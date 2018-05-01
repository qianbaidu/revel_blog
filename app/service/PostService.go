package service

import (
	"github.com/revel/revel"
	"github.com/qianbaidu/revel_blog/app/model"
	"github.com/qianbaidu/revel_blog/app/db"
	"github.com/qianbaidu/revel_blog/app/utils"
	"github.com/revel/revel/cache"
	"html/template"
	"errors"
	"fmt"
	"time"
)

type PostService struct{}

func (this *PostService) GetPostById(id int, real bool) (model.Posts, error) {
	post := model.Posts{}

	if id <= 0 {
		return post, errors.New("param error")
	}

	cKey := utils.CacheKey("PostService", "modelById", id)
	if real {
		go cache.Delete(cKey)
	}

	if err := cache.Get(cKey, &post); err != nil {
		_, err := db.MasterDB.Where("id = ?", id).Get(&post)
		if err != nil {
			return post, err
		}

		go cache.Set(cKey, post, 30 * time.Minute)
	}


	//related Categories
	category, catErr := categoryService.GetCategoryById(post.CategoryId, real)
	if catErr != nil {
		revel.INFO.Printf("GetCategoryById failed : %s", catErr)
		return post, catErr
	}
	post.Categories = category

	return post, nil
}

func (this *PostService) GetPostBySlug(slug string, real bool) (model.Posts, error) {
	post := model.Posts{}
	if slug == "" {
		return post, errors.New("Slug is empty.")
	}
	_, err := db.MasterDB.Where("flag = ?", slug).Cols("id").Get(&post)
	if err != nil {
		return post, err
	}

	post, pErr := this.GetPostById(post.Id, real)
	if pErr != nil {
		return post, err
	}

	return post, nil
}

func (this *PostService) GetSlugList(limit int, page int) ([]model.Posts, error) {
	limit = utils.IntDefault(limit > 0, limit, 20)
	page = utils.IntDefault(page > 0, page, 1)
	start := (page - 1) * limit
	postArr := make([]model.Posts, 0)
	err := db.MasterDB.Desc("id").Cols("flag", "created_at").Limit(limit, start).Find(&postArr)
	if err != nil {
		return nil, err
	}

	return postArr, nil
}

func (this *PostService) GetPostIdArr(categoryId int, keywords string, limit int, page int) ([]int, error) {
	limit = utils.IntDefault(limit > 0, limit, 20)
	page = utils.IntDefault(page > 0, page, 1)
	session := db.MasterDB.NewSession()
	start := (page - 1) * limit
	postList := make([]model.Posts, 0)
	if categoryId > 0 {
		session.And("category_id = ?", categoryId)
	}
	if len(keywords) > 0 {
		keywordsStr := "%" + keywords + "%"
		session.And("title like ?", keywordsStr)
	}
	err := session.Desc("id").Cols("id").Limit(limit, start).Find(&postList)
	if err != nil {
		return nil, err
	}

	idArr := make([]int, len(postList))
	for k, val := range postList {
		idArr[k] = val.Id
	}

	return idArr, nil
}

func (this *PostService) GetPostByIdArr(idArr []int, real bool) ([]model.Posts, error) {
	idLen := len(idArr)
	if idLen <= 0 {
		return nil, errors.New("Param error.")
	}

	postArr := make([]model.Posts, idLen)

	for k, postId := range idArr {
		post, err := this.GetPostById(postId, real)
		if err == nil {
			postArr[k] = post
		}
	}

	return postArr, nil
}

func (this *PostService) CountPost(categoryId int, keywords string) (int, error) {
	post := new(model.Posts)
	dbSession := db.MasterDB.NewSession()

	if categoryId > 0 {
		dbSession.And("category_id = ?", categoryId)
	}

	if keywords != "" {
		likeTitle := "%" + keywords + "%"
		dbSession.And("title like ?", likeTitle)
	}

	total, err := dbSession.Count(post)
	if err != nil {
		//revel.INFO.Printf("Count post failed: %s", err)
		return 0, err
	}
	return int(total), nil
}

func (this *PostService) ShowPage(prefix string, page int, totalPage int) template.HTML {
	next := "<a rel='next' class='pager-btn pager-next' href='/%s/%d'>更早 &rarr;</a>"
	previous := "<a rel='prev' class='pager-btn pager-previous' href='/%s/%d'>&larr; 最近</a>"
	html := ""

	if totalPage == 1 {
		return template.HTML("")
	}

	if page < 1 {
		html = fmt.Sprintf(next, prefix, 1)
	} else if page == 1 {
		html = fmt.Sprintf(next, prefix, page + 1)
	} else if page >= totalPage {
		newTotalPage := totalPage - 1
		previousNum := utils.IntDefault(newTotalPage > 0, newTotalPage, 1)
		html = fmt.Sprintf(previous, prefix, previousNum)
	} else {
		newTotalPage := totalPage - 1
		previousNum := utils.IntDefault(newTotalPage > 0, newTotalPage, 1)
		html = fmt.Sprintf(previous + next, prefix, previousNum, prefix, page + 1)
	}

	return template.HTML(html)
}

func (this *PostService) GetListPaging(categoryId int, keywords string, limit int, page int, real bool) *model.PagingContent {
	dataList, _ := this.SearchList(categoryId, keywords, limit, page, real)
	total, _ := this.CountPost(0, "")
	totalPage := utils.GetTotalPage(total, limit)
	pagingContent := &model.PagingContent{Data: dataList,
		Total: total,
		TotalPage: totalPage,
		CurrentPage: page}
	fmt.Println(pagingContent)
	return pagingContent
}

func (this *PostService) GetTopArticleList( limit int, page int, real bool) ([]model.Posts, error) {
	limit = utils.IntDefault(limit > 0, limit, 20)
	page = utils.IntDefault(page > 0, page, 1)
	session := db.MasterDB.NewSession()
	start := (page - 1) * limit
	postList := make([]model.Posts, 0)

	session.Where("deleted_at = 0")
	err := session.Desc("views").Cols("`id`, `flag`, `title`, `thumb`, `category_id`, `user_id`, `content`, `markdown`, `views`, `comments`, `created_at`, `updated_at`, `deleted_at`, `client_ip`").Limit(limit, start).Find(&postList)

	if err != nil {
		return nil, err
	}
	cidArr := make([]int, len(postList))

	for k, v := range postList {
		cidArr[k] = v.CategoryId
	}

	cateList, _ := categoryService.GetCategoryByIdArr(cidArr, real)
	for k, _ := range (postList) {
		postList[k].Categories = cateList[k]
	}
	return postList, nil
}



func (this *PostService) GetArticleList(categoryId int, limit int, page int, real bool) ([]model.Posts, error) {
	limit = utils.IntDefault(limit > 0, limit, 20)
	page = utils.IntDefault(page > 0, page, 1)
	session := db.MasterDB.NewSession()
	start := (page - 1) * limit
	postList := make([]model.Posts, 0)

	session.Where("deleted_at = 0")
	if categoryId > 0 {
		session.And("category_id = ?", categoryId)
	}

	err := session.Desc("id").Cols("`id`, `flag`, `title`, `thumb`, `category_id`, `user_id`, `content`, `markdown`, `views`, `comments`, `created_at`, `updated_at`, `deleted_at`, `client_ip`").Limit(limit, start).Find(&postList)

	if err != nil {
		return nil, err
	}
	cidArr := make([]int, len(postList))

	for k, v := range postList {
		cidArr[k] = v.CategoryId
	}

	cateList, _ := categoryService.GetCategoryByIdArr(cidArr, real)
	for k, _ := range (postList) {
		postList[k].Categories = cateList[k]
	}
	return postList, nil
}



func (this *PostService) SearchList(categoryId int, keywords string, limit int, page int, real bool) ([]model.Posts, error) {
	limit = utils.IntDefault(limit > 0, limit, 20)
	page = utils.IntDefault(page > 0, page, 1)
	session := db.MasterDB.NewSession()
	start := (page - 1) * limit
	postList := make([]model.Posts, 0)

	session.Where("deleted_at = 0")
	if categoryId > 0 {
		session.And("category_id = ?", categoryId)
	}
	if len(keywords) > 0 {
		keywordsStr := "%" + keywords + "%"
		session.And("title like ?", keywordsStr)
	}
	err := session.Desc("id").Cols("id").Limit(limit, start).Find(&postList)
	if err != nil {
		return nil, err
	}

	idArr := make([]int, len(postList))
	for k, v := range postList {
		idArr[k] = v.Id
	}

	postList, pErr := this.GetPostByIdArr(idArr, real)
	if pErr != nil {
		return nil, pErr
	}

	return postList, nil
}

func (this *PostService) GetPostTitleById(id int, real bool) (string, error) {
	post := model.Posts{}

	if id <= 0 {
		return "", errors.New("param error")
	}

	cKey := utils.CacheKey("PostService", "modelById", id)
	if real {
		go cache.Delete(cKey)
	}

	if err := cache.Get(cKey, &post); err != nil {
		_, err := db.MasterDB.Where("id = ?", id).Get(&post)
		if err != nil {
			return "", err
		}

		go cache.Set(cKey, post, 30 * time.Minute)
	}

	return post.Title, nil
}

//================================ use backend ===============================

func (this *PostService) Save(post model.Posts) (int, error) {
	if _, err := db.MasterDB.InsertOne(post); err != nil {
		revel.INFO.Printf("Save post failed : %s", err)
		return 0, err
	}
	return post.Id, nil
}

func (this *PostService) Update(id int, post model.Posts) (bool, error) {
	_, err := db.MasterDB.Id(id).Update(post)
	if err != nil {
		revel.INFO.Printf("Update post failed: %s", err)
		return false, err
	}

	this.GetPostById(id, true)
	return true, nil
}

func (this *PostService) Trash(ids []int) (bool, error) {
	post := model.Posts{DeletedAt: time.Now().Unix()}
	_, err := db.MasterDB.In("id", ids).Update(&post)
	if err != nil {
		revel.INFO.Printf("Destroy post failed: %s", err)
		return false, err
	}
	return true, nil
}

func (this *PostService) SumViews() (int, error) {
	post := new(model.Posts)
	total, err := db.MasterDB.Sum(post, "views")
	if err != nil {
		revel.INFO.Printf("Count post failed: %s", err)
		return 0, err
	}
	return int(total), nil
}

func (this *PostService) Table(tableName string) string {
	return db.MasterDB.TableMapper.Obj2Table(tableName)
}

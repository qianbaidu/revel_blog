package service

import (
	"github.com/qianbaidu/revel_blog/app/model"
	"github.com/qianbaidu/revel_blog/app/db"
	"github.com/qianbaidu/revel_blog/app/utils"
	"github.com/revel/revel/cache"
	"errors"
	"time"
)

type CategoryService struct {
	page  int
	limit int
}

func (this *CategoryService) GetCategoryById(id int, real bool) (model.Categorys, error) {
	category := model.Categorys{}

	if id <= 0 {
		return category, errors.New("Param error.")
	}

	cKey := utils.CacheKey("CategoryService", "InfoById", id)
	if real {
		go cache.Delete(cKey)
	}

	if err := cache.Get(cKey, &category); err != nil {
		_, err := db.MasterDB.Where("id = ?", id).Get(&category)
		if err != nil {
			return category, err
		}

		go cache.Set(cKey, category, 30*time.Minute)
	}

	return category, nil
}

func (this *CategoryService) GetCategory(id int) (model.Categorys, error) {
	category := model.Categorys{}

	_, err := db.MasterDB.Where("id = ?", id).Get(&category)
	if err != nil {
		return category, err
	}

	key := utils.CacheKey("CategoryService", "InfoById", id)
	go cache.Set(key, category, 30*time.Minute)

	return category, nil
}

func (this *CategoryService) GetCategoryBySlug(slug string, real bool) (model.Categorys, error) {
	category := model.Categorys{}
	if slug == "" {
		return category, errors.New("Slug is empty.")
	}
	_, err := db.MasterDB.Where("category_flag = ?", slug).Cols("id").Get(&category)
	if err != nil {
		return category, err
	}

	return category, nil
}

func (this *CategoryService) GetCategoryByIdArr(idArr []int, real bool) ([]model.Categorys, error) {
	idLen := len(idArr)
	if idLen <= 0 {
		return nil, errors.New("参数不正确")
	}

	categoryArr := make([]model.Categorys, idLen)

	for k, catId := range idArr {
		category, err := this.GetCategoryById(catId, real)
		if err == nil {
			categoryArr[k] = category
		}
	}

	return categoryArr, nil
}

func (this *CategoryService) GetList(limit int, page int, real bool) ([]model.Categorys, error) {
	this.limit = utils.IntDefault(limit > 0, limit, 20)
	this.page = utils.IntDefault(page > 0, page, 20)

	start := (this.page - 1) * limit
	categorysList := make([]model.Categorys, 0)

	if err := db.MasterDB.Limit(this.limit, start).Cols("id").Find(&categorysList); err != nil {
		return nil, err
	}

	idArr := make([]int, len(categorysList))
	for k, v := range categorysList {
		idArr[k] = v.Id
	}

	categorysList, pErr := this.GetCategoryByIdArr(idArr, real)
	if pErr != nil {
		return nil, pErr
	}

	return categorysList, nil
}

func (this *CategoryService) GetListPaging(limit int, page int, real bool) (*model.PagingContent, error) {
	dataList, err := this.GetList(limit, page, real)
	if err != nil {
		return nil, err
	}

	total, cErr := this.CountCategory()
	if cErr != nil {
		return nil, err
	}

	totalPage := utils.GetTotalPage(total, this.limit)
	pagingContent := &model.PagingContent{Data: dataList,
		Total: total,
		TotalPage: totalPage,
		CurrentPage: this.page}
	return pagingContent, nil
}

func (this *CategoryService) CountCategory() (int, error) {
	category := new(model.Categorys)
	total, err := db.MasterDB.Count(category)
	if err != nil {
		return 0, err
	}
	return int(total), nil
}

func (this *CategoryService) Save(category model.Categorys) (int, error) {
	if _, err := db.MasterDB.InsertOne(category); err != nil {
		//revel.INFO.Printf("Save categorys failed : %s", err)
		return 0, err
	}

	this.GetCategoryById(category.Id, true)
	return category.Id, nil
}

func (this *CategoryService) Update(id int, category model.Categorys) (bool, error) {
	if _, err := db.MasterDB.Id(id).Update(category); err != nil {
		return false, err
	}

	this.GetCategoryById(category.Id, true)
	return true, nil
}

func (this *CategoryService) Destroy(ids []int, category model.Categorys) (bool, error) {
	if _, err := db.MasterDB.In("id", ids).Delete(category); err != nil {
		return false, err
	}

	return true, nil
}

func (this *CategoryService) Table(tableName string) string {
	return db.MasterDB.TableMapper.Obj2Table(tableName)
}

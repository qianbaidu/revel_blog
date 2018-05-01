/**
*
* @author Alex
* @create 2018-05-01 08:43
* @package controllers
**/


package controllers

import (
	"github.com/revel/revel"
	"github.com/qianbaidu/revel_blog/app/utils"
	"github.com/qianbaidu/revel_blog/app/model"

	"fmt"
)

type FrontEnd struct {
	BaseFrontController
}

func (c FrontEnd) Index(page int) revel.Result {
	page = utils.IntDefault(page > 0, page, FirstPage)
	postArr, err := postService.GetArticleList(0, PageSize, page, false)
	if err != nil {
		c.Flash.Error(err.Error())
	}

	total, cErr := postService.CountPost(0, "")
	if cErr != nil {
		c.Flash.Error(cErr.Error())
	}

	c.ViewAssign(postArr, total, PageSize, page)

	return c.Render()
}

func (c FrontEnd) List(cid, page int) revel.Result {

	page = utils.IntDefault(page > 0, page, FirstPage)
	postArr, err := postService.GetArticleList(cid, PageSize, page, false)
	if err != nil {
		c.Flash.Error(err.Error())
	}

	total, cErr := postService.CountPost(0, "")
	if cErr != nil {
		c.Flash.Error(cErr.Error())
	}
	category, _ := categoryService.GetCategory(cid)

	c.ViewArgs["category"] = category
	c.ViewAssign(postArr, total, PageSize, page)
	return c.Render()
}

func (c FrontEnd) Article(id int) revel.Result {

	if string(id) == "" || id <1 {
		return c.NotFound("很抱歉，没有找到这个页面.")
	}
	article ,_ := postService.GetPostById(id,false)
	fmt.Println("--")
	article.Views ++
	postService.Update(id,article)

	c.ViewArgs["article"] = article
	c.ViewAssign(make([]model.Posts, 0), 1, 1, 1)
	return c.Render(article)
}
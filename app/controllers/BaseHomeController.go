/**
*
* @author Alex
* @create 2018-05-01 08:23
* @package controllers
**/


package controllers

import (
	"github.com/revel/revel"
	"github.com/qianbaidu/revel_blog/app/utils"
	"github.com/qianbaidu/revel_blog/app/model"
	"fmt"
	"time"
	//"math"
	"math"
)

const (
	PageSize  = 10
	FirstPage = 1
)
type BaseFrontController struct {
	*revel.Controller
}

func (c BaseFrontController) GetGlobalInfo() {
	allOption, err := optionService.GetAllOption(false)
	if err == nil {
		for _, v := range allOption {
			c.ViewArgs[v.OptionName] = v.OptionValue
		}
	} else {
		revel.INFO.Printf("GetAllOption failed: %s", err)
	}

	//nav
	navi, navErr := navigationService.GetNavigation(false)
	if navErr != nil {
		revel.INFO.Printf("GetNavigation failed: %s", err)
	}
	c.ViewArgs["navigations"] = navi
}


func (c BaseFrontController) ViewAssign(posts []model.Posts, total int, limit int, page int) {
	c.GetGlobalInfo()

	posts = utils.SubstrContent(posts)
	totalPage := utils.GetTotalPage(total, limit)

	prefix := "page"
	if tagName := c.Params.Route.Get("name"); tagName != "" {
		prefix = fmt.Sprintf("tag/%s", tagName)
	}

	//sidebar
	sidebar,_ := postService.GetTopArticleList( 10, 1, false)

	//2015年08月29日
	beginTime, _ := time.Parse("01/02/2006", "08/29/2015")
	runTime  := time.Now().Unix() - beginTime.Unix()
	runDays :=  math.Ceil(float64(runTime) / (24*60*60))

	c.ViewArgs["sidebar"] = sidebar

	//c.ViewArgs["baseUrl"] = "http://revel_blog.qipajun.com"
	c.ViewArgs["baseUrl"] = "http://localhost:9000"

	c.ViewArgs["runDays"] = runDays
	c.ViewArgs["posts"] = posts
	c.ViewArgs["page"] = page
	c.ViewArgs["total"] = total
	c.ViewArgs["totalPage"] = totalPage
	c.ViewArgs["showPage"] = postService.ShowPage(prefix, page, totalPage)
}
/**
* 
* @author Alex
* @create 2018-05-01 09:23
* @package controllers
**/


package controllers

import (
	"github.com/qianbaidu/revel_blog/app/service"
)

var optionService, OptionS *service.OptionService
var navigationService, NavigationS *service.NavigationService
var categoryService, CategoryS *service.CategoryService
var postService, PostS *service.PostService

func InitService() {
	OptionS = &service.OptionService{}
	NavigationS = &service.NavigationService{}
	CategoryS = &service.CategoryService{}
	PostS = &service.PostService{}
}

func main() {
	InitService()
}
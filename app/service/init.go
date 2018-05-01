package service

var optionService, OptionS *OptionService

var categoryService, CategoryS *CategoryService
var postService, PostS *PostService


func InitService() {

	OptionS = &OptionService{}
	CategoryS = &CategoryService{}
	PostS = &PostService{}


}
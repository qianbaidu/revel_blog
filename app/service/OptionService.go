package service

import (
	"github.com/revel/revel"
	"github.com/qianbaidu/revel_blog/app/model"
	"github.com/qianbaidu/revel_blog/app/utils"
	"github.com/qianbaidu/revel_blog/app/db"
	"time"
	"github.com/revel/revel/cache"
)

type OptionService struct{}



func (this *OptionService) GetAllOption(real bool) ([]model.Options, error) {
	options := make([]model.Options, 0)
	cKey := utils.CacheKey("OptionService", "AllOption")

	if real {
		go cache.Delete(cKey)
	}

	if err := cache.Get(cKey, &options); err != nil {
		dbErr := db.MasterDB.Where("option_status !='hidden'").Find(&options)
		if dbErr != nil {
			return nil, dbErr
		}
		go cache.Set(cKey, options, 30*time.Minute)
	}

	return options, nil
}


func (this *OptionService) GetValueByName(optionName string, real bool) (string, error) {
	option := &model.Options{}
	_, err := db.MasterDB.Where("option_name = ?", optionName).Cols("option_value").Get(option)
	if err != nil {
		revel.INFO.Printf("Get value by name failed : %s", err)
		return "", err
	}

	return option.OptionValue, nil
}

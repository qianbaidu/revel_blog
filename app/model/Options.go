package model

type Options struct {
	Id           int    `json:"id" xorm:"pk autoincr"`
	OptionTitle  string `json:"option_title"`
	OptionName   string `json:"option_name"`
	OptionValue  string `json:"option_value"`
	OptionGroup  string `json:"option_group"`
	OptionRemark string `json:"option_remark"`
	OptionStatus string `json:"option_status"`
	DataType     string `json:"data_type"`
	CreatedAt    int64  `json:"created_at" xorm:"created"`
	UpdatedAt    int64  `json:"updated_at" xorm:"updated"`
}

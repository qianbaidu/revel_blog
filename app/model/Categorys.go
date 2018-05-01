package model

type Categorys struct {
	Id                  int    `json:"id" xorm:"pk autoincr"`
	CategoryName        string `json:"category_name"`
	CategoryParent      int    `json:"category_parent"`
	CategoryFlag        string `json:"category_flag"`
	CategoryDescription string `json:"category_description"`
	ClientIp            uint32 `json:"client_ip"`
	CreatedAt           int64  `json:"created_at" xorm:"created"`
	UpdatedAt           int64  `json:"updated_at" xorm:"updated"`
}

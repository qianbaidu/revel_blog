package utils

import (
	"reflect"
	"strconv"
	"fmt"
	"strings"
	"github.com/qianbaidu/revel_blog/app/model"
	"math"
	"regexp"
	//"time"
	//"time"
)

func CacheKey(keys ...interface{}) string {
	strArr := make([]string, len(keys))
	for k, v := range keys {
		vtype := reflect.TypeOf(v).String()
		switch vtype {
		case "string":
			strArr[k] = v.(string)
		case "int":
			strArr[k] = strconv.Itoa(v.(int))
		default:
		}
	}
	newStr := strings.Join(strArr, ":")
	fmt.Println(fmt.Sprintf("%s", newStr))
	return fmt.Sprintf("%s", newStr)
}

func TrimHtml(src string) string {
	//将HTML标签全转换成小写
	re, _ := regexp.Compile("\\<[\\S\\s]+?\\>")
	src = re.ReplaceAllStringFunc(src, strings.ToLower)
	//去除STYLE
	re, _ = regexp.Compile("\\<style[\\S\\s]+?\\</style\\>")
	src = re.ReplaceAllString(src, "")
	//去除SCRIPT
	re, _ = regexp.Compile("\\<script[\\S\\s]+?\\</script\\>")
	src = re.ReplaceAllString(src, "")
	//去除所有尖括号内的HTML代码，并换成换行符
	re, _ = regexp.Compile("\\<[\\S\\s]+?\\>")
	src = re.ReplaceAllString(src, "\n")
	//去除连续的换行符
	re, _ = regexp.Compile("\\s{2,}")
	src = re.ReplaceAllString(src, "\n")
	return strings.TrimSpace(src)
}


func Substr(src string, length int) string {
	if length <= 0 {
		length = 125
	}
	newSrc := TrimHtml(src)
	newStr := []rune(newSrc)
	strLen := len(newStr)
	var desc string
	if strLen > length {
		desc = string(newStr[:length])
	} else {
		desc = newSrc
	}
	return desc
}


func SubstrContent(posts []model.Posts) []model.Posts {
	for key, val := range posts {
		posts[key].Content = Substr(val.Content, 130)
	}
	return posts
}

func GetTotalPage(count int, limit int) int {
	return int(math.Ceil(float64(count) / float64(limit)))
}

func IntDefault(check bool, inputVal int, defaultVal int) int {
	newVal := defaultVal
	if check {
		newVal = inputVal
	}
	return newVal
}

//func Date(format string, timestamp int64) (string) {
//	if format == "" {
//		format = "2006-01-02 15:04:05"
//	}
//	tm := time.Unix(timestamp, 0)
//	return tm.Format(format)
//}


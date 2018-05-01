# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.6.36)
# Database: go_blog
# Generation Time: 2018-05-01 11:58:53 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table attachments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `attachments`;

CREATE TABLE `attachments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `hash1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `md5` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` int(10) DEFAULT NULL,
  `updated_at` int(10) DEFAULT NULL,
  `client_ip` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table categorys
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorys`;

CREATE TABLE `categorys` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `category_parent` int(11) NOT NULL DEFAULT '0',
  `category_flag` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `category_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` int(10) DEFAULT NULL,
  `updated_at` int(10) DEFAULT NULL,
  `client_ip` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorys_category_flag_unique` (`category_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `categorys` WRITE;
/*!40000 ALTER TABLE `categorys` DISABLE KEYS */;

INSERT INTO `categorys` (`id`, `category_name`, `category_parent`, `category_flag`, `category_description`, `created_at`, `updated_at`, `client_ip`)
VALUES
	(1,'golang',0,'golang','golang note.',1523074802,1523074802,2130706433),
	(2,'linux',0,'linux','linux',1525162575,1525162575,2130706433),
	(19,'机器学习',0,'machine learning','machine learning',NULL,NULL,NULL),
	(21,'大数据',0,'big data','big data',NULL,NULL,NULL),
	(22,'php',0,'php','php',NULL,NULL,NULL),
	(23,'python',0,'python','python',NULL,NULL,NULL),
	(24,'消息日志',0,'ELk','ELK',NULL,NULL,NULL);

/*!40000 ALTER TABLE `categorys` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table comments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `comments`;

CREATE TABLE `comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) DEFAULT '0',
  `posts_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `content` text COLLATE utf8_unicode_ci,
  `markdown` text COLLATE utf8_unicode_ci,
  `created_at` int(10) DEFAULT NULL,
  `updated_at` int(10) DEFAULT NULL,
  `client_ip` int(10) DEFAULT NULL,
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '1 正常 2待审核 3垃圾评论',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table links
# ------------------------------------------------------------

DROP TABLE IF EXISTS `links`;

CREATE TABLE `links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `group` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `created_at` int(10) DEFAULT NULL,
  `updated_at` int(10) DEFAULT NULL,
  `client_ip` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `links` WRITE;
/*!40000 ALTER TABLE `links` DISABLE KEYS */;

INSERT INTO `links` (`id`, `name`, `logo`, `group`, `url`, `created_at`, `updated_at`, `client_ip`)
VALUES
	(1,'MrCong','https://o75u5ooep.qnssl.com/avatar/persimmon.jpg','','https://cong5.net/',1487105565,1487105897,0);

/*!40000 ALTER TABLE `links` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table navications
# ------------------------------------------------------------

DROP TABLE IF EXISTS `navications`;

CREATE TABLE `navications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sort` int(11) DEFAULT '0',
  `created_at` int(10) DEFAULT NULL,
  `updated_at` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table options
# ------------------------------------------------------------

DROP TABLE IF EXISTS `options`;

CREATE TABLE `options` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `option_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `option_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `option_value` text COLLATE utf8_unicode_ci,
  `option_group` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `option_remark` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `option_status` tinyint(1) DEFAULT '2' COMMENT '0 hidden 1 base 2 extends ',
  `data_type` tinyint(1) DEFAULT '1' COMMENT '1 text  2 textarea',
  `created_at` int(10) DEFAULT NULL,
  `updated_at` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `options` WRITE;
/*!40000 ALTER TABLE `options` DISABLE KEYS */;

INSERT INTO `options` (`id`, `option_title`, `option_name`, `option_value`, `option_group`, `option_remark`, `option_status`, `data_type`, `created_at`, `updated_at`)
VALUES
	(3,'网站名称','site_name','Mr柿子 - I\'am Mr柿子.','','',1,1,1487167761,1487546220),
	(4,'网站关键词','keywords','Mr柿子,MrCong,PHP 开发笔记,Swift 笔记,iOS 开发笔记',NULL,NULL,1,2,1487167779,1487194870),
	(5,'网站描述','description','Hi~ ，我是刘聪(@Mr柿子),一名PHPer，爱好折腾各种新技术，热爱PHP、Swift.','','',1,2,1487167800,1487194870),
	(6,'导航配置','navigations','[\n    {\n        \"name\":\"Golang\",\n        \"url\":\"/list/1\"\n    },\n    {\n        \"name\":\"Linux\",\n        \"url\":\"/list/2\"\n    },\n    {\n        \"name\":\"机器学习\",\n        \"url\":\"/list/19\"\n    },\n    {\n        \"name\":\"大数据\",\n        \"url\":\"/list/21\"\n    },\n    {\n        \"name\":\"php\",\n        \"url\":\"/list/22\"\n    },\n     {\n        \"name\":\"python\",\n        \"url\":\"/list/23\"\n    }\n]','','',0,2,1487198194,1522596442),
	(7,'新浪微博','weibo','http://weibo.com/701265306','','',2,1,1487545984,1487546153),
	(8,'GitHub 地址','github','https://github.com/cong5',NULL,NULL,2,1,1487546011,1487546153),
	(9,'Google Plus','google_plus','https://plus.google.com/+CongLiuForMe/','','',2,1,1487546054,1487546153),
	(10,'统计代码','analysis','<script src=\"https://s13.cnzz.com/z_stat.php?id=1266985713&web_id=1266985713\" language=\"JavaScript\"></script>','','',2,2,1487546593,1509398943),
	(11,'备案号','icp','桂ICP备14007691号','','',2,1,1487547000,1487547020),
	(13,'XmlRpc登陆失败次数','xmlrpc_login_failed','4',NULL,NULL,2,1,1489086282,1492661326);

/*!40000 ALTER TABLE `options` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table posts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `posts`;

CREATE TABLE `posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `flag` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `thumb` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `category_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `markdown` text COLLATE utf8_unicode_ci,
  `views` int(11) DEFAULT '0',
  `comments` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` int(11) NOT NULL DEFAULT '0',
  `deleted_at` tinyint(2) NOT NULL DEFAULT '0',
  `client_ip` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;

INSERT INTO `posts` (`id`, `flag`, `title`, `thumb`, `category_id`, `user_id`, `content`, `markdown`, `views`, `comments`, `created_at`, `updated_at`, `deleted_at`, `client_ip`)
VALUES
	(1,'test-hello-world','shadowsocks搭建科学上网','',2,0,'<h2>shadowsocks搭建科学上网</h2>\n\n<ul>\n<li>shadowsocks搭建科学上网 给予python，所以显得安装python环境。</li>\n<li>安装shadowsocks</li>\n</ul>\n\n<pre><code>pip install shadowsocks\n</code></pre>\n\n<ul>\n<li>安装完会多出两个程序<code>ssserver</code>、<code>sslocal</code></li>\n<li>配置<code>vi /etc/shadowsocks.conf</code></li>\n</ul>\n\n<pre><code>{\n    \"server\":\"0.0.0.0\",\n    \"server_port\":8381,\n    \"local_address\": \"127.0.0.1\",\n    \"local_port\":1080,\n    \"password\":\"pass\",\n    \"timeout\":300,\n    \"method\":\"aes-256-cfb\",\n    \"fast_open\": false\n}\n</code></pre>\n\n<ul>\n<li>启动</li>\n</ul>\n\n<pre><code>ssserver -c /etc/shadowsocks.conf --workers 10 --pid-file /tmp/ss.pid --log-file /tmp/ss.log --user nobody -v -d start\n### 制定log文件方便差错\n</code></pre>\n\n<ul>\n<li>测试是否ok</li>\n</ul>\n\n<pre><code>tail -f /tmp/ss.log ### 查看日志\ncurl -f 127.0.0.1:8381 ## 看是否有日志输出，如果ok至少说明本地服务器启动没问题。\n### 这里如果外网不同，看下服务商后台安全策略是否端口被过滤了\n### 还有就是开启防火墙端口\n</code></pre>\n\n<ul>\n<li>防火墙端口开启</li>\n</ul>\n\n<pre><code>firewall-cmd --state ### 查看防火墙状态\nsystemctl start firewalld ### 启动\nsystemctl stop firewalld ### 停止\n firewall-cmd --zone=public --list-ports ## 查看开启端口\nfirewall-cmd --zone=public --add-port=8381/tcp --permanent ### 添加端口\nfirewall-cmd --zone=public --remove-port=8381/tcp --permanent  ### 移除端口\nfirewall-cmd --reload ### 重新加载配置\n</code></pre>\n\n<ul>\n<li>设置开机启动 <code>vim /etc/rc.d/rc.local</code></li>\n</ul>\n\n<pre><code>ssserver -c /etc/shadowsocks.conf --workers 10 --pid-file /tmp/ss.pid --log-file /tmp/ss.log --user nobody -v -d start\n</code></pre>\n\n<ul>\n<li>添加执行权限 <code>chmod +x /etc/rc.d/rc.local</code></li>\n</ul>','asdfasdf',1,0,'2017-04-01 22:54:51',1525169583,0,2130706433),
	(5,'test','wiki中文词向量建模','',19,0,'<h3>维基百科词库中文建模练习</h3>\n\n<ul>\n<li>wiki词库下载\n\n<ul>\n<li>资源下载页面地址: https://dumps.wikimedia.org/zhwiki/latest/</li>\n<li>文件: https://dumps.wikimedia.org/zhwiki/latest/zhwiki-latest-pages-articles.xml.bz2</li>\n<li>下载后解压得到xml文件</li>\n</ul></li>\n<li>xml 文本抽取\n\n<ul>\n<li>使用Wikipedia Extractor抽取正文\n    <code>git clone https://github.com/attardi/wikiextractor.git wikiextractor\n    cd wikiextractor\n    python setup.py install\n    ./WikiExtractor.py -b 500M -o extracted zhwiki-latest-pages-articles.xml.bz2 \n    ### -o extracted  -o 制定输出目录 运行完查看目录抽取文件\n    ### -b 文件大小 默认是1M</code></li>\n</ul></li>\n<li><p>繁简转换</p></li>\n</ul>\n\n<pre><code>brew install opencc\nopencc -i wiki_00 -o zh_wiki_00 -c zht2zhs.ini\n### zht2zhs.ini 报错使用下面配置\nopencc -i wiki_00 -o wiki_00_zh.txt -c t2s.json\n</code></pre>\n\n<ul>\n<li>特殊字符处理</li>\n<li>该步骤包含分词，剔除标点符号和去文章结构标识。（建议word2vec训练数据不要去除标点符号，比如在情感分析应用中标点符号很有用）最终将得到分词好的纯文本文件，每行对应一篇文章，词语间以空格作为分隔符。script_seg.py如下：</li>\n</ul>\n\n<pre><code>#!/usr/bin/python\n# -*- coding: utf-8 -*-\nimport sys, codecs\nimport jieba.posseg as pseg\nreload(sys)\nsys.setdefaultencoding(\'utf-8\')\nif __name__ == \'__main__\':\n    if len(sys.argv) &lt; 3:\n        print \"Usage: python script.py infile outfile\"\n        sys.exit()\n    i = 0\n    infile, outfile = sys.argv[1:3]\n    output = codecs.open(outfile, \'w\', \'utf-8\')\n    with codecs.open(infile, \'r\', \'utf-8\') as myfile:\n        for line in myfile:\n            line = line.strip()\n            if len(line) &lt; 1:\n                continue\n            if line.startswith(\'&lt;doc\'):\n                i = i + 1\n                if(i % 1000 == 0):\n                    print(\'Finished \' + str(i) + \' articles\')\n                continue\n            if line.startswith(\'&lt;/doc\'):\n                output.write(\'\\n\')\n                continue\n            words = pseg.cut(line)\n            for word, flag in words:\n                if flag.startswith(\'x\'):\n                    continue\n                output.write(word + \' \')\n    output.close()\n    print(\'Finished \' + str(i) + \' articles\')\n</code></pre>\n\n<ul>\n<li>执行命令</li>\n</ul>\n\n<pre><code>time python script_seg.py wiki_00_output.txt seg_wiki_00_output.txt\n</code></pre>\n\n<ul>\n<li>去除空白行</li>\n</ul>\n\n<pre><code>sed \'/^$/d\' seg_wiki_00_output.txt  &gt; trim_seg_wiki_00_output.txt\n</code></pre>\n\n<ul>\n<li>分词预处理</li>\n<li><code>Testjieba.py</code></li>\n</ul>\n\n<pre><code># -*- coding: utf-8 -*-\nimport jieba\nimport jieba.analyse\nimport jieba.posseg as pseg\nimport codecs,sys\ndef cut_words(sentence):\n    #print sentence\n    return \" \".join(jieba.cut(sentence)).encode(\'utf-8\')\nf=codecs.open(\'wiki.zh_output.text\',\'r\',encoding=\"utf8\") ## 输入\ntarget = codecs.open(\"wiki.zh_output_jieba.text\", \'w\',encoding=\"utf8\")  ## 输出\nprint (\'open files\')\nline_num=1\nline = f.readline()\nwhile line:\n    print(\'-\')\n    line_seg = \" \".join(jieba.cut(line))\n    target.writelines(line_seg)\n    line_num = line_num + 1\n    line = f.readline()\nf.close()\ntarget.close()\nexit()\nwhile line:\n    curr = []\n    for oneline in line:\n        #print(oneline)\n        curr.append(oneline)\n    after_cut = map(cut_words, curr)\n    target.writelines(after_cut)\n    print (\'saved\',line_num,\'articles\')\n    exit()\n    line = f.readline1()\nf.close()\ntarget.close()\n\n# python Testjieba.py\n</code></pre>\n\n<ul>\n<li>建模</li>\n<li><code>word2vec_model.py</code></li>\n</ul>\n\n<pre><code># -*- coding: utf-8 -*-\nimport logging\nimport os.path\nimport sys\nimport multiprocessing\nfrom gensim.corpora import WikiCorpus\nfrom gensim.models import Word2Vec\nfrom gensim.models.word2vec import LineSentence\nif __name__ == \'__main__\':\n\n    program = os.path.basename(sys.argv[0])\n    logger = logging.getLogger(program)\n    logging.basicConfig(format=\'%(asctime)s: %(levelname)s: %(message)s\')\n    logging.root.setLevel(level=logging.INFO)\n    logger.info(\"running %s\" % \' \'.join(sys.argv))\n    # check and process input arguments\n    if len(sys.argv) &lt; 4:\n        print (globals()[\'__doc__\'] % locals())\n        sys.exit(1)\n    inp, outp1, outp2 = sys.argv[1:4]\n    model = Word2Vec(LineSentence(inp), size=400, window=5, min_count=5, workers=multiprocessing.cpu_count())\n    model.save(outp1)\n    model.wv.save_word2vec_format(outp2, binary=False)\n#python word2vec_model.py zh.jian.wiki.seg.txt wiki.zh.text.model wiki.zh.text.vector\n#opencc -i wiki_texts.txt -o test.txt -c t2s.json\n</code></pre>\n\n<pre><code>python word2vec_model.py wiki.zh_output_jieba.text wiki.zh_output_jieba_model.model wiki.zh_output_jieba_model.vector\n</code></pre>\n\n<ul>\n<li>测试向量模型</li>\n<li><code>test_model.py</code></li>\n</ul>\n\n<pre><code># -*- coding: utf-8 -*-\nfrom gensim.models import Word2Vec\n\nen_wiki_word2vec_model = Word2Vec.load(\'wiki.zh_output_jieba_model.model\')\nres = en_wiki_word2vec_model.most_similar(u\"数学\")\nprint (res)\nfor i in res:\n    print(i[0])\n\n</code></pre>\n\n<ul>\n<li>实例结果</li>\n</ul>\n\n<pre><code>[(u\'\\u6d41\\u884c\\u6027\', 0.8884406685829163), (u\'\\u8179\\u6cfb\', 0.8853926658630371), (u\'\\u8111\\u819c\\u708e\', 0.8741780519485474), (u\'\\u6025\\u6027\', 0.8728883266448975), (u\'\\u6162\\u6027\', 0.8612829446792603), (u\'\\u8fc7\\u654f\\u6027\', 0.8557898998260498), (u\'\\u5173\\u8282\\u708e\', 0.8552945256233215), (u\'\\u75c7\', 0.8550660610198975), (u\'\\u51fa\\u8840\', 0.8524866700172424), (u\'\\u766b\\u75eb\', 0.8476200103759766)]\n流行性\n腹泻\n脑膜炎\n急性\n慢性\n过敏性\n关节炎\n症\n出血\n癫痫\n</code></pre>','撒打发斯蒂芬',24,0,'2017-04-01 22:54:51',1525174992,0,2130706433),
	(7,'','x-pack安装使用',NULL,24,0,'<ul>\n<li>x-pack简介\n     x-pack是elasticsearch的一个扩展包，将安全，警告，监视，图形和报告功能捆绑在一个易于安装的软件包中，虽然x-pack被设计为一个无缝的工作，但是你可以轻松的启用或者关闭一些功能</li>\n<li>x-pack功能介绍\n    X-pack提供以下几个级别保护elastic集群\n    用户验证\n    授权和基于角色的访问控制\n    节点/客户端认证和信道加密\n    审计</li>\n<li>elasticsearch x-pack安装</li>\n</ul>\n\n<pre><code>/bin/elasticsearch-plugin install x-pack  ##安装\n/bin/elasticsearch-plugin remove x-pack ##卸载 \n</code></pre>\n\n<ul>\n<li>elasticsearch x-pack安装</li>\n</ul>\n\n<pre><code>/bin/kibana-plugin install x-pack ##安装\n/bin/kibana-plugin remove x-pack ##卸载 \n</code></pre>\n\n<ul>\n<li>启动</li>\n</ul>\n\n<pre><code>/bin/elasticsearch ## 启动elasticsearch\n/bin/kibana ## 启动kibana\n</code></pre>\n\n<ul>\n<li>运行web页面</li>\n</ul>\n\n<pre><code>http://localhost:5601 ## 5601默认端口 如果修改则运行自己的端口 启动事终端会提示 \n</code></pre>\n\n<blockquote>\n  默认超级账户  用户名<code>elastic</code> 密码<code>changeme</code>\n</blockquote>\n\n<h2>修改密码</h2>\n\n<ul>\n<li>方式一 安装完成web端修改</li>\n<li>方式二 终端修改</li>\n</ul>\n\n<pre><code>## 修改elastic用户的密码：\ncurl -XPUT -u elastic \'localhost:9200/_xpack/security/user/elastic/_password\' -d \'{\n  \"password\" : \"123456\"\n}\'\n\n## 修改kibana用户的密码：\ncurl -XPUT -u elastic \'localhost:9200/_xpack/security/user/kibana/_password\' -d \'{\n  \"password\" : \"123456\"\n}\'\n\n## 创建用户组和角色，创建所属用户 \neg：创建developer用户组，该用户组对test*有all权限，对.kibana*有manage，read，index权限\ncurl -XPOST -u elastic \'localhost:9200/_xpack/security/role/developer\' -d \'{\n  \"indices\" : [\n    {\n      \"names\" : [ \"test*\" ],\n      \"privileges\" : [ \"all\" ]\n    },\n    {\n      \"names\" : [ \".kibana*\" ],\n      \"privileges\" : [ \"manage\", \"read\", \"index\" ]\n    }\n  ]\n}\'\n\n## 创建guest用户，密码是Alex\ncurl -XPOST -u elastic \'localhost:9200/_xpack/security/user/guest\' -d \'{\n  \"password\" : \"Alex\",\n  \"full_name\" : \"Alex\",\n  \"email\" : \"guest@gmail.com\",\n  \"roles\" : [ \"developer\" ]\n}\'\n\n</code></pre>\n\n<h3>数据传递通信</h3>\n\n<ul>\n<li>安装完x-pack之后默认kibana /elastic 通信都需要安全验证，所以如果通信之间需要设置。</li>\n<li>kibana设置elasticsearch通信</li>\n</ul>\n\n<pre><code>### kibana.yml中加入配置\nelasticsearch.username: \"elastic\" ## elasticsearch用户名 \nelasticsearch.password: \"changeme\" ## 密码\n</code></pre>\n\n<ul>\n<li>logstash设置elasticsearch通信</li>\n</ul>\n\n<pre><code>## logstash 配置文件加入配置\ninput {\n  stdin{}\n  beats{\n     port =&gt; 5044\n  }\n}\noutput {\n    elasticsearch {\n       hosts =&gt; [\"http://localhost:9200\"]\n       user =&gt; elastic  ## 配置elasticsearch用户\n       password =&gt; changeme ## 密码\n}\n   stdout{\n       codec=&gt;rubydebug\n   }\n}\n</code></pre>',NULL,1,0,'2017-04-01 22:54:51',1525172101,0,NULL),
	(8,'','logstash配置参数语法',NULL,24,0,'<h3>语法</h3>\n\n<ul>\n<li>Logstash 支持少量的数据值类型：</li>\n</ul>\n\n<pre><code>debug =&gt; true ### bool\nhost =&gt; \"hostname\" ### string\nport =&gt; 514 ### number\nmatch =&gt; [\"datetime\", \"UNIX\", \"ISO8601\"] ### array\noptions =&gt; { ### hash\n    key1 =&gt; \"value1\",\n    key2 =&gt; \"value2\"\n}\n</code></pre>\n\n<ul>\n<li>logstash支持的条件判断(condition)</li>\n</ul>\n\n<pre><code>- logstash条件判断参数\n-  ==(等于), !=(不等于), &lt;(小于), &gt;(大于), &lt;=(小于等于), &gt;=(大于等于) \n- =~(匹配正则), !~（不匹配正则） \n- in(包含), not in(不包含) \n- and(与), or(或), nand(非与), xor(非或) \n- ()(复合表达式), !()(对复合表达式结果取反)\n</code></pre>\n\n<ul>\n<li>logstash官方插件 input/filter/output/codec</li>\n</ul>\n\n<pre><code>input {\n    stdin {}\n    filter{}\n    syslog {}\n}\n### 插件搜索 https://github.com/logstash-plugins\n</code></pre>\n\n<h3>input输入插件</h3>\n\n<h5>标准输入(stdin)</h5>\n\n<pre><code># vi config/stdin.conf\ninput {\n    stdin {\n        add_field =&gt; {\"key\" =&gt; \"value\"}\n        codec =&gt; \"plain\"\n        tags =&gt; [\"add\"]\n        type =&gt; \"std\"\n    }\n}\noutput {\n    stdout{          \n        codec =&gt; rubydebug \n    }\n}\n# logtash -f  confi/stdin.conf  运行后 输入helloworld 即可看到输入结果\n</code></pre>\n\n<h5>读取文件(file)</h5>\n\n<pre><code>input {\n    file {\n        path =&gt; \"/Users/liuhaogui/www/hillinsight/edu_tp/runtime/log/event/*.log\" ### 可以数组形式传入多个、也可正则匹配文件 path =&gt; [\"/var/log/*.log\", \"/var/log/message\"]\n        #start_position =&gt; beginning\n        #ignore_older =&gt; 0\n        #sincedb_path =&gt; \"/dev/null\"\n        type =&gt; \'tp_event_150\'\n        tags =&gt; [\"tp_event\"]\n    }\n}\n### 字段解释\ndiscover_interval : logstash 每隔多久去检查一次被监听的 path 下是否有新文件。默认值是 15 秒\nexclude : 不想被监听的文件可以排除出去，这里跟 path 一样支持 glob 展开\nsincedb_path : 配置定义 sincedb 文件到其他位置\nsincedb_write_interval : 每隔多久写一次 sincedb 文件，默认是 15 秒\nstat_interval : 每隔多久检查一次被监听文件状态（是否有更新），默认是 1 秒\nstart_position : 开始读取文件数据位置，默认是结束位置(等同 tail -F )\nignore_older : 在每次检查文件列表的时候，如果一个文件的最后修改时间超过这个值，就忽略这个文件。默认是 86400 秒，即一天。\nclose_older : 一个已经监听中的文件，如果超过这个值的时间内没有更新内容，就关闭监听它的文件句柄。默认是 3600 秒，即一小时。\n</code></pre>\n\n<h5>读取网络数据(tcp)</h5>\n\n<pre><code>input {\n    tcp {\n        port =&gt; 8888\n        mode =&gt; \"server\"\n        ssl_enable =&gt; false\n    }\n}\n</code></pre>\n\n<h5>读取Redis数据</h5>\n\n<pre><code>input {\n    redis {\n        data_type =&gt; \"pattern_channel\"\n        key =&gt; \"logstash-*\"\n        host =&gt; \"192.168.0.2\"\n        port =&gt; 6379\n        threads =&gt; 5\n    }\n}\n</code></pre>\n\n<h5>读取collectd数据</h5>\n\n<pre><code>udp {\n    port =&gt; 25826\n    buffer_size =&gt; 1452\n    workers =&gt; 3          # Default is 2\n    queue_size =&gt; 30000   # Default is 2000\n    codec =&gt; collectd { }\n    type =&gt; \"collectd\"\n}\n</code></pre>\n\n<h3>output输出插件</h3>\n\n<h5>标准输出stdout</h5>\n\n<pre><code>output {\n    stdout {\n        codec =&gt; rubydebug\n        workers =&gt; 2\n    }\n}\n</code></pre>\n\n<h5>输出文件file</h5>\n\n<pre><code>output {\n    file {\n        path =&gt; \"/path/to/%{+yyyy/MM/dd/HH}/%{host}.log.gz\"\n        message_format =&gt; \"%{message}\"\n        gzip =&gt; true\n    }\n}\n</code></pre>\n\n<h5>输出elasticsearch</h5>\n\n<pre><code>output {\n    elasticsearch {\n        host =&gt; \"192.168.0.2\"\n        protocol =&gt; \"http\"\n        index =&gt; \"logstash-%{type}-%{+YYYY.MM.dd}\"\n        index_type =&gt; \"%{type}\"\n        workers =&gt; 5\n        template_overwrite =&gt; true\n    }\n}\n</code></pre>\n\n<h5>输出redis</h5>\n\n<pre><code>output {\n    redis {\n        data_type =&gt; \"channel\"\n        key =&gt; \"logstash-chan-%{+yyyy.MM.dd}\"\n    }\n}\n</code></pre>\n\n<h5>输出tcp</h5>\n\n<pre><code>output {\n    tcp {\n        host  =&gt; \"192.168.0.2\"\n        port  =&gt; 8888\n        codec =&gt; json_lines\n    }\n}\n</code></pre>\n\n<h5>输出naios</h5>\n\n<pre><code>output {\n    nagios_nsca {\n        nagios_host =&gt; \"%{host}\"\n        nagios_service =&gt; \"logstash_check_%{type}\"\n        nagios_status =&gt; \"2\"\n        message_format =&gt; \"%{@timestamp}: %{message}\"\n        host =&gt; \"nagiosserver.domain.com\"\n    }\n}\n</code></pre>\n\n<h5>输出Email</h5>\n\n<pre><code>output {\n    email {\n        to =&gt; \"admin@website.com,root@website.com\"\n        cc =&gt; \"other@website.com\"\n        via =&gt; \"smtp\"\n        subject =&gt; \"Warning: %{title}\"\n        options =&gt; {\n            smtpIporHost       =&gt; \"localhost\",\n            port               =&gt; 25,\n            domain             =&gt; \'localhost.localdomain\',\n            userName           =&gt; nil,\n            password           =&gt; nil,\n            authenticationType =&gt; nil, # (plain, login and cram_md5)\n            starttls           =&gt; true\n        }\n        htmlbody =&gt; \"\"\n        body =&gt; \"\"\n        attachments =&gt; [\"/path/to/filename\"]\n    }\n}\n</code></pre>\n\n<h5>调用命令执行</h5>\n\n<pre><code>output {\n    exec {\n        command =&gt; \"sendsms.pl \\\"%{message}\\\" -t %{user}\"\n    }\n}\n</code></pre>\n\n<h3>filter过滤器</h3>\n\n<h5>Grok 正则捕获</h5>\n\n<pre><code>input {stdin{}}\nfilter {\n    grok {\n        match =&gt; {\n            \"message\" =&gt; \"\\s+(?&lt;request_time&gt;\\d+(?:\\.\\d+)?)\\s+\"\n        }\n    }\n}\noutput {stdout{}}\n\n### 多项匹配\nmatch =&gt; [\n    \"message\", \"(?&lt;request_time&gt;\\d+(?:\\.\\d+)?)\",\n    \"message\", \"%{SYSLOGBASE} %{DATA:message}\",\n    \"message\", \"(?m)%{WORD}\"\n]\n</code></pre>\n\n<h5>时间处理Date</h5>\n\n<h5>GeoIp查询</h5>\n\n<pre><code>filter {\n    geoip {\n        source =&gt; \"message\"\n    }\n}\n-----\nfilter {\n    geoip {\n        fields =&gt; [\"city_name\", \"continent_code\", \"country_code2\", \"country_code3\", \"country_name\", \"dma_code\", \"ip\", \"latitude\", \"longitude\", \"postal_code\", \"region_name\", \"timezone\"]\n    }\n}\n</code></pre>\n\n<h5>Spiit拆分</h5>\n\n<h5>UserAgent匹配归类</h5>\n\n<pre><code>filter {\n    useragent {\n        target =&gt; \"ua\"\n        source =&gt; \"useragent\"\n    }\n}\n</code></pre>\n\n<h5>Key-Value切分</h5>\n\n<h5>Ruby处理</h5>\n\n<h5>数值统计(Metrics)</h5>\n\n<h3>codec编码插件</h3>\n\n<h5>json编码</h5>\n\n<pre><code>input {\n    file {\n        path =&gt; \"/var/log/nginx/access.log_json\"\"\n        codec =&gt; \"json\"\n    }\n}\n</code></pre>\n\n<h5>multiline合并多行</h5>\n\n<pre><code>input {\n    stdin {\n        codec =&gt; multiline {\n            pattern =&gt; \"^\\[\"\n            negate =&gt; true\n            what =&gt; \"previous\"\n        }\n    }\n}\n</code></pre>',NULL,1,0,'2017-05-07 23:50:56',1525169849,0,NULL),
	(9,'','elasticsearch config',NULL,24,0,'<h3>elasticsearch 配置文件详解</h3>\n\n<pre><code>- 当前版本elasticsearch-5.5.1\n### 集群名称\ncluster.name: my-application\n### 节点名称\nnode.name: node-1\n### 设置自定义节点属性 后期节点属性过滤\nnode.attr.rack: r1\n### 设置保数据引路径 逗号隔开多个\npath.data: /path/to/data\n### 设置日志路径\npath.logs: /path/to/logs\n# --\n### 启动事分配固定内存 避免jvm过度占用内存是导致性能地下\nbootstrap.memory_lock: true ### 默认true\n# --\n### 设置绑定ip\nnetwork.host: 192.168.0.1\n### 设置绑定端口\nhttp.port: 9200\n# -\n#### 设置初始化集群发现的ip列表\n# The default list of hosts is [\"127.0.0.1\", \"[::1]\"]\ndiscovery.zen.ping.unicast.hosts: [\"host1\", \"host2\"]\n### 集群master候选资格\n#discovery.zen.minimum_master_nodes: 3\n\n# --\n### 设置集群数到达以后才开始数据恢复 保证数据节点数据同步\ngateway.recover_after_nodes: 3\n# --\n#action.destructive_requires_name: true\n### 禁用/启用http协议\nhttp.cors.enabled: true\nhttp.cors.allow-origin: \"*\"\n</code></pre>',NULL,1,0,'2017-05-07 22:50:56',1525174995,0,NULL),
	(10,'','zabbix安装使用',NULL,2,0,'<h1>安装zabbix-server</h1>\n\n<ul>\n<li>下载安装</li>\n</ul>\n\n<pre><code>wget https://jaist.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/3.0.10/zabbix-3.0.10.tar.gz\n# tar包含 Server, Proxy, Agent, GUI\ntar -zxvf zabbix-3.0.10.tar.gz\ncd zabbix-3.0.10\n./configure --prefix=/usr/local/zabbix --enable-server --with-mysql --with-net-snmp --with-libcurl --with-libxml2make\nmake install\n</code></pre>\n\n<ul>\n<li>相关依赖\n\n<ul>\n<li>未提示错误此步骤可以跳过</li>\n</ul></li>\n</ul>\n\n<pre><code> yum -y install net-snmp net-snmp-devel curl curl-devel libxml2 libxml2-devel\n# zabbix server有图形化要求，需要借助PHP gd的支持，这两项是PHP gd的必须项\n- freetype\n- jpegsrc\n</code></pre>\n\n<ul>\n<li>配置 \n\n<ul>\n<li>给zabbix server服务配置mysql信息 </li>\n</ul></li>\n</ul>\n\n<pre><code>vi /usr/local/zabbix/etc/zabbix_server.conf\nLogFile=/var/log/zabbix/zabbix_server.log\nDBHost=localhost \nDBName=zabbix //数据库名\nDBUser=zabbix //数据库用户名\nDBPassword=zabbix //密码\n</code></pre>\n\n<h3>配置访问界面web程序</h3>\n\n<pre><code>cd frontends\n</code></pre>\n\n<pre><code>- zabbix web服务由php编写，所以需要有php环境，将php目录移至web目录或者配置web可访问此目录。\n- 浏览器打开范文此目录地址开始安装步骤，如果提示扩展或不通过项，安装扩展并修改`php.ini`即可。\n</code></pre>\n\n<h3>安装zabbix-agent</h3>\n\n<ul>\n<li>agent是部署在被监控的机器上，用于采集CPU、内存、磁盘等统计信息，并上报给server用于进一步处理</li>\n<li>安装</li>\n</ul>\n\n<pre><code>cd zabbix-3.0.10\n./configure --prefix=/usr/local/zabbix-agent --enable-agent\nmake install\n</code></pre>\n\n<pre><code>-修改配置文件\n</code></pre>\n\n<pre><code>vi /usr/local/zabbix-agent/etc/zabbix_agentd.conf\n#日志最大值，默认1M，超出会rotate\nLogFileSize=\n#被动模式下服务器地址，可以是ip或者hostname\nServer=192.168.0.1\n#主动模式下服务器地址，可以ip或者hostname\nServerActive=192.168.0.1\n#被监控机的ip或hostname，注意的是该值必须和你在server的监控界面中定义的server name要保持一致\nHostname=192.168.0.2\n</code></pre>\n\n<ul>\n<li>配置开机启动项</li>\n</ul>\n\n<pre><code>cd /zabbix-3.0.10/misc/init.d/fedora/core\nsudo cp zabbix_* /etc/init.d/\nsudo chmod a+x /etc/init.d/zabbix_* \nchkconfig --add zabbix_server\nchkconfig --add zabbix_agentd\nchkconfig --level 345 zabbix_server on\nchkconfig --level 345 zabbix_agentd on\n</code></pre>\n\n<ul>\n<li>检查开机启动项</li>\n</ul>\n\n<pre><code>chkconfig --list | grep zabbix\n//看到输出说明开机启动ok\nzabbix_agentd   0:off   1:off   2:off   3:on    4:on    5:on    6:off\nzabbix_server    0:off   1:off   2:off   3:on    4:on    5:on    6:off\n</code></pre>',NULL,1,0,'2017-05-07 23:50:56',1525174996,0,NULL),
	(11,'','go chan有缓冲和无缓冲',NULL,1,0,'<h3>go chan有缓冲无缓冲区别</h3>\n\n<blockquote>\n  同步非同步区别\n  - 有缓冲与无缓冲\n</blockquote>\n\n<pre><code>c1:=make(chan int)        //无缓冲\nc2:=make(chan int,1)      //有缓冲\nc1 &lt;- 1\n</code></pre>\n\n<ul>\n<li>无缓冲<code>c1</code> 通道放入1后需要有携程一直处理，不然一直会阻塞下去</li>\n<li>方向论证代码(错误示例)</li>\n</ul>\n\n<pre><code>package main\n\nfunc main()  {\n    c1 := make(chan int)\n    c1 &lt;- 1 //没有处理接收就堵塞这里了  //fatal error: all goroutines are asleep - deadlock!\n    &lt;-c1\n}\n</code></pre>\n\n<ul>\n<li>正确示例</li>\n</ul>\n\n<pre><code>package main\n\nimport (\n    \"fmt\"\n    \"time\"\n)\n\nfunc read(out chan int) {\n    for {\n        fmt.Println(\"waiting =&gt; \", time.Now())\n        fmt.Println(\"read =&gt; \", &lt;-out)\n    }\n}\n\nfunc main() {\n    out := make(chan int)\n    go read(out)\n\n    for i := 1; i &lt;= 5; i++ {\n        time.Sleep(time.Second)\n        fmt.Println(\"set =&gt; \", i, time.Now())\n        out &lt;- i\n    }\n\n}\n</code></pre>\n\n<ul>\n<li>有缓冲示例</li>\n</ul>\n\n<pre><code>    c2 := make(chan int,2)\n    c2 &lt;- 1 //这里不会阻塞 因为缓冲大小是2  只有当满了2个值后还无取出 则会阻塞\n    fmt.Println(&lt;-c2) // 1\n</code></pre>',NULL,5,0,'2017-04-26 20:22:57',1525174993,0,NULL),
	(12,'','php发送与接收流文件',NULL,22,0,'<h3>数据流</h3>\n\n<ul>\n<li>数据流（data stream）最初是通信领域使用的概念，代表传输中所使用的信息的数字编码信号序列。然而，我们所提到的数据流概念与此不同。这个概念最初在1998年由Henzinger在文献87中提出，他将数据流定义为“只能以事先规定好的顺序被读取一次的数据的一个序列”。<a href=\"http://baike.baidu.com/link?url=naEBomRN0AOcgG86DoiCQbmRPKXWUQ7-4EJxk-a9hu8grEyVLbBwKEWMRuoMTveV-dZksTKZ8vKJbZ0UXEjnfGRacpStn5-mlWOQGLVSnoGGgRgBQQaj7lZ0xls_OHuo\">百度百科参考地址</a></li>\n</ul>\n\n<h3>输入流与输出流</h3>\n\n<ul>\n<li>数据流分为输入流(InputStream)和输出流(OutputStream)两类。输入流只能读不能写，而输出流只能写不能读。</li>\n<li>输入流可从键盘或文件中获得数据，输出流可向显示器、打印机或文件中传输数据。</li>\n</ul>\n\n<h3>PHP Streams是内置核心操作</h3>\n\n<ul>\n<li>PHP Streams 用于统一文件、网络、数据压缩类文件操作方式，并未这些类文件操作提供一组通用的函数接口。</li>\n<li>一个stream就是一个具有流式行为的资源对象，每个stream对象都有一个包装类。Stream 可以通过<scheme>://<target>方式来引用。其中<scheme>是包装类的名字，<target>中的内容是由包装类的语法指定，不同的包装类的语法会有所不同。</li>\n<li>内置默认的包装类</li>\n</ul>\n\n<pre><code>var_dump(stream_get_wrappers());\n/*\narray(12) {\n  [0] =&gt;\n  string(5) \"https\"\n  [1] =&gt;\n  string(4) \"ftps\"\n  [2] =&gt;\n  string(13) \"compress.zlib\"\n  [3] =&gt;\n  string(14) \"compress.bzip2\"\n  [4] =&gt;\n  string(3) \"php\"\n  [5] =&gt;\n  string(4) \"file\"\n  [6] =&gt;\n  string(4) \"glob\"\n  [7] =&gt;\n  string(4) \"data\"\n  [8] =&gt;\n  string(4) \"http\"\n  [9] =&gt;\n  string(3) \"ftp\"\n  [10] =&gt;\n  string(4) \"phar\"\n  [11] =&gt;\n  string(3) \"zip\"\n}\n*/\n</code></pre>\n\n<ul>\n<li>获取数据方式</li>\n</ul>\n\n<pre><code>file_get_contents ( \"foo.txt\" );\nfile_get_contents ( \"file:///foo.txt\" );\nfile_get_contents ( \"http://www.example.com/foo.txt\" );\nfile_get_contents ( \"ftp://user:pass@ftp.example.com/foo.txt\" );\nfile_get_contents ( \"ftp://user:pass@ftp.example.com/foo.txt\" );\nfile_get_contents(\'php://input\'); //php获取流数据\n...\n</code></pre>\n\n<h3>stream_context_create — 创建资源流上下文</h3>\n\n<pre><code>resource stream_context_create ([ array $options [, array $params ]] )\n</code></pre>\n\n<ul>\n<li>创建并返回一个资源流上下文，该资源流中包含了 options 中提前设定的所有参数的值。</li>\n<li>实例代码</li>\n</ul>\n\n<pre><code>//send.txt\n发送测试内容文本\n</code></pre>\n\n<pre><code>//send.php\nfunction send($url, $file){\n\n    if(file_exists($file)){\n\n        $opts = array(\n            \'http\' =&gt; array(\n                \'method\' =&gt; \'POST\',\n                \'header\' =&gt; \'content-type:application/x-www-form-urlencoded\',\n                \'content\' =&gt; file_get_contents($file)\n            )\n        );\n\n        $context = stream_context_create($opts);//创建资源流\n        $response = file_get_contents($url, false, $context);\n        $ret = json_decode($response, true);\n        return $ret[\'success\'];\n\n    }else{\n        return false;\n    }\n\n}\n\n$ret = send(\'http://localhost/StreamFile/receive.php\', \'send.txt\');\nvar_dump($ret);\n</code></pre>\n\n<ul>\n<li>接收流</li>\n</ul>\n\n<pre><code>//receive.php\nfunction receive($receiveFile){\n\n    $streamData = isset($GLOBALS[\'HTTP_RAW_POST_DATA\'])? $GLOBALS[\'HTTP_RAW_POST_DATA\'] : \'\';\n\n    if(empty($streamData)){\n        $streamData = file_get_contents(\'php://input\'); //读取数据流\n    }\n\n    if($streamData!=\'\'){\n        $ret = file_put_contents(\'接收到的内容=&gt; \'. $receiveFile, $streamData, true); //输出写入文件\n    }else{\n        $ret = false;\n    }\n\n    return $ret;\n\n}\n\n$receiveFile = \'receive.txt\';\n$ret = receiveStreamFile($receiveFile);\necho json_encode(array(\'success\'=&gt;(bool)$ret));\n</code></pre>',NULL,4,0,'2017-04-26 20:22:57',1525172090,0,NULL),
	(14,'','php多继承',NULL,22,0,'<ul>\n<li>php自身并不支持多继承，但是可以用过Trait实现多继承。</li>\n<li>Trait和Class 相似，但仅仅旨在用细粒度和一致的方式来组合功能。无法通过 trait 自身来实例化。它为传统继承增加了水平特性的组合；也就是说，应用的几个 Class 之间不需要继承。</li>\n<li>代码实例</li>\n</ul>\n\n<pre><code>trait ezcReflectionReturnInfo {\n\n    public function __construct()\n    {\n        echo \'ezcReflectionReturnInfo\';\n    }\n\n    function getReturnType() {\n        echo \'getReturnType\';\n    }\n    function getReturnDescription() {\n        echo \'getReturnDescription\';\n    }\n}\n\nclass ezcReflectionMethod extends ReflectionMethod {\n    use ezcReflectionReturnInfo;\n    /* ... */\n\n}\n\nclass ezcReflectionFunction extends ReflectionFunction {\n    use ezcReflectionReturnInfo;\n    /* ... */\n}\n\n$a = new ezcReflectionMethod();\n$b = new ezcReflectionFunction();\n</code></pre>\n\n<ul>\n<li>优先级\n> -   从基类继承的成员会被 trait 插入的成员所覆盖。优先顺序是来自当前类的成员覆盖了 trait 的方法，而 trait 则覆盖了被继承的方法。\n例:</li>\n</ul>\n\n<pre><code>&lt;?php\nclass Base {\n    public function sayHello() {\n        echo \'Hello \';\n    }\n}\n\ntrait SayWorld {\n    public function sayHello() {\n        parent::sayHello();\n        echo \'World!\';\n    }\n}\n\nclass MyHelloWorld extends Base {\n    use SayWorld;\n}\n\n$o = new MyHelloWorld();\n$o-&gt;sayHello();  //Hello World!\n?&gt;\n</code></pre>\n\n覆盖:\n\n<pre><code>&lt;?php\ntrait HelloWorld {\n    public function sayHello() {\n        echo \'Hello World!\';\n    }\n}\n\nclass TheWorldIsNotEnough {\n    use HelloWorld;\n    public function sayHello() {\n        echo \'Hello Universe!\';\n    }\n}\n\n$o = new TheWorldIsNotEnough();\n$o-&gt;sayHello();\n?&gt;\n</code></pre>\n\n<ul>\n<li>冲突解决\n> - 如果两个 trait 都插入了一个同名的方法，如果没有明确解决冲突将会产生一个致命错误。\n> -  为了解决多个 trait 在同一个类中的命名冲突，需要使用 insteadof 操作符来明确指定使用冲突方法中的哪一个。\n>  -  as 操作符可以将其中一个冲突的方法以另一个名称来引入。</li>\n</ul>',NULL,3,0,'2017-04-26 20:22:57',1525172092,0,NULL);

/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tags`;

CREATE TABLE `tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tags_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tags_flag` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` int(10) DEFAULT NULL,
  `updated_at` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;

INSERT INTO `tags` (`id`, `tags_name`, `tags_flag`, `created_at`, `updated_at`)
VALUES
	(1,'hello','hello',1525134888,1525134888);

/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` int(10) DEFAULT NULL,
  `updated_at` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `name`, `email`, `password`, `avatar`, `remember_token`, `created_at`, `updated_at`)
VALUES
	(1,'persimmon','test@test.com','$2a$10$CbYcx7N9TFEavvyZf5XKM.aQHykB.IqKzl/w5J9pGW6HfwrK6sb0a','https://o75u5ooep.qnssl.com/avatar/persimmon.jpg','',1523073838,1523073838);

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

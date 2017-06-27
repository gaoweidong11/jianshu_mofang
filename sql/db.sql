# 核心功能
/*
简信
*/

DROP DATABASE IF EXISTS db_jianshu;
CREATE DATABASE db_jianshu;

# 1. 用户 user
DROP TABLE IF EXISTS db_jianshu.user;
CREATE TABLE db_jianshu.user (
  id       INT                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               AUTO_INCREMENT PRIMARY KEY
  COMMENT 'ID PK',
  nick     VARCHAR(15)   NOT NULL UNIQUE
  COMMENT '昵称',
  mobile   VARCHAR(191) UNIQUE
  COMMENT '手机号',
  password VARCHAR(255) NOT NULL
  COMMENT '密码',
  avatar   VARCHAR(255) NOT NULL                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               DEFAULT 'default_avatar.png',
  pay      INT                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 DEFAULT 2
  COMMENT '打赏金额，默认-2元；NULL-关闭打赏',
  money    DECIMAL(8, 2) NOT NULL                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              DEFAULT 0
  COMMENT '账户余额'
)
  COMMENT '用户表';

# 2. 文集 notebook
DROP TABLE IF EXISTS db_jianshu.notebook;
CREATE TABLE db_jianshu.notebook (
  id     INT AUTO_INCREMENT PRIMARY KEY
  COMMENT 'ID PK',
  title VARCHAR(255) NOT NULL
  COMMENT '名称',
  userId INT COMMENT 'FK 用户 ID'
)
  COMMENT '文集表';

# 3. 文章 note
DROP TABLE IF EXISTS db_jianshu.note;
CREATE TABLE db_jianshu.note (
  id         INT      AUTO_INCREMENT PRIMARY KEY
  COMMENT 'ID PK',
  title VARCHAR(255) NOT NULL
  COMMENT '标题',
  content TEXT       NOT NULL
  COMMENT '内容',
  time    DATETIME DEFAULT now()
  COMMENT '时间',
  views   INT      DEFAULT 0
  COMMENT '阅读次数',
  notebookId INT COMMENT 'FK 文集 ID'
)
  COMMENT '文章表';

# like table: id userId noteId

# 4. 评论 comment
DROP TABLE IF EXISTS db_jianshu.comment;
CREATE TABLE db_jianshu.comment (
  id        INT      AUTO_INCREMENT PRIMARY KEY
  COMMENT 'ID PK',
  content TEXT NOT NULL
  COMMENT '内容',
  time    DATETIME DEFAULT now()
  COMMENT '时间',
  noteId  INT COMMENT 'FK 文章 ID',
  userId  INT COMMENT 'FK 用户 ID',
  commentId INT COMMENT 'FK 评论 ID'
)
  COMMENT '评论表';

# zan table: id userId commentId time

# 5. 专题 collection
DROP TABLE IF EXISTS db_jianshu.collection;
CREATE TABLE db_jianshu.collection (
  id     INT AUTO_INCREMENT PRIMARY KEY
  COMMENT 'ID PK',
  title VARCHAR(255) NOT NULL
  COMMENT '名称',
  userId INT COMMENT 'FK 用户 ID'
)
  COMMENT '专题表';

# 6. 专题-文章 collection_note
DROP TABLE IF EXISTS db_jianshu.collection_note;
CREATE TABLE db_jianshu.collection_note (
  collectionId INT COMMENT 'PK FK',
  noteId       INT COMMENT 'PK FK',
  PRIMARY KEY (collectionId, noteId)
)
  COMMENT '';

# 7. 关注 follow
DROP TABLE IF EXISTS db_jianshu.follow;
CREATE TABLE db_jianshu.follow (
  id                   INT               AUTO_INCREMENT PRIMARY KEY
  COMMENT 'ID PK',
  time DATETIME NOT NULL DEFAULT now()
  COMMENT '时间',
  userId INT COMMENT 'FK 关注者 ID',
  followedUserId INT COMMENT 'FK 被关注用户 ID',
  followedNotebookId INT COMMENT 'FK 被关注文集 ID',
  followedCollectionId INT COMMENT 'FK 被关注专题 ID'
)
  COMMENT '关注表';

# 8. 收藏 bookmark
DROP TABLE IF EXISTS db_jianshu.bookmark;
CREATE TABLE db_jianshu.bookmark (
  id     INT AUTO_INCREMENT PRIMARY KEY
  COMMENT 'ID PK',
  userId INT COMMENT 'FK 收藏者 ID',
  noteId INT COMMENT 'FK 被收藏文章 ID'
)
  COMMENT '收藏表';

# 9. 打赏 pay
DROP TABLE IF EXISTS db_jianshu.pay;
CREATE TABLE db_jianshu.pay (
  id      INT AUTO_INCREMENT PRIMARY KEY
  COMMENT 'ID PK',
  amount INT           NOT NULL
  COMMENT '金额',
  message VARCHAR(255) COMMENT '留言',
  method  VARCHAR(255) NOT NULL
  COMMENT '支付方式',
  userId  INT COMMENT 'FK 打赏用户 ID',
  noteId  INT COMMENT 'FK 文章 ID'
)
  COMMENT '打赏表';

# 外键
ALTER TABLE db_jianshu.notebook
  ADD CONSTRAINT
  notebook_fk_userId
FOREIGN KEY (userId)
REFERENCES db_jianshu.user (id);

ALTER TABLE db_jianshu.note
  ADD CONSTRAINT
  note_fk_notebookId
FOREIGN KEY (notebookId)
REFERENCES db_jianshu.notebook (id);

ALTER TABLE db_jianshu.comment
  ADD CONSTRAINT
  comment_fk_noteId
FOREIGN KEY (noteId)
REFERENCES db_jianshu.note (id);

ALTER TABLE db_jianshu.comment
  ADD CONSTRAINT
  comment_fk_userId
FOREIGN KEY (userId)
REFERENCES db_jianshu.user (id);

ALTER TABLE db_jianshu.comment
  ADD CONSTRAINT
  comment_fk_commentId
FOREIGN KEY (commentId)
REFERENCES db_jianshu.comment (id);

ALTER TABLE db_jianshu.collection
  ADD CONSTRAINT
  collection._fk_userId
FOREIGN KEY (userId)
REFERENCES db_jianshu.user (id);

ALTER TABLE db_jianshu.collection_note
  ADD CONSTRAINT
  collection_note._fk_collectionId
FOREIGN KEY (collectionId)
REFERENCES db_jianshu.collection (id);

ALTER TABLE db_jianshu.collection_note
  ADD CONSTRAINT
  collection_note._fk_noteId
FOREIGN KEY (noteId)
REFERENCES db_jianshu.note (id);

ALTER TABLE db_jianshu.follow
  ADD CONSTRAINT
  follow_fk_userId
FOREIGN KEY (userId)
REFERENCES db_jianshu.user (id);

ALTER TABLE db_jianshu.follow
  ADD CONSTRAINT
  follow_fk_followedUserId
FOREIGN KEY (followedUserId)
REFERENCES db_jianshu.user (id);

ALTER TABLE db_jianshu.follow
  ADD CONSTRAINT
  follow_fk_followedNotebookId
FOREIGN KEY (followedNotebookId)
REFERENCES db_jianshu.notebook (id);

ALTER TABLE db_jianshu.follow
  ADD CONSTRAINT
  follow_fk_followedCollectionId
FOREIGN KEY (followedCollectionId)
REFERENCES db_jianshu.collection (id);

ALTER TABLE db_jianshu.bookmark
  ADD CONSTRAINT
  bookmark_fk_userId
FOREIGN KEY (userId)
REFERENCES db_jianshu.user (id);

ALTER TABLE db_jianshu.bookmark
  ADD CONSTRAINT
  bookmark_fk_noteId
FOREIGN KEY (noteId)
REFERENCES db_jianshu.note (id);

ALTER TABLE db_jianshu.pay
  ADD CONSTRAINT
  pay_fk_userId
FOREIGN KEY (userId)
REFERENCES db_jianshu.user (id);

ALTER TABLE db_jianshu.pay
  ADD CONSTRAINT
  pay_fk_noteId
FOREIGN KEY (noteId)
REFERENCES db_jianshu.note (id);


-- SELECT
SELECT *
FROM db_jianshu.user;

SELECT *
FROM db_jianshu.notebook;

SELECT *
FROM db_jianshu.note;

SELECT *
FROM db_jianshu.comment;

SELECT *
FROM db_jianshu.follow;
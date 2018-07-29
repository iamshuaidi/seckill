-- 数据库初始化脚本

-- 创建数据库
CREATE DATABASE seckill
-- 使用数据库
use seckill;
-- 创建秒杀库存表
CREATE TABLE seckill(
`seckill_id` bigint NOT NULL AUTO_INCREMENT,
`name` varchar(50) NOT NULL,
`number` int NOT NULL,
`start_time` timestamp NOT NULL,
`end_time` timestamp NOT NULL,
`create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (seckill_id),
key idx_start_time(start_time),
key idx_end_time(end_time),
key idx_create_time(create_time)
)ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT '秒杀库存表';

--初始化数据
insert into seckill(name, number, start_time, end_time)
values
('1000元秒杀iphone6', 100, '2018-7-28 00:00:00', '2018-7-29 00:00:00'),
('100元秒杀iphone7', 1000, '2018-7-28 00:00:00', '2018-7-29 00:00:00'),
('2000元秒杀iphone8', 400, '2018-7-28 00:00:00', '2018-7-29 00:00:00'),
('600元秒杀小米5', 500, '2018-7-28 00:00:00', '2018-7-29 00:00:00'),
('1000元秒杀荣耀8', 600, '2018-7-28 00:00:00', '2018-7-29 00:00:00');

-- 秒杀成功明细表
-- 用户登陆认证相关的信息
 create table success_killed (
  `seckill_id` bigint NOT NULL,
  `user_phone` bigint NOT NULL,
  `state` tinyint NOT NULL DEFAULT -1 COMMENT '-1:无效  0:成功  1:已付款',
  `create_time` timestamp NOT NULL,
  PRIMARY KEY(seckill_id,user_phone), /*联合主键*/
  key idx_create_time(create_time)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='秒杀明细表';

-- 连接数据库控制台
mysql -uroot -p123456

-- 为什么要手写ddl这样的脚本呢？
-- 记录每次上线的DDL修改
-- 上线v1.1

ALTER TABLE seckill
DROP INDEX idx_create_time
ADD index idx_c_s(start_time,create_time);
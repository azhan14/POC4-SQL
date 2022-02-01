CREATE DATABASE POC4;
USE POC4;

create table author (
id int primary key,
name varchar(100)
);

create table post(
id int primary key,
name varchar(100),
authorid int,
foreign key(authorid) references author(id),
createdts datetime
);



create table user (
id int primary key,
name varchar(100)
);

create table comment (
id int primary key,
content varchar(1000),
postid int,
foreign key(postid) references post(id),
createdts datetime,
userid int, 
foreign key (userid) references user(id)
);

select * from post;

select * from comment;

select * from author;

select * from user;

INSERT INTO AUTHOR(id,name) VALUES(1,'JAMES BOND');

INSERT INTO POST(id,name,authorid,createdts) VALUES (1,'SPECTRE',1,now());
INSERT INTO POST(id,name,authorid,createdts) VALUES (2,'NO WAY TO DIE',1,now());

INSERT INTO USER(id,name) VALUES(1,'JIM'),
(2,'DWIGHT'),
(3,'PAM'),
(4,'KELLY'),
(5,'MICHAEL'),
(6,'MIKE'),
(7,'RAJ'),
(8,'DONNA'),
(9,'SHELDON'),
(10,'JUAN');

INSERT INTO COMMENT(id,content,postid,createdts,userid) VALUES(1,'GREAT POST',1,now(),2),
(2,'NICE POST',1,now(),4),
(3,'AVERAGE',1,now(),6),
(4,'NOT BAD',1,now(),8),
(5,'LOOKS GOOD',1,now(),10),
(6,'NOT MY TYPE',1,now(),1),
(7,'DISAGREE',1,now(),3),
(8,'LMAO',1,now(),5),
(9,'NICE ONE',1,now(),7),
(10,'GGS',1,now(),9);

INSERT INTO COMMENT(id,content,postid,createdts,userid) VALUES(12,'GREAT POST',2,now(),2),
(13,'NICE POST',2,now(),4),
(14,'AVERAGE',2,now(),6),
(15,'NOT BAD',2,now(),8),
(16,'LOOKS GOOD',2,now(),10),
(17,'NOT MY TYPE',2,now(),1),
(18,'DISAGREE',2,now(),3),
(19,'LMAO',2,now(),5),
(20,'NICE ONE',2,now(),7),
(21,'GGS',2,now(),9);

INSERT INTO COMMENT(id,content,postid,createdts,userid) VALUES(11,'Marvellous',1,now(),1);

SELECT c.id as comment_id,c.content as content,c.createdts as comment_created_ts,c.userid as user_id, p.id as post_id, p.name as post_name,
p.authorid as author_id,p.createdts as post_created_ts
FROM (
	SELECT *, row_number() OVER (PARTITION BY postid ORDER BY createdts DESC) AS rn
    FROM comment
) c
JOIN post p 
ON p.id = c.postid
WHERE p.authorid = (SELECT id from AUTHOR WHERE NAME='JAMES BOND') AND rn <= 10
ORDER BY c.createdts DESC;
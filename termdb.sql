grant all privileges on  *.* to 'root'@'%' identified by 'mysql1234';
delete from mysql.user where host="localhost" and user="root";
flush privileges;
select host,user,plugin,authentication_string from mysql.user;

#####
DROP DATABASE IF EXISTS `termdb` ;#termdb를 삭제

CREATE DATABASE IF NOT EXISTS `termdb` #있으면 삭제 후 생성 없으면 바로 생성
  DEFAULT CHARACTER SET utf8 
  DEFAULT COLLATE utf8_general_ci;

USE `termdb` ;

create table `game` (
    #id int not null AUTO_INCREMENT,
    `title` varchar(20) not NULL,    #게임명
    `developer` varchar(20),         #개발사
    primary key (`title`)            #기본키
) engine=InnoDB
	DEFAULT CHARACTER SET utf8
	DEFAULT COLLATE utf8_general_ci;

create table `review` (
    #rid int,
    `title` varchar(20) not NULL,    #게임명
    `memo` varchar(50),              #게임 설명
    primary key(`title`),
    INDEX(`title`),
    #foreign key(rid) references gmae(id),
    foreign key(`title`) references `game`(`title`) ON DELETE CASCADE ON UPDATE CASCADE #지우면 같이 지워짐
) engine=InnoDB
	DEFAULT CHARACTER SET utf8
	DEFAULT COLLATE utf8_general_ci;
    
create table `genre` (
    `title` varchar(20) not NULL,    #게임명
    `genre1` varchar(20),            #장르1
    `genre2` varchar(20),            #장르2
    primary key(`title`),
    INDEX(`title`),
    foreign key(`title`) references `game`(`title`) ON DELETE CASCADE ON UPDATE CASCADE
) engine=InnoDB
	DEFAULT CHARACTER SET utf8
	DEFAULT COLLATE utf8_general_ci;
    
    create table `image` (
    `title` varchar(20) not NULL,     #게임명
    `image_name` varchar(50),
    `image` varchar(2083),            #사진의 주소
    primary key(`title`),
    INDEX(`title`),
    foreign key(`title`) references `game`(`title`) ON DELETE CASCADE ON UPDATE CASCADE
) engine=InnoDB
	DEFAULT CHARACTER SET utf8
	DEFAULT COLLATE utf8_general_ci;



#######
INSERT INTO game (title,developer) VALUES    #게임 테이블 개체 생성
('리그 오브 레전드', '라이엇 게임즈'),
('배틀 그라운드', '펍지'),
('붕괴3rd', '미호요'),
('원신', '미호요'),
('몬스터 헌터 월드', '캡콤'),
('코드 베인', '반다이 남코'),
('어쌔신 크리드: 발할라', '유비소프트 몬트리올'),
('사이버펑크 2077', 'CD PROJEKT RED'),
('철권7', '반다이 남코');

insert into review (title,memo) VALUES #리뷰 테이블 개체 생성
('리그 오브 레전드', '라이엇 게임즈 대표작'),
('배틀 그라운드', '펍지를 먹여 살린 게임'),
('붕괴3rd', '원신 이전 미호요의 대표작'),
('원신', '붕괴3rd에서의 기술을 오픈 월드에 담은 게임'),
('몬스터 헌터 월드', '몬스터를 잡는 헌터'),
('코드 베인', '흡혈귀 + 애니메이션 + 다크 소울'),
('어쌔신 크리드: 발할라', '어쌔신 크리드 신작'),
('사이버펑크 2077', '30번대 그래픽카드 구매 재평가'),
('철권7', '근본 격투 게임');

insert into genre (title,genre1,genre2) VALUES #장르 테이블 개체 생성
('리그 오브 레전드', 'MOBA', NULL),
('배틀 그라운드', '배틀로얄', '액션 어드벤처'),
('붕괴3rd', '액션 RPG', '핵 앤드 슬래시'),
('원신', '액션 RPG','어드벤처'),
('몬스터 헌터 월드', '액션 RPG', 'MORPG'),
('코드 베인', '액션 RPG', NULL),
('어쌔신 크리드: 발할라', '액션 RPG', NULL),
('사이버펑크 2077', '액션 RPG', 'FPS'),
('철권7', '대전 격투', NULL);

insert into image (title,image_name,image) VALUES # 이미지 테이블 개체 생성
('리그 오브 레전드','리그 오브 레전드.jpg','https://lolstatic-a.akamaihd.net/frontpage/apps/prod/harbinger-l10-website/ko-kr/production/ko-kr/static/twitter-fafabb053dd48811ea554fe63188cc1a.jpg'),
('배틀 그라운드','배틀 그라운드.jpg','https://upload.wikimedia.org/wikipedia/ko/thumb/0/05/Battlegrounds_Cover_Art.png/300px-Battlegrounds_Cover_Art.png'),
('붕괴3rd','붕괴3rd.jpg','https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Honkai_Impact_3rd_logo_at_Honkai_Impact_3rd_booth_stage_20200801.jpg/220px-Honkai_Impact_3rd_logo_at_Honkai_Impact_3rd_booth_stage_20200801.jpg'),
('원신','원신.jpg',  'https://www.sisaweekly.com/news/photo/202009/32918_50860_595.jpg'),
('몬스터 헌터 월드','몬스터 헌터 월드.jpg','https://ww.namu.la/s/24601e3fb0b44202169a30303137063865d26b7af2e59c034e2531ab96a63bf47dde71c63bdce5239af019f34f25facf6a1139c689ddcd227c96c36c6767b2c42ceb5376842b02e60054956cf324a071426987d596c724a5c5b6f0d0384d964efff4d08f6fa6cc2d4b36d88acd3d8310'),
('코드 베인', '코드 베인.jpg','https://ww.namu.la/s/c14ef9919baa3332168bd9148b7ba6ce94e815cc70486fb65f6fb86962559da45b4408bd0ac70bddb3be23e1439c02440f0d3da3f377133539424a31798d91f1e5e303d7d176fefe87132482599685e65c38be0380854f5757a6ffc94550e8f930ffa8b963a1e8fbadfafc0312baf4d9'),
('어쌔신 크리드: 발할라','어쌔신 크리드: 발할라.jpg','https://w.namu.la/s/b1d8d566bb640edd45208f888b397eda8259d2bc8c1aab1311b84ae8ec72376d18812a3baede2e3638d819497993aa1eaf743ebaab1acbe8ad0b0199b9032718cbd4ebb4dc192dbaa9639523bd69a10b9756f779b0a4e8a8a6230f2413f2201d99393db525379a1fb28f549deddca047'),
('사이버펑크 2077','사이버펑크 2077.jpg','https://ww.namu.la/s/d550f67ae754da7d8c067afbd0e96dc492f82d7944616bd5889d79eba753727b55787ffa5df3b7f404f30a64210d03ec46ac9a8e3ae3d4e994a801a7f2c9a48c14b0b9d0b614a3b596528aa0cf24c9a2dab7f0ee6907aacaf6a687d40402d029fb14a46056f7effef514e70fb21ea1a7'),
('철권7','철권7.jpg', 'https://w.namu.la/s/1dbcf9252c43b4ee4d65077cd949de459170b783b97591949f55b1e9dfdc7625d27b57b5af1be39fad7c815d577a942dbfeffc011e7c5ce97e3ed25cae18cf94b623feca7518a2e97c70445bc8ed572f91cd27dc510d347c01e4ab82fabcc220c172aff2be59148c18acfde3ef8c1e24');

/*//안될경우 아래 코드 사용
grant all privileges on  *.* to 'root'@'%' identified by 'mysql1234';
delete from mysql.user where host="localhost" and user="root";
flush privileges;
select host,user,plugin,authentication_string from mysql.user;

#####
DROP DATABASE IF EXISTS `termdb` ;

CREATE DATABASE IF NOT EXISTS `termdb` 
  DEFAULT CHARACTER SET utf8 
  DEFAULT COLLATE utf8_general_ci;

USE `termdb` ;

create table game (
    #id int not null AUTO_INCREMENT,
    title varchar(20),
    developer varchar(20),
    primary key (title)
) engine=InnoDB
	DEFAULT CHARACTER SET utf8
	DEFAULT COLLATE utf8_general_ci;

create table review (
    #rid int,
    title varchar(20),
    memo varchar(50),
    primary key(title),
    #foreign key(rid) references gmae(id),
    foreign key(title) references game(title)
) engine=InnoDB
	DEFAULT CHARACTER SET utf8
	DEFAULT COLLATE utf8_general_ci;
    
create table genre (
    title varchar(20),
    genre1 varchar(20),
    genre2 varchar(20),
    primary key(title),
    foreign key(title) references game(title)
) engine=InnoDB
	DEFAULT CHARACTER SET utf8
	DEFAULT COLLATE utf8_general_ci;
    
    create table image (
    title varchar(20) not NULL,
    image_name varchar(20),
    image varchar(2083),
    primary key(title),
    foreign key(title) references game(title) ON DELETE CASCADE ON UPDATE CASCADE
) engine=InnoDB
	DEFAULT CHARACTER SET utf8
	DEFAULT COLLATE utf8_general_ci;




#######
insert into game values ('리그 오브 레전드', '라이엇 게임즈');
insert into game values ('배틀 그라운드', '펍지');
insert into game values ('붕괴3rd', '미호요');
insert into game values ('원신', '미호요');
insert into game values ('몬스터 헌터 월드', '캡콤');
insert into game values ('코드 베인', '반다이 남코');
insert into game values ('어쌔신 크리드: 발할라', '유비소프트 몬트리올');
insert into game values ('사이버펑크 2077', 'CD PROJEKT RED');
insert into game values ('철권7', '반다이 남코');

insert into review values ('리그 오브 레전드', '라이엇 게임즈 대표작');
insert into review values ('배틀 그라운드', '펍지를 먹여 살린 게임');
insert into review values ('붕괴3rd', '원신 이전 미호요의 대표작');
insert into review values ('원신', '붕괴3rd에서의 기술을 오픈 월드에 담은 게임');
insert into review values ('몬스터 헌터 월드', '몬스터를 잡는 헌터');
insert into review values ('코드 베인', '흡혈귀 + 애니메이션 + 다크 소울');
insert into review values ('어쌔신 크리드: 발할라', '어쌔신 크리드 신작');
insert into review values ('사이버펑크 2077', '30번대 그래픽카드 구매 재평가');
insert into review values ('철권7', '근본 격투 게임');
  
insert into genre values ('리그 오브 레전드', 'MOBA', NULL);
insert into genre values ('배틀 그라운드', '배틀로얄', '액션 어드벤처');
insert into genre values ('붕괴3rd', '액션 RPG', '핵 앤드 슬래시');
insert into genre values ('원신', '액션 RPG','어드벤처');
insert into genre values ('몬스터 헌터 월드', '액션 RPG', 'MORPG');
insert into genre values ('코드 베인', '액션 RPG', NULL);
insert into genre values ('어쌔신 크리드: 발할라', '액션 RPG', NULL);
insert into genre values ('사이버펑크 2077', '액션 RPG', 'FPS');
insert into genre values ('철권7', '대전 격투', NULL);

insert into image values ('리그 오브 레전드','리그 오브 레전드.jpg','https://lolstatic-a.akamaihd.net/frontpage/apps/prod/harbinger-l10-website/ko-kr/production/ko-kr/static/twitter-fafabb053dd48811ea554fe63188cc1a.jpg');
insert into image values ('배틀 그라운드','배틀 그라운드.jpg','https://upload.wikimedia.org/wikipedia/ko/thumb/0/05/Battlegrounds_Cover_Art.png/300px-Battlegrounds_Cover_Art.png');
insert into image values ('붕괴3rd','붕괴3rd.jpg','https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Honkai_Impact_3rd_logo_at_Honkai_Impact_3rd_booth_stage_20200801.jpg/220px-Honkai_Impact_3rd_logo_at_Honkai_Impact_3rd_booth_stage_20200801.jpg');
insert into image values ('원신','원신.jpg',  'https://www.sisaweekly.com/news/photo/202009/32918_50860_595.jpg');
insert into image values ('몬스터 헌터 월드','몬스터 헌터 월드.jpg','https://ww.namu.la/s/24601e3fb0b44202169a30303137063865d26b7af2e59c034e2531ab96a63bf47dde71c63bdce5239af019f34f25facf6a1139c689ddcd227c96c36c6767b2c42ceb5376842b02e60054956cf324a071426987d596c724a5c5b6f0d0384d964efff4d08f6fa6cc2d4b36d88acd3d8310');
insert into image values ('코드 베인', '코드 베인.jpg','https://ww.namu.la/s/c14ef9919baa3332168bd9148b7ba6ce94e815cc70486fb65f6fb86962559da45b4408bd0ac70bddb3be23e1439c02440f0d3da3f377133539424a31798d91f1e5e303d7d176fefe87132482599685e65c38be0380854f5757a6ffc94550e8f930ffa8b963a1e8fbadfafc0312baf4d9');
insert into image values ('어쌔신 크리드: 발할라','어쌔신 크리드: 발할라.jpg','https://w.namu.la/s/b1d8d566bb640edd45208f888b397eda8259d2bc8c1aab1311b84ae8ec72376d18812a3baede2e3638d819497993aa1eaf743ebaab1acbe8ad0b0199b9032718cbd4ebb4dc192dbaa9639523bd69a10b9756f779b0a4e8a8a6230f2413f2201d99393db525379a1fb28f549deddca047');
insert into image values ('사이버펑크 2077','사이버펑크 2077.jpg','https://ww.namu.la/s/d550f67ae754da7d8c067afbd0e96dc492f82d7944616bd5889d79eba753727b55787ffa5df3b7f404f30a64210d03ec46ac9a8e3ae3d4e994a801a7f2c9a48c14b0b9d0b614a3b596528aa0cf24c9a2dab7f0ee6907aacaf6a687d40402d029fb14a46056f7effef514e70fb21ea1a7');
insert into image values ('철권7','철권7.jpg', 'https://w.namu.la/s/1dbcf9252c43b4ee4d65077cd949de459170b783b97591949f55b1e9dfdc7625d27b57b5af1be39fad7c815d577a942dbfeffc011e7c5ce97e3ed25cae18cf94b623feca7518a2e97c70445bc8ed572f91cd27dc510d347c01e4ab82fabcc220c172aff2be59148c18acfde3ef8c1e24');
*/
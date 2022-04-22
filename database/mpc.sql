mysql -u root -p
123456

drop database mpc;
create database mpc;
use mpc;

CREATE TABLE `users` (
            `id` INT  NOT NULL AUTO_INCREMENT,            
            `email` VARCHAR(255) NOT NULL,
            `password` varchar(32) NOT NULL,                     
            `firstname` VARCHAR(100)  NOT NULL,            
            `lastname` VARCHAR(100)  NOT NULL,      
            `dob` datetime NOT NULL,            
            `gender` VARCHAR(10)  NOT NULL,            
            `country` VARCHAR(50)  NOT NULL,                                     
			`zonal` VARCHAR(50)  NOT NULL,                                     
            `dateofjoin` datetime NOT NULL,                  
            `profilePic` VARCHAR(255) NOT NULL default 'images/users/none.jpg',                  
            `usertype` tinyint(3) unsigned NOT NULL default 1,
            `canuse` tinyint(3) unsigned NOT NULL default 1,                        
            `showProfile` tinyint(3) unsigned NOT NULL default 1,
            `siteType` VARCHAR(255) NOT NULL,
            PRIMARY KEY (`id`),
            UNIQUE (email)                        
)ENGINE=InnoDB AUTO_INCREMENT=501;

CREATE TABLE `profiles` (
            `id` INT  NOT NULL AUTO_INCREMENT,            
            `email` VARCHAR(255),
            `work` varchar(255),                     
            `education` VARCHAR(255),            
            `relationship` VARCHAR(100),      
            `familyMembers` VARCHAR(5),                       
            `aboutMe` VARCHAR(255),                                     
            `quotations` VARCHAR(255),                                    
            `movies` VARCHAR(255),
            `tvshows` VARCHAR(255),
            `singer` VARCHAR(255),
            `book` VARCHAR(255),
            `player` VARCHAR(255),
            `cityOfLiving` VARCHAR(255),
            `phone` VARCHAR(255),
            `address` VARCHAR(255), 
            `profilePic` VARCHAR(255) NOT NULL default 'images/users/none.jpg',
            `siteType` VARCHAR(255) NOT NULL,                       
            PRIMARY KEY (`id`),     
            UNIQUE (`email`)                        
)ENGINE=InnoDB AUTO_INCREMENT=501;

CREATE TABLE `notifications` (
            `id` INT  NOT NULL AUTO_INCREMENT,            
            `email` VARCHAR(255) NOT NULL,
            `notification` TEXT NOT NULL,   
            `activity` TEXT NOT NULL,                     
            `otherinfo` VARCHAR(10) NOT NULL default 'None',
            `publishDate` datetime NOT NULL,                                               
            `sent` tinyint(3) unsigned NOT NULL default 0,
            `siteType` VARCHAR(255) NOT NULL,
            PRIMARY KEY (`id`)                                    
);  

/*
status --> 0 ---> waiting Friend
status --> 1 ---> Accepted Friend


*/
CREATE TABLE `friends` (                        
            `id` INT  NOT NULL AUTO_INCREMENT,            
            `email` VARCHAR(255) NOT NULL,
            `friendMail` VARCHAR(255) NOT NULL,                                 
            `status` VARCHAR(10) NOT NULL default '0',
            `publishDate` datetime NOT NULL, 
			`zonal` VARCHAR(50)  NOT NULL,
            `siteType` VARCHAR(255) NOT NULL,  			
            PRIMARY KEY (`id`),
            unique key(email,friendMail)                                  
);
 

CREATE TABLE `wallmessages` (                        
            `id` INT  NOT NULL AUTO_INCREMENT,            
            `toMail` VARCHAR(255) NOT NULL,
            `fromMail` VARCHAR(255) NOT NULL,                                 
            `message` TEXT NOT NULL,
            `msgDate` datetime NOT NULL,     
            `siteType` VARCHAR(255) NOT NULL,  
            PRIMARY KEY (`id`)                                  
);

CREATE TABLE `wallMessageStatus` (                        
            `num` VARCHAR(20) NOT NULL,            
            `messageDetails` TEXT NOT NULL,   
            `siteType` VARCHAR(255) NOT NULL                                        
);  
 
 
CREATE TABLE `fileuploads` (
   tid int unsigned NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,  
  `filename` TEXT NULL,
  `filesize` TEXT NULL,
  `filepath` TEXT NULL,
  `filetype` TEXT NULL,     
  `uploaddate` datetime NULL,
  `visible` VARCHAR(10) NOT NULL default 'Y',
  `siteType` VARCHAR(255) NOT NULL,  
   PRIMARY KEY (`tid` ASC)
);

CREATE TABLE `taginfo` (
   `tagid` int unsigned NOT NULL AUTO_INCREMENT, 
   `tid` int unsigned NOT NULL,
   `filename` TEXT NULL,
   `email` VARCHAR(255) NOT NULL,
   `title` VARCHAR(255) NOT NULL,
   `friendName` VARCHAR(255) NOT NULL,
   `friendMail` VARCHAR(255) NOT NULL,  
   `x` TEXT NULL,
   `y` TEXT NULL,
   `h` TEXT NULL,
   `w` TEXT NULL,     
   `uploaddate` datetime NULL,
   `status` VARCHAR(10) NOT NULL default 'N',
   `siteType` VARCHAR(255) NOT NULL default 'None',  
    PRIMARY KEY (`tagid` ASC),
    UNIQUE (`tid`,`friendMail`)
);

CREATE TABLE `tagMatrix` (
   `tagid` int unsigned NOT NULL,
   `tid` int unsigned NOT NULL,      
   `email` VARCHAR(255) NOT NULL,   
   `status` VARCHAR(10) NOT NULL,
   UNIQUE (`tagid`,`tid`,`email`)   
);

CREATE TABLE `tagPolicy` (
   `tagid` int unsigned NOT NULL,
   `tid` int unsigned NOT NULL,      
   `tagger` VARCHAR(255) NOT NULL,   
   `party` VARCHAR(255) NOT NULL,   
   `partyanswer` VARCHAR(10) NOT NULL,
   UNIQUE (`tagid`,`tid`,`tagger`,`party`)   
);

CREATE TABLE `actionsmonitor` (     
            `actioned` varchar(100) NOT NULL,      
            `actioner` varchar(100) NOT NULL,
            `action` VARCHAR(200) NOT NULL,                     
            `actionon` datetime NOT NULL,                                   
            `actionertype` VARCHAR(100),                                     
            `sensitiveaction` VARCHAR(100)                                     
);

CREATE TABLE `userLive` (     
            `usid` VARCHAR(255) NOT NULL,                                
			`email` VARCHAR(255) NOT NULL,
            `dateoflogin` datetime DEFAULT CURRENT_TIMESTAMP,                  
            `status` VARCHAR(50) NOT NULL default 'online'			
);

CREATE TABLE `userGroups` (
			`id` INT  NOT NULL AUTO_INCREMENT,
            `usid` VARCHAR(255) NOT NULL,                                
			`groupName` VARCHAR(255) NOT NULL,
			`zonal` VARCHAR(255) NOT NULL,
			`dateofcreation` datetime DEFAULT CURRENT_TIMESTAMP, 
            PRIMARY KEY (`id`),
            UNIQUE (usid,groupName)                        
)ENGINE=InnoDB AUTO_INCREMENT=101;

insert into users(`email`,`password`,`firstname`,`lastname`,`dob`,`gender`,`country`,`zonal`,`dateofjoin`,`siteType`) values('u1@gmail.com','81dc9bdb52d04dc20036dbd8313ed055','u1','u1','1980-07-12','null','London(Canada)','North-East London',now(),'FBSim');
insert into users(`email`,`password`,`firstname`,`lastname`,`dob`,`gender`,`country`,`zonal`,`dateofjoin`,`siteType`) values('u2@gmail.com','81dc9bdb52d04dc20036dbd8313ed055','u2','u2','1981-07-12','null','London(Canada)','South-West London',now(),'FBSim');
insert into users(`email`,`password`,`firstname`,`lastname`,`dob`,`gender`,`country`,`zonal`,`dateofjoin`,`siteType`) values('u3@gmail.com','81dc9bdb52d04dc20036dbd8313ed055','u3','u3','1982-07-12','null','London(Canada)','South-West London',now(),'FBSim');
insert into users(`email`,`password`,`firstname`,`lastname`,`dob`,`gender`,`country`,`zonal`,`dateofjoin`,`siteType`) values('u4@gmail.com','81dc9bdb52d04dc20036dbd8313ed055','u4','u4','1982-07-12','null','London(Canada)','North-West London',now(),'FBSim');
insert into users(`email`,`password`,`firstname`,`lastname`,`dob`,`gender`,`country`,`zonal`,`dateofjoin`,`siteType`) values('u5@gmail.com','81dc9bdb52d04dc20036dbd8313ed055','u5','u5','1982-07-12','null','London(Canada)','South-East London',now(),'FBSim');

create table u1_u1_grps(usid VARCHAR(255) NOT NULL,uname VARCHAR(255) NOT NULL,groupname VARCHAR(255) NOT NULL,usertype VARCHAR(255) NOT NULL,zonal VARCHAR(255) NOT NULL,status VARCHAR(255) NOT NULL);
create table u2_u2_grps(usid VARCHAR(255) NOT NULL,uname VARCHAR(255) NOT NULL,groupname VARCHAR(255) NOT NULL,usertype VARCHAR(255) NOT NULL,zonal VARCHAR(255) NOT NULL,status VARCHAR(255) NOT NULL);
create table u3_u3_grps(usid VARCHAR(255) NOT NULL,uname VARCHAR(255) NOT NULL,groupname VARCHAR(255) NOT NULL,usertype VARCHAR(255) NOT NULL,zonal VARCHAR(255) NOT NULL,status VARCHAR(255) NOT NULL);
create table u4_u4_grps(usid VARCHAR(255) NOT NULL,uname VARCHAR(255) NOT NULL,groupname VARCHAR(255) NOT NULL,usertype VARCHAR(255) NOT NULL,zonal VARCHAR(255) NOT NULL,status VARCHAR(255) NOT NULL);
create table u5_u5_grps(usid VARCHAR(255) NOT NULL,uname VARCHAR(255) NOT NULL,groupname VARCHAR(255) NOT NULL,usertype VARCHAR(255) NOT NULL,zonal VARCHAR(255) NOT NULL,status VARCHAR(255) NOT NULL);


insert into friends(email,friendMail,status,publishDate,zonal,siteType) values('u2@gmail.com','u3@gmail.com','1',now(),'South-West London','FBSim');
insert into friends(email,friendMail,status,publishDate,zonal,siteType) values('u3@gmail.com','u2@gmail.com','1',now(),'South-West London','FBSim');

insert into userLive(`usid`,email,`status`) values('u2.u2','u2@gmail.com','offline');
insert into userLive(`usid`,email,`status`) values('u3.u3','u3@gmail.com','offline');

commit;

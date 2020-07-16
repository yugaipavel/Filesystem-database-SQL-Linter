drop table FFILES;
drop table FFOLDERS;
drop table AACCESS_RIGHTS;
drop table OBJECTS;
drop table SUBJECTS;
drop table FILE_SYSTEM;

create or replace table FILE_SYSTEM
(
fs_id int,
primary key(fs_id),
fs_name char(32)
);
create or replace table SUBJECTS
(
s_id int,
fs_id int,
primary key(s_id, fs_id),
foreign key(fs_id) references FILE_SYSTEM(fs_id) on update cascade on delete cascade,

s_name char(32),
type_name char(32)
);
create or replace table OBJECTS
(
o_id int,
fs_id int,
primary key (o_id, fs_id),
foreign key(fs_id) references FILE_SYSTEM(fs_id) on update cascade on delete cascade,

o_name char(32),
type_name char(32)
);
create or replace table AACCESS_RIGHTS
(
ar_id int,
primary key(ar_id),
ar_name char(32),
s_id int,
o_id int,
fs_id_from_o int,
fs_id_from_s int,
foreign key(s_id,fs_id_from_s) references SUBJECTS(s_id,fs_id) on update cascade on delete cascade,
foreign key(o_id,fs_id_from_o) references OBJECTS(o_id,fs_id) on update cascade on delete cascade
);
create or replace table FFOLDERS
(
o_id int,
fs_id int,
primary key(o_id,fs_id),
foreign key(o_id, fs_id) references OBJECTS(o_id, fs_id) on update cascade on delete cascade,

folder_id int,
folder_name char(32),
parent_folder_id int,
ffss_id int,
foreign key (parent_folder_id, ffss_id) references FFOLDERS(o_id, fs_id) on update cascade on delete cascade
);
create or replace table FFILES
(
o_id int,
fs_id int,
primary key(o_id, fs_id),
foreign key(o_id, fs_id) references OBJECTS(o_id, fs_id) on update cascade on delete cascade,

ffile_id int,
ffile_name char(32),
full_path char(1024)
);

insert into FILE_SYSTEM values (13, 'MyOS');
insert into FILE_SYSTEM values (999, 'EmptyOS');
insert into SUBJECTS values (1, 13, 'Program.exe', 'exe');
insert into SUBJECTS values (5, 13, 'Pasha', 'Administrator');
insert into SUBJECTS values (6, 13, 'Sasha', 'Moderator');
insert into SUBJECTS values (7, 13, 'Masha', 'User');
insert into SUBJECTS values (8, 13, 'Dasha', 'User');
insert into SUBJECTS values (9, 13, 'Slava', 'User');

insert into OBJECTS values (5, 13, 'Pasha', 'Administrator');
insert into OBJECTS values (6, 13, 'Sasha', 'Moderator');
insert into OBJECTS values (7, 13, 'Masha', 'User');
insert into OBJECTS values (8, 13, 'Dasha', 'User');
insert into OBJECTS values (9, 13, 'Slava', 'User');
insert into OBJECTS values (1, 13, 'Program.exe', 'exe');
insert into OBJECTS values (2, 13, 'Readme.txt', 'txt');
insert into OBJECTS values (3, 13, 'RootFolder', 'folder');
insert into OBJECTS values (4, 13, 'UsersFolders', 'folder');
insert into OBJECTS values (10, 13, 'PashaFolder', 'folder');
insert into OBJECTS values (11, 13, 'SashaFolder', 'folder');
insert into OBJECTS values (12, 13, 'MashaFolder', 'folder');
insert into OBJECTS values (13, 13, 'DashaFolder', 'folder');
insert into OBJECTS values (14, 13, 'SlavaFolder', 'folder');
insert into OBJECTS values (15, 13, 'script.py', 'py');
insert into OBJECTS values (16, 13, 'mod.bat', 'bat');
insert into OBJECTS values (17, 13, 'report.docx', 'docx');
insert into OBJECTS values (18, 13, 'gg.bin', 'bin');

insert into AACCESS_RIGHTS values (10305, 'read', 1, 3, 13, 13);
insert into AACCESS_RIGHTS values (10304, 'write', 1, 3, 13, 13);
insert into AACCESS_RIGHTS values (10405, 'read', 1, 4, 13, 13);
insert into AACCESS_RIGHTS values (10404, 'write', 1, 4, 13, 13);
insert into AACCESS_RIGHTS values (10205, 'read', 1, 2, 13, 13);
insert into AACCESS_RIGHTS values (10204, 'write', 1, 2, 13, 13);
insert into AACCESS_RIGHTS values (50301, 'full', 5, 3, 13, 13);
insert into AACCESS_RIGHTS values (60302, 'special', 6, 3, 13, 13);
insert into AACCESS_RIGHTS values (701205, 'read', 7, 12, 13, 13);
insert into AACCESS_RIGHTS values (701204, 'read', 7, 12, 13, 13);
insert into AACCESS_RIGHTS values (801303, 'modify', 8, 13, 13, 13);
insert into AACCESS_RIGHTS values (801304, 'write', 8, 13, 13, 13);
insert into AACCESS_RIGHTS values (901403, 'modify', 9, 14, 13, 13);
insert into AACCESS_RIGHTS values (901404, 'write', 9, 14, 13, 13);

insert into FFOLDERS values (3, 13, 3, 'RootFolder', 3, 13);
insert into FFOLDERS values (4, 13, 4, 'UsersFolders', 3, 13);
insert into FFOLDERS values (10, 13, 10, 'PashaFolder', 4, 13);
insert into FFOLDERS values (11, 13, 11, 'SashaFolder', 4, 13);
insert into FFOLDERS values (12, 13, 12, 'MashaFolder', 4, 13);
insert into FFOLDERS values (13, 13, 13, 'DashaFolder', 4, 13);
insert into FFOLDERS values (14, 13, 14, 'SlavaFolder', 4, 13);

insert into FFILES values (1, 13, 1, 'Program.exe', 'RootFolder\Program.exe');
insert into FFILES values (2, 13, 2, 'Readme.txt', 'RootFolder\UsersFolders\SlavaFolder\Readme.txt');
insert into FFILES values (15, 13, 15, 'script.py', 'RootFolder\UsersFolders\PashaFolder\script.py');
insert into FFILES values (16, 13, 16, 'mod.bat', 'RootFolder\UsersFolders\SashaFolder\mod.bat');
insert into FFILES values (17, 13, 17, 'report.docx', 'RootFolder\UsersFolders\MashaFolder\report.docx');
insert into FFILES values (18, 13, 18, 'gg.bin', 'RootFolder\UsersFolders\DashaFolder\gg.bin');
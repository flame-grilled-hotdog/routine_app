create table tb_goal_mt(
 gid TEXT NOT NULL CHECK (length(gid) <= 7),
 title TEXT NOT NULL CHECK (length(title) <= 20),
 descrip TEXT,
 times INTEGER,
 frequency TEXT NOT NULL CHECK (length(frequency) <= 1),
 term INTEGER,
 stime DATETIME,
 etime DATETIME);

create table tb_achievement_mt(
 aid TEXT NOT NULL CHECK (length(aid) <= 7),
 gid TEXT NOT NULL CHECK (length(gid) <= 7),
 utime DATETIME,
 achieve_flg INTEGER);


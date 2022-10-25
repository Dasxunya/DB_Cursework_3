--Имя магазина(1)
create table Shop_Type
(
    ID   serial primary key,
    Name varchar(20) not null
);

--Имя адреса(2)
create table Address
(
    ID   serial primary key,
    Name varchar(100) not null,
    City varchar(50) not null,
    Phone varchar(11) not null
);

--Информация о магазине(3)
create table Shop
(
    ID           serial primary key,
    Name         varchar(100)                                                     not null,
    Address_ID   integer references Address on delete cascade on update cascade   not null,
    Shop_Type_ID integer references Shop_Type on delete cascade on update cascade not null
);

--Жанр игры(4)
create table Game_Genre
(
    ID   serial primary key,
    Name varchar(100) not null
);

--Тема игры(5)
create table Game_Theme
(
    ID   serial primary key,
    Name varchar(100) not null
);

--Категория игры(6)
create table Game_Mechanics
(
    ID   serial primary key,
    Name varchar(100) not null
);
--Создатель игры (7)
create table Game_Publisher
(
    ID      serial primary key,
    Name    varchar(100) not null,
    Country varchar(20)  not null
);

--Настольная игра(8)
create table Board_Game
(
    ID                  serial primary key,
    Name                varchar(100)                                                           not null,
    Genre_ID            integer references Game_Genre on delete restrict on update cascade     not null,
    Image               text                                                                   not null,
    Video               text,
    Description         text                                                                   not null,
    Max_Players         integer check ( Max_Players > 0 )                                      not null,
    Min_Players         integer check ( Min_Players > 0 )                                      not null,
    Recommended_Players integer check ( Recommended_Players > 0 )                              not null,
    Min_Playtime        integer check ( Min_Playtime > 0 )                                     not null,
    Max_Playtime        integer check ( Max_Playtime > 0 )                                     not null,
    Year_Publish        integer check (Year_Publish > 1970 and
                                       Year_Publish < 2100 )                                   not null,
    Designers           varchar(100),
    Min_Age             integer check (Min_Age >= 0)                                           not null,
    Max_Age             integer check (Max_Age >= 0)                                           not null,
    Mechanics_ID        integer references Game_Mechanics on delete restrict on update cascade not null,
    Difficultness       real check (Difficultness >= 0 and Difficultness <= 10)                not null,
    Weight              integer check ( Weight > 0 )                                           not null,
    Wishlist            integer check (Board_Game.Wishlist >= 0)                               not null,
    Own                 integer check (Own >= 0)                                               not null,
    Publisher           integer references Game_Publisher on delete restrict on update cascade not null
);

--Связь-Игра-Категория(9)
create table Game_to_Theme
(
    Board_ID integer references Board_Game on delete restrict on update cascade not null,
    Theme_ID integer references Game_Theme on delete restrict on update cascade not null,
    primary key (Board_ID, Theme_ID)
);

--Роль Пользователя(10)
create table User_Role
(
    ID   serial primary key,
    Name varchar(20) not null
);

--Пользователь(11)
create table Users
(
    ID              serial primary key,
    Login           varchar(20)                                                       not null,
    Hashed_Password varchar(16)                                                       not null,
    Mail            varchar(320)                                                      not null,
    Wants_Mailing   boolean                                                           not null,
    Salt            varchar(15)                                                       not null,
    User_Role       integer references User_Role on delete restrict on update cascade not null
);

--Комментарии к игре(12)
create table Game_Comment
(
    ID      serial primary key,
    Game_ID integer references Board_Game on delete restrict on update cascade not null,
    User_ID integer references Users on delete restrict on update cascade      not null,
    Date    timestamp default current_timestamp                                not null,
    Content text                                                               not null
);

--Сущность-Игра-магазин(13)
create table Game_to_Shop
(
    Game_ID integer references Board_Game on delete restrict on update cascade not null,
    Shop_ID integer references Shop on delete restrict on update cascade       not null,
    Price   real check (Price >= 0)                                            not null,
    primary key (Game_ID, Shop_ID)
);

--Тема Форума(14)
create table Forum_Topic
(
    ID   serial primary key,
    Name varchar(100) not null
);

--Комментарии темы(15)
create table Topic_Comment
(
    ID       serial primary key,
    Forum_ID integer references Forum_Topic on delete restrict on update cascade not null,
    User_ID  integer references Users on delete restrict on update cascade        not null,
    Date     timestamp default current_timestamp                                  not null,
    Content  text                                                                 not null
);

--Ассоциация-Корзина-Игра(16)
create table Carts_of_Users
(
    User_ID     integer references Users on delete restrict on update cascade      not null,
    Game_ID     integer references Board_Game on delete restrict on update cascade not null,
    Date_of_add timestamp default current_timestamp not null,
    Date_of_buy timestamp,
    primary key (User_ID, Game_ID)
);

--Ассоциация-Фавориты-Игры(17)
create table Favorites_of_Users
(
    User_ID     integer references Users on delete restrict on update cascade      not null,
    Game_ID     integer references Board_Game on delete restrict on update cascade not null,
    Date_of_add timestamp default current_timestamp not null
);

--Связь-Пользователи-Темы(18)
create table Users_Fav_Forums
(
    User_ID  integer references Users on delete restrict on update cascade       not null,
    Forum_ID integer references Forum_Topic on delete restrict on update cascade not null,
    primary key (User_ID, Forum_ID)
);

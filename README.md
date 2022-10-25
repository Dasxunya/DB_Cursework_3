# DB_Cursework_3
Реализовать даталогическую модель в реляционной СУБД PostgreSQL:

* Создать необходимые объекты базы данных.
* Заполнить созданные таблицы тестовыми данными.
* Сделать скрипты для:
  * создания/удаления объектов базы данных;
  * заполнения/удаления созданных таблиц.
* Обеспечить целостность данных при помощи средств языка DDL.
* Добавить в базу данных триггеры для обеспечения комплексных ограничений
целостности.
* Реализовать функции и процедуры на основе описания бизнес-процессов (из этапа
№1).
* Произвести анализ использования созданной базы данных:
  * выявить наиболее часто используемые запросы к объектам базы данных;
  * результаты представить в виде текстового описания. 
# ER-модель

```mermaid
erDiagram
Board_Game ||--o{ Favorites_of_Users : Game_ID
    Board_Game {
    serial ID        
    varchar Name            
    integer Genre_ID     
    varchar Image            
    varchar Video           
    varchar Description  
    integer Max_Players    
    integer Min_Players         
    integer Recommended_Players 
    integer Min_Playtime     
    integer Max_Playtime        
    integer Year_Publish       
    varchar Designers          
    integer Min_Age            
    integer Max_Age             
    integer Mechanics_ID        
    integer Difficultness       
    integer Weight
    integer Wishlist  
    integer Own   
    integer Publisher
    }
    Users ||--o{ Favorites_of_Users : User_ID
    Favorites_of_Users {
    integer User_ID
    integer Game_ID
    timestamp Date_off_add
    }
    Users {
    serial ID             
    integer Favorite_Forums
    varchar Login          
    varchar Hashed_Password
    varchar Mail           
    boolean Wants_Mailing  
    varchar Salt           
    integer User_Role      
    }
    Board_Game ||--|{ Game_to_Shop : Game_ID
    Shop ||--|{ Game_to_Shop : Shop_ID
    Shop {
    serial ID
    varchar Name
    integer Address_ID
    integer Shop_Type_ID
    }
    Game_to_Shop {
    integer Game_ID 
    integer Shop_ID 
    real Price
    }
    Users ||--o{ Carts_of_Users : User_ID
    Board_Game ||--o{ Carts_of_Users : Game_ID
    Carts_of_Users{
    integer User_ID
    integer Game_ID
    timestamp Date_off_add
    timestamp Date_off_buy
    }
    Game_Publisher ||--|| Board_Game : Publisher_ID
    Game_Publisher {
    serial ID
    varchar Country
    varchar Name
    }
    Game_Mechanic ||--|| Board_Game : Mechanic_ID
    Game_Mechanic {
    serial ID
    varchar Name
    }
    Game_Theme ||--o{ Game_to_Theme : Theme_ID
    Board_Game ||--o{ Game_to_Theme : Game_ID
    Game_Theme {
    serial ID
    varchar Name
    }
    Address }|--|| Shop : Address_ID
    Address {
    serial ID
    varchar Name
    }
    Shop_Type ||--|| Shop : Shop_Type_ID
    Shop_Type {
    serial ID
    varchar Name
    }
    Game_Genre ||--|| Board_Game : Game_ID
    Game_Genre {
    serial ID
    varchar Name
    }
    Board_Game ||--o{ Game_Comment : Game_ID
    Users ||--o{ Game_Comment : User_ID
    Game_Comment{
    serial ID
    integer Game_ID
    integer User_ID
    timestamp Date
    text Content
    }
    Users_Fav_Forums }o--|| Forum_Topic : Forum_ID
    Users_Fav_Forums }o--|| Users : User_ID
    Forum_Topic {
    serial ID
    varchar Name
    }
    Topic_Comment }o--|| Forum_Topic : Forum_ID
    Topic_Comment }o--|| Users : User_ID
    Topic_Comment {
    serial ID
    integer Forum_ID
    integer User_ID
    timestamp Date
    text Content    
    }
    User_Role ||--|| Users : User_ID
    User_Role{
    serial ID
    varchar Name
    }
```
  

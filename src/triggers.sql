--Триггер на максимальное количество любимых форумов (10)
create or replace function LovedForums() returns trigger as
$$
begin
    if (select count(forum_id) from users_fav_forums group by user_id) > 10
    then
delete
from users_fav_forums
where user_id = new.user_id
  and forum_id = new.forum_id;
raise exception 'Превышено максимальное количество избранных форумов';
end if;
end;
$$ language plpgsql;

drop trigger if exists "CheckLovedForums" on users_fav_forums;
create trigger CheckLovedForums
    after insert
    on users_fav_forums
    for each row
    execute procedure LovedForums();
    
--Сделать магазины сети VIP
CREATE OR REPLACE FUNCTION ChangeAllShopsStatus() RETURNS TRIGGER AS
$$
begin
    update Shop set Shop_Type_ID = new.Shop_Type_ID where Name = new.Name;
    return null;
end;
$$ LANGUAGE plpgsql;

--Триггер на изменения магазина на VIP или обратно на стандарт
DROP TRIGGER IF EXISTS "ShopUpdated" ON Shop;
CREATE TRIGGER ShopUpdated
    AFTER UPDATE
    ON Shop
    FOR EACH ROW WHEN ((OLD.Shop_Type_ID) IS DISTINCT FROM (NEW.Shop_Type_ID))
EXECUTE PROCEDURE ChangeAllShopsStatus();

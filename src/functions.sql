--Подсчет количества различных игр на сайте
create or replace function different_board_count() returns integer as $$
declare
    cnt integer;
begin
    select count(id) into cnt from board_game;
    return cnt;
end;
$$ language plpgsql;

--Проверить наличие дешевых игр
create or replace function cheap_board_game() returns integer as $$
declare
    cnt integer;
begin
    select count(id) into cnt from board_game
        join game_to_shop on board_game.id = game_to_shop.game_id
                              where game_to_shop.price<500;
    return cnt;
end;
$$ language plpgsql;

--Триггер на максимальное количество любимых форумов (10)
DROP TRIGGER IF EXISTS "CheckLovedForums" ON users_fav_forums;
CREATE TRIGGER CheckLovedForums
    AFTER INSERT
    ON users_fav_forums
    FOR EACH ROW
EXECUTE PROCEDURE LovedForums();


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
--TODO: Оно хотело бы жить, но пока не может
CREATE OR REPLACE FUNCTION LovedForums() RETURNS TRIGGER AS
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
$$ LANGUAGE plpgsql;

--Триггер на максимальное количество любимых форумов (10)
DROP TRIGGER IF EXISTS "CheckLovedForums" ON users_fav_forums;
CREATE TRIGGER CheckLovedForums
    AFTER INSERT
    ON users_fav_forums
    FOR EACH ROW
EXECUTE PROCEDURE LovedForums();
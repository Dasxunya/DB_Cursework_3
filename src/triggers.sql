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
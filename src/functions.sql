create or replace function different_board_count() returns integer as $$
declare
    cnt integer;
begin
    select count(id) into cnt from board_game;
    return cnt;
end;
$$ language plpgsql;


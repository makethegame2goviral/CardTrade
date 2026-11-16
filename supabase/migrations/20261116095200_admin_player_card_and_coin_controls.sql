create or replace function public.admin_remove_player_card(p_user_id uuid, p_card_id uuid)
returns void
language plpgsql
security definer
set search_path = ''
as $function$
begin
  if auth.uid() is null or not public.is_cardsnoscam_admin() then
    raise exception 'Nur der Admin darf Spielerkarten entfernen.';
  end if;

  delete from public.inventory
  where user_id = p_user_id and card_id = p_card_id;

  if not found then
    raise exception 'Diese Karte wurde beim Spieler nicht gefunden.';
  end if;
end;
$function$;

revoke all on function public.admin_remove_player_card(uuid, uuid) from public;
grant execute on function public.admin_remove_player_card(uuid, uuid) to authenticated;

create or replace function public.admin_set_player_coins(p_user_id uuid, p_balance numeric)
returns void
language plpgsql
security definer
set search_path = ''
as $function$
begin
  if auth.uid() is null or not public.is_cardsnoscam_admin() then
    raise exception 'Nur der Admin darf Coin-Kontostände ändern.';
  end if;

  if p_balance is null or p_balance < 0 or p_balance > 1000000000 or p_balance <> trunc(p_balance) then
    raise exception 'Der Coin-Kontostand muss eine ganze Zahl zwischen 0 und 1.000.000.000 sein.';
  end if;

  update public.wallets
  set balance = p_balance,
      last_income_at = now()
  where user_id = p_user_id;

  if not found then
    raise exception 'Spieler-Wallet nicht gefunden.';
  end if;
end;
$function$;

revoke all on function public.admin_set_player_coins(uuid, numeric) from public;
grant execute on function public.admin_set_player_coins(uuid, numeric) to authenticated;

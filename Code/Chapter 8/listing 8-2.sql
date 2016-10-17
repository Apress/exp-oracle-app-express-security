declare
    v varchar2(255) := null;
    c owa_cookie.cookie;
begin
   c := owa_cookie.get('LOGIN_USERNAME_COOKIE');
   :P101_USERNAME := c.vals(1);
exception when others then null;
end;
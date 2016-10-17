begin
owa_util.mime_header('text/html', FALSE);
owa_cookie.send(
    name=>'LOGIN_USERNAME_COOKIE',
    value=>lower(:P101_USERNAME));
exception when others then null;
end;
FROM openresty/openresty:jessie
RUN luarocks install luajson
RUN luarocks install uuid

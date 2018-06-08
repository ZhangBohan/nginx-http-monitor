# nginx-http-monitor

开发过程中后端与客户端之前接口请求沟通成本过高，双方需要多次确认信息且很可能得到错误的信息，基于该痛点开发了`nginx-http-monitor`

例如客户端请求如下：

```bash
> http :8080/abc\?x\=2\&y\=z a=b c=d

HTTP/1.1 200 OK
Connection: keep-alive
Content-Type: text/html
Date: Fri, 08 Jun 2018 08:33:18 GMT
Server: openresty/1.13.6.1
Transfer-Encoding: chunked
X-Request-Id: ae914284924fc345be45871798433dac

POST /abc x=2&y=z

```

会在返回头中生成`X-Request-Id`做为唯一ID，同时nginx日志会记录该HTTP请求的请求体和响应，日志中JSON中包含请求和响应信息

```bash
nginx_1  | 2018/06/08 08:33:18 [crit] 5#5: *1 [lua] request_logger.lua:35: {"response":{"time":1528446798.089,"body":"POST \/abc x=2&y=z\n","headers":{"connection":"close","content-type":"text\/html","x-request-id":"ae914284924fc345be45871798433dac","transfer-encoding":"chunked"},"status":200,"duration":"0.001"},"request":{"host":"localhost","body":"{\"a\": \"b\", \"c\": \"d\"}","uri":"\/abc","post_args":{"{\"a\": \"b\", \"c\": \"d\"}":true},"method":"POST","headers":{"host":"localhost:8080","content-length":"20","accept-encoding":"gzip, deflate","user-agent":"HTTPie\/0.9.3","accept":"application\/json","content-type":"application\/json","connection":"keep-alive"},"get_args":{"y":"z","x":"2"},"time":1528446798.088}} while logging request, client: 172.18.0.1, server: , request: "POST /abc?x=2&y=z HTTP/1.1", upstream: "http://127.0.0.1:8081/abc?x=2&y=z", host: "localhost:8080"
```

参考：

- [Request Capturing using NGINX and Lua](http://tarunlalwani.com/post/request-capturing-nginx-lua/)
- [How to add a response header on nginx when using proxy_pass?](https://stackoverflow.com/a/16308982/1852409)
- [Nginx Unique Tracing ID](https://www.jianshu.com/p/5e103e1eb017)
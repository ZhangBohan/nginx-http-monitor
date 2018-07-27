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
{"request_id":"e695b09d9351ccfb231dba8486b54db7","uri":"\/","method":"GET","response":{"time":1532686982.319,"body":"GET \/ \n","headers":{"connection":"close","content-type":"text\/html","x-request-id":"e695b09d9351ccfb231dba8486b54db7","transfer-encoding":"chunked"},"status":200,"duration":"0.000"},"request":{"host":"localhost","uri":"\/","post_args":{},"method":"GET","headers":{"host":"localhost:8080","accept-language":"zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7,ja;q=0.6","accept-encoding":"gzip, deflate, br","user-agent":"Mozilla\/5.0 (Macintosh; Intel Mac OS X 10_13_1) AppleWebKit\/537.36 (KHTML, like Gecko) Chrome\/67.0.3396.99 Safari\/537.36","connection":"keep-alive","accept":"text\/html,application\/xhtml+xml,application\/xml;q=0.9,image\/webp,image\/apng,*\/*;q=0.8","cache-control":"max-age=0","upgrade-insecure-requests":"1"},"get_args":{},"time":1532686982.319},"host":"localhost"}
{"request_id":"bc49e82f84ec4bb26174d53005d53fec","uri":"\/favicon.ico","method":"GET","response":{"time":1532686982.637,"body":"GET \/favicon.ico \n","headers":{"connection":"close","content-type":"text\/html","x-request-id":"bc49e82f84ec4bb26174d53005d53fec","transfer-encoding":"chunked"},"status":200,"duration":"0.000"},"request":{"host":"localhost","uri":"\/favicon.ico","post_args":{},"method":"GET","headers":{"host":"localhost:8080","connection":"keep-alive","cache-control":"no-cache","referer":"http:\/\/localhost:8080\/","pragma":"no-cache","user-agent":"Mozilla\/5.0 (Macintosh; Intel Mac OS X 10_13_1) AppleWebKit\/537.36 (KHTML, like Gecko) Chrome\/67.0.3396.99 Safari\/537.36","accept-language":"zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7,ja;q=0.6","accept-encoding":"gzip, deflate, br","accept":"image\/webp,image\/apng,image\/*,*\/*;q=0.8"},"get_args":{},"time":1532686982.637},"host":"localhost"}
```

参考：

- [Request Capturing using NGINX and Lua](http://tarunlalwani.com/post/request-capturing-nginx-lua/)
- [How to add a response header on nginx when using proxy_pass?](https://stackoverflow.com/a/16308982/1852409)
- [Nginx Unique Tracing ID](https://www.jianshu.com/p/5e103e1eb017)
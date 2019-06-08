##
网页登陆某一个网站, 要填写登陆信息, 然后登陆上  
怎样在curl中登陆?  
打开登陆网页, 按f12(打开调试)  
填上登陆信息登陆, 然后看network, headers  
general 中有: request url, request method)  
form data 中有 username, password  
curl -X POST -d "username=lj-wangjie&password=8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92" http://ecg-java-test.landmind.cn/user/login/  

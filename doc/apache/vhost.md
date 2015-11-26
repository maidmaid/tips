Add dev vhosts 
--------------

In ``C:\WINDOWS\system32\drivers\etc\hosts`` file :

```
127.0.0.1   project.dev
```

In ``httpd.conf`` file :

```
NameVirtualHost project.dev
<VirtualHost project.dev>     
    DocumentRoot C:/EasyPHP/data/localweb/project
    ServerName project.dev
</VirtualHost>
```
Add dev vhosts 
--------------

In ``C:\WINDOWS\system32\drivers\etc\hosts`` (WIN) or ``/etc/hosts`` (LNX) file :

```
127.0.0.1   project.dev
```

In ``httpd.conf`` (WIN) or ``/etc/apache2/sites-available/001-project.conf`` (LNX) file :

```
NameVirtualHost project.dev
<VirtualHost project.dev>     
    DocumentRoot C:/EasyPHP/data/localweb/project
    ServerName project.dev
</VirtualHost>
```

On Linux, enable config :
```
sudo a2ensite 001-project.conf
```

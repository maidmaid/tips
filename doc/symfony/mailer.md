Mailer
======

config with swisscenter.com:

```yml
# app/config/parameters.yml
parameters:
    mailer_transport: smtp
    mailer_port: 587
    mailer_encryption: tls
    mailer_host: mail01.swisscenter.com
    mailer_user: test1@digital-play.ch
    mailer_password: ~
```

```yml
# app/config/config.yml
swiftmailer:
    transport:  "%mailer_transport%"
    host:       "%mailer_host%"
    port:       "%mailer_port%"
    encryption: "%mailer_encryption%"
    username:   "%mailer_user%"
    password:   "%mailer_password%"
    spool:      { type: memory }
```

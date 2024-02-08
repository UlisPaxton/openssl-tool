# openssl-tool
Инструмент генерации сертификатов на основе openssl. Изначально предназначен для удобного выпуска SSL-сертификатов для Nginx.
### Перед использованием ОБЯЗАТЕЛЬНО настройте значения необходимых полей в шаблоне /templates/openssl.conf.j2
  
  ### Генерация корневого сертификата:
  ```make ca```   
  Внимание!!! Храните файл root.key в безопасном месте.
  
 ### Генерация закрытого ключа и запроса на подписание сертификата:
 ```make csr_only fqdn=ya.ru```   
 Требуется обязательный параметр fqdn для указания доменного имени web-ресурса, для которого выпускается закрытый ключ и запрос на подписание сертификата.
  
 ### Генерация закрытого ключа, запроса на подписание сертификата(csr) и выпуск сертификата, подписанного корневым сертификатом.
 ```make sign fqdn=ya.ru```   

 ### Копирует все связанные файлы(key, csr, crt openssl.conf) на указанный сервер в домашнюю папку пользователя
 ```make distribute user=<remote_ssh_user> fqdn=<server_address>```
  
### Устанавливает зависимости, необходимые для работы.
```apt install make```  
```make dependencies```
  

default:
	# make ca
	# 	генерит корневой серт
	#
	# make csr_only fqdn=ya.ru
	# 	генерит запрос на подписание серта
	#
	# make sign fqdn=ya.ru
	# 	генерит csr и подписывает корневым сертом ca.crt
	#
	# make distribute user=<remote_ssh_user> fqdn=<сервер>
	# 	складывает закрытый ключ, сертификат, csr и конфиг openssl в домашнюю папку <remote_ssh_user> на сервере fqdn

ca:
	#openssl req -newkey rsa:2048 -nodes -keyout ca.key -x509 -days 3654 -out ca.crt -config ./openssl.conf -batch
	openssl req -x509 -new -nodes -keyout root.key -out root.crt -config ./openssl.conf -batch

csr_only:  # пераметр fqdn обязательно
	python3 generate_config.py $(fqdn)
	openssl req -config $(fqdn).ssl.conf -out $(fqdn).csr -new -newkey rsa:2048 -nodes -keyout $(fqdn).key -batch

sign:  #пераметр fqdn обязательно
	python3 generate_config.py $(fqdn)
	openssl req -new -nodes -keyout $(fqdn).key -out $(fqdn).csr -config $(fqdn).ssl.conf -batch

	openssl x509 -req -in $(fqdn).csr -CA root.crt -CAkey root.key -CAcreateserial -out $(fqdn).crt -days 365 -extensions req_ext -extfile $(fqdn).ssl.conf
	mkdir $(fqdn) & mv $(fqdn)* ./$(fqdn)/

distribute:  # пераметры user, fqdn обязательно
	scp $(fqdn)/$(fqdn).* $(user)@$(fqdn):/home/$(user)/

dependencies:
	apt install python3-pip
	pip3 install jinja2

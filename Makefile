build:
	docker build -t ccnmtl/django.base -f django.base .
	docker build -t ccnmtl/django.build -f django.build .
	docker build -t ccnmtl/hugo.base -f hugo.base .

push:
	docker push ccnmtl/django.base
	docker push ccnmtl/django.build
	docker push ccnmtl/hugo.base

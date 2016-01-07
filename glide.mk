info:
	@echo info

export GO15VENDOREXPERIMENT=1

bootstrap:
	${DEV_CMD} glide install

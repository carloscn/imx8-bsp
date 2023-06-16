.PHONY: clean distclean

linux:
	bash build_linux.sh

uboot:
	bash build_uboot.sh

atf: uboot-imx/u-boot.bin
	bash build_atf.sh

optee-os:
	bash build_optee_os.sh

optee-client:
	bash build_optee_client.sh

optee-test:
	bash build_optee_test.sh

optee-example:
	bash build_optee_example.sh

uuc:
	bash build_uuc.sh
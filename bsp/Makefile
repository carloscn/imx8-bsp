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

firmware:
	bash build_firmware.sh

image:
	bash build_mkimage.sh

burn:
	sudo dd if=./imx-mkimage/iMX8QM/flash.bin of=${DEV} bs=1k seek=32 conv=fsync && sync

clean:
	rm -rf firmware-imx-8.1.bin firmware-imx-8.1

distclean:
	rm -rf firmware-imx-8.1 imx-atf imx-mkimage
	rm -rf imx-optee-client imx-optee-os imx-uuc
	rm -rf imx-optee-test optee_examples linux-imx scfw uboot-imx
	rm -rf *.tar.gz *.bin
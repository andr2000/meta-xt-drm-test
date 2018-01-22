DEPENDS += "u-boot-mkimage-native"

IMAGE_INSTALL_append = " \
    packagegroup-xt-core-xen \
    packagegroup-xt-core-guest-addons \
    domd-install-artifacts \
    domu-install-artifacts \
"

generate_uboot_image() {
    ${STAGING_BINDIR_NATIVE}/uboot-mkimage -A arm64 -O linux -T ramdisk -C gzip -n "uInitramfs" \
        -d ${DEPLOY_DIR_IMAGE}/${IMAGE_LINK_NAME}.cpio.gz ${DEPLOY_DIR_IMAGE}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.cpio.gz.uInitramfs
    ln -sfr  ${DEPLOY_DIR_IMAGE}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.cpio.gz.uInitramfs ${DEPLOY_DIR_IMAGE}/uInitramfs
}

IMAGE_POSTPROCESS_COMMAND += " generate_uboot_image;"

IMAGE_ROOTFS_SIZE = "65535"


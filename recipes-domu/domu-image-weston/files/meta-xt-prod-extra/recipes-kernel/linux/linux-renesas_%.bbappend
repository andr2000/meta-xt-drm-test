FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

require inc/xt_shared_env.inc

RENESAS_BSP_URL = "git://github.com/andr2000/linux.git"

BRANCH = "drm_pre_v0_drm_next"
SRCREV = "${AUTOREV}"
SRC_URI_append = " \
    file://defconfig \
"

DEPLOYDIR="${XT_DIR_ABS_SHARED_BOOT_DOMU}"

do_deploy_append() {
    find ${D}/boot -iname "vmlinux*" -exec tar -cJvf ${STAGING_KERNEL_BUILDDIR}/vmlinux.tar.xz {} \;
}


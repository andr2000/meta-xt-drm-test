FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
FILESEXTRAPATHS_prepend := "${THISDIR}/../../inc:"
FILESEXTRAPATHS_prepend := "${THISDIR}/../../recipes-domx:"

#do_fetch[depends] += "domu-image-weston:do_${BB_DEFAULT_TASK}"

SRC_URI = " \
    repo://github.com/andr2000/manifests;protocol=https;branch=pv_devel;manifest=prod_pv_devel/domd.xml;scmdata=keep \
"

XT_QUIRK_UNPACK_SRC_URI += " \
    file://meta-xt-prod-extra;subdir=repo \
    file://meta-xt-prod-vgpu;subdir=repo \
    file://xt_shared_env.inc;subdir=repo/meta-xt-prod-extra/inc \
"

XT_QUIRK_BB_ADD_LAYER += " \
    meta-xt-prod-extra \
    meta-xt-prod-vgpu \
"

XT_BB_IMAGE_TARGET = "core-image-weston"

################################################################################
# Renesas R-Car
################################################################################

XT_QUIRK_PATCH_SRC_URI_rcar = "\
    file://${S}/meta-renesas/meta-rcar-gen3/docs/sample/patch/patch-for-linaro-gcc/0001-rcar-gen3-add-readme-for-building-with-Linaro-Gcc.patch;patchdir=meta-renesas \
"

XT_BB_LOCAL_CONF_FILE_rcar = "meta-xt-prod-extra/doc/local.conf.rcar-domd-image-weston"
XT_BB_LAYERS_FILE_rcar = "meta-xt-prod-extra/doc/bblayers.conf.rcar-domd-image-weston"

GLES_VERSION_rcar = "1.9"

configure_versions_rcar() {
    local local_conf="${S}/build/conf/local.conf"

    cd ${S}
    base_update_conf_value ${local_conf} PREFERRED_VERSION_xen "4.9.0+git\%"
    base_update_conf_value ${local_conf} PREFERRED_VERSION_u-boot_rcar "v2015.04\%"
    base_update_conf_value ${local_conf} PREFERRED_VERSION_gles-user-module ${GLES_VERSION}
    base_update_conf_value ${local_conf} PREFERRED_VERSION_gles-kernel-module ${GLES_VERSION}
    base_update_conf_value ${local_conf} PREFERRED_VERSION_gles-module-egl-headers ${GLES_VERSION}

    # HACK: force ipk instead of rpm b/c it makes troubles to PVR UM build otherwise
    base_update_conf_value ${local_conf} PACKAGE_CLASSES "package_ipk"

    # FIXME: normally bitbake fails with error if there are bbappends w/o recipes
    # which is the case for agl-demo-platform's recipe-platform while building
    # agl-image-weston: due to AGL's Yocto configuration recipe-platform is only
    # added to bblayers if building agl-demo-platform, thus making bitbake to
    # fail if this recipe is absent. Workaround this by allowing bbappends without
    # corresponding recipies.
    base_update_conf_value ${local_conf} BB_DANGLINGAPPENDS_WARNONLY "yes"

    # override console specified by default by the meta-rcar-gen3
    # to be hypervisor's one
    base_update_conf_value ${local_conf} SERIAL_CONSOLE "115200 hvc0"

    # set default timezone to Las Vegas
    base_update_conf_value ${local_conf} DEFAULT_TIMEZONE "US/Pacific"
}

python do_configure_append_rcar() {
    bb.build.exec_func("configure_versions_rcar", d)
}

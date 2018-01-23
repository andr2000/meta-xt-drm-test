LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=815ca599c9df247a0c7f619bab123dad"

SRCREV = "${AUTOREV}"
BRANCH = "master"
SRC_URI = "git://github.com/tomba/kmsxx.git;protocol=https;branch=${BRANCH}"

# Modify these as desired
PV = "1.0+git${SRCPV}"
SRCREV = "${AUTOREV}"

S = "${WORKDIR}/git"

DEPENDS = "libdrm pybind11 python3"
RDEPENDS_${PN} += "python3 python3-enum python3-selectors python3-ctypes python3-fcntl"

inherit cmake pkgconfig

EXTRA_OECMAKE = ""

FILES_${PN} = "\
    ${libdir}/python*/site-packages/pykms/* \
    ${bindir}/* \
"

do_install_append() {
    # libdrm-tests already provides the same
    rm ${D}/usr/bin/kmstest || true
}

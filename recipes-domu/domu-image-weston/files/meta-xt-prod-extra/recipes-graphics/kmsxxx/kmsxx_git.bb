LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=815ca599c9df247a0c7f619bab123dad"

SRCREV = "${AUTOREV}"
BRANCH = "master"
SRC_URI = "gitsm://github.com/andr2000/kmsxx.git;protocol=https;branch=${BRANCH}"

S = "${WORKDIR}/git"

DEPENDS = "libdrm python3"
RDEPENDS_${PN} += "python3 python3-enum python3-selectors python3-ctypes\
     python3-fcntl python3-argparse python3-core python3-textutils\
     python3-crypt\
"

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

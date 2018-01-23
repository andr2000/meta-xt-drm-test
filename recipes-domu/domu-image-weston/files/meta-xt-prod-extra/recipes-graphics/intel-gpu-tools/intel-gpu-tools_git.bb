LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING;md5=e4b3dd344780e0400593b21b115a6947"

BRANCH = "pv_drm/v4.9"
SRCREV = "${AUTOREV}"

SRC_URI = "git://github.com/andr2000/intel-gpu-tools.git;protocol=https;branch=${BRANCH}"

S = "${WORKDIR}/git"

DEPENDS = "kmod systemd cairo bison-native glib-2.0 flex-native libpciaccess libdrm procps libunwind"
RDEPENDS_${PN} = "bash"

inherit pkgconfig autotools gtk-doc

# Specify any options you want to pass to the configure script using EXTRA_OECONF:
EXTRA_OECONF = "--disable-amdgpu --disable-nouveau"

FILES_${PN} += " \
    ${libdir}/* \
"

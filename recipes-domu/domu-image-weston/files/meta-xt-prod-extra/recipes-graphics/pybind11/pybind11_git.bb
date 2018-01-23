LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://LICENSE;md5=9b27fac7e937323e3de9ca3a7db38e37"

HOMEPAGE = "https://github.com/pybind11/pybind11"
SUMMARY = "Seamless operability between C++11 and Python"

SRCREV = "${AUTOREV}"
BRANCH = "stable"

SRC_URI = "git://github.com/pybind/pybind11.git;protocol=https;branch=${BRANCH}"

S = "${WORKDIR}/git"

inherit setuptools3

# WARNING: the following rdepends are determined through basic analysis of the
# python sources, and might not be 100% accurate.
RDEPENDS_${PN} += "python-argparse python-core"

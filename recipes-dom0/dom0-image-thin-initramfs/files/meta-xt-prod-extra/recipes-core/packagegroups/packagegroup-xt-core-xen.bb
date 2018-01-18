SUMMARY = "Dom0 Xen components"

LICENSE = "MIT"

inherit packagegroup

RDEPENDS_packagegroup-xt-core-xen = "\
    xen-xencommons \
    xen-xenstat \
    xen-misc \
"

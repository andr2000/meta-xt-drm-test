SUMMARY = "Guest domain(s) scripts, configs etc."

LICENSE = "MIT"

inherit packagegroup

RDEPENDS_packagegroup-xt-core-guest-addons = "\
    guest-addons \
    guest-addons-run-domd \ 
    guest-addons-run-domu \ 
    guest-addons-run-vcpu_pin \ 
    guest-addons-run-set_root_dev \
"

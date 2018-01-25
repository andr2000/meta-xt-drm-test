FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
    file://0001-Convert-timers-to-use-timer_setup.patch \
    file://0002-dma-buf-Rename-dma-ops-to-prevent-conflict-with-kunm.patch \
    file://0003-Rework-drm_platform_init.patch \
    file://0004-Make-const-struct-dma_map_ops-dma_ops.patch \
"

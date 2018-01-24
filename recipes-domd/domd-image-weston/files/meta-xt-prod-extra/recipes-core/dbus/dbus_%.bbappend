FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

SRC_URI_append = " \
    file://display_manager.conf \
    file://dbus.service \
    file://dbus.socket \
    file://dbus_env.conf \
"

inherit systemd

do_install_append() {
    install -d ${D}${sysconfdir}/dbus-1/session.d
    install -m 0755 ${WORKDIR}/display_manager.conf ${D}${sysconfdir}/dbus-1/session.d/

    if [ "${PN}" != "nativesdk-dbus" ]; then
        if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
            install -m 644 -p -D ${WORKDIR}/dbus.service ${D}${systemd_user_unitdir}/dbus.service
            install -m 644 -p -D ${WORKDIR}/dbus.socket ${D}${systemd_user_unitdir}/dbus.socket
            install -m 644 -p -D ${WORKDIR}/dbus_env.conf ${D}${systemd_system_unitdir}/user@.service.d/dbus_env.conf

            # Execute these manually on behalf of systemctl script (from systemd-systemctl-native.bb)
            # because it does not support systemd's user mode.
            mkdir -p ${D}/etc/systemd/user/default.target.wants/
            ln -sf ${systemd_user_unitdir}/dbus.socket ${D}/etc/systemd/user/default.target.wants/dbus.socket
        fi
    fi
}

FILES_${PN} += " \
    ${datadir}/dbus-1/session.d/display_manager.conf \
    ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', '${systemd_user_unitdir}/dbus.*', '', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', '${systemd_system_unitdir}/user@.service.d/dbus_env.conf', '', d)} \
    "

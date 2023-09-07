depends() {
    echo systemd
    return 0
}

install() {                                                                     
    inst_simple "${moddir}/echo-here.service" "${systemdsystemunitdir}/echo-here.service"
    $SYSTEMCTL -q --root "$initdir" add-wants cryptsetup.target echo-here.service
}                                                                               

#!/sbin/sh

#	file containing the basic functions

file_getprop() {
    grep "^$2" "$1" | cut -d= -f2;
}

ui_print() {
    echo -ne "-  $1\n" > $OUTFD;
}

set_perm() {
    chown $1.$2 $4;
    chown $1:$2 $4;
    chmod $3 $4;
}

set_perm_recursive() {
    dirs=$(echo $* | awk '{ print substr($0, index($0,$5)) }');
    for i in $dirs; do
        chown -R $1.$2 $i; chown -R $1:$2 $i;
        find "$i" -type d -exec chmod $3 {} +;
        find "$i" -type f -exec chmod $4 {} +;
    done;
}

package_extract_file() {
    unzip -o "$ZIP" "$1/$2/*" -d /tmp;
}

package_extract_dir() {
    unzip -o "$ZIP" "$1/$2/*" -d /tmp;
    bkup_list=$'\n'"$(find /tmp/$1/$2 -type f | cut -d/ -f5-)${bkup_list}";
    cp -rf "/tmp/$1/$2/." /system/;
    rm -rf "/tmp/$1";
}

abort() {
    quit;
    ui_print " ";
    ui_print "Installer will now exit...";
    ui_print " ";
    ui_print "Error Code: $1";
    sleep 5;
    quit $1;
}

quit() {
    rm -rf /tmp/*;
    ui_print " ";
    ui_print "- Unmounting systems";
    ui_print " ";
    umount /system;
    exit $1;
}

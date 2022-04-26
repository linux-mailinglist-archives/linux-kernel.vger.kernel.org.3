Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E5950FD35
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350033AbiDZMl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349993AbiDZMlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:41:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC998930C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 05:38:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B5E8B1F380;
        Tue, 26 Apr 2022 12:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650976720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=DYVKwGEBJtCQ2qy8oNKcXogDcxj6DclNH922mKo91m0=;
        b=Sb7S/1oE3qfNMyFhXlRPFGDrILm9Jnh1u+sVC/55qDBt5uwvYvPg23ge1ZvbejwxHjMe7s
        tbTZBh62m0yoyV9FlDMt9/PzisgwzAVASHijBdkgQPJ2/2xa/qcow0cLsTavK3/wijQiXa
        xnWrAaJglCfSNQomVlgRC0ScMgA3kRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650976720;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=DYVKwGEBJtCQ2qy8oNKcXogDcxj6DclNH922mKo91m0=;
        b=vhJTHnpb/Dnd6LZxRyW3tHPlwc4sd3hAncAT4LQZ2sfqm2pGgTvSZ4qWcgwV8uyrSqs0Xx
        q7pP0mLCOZOozkAg==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 958C32C143;
        Tue, 26 Apr 2022 12:38:40 +0000 (UTC)
Date:   Tue, 26 Apr 2022 14:38:39 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev
Subject: ndctl tests usable?
Message-ID: <20220426123839.GF163591@kunlun.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

there is some testsuite included with ndctl, and when following the
instructions to build it most tests fail or are skipped:

[   95s] Ok:                 3   
[   95s] Expected Fail:      0   
[   95s] Fail:               5   
[   95s] Unexpected Pass:    0   
[   95s] Skipped:            15  
[   95s] Timeout:            0   

Is this the expected outcome or is this a problem with the ndctl build?

Attaching test run log.

Thanks

Michal

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="ndctl-test.log"
Content-Transfer-Encoding: quoted-printable

[    6s] /usr/bin/qemu-kvm -nodefaults -no-reboot -nographic -vga none -cpu=
 host -M pc,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff,vmport=3Doff -sandb=
ox on -bios /usr/share/qemu/qboot.rom -object rng-random,filename=3D/dev/ra=
ndom,id=3Drng0 -device virtio-rng-pci,rng=3Drng0 -object iothread,id=3Dio0 =
-runas qemu -net none -kernel /var/tmp/build-root/openSUSE_Tumbleweed-x86_6=
4/.mount/boot/kernel -initrd /var/tmp/build-root/openSUSE_Tumbleweed-x86_64=
/.mount/boot/initrd -append root=3D/dev/disk/by-id/virtio-0 rootfstype=3Dex=
t4 rootflags=3Dnoatime elevator=3Dnoop nmi_watchdog=3D0 rw oops=3Dpanic pan=
ic=3D1 quiet console=3Dhvc0 init=3D/.build/build -m 512 -drive file=3D/var/=
tmp/build-root/openSUSE_Tumbleweed-x86_64/img,format=3Draw,if=3Dnone,id=3Dd=
isk,cache=3Dunsafe -device virtio-blk-pci,iothread=3Dio0,drive=3Ddisk,seria=
l=3D0 -drive file=3D/var/tmp/build-root/openSUSE_Tumbleweed-x86_64/swap,for=
mat=3Draw,if=3Dnone,id=3Dswap,cache=3Dunsafe -device virtio-blk-pci,iothrea=
d=3Dio0,drive=3Dswap,serial=3D1 -device virtio-serial,max_ports=3D2 -device=
 virtconsole,chardev=3Dvirtiocon0 -chardev stdio,id=3Dvirtiocon0 -chardev s=
ocket,id=3Dmonitor,server=3Don,wait=3Doff,path=3D/var/tmp/build-root/openSU=
SE_Tumbleweed-x86_64/img.qemu/monitor -mon chardev=3Dmonitor,mode=3Dreadlin=
e -smp 2
[   10s] 2nd stage started in virtual machine=0D
[   10s] machine type: x86_64=0D
[   10s] Linux version: 5.17.4-1-default #1 SMP PREEMPT Wed Apr 20 07:43:03=
 UTC 2022 (75e9961)=0D
[   10s] Increasing log level from now on...=0D
[   10s] [    3.334615][  T350] sysrq: Changing Loglevel=0D
[   10s] [    3.334930][  T350] sysrq: Loglevel set to 4=0D
[   10s] Enable sysrq operations=0D
[   10s] Setting up swapspace version 1, size =3D 1024 MiB (1073737728 byte=
s)=0D
[   10s] no label, UUID=3D704fbe68-057e-4dc3-aaa3-3abe0367e831=0D
[   10s] swapon: /dev/vdb: found signature [pagesize=3D4096, signature=3Dsw=
ap]=0D
[   10s] swapon: /dev/vdb: pagesize=3D4096, swapsize=3D1073741824, devsize=
=3D1073741824=0D
[   10s] swapon /dev/vdb=0D
[   10s] WARNING: udev not running, creating extra device nodes=0D
[   10s] logging output to //.build.log...=0D
[   10s] processing recipe /.build-srcdir/ndctl-test.spec ...=0D
[   10s] init_buildsystem --configdir /.build/configs --cachedir /var/cache=
/build /.build-srcdir/ndctl-test.spec ...=0D
[   10s] initializing rpm db...=0D
[   10s] querying package ids...=0D
[   13s] [1/229] keeping compat-usrmerge-tools-84.87-5.6=0D
[   13s] [2/229] keeping crypto-policies-20210917.c9d86d1-1.5=0D
[   13s] [3/229] keeping file-magic-5.41-4.1=0D
[   13s] [4/229] keeping kernel-obs-build-5.17.4-1.1=0D
[   13s] [5/229] keeping libsemanage-conf-3.3-2.3=0D
[   13s] [6/229] keeping libssh-config-0.9.6-3.2=0D
[   13s] [7/229] keeping pkgconf-m4-1.8.0-1.6=0D
[   13s] [8/229] keeping python-rpm-macros-20220106.80d3756-1.4=0D
[   13s] [9/229] keeping system-user-root-20190513-2.3=0D
[   13s] [10/229] keeping vim-data-common-8.2.4745-2.1=0D
[   13s] [11/229] keeping filesystem-84.87-4.1=0D
[   13s] [12/229] keeping glibc-2.35-2.1=0D
[   13s] [13/229] keeping diffutils-3.8-79.7=0D
[   13s] [14/229] keeping fillup-1.42-276.9=0D
[   13s] [15/229] keeping libacl1-2.3.1-2.1=0D
[   13s] [16/229] keeping libalternatives1-1.2+3.b848aad-2.3=0D
[   13s] [17/229] keeping libapparmor1-3.0.4-6.1=0D
[   13s] [18/229] keeping libargon2-1-0.0+git20190520.62358ba-1.9=0D
[   13s] [19/229] keeping libatomic1-12.0.1+git192423-1.2=0D
[   13s] [20/229] keeping libattr1-2.5.1-1.17=0D
[   13s] [21/229] keeping libaudit1-3.0.6-4.1=0D
[   13s] [22/229] keeping libblkid1-2.37.4-1.1=0D
[   13s] [23/229] keeping libbrotlicommon1-1.0.9-1.7=0D
[   13s] [24/229] keeping libbz2-1-1.0.8-3.6=0D
[   13s] [25/229] keeping libcap-ng0-0.7.11-1.5=0D
[   13s] [26/229] keeping libcap2-2.64-1.1=0D
[   13s] [27/229] keeping libcom_err2-1.46.5-2.1=0D
[   13s] [28/229] keeping libcrypt1-4.4.27-1.4=0D
[   13s] [29/229] keeping libeconf0-0.4.5+git20220406.c9658f2-1.1=0D
[   13s] [30/229] keeping libexpat1-2.4.8-1.1=0D
[   13s] [31/229] keeping libffi8-3.4.2-1.5=0D
[   13s] [32/229] keeping libgcc_s1-12.0.1+git192423-1.2=0D
[   13s] [33/229] keeping libgdbm6-1.23-1.4=0D
[   13s] [34/229] keeping libgmp10-6.2.1-4.5=0D
[   13s] [35/229] keeping libgomp1-12.0.1+git192423-1.2=0D
[   13s] [36/229] keeping libgpg-error0-1.45-1.1=0D
[   13s] [37/229] keeping libiniparser1-4.1-1.14=0D
[   13s] [38/229] keeping libip4tc2-1.8.7-4.2=0D
[   13s] [39/229] keeping libitm1-12.0.1+git192423-1.2=0D
[   13s] [40/229] keeping libjson-c5-0.16-1.1=0D
[   13s] [41/229] keeping libkeyutils1-1.6.3-3.6=0D
[   13s] [42/229] keeping libltdl7-2.4.7-1.1=0D
[   13s] [43/229] keeping liblua5_4-5-5.4.4-2.1=0D
[   13s] [44/229] keeping liblz4-1-1.9.3-2.3=0D
[   13s] [45/229] keeping liblzma5-5.2.5-3.1=0D
[   13s] [46/229] keeping libmpdec3-2.5.1-2.6=0D
[   13s] [47/229] keeping libnghttp2-14-1.47.0-1.2=0D
[   13s] [48/229] keeping libnss_usrfiles2-2.27-3.5=0D
[   13s] [49/229] keeping libpcre1-8.45-1.5=0D
[   13s] [50/229] keeping libpcre2-8-0-10.40-1.1=0D
[   13s] [51/229] keeping libpkgconf3-1.8.0-1.6=0D
[   13s] [52/229] keeping libpopt0-1.18-2.21=0D
[   13s] [53/229] keeping libsasl2-3-2.1.28-1.3=0D
[   13s] [54/229] keeping libseccomp2-2.5.3-4.5=0D
[   13s] [55/229] keeping libsepol2-3.3-1.5=0D
[   13s] [56/229] keeping libsmartcols1-2.37.4-1.1=0D
[   13s] [57/229] keeping libtextstyle0-0.21-4.1=0D
[   13s] [58/229] keeping libudev1-250.4-5.1=0D
[   13s] [59/229] keeping libunistring2-1.0-1.1=0D
[   13s] [60/229] keeping libuuid1-2.37.4-1.1=0D
[   13s] [61/229] keeping libverto1-0.3.1-1.20=0D
[   13s] [62/229] keeping libyaml-0-2-0.2.5-1.7=0D
[   13s] [63/229] keeping libz1-1.2.11-19.1=0D
[   13s] [64/229] keeping libzstd1-1.5.2-1.3=0D
[   13s] [65/229] keeping patch-2.7.6-4.5=0D
[   13s] [66/229] keeping rzsz-0.12.21~rc-4.7=0D
[   13s] [67/229] keeping update-alternatives-1.21.1-1.1=0D
[   13s] [68/229] keeping libiniparser-devel-4.1-1.14=0D
[   13s] [69/229] keeping netcfg-11.6-9.6=0D
[   13s] [70/229] keeping alts-1.2+3.b848aad-2.3=0D
[   13s] [71/229] keeping attr-2.5.1-1.17=0D
[   13s] [72/229] keeping libbrotlidec1-1.0.9-1.7=0D
[   13s] [73/229] keeping libctf-nobfd0-2.38-4.1=0D
[   13s] [74/229] keeping libelf1-0.186-3.1=0D
[   13s] [75/229] keeping libgcrypt20-1.9.4-3.3=0D
[   13s] [76/229] keeping libgdbm_compat4-1.23-1.4=0D
[   13s] [77/229] keeping libglib-2_0-0-2.72.0-2.1=0D
[   13s] [78/229] keeping libidn2-0-2.3.2-1.4=0D
[   13s] [79/229] keeping libisl23-0.24-1.17=0D
[   13s] [80/229] keeping libjemalloc2-5.2.1-5.1=0D
[   13s] [81/229] keeping libmpfr6-4.1.0-2.18=0D
[   13s] [82/229] keeping libp11-kit0-0.24.1-1.1=0D
[   13s] [83/229] keeping libselinux1-3.3-2.1=0D
[   13s] [84/229] keeping libstdc++6-12.0.1+git192423-1.2=0D
[   13s] [85/229] keeping perl-base-5.34.0-2.1=0D
[   13s] [86/229] keeping pigz-2.6-1.7=0D
[   13s] [87/229] keeping pkgconf-1.8.0-1.6=0D
[   13s] [88/229] keeping chkstat-1599_20220309-30.1=0D
[   13s] [89/229] keeping libfdisk1-2.37.4-1.1=0D
[   13s] [90/229] keeping libopenssl1_1-1.1.1n-1.1=0D
[   13s] [91/229] keeping libxml2-2-2.9.13-1.1=0D
[   13s] [92/229] keeping libmagic1-5.41-4.1=0D
[   13s] [93/229] keeping build-mkbaselibs-20220329-1.1=0D
[   13s] [94/229] keeping rpm-build-perl-4.17.0-6.1=0D
[   13s] [95/229] keeping dwz-0.14-3.3=0D
[   13s] [96/229] keeping findutils-4.9.0-1.3=0D
[   13s] [97/229] keeping libgmodule-2_0-0-2.72.0-2.1=0D
[   13s] [98/229] keeping libxslt1-1.1.34-4.3=0D
[   13s] [99/229] keeping ninja-1.10.2-2.17=0D
[   13s] [100/229] keeping fdupes-2.1.2-2.1=0D
[   13s] [101/229] keeping file-5.41-4.1=0D
[   13s] [102/229] keeping libasan6-11.2.1+git1635-1.1=0D
[   13s] [103/229] keeping libdb-4_8-4.8.30-39.1=0D
[   13s] [104/229] keeping libldap2-2.6.1-1.1=0D
[   13s] [105/229] keeping liblsan0-12.0.1+git192423-1.2=0D
[   13s] [106/229] keeping libmount1-2.37.4-1.1=0D
[   13s] [107/229] keeping libmpc3-1.2.1-1.19=0D
[   13s] [108/229] keeping libpsl5-0.21.1-1.9=0D
[   13s] [109/229] keeping libsource-highlight4-3.1.9-4.5=0D
[   13s] [110/229] keeping libsubid4-4.11.1-1.3=0D
[   13s] [111/229] keeping libtsan0-11.2.1+git1635-1.1=0D
[   13s] [112/229] keeping libubsan1-12.0.1+git192423-1.2=0D
[   13s] [113/229] keeping tar-1.34-6.1=0D
[   13s] [114/229] keeping libkmod2-29-9.1=0D
[   13s] [115/229] keeping libruby3_1-3_1-3.1.2-2.1=0D
[   13s] [116/229] keeping krb5-1.19.3-1.1=0D
[   13s] [117/229] keeping libdw1-0.186-3.1=0D
[   13s] [118/229] keeping libsemanage2-3.3-2.3=0D
[   13s] [119/229] keeping libsystemd0-250.4-5.1=0D
[   13s] [120/229] keeping libasm1-0.186-3.1=0D
[   13s] [121/229] keeping libexslt0-1.1.34-4.3=0D
[   13s] [122/229] keeping libssh4-0.9.6-3.2=0D
[   13s] [123/229] keeping babeltrace-1.5.8-3.2=0D
[   13s] [124/229] keeping cpp11-11.2.1+git1635-1.1=0D
[   13s] [125/229] keeping perl-5.34.0-2.1=0D
[   13s] [126/229] keeping brp-check-suse-84.87+git20211116.6c5fe09-1.3=0D
[   13s] [127/229] keeping libxslt-tools-1.1.34-4.3=0D
[   13s] [128/229] keeping libcurl4-7.82.0-1.3=0D
[   13s] [129/229] keeping libdebuginfod1-0.186-3.1=0D
[   13s] [130/229] keeping terminfo-base-6.3.20220416-16.1=0D
[   13s] [131/229] keeping libncurses6-6.3.20220416-16.1=0D
[   13s] [132/229] keeping libreadline8-8.1-3.3=0D
[   13s] [133/229] keeping ncurses-utils-6.3.20220416-16.1=0D
[   13s] [134/229] keeping bash-5.1.16-7.1=0D
[   13s] [135/229] keeping libxml2-tools-2.9.13-1.1=0D
[   13s] [136/229] keeping gawk-5.1.1-3.6=0D
[   13s] [137/229] keeping bash-sh-5.1.16-7.1=0D
[   13s] [138/229] keeping login_defs-4.11.1-1.3=0D
[   13s] [139/229] keeping openSUSE-release-20220424-1573.1=0D
[   13s] [140/229] keeping sysuser-shadow-3.1-4.3=0D
[   13s] [141/229] keeping cpio-2.13-4.5=0D
[   13s] [142/229] keeping cpp-11-6.1=0D
[   13s] [143/229] keeping m4-1.4.18-6.6=0D
[   13s] [144/229] keeping make-4.3-2.39=0D
[   13s] [145/229] keeping systemd-default-settings-0.7-2.2=0D
[   13s] [146/229] keeping which-2.21-4.49=0D
[   13s] [147/229] keeping bzip2-1.0.8-3.6=0D
[   13s] [148/229] keeping grep-3.7-3.1=0D
[   13s] [149/229] keeping gzip-1.12-1.1=0D
[   13s] [150/229] keeping keyutils-1.6.3-3.6=0D
[   13s] [151/229] keeping pkgconf-pkg-config-1.8.0-1.6=0D
[   13s] [152/229] keeping strace-5.17-1.1=0D
[   13s] [153/229] keeping libdevmapper1_03-1.02.185-3.1=0D
[   13s] [154/229] keeping sed-4.8-3.10=0D
[   13s] [155/229] keeping xz-5.2.5-3.1=0D
[   13s] [156/229] keeping elfutils-0.186-3.1=0D
[   13s] [157/229] keeping gettext-runtime-0.21-4.1=0D
[   13s] [158/229] keeping lua54-5.4.4-2.1=0D
[   13s] [159/229] keeping zstd-1.5.2-1.3=0D
[   13s] [160/229] keeping coreutils-9.0-2.3=0D
[   13s] [161/229] keeping binutils-2.38-4.1=0D
[   13s] [162/229] keeping vim-8.2.4745-2.1=0D
[   13s] [163/229] keeping python38-base-3.8.13-1.2=0D
[   13s] [164/229] keeping bash-completion-devel-2.11-152.2=0D
[   13s] [165/229] keeping compat-usrmerge-build-84.87-5.6=0D
[   13s] [166/229] keeping systemd-default-settings-branding-openSUSE-0.7-2=
=2E2=0D
[   13s] [167/229] keeping systemd-rpm-macros-16-1.1=0D
[   13s] [168/229] keeping libjson-c-devel-0.16-1.1=0D
[   13s] [169/229] keeping libkmod-devel-29-9.1=0D
[   13s] [170/229] keeping libpython3_8-1_0-3.8.13-1.2=0D
[   13s] [171/229] keeping libuuid-devel-2.37.4-1.1=0D
[   13s] [172/229] keeping libxcrypt-devel-4.4.27-1.4=0D
[   13s] [173/229] keeping linux-glibc-devel-5.17-1.1=0D
[   13s] [174/229] keeping meson-0.61.3-1.1=0D
[   13s] [175/229] keeping system-group-hardware-20170617-71.55=0D
[   13s] [176/229] keeping system-group-kvm-20170617-71.55=0D
[   13s] [177/229] keeping autoconf-2.71-1.1=0D
[   13s] [178/229] keeping glibc-locale-base-2.35-2.1=0D
[   13s] [179/229] keeping libctf0-2.38-4.1=0D
[   13s] [180/229] keeping perl-Bootloader-0.938-1.1=0D
[   13s] [181/229] keeping rpm-build-python-4.17.0-6.1=0D
[   13s] [182/229] keeping permissions-config-1599_20220309-30.1=0D
[   13s] [183/229] keeping polkit-default-privs-1550+20220404.7b4bea2-1.1=0D
[   13s] [184/229] keeping less-590-3.5=0D
[   13s] [185/229] keeping gettext-tools-0.21-4.1=0D
[   13s] [186/229] keeping libcryptsetup12-2.4.3-1.2=0D
[   13s] [187/229] keeping sgml-skel-0.7.2-1.1=0D
[   13s] [188/229] keeping aaa_base-84.87+git20220419.bf51b75-1.1=0D
[   13s] [189/229] keeping ruby3.1-3.1.2-2.1=0D
[   13s] [190/229] keeping rpm-4.17.0-6.1=0D
[   13s] [191/229] keeping aaa_base-malloccheck-84.87+git20220419.bf51b75-1=
=2E1=0D
[   13s] [192/229] keeping permissions-20220309.1599-30.1=0D
[   13s] [193/229] keeping glibc-devel-2.35-2.1=0D
[   13s] [194/229] keeping rpm-config-SUSE-20220414-1.1=0D
[   13s] [195/229] keeping ruby3.1-rubygem-asciidoctor-2.0.17-1.2=0D
[   13s] [196/229] keeping ruby3.1-rubygem-gem2rpm-0.10.1-18.1=0D
[   13s] [197/229] keeping automake-1.16.5-1.5=0D
[   13s] [198/229] keeping rpmlint-mini-2.2.0+git20220419.1dbd1ae-5.13=0D
[   13s] [199/229] keeping systemd-devel-250.4-5.1=0D
[   13s] [200/229] keeping docbook_4-4.5-143.9=0D
[   13s] [201/229] keeping build-compare-20220307T115648.b5abdde-1.1=0D
[   13s] [202/229] keeping librpmbuild9-4.17.0-6.1=0D
[   13s] [203/229] keeping suse-module-tools-16.0.19-1.3=0D
[   13s] [204/229] keeping gdb-11.1-7.1=0D
[   13s] [205/229] keeping nfit_test-ueficert-0-6.1=0D
[   13s] [206/229] keeping docbook-xsl-stylesheets-1.79.2-2.10=0D
[   13s] [207/229] keeping keyutils-devel-1.6.3-3.6=0D
[   13s] [208/229] keeping libutempter0-1.2.0-3.19=0D
[   13s] [209/229] keeping libtool-2.4.7-1.1=0D
[   13s] [210/229] keeping kmod-29-9.1=0D
[   13s] [211/229] keeping post-build-checks-84.87+git20220325.f46ef3c-1.1=
=0D
[   13s] [212/229] keeping pam-1.5.2-6.1=0D
[   13s] [213/229] keeping gcc11-11.2.1+git1635-1.1=0D
[   13s] [214/229] keeping gcc11-PIE-11.2.1+git1635-1.1=0D
[   13s] [215/229] keeping gcc-11-6.1=0D
[   13s] [216/229] keeping pam_unix-1.5.2-6.1=0D
[   13s] [217/229] keeping xmlto-0.0.28-3.13=0D
[   13s] [218/229] keeping shadow-4.11.1-1.3=0D
[   13s] [219/229] keeping util-linux-2.37.4-1.1=0D
[   13s] [220/229] keeping gcc-PIE-11-6.1=0D
[   13s] [221/229] keeping ruby-common-2.6-7.1=0D
[   13s] [222/229] keeping systemd-250.4-5.1=0D
[   13s] [223/229] keeping rpm-build-4.17.0-6.1=0D
[   13s] [224/229] keeping util-linux-systemd-2.37.4-1.1=0D
[   13s] [225/229] keeping udev-250.4-5.1=0D
[   13s] [226/229] keeping dracut-056+suse.275.g4ce7a6a7-1.1=0D
[   13s] [227/229] keeping dracut-mkinitrd-deprecated-056+suse.275.g4ce7a6a=
7-1.1=0D
[   13s] [228/229] keeping kernel-default-5.17.4-1.1=0D
[   13s] [229/229] keeping nfit_test-kmp-default-0_k5.17.4_1-6.1=0D
[   13s] now finalizing build dir...=0D
[   13s] ... running 01-add_abuild_user_to_trusted_group=0D
[   13s] ... running 02-set_timezone_to_utc=0D
[   13s] ... running 03-set-permissions-secure=0D
[   13s] ... running 11-hack_uname_version_to_kernel_version=0D
[   15s] -----------------------------------------------------------------=
=0D
[   15s] I have the following modifications for ndctl-test.spec:=0D
[   15s] -----------------------------------------------------------------=
=0D
[   15s] ----- building ndctl-test.spec=0D
[   15s] -----------------------------------------------------------------=
=0D
[   15s] -----------------------------------------------------------------=
=0D
[   15s] + exec rpmbuild -ba --define '_srcdefattr (-,root,root)' --nosigna=
ture --define '_build_create_debug 1' /usr/src/packages/SOURCES/ndctl-test.=
spec=0D
[   16s] setting SOURCE_DATE_EPOCH=3D1649548800=0D
[   16s] Executing(%prep): /usr/bin/bash -e /var/tmp/rpm-tmp.VEscWN=0D
[   16s] + umask 022=0D
[   16s] + cd /usr/src/packages/BUILD=0D
[   16s] + cd /usr/src/packages/BUILD=0D
[   16s] + rm -rf ndctl-73=0D
[   16s] + /usr/bin/gzip -dc /usr/src/packages/SOURCES/ndctl-73.tar.gz=0D
[   16s] + /usr/bin/tar -xof -=0D
[   16s] + STATUS=3D0=0D
[   16s] + '[' 0 -ne 0 ']'=0D
[   16s] + cd ndctl-73=0D
[   16s] + /usr/bin/chmod -Rf a+rX,u+w,g-w,o-w .=0D
[   16s] + /usr/bin/patch -p1 -s --fuzz=3D0 --no-backup-if-mismatch -f=0D
[   16s] + /usr/bin/cat /usr/src/packages/SOURCES/harden_ndctl-monitor.serv=
ice.patch=0D
[   16s] + /usr/bin/cat /usr/src/packages/SOURCES/ndctl-build-Fix-systemd-u=
nit-directory-detection.patch=0D
[   16s] + /usr/bin/patch -p1 -s --fuzz=3D0 --no-backup-if-mismatch -f=0D
[   16s] + /usr/bin/cat /usr/src/packages/SOURCES/ndctl-meson-make-modprobe=
datadir-an-option.patch=0D
[   16s] + /usr/bin/patch -p1 -s --fuzz=3D0 --no-backup-if-mismatch -f=0D
[   16s] + RPM_EC=3D0=0D
[   16s] ++ jobs -p=0D
[   16s] + exit 0=0D
[   16s] Executing(%build): /usr/bin/bash -e /var/tmp/rpm-tmp.ZNNQ9N=0D
[   16s] + umask 022=0D
[   16s] + cd /usr/src/packages/BUILD=0D
[   16s] + /usr/bin/rm -rf /usr/src/packages/BUILDROOT/ndctl-73-0.x86_64=0D
[   16s] ++ dirname /usr/src/packages/BUILDROOT/ndctl-73-0.x86_64=0D
[   16s] + /usr/bin/mkdir -p /usr/src/packages/BUILDROOT=0D
[   16s] + /usr/bin/mkdir /usr/src/packages/BUILDROOT/ndctl-73-0.x86_64=0D
[   16s] + cd ndctl-73=0D
[   16s] + PATH=3D/sbin:/usr/sbin:/sbin:/usr/sbin:/usr/local/sbin:/root/bin=
:/usr/local/bin:/usr/bin:/bin=0D
[   16s] + export 'CFLAGS=3D-O2 -Wall -D_FORTIFY_SOURCE=3D2 -fstack-protect=
or-strong -funwind-tables -fasynchronous-unwind-tables -fstack-clash-protec=
tion -Werror=3Dreturn-type -flto=3Dauto -g -fcommon'=0D
[   16s] + CFLAGS=3D'-O2 -Wall -D_FORTIFY_SOURCE=3D2 -fstack-protector-stro=
ng -funwind-tables -fasynchronous-unwind-tables -fstack-clash-protection -W=
error=3Dreturn-type -flto=3Dauto -g -fcommon'=0D
[   16s] ++ uname -r=0D
[   16s] + grep -E 'CONFIG_(X86_PMEM_LEGACY|ZONE_DEVICE|LIBNVDIMM|BLK_DEV_P=
MEM|ND_BLK|BTT|NVDIMM_PFN|NVDIMM_DAX|DEV_DAX_PMEM|ENCRYPTED_KEYS)' /boot/co=
nfig-5.17.4-1-default=0D
[   16s] CONFIG_X86_PMEM_LEGACY_DEVICE=3Dy=0D
[   16s] CONFIG_X86_PMEM_LEGACY=3Dm=0D
[   16s] CONFIG_ZONE_DEVICE=3Dy=0D
[   16s] CONFIG_LIBNVDIMM=3Dm=0D
[   16s] CONFIG_BLK_DEV_PMEM=3Dm=0D
[   16s] CONFIG_ND_BLK=3Dm=0D
[   16s] CONFIG_BTT=3Dy=0D
[   16s] CONFIG_NVDIMM_PFN=3Dy=0D
[   16s] CONFIG_NVDIMM_DAX=3Dy=0D
[   16s] CONFIG_DEV_DAX_PMEM=3Dm=0D
[   16s] CONFIG_ENCRYPTED_KEYS=3Dy=0D
[   16s] + modinfo crc7=0D
[   16s] filename:       /lib/modules/5.17.4-1-default/kernel/lib/crc7.ko.z=
st=0D
[   16s] license:        GPL=0D
[   16s] description:    CRC7 calculations=0D
[   16s] suserelease:    openSUSE Tumbleweed=0D
[   16s] srcversion:     4A994A610EF89736D603BAB=0D
[   16s] depends:        =0D
[   16s] retpoline:      Y=0D
[   16s] intree:         Y=0D
[   16s] name:           crc7=0D
[   16s] vermagic:       5.17.4-1-default SMP preempt mod_unload modversion=
s =0D
[   16s] sig_id:         PKCS#7=0D
[   16s] signer:         openSUSE Secure Boot CA=0D
[   16s] sig_key:        FA:BE:D8:BF:40:9A:5E:64=0D
[   16s] sig_hashalgo:   sha256=0D
[   16s] signature:      02:41:51:23:A4:7E:FB:E9:06:A9:49:E3:70:06:AE:ED:82=
:4D:46:02:=0D
[   16s] 		11:18:DF:12:32:DE:77:B1:0B:14:72:1B:7B:C9:BC:12:47:4E:5B:41:=0D
[   16s] 		A2:8C:47:4E:39:9A:35:F2:3E:A2:85:C8:AB:76:60:BF:E7:56:14:FB:=0D
[   16s] 		51:60:03:6A:6E:5E:01:FF:7A:51:E1:77:0B:FE:13:17:58:CF:54:1E:=0D
[   16s] 		23:51:49:70:CF:6F:F3:74:8B:79:A4:BC:C6:46:8D:E0:14:9C:47:68:=0D
[   16s] 		F6:C0:2A:60:3C:D9:B3:28:E7:46:F7:24:B4:3F:2D:E1:A9:8D:68:44:=0D
[   16s] 		B8:21:30:FE:1D:C0:62:FF:DD:2F:CA:6E:CC:C4:22:0B:9A:38:F6:6B:=0D
[   16s] 		44:12:8C:A2:E7:4F:DD:5D:48:5F:BC:4C:4B:DF:57:F3:E5:41:5D:37:=0D
[   16s] 		B9:89:D8:77:FF:6F:BA:FE:5E:04:4E:9E:0B:D5:0F:2A:1D:17:E6:32:=0D
[   16s] 		A8:6F:9C:32:E8:B5:5A:E3:FF:FB:F9:59:A2:3D:3A:88:49:45:83:B9:=0D
[   16s] 		B4:D3:09:90:71:5B:A8:EF:5B:CF:6B:C5:F8:3A:BE:3D:AD:C3:64:FA:=0D
[   16s] 		34:05:BF:CF:9B:20:53:23:A1:48:E3:66:4E:CC:C1:8B:96:4E:FD:AB:=0D
[   16s] 		0A:89:19:B6:00:1C:B2:CB:6A:8E:4F:31:A5:08:FF:37=0D
[   16s] + rpm -ql nfit_test-kmp-default=0D
[   16s] /usr/lib/modules/5.17.4-1-default=0D
[   16s] /usr/lib/modules/5.17.4-1-default/updates=0D
[   16s] /usr/lib/modules/5.17.4-1-default/updates/dax_pmem.ko=0D
[   16s] /usr/lib/modules/5.17.4-1-default/updates/device_dax.ko=0D
[   16s] /usr/lib/modules/5.17.4-1-default/updates/libnvdimm.ko=0D
[   16s] /usr/lib/modules/5.17.4-1-default/updates/nd_blk.ko=0D
[   16s] /usr/lib/modules/5.17.4-1-default/updates/nd_btt.ko=0D
[   16s] /usr/lib/modules/5.17.4-1-default/updates/nd_e820.ko=0D
[   16s] /usr/lib/modules/5.17.4-1-default/updates/nd_pmem.ko=0D
[   16s] /usr/lib/modules/5.17.4-1-default/updates/nfit.ko=0D
[   16s] /usr/lib/modules/5.17.4-1-default/updates/test=0D
[   16s] /usr/lib/modules/5.17.4-1-default/updates/test/nfit_test.ko=0D
[   16s] /usr/lib/modules/5.17.4-1-default/updates/test/nfit_test_iomap.ko=
=0D
[   16s] + rpm -ql nfit_test-kmp-default=0D
[   16s] + read x=0D
[   16s] + grep '[.]ko$'=0D
[   16s] + x=3Ddax_pmem.ko=0D
[   16s] + modinfo dax_pmem=0D
[   16s] filename:       /lib/modules/5.17.4-1-default/updates/dax_pmem.ko=
=0D
[   16s] alias:          nd:t7*=0D
[   16s] author:         Intel Corporation=0D
[   16s] license:        GPL v2=0D
[   16s] suserelease:    openSUSE Tumbleweed=0D
[   16s] srcversion:     DF110B4AF46CAD12B1B604B=0D
[   16s] depends:        libnvdimm,nfit_test_iomap=0D
[   16s] retpoline:      Y=0D
[   16s] name:           dax_pmem=0D
[   16s] vermagic:       5.17.4-1-default SMP preempt mod_unload modversion=
s =0D
[   16s] sig_id:         PKCS#7=0D
[   16s] signer:         home:michals OBS Project=0D
[   16s] sig_key:        D6:35:C9:D3:9B:A7:05:F5=0D
[   16s] sig_hashalgo:   sha256=0D
[   16s] signature:      6E:73:92:61:46:06:6F:28:CF:86:59:93:D2:20:1A:4B:0A=
:E7:F8:18:=0D
[   16s] 		B1:75:B5:15:58:C0:A1:24:45:39:75:CC:A8:81:15:21:31:74:AC:9D:=0D
[   16s] 		26:81:59:FE:64:29:75:42:F5:36:10:63:B7:AB:0F:A8:2C:CB:9D:F8:=0D
[   16s] 		E4:13:C3:DC:12:1B:4B:E3:DA:85:A7:14:8F:69:BB:97:6B:30:55:E5:=0D
[   16s] 		95:9B:C1:1E:FC:3C:22:FB:7C:1A:B9:3C:85:69:BC:EE:91:67:6C:36:=0D
[   16s] 		C1:5C:CB:3E:20:95:A1:0D:DD:E8:C5:B9:86:1C:45:A3:0F:FA:B9:CB:=0D
[   16s] 		6E:4F:7B:42:D9:2C:E9:7D:D2:99:31:91:17:B6:52:49:35:74:A1:06:=0D
[   16s] 		65:47:39:1B:BE:AD:F9:8A:5C:DC:E1:99:4B:D0:25:7C:5F:2C:0D:88:=0D
[   16s] 		87:E6:C6:67:D3:15:2F:4A:09:87:CE:4D:AF:EF:87:84:F3:F2:4C:C2:=0D
[   16s] 		71:04:63:31:7E:82:5D:D1:FB:32:13:E2:80:9D:D1:C4:F2:A7:C1:EF:=0D
[   16s] 		EA:6D:A3:56:FA:5F:60:53:4A:AF:29:4E:7E:C3:3A:08:37:91:6F:02:=0D
[   16s] 		37:2E:78:72:C8:AC:64:DB:F6:BF:69:D6:0E:02:B3:0F:81:EF:30:BD:=0D
[   16s] 		38:14:0D:60:63:55:6E:43:FB:8C:68:42:EE:93:3A:AF=0D
[   16s] + read x=0D
[   16s] + x=3Ddevice_dax.ko=0D
[   16s] + modinfo device_dax=0D
[   16s] filename:       /lib/modules/5.17.4-1-default/updates/device_dax.k=
o=0D
[   16s] alias:          dax:t0*=0D
[   16s] license:        GPL v2=0D
[   16s] author:         Intel Corporation=0D
[   16s] suserelease:    openSUSE Tumbleweed=0D
[   16s] srcversion:     8D0DEC24055D11C4E59A619=0D
[   16s] depends:        nfit_test_iomap=0D
[   16s] retpoline:      Y=0D
[   16s] name:           device_dax=0D
[   16s] vermagic:       5.17.4-1-default SMP preempt mod_unload modversion=
s =0D
[   16s] sig_id:         PKCS#7=0D
[   16s] signer:         home:michals OBS Project=0D
[   16s] sig_key:        D6:35:C9:D3:9B:A7:05:F5=0D
[   16s] sig_hashalgo:   sha256=0D
[   16s] signature:      A9:DE:44:9B:1B:7B:1E:CD:28:F1:4D:6C:50:97:43:DF:47=
:9F:9B:1C:=0D
[   16s] 		3E:7D:5F:74:9E:9D:D1:32:44:9A:64:07:AB:46:38:89:3D:57:8D:E0:=0D
[   16s] 		82:BF:7D:B8:E9:34:C3:37:71:21:E0:FE:DF:45:D5:03:1E:D9:B6:99:=0D
[   16s] 		45:FC:4D:E1:46:B4:06:85:25:40:51:5B:C7:2C:41:C0:59:82:7A:B1:=0D
[   16s] 		8F:08:FB:12:F0:F4:D7:D8:34:BD:8C:02:2F:95:42:C0:2C:19:F4:15:=0D
[   16s] 		C6:6C:14:39:0B:28:A1:D3:F3:94:6C:0C:B6:D3:E9:39:D5:E8:BC:40:=0D
[   16s] 		77:69:7C:A4:14:4D:68:28:86:19:57:E8:61:0B:63:92:4C:F7:1F:D7:=0D
[   16s] 		A2:7E:99:B3:E3:D6:C1:30:2F:20:8E:D9:19:D1:04:28:CF:51:95:0D:=0D
[   16s] 		02:C4:E2:56:3E:BC:4C:E9:E7:97:21:E4:F1:5E:20:3D:A2:1D:AE:C7:=0D
[   16s] 		45:AD:BC:2B:14:13:1C:A5:3B:90:D6:7C:A3:71:85:77:45:AF:02:F7:=0D
[   16s] 		05:09:19:76:3D:08:C0:DE:6F:23:C3:EF:B2:11:29:15:BB:AC:D1:B4:=0D
[   16s] 		EE:70:0C:5C:7A:39:B6:C2:4D:9A:28:4F:5F:54:FC:74:E6:0B:AB:13:=0D
[   16s] 		18:72:60:6D:33:E2:2E:83:5E:4D:4E:15:92:94:31:0D=0D
[   16s] + read x=0D
[   16s] + x=3Dlibnvdimm.ko=0D
[   16s] + modinfo libnvdimm=0D
[   16s] filename:       /lib/modules/5.17.4-1-default/updates/libnvdimm.ko=
=0D
[   16s] author:         Intel Corporation=0D
[   16s] license:        GPL v2=0D
[   16s] alias:          nd:t1*=0D
[   16s] alias:          nd:t3*=0D
[   16s] alias:          nd:t2*=0D
[   16s] suserelease:    openSUSE Tumbleweed=0D
[   16s] srcversion:     7979C2F441DB6169DFBD35D=0D
[   16s] depends:        nfit_test_iomap=0D
[   16s] retpoline:      Y=0D
[   16s] name:           libnvdimm=0D
[   16s] vermagic:       5.17.4-1-default SMP preempt mod_unload modversion=
s =0D
[   16s] sig_id:         PKCS#7=0D
[   16s] signer:         home:michals OBS Project=0D
[   16s] sig_key:        D6:35:C9:D3:9B:A7:05:F5=0D
[   16s] sig_hashalgo:   sha256=0D
[   16s] signature:      90:94:56:55:B0:54:B8:0C:54:AA:B3:F8:37:A6:10:74:B5=
:68:61:49:=0D
[   16s] 		FF:E1:B5:4F:86:24:4F:44:44:0A:01:D6:36:EF:05:CD:F0:34:B1:45:=0D
[   16s] 		3B:6C:5C:38:FC:97:FB:C5:3B:DE:9F:92:0C:10:93:9B:76:A2:C7:4A:=0D
[   16s] 		EC:61:26:2B:21:07:9D:42:A0:F1:CA:EB:8E:17:E4:20:71:E5:57:E3:=0D
[   16s] 		A1:00:1B:92:B2:3C:7A:7F:C6:B0:C4:F2:46:8E:36:F3:9E:03:5A:A5:=0D
[   16s] 		9B:28:24:90:EC:32:57:64:19:A4:F6:44:94:98:98:D0:18:C4:D7:50:=0D
[   16s] 		83:AC:CC:2D:56:A7:5F:38:52:70:18:DC:19:01:8B:94:36:84:06:B5:=0D
[   16s] 		45:5F:F4:84:8C:91:BD:DA:CC:2C:61:DB:58:75:FB:0C:A1:DE:4E:6C:=0D
[   16s] 		6D:A9:23:37:38:27:A5:42:15:3B:6C:65:EA:41:63:01:01:42:22:34:=0D
[   16s] 		F4:D0:FA:B0:23:86:F8:B9:E6:D2:1D:2F:62:4D:F8:31:B1:DE:BA:49:=0D
[   16s] 		A5:97:0F:79:F2:EF:B4:5A:73:6B:AA:40:FE:44:1C:14:BB:B1:AC:27:=0D
[   16s] 		7A:CF:0F:54:AE:52:C8:D4:F0:23:F4:44:26:81:15:54:74:B2:EF:CB:=0D
[   16s] 		1A:CD:C0:01:50:00:57:FF:2A:22:4B:CF:38:30:7B:03=0D
[   16s] parm:           key_revalidate:Require key validation at init. (bo=
ol)=0D
[   16s] parm:           noblk:force disable BLK / local alias support (boo=
l)=0D
[   16s] + read x=0D
[   16s] + x=3Dnd_blk.ko=0D
[   16s] + modinfo nd_blk=0D
[   16s] filename:       /lib/modules/5.17.4-1-default/updates/nd_blk.ko=0D
[   16s] alias:          nd:t6*=0D
[   16s] license:        GPL v2=0D
[   16s] author:         Ross Zwisler <ross.zwisler@linux.intel.com>=0D
[   16s] suserelease:    openSUSE Tumbleweed=0D
[   16s] srcversion:     3A72F6FC76BFBAD5F8FD368=0D
[   16s] depends:        libnvdimm,nd_btt=0D
[   16s] retpoline:      Y=0D
[   16s] name:           nd_blk=0D
[   16s] vermagic:       5.17.4-1-default SMP preempt mod_unload modversion=
s =0D
[   16s] sig_id:         PKCS#7=0D
[   16s] signer:         home:michals OBS Project=0D
[   16s] sig_key:        D6:35:C9:D3:9B:A7:05:F5=0D
[   16s] sig_hashalgo:   sha256=0D
[   16s] signature:      31:03:96:BD:4B:AF:D8:47:2A:FC:C1:6E:69:12:E9:B5:3D=
:47:57:E3:=0D
[   16s] 		16:0D:FA:59:A2:A0:B9:D2:3A:23:6C:4C:FB:8A:20:57:FE:4C:5F:D8:=0D
[   16s] 		A0:4E:67:A5:A2:84:78:3E:1F:95:F2:70:BA:55:78:CF:F8:89:40:FD:=0D
[   16s] 		8C:97:9A:BA:10:B3:37:82:4E:A8:0C:61:0A:F9:40:97:48:75:9E:F4:=0D
[   16s] 		88:C7:EE:A5:36:0D:EF:7B:9E:64:7F:23:55:47:76:A8:72:00:96:1E:=0D
[   16s] 		DB:3F:06:BC:FC:07:48:B1:E6:E9:B9:1F:C0:B5:90:30:F7:01:14:A8:=0D
[   16s] 		4F:D4:3C:42:D2:A0:F6:AE:0C:B9:56:4A:DE:DB:29:E1:06:36:80:C1:=0D
[   16s] 		39:A0:10:B3:79:4D:A2:53:35:4F:F8:08:23:80:EE:CB:CA:F8:F6:01:=0D
[   16s] 		09:C9:66:94:EB:BF:CD:64:4B:76:70:A4:09:BF:B1:88:D0:1C:16:F8:=0D
[   16s] 		B9:49:17:D6:9D:75:7A:B1:7D:1D:07:D2:AE:A7:A4:37:27:17:5C:88:=0D
[   16s] 		46:D3:73:8F:DA:52:E8:A3:70:F5:1B:4F:29:65:E7:89:A9:BA:80:C8:=0D
[   16s] 		DF:38:3B:22:F8:BC:6D:B0:D5:A1:16:68:99:2F:8D:A2:3A:EE:0D:30:=0D
[   16s] 		42:3E:A3:F1:98:A1:EE:19:FE:78:3B:B6:B4:32:5E:3B=0D
[   16s] + read x=0D
[   16s] + x=3Dnd_btt.ko=0D
[   16s] + modinfo nd_btt=0D
[   16s] filename:       /lib/modules/5.17.4-1-default/updates/nd_btt.ko=0D
[   16s] license:        GPL v2=0D
[   16s] author:         Vishal Verma <vishal.l.verma@linux.intel.com>=0D
[   16s] alias:          nd:tND_DEVICE_BTT*=0D
[   16s] suserelease:    openSUSE Tumbleweed=0D
[   16s] srcversion:     6086D5F0094FD8F88E6F3F5=0D
[   16s] depends:        libnvdimm=0D
[   16s] retpoline:      Y=0D
[   16s] name:           nd_btt=0D
[   16s] vermagic:       5.17.4-1-default SMP preempt mod_unload modversion=
s =0D
[   16s] sig_id:         PKCS#7=0D
[   16s] signer:         home:michals OBS Project=0D
[   16s] sig_key:        D6:35:C9:D3:9B:A7:05:F5=0D
[   16s] sig_hashalgo:   sha256=0D
[   16s] signature:      33:07:75:74:D8:F7:38:ED:07:CA:14:94:AC:28:0B:32:21=
:45:1C:49:=0D
[   16s] 		FC:36:EE:82:CC:EF:57:36:EB:6F:D0:3F:65:89:47:FF:43:82:55:11:=0D
[   16s] 		8E:B7:9C:CA:1A:CC:8E:01:E9:7E:1D:24:04:0D:43:66:A9:97:FD:6A:=0D
[   16s] 		11:0C:75:2C:85:72:99:A1:45:1A:FB:1C:62:02:2F:DF:F1:C1:8E:80:=0D
[   16s] 		23:D2:6F:23:01:B3:C7:A0:FF:AE:5F:00:6C:0A:6B:6D:73:01:8B:EA:=0D
[   16s] 		17:B1:6C:5E:7A:2D:50:1C:4C:32:14:29:E9:D6:78:31:E2:CD:55:5E:=0D
[   16s] 		4C:E3:9C:56:5B:2F:D1:A8:24:D0:58:0C:03:3E:54:3E:3D:B4:F1:6D:=0D
[   16s] 		08:D4:66:25:28:BA:2E:7A:12:6E:84:EC:04:22:20:EF:88:FD:5F:87:=0D
[   16s] 		60:0A:16:0A:47:79:FD:02:93:2F:EB:71:90:69:F2:E9:A5:3C:BC:46:=0D
[   16s] 		23:66:D4:0B:ED:18:98:14:41:7C:4E:2D:82:B0:19:05:B0:A7:56:90:=0D
[   16s] 		03:6B:F9:19:01:FA:51:96:F0:05:A3:11:77:B2:66:C9:E4:D2:05:1B:=0D
[   16s] 		50:8E:32:48:2C:14:7C:DB:B9:7A:61:C2:25:1E:DF:B4:A5:09:CB:5F:=0D
[   16s] 		C2:47:69:4F:CA:8D:05:9A:B3:79:BF:9A:82:DB:06:A8=0D
[   16s] + read x=0D
[   16s] + x=3Dnd_e820.ko=0D
[   16s] + modinfo nd_e820=0D
[   16s] filename:       /lib/modules/5.17.4-1-default/updates/nd_e820.ko=0D
[   16s] author:         Intel Corporation=0D
[   16s] license:        GPL v2=0D
[   16s] alias:          platform:e820_pmem*=0D
[   16s] suserelease:    openSUSE Tumbleweed=0D
[   16s] srcversion:     DD0C086278FBA71A4E0D0A7=0D
[   16s] depends:        libnvdimm=0D
[   16s] retpoline:      Y=0D
[   16s] name:           nd_e820=0D
[   16s] vermagic:       5.17.4-1-default SMP preempt mod_unload modversion=
s =0D
[   16s] sig_id:         PKCS#7=0D
[   16s] signer:         home:michals OBS Project=0D
[   16s] sig_key:        D6:35:C9:D3:9B:A7:05:F5=0D
[   16s] sig_hashalgo:   sha256=0D
[   16s] signature:      88:01:9C:3A:6A:B2:7D:72:F8:FA:8A:FA:74:EC:22:B7:D6=
:AA:0E:12:=0D
[   16s] 		E1:6D:82:62:EF:C8:81:47:E5:5F:CC:EB:F9:46:EA:95:C2:C1:0B:A9:=0D
[   16s] 		1B:63:CC:3B:54:F2:2E:28:A5:13:76:42:59:97:60:1F:F1:31:81:1F:=0D
[   16s] 		B5:FF:1E:79:39:84:39:88:9E:93:7A:6B:07:4A:BA:9F:87:B9:D3:02:=0D
[   16s] 		E8:56:20:D1:C1:B7:C2:2F:CD:41:50:A2:3B:5E:BB:56:EA:AE:86:EE:=0D
[   16s] 		B4:82:ED:24:D3:17:44:12:64:6F:F8:4E:F7:85:E5:9B:DF:85:F7:FF:=0D
[   16s] 		DB:D3:FB:14:CB:87:F1:70:95:C8:4E:39:A7:69:28:8E:3B:E4:9A:81:=0D
[   16s] 		A9:1B:F7:3A:32:5E:0D:87:CA:05:23:F5:F4:05:31:9C:37:8D:2C:66:=0D
[   16s] 		66:C3:81:F8:CB:5D:C9:83:C1:C8:06:EC:FC:4A:FE:A6:06:22:F0:25:=0D
[   16s] 		86:AD:DA:3F:EC:B7:3C:36:B6:B9:25:50:9D:2F:8A:B2:BF:70:44:BD:=0D
[   16s] 		43:5A:7B:0F:D2:31:FF:D4:BF:2F:7E:39:09:42:F4:73:35:BC:EA:70:=0D
[   16s] 		E2:B0:49:6C:64:90:E2:EE:73:04:36:AA:39:65:9D:AB:3C:7D:D7:DA:=0D
[   16s] 		2F:86:26:BB:AB:5A:08:4F:C4:31:EC:B9:2F:AD:B6:BB=0D
[   16s] + read x=0D
[   16s] + x=3Dnd_pmem.ko=0D
[   16s] + modinfo nd_pmem=0D
[   16s] filename:       /lib/modules/5.17.4-1-default/updates/nd_pmem.ko=0D
[   16s] license:        GPL v2=0D
[   16s] author:         Ross Zwisler <ross.zwisler@linux.intel.com>=0D
[   16s] alias:          nd:t5*=0D
[   16s] alias:          nd:t4*=0D
[   16s] alias:          pmem=0D
[   16s] suserelease:    openSUSE Tumbleweed=0D
[   16s] srcversion:     D2055A058EAD68106B47915=0D
[   16s] depends:        nfit_test_iomap,libnvdimm,nd_btt=0D
[   16s] retpoline:      Y=0D
[   16s] name:           nd_pmem=0D
[   16s] vermagic:       5.17.4-1-default SMP preempt mod_unload modversion=
s =0D
[   16s] sig_id:         PKCS#7=0D
[   16s] signer:         home:michals OBS Project=0D
[   16s] sig_key:        D6:35:C9:D3:9B:A7:05:F5=0D
[   16s] sig_hashalgo:   sha256=0D
[   16s] signature:      66:2A:ED:73:79:73:4F:CE:CD:46:72:15:D1:E5:C9:0C:C8=
:08:CF:92:=0D
[   16s] 		87:A0:4E:4C:78:E5:93:E2:33:A1:86:4B:CA:43:AE:B4:4D:11:7F:42:=0D
[   16s] 		43:38:FF:08:74:62:F1:5D:85:4B:EE:A8:F4:67:E8:81:96:12:80:D5:=0D
[   16s] 		4A:28:CE:2B:52:BE:A0:07:98:4E:4B:56:A7:52:A1:23:BA:73:FA:94:=0D
[   16s] 		48:9A:F1:20:6A:37:03:3A:DF:A1:FF:AF:03:DC:18:B2:34:EC:39:C7:=0D
[   16s] 		2C:AE:4F:BB:E1:24:D5:FE:1F:66:D5:8D:B2:5E:E1:A4:B2:FF:C6:AE:=0D
[   16s] 		9C:12:D7:3F:11:04:50:17:1C:2F:6E:82:50:B9:AD:C4:F1:0F:AC:2B:=0D
[   16s] 		4A:0E:DC:66:C7:A6:92:89:45:46:A2:91:FB:01:0A:1F:43:8C:A4:F4:=0D
[   16s] 		58:B4:76:9E:F3:2D:66:83:32:48:90:C2:B7:72:ED:DB:A8:55:38:B9:=0D
[   16s] 		45:6E:BD:24:35:5B:8D:74:1C:8E:59:D7:5D:11:75:DA:C3:35:78:CD:=0D
[   16s] 		39:DE:89:7C:73:FC:B9:9F:4C:98:D7:42:E7:E4:F6:20:12:5E:0E:93:=0D
[   16s] 		11:38:92:40:E5:AB:4F:C8:43:51:BA:AE:85:2B:05:DE:86:D0:C5:02:=0D
[   16s] 		8F:AB:38:60:01:37:BB:E3:55:63:2A:B9:EE:DC:70:B2=0D
[   16s] + read x=0D
[   16s] + x=3Dnfit.ko=0D
[   16s] + modinfo nfit=0D
[   16s] filename:       /lib/modules/5.17.4-1-default/updates/nfit.ko=0D
[   16s] author:         Intel Corporation=0D
[   16s] license:        GPL v2=0D
[   16s] suserelease:    openSUSE Tumbleweed=0D
[   16s] srcversion:     22FD8D672D1712147004184=0D
[   16s] alias:          acpi*:ACPI0012:*=0D
[   16s] depends:        libnvdimm,nfit_test_iomap=0D
[   16s] retpoline:      Y=0D
[   16s] name:           nfit=0D
[   16s] vermagic:       5.17.4-1-default SMP preempt mod_unload modversion=
s =0D
[   16s] sig_id:         PKCS#7=0D
[   16s] signer:         home:michals OBS Project=0D
[   16s] sig_key:        D6:35:C9:D3:9B:A7:05:F5=0D
[   16s] sig_hashalgo:   sha256=0D
[   16s] signature:      C1:A7:C7:03:10:AB:36:7D:AC:5C:1D:0B:03:7B:53:8B:EC=
:59:F2:A6:=0D
[   16s] 		57:CA:08:E9:AF:7A:29:6E:1C:73:8E:15:6C:48:A1:97:56:3D:BE:EF:=0D
[   16s] 		FF:BC:2C:B1:B5:C1:4F:94:82:04:36:66:EB:FA:86:FE:6A:FC:82:32:=0D
[   16s] 		4C:D2:75:DA:CE:34:41:B4:EC:E3:BC:50:A8:1F:D2:5B:53:86:95:53:=0D
[   16s] 		04:71:EA:BD:C0:27:D8:BD:90:14:08:95:BF:30:37:68:03:E3:FD:9A:=0D
[   16s] 		FC:21:2F:F0:58:67:64:46:3D:15:AD:85:A6:A8:87:1A:7E:B8:06:6A:=0D
[   16s] 		C4:CE:C1:10:A8:65:07:A8:3B:ED:2A:A2:ED:A0:66:89:6D:E2:F2:B1:=0D
[   16s] 		36:93:11:ED:E7:65:37:48:FA:70:C2:2E:73:A5:A3:E9:6B:58:78:16:=0D
[   16s] 		4D:CF:61:A5:7D:20:3E:C5:69:41:79:68:CD:F5:AB:C4:21:67:F5:1F:=0D
[   16s] 		A5:96:3F:5F:2F:91:55:56:CB:33:9C:70:E0:DE:9D:24:82:B9:2B:A8:=0D
[   16s] 		31:4F:B1:ED:3F:AA:E4:79:7C:9E:7C:53:15:FF:20:50:CF:22:F3:3B:=0D
[   16s] 		1C:49:10:DB:B8:F6:F4:AC:16:9A:0C:D9:E6:2D:A3:83:50:DA:21:E7:=0D
[   16s] 		94:CA:19:CD:22:97:2E:7E:9C:0E:79:6B:C4:EF:F5:40=0D
[   16s] parm:           force_enable_dimms:Ignore _STA (ACPI DIMM device) =
status (bool)=0D
[   16s] parm:           disable_vendor_specific:Limit commands to the publ=
icly specified set (bool)=0D
[   16s] parm:           override_dsm_mask:Bitmask of allowed NVDIMM DSM fu=
nctions (ulong)=0D
[   16s] parm:           default_dsm_family:Try this DSM type first when id=
entifying NVDIMM family (int)=0D
[   16s] parm:           no_init_ars:Skip ARS run at nfit init time (bool)=
=0D
[   16s] parm:           force_labels:Opt-in to labels despite missing meth=
ods (bool)=0D
[   16s] + read x=0D
[   16s] + x=3Dnfit_test.ko=0D
[   16s] + modinfo nfit_test=0D
[   16s] filename:       /lib/modules/5.17.4-1-default/updates/test/nfit_te=
st.ko=0D
[   16s] author:         Intel Corporation=0D
[   16s] license:        GPL v2=0D
[   16s] suserelease:    openSUSE Tumbleweed=0D
[   16s] srcversion:     789BD8068E0BE584E9DFD23=0D
[   16s] depends:        libnvdimm,dax_pmem,device_dax,nfit,nfit_test_iomap=
,nd_pmem=0D
[   16s] retpoline:      Y=0D
[   16s] name:           nfit_test=0D
[   16s] vermagic:       5.17.4-1-default SMP preempt mod_unload modversion=
s =0D
[   16s] sig_id:         PKCS#7=0D
[   16s] signer:         home:michals OBS Project=0D
[   16s] sig_key:        D6:35:C9:D3:9B:A7:05:F5=0D
[   16s] sig_hashalgo:   sha256=0D
[   16s] signature:      A0:39:2A:E3:1D:F1:32:C4:27:27:72:3A:08:D5:A8:A3:06=
:0E:00:55:=0D
[   16s] 		C8:39:D6:92:A5:94:CA:F4:DD:DE:2D:07:BD:AD:9D:E4:E4:05:40:66:=0D
[   16s] 		6E:13:56:28:49:5F:C2:71:A9:6E:8A:35:C6:6D:FF:E8:0B:67:90:6A:=0D
[   16s] 		FA:66:80:3C:41:26:AB:47:16:81:6B:FA:5E:3F:D0:88:D1:11:58:13:=0D
[   16s] 		93:B1:BF:6F:C4:97:05:93:6F:3D:62:E8:97:69:8F:86:41:D9:19:69:=0D
[   16s] 		B6:4A:3A:28:E4:E7:1A:06:68:32:97:64:05:7E:48:C6:1D:6F:E7:B6:=0D
[   16s] 		12:A5:4A:73:71:F5:3E:CF:9D:9F:88:78:AE:11:66:08:DF:FB:F5:1E:=0D
[   16s] 		17:CC:00:46:A3:90:B3:4A:04:B0:28:20:CF:FD:FF:B4:DE:B0:D5:35:=0D
[   16s] 		61:CD:72:F3:62:53:BA:70:17:73:C3:FD:50:B1:7E:0F:04:16:D3:ED:=0D
[   16s] 		E6:0D:3B:9E:6E:A0:FD:14:DE:C4:98:46:A4:A4:73:A5:73:47:6C:CA:=0D
[   16s] 		81:B0:73:A5:8D:A7:45:0A:7E:15:02:A6:7B:80:17:3F:41:08:DF:B7:=0D
[   16s] 		63:A0:8E:9F:5B:F8:37:8F:40:EE:E0:98:41:60:5F:44:AE:CB:8D:31:=0D
[   16s] 		9F:74:B7:F1:98:67:03:3A:1B:7E:D7:33:2D:FA:15:F6=0D
[   16s] + read x=0D
[   16s] + x=3Dnfit_test_iomap.ko=0D
[   16s] + modinfo nfit_test_iomap=0D
[   16s] filename:       /lib/modules/5.17.4-1-default/updates/test/nfit_te=
st_iomap.ko=0D
[   16s] license:        GPL v2=0D
[   16s] suserelease:    openSUSE Tumbleweed=0D
[   16s] srcversion:     534B7D5E73E88AB001556E5=0D
[   16s] depends:        =0D
[   16s] retpoline:      Y=0D
[   16s] name:           nfit_test_iomap=0D
[   16s] vermagic:       5.17.4-1-default SMP preempt mod_unload modversion=
s =0D
[   16s] sig_id:         PKCS#7=0D
[   16s] signer:         home:michals OBS Project=0D
[   16s] sig_key:        D6:35:C9:D3:9B:A7:05:F5=0D
[   16s] sig_hashalgo:   sha256=0D
[   16s] signature:      35:82:E4:A3:77:59:3C:01:45:F5:60:87:07:F3:01:9A:3D=
:99:38:D4:=0D
[   16s] 		88:4C:1F:D4:CF:E1:29:74:07:BB:35:F8:4E:99:90:40:67:19:6F:3D:=0D
[   16s] 		FC:AE:B6:9D:4F:A0:15:B2:31:A5:CF:5D:E4:71:BB:C2:F0:58:4E:4D:=0D
[   16s] 		A5:8F:12:DA:3D:CA:34:DB:FF:7F:8E:D3:83:FF:58:3A:16:76:03:72:=0D
[   16s] 		C6:62:86:0A:24:8E:A8:40:F3:E1:30:35:4C:9C:FE:0A:EA:00:02:5F:=0D
[   16s] 		98:17:2E:36:86:A6:15:DA:5B:7F:0B:71:29:0A:41:DD:A3:09:8B:DF:=0D
[   16s] 		F9:C9:2A:74:AB:D9:3A:F4:59:E9:0B:51:43:4F:E1:0E:92:2B:80:5B:=0D
[   16s] 		BC:0E:E0:45:D3:A2:1A:32:E6:41:AF:93:53:C7:F8:9A:36:7D:5C:99:=0D
[   16s] 		26:72:A8:B2:F7:A4:9A:E1:F1:D3:BA:80:AD:F6:85:8C:64:95:48:D7:=0D
[   16s] 		63:B3:D1:62:4B:32:33:98:08:2F:66:59:AB:4B:93:CD:CB:AE:4F:CC:=0D
[   16s] 		77:B2:FB:88:C2:46:47:A2:C5:73:2B:F6:26:F2:2A:F9:BA:3F:AE:5E:=0D
[   16s] 		BB:66:16:98:F2:74:3F:62:A8:B7:95:32:46:DE:4D:98:55:CE:15:03:=0D
[   16s] 		F1:11:71:6C:B2:D8:51:C6:D4:AE:15:3A:16:CB:33:08=0D
[   16s] + read x=0D
[   16s] + CONFIG_SHELL=3D/usr/bin/bash=0D
[   16s] + export CONFIG_SHELL=0D
[   16s] + CFLAGS=3D'-O2 -Wall -D_FORTIFY_SOURCE=3D2 -fstack-protector-stro=
ng -funwind-tables -fasynchronous-unwind-tables -fstack-clash-protection -W=
error=3Dreturn-type -flto=3Dauto -g -fcommon'=0D
[   16s] + export CFLAGS=0D
[   16s] + CXXFLAGS=3D'-O2 -Wall -D_FORTIFY_SOURCE=3D2 -fstack-protector-st=
rong -funwind-tables -fasynchronous-unwind-tables -fstack-clash-protection =
-Werror=3Dreturn-type -flto=3Dauto -g'=0D
[   16s] + export CXXFLAGS=0D
[   16s] + FFLAGS=3D'-O2 -Wall -D_FORTIFY_SOURCE=3D2 -fstack-protector-stro=
ng -funwind-tables -fasynchronous-unwind-tables -fstack-clash-protection -W=
error=3Dreturn-type -flto=3Dauto -g '=0D
[   16s] + export FFLAGS=0D
[   16s] + FCFLAGS=3D'-O2 -Wall -D_FORTIFY_SOURCE=3D2 -fstack-protector-str=
ong -funwind-tables -fasynchronous-unwind-tables -fstack-clash-protection -=
Werror=3Dreturn-type -flto=3Dauto -g '=0D
[   16s] + export FCFLAGS=0D
[   16s] + LDFLAGS=3D-flto=3Dauto=0D
[   16s] + export LDFLAGS=0D
[   16s] + /usr/bin/meson --buildtype=3Dplain --prefix=3D/usr --libdir=3D/u=
sr/lib64 --libexecdir=3D/usr/libexec --bindir=3D/usr/bin --sbindir=3D/usr/s=
bin --includedir=3D/usr/include --datadir=3D/usr/share --mandir=3D/usr/shar=
e/man --infodir=3D/usr/share/info --localedir=3D/usr/share/locale --sysconf=
dir=3D/etc --localstatedir=3D/var --sharedstatedir=3D/var/lib --wrap-mode=
=3Dnodownload --auto-features=3Denabled . x86_64-suse-linux -Dasciidoctor=
=3Denabled -Dversion-tag=3D73 -Dmodprobedatadir=3D/lib/modprobe.d=0D
[   21s] The Meson build system=0D
[   21s] Version: 0.61.3=0D
[   21s] Source dir: /usr/src/packages/BUILD/ndctl-73=0D
[   21s] Build dir: /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux=0D
[   21s] Build type: native build=0D
[   21s] Project name: ndctl=0D
[   21s] Project version: 73=0D
[   21s] C compiler for the host machine: cc (gcc 11.2.1 "cc (SUSE Linux) 1=
1.2.1 20220420 [revision 691af15031e00227ba6d5935c1d737026cda4129]")=0D
[   21s] C linker for the host machine: cc ld.bfd 2.38.20220411-4=0D
[   21s] Host machine cpu family: x86_64=0D
[   21s] Host machine cpu: x86_64=0D
[   21s] Compiler for C supports arguments -Wall: YES =0D
[   21s] Compiler for C supports arguments -Wchar-subscripts: YES =0D
[   21s] Compiler for C supports arguments -Wformat-security: YES =0D
[   21s] Compiler for C supports arguments -Wmissing-declarations: YES =0D
[   21s] Compiler for C supports arguments -Wmissing-prototypes: YES =0D
[   21s] Compiler for C supports arguments -Wnested-externs : NO =0D
[   21s] Compiler for C supports arguments -Wshadow: YES =0D
[   21s] Compiler for C supports arguments -Wsign-compare: YES =0D
[   21s] Compiler for C supports arguments -Wstrict-prototypes: YES =0D
[   21s] Compiler for C supports arguments -Wtype-limits: YES =0D
[   21s] Compiler for C supports arguments -Wmaybe-uninitialized: YES =0D
[   21s] Compiler for C supports arguments -Wdeclaration-after-statement: Y=
ES =0D
[   21s] Compiler for C supports arguments -Wunused-result: YES =0D
[   21s] Compiler for C supports arguments -D_FORTIFY_SOURCE=3D2: YES =0D
[   21s] Compiler for C supports arguments -O2: YES =0D
[   21s] meson.build:77: WARNING: Consider using the built-in warning_level=
 option instead of using "-Wall".=0D
[   21s] meson.build:77: WARNING: Consider using the built-in optimization =
level instead of using "-O2".=0D
[   21s] Program git found: NO=0D
[   21s] Program env found: YES (/usr/bin/env)=0D
[   21s] Configuring version.h using configuration=0D
[   21s] Found pkg-config: /usr/bin/pkg-config (1.8.0)=0D
[   21s] Run-time dependency libkmod found: YES 29=0D
[   21s] Run-time dependency libudev found: YES 250=0D
[   21s] Run-time dependency uuid found: YES 2.37.4=0D
[   21s] Run-time dependency json-c found: YES 0.16=0D
[   21s] Program asciidoctor found: YES (/usr/bin/asciidoctor)=0D
[   21s] Run-time dependency systemd found: YES 250=0D
[   21s] Run-time dependency udev found: YES 250=0D
[   21s] Library keyutils found: YES=0D
[   21s] Library iniparser found: YES=0D
[   21s] Has header "dlfcn.h" : YES =0D
[   21s] Has header "inttypes.h" : YES =0D
[   21s] Has header "keyutils.h" : YES =0D
[   21s] Has header "linux/version.h" : YES =0D
[   21s] Has header "memory.h" : YES =0D
[   21s] Has header "stdint.h" : YES =0D
[   21s] Has header "stdlib.h" : YES =0D
[   21s] Has header "strings.h" : YES =0D
[   21s] Has header "string.h" : YES =0D
[   21s] Has header "sys/stat.h" : YES =0D
[   21s] Has header "sys/types.h" : YES =0D
[   21s] Has header "unistd.h" : YES =0D
[   21s] Header <signal.h> has symbol "BUS_MCEERR_AR" : YES =0D
[   21s] Header <linux/mman.h> has symbol "MAP_SHARED_VALIDATE" : YES =0D
[   21s] Header <linux/mman.h> has symbol "MAP_SYNC" : YES =0D
[   21s] Checking for function "secure_getenv" : YES =0D
[   21s] Checking for function "__secure_getenv" : NO =0D
[   21s] Checking for function "json_object_new_uint64" with dependency jso=
n-c: YES =0D
[   21s] Configuring config.h using configuration=0D
[   21s] Program create.sh found: YES (/usr/src/packages/BUILD/ndctl-73/tes=
t/create.sh)=0D
[   21s] Program clear.sh found: YES (/usr/src/packages/BUILD/ndctl-73/test=
/clear.sh)=0D
[   21s] Program pmem-errors.sh found: YES (/usr/src/packages/BUILD/ndctl-7=
3/test/pmem-errors.sh)=0D
[   21s] Program daxdev-errors.sh found: YES (/usr/src/packages/BUILD/ndctl=
-73/test/daxdev-errors.sh)=0D
[   21s] Program multi-dax.sh found: YES (/usr/src/packages/BUILD/ndctl-73/=
test/multi-dax.sh)=0D
[   21s] Program btt-check.sh found: YES (/usr/src/packages/BUILD/ndctl-73/=
test/btt-check.sh)=0D
[   21s] Program label-compat.sh found: YES (/usr/src/packages/BUILD/ndctl-=
73/test/label-compat.sh)=0D
[   21s] Program sector-mode.sh found: YES (/usr/src/packages/BUILD/ndctl-7=
3/test/sector-mode.sh)=0D
[   21s] Program inject-error.sh found: YES (/usr/src/packages/BUILD/ndctl-=
73/test/inject-error.sh)=0D
[   21s] Program btt-errors.sh found: YES (/usr/src/packages/BUILD/ndctl-73=
/test/btt-errors.sh)=0D
[   21s] Program btt-pad-compat.sh found: YES (/usr/src/packages/BUILD/ndct=
l-73/test/btt-pad-compat.sh)=0D
[   21s] Program firmware-update.sh found: YES (/usr/src/packages/BUILD/ndc=
tl-73/test/firmware-update.sh)=0D
[   21s] Program rescan-partitions.sh found: YES (/usr/src/packages/BUILD/n=
dctl-73/test/rescan-partitions.sh)=0D
[   21s] Program inject-smart.sh found: YES (/usr/src/packages/BUILD/ndctl-=
73/test/inject-smart.sh)=0D
[   21s] Program monitor.sh found: YES (/usr/src/packages/BUILD/ndctl-73/te=
st/monitor.sh)=0D
[   21s] Program max_available_extent_ns.sh found: YES (/usr/src/packages/B=
UILD/ndctl-73/test/max_available_extent_ns.sh)=0D
[   21s] Program pfn-meta-errors.sh found: YES (/usr/src/packages/BUILD/ndc=
tl-73/test/pfn-meta-errors.sh)=0D
[   21s] Program track-uuid.sh found: YES (/usr/src/packages/BUILD/ndctl-73=
/test/track-uuid.sh)=0D
[   21s] Program security.sh found: YES (/usr/src/packages/BUILD/ndctl-73/t=
est/security.sh)=0D
[   21s] Run-time dependency bash-completion found: YES 2.11=0D
[   21s] Build targets in project: 85=0D
[   21s] =0D
[   21s] ndctl 73=0D
[   21s] =0D
[   21s]   User defined options=0D
[   21s]     auto_features  : enabled=0D
[   21s]     bindir         : /usr/bin=0D
[   21s]     buildtype      : plain=0D
[   21s]     datadir        : /usr/share=0D
[   21s]     includedir     : /usr/include=0D
[   21s]     infodir        : /usr/share/info=0D
[   21s]     libdir         : /usr/lib64=0D
[   21s]     libexecdir     : /usr/libexec=0D
[   21s]     localedir      : /usr/share/locale=0D
[   21s]     localstatedir  : /var=0D
[   21s]     mandir         : /usr/share/man=0D
[   21s]     prefix         : /usr=0D
[   21s]     sbindir        : /usr/sbin=0D
[   21s]     sharedstatedir : /var/lib=0D
[   21s]     sysconfdir     : /etc=0D
[   21s]     wrap_mode      : nodownload=0D
[   21s]     asciidoctor    : enabled=0D
[   21s]     modprobedatadir: /lib/modprobe.d=0D
[   21s]     version-tag    : 73=0D
[   21s] =0D
[   21s] Found ninja-1.10.2 at /usr/bin/ninja=0D
[   21s] + /usr/bin/meson test -C x86_64-suse-linux --num-processes 2 --pri=
nt-errorlogs=0D
[   21s] ninja: Entering directory `/usr/src/packages/BUILD/ndctl-73/x86_64=
-suse-linux'=0D
[   22s] [1/135] Compiling C object daxctl/lib/libdaxctl.so.1.1.5.p/.._.._u=
til_iomem.c.o=0D
[   22s] [2/135] Compiling C object daxctl/lib/libdaxctl.so.1.1.5.p/.._.._u=
til_log.c.o=0D
[   22s] [3/135] Compiling C object daxctl/lib/libdaxctl.so.1.1.5.p/.._.._u=
til_sysfs.c.o=0D
[   22s] [4/135] Compiling C object ndctl/lib/libndctl.so.6.0.20.p/.._.._ut=
il_log.c.o=0D
[   22s] [5/135] Compiling C object ndctl/lib/libndctl.so.6.0.20.p/.._.._ut=
il_sysfs.c.o=0D
[   22s] [6/135] Compiling C object daxctl/lib/libdaxctl.so.1.1.5.p/libdaxc=
tl.c.o=0D
[   22s] [7/135] Compiling C object ndctl/lib/libndctl.so.6.0.20.p/inject.c=
=2Eo=0D
[   22s] [8/135] Compiling C object ndctl/lib/libndctl.so.6.0.20.p/dimm.c.o=
=0D
[   23s] [9/135] Compiling C object ndctl/lib/libndctl.so.6.0.20.p/nfit.c.o=
=0D
[   23s] [10/135] Compiling C object ndctl/lib/libndctl.so.6.0.20.p/smart.c=
=2Eo=0D
[   23s] [11/135] Compiling C object ndctl/lib/libndctl.so.6.0.20.p/intel.c=
=2Eo=0D
[   23s] [12/135] Compiling C object ndctl/lib/libndctl.so.6.0.20.p/hpe1.c.=
o=0D
[   23s] [13/135] Compiling C object ndctl/lib/libndctl.so.6.0.20.p/msft.c.=
o=0D
[   23s] [14/135] Compiling C object ndctl/lib/libndctl.so.6.0.20.p/hyperv.=
c.o=0D
[   23s] [15/135] Compiling C object ndctl/lib/libndctl.so.6.0.20.p/papr.c.=
o=0D
[   24s] [16/135] Compiling C object ndctl/lib/libndctl.so.6.0.20.p/firmwar=
e.c.o=0D
[   24s] [17/135] Compiling C object ndctl/lib/libndctl.so.6.0.20.p/ars.c.o=
=0D
[   24s] [18/135] Compiling C object cxl/lib/libcxl.so.1.0.1.p/.._.._util_s=
ysfs.c.o=0D
[   24s] [19/135] Compiling C object cxl/lib/libcxl.so.1.0.1.p/.._.._util_l=
og.c.o=0D
[   24s] [20/135] Linking target daxctl/lib/libdaxctl.so.1.1.5=0D
[   25s] [21/135] Compiling C object cxl/lib/libcxl.so.1.0.1.p/libcxl.c.o=0D
[   25s] [22/135] Compiling C object ndctl/lib/libndctl.so.6.0.20.p/libndct=
l.c.o=0D
[   25s] [23/135] Generating symbol file daxctl/lib/libdaxctl.so.1.1.5.p/li=
bdaxctl.so.1.1.5.symbols=0D
[   26s] [24/135] Compiling C object util/libutil.a.p/parse-options.c.o=0D
[   26s] [25/135] Compiling C object util/libutil.a.p/parse-configs.c.o=0D
[   26s] [26/135] Compiling C object util/libutil.a.p/usage.c.o=0D
[   26s] [27/135] Compiling C object util/libutil.a.p/size.c.o=0D
[   26s] [28/135] Compiling C object util/libutil.a.p/main.c.o=0D
[   27s] [29/135] Compiling C object util/libutil.a.p/help.c.o=0D
[   27s] [30/135] Compiling C object util/libutil.a.p/strbuf.c.o=0D
[   27s] [31/135] Compiling C object util/libutil.a.p/wrapper.c.o=0D
[   27s] [32/135] Compiling C object util/libutil.a.p/bitmap.c.o=0D
[   28s] [33/135] Compiling C object util/libutil.a.p/abspath.c.o=0D
[   28s] [34/135] Compiling C object util/libutil.a.p/iomem.c.o=0D
[   28s] [35/135] Linking static target util/libutil.a=0D
[   28s] [36/135] Compiling C object ndctl/ndctl.p/ndctl.c.o=0D
[   29s] [37/135] Compiling C object ndctl/ndctl.p/bus.c.o=0D
[   29s] [38/135] Linking target cxl/lib/libcxl.so.1.0.1=0D
[   29s] [39/135] Compiling C object ndctl/ndctl.p/create-nfit.c.o=0D
[   31s] [40/135] Compiling C object ndctl/ndctl.p/namespace.c.o=0D
[   31s] [41/135] Generating symbol file cxl/lib/libcxl.so.1.0.1.p/libcxl.s=
o.1.0.1.symbols=0D
[   31s] [42/135] Compiling C object ndctl/ndctl.p/region.c.o=0D
[   31s] [43/135] Compiling C object ndctl/ndctl.p/check.c.o=0D
[   31s] [44/135] Compiling C object ndctl/ndctl.p/dimm.c.o=0D
[   31s] [45/135] Compiling C object ndctl/ndctl.p/.._util_log.c.o=0D
[   32s] [46/135] Compiling C object ndctl/ndctl.p/.._daxctl_filter.c.o=0D
[   32s] [47/135] Compiling C object ndctl/ndctl.p/filter.c.o=0D
[   32s] [48/135] Compiling C object ndctl/ndctl.p/.._util_json.c.o=0D
[   32s] [49/135] Compiling C object ndctl/ndctl.p/list.c.o=0D
[   32s] [50/135] Compiling C object ndctl/ndctl.p/.._daxctl_json.c.o=0D
[   32s] [51/135] Compiling C object ndctl/ndctl.p/json.c.o=0D
[   32s] [52/135] Compiling C object ndctl/ndctl.p/json-smart.c.o=0D
[   33s] [53/135] Compiling C object ndctl/ndctl.p/inject-error.c.o=0D
[   33s] [54/135] Compiling C object ndctl/ndctl.p/inject-smart.c.o=0D
[   33s] [55/135] Compiling C object ndctl/ndctl.p/monitor.c.o=0D
[   33s] [56/135] Compiling C object ndctl/ndctl.p/keys.c.o=0D
[   33s] [57/135] Compiling C object daxctl/daxctl.p/daxctl.c.o=0D
[   33s] [58/135] Compiling C object ndctl/ndctl.p/load-keys.c.o=0D
[   34s] [59/135] Compiling C object daxctl/daxctl.p/list.c.o=0D
[   34s] [60/135] Compiling C object daxctl/daxctl.p/acpi.c.o=0D
[   34s] [61/135] Compiling C object daxctl/daxctl.p/migrate.c.o=0D
[   34s] [62/135] Linking target ndctl/lib/libndctl.so.6.0.20=0D
[   34s] [63/135] Compiling C object daxctl/daxctl.p/device.c.o=0D
[   34s] [64/135] Compiling C object daxctl/daxctl.p/.._util_json.c.o=0D
[   34s] [65/135] Compiling C object daxctl/daxctl.p/json.c.o=0D
[   34s] [66/135] Compiling C object daxctl/daxctl.p/filter.c.o=0D
[   35s] [67/135] Compiling C object cxl/cxl.p/cxl.c.o=0D
[   35s] [68/135] Compiling C object cxl/cxl.p/list.c.o=0D
[   35s] [69/135] Compiling C object cxl/cxl.p/port.c.o=0D
[   35s] [70/135] Compiling C object cxl/cxl.p/memdev.c.o=0D
[   35s] [71/135] Compiling C object cxl/cxl.p/.._util_json.c.o=0D
[   35s] [72/135] Generating symbol file ndctl/lib/libndctl.so.6.0.20.p/lib=
ndctl.so.6.0.20.symbols=0D
[   35s] [73/135] Compiling C object cxl/cxl.p/.._util_log.c.o=0D
[   35s] [74/135] Compiling C object cxl/cxl.p/json.c.o=0D
[   36s] [75/135] Compiling C object cxl/cxl.p/filter.c.o=0D
[   41s] [76/135] Linking target daxctl/daxctl=0D
[   41s] [77/135] Compiling C object test/libndctl.p/core.c.o=0D
[   41s] [78/135] Compiling C object test/libndctl.p/.._util_log.c.o=0D
[   42s] [79/135] Compiling C object test/libndctl.p/.._util_sysfs.c.o=0D
[   42s] [80/135] Linking target cxl/cxl=0D
[   42s] [81/135] Compiling C object test/dsm-fail.p/core.c.o=0D
[   42s] [82/135] Compiling C object test/dsm-fail.p/.._util_log.c.o=0D
[   42s] [83/135] Compiling C object test/libndctl.p/libndctl.c.o=0D
[   43s] [84/135] Compiling C object test/dsm-fail.p/.._util_sysfs.c.o=0D
[   43s] [85/135] Compiling C object test/dsm-fail.p/.._ndctl_namespace.c.o=
=0D
[   44s] [86/135] Linking target ndctl/ndctl=0D
[   44s] [87/135] Compiling C object test/dsm-fail.p/.._ndctl_filter.c.o=0D
[   44s] [88/135] Compiling C object test/dsm-fail.p/.._ndctl_check.c.o=0D
[   44s] [89/135] Compiling C object test/dsm-fail.p/.._util_json.c.o=0D
[   44s] [90/135] Compiling C object test/dsm-fail.p/.._ndctl_json.c.o=0D
[   44s] [91/135] Compiling C object test/dsm-fail.p/.._daxctl_filter.c.o=0D
[   44s] [92/135] Compiling C object test/dsm-fail.p/.._daxctl_json.c.o=0D
[   45s] [93/135] Compiling C object test/hugetlb.p/core.c.o=0D
[   45s] [94/135] Compiling C object test/dsm-fail.p/dsm-fail.c.o=0D
[   45s] [95/135] Compiling C object test/hugetlb.p/.._util_log.c.o=0D
[   45s] [96/135] Compiling C object test/hugetlb.p/.._util_sysfs.c.o=0D
[   45s] [97/135] Compiling C object test/hugetlb.p/hugetlb.c.o=0D
[   46s] [98/135] Linking target test/libndctl=0D
[   46s] [99/135] Compiling C object test/hugetlb.p/dax-pmd.c.o=0D
[   46s] [100/135] Compiling C object test/hugetlb.p/dax-poison.c.o=0D
[   46s] [101/135] Compiling C object test/ack-shutdown-count-set.p/core.c.=
o=0D
[   46s] [102/135] Linking target test/hugetlb=0D
[   46s] [103/135] Compiling C object test/ack-shutdown-count-set.p/.._util=
_log.c.o=0D
[   46s] [104/135] Compiling C object test/ack-shutdown-count-set.p/ack-shu=
tdown-count-set.c.o=0D
[   46s] [105/135] Compiling C object test/ack-shutdown-count-set.p/.._util=
_sysfs.c.o=0D
[   47s] [106/135] Compiling C object test/dax-errors.p/dax-errors.c.o=0D
[   47s] [107/135] Linking target test/dax-errors=0D
[   47s] [108/135] Compiling C object test/smart-notify.p/smart-notify.c.o=
=0D
[   47s] [109/135] Linking target test/ack-shutdown-count-set=0D
[   48s] [110/135] Linking target test/smart-notify=0D
[   48s] [111/135] Compiling C object test/daxdev-errors.p/.._util_log.c.o=
=0D
[   48s] [112/135] Compiling C object test/daxdev-errors.p/daxdev-errors.c.=
o=0D
[   48s] [113/135] Compiling C object test/daxdev-errors.p/.._util_sysfs.c.=
o=0D
[   48s] [114/135] Compiling C object test/list-smart-dimm.p/list-smart-dim=
m.c.o=0D
[   48s] [115/135] Compiling C object test/list-smart-dimm.p/.._ndctl_filte=
r.c.o=0D
[   49s] [116/135] Compiling C object test/list-smart-dimm.p/.._util_json.c=
=2Eo=0D
[   49s] [117/135] Linking target test/daxdev-errors=0D
[   49s] [118/135] Linking target test/dsm-fail=0D
[   49s] [119/135] Compiling C object test/list-smart-dimm.p/.._ndctl_json.=
c.o=0D
[   49s] [120/135] Compiling C object test/list-smart-dimm.p/.._daxctl_filt=
er.c.o=0D
[   49s] [121/135] Compiling C object test/list-smart-dimm.p/.._daxctl_json=
=2Ec.o=0D
[   49s] [122/135] Compiling C object test/dax-dev.p/core.c.o=0D
[   49s] [123/135] Compiling C object test/dax-dev.p/.._util_log.c.o=0D
[   49s] [124/135] Compiling C object test/dax-dev.p/dax-dev.c.o=0D
[   49s] [125/135] Compiling C object test/dax-dev.p/.._util_sysfs.c.o=0D
[   50s] [126/135] Compiling C object test/dax-pmd.p/core.c.o=0D
[   50s] [127/135] Compiling C object test/dax-pmd.p/.._util_log.c.o=0D
[   50s] [128/135] Linking target test/dax-dev=0D
[   50s] [129/135] Compiling C object test/dax-pmd.p/.._util_sysfs.c.o=0D
[   50s] [130/135] Compiling C object test/dax-pmd.p/dax-pmd.c.o=0D
[   50s] [131/135] Compiling C object test/dax-pmd.p/dax-poison.c.o=0D
[   50s] [132/135] Compiling C object test/mmap.p/mmap.c.o=0D
[   51s] [133/135] Linking target test/list-smart-dimm=0D
[   51s] [134/135] Linking target test/mmap=0D
[   51s] [135/135] Linking target test/dax-pmd=0D
[   51s]  1/23 ndctl:ndctl / libndctl               SKIP            0.02s  =
 exit status 77=0D
[   51s]  2/23 ndctl:ndctl / dsm-fail               SKIP            0.01s  =
 exit status 77=0D
[   51s] [   44.669516][ T2022] nfit_test nfit_test.0: failed to evaluate _=
FIT=0D
[   51s] [   44.690393][ T2022] nfit_test nfit_test.1: Error found in NVDIM=
M nmem4 flags: save_fail restore_fail flush_fail not_armed=0D
[   51s] [   44.690600][ T2022] nfit_test nfit_test.1: Error found in NVDIM=
M nmem5 flags: map_fail=0D
[   51s] [   44.936417][ T2039] nd_pmem btt1.0: init: error in meta_init: -=
12=0D
[   51s]  3/23 ndctl:ndctl / create.sh              FAIL            0.51s  =
 exit status 1=0D
[   51s] >>> DATA_PATH=3D/usr/src/packages/BUILD/ndctl-73/test DAXCTL=3D/us=
r/src/packages/BUILD/ndctl-73/x86_64-suse-linux/daxctl/daxctl TEST_PATH=3D/=
usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/test NDCTL=3D/usr/src/pac=
kages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl /usr/src/packages/BUILD/=
ndctl-73/test/create.sh=0D
[   51s] =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=0D
[   51s] stdout:=0D
[   51s] test/create.sh: failed at line 35=0D
[   51s] stderr:=0D
[   51s] + set -e=0D
[   51s] + SECTOR_SIZE=3D4096=0D
[   51s] + rc=3D77=0D
[   51s] ++ dirname /usr/src/packages/BUILD/ndctl-73/test/create.sh=0D
[   51s] + . /usr/src/packages/BUILD/ndctl-73/test/common=0D
[   51s] ++ '[' -z /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/ndctl=
/ndctl ']'=0D
[   51s] ++ '[' -z /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/daxct=
l/daxctl ']'=0D
[   51s] ++ '[' -z /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/test =
']'=0D
[   51s] ++ NFIT_TEST_BUS0=3Dnfit_test.0=0D
[   51s] ++ NFIT_TEST_BUS1=3Dnfit_test.1=0D
[   51s] ++ ACPI_BUS=3DACPI.NFIT=0D
[   51s] ++ E820_BUS=3De820=0D
[   51s] + check_min_kver 4.5=0D
[   51s] + local ver=3D4.5=0D
[   51s] ++ uname -r=0D
[   51s] + : 5.17.4-1-default=0D
[   51s] + '[' -n 4.5 ']'=0D
[   51s] ++ echo -e '4.5\n5.17.4-1-default'=0D
[   51s] ++ sort -V=0D
[   51s] ++ head -1=0D
[   51s] + [[ 4.5 =3D=3D \4\.\5 ]]=0D
[   51s] + trap 'err $LINENO' ERR=0D
[   51s] + modprobe nfit_test=0D
[   51s] + reset=0D
[   51s] + /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl d=
isable-region -b nfit_test.0 all=0D
[   51s] disabled 6 regions=0D
[   51s] + /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl i=
nit-labels -f -b nfit_test.0 all=0D
[   51s] initialized 4 nmems=0D
[   51s] + /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl e=
nable-region -b nfit_test.0 all=0D
[   51s] enabled 6 regions=0D
[   51s] + rc=3D1=0D
[   51s] + dev=3Dx=0D
[   51s] ++ /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl =
create-namespace -b nfit_test.0 -t pmem -m raw=0D
[   51s] + json=3D'{=0D
[   51s]   "dev":"namespace1.0",=0D
[   51s]   "mode":"raw",=0D
[   51s]   "size":67108864,=0D
[   51s]   "uuid":"5c1b4706-cb40-41b7-ba43-e0a350e7b97d",=0D
[   51s]   "sector_size":512,=0D
[   51s]   "blockdev":"pmem1"=0D
[   51s] }'=0D
[   51s] ++ echo '{' '"dev":"namespace1.0",' '"mode":"raw",' '"size":671088=
64,' '"uuid":"5c1b4706-cb40-41b7-ba43-e0a350e7b97d",' '"sector_size":512,' =
'"blockdev":"pmem1"' '}'=0D
[   51s] ++ json2var=0D
[   51s] ++ sed -e 's/[{}",]//g; s/\[//g; s/\]//g; s/:/=3D/g'=0D
[   51s] + eval dev=3Dnamespace1.0 mode=3Draw size=3D67108864 uuid=3D5c1b47=
06-cb40-41b7-ba43-e0a350e7b97d sector_size=3D512 blockdev=3Dpmem1=0D
[   51s] ++ dev=3Dnamespace1.0=0D
[   51s] ++ mode=3Draw=0D
[   51s] ++ size=3D67108864=0D
[   51s] ++ uuid=3D5c1b4706-cb40-41b7-ba43-e0a350e7b97d=0D
[   51s] ++ sector_size=3D512=0D
[   51s] ++ blockdev=3Dpmem1=0D
[   51s] + '[' namespace1.0 =3D x ']'=0D
[   51s] + '[' raw '!=3D' raw ']'=0D
[   51s] ++ /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl =
create-namespace -m fsdax -f -e namespace1.0=0D
[   51s] + json=3D'{=0D
[   51s]   "dev":"namespace1.0",=0D
[   51s]   "mode":"fsdax",=0D
[   51s]   "map":"dev",=0D
[   51s]   "size":65011712,=0D
[   51s]   "uuid":"6438fbbe-d7d8-4078-928f-2cd5a1c30ec9",=0D
[   51s]   "sector_size":512,=0D
[   51s]   "align":2097152,=0D
[   51s]   "blockdev":"pmem1"=0D
[   51s] }'=0D
[   51s] ++ echo '{' '"dev":"namespace1.0",' '"mode":"fsdax",' '"map":"dev"=
,' '"size":65011712,' '"uuid":"6438fbbe-d7d8-4078-928f-2cd5a1c30ec9",' '"se=
ctor_size":512,' '"align":2097152,' '"blockdev":"pmem1"' '}'=0D
[   51s] ++ json2var=0D
[   51s] ++ sed -e 's/[{}",]//g; s/\[//g; s/\]//g; s/:/=3D/g'=0D
[   51s] + eval dev=3Dnamespace1.0 mode=3Dfsdax map=3Ddev size=3D65011712 u=
uid=3D6438fbbe-d7d8-4078-928f-2cd5a1c30ec9 sector_size=3D512 align=3D209715=
2 blockdev=3Dpmem1=0D
[   51s] ++ dev=3Dnamespace1.0=0D
[   51s] ++ mode=3Dfsdax=0D
[   51s] ++ map=3Ddev=0D
[   51s] ++ size=3D65011712=0D
[   51s] ++ uuid=3D6438fbbe-d7d8-4078-928f-2cd5a1c30ec9=0D
[   51s] ++ sector_size=3D512=0D
[   51s] ++ align=3D2097152=0D
[   51s] ++ blockdev=3Dpmem1=0D
[   51s] + '[' fsdax '!=3D' fsdax ']'=0D
[   51s] ++ /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl =
create-namespace -m sector -l 4096 -f -e namespace1.0=0D
[   51s] libndctl: ndctl_btt_enable: btt1.0: failed to enable=0D
[   51s]   Error: namespace1.0: failed to enable=0D
[   51s] =0D
[   51s] failed to reconfigure namespace: No such device or address=0D
[   51s] + json=3D=0D
[   51s] ++ err 35=0D
[   51s] +++ basename /usr/src/packages/BUILD/ndctl-73/test/create.sh=0D
[   51s] ++ echo test/create.sh: failed at line 35=0D
[   51s] ++ '[' -n '' ']'=0D
[   51s] ++ exit 1=0D
[   51s] =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=0D
[   51s] =0D
[   65s]  4/23 ndctl:ndctl / clear.sh               OK             13.70s=0D
[   65s] [   58.822295][ T2104] nfit_test nfit_test.0: failed to evaluate _=
FIT=0D
[   65s] [   58.828419][ T2104] nfit_test nfit_test.1: Error found in NVDIM=
M nmem4 flags: save_fail restore_fail flush_fail not_armed=0D
[   65s] [   58.828755][ T2104] nfit_test nfit_test.1: Error found in NVDIM=
M nmem5 flags: map_fail=0D
[   78s]  5/23 ndctl:ndctl / pmem-errors.sh         FAIL           12.38s  =
 exit status 32=0D
[   78s] >>> DATA_PATH=3D/usr/src/packages/BUILD/ndctl-73/test DAXCTL=3D/us=
r/src/packages/BUILD/ndctl-73/x86_64-suse-linux/daxctl/daxctl TEST_PATH=3D/=
usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/test NDCTL=3D/usr/src/pac=
kages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl /usr/src/packages/BUILD/=
ndctl-73/test/pmem-errors.sh=0D
[   78s] =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=0D
[   78s] Listing only the last 100 lines from a long log.=0D
[   78s]       "activate_state":"idle"=0D
[   78s]     }=0D
[   78s]   }=0D
[   78s] ]=0D
[   78s] [=0D
[   78s]   {=0D
[   78s]     "provider":"nfit_test.0",=0D
[   78s]     "dev":"ndbus0",=0D
[   78s]     "scrub_state":"idle",=0D
[   78s]     "firmware":{=0D
[   78s]       "activate_method":"suspend",=0D
[   78s]       "activate_state":"idle"=0D
[   78s]     }=0D
[   78s]   }=0D
[   78s] ]=0D
[   78s] test/pmem-errors.sh: failed at line 64=0D
[   78s] stderr:=0D
[   78s] + MNT=3Dtest_dax_mnt=0D
[   78s] + FILE=3Dimage=0D
[   78s] + rc=3D77=0D
[   78s] ++ dirname /usr/src/packages/BUILD/ndctl-73/test/pmem-errors.sh=0D
[   78s] + . /usr/src/packages/BUILD/ndctl-73/test/common=0D
[   78s] ++ '[' -z /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/ndctl=
/ndctl ']'=0D
[   78s] ++ '[' -z /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/daxct=
l/daxctl ']'=0D
[   78s] ++ '[' -z /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/test =
']'=0D
[   78s] ++ NFIT_TEST_BUS0=3Dnfit_test.0=0D
[   78s] ++ NFIT_TEST_BUS1=3Dnfit_test.1=0D
[   78s] ++ ACPI_BUS=3DACPI.NFIT=0D
[   78s] ++ E820_BUS=3De820=0D
[   78s] + check_min_kver 4.7=0D
[   78s] + local ver=3D4.7=0D
[   78s] ++ uname -r=0D
[   78s] + : 5.17.4-1-default=0D
[   78s] + '[' -n 4.7 ']'=0D
[   78s] ++ echo -e '4.7\n5.17.4-1-default'=0D
[   78s] ++ head -1=0D
[   78s] ++ sort -V=0D
[   78s] + [[ 4.7 =3D=3D \4\.\7 ]]=0D
[   78s] + set -e=0D
[   78s] + mkdir -p test_dax_mnt=0D
[   78s] + trap 'err $LINENO cleanup' ERR=0D
[   78s] + modprobe nfit_test=0D
[   78s] + reset=0D
[   78s] + /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl d=
isable-region -b nfit_test.0 all=0D
[   78s] disabled 6 regions=0D
[   78s] + /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl i=
nit-labels -f -b nfit_test.0 all=0D
[   78s] initialized 4 nmems=0D
[   78s] + /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl e=
nable-region -b nfit_test.0 all=0D
[   78s] enabled 6 regions=0D
[   78s] + rc=3D1=0D
[   78s] + dev=3Dx=0D
[   78s] ++ /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl =
create-namespace -b nfit_test.0 -t pmem -m raw=0D
[   78s] + json=3D'{=0D
[   78s]   "dev":"namespace1.0",=0D
[   78s]   "mode":"raw",=0D
[   78s]   "size":67108864,=0D
[   78s]   "uuid":"2856907b-3595-46a9-9e4f-8dd778d70833",=0D
[   78s]   "sector_size":512,=0D
[   78s]   "blockdev":"pmem1"=0D
[   78s] }'=0D
[   78s] ++ json2var=0D
[   78s] ++ sed -e 's/[{}",]//g; s/\[//g; s/\]//g; s/:/=3D/g'=0D
[   78s] ++ echo '{' '"dev":"namespace1.0",' '"mode":"raw",' '"size":671088=
64,' '"uuid":"2856907b-3595-46a9-9e4f-8dd778d70833",' '"sector_size":512,' =
'"blockdev":"pmem1"' '}'=0D
[   78s] + eval dev=3Dnamespace1.0 mode=3Draw size=3D67108864 uuid=3D285690=
7b-3595-46a9-9e4f-8dd778d70833 sector_size=3D512 blockdev=3Dpmem1=0D
[   78s] ++ dev=3Dnamespace1.0=0D
[   78s] ++ mode=3Draw=0D
[   78s] ++ size=3D67108864=0D
[   78s] ++ uuid=3D2856907b-3595-46a9-9e4f-8dd778d70833=0D
[   78s] ++ sector_size=3D512=0D
[   78s] ++ blockdev=3Dpmem1=0D
[   78s] + '[' namespace1.0 =3D x ']'=0D
[   78s] + '[' raw '!=3D' raw ']'=0D
[   78s] + err_sector=3D65536=0D
[   78s] + err_count=3D8=0D
[   78s] + read sector len=0D
[   78s] + /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl i=
nject-error --block=3D65536 --count=3D8 namespace1.0=0D
[   78s] + /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl s=
tart-scrub nfit_test.0=0D
[   78s] + /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl w=
ait-scrub nfit_test.0=0D
[   78s] + read sector len=0D
[   78s] + '[' 131072 -ne 131072 ']'=0D
[   78s] + dd if=3D/dev/pmem1 of=3D/dev/null iflag=3Ddirect bs=3D512 skip=
=3D65536 count=3D8=0D
[   78s] dd: error reading '/dev/pmem1': Input/output error=0D
[   78s] 0+0 records in=0D
[   78s] 0+0 records out=0D
[   78s] 0 bytes copied, 0.00223186 s, 0.0 kB/s=0D
[   78s] + dd of=3D/dev/pmem1 if=3D/dev/zero oflag=3Ddirect bs=3D512 seek=
=3D65536 count=3D8=0D
[   78s] 8+0 records in=0D
[   78s] 8+0 records out=0D
[   78s] 4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000940564 s, 4.4 MB/s=0D
[   78s] + read sector len=0D
[   78s] + mkfs.ext4 /dev/pmem1 -b 4096=0D
[   78s] /usr/src/packages/BUILD/ndctl-73/test/pmem-errors.sh: line 64: mkf=
s.ext4: command not found=0D
[   78s] ++ err 64 cleanup=0D
[   78s] +++ basename /usr/src/packages/BUILD/ndctl-73/test/pmem-errors.sh=
=0D
[   78s] ++ echo test/pmem-errors.sh: failed at line 64=0D
[   78s] ++ '[' -n cleanup ']'=0D
[   78s] ++ cleanup=0D
[   78s] ++ '[' -n pmem1 ']'=0D
[   78s] ++ umount /dev/pmem1=0D
[   78s] umount: /dev/pmem1: not mounted.=0D
[   78s] =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=0D
[   78s] =0D
[   78s]  6/23 ndctl:dax / daxdev-errors.sh         SKIP            0.07s  =
 exit status 77=0D
[   78s]  7/23 ndctl:dax / multi-dax.sh             SKIP            0.05s  =
 exit status 77=0D
[   83s] [   76.867823][ T2259] nd_pmem btt1.0: init: error in meta_init: -=
12=0D
[   83s]  8/23 ndctl:ndctl / btt-check.sh           FAIL            5.70s  =
 exit status 2=0D
[   83s] >>> DATA_PATH=3D/usr/src/packages/BUILD/ndctl-73/test DAXCTL=3D/us=
r/src/packages/BUILD/ndctl-73/x86_64-suse-linux/daxctl/daxctl TEST_PATH=3D/=
usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/test NDCTL=3D/usr/src/pac=
kages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl /usr/src/packages/BUILD/=
ndctl-73/test/btt-check.sh=0D
[   83s] =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=0D
[   83s] stdout:=0D
[   83s] =3D=3D=3D test_normal =3D=3D=3D=0D
[   83s] post_repair_test: I/O to BTT namespace=0D
[   83s] done=0D
[   83s] =3D=3D=3D test_force =3D=3D=3D=0D
[   83s] post_repair_test: I/O to BTT namespace=0D
[   83s] done=0D
[   83s] =3D=3D=3D test_bad_info2 =3D=3D=3D=0D
[   83s] set raw_mode: 1=0D
[   83s] wiping info2 block (offset =3D 16383 blocks)=0D
[   83s] set raw_mode: 0=0D
[   83s] namespace1.0: btt_copy_to_info2: Arena 0: BTT info2 needs to be re=
stored=0D
[   83s] Arena 0: Restoring BTT info2=0D
[   83s] post_repair_test: I/O to BTT namespace=0D
[   83s] done=0D
[   83s] =3D=3D=3D test_bad_info =3D=3D=3D=0D
[   83s] set raw_mode: 1=0D
[   83s] wiping info block=0D
[   83s] set raw_mode: 0=0D
[   83s] namespace1.0: btt_write_info: BTT info block at offset 0x1000 need=
s to be restored=0D
[   83s] post_repair_test: I/O to BTT namespace=0D
[   83s] done=0D
[   83s] =3D=3D=3D test_bitmap =3D=3D=3D=0D
[   83s] test/btt-check.sh: failed at line 31=0D
[   83s] stderr:=0D
[   83s] disabled 6 regions=0D
[   83s] initialized 4 nmems=0D
[   83s] enabled 6 regions=0D
[   83s] disabled 1 namespace=0D
[   83s] checked 1 namespace=0D
[   83s] enabled 1 namespace=0D
[   83s] checked 1 namespace=0D
[   83s] disabled 1 namespace=0D
[   83s] enabled 1 namespace=0D
[   83s] 1+0 records in=0D
[   83s] 1+0 records out=0D
[   83s] 4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000195241 s, 21.0 MB/s=0D
[   83s] disabled 1 namespace=0D
[   83s] enabled 1 namespace=0D
[   83s] disabled 1 namespace=0D
[   83s] checked 1 namespace=0D
[   83s] enabled 1 namespace=0D
[   83s] disabled 1 namespace=0D
[   83s] enabled 1 namespace=0D
[   83s] 2+0 records in=0D
[   83s] 2+0 records out=0D
[   83s] 8192 bytes (8.2 kB, 8.0 KiB) copied, 0.000159519 s, 51.4 MB/s=0D
[   83s] disabled 1 namespace=0D
[   83s] enabled 1 namespace=0D
[   83s] disabled 1 namespace=0D
[   83s] checked 1 namespace=0D
[   83s] enabled 1 namespace=0D
[   83s] disabled 6 regions=0D
[   83s] initialized 4 nmems=0D
[   83s] enabled 6 regions=0D
[   83s] libndctl: ndctl_btt_enable: btt1.0: failed to enable=0D
[   83s]   Error: namespace1.0: failed to enable=0D
[   83s] =0D
[   83s] failed to create namespace: No such device or address=0D
[   83s] =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=0D
[   83s] =0D
[   83s]  9/23 ndctl:ndctl / label-compat.sh        SKIP            0.06s  =
 exit status 77=0D
[   84s] 10/23 ndctl:ndctl / sector-mode.sh         SKIP            0.02s  =
 exit status 77=0D
[   84s] 11/23 ndctl:ndctl / inject-error.sh        SKIP            0.03s  =
 exit status 77=0D
[   84s] [   77.131436][ T2314] nd_pmem btt1.0: init: error in meta_init: -=
12=0D
[   84s] 12/23 ndctl:ndctl / btt-errors.sh          SKIP            0.13s  =
 exit status 77=0D
[   84s] 13/23 ndctl:ndctl / hugetlb                SKIP            0.02s  =
 exit status 77=0D
[   84s] [   77.271362][ T2330] nd_pmem btt1.0: init: error in meta_init: -=
12=0D
[   84s] 14/23 ndctl:ndctl / btt-pad-compat.sh      FAIL            0.12s  =
 exit status 1=0D
[   84s] >>> DATA_PATH=3D/usr/src/packages/BUILD/ndctl-73/test DAXCTL=3D/us=
r/src/packages/BUILD/ndctl-73/x86_64-suse-linux/daxctl/daxctl TEST_PATH=3D/=
usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/test NDCTL=3D/usr/src/pac=
kages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl /usr/src/packages/BUILD/=
ndctl-73/test/btt-pad-compat.sh=0D
[   84s] =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=0D
[   84s] stdout:=0D
[   84s] test/btt-pad-compat.sh: failed at line 26=0D
[   84s] stderr:=0D
[   84s] + dev=3D=0D
[   84s] + size=3D=0D
[   84s] + blockdev=3D=0D
[   84s] + rc=3D77=0D
[   84s] ++ dirname /usr/src/packages/BUILD/ndctl-73/test/btt-pad-compat.sh=
=0D
[   84s] + BASE=3D/usr/src/packages/BUILD/ndctl-73/test=0D
[   84s] + . /usr/src/packages/BUILD/ndctl-73/test/common=0D
[   84s] ++ '[' -z /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/ndctl=
/ndctl ']'=0D
[   84s] ++ '[' -z /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/daxct=
l/daxctl ']'=0D
[   84s] ++ '[' -z /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/test =
']'=0D
[   84s] ++ NFIT_TEST_BUS0=3Dnfit_test.0=0D
[   84s] ++ NFIT_TEST_BUS1=3Dnfit_test.1=0D
[   84s] ++ ACPI_BUS=3DACPI.NFIT=0D
[   84s] ++ E820_BUS=3De820=0D
[   84s] + trap 'err $LINENO' ERR=0D
[   84s] + modprobe nfit_test=0D
[   84s] + check_prereq xxd=0D
[   84s] + command -v xxd=0D
[   84s] + rc=3D1=0D
[   84s] + reset=0D
[   84s] + /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl d=
isable-region -b nfit_test.0 all=0D
[   84s] disabled 6 regions=0D
[   84s] + /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl i=
nit-labels -f -b nfit_test.0 all=0D
[   84s] initialized 4 nmems=0D
[   84s] + /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl e=
nable-region -b nfit_test.0 all=0D
[   84s] enabled 6 regions=0D
[   84s] + do_tests=0D
[   84s] + create=0D
[   84s] ++ /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl =
create-namespace -b nfit_test.0 -t pmem -m sector=0D
[   84s] libndctl: ndctl_btt_enable: btt1.0: failed to enable=0D
[   84s]   Error: namespace1.0: failed to enable=0D
[   84s] =0D
[   84s] failed to create namespace: No such device or address=0D
[   84s] +++ err 26=0D
[   84s] ++++ basename /usr/src/packages/BUILD/ndctl-73/test/btt-pad-compat=
=2Esh=0D
[   84s] +++ echo test/btt-pad-compat.sh: failed at line 26=0D
[   84s] +++ '[' -n '' ']'=0D
[   84s] +++ exit 1=0D
[   84s] + json=3D'test/btt-pad-compat.sh: failed at line 26'=0D
[   84s] ++ err 26=0D
[   84s] +++ basename /usr/src/packages/BUILD/ndctl-73/test/btt-pad-compat.=
sh=0D
[   84s] ++ echo test/btt-pad-compat.sh: failed at line 26=0D
[   84s] ++ '[' -n '' ']'=0D
[   84s] ++ exit 1=0D
[   84s] =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=0D
[   84s] =0D
[   84s] 15/23 ndctl:ndctl / firmware-update.sh     SKIP            0.14s  =
 exit status 77=0D
[   84s] 16/23 ndctl:ndctl / ack-shutdown-count-set SKIP            0.02s  =
 exit status 77=0D
[   84s] 17/23 ndctl:ndctl / rescan-partitions.sh   SKIP            0.05s  =
 exit status 77=0D
[   84s] 18/23 ndctl:ndctl / inject-smart.sh        SKIP            0.05s  =
 exit status 77=0D
[   84s] 19/23 ndctl:ndctl / monitor.sh             SKIP            0.03s  =
 exit status 77=0D
[   84s] 20/23 ndctl:ndctl / max_extent_ns          SKIP            0.06s  =
 exit status 77=0D
[   94s] 21/23 ndctl:ndctl / pfn-meta-errors.sh     OK              9.89s=0D
[   94s] [   87.657417][ T2483] nfit_test nfit_test.0: failed to evaluate _=
FIT=0D
[   94s] [   87.662677][ T2483] nfit_test nfit_test.1: Error found in NVDIM=
M nmem4 flags: save_fail restore_fail flush_fail not_armed=0D
[   94s] [   87.663055][ T2483] nfit_test nfit_test.1: Error found in NVDIM=
M nmem5 flags: map_fail=0D
[   95s] 22/23 ndctl:ndctl / track-uuid.sh          OK              0.55s=0D
[   95s] [   88.241521][ T2519] nfit_test nfit_test.0: failed to evaluate _=
FIT=0D
[   95s] [   88.248812][ T2519] nfit_test nfit_test.1: Error found in NVDIM=
M nmem4 flags: save_fail restore_fail flush_fail not_armed=0D
[   95s] [   88.249519][ T2519] nfit_test nfit_test.1: Error found in NVDIM=
M nmem5 flags: map_fail=0D
[   95s] 23/23 ndctl:ndctl / security.sh            FAIL            0.22s  =
 exit status 1=0D
[   95s] >>> DATA_PATH=3D/usr/src/packages/BUILD/ndctl-73/test DAXCTL=3D/us=
r/src/packages/BUILD/ndctl-73/x86_64-suse-linux/daxctl/daxctl TEST_PATH=3D/=
usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/test NDCTL=3D/usr/src/pac=
kages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl /usr/src/packages/BUILD/=
ndctl-73/test/security.sh=0D
[   95s] =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=0D
[   95s] stdout:=0D
[   95s] test/security.sh: failed at line 25=0D
[   95s] stderr:=0D
[   95s] + rc=3D77=0D
[   95s] + dev=3D=0D
[   95s] + id=3D=0D
[   95s] + keypath=3D/etc/ndctl/keys=0D
[   95s] + masterkey=3Dnvdimm-master=0D
[   95s] + masterpath=3D/etc/ndctl/keys/nvdimm-master.blob=0D
[   95s] + backup_key=3D0=0D
[   95s] + backup_handle=3D0=0D
[   95s] ++ dirname /usr/src/packages/BUILD/ndctl-73/test/security.sh=0D
[   95s] + . /usr/src/packages/BUILD/ndctl-73/test/common=0D
[   95s] ++ '[' -z /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/ndctl=
/ndctl ']'=0D
[   95s] ++ '[' -z /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/daxct=
l/daxctl ']'=0D
[   95s] ++ '[' -z /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/test =
']'=0D
[   95s] ++ NFIT_TEST_BUS0=3Dnfit_test.0=0D
[   95s] ++ NFIT_TEST_BUS1=3Dnfit_test.1=0D
[   95s] ++ ACPI_BUS=3DACPI.NFIT=0D
[   95s] ++ E820_BUS=3De820=0D
[   95s] + trap 'err $LINENO' ERR=0D
[   95s] + check_min_kver 5.0=0D
[   95s] + local ver=3D5.0=0D
[   95s] ++ uname -r=0D
[   95s] + : 5.17.4-1-default=0D
[   95s] + '[' -n 5.0 ']'=0D
[   95s] ++ echo -e '5.0\n5.17.4-1-default'=0D
[   95s] ++ head -1=0D
[   95s] ++ sort -V=0D
[   95s] + [[ 5.0 =3D=3D \5\.\0 ]]=0D
[   95s] ++ keyctl show=0D
[   95s] ++ head -1=0D
[   95s] ++ cut -d. -f2-=0D
[   95s] ++ grep -Eo '_uid.[0-9]+'=0D
[   95s] + uid=3D0=0D
[   95s] + '[' 0 -ne 0 ']'=0D
[   95s] + modprobe nfit_test=0D
[   95s] + setup=0D
[   95s] + /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl d=
isable-region -b nfit_test.0 all=0D
[   95s] disabled 6 regions=0D
[   95s] + check_prereq keyctl=0D
[   95s] + command -v keyctl=0D
[   95s] + rc=3D1=0D
[   95s] + detect=0D
[   95s] ++ /usr/src/packages/BUILD/ndctl-73/x86_64-suse-linux/ndctl/ndctl =
list -b nfit_test.0 -D=0D
[   95s] ++ jq -r '.[0].dev'=0D
[   95s] /usr/src/packages/BUILD/ndctl-73/test/security.sh: line 25: jq: co=
mmand not found=0D
[   95s] +++ err 25=0D
[   95s] ++++ basename /usr/src/packages/BUILD/ndctl-73/test/security.sh=0D
[   95s] +++ echo test/security.sh: failed at line 25=0D
[   95s] +++ '[' -n '' ']'=0D
[   95s] +++ exit 1=0D
[   95s] + dev=3D'test/security.sh: failed at line 25'=0D
[   95s] ++ err 25=0D
[   95s] +++ basename /usr/src/packages/BUILD/ndctl-73/test/security.sh=0D
[   95s] ++ echo test/security.sh: failed at line 25=0D
[   95s] ++ '[' -n '' ']'=0D
[   95s] ++ exit 1=0D
[   95s] =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=0D
[   95s] =0D
[   95s] =0D
[   95s] Summary of Failures:=0D
[   95s] =0D
[   95s]  3/23 ndctl:ndctl / create.sh              FAIL            0.51s  =
 exit status 1=0D
[   95s]  5/23 ndctl:ndctl / pmem-errors.sh         FAIL           12.38s  =
 exit status 32=0D
[   95s]  8/23 ndctl:ndctl / btt-check.sh           FAIL            5.70s  =
 exit status 2=0D
[   95s] 14/23 ndctl:ndctl / btt-pad-compat.sh      FAIL            0.12s  =
 exit status 1=0D
[   95s] 23/23 ndctl:ndctl / security.sh            FAIL            0.22s  =
 exit status 1=0D
[   95s] =0D
[   95s] =0D
[   95s] Ok:                 3   =0D
[   95s] Expected Fail:      0   =0D
[   95s] Fail:               5   =0D
[   95s] Unexpected Pass:    0   =0D
[   95s] Skipped:            15  =0D
[   95s] Timeout:            0   =0D
[   95s] =0D
[   95s] Full log written to /usr/src/packages/BUILD/ndctl-73/x86_64-suse-l=
inux/meson-logs/testlog.txt=0D
[   95s] error: Bad exit status from /var/tmp/rpm-tmp.ZNNQ9N (%build)=0D
[   95s] =0D
[   95s] =0D
[   95s] RPM build errors:=0D
[   95s]     Bad exit status from /var/tmp/rpm-tmp.ZNNQ9N (%build)=0D
[   95s] Failed to write wtmp record, ignoring: Read-only file system=0D
[   95s] Failed to write utmp record: Read-only file system=0D
[   95s] Powering off.=0D
[   95s] [   88.858291][ T2538] reboot: Power down=0D

--5mCyUwZo2JvN/JJP--

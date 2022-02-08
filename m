Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880F44ADB5C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351250AbiBHOil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351341AbiBHOiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:38:23 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB99C03FECE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 06:38:21 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k6-20020a05600c1c8600b003524656034cso1820125wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 06:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0HR5VAm488E8jgdmiu/QMQOKm7/HI0OvplQKa/slHIA=;
        b=A5cWEKRGfnrlw8fds6rIf9tvqgO+Vc2DpF0ipuZCFlWH3wH8uPfI/6R5aDXqJmt70v
         XZ7FPHgxtnfReQy/lkD5wcQZTt7P9K++I32bH9IEs19h+FdWvfEblaGq7YrtwVBv2BGV
         HkaY1hjjAAhi8guZKbpL6trEdF/Fap1fLggu9tJgMa1UAH5zVQssw71UxfDm+ILo/aKP
         atxQ8NeSItEdJpKFX80tAphRcXTz41+tSeMbnXpQ+fBJFN8x8ExU1W9UX1d7mPb1B2s2
         orVsw0v+aKXmYQiMhaq9PFnoScZW5lgnKjU1wvFxZ9SWpPetR/PB2pRdV8Ya7GmZZGdu
         GXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0HR5VAm488E8jgdmiu/QMQOKm7/HI0OvplQKa/slHIA=;
        b=OECZer4quMyj0OCqHGk6AVIldnf8y6taW6Kp6qQlloc2aM7aPJPeeRgo92sN5ES8p/
         AIpNt0wv7b9tHVtd9nKzAGtaEDyzmuvLJzhgiGKudj0+MK9jzLyZNP5f+C1rPAYbANUN
         q20DPlOBUWyAvBJsHAs4955eih4SRljdj9QzNCDw/UzML0l1uJpMagkZZUKD5i4VaWEz
         3wCGzc4cvjKKECn7H4gz9V7HspfdNVqFnBU5HDHDKQgOtURRpQOcwlfFBVEEr+UJ7jzD
         g96Wbamb6YH5Q9KHJR398jvKETHg1F93wKOPtF2ImcavQLxs5/edeJB/3yC2RB4SqBSk
         GoYA==
X-Gm-Message-State: AOAM530Gek7odXOLuxHRm9phV3uurBYYFgi0qE/vHbuYLuAHGK2Oakm0
        mJWFW76bjzWb00IXN4Pjqeo=
X-Google-Smtp-Source: ABdhPJxOdUacZ+AWBNPYDNpjSPdetxsR1IBwYx3y6EU4d/IqBXQbouqUOlBKM/YMKLe0HkuXCH0vWQ==
X-Received: by 2002:a05:600c:3544:: with SMTP id i4mr1396234wmq.23.1644331100332;
        Tue, 08 Feb 2022 06:38:20 -0800 (PST)
Received: from leap.localnet (host-95-245-2-16.retail.telecomitalia.it. [95.245.2.16])
        by smtp.gmail.com with ESMTPSA id p14sm14436426wrr.7.2022.02.08.06.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 06:38:19 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Cc:     syzbot <syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com>
Subject: Re: [syzbot] WARNING in component_del
Date:   Tue, 08 Feb 2022 15:38:17 +0100
Message-ID: <2114181.C4sosBPzcN@leap>
In-Reply-To: <0000000000001e4c2e05d77cfcbb@google.com>
References: <0000000000001e4c2e05d77cfcbb@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2446644.4XsnlVU6TS"
Content-Transfer-Encoding: 7Bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart2446644.4XsnlVU6TS
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On marted=C3=AC 8 febbraio 2022 08:51:29 CET syzbot wrote:
> syzbot has found a reproducer for the following issue on:
>=20
> HEAD commit:    555f3d7be91a Merge tag '5.17-rc3-ksmbd-server-fixes' of g=
i..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D130a0c2c700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D266de9da75c71=
a45
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D60df062e1c41940=
cae0f
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binuti=
ls for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15880d84700=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14de0c77b00000
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com
>=20
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 3598 at drivers/base/component.c:767 component_del+0=
x40c/0x540 drivers/base/component.c:765
> Modules linked in:
> CPU: 0 PID: 3598 Comm: syz-executor255 Not tainted 5.17.0-rc3-syzkaller-0=
0020-g555f3d7be91a #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/01/2011
> RIP: 0010:component_del+0x40c/0x540 drivers/base/component.c:767
> Code: 00 48 39 6b 20 75 82 e8 72 b1 07 fd 48 c7 43 20 00 00 00 00 e9 70 f=
f ff ff e8 60 b1 07 fd 48 c7 c7 20 aa 67 8c e8 84 d4 db 04 <0f> 0b 31 ed e8=
 4b b1 07 fd 48 89 ef 5b 5d 41 5c 41 5d 41 5e 41 5f
> RSP: 0018:ffffc90001aafa68 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffff8880745c8000
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffc90001aaf9b0
> RBP: ffffffff8c67a9e0 R08: 0000000000000001 R09: ffffc90001aaf9b7
> R10: fffff52000355f36 R11: 0000000000000001 R12: ffff88801dce5008
> R13: ffffffff8a4c0dc0 R14: ffff88801dce5008 R15: ffff88801dce5000
> FS:  0000555556461300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fb3739a5130 CR3: 000000001996f000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  usb_hub_remove_port_device+0x272/0x370 drivers/usb/core/port.c:653
>  hub_disconnect+0x171/0x510 drivers/usb/core/hub.c:1737
>  usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
>  __device_release_driver+0x5d7/0x700 drivers/base/dd.c:1206
>  device_release_driver_internal drivers/base/dd.c:1237 [inline]
>  device_release_driver+0x26/0x40 drivers/base/dd.c:1260
>  usb_driver_release_interface+0x102/0x180 drivers/usb/core/driver.c:627
>  proc_ioctl.part.0+0x4d6/0x560 drivers/usb/core/devio.c:2332
>  proc_ioctl drivers/usb/core/devio.c:170 [inline]
>  proc_ioctl_default drivers/usb/core/devio.c:2375 [inline]
>  usbdev_do_ioctl drivers/usb/core/devio.c:2731 [inline]
>  usbdev_ioctl+0x2b29/0x36c0 drivers/usb/core/devio.c:2791
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:874 [inline]
>  __se_sys_ioctl fs/ioctl.c:860 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7fb3739346f9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff3db9d808 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fb373978194 RCX: 00007fb3739346f9
> RDX: 0000000020000380 RSI: 00000000c0105512 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 00007fff3db9d280 R09: 0000000000000001
> R10: 000000000000ffff R11: 0000000000000246 R12: 00007fff3db9d81c
> R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
>=20
> --=20
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/0000000000001e4c2e05d77cfcbb%40google.com.
>=20
#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 master

--nextPart2446644.4XsnlVU6TS
Content-Disposition: attachment; filename="diff"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="diff"

diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index c2bbf97a79be..8455b235976a 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -605,8 +605,11 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 	find_and_link_peer(hub, port1);
 
 	retval = component_add(&port_dev->dev, &connector_ops);
-	if (retval)
+	if (retval) {
 		dev_warn(&port_dev->dev, "failed to add component\n");
+		device_unregister(&port_dev->dev);
+		return retval;
+	}
 
 	/*
 	 * Enable runtime pm and hold a refernce that hub_configure()

--nextPart2446644.4XsnlVU6TS--




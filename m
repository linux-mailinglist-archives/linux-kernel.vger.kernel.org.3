Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38AF4AD286
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 08:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348614AbiBHHvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 02:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbiBHHva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 02:51:30 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94E1C0401EF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 23:51:29 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id g14-20020a056e021e0e00b002a26cb56bd4so10754359ila.14
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 23:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=f+PS8bYwF5wBhMvgVJjLy1tyVfgdFtf4D2GhyeRWiOg=;
        b=DZaGHNwq6dBtN8XttIvjuup3WBQGRusTNP0JDlZQaJoqa0UxS66DE3z2ihojkyelAZ
         /akXJMezA+2Ph/DpWdbyscwHpB031Wt82txCyVe0CGxuBpUwQj/WYNXIrSPckqa9/D3b
         hpa3Pzu/0szsIscHd1MdeO5ln1fppBO1JjjsBl9U4q4V2K79EXvvo9rm4VjNcRxkJ3qy
         o2az1Ptlb6rVQ6JPWumDzxFfQkj6oRlRBrdw0UlyOVWxAKOLOvGnSZ6aTO8G/VymtGih
         GeQ0q4bTfD1ErXY8Z0sBjoe3lhNGjTvGg8W3ShdKqV+qhf6I/q6T7LT2UjsLq4iRClW4
         4pbA==
X-Gm-Message-State: AOAM532R6f8HG3VOTsVCTlZNak73O7AYAuUmgVAioeKwr3owrKfncG1N
        8KDbJ8oLGPoWJ41HWoRk4u+ltpvlTjuuTJfm5ZS9qWKIvfMf
X-Google-Smtp-Source: ABdhPJztnn1YEJ0TMUD57Lu2Md6Du6wd1J/i/PO2DCxV9ey6Vq/j+ereZKbMz1nZFzkFMgz0eNnlgPhqo0CxN2Kj/zBQHhA2IezH
MIME-Version: 1.0
X-Received: by 2002:a92:1311:: with SMTP id 17mr1605580ilt.42.1644306689312;
 Mon, 07 Feb 2022 23:51:29 -0800 (PST)
Date:   Mon, 07 Feb 2022 23:51:29 -0800
In-Reply-To: <00000000000016f4ae05d5cec832@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001e4c2e05d77cfcbb@google.com>
Subject: Re: [syzbot] WARNING in component_del
From:   syzbot <syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com>
To:     dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    555f3d7be91a Merge tag '5.17-rc3-ksmbd-server-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130a0c2c700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=266de9da75c71a45
dashboard link: https://syzkaller.appspot.com/bug?extid=60df062e1c41940cae0f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15880d84700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14de0c77b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3598 at drivers/base/component.c:767 component_del+0x40c/0x540 drivers/base/component.c:765
Modules linked in:
CPU: 0 PID: 3598 Comm: syz-executor255 Not tainted 5.17.0-rc3-syzkaller-00020-g555f3d7be91a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:component_del+0x40c/0x540 drivers/base/component.c:767
Code: 00 48 39 6b 20 75 82 e8 72 b1 07 fd 48 c7 43 20 00 00 00 00 e9 70 ff ff ff e8 60 b1 07 fd 48 c7 c7 20 aa 67 8c e8 84 d4 db 04 <0f> 0b 31 ed e8 4b b1 07 fd 48 89 ef 5b 5d 41 5c 41 5d 41 5e 41 5f
RSP: 0018:ffffc90001aafa68 EFLAGS: 00010286
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffff8880745c8000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffc90001aaf9b0
RBP: ffffffff8c67a9e0 R08: 0000000000000001 R09: ffffc90001aaf9b7
R10: fffff52000355f36 R11: 0000000000000001 R12: ffff88801dce5008
R13: ffffffff8a4c0dc0 R14: ffff88801dce5008 R15: ffff88801dce5000
FS:  0000555556461300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb3739a5130 CR3: 000000001996f000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 usb_hub_remove_port_device+0x272/0x370 drivers/usb/core/port.c:653
 hub_disconnect+0x171/0x510 drivers/usb/core/hub.c:1737
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 __device_release_driver+0x5d7/0x700 drivers/base/dd.c:1206
 device_release_driver_internal drivers/base/dd.c:1237 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1260
 usb_driver_release_interface+0x102/0x180 drivers/usb/core/driver.c:627
 proc_ioctl.part.0+0x4d6/0x560 drivers/usb/core/devio.c:2332
 proc_ioctl drivers/usb/core/devio.c:170 [inline]
 proc_ioctl_default drivers/usb/core/devio.c:2375 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2731 [inline]
 usbdev_ioctl+0x2b29/0x36c0 drivers/usb/core/devio.c:2791
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fb3739346f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff3db9d808 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fb373978194 RCX: 00007fb3739346f9
RDX: 0000000020000380 RSI: 00000000c0105512 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fff3db9d280 R09: 0000000000000001
R10: 000000000000ffff R11: 0000000000000246 R12: 00007fff3db9d81c
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>


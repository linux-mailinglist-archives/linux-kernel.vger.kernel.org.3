Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C68259B1C2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 06:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiHUEoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 00:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHUEo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 00:44:26 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEAA14087
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 21:44:24 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id k9-20020a056e021a8900b002e5bd940e96so6056703ilv.13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 21:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=bVZXnPdyq13OL3gTqrTuRwM/LzaBY2wVApRqSobDy+M=;
        b=EUw3i10HvHqDiQ1PYgqhNYFqF7PtPmHSTUvkeHVwcWkMFjQ2Pl5KzqpJyLW/RuzWBh
         wuoEExJRmWma1z0P9w/lhHkWkkdT9rzAxulrTXJwjxmBvx+qN3/pK5GGCuJ0lxE6lnWA
         SJ1iM0qo8Yic2/MGASL5XSwW/EmwHjEjBRZC0NBPlmWBLxOQWi0cdANd7+Y48/aKxpTa
         4qndJ0MOKrGboVpI7IRPT+pI7UY0dLyW94Ojy085mfO/OQKf06zw5V4gCSxorXxGHR8d
         MHG2IhUEQAe+bpmE8hZiNZLi4ngia36+IAgS92U0d39XkqMJNbWRvUS/s/9scdswo+nF
         NCIw==
X-Gm-Message-State: ACgBeo0djTzZOZeCrX48E8kpkPstSZ+0JMBKwkez0aVjwlMbgyocEcrA
        BEk8qYst13hZ1iO093NSV4V+Ux1dVvqWrm8H8Bw1wLa0ZoyM
X-Google-Smtp-Source: AA6agR4li2Niup/6JXfm8rwixUjv0fRIYSvRlavbxJvrRzUgYLE7razoFui2K7MDR37gpymzYNK4fxtM534c95mw32IKKOR0pwLD
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bc8:b0:2e9:8401:477a with SMTP id
 x8-20020a056e021bc800b002e98401477amr1529904ilv.265.1661057064062; Sat, 20
 Aug 2022 21:44:24 -0700 (PDT)
Date:   Sat, 20 Aug 2022 21:44:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004155f505e6b8fc3b@google.com>
Subject: [syzbot] upstream boot error: BUG: unable to handle kernel paging
 request in kobject_add
From:   syzbot <syzbot+995136d881b59882b2b6@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
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

Hello,

syzbot found the following issue on:

HEAD commit:    3cc40a443a04 Merge tag 'nios2_fixes_v6.0' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1525710d080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b9175e0879a7749
dashboard link: https://syzkaller.appspot.com/bug?extid=995136d881b59882b2b6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+995136d881b59882b2b6@syzkaller.appspotmail.com

usbcore: registered new interface driver nfcmrvl
Loading iSCSI transport class v2.0-870.
scsi host0: Virtio SCSI HBA
st: Version 20160209, fixed bufsize 32768, s/g segs 256
Rounding down aligned max_sectors from 4294967295 to 4294967288
db_root: cannot open: /etc/target
slram: not enough parameters.
ftl_cs: FTL header not found.
wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for information.
wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
eql: Equalizer2002: Simon Janes (simon@ncm.com) and David S. Miller (davem@redhat.com)
MACsec IEEE 802.1AE
tun: Universal TUN/TAP device driver, 1.6
vcan: Virtual CAN interface driver
vxcan: Virtual CAN Tunnel driver
slcan: serial line CAN interface driver
CAN device driver interface
usbcore: registered new interface driver usb_8dev
usbcore: registered new interface driver ems_usb
usbcore: registered new interface driver gs_usb
usbcore: registered new interface driver kvaser_usb
usbcore: registered new interface driver mcba_usb
usbcore: registered new interface driver peak_usb
e100: Intel(R) PRO/100 Network Driver
e100: Copyright(c) 1999-2006 Intel Corporation
e1000: Intel(R) PRO/1000 Network Driver
e1000: Copyright (c) 1999-2006 Intel Corporation.
e1000e: Intel(R) PRO/1000 Network Driver
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
mkiss: AX.25 Multikiss, Hans Albas PE1AYX
AX.25: 6pack driver, Revision: 0.3.0
AX.25: bpqether driver version 004
PPP generic driver version 2.4.2
PPP BSD Compression module registered
PPP Deflate Compression module registered
PPP MPPE Compression module registered
NET: Registered PF_PPPOX protocol family
PPTP driver version 0.8.5
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256) (6 bit encapsulation enabled).
CSLIP: code copyright 1989 Regents of the University of California.
SLIP linefill/keepalive option.
hdlc: HDLC support module revision 1.22
LAPB Ethernet driver version 0.02
usbcore: registered new interface driver ath9k_htc
usbcore: registered new interface driver carl9170
usbcore: registered new interface driver ath6kl_usb
usbcore: registered new interface driver ar5523
usbcore: registered new interface driver ath10k_usb
usbcore: registered new interface driver rndis_wlan
mac80211_hwsim: initializing netlink
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc1-syzkaller-00017-g3cc40a443a04 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:string_nocheck lib/vsprintf.c:643 [inline]
RIP: 0010:string+0x1bb/0x3d0 lib/vsprintf.c:725
Code: 48 3b 5c 24 08 74 4b e8 e3 42 59 fd 48 89 df 48 83 c3 01 48 b9 00 00 00 00 00 fc ff df 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <0f> b6 04 08 38 d0 7f 08 84 c0 0f 85 cc 01 00 00 44 0f b6 63 ff 31
RSP: 0000:ffffc90000067410 EFLAGS: 00010046
RAX: 1fffe00000000000 RBX: ffff000000000001 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffffffff8422c86d RDI: ffff000000000000
RBP: ffffc900000676eb R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000001 R12: 00000000ffffffff
R13: ffffc900000676e8 R14: ffff000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc0000000000 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vsnprintf+0x71b/0x14f0 lib/vsprintf.c:2782
 vprintk_store+0x2d8/0xae0 kernel/printk/printk.c:2155
 vprintk_emit+0x14c/0x5f0 kernel/printk/printk.c:2252
 vprintk+0x80/0x90 kernel/printk/printk_safe.c:50
 _printk+0xba/0xed kernel/printk/printk.c:2292
 kobject_add.cold+0x4a/0x5e lib/kobject.c:404
 device_add+0x368/0x1e90 drivers/base/core.c:3452
 device_create_groups_vargs+0x203/0x280 drivers/base/core.c:4194
 device_create+0xdf/0x120 drivers/base/core.c:4236
 mac80211_hwsim_new_radio+0x3ab/0x4dd0 drivers/net/wireless/mac80211_hwsim.c:3821
 init_mac80211_hwsim+0x5aa/0x73b drivers/net/wireless/mac80211_hwsim.c:5379
 do_one_initcall+0xfe/0x650 init/main.c:1296
 do_initcall_level init/main.c:1369 [inline]
 do_initcalls init/main.c:1385 [inline]
 do_basic_setup init/main.c:1404 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1611
 kernel_init+0x1a/0x1d0 init/main.c:1500
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
CR2: ffffdc0000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:string_nocheck lib/vsprintf.c:643 [inline]
RIP: 0010:string+0x1bb/0x3d0 lib/vsprintf.c:725
Code: 48 3b 5c 24 08 74 4b e8 e3 42 59 fd 48 89 df 48 83 c3 01 48 b9 00 00 00 00 00 fc ff df 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <0f> b6 04 08 38 d0 7f 08 84 c0 0f 85 cc 01 00 00 44 0f b6 63 ff 31
RSP: 0000:ffffc90000067410 EFLAGS: 00010046
RAX: 1fffe00000000000 RBX: ffff000000000001 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffffffff8422c86d RDI: ffff000000000000
RBP: ffffc900000676eb R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000001 R12: 00000000ffffffff
R13: ffffc900000676e8 R14: ffff000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc0000000000 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 3b 5c 24 08       	cmp    0x8(%rsp),%rbx
   5:	74 4b                	je     0x52
   7:	e8 e3 42 59 fd       	callq  0xfd5942ef
   c:	48 89 df             	mov    %rbx,%rdi
   f:	48 83 c3 01          	add    $0x1,%rbx
  13:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  1a:	fc ff df
  1d:	48 89 f8             	mov    %rdi,%rax
  20:	48 89 fa             	mov    %rdi,%rdx
  23:	48 c1 e8 03          	shr    $0x3,%rax
  27:	83 e2 07             	and    $0x7,%edx
* 2a:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax <-- trapping instruction
  2e:	38 d0                	cmp    %dl,%al
  30:	7f 08                	jg     0x3a
  32:	84 c0                	test   %al,%al
  34:	0f 85 cc 01 00 00    	jne    0x206
  3a:	44 0f b6 63 ff       	movzbl -0x1(%rbx),%r12d
  3f:	31                   	.byte 0x31


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

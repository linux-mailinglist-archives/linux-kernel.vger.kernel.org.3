Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26575956E7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbiHPJpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbiHPJpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:45:17 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CB1201AD
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:36:24 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id n13-20020a056e02140d00b002dfa5464967so6610090ilo.19
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=eNWO53sDhcW1Rvld7RgiYbE4mnEsunJEPpn1lTZT5Ho=;
        b=1+YFmkZNRGgl42qVlRZgEX+xJ6D4EIQ92DQ/m/WFIo9ArXpf9H34vUDbI0eMradeR9
         FqeObCC6boBdojbn8JHPAKhX5rUkFOC4d/N9nb3noxY7wtoo4KKjIk7GJZch0e7ywmsM
         EAQ0D8lPqdXjmXYVSRVrZGuib4t/h+cTnrfIucUR6aBfSk8RZ/Zb8MfoR2eBsrwtU8J3
         emiTkEKZKPTUQMNK2TTbo/aoNWd9/Xy6QjM7xeCJWKCwJ718iPnTdMmzpCFIUv1wIoWE
         WOP6OArzzfUs/mLGSWCrC4gCvFdHp1LKlxLNTyQT5dCWOcNt1tGU9vkt+4eZe5cLlSsf
         prOQ==
X-Gm-Message-State: ACgBeo2qjsMre954JGTJFAduW0EME9eQyw3F6igHczQ5pTl2EEYQorR7
        5zaitEhnwaKhgH8Lsn8RTHypYi5nV8v+E7ZNqKIaSKrJNPdd
X-Google-Smtp-Source: AA6agR7XSAW/tXIkh889Aj8VoOdFw9iKOC3nLpobcnUVnfHtlnndaXOVQ5jYvCJQh0NARdkkxKGQR8dgLAOVqtk3so56SCRA6hHC
MIME-Version: 1.0
X-Received: by 2002:a05:6638:25d3:b0:342:fa3d:1275 with SMTP id
 u19-20020a05663825d300b00342fa3d1275mr9729266jat.70.1660638983648; Tue, 16
 Aug 2022 01:36:23 -0700 (PDT)
Date:   Tue, 16 Aug 2022 01:36:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b87c4405e657a415@google.com>
Subject: [syzbot] upstream boot error: BUG: unable to handle kernel paging
 request in media_entity_pads_init
From:   syzbot <syzbot+47c70875ed0bc4fdc9f4@syzkaller.appspotmail.com>
To:     laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, syzkaller-bugs@googlegroups.com
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

HEAD commit:    568035b01cfb Linux 6.0-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160e6b35080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=126b81cc3ce4f07e
dashboard link: https://syzkaller.appspot.com/bug?extid=47c70875ed0bc4fdc9f4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47c70875ed0bc4fdc9f4@syzkaller.appspotmail.com

usbcore: registered new interface driver spca501
usbcore: registered new interface driver spca505
usbcore: registered new interface driver spca506
usbcore: registered new interface driver spca508
usbcore: registered new interface driver spca561
usbcore: registered new interface driver spca1528
usbcore: registered new interface driver sq905
usbcore: registered new interface driver sq905c
usbcore: registered new interface driver sq930x
usbcore: registered new interface driver sunplus
usbcore: registered new interface driver stk014
usbcore: registered new interface driver stk1135
usbcore: registered new interface driver stv0680
usbcore: registered new interface driver t613
usbcore: registered new interface driver gspca_topro
usbcore: registered new interface driver touptek
usbcore: registered new interface driver tv8532
usbcore: registered new interface driver vc032x
usbcore: registered new interface driver vicam
usbcore: registered new interface driver xirlink-cit
usbcore: registered new interface driver gspca_zc3xx
usbcore: registered new interface driver ALi m5602
usbcore: registered new interface driver STV06xx
usbcore: registered new interface driver gspca_gl860
usbcore: registered new interface driver hackrf
usbcore: registered new interface driver msi2500
usbcore: registered new interface driver Philips webcam
usbcore: registered new interface driver uvcvideo
au0828: au0828 driver loaded
usbcore: registered new interface driver au0828
cpia2: V4L-Driver for Vision CPiA2 based cameras v3.0.1
usbcore: registered new interface driver cpia2
usbcore: registered new interface driver cx231xx
usbcore: registered new interface driver em28xx
em28xx: Registered (Em28xx v4l2 Extension) extension
em28xx: Registered (Em28xx Audio Extension) extension
em28xx: Registered (Em28xx dvb Extension) extension
em28xx: Registered (Em28xx Input Extension) extension
usbcore: registered new interface driver go7007
usbcore: registered new interface driver go7007-loader
usbcore: registered new interface driver hdpvr
usbcore: registered new interface driver pvrusb2
pvrusb2: V4L in-tree version:Hauppauge WinTV-PVR-USB2 MPEG2 Encoder/Tuner
pvrusb2: Debug mask is 31 (0x1f)
usbcore: registered new interface driver stk1160
usbcore: registered new interface driver tm6000
usbcore: registered new interface driver usbtv
dvbdev: DVB: registering new adapter (dvb_vidtv_bridge)
i2c i2c-0: DVB: registering adapter 0 frontend 0 (Dummy demod for DVB-T/T2/C/S/S2)...
dvbdev: dvb_create_media_entity: media entity 'Dummy demod for DVB-T/T2/C/S/S2' registered.
BUG: unable to handle page fault for address: 00000881b7bf0118
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 0 P4D 0 
Oops: 0002 [#1] PREEMPT SMP
CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W          6.0.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:arch_atomic64_try_cmpxchg arch/x86/include/asm/atomic64_64.h:190 [inline]
RIP: 0010:arch_atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-long.h:443 [inline]
RIP: 0010:atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:1781 [inline]
RIP: 0010:__mutex_trylock_fast kernel/locking/mutex.c:171 [inline]
RIP: 0010:mutex_lock+0x14/0x30 kernel/locking/mutex.c:285
Code: 84 00 00 00 00 00 be 02 00 00 00 e9 86 f8 ff ff 66 0f 1f 44 00 00 55 48 89 fd 2e 2e 2e 31 c0 31 c0 65 48 8b 14 25 80 ad 01 00 <f0> 48 0f b1 55 00 75 02 5d c3 48 89 ef 5d eb cc 66 66 2e 0f 1f 84
RSP: 0000:ffffc90000273b68 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000881b7bf0000 RCX: 0000000000000000
RDX: ffff888101818040 RSI: ffffffff83098dc5 RDI: 00000881b7bf0118
RBP: 00000881b7bf0118 R08: 0000000000000003 R09: 00000000000001ff
R10: 0000000000000001 R11: 000000000002f8b8 R12: 00000881b7bf0118
R13: ffff888141351500 R14: ffff888142493000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000881b7bf0118 CR3: 0000000005a29000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 media_entity_pads_init+0x64/0x1d0 drivers/media/mc/mc-entity.c:205
 dvb_create_tsout_entity drivers/media/dvb-core/dvbdev.c:271 [inline]
 dvb_create_tsout_entity+0x149/0x190 drivers/media/dvb-core/dvbdev.c:243
 dvb_create_media_entity drivers/media/dvb-core/dvbdev.c:301 [inline]
 dvb_register_media_device drivers/media/dvb-core/dvbdev.c:394 [inline]
 dvb_register_device+0x291/0x7d0 drivers/media/dvb-core/dvbdev.c:514
 dvb_dmxdev_init+0x144/0x200 drivers/media/dvb-core/dmxdev.c:1425
 vidtv_bridge_dmxdev_init drivers/media/test-drivers/vidtv/vidtv_bridge.c:337 [inline]
 vidtv_bridge_dvb_init drivers/media/test-drivers/vidtv/vidtv_bridge.c:439 [inline]
 vidtv_bridge_probe+0x3bc/0x4d0 drivers/media/test-drivers/vidtv/vidtv_bridge.c:508
 platform_probe+0x81/0x120 drivers/base/platform.c:1400
 call_driver_probe drivers/base/dd.c:530 [inline]
 really_probe+0x12d/0x390 drivers/base/dd.c:609
 __driver_probe_device+0xbf/0x140 drivers/base/dd.c:748
 driver_probe_device+0x2a/0x120 drivers/base/dd.c:778
 __driver_attach drivers/base/dd.c:1150 [inline]
 __driver_attach+0xe6/0x1f0 drivers/base/dd.c:1099
 bus_for_each_dev+0xa9/0x100 drivers/base/bus.c:301
 bus_add_driver+0x214/0x290 drivers/base/bus.c:618
 driver_register+0xc3/0x150 drivers/base/driver.c:240
 vidtv_bridge_init+0x37/0x64 drivers/media/test-drivers/vidtv/vidtv_bridge.c:600
 do_one_initcall+0x5e/0x2e0 init/main.c:1296
 do_initcall_level init/main.c:1369 [inline]
 do_initcalls init/main.c:1385 [inline]
 do_basic_setup init/main.c:1404 [inline]
 kernel_init_freeable+0x255/0x2cf init/main.c:1611
 kernel_init+0x1a/0x1c0 init/main.c:1500
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
CR2: 00000881b7bf0118
---[ end trace 0000000000000000 ]---
RIP: 0010:arch_atomic64_try_cmpxchg arch/x86/include/asm/atomic64_64.h:190 [inline]
RIP: 0010:arch_atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-long.h:443 [inline]
RIP: 0010:atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:1781 [inline]
RIP: 0010:__mutex_trylock_fast kernel/locking/mutex.c:171 [inline]
RIP: 0010:mutex_lock+0x14/0x30 kernel/locking/mutex.c:285
Code: 84 00 00 00 00 00 be 02 00 00 00 e9 86 f8 ff ff 66 0f 1f 44 00 00 55 48 89 fd 2e 2e 2e 31 c0 31 c0 65 48 8b 14 25 80 ad 01 00 <f0> 48 0f b1 55 00 75 02 5d c3 48 89 ef 5d eb cc 66 66 2e 0f 1f 84
RSP: 0000:ffffc90000273b68 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000881b7bf0000 RCX: 0000000000000000
RDX: ffff888101818040 RSI: ffffffff83098dc5 RDI: 00000881b7bf0118
RBP: 00000881b7bf0118 R08: 0000000000000003 R09: 00000000000001ff
R10: 0000000000000001 R11: 000000000002f8b8 R12: 00000881b7bf0118
R13: ffff888141351500 R14: ffff888142493000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000881b7bf0118 CR3: 0000000005a29000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	84 00                	test   %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	00 00                	add    %al,(%rax)
   6:	be 02 00 00 00       	mov    $0x2,%esi
   b:	e9 86 f8 ff ff       	jmpq   0xfffff896
  10:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  16:	55                   	push   %rbp
  17:	48 89 fd             	mov    %rdi,%rbp
  1a:	2e 2e 2e 31 c0       	cs cs cs xor %eax,%eax
  1f:	31 c0                	xor    %eax,%eax
  21:	65 48 8b 14 25 80 ad 	mov    %gs:0x1ad80,%rdx
  28:	01 00
* 2a:	f0 48 0f b1 55 00    	lock cmpxchg %rdx,0x0(%rbp) <-- trapping instruction
  30:	75 02                	jne    0x34
  32:	5d                   	pop    %rbp
  33:	c3                   	retq
  34:	48 89 ef             	mov    %rbp,%rdi
  37:	5d                   	pop    %rbp
  38:	eb cc                	jmp    0x6
  3a:	66                   	data16
  3b:	66                   	data16
  3c:	2e                   	cs
  3d:	0f                   	.byte 0xf
  3e:	1f                   	(bad)
  3f:	84                   	.byte 0x84


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E621A4B6A5C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbiBOLKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:10:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236945AbiBOLKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:10:30 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF53107D0B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 03:10:20 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id q15-20020a92ca4f000000b002be3e7707ffso13255734ilo.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 03:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=HlCRe0snkQy/+hDudsrhVi6HrHTIwYgHHKD60hKLOUY=;
        b=gQFHfpwcEP4OfhTPftvDAA3CpbyVUnX1s2mZvq94bPVE5Qxe9Vi/n7E14YwBtEEe8T
         GEbJYQ5Wm34By4VOnoCGzwyAV1DH81R06Kc9Ur18ToVlASFeyC2jH/lNVL+1xwFElmZA
         7iNYy1oRn9FikN6yw8ZA3HgSete7IQOSw8aktcWxUV4D10Pmq6CXvJpJ91kpzOAVQaOK
         c26fV5a6Se+JZWlSSvBLY0lJSL5k5Q+LqcnGHN5J8g2QIh8g0nwtM3zclztt354F5kRv
         yXcRBEXRHWTW8z/iwEp8yHhVrVjz3PVX1l8aKAYYfv4BXtiRh6VOp2OS8oUO1dMsSuAr
         0orA==
X-Gm-Message-State: AOAM5315xtZ9TjWY83tbbOUBpPFGjnx2PoUJz1mwSOZn8omTGKOxmE9F
        RNHryJR6epbiXf2jwYa5emi7ulBaZSjzYf6CANQpxemEWHAw
X-Google-Smtp-Source: ABdhPJxOWYGBpkLr8EdIQagvabFo5COZYg08isyBEHSg2ydDelnsvXsA3AokzVzwpzupWlD1y4GdGMv2i6HQIm+hfcb4cun9KvRG
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca8:: with SMTP id x8mr2235559ill.89.1644923419655;
 Tue, 15 Feb 2022 03:10:19 -0800 (PST)
Date:   Tue, 15 Feb 2022 03:10:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c844905d80c946c@google.com>
Subject: [syzbot] general protection fault in __media_entity_remove_link
From:   syzbot <syzbot+3a40339fb2628236d307@syzkaller.appspotmail.com>
To:     laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, sakari.ailus@linux.intel.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c3c9cee59282 usb: ehci: add pci device support for Aspeed ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=12899ef8700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3639fddee516775
dashboard link: https://syzkaller.appspot.com/bug?extid=3a40339fb2628236d307
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3a40339fb2628236d307@syzkaller.appspotmail.com

dvb-usb: could not initialize remote control.
dvb-usb: PCTV 2002e SE successfully initialized and connected.
usb 4-1: USB disconnect, device number 52
general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 PID: 4783 Comm: kworker/0:5 Not tainted 5.17.0-rc2-syzkaller-00044-gc3c9cee59282 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:__media_entity_remove_link+0x53/0xa10 drivers/media/mc/mc-entity.c:590
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 14 09 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 5e 30 48 8d 7b 20 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 e7 08 00 00 4c 8b 7b 20 4c 3b 7c 24 18 0f 84 84
RSP: 0018:ffffc900018a7448 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffffffffffffffff RCX: ffffc900075fe000
RDX: 0000000000000003 RSI: ffffffff84110f6b RDI: 000000000000001f
RBP: ffffffffffffffff R08: 0000000000000001 R09: ffffffff8a7e87af
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88810fed4300
R13: ffff88810fed4350 R14: ffff88820fed4330 R15: ffff88820fed4330
FS:  0000000000000000(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555556290af8 CR3: 000000012ddec000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __media_entity_remove_links+0x86/0x160 drivers/media/mc/mc-entity.c:768
 __media_device_unregister_entity+0x187/0x300 drivers/media/mc/mc-device.c:597
 media_device_unregister_entity+0x49/0x70 drivers/media/mc/mc-device.c:689
 dvb_media_device_free+0x1d5/0x680 drivers/media/dvb-core/dvbdev.c:216
 dvb_remove_device.part.0+0x9c/0x260 drivers/media/dvb-core/dvbdev.c:558
 dvb_remove_device drivers/media/dvb-core/dvbdev.c:551 [inline]
 dvb_unregister_device+0x1b/0x60 drivers/media/dvb-core/dvbdev.c:580
 dvb_dmxdev_release+0x1c9/0x630 drivers/media/dvb-core/dmxdev.c:1462
 dvb_usb_adapter_dvb_exit+0x93/0x230 drivers/media/usb/dvb-usb/dvb-usb-dvb.c:224
 dvb_usb_adapter_exit drivers/media/usb/dvb-usb/dvb-usb-init.c:126 [inline]
 dvb_usb_exit drivers/media/usb/dvb-usb/dvb-usb-init.c:141 [inline]
 dvb_usb_device_exit+0x20a/0x510 drivers/media/usb/dvb-usb/dvb-usb-init.c:336
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 __device_release_driver+0x5d7/0x700 drivers/base/dd.c:1206
 device_release_driver_internal drivers/base/dd.c:1237 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1260
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
 device_del+0x502/0xd50 drivers/base/core.c:3592
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x27a/0x78e drivers/usb/core/hub.c:2228
 hub_port_connect drivers/usb/core/hub.c:5206 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5506 [inline]
 port_event drivers/usb/core/hub.c:5664 [inline]
 hub_event+0x1e39/0x44d0 drivers/usb/core/hub.c:5746
 process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
 process_scheduled_works kernel/workqueue.c:2370 [inline]
 worker_thread+0x833/0x1110 kernel/workqueue.c:2456
 kthread+0x2ef/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__media_entity_remove_link+0x53/0xa10 drivers/media/mc/mc-entity.c:590
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 14 09 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 5e 30 48 8d 7b 20 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 e7 08 00 00 4c 8b 7b 20 4c 3b 7c 24 18 0f 84 84
RSP: 0018:ffffc900018a7448 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffffffffffffffff RCX: ffffc900075fe000
RDX: 0000000000000003 RSI: ffffffff84110f6b RDI: 000000000000001f
RBP: ffffffffffffffff R08: 0000000000000001 R09: ffffffff8a7e87af
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88810fed4300
R13: ffff88810fed4350 R14: ffff88820fed4330 R15: ffff88820fed4330
FS:  0000000000000000(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555556290af8 CR3: 000000012ddec000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 89 fa             	mov    %rdi,%rdx
   3:	48 c1 ea 03          	shr    $0x3,%rdx
   7:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   b:	0f 85 14 09 00 00    	jne    0x925
  11:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  18:	fc ff df
  1b:	49 8b 5e 30          	mov    0x30(%r14),%rbx
  1f:	48 8d 7b 20          	lea    0x20(%rbx),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 e7 08 00 00    	jne    0x91b
  34:	4c 8b 7b 20          	mov    0x20(%rbx),%r15
  38:	4c 3b 7c 24 18       	cmp    0x18(%rsp),%r15
  3d:	0f                   	.byte 0xf
  3e:	84                   	.byte 0x84
  3f:	84                   	.byte 0x84


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

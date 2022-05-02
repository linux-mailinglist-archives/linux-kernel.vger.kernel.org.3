Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2EA516AF2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 08:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383506AbiEBGqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 02:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343598AbiEBGqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 02:46:50 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843C62CE2E
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 23:43:21 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id k3-20020a6bba03000000b00657cc832f3aso5574298iof.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 23:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xU21jNma3wnJAcTSyKuLDDf/RK7eubjOe9IzgIAdPS8=;
        b=xtpRqYU3URT8iMTyQIEOWuO34gf69y3vgAymWQ1RoJE2K3P6Tz8i3lwV7EjEHKgPz4
         9kVQhaLlCSPVZ2XxMU+vulsCoZfqRlY3IO+rfWtuXxFaR8jCDlPLOK7GnKWjTp6zZxTo
         92GyhX2+6FPJckZuVrVi1acwk9oKSB098hJLpsPJZqA+gkzqxrZp+Gkzp37g/Ydgs0zn
         oaRkxZmJoeScipJKseujgkAXt57kyl7bn0q8ah6NCGfzcgSbNfL2140QtCekxc/zYFZQ
         WO4i6buPLQTUzpC96PhRuNharr/j9beINOmhhsCjc+asfRUnF4MKxybxMy8cE00cvibs
         Mqcg==
X-Gm-Message-State: AOAM533zuBG983XjYIjp+WabmI7K6jsyksXrH6Mv06z/G86ic/u7czuQ
        pDSapXxW9lQQWAcgHmx22u8HJGInx35rJNOFALEC9xdwFoaU
X-Google-Smtp-Source: ABdhPJwSgS0AR6/oHAUdRRiJ/BA2Td/W1bbexhImX0XzfhXS2ZX0MTKqC/IuU+lyUfUqmHOnpSB9BL3gtldvJyn3+pX5+Lyv2PbU
MIME-Version: 1.0
X-Received: by 2002:a05:6638:16d2:b0:323:7285:474b with SMTP id
 g18-20020a05663816d200b003237285474bmr4665475jat.61.1651473800884; Sun, 01
 May 2022 23:43:20 -0700 (PDT)
Date:   Sun, 01 May 2022 23:43:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041f67405de01b5cf@google.com>
Subject: [syzbot] general protection fault in usb_gadget_udc_reset (3)
From:   syzbot <syzbot+10d79fa6d4fbfacaed2e@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, jakobkoschel@gmail.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, stern@rowland.harvard.edu,
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

HEAD commit:    d615b5416f8a Merge tag 'f2fs-fix-5.18' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157d7830f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b6ba81e30e2008b1
dashboard link: https://syzkaller.appspot.com/bug?extid=10d79fa6d4fbfacaed2e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+10d79fa6d4fbfacaed2e@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000008: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
CPU: 1 PID: 24 Comm: kworker/1:0 Not tainted 5.18.0-rc4-syzkaller-00006-gd615b5416f8a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: events __usb_queue_reset_device
RIP: 0010:usb_gadget_udc_reset+0x23/0xb0 drivers/usb/gadget/udc/core.c:1088
Code: 00 00 00 0f 1f 40 00 41 54 49 89 fc 53 48 89 f3 e8 02 88 b0 fb 48 8d 7b 40 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 70 4c 89 e7 ff 53 40 49 8d bc 24 80 00 00 00 48 b8
RSP: 0018:ffffc9000072f4e0 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000008 RSI: ffffffff85c7dcee RDI: 0000000000000040
RBP: ffff888044e50bfc R08: 0000000000000000 R09: ffff888044e50003
R10: ffffffff85c8e5e7 R11: 0000000000000001 R12: ffff888044e50c00
R13: ffff888044e50c00 R14: 0000000000000019 R15: ffff88806c056408
FS:  0000000000000000(0000) GS:ffff88802cb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4d9e2810f8 CR3: 000000006e13f000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 set_link_state+0xc83/0xf70 drivers/usb/gadget/udc/dummy_hcd.c:465
 dummy_hub_control+0x1192/0x1f80 drivers/usb/gadget/udc/dummy_hcd.c:2315
 rh_call_control drivers/usb/core/hcd.c:683 [inline]
 rh_urb_enqueue drivers/usb/core/hcd.c:848 [inline]
 usb_hcd_submit_urb+0xc83/0x2250 drivers/usb/core/hcd.c:1551
 usb_submit_urb+0x86d/0x18a0 drivers/usb/core/urb.c:594
 usb_start_wait_urb+0x101/0x4c0 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
 set_port_feature drivers/usb/core/hub.c:439 [inline]
 hub_port_reset+0x26d/0x1ce0 drivers/usb/core/hub.c:2968
 hub_port_init+0x18a/0x2ed0 drivers/usb/core/hub.c:4714
 usb_reset_and_verify_device+0x3a0/0xe10 drivers/usb/core/hub.c:5946
 usb_reset_device+0x4bd/0x9a0 drivers/usb/core/hub.c:6122
 __usb_queue_reset_device+0x68/0x90 drivers/usb/core/message.c:1904
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:usb_gadget_udc_reset+0x23/0xb0 drivers/usb/gadget/udc/core.c:1088
Code: 00 00 00 0f 1f 40 00 41 54 49 89 fc 53 48 89 f3 e8 02 88 b0 fb 48 8d 7b 40 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 70 4c 89 e7 ff 53 40 49 8d bc 24 80 00 00 00 48 b8
RSP: 0018:ffffc9000072f4e0 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000008 RSI: ffffffff85c7dcee RDI: 0000000000000040
RBP: ffff888044e50bfc R08: 0000000000000000 R09: ffff888044e50003
R10: ffffffff85c8e5e7 R11: 0000000000000001 R12: ffff888044e50c00
R13: ffff888044e50c00 R14: 0000000000000019 R15: ffff88806c056408
FS:  0000000000000000(0000) GS:ffff88802cb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4d9e2810f8 CR3: 000000006e13f000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	00 00                	add    %al,(%rax)
   2:	0f 1f 40 00          	nopl   0x0(%rax)
   6:	41 54                	push   %r12
   8:	49 89 fc             	mov    %rdi,%r12
   b:	53                   	push   %rbx
   c:	48 89 f3             	mov    %rsi,%rbx
   f:	e8 02 88 b0 fb       	callq  0xfbb08816
  14:	48 8d 7b 40          	lea    0x40(%rbx),%rdi
  18:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1f:	fc ff df
  22:	48 89 fa             	mov    %rdi,%rdx
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2d:	75 70                	jne    0x9f
  2f:	4c 89 e7             	mov    %r12,%rdi
  32:	ff 53 40             	callq  *0x40(%rbx)
  35:	49 8d bc 24 80 00 00 	lea    0x80(%r12),%rdi
  3c:	00
  3d:	48                   	rex.W
  3e:	b8                   	.byte 0xb8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

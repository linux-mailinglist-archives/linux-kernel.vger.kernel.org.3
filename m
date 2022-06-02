Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A611D53BF20
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 21:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238960AbiFBTuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 15:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239100AbiFBTtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:49:55 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FF535878
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 12:49:29 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id g11-20020a056e021e0b00b002d1b5e8389bso3961826ila.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 12:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4t0supSvPwKLYFOlsPNvX6umAqy/zHS8bwntXWxDYdA=;
        b=PqZMk9+FN3TR2G4vB1vAUsw8H86LQBI4TVPAfaK1D/zy19zT/5eklfP48tZ9jeEIs/
         fyAI/DIMASBl/xMfLOB2/rUMrJyK5X9IbvjgHy8/gyCPgJgztKuocpe8g7tUgletl4Ch
         V1IQbpBVwsUBijtbaph9DbawebPsM4w9wo2edyWpwIbon2ct3blnWkD+cSnKazlYMK73
         WxxiA6p3WvRlatXwH8v0Q9rafVoC1rFGck4rYjE8jVLSk4bquOCQnuotitoz/5RICm+Z
         dhqdn+0HjPJdRPlmW9EEp/s63KAEh+GHYyoQsqHhlaqKqbCZWsDhP55MGhdw23bc5iWo
         /BcA==
X-Gm-Message-State: AOAM530hfg02JVynM4QPo/eQ2G9T+PWSyEoI6lYgbQl01CcHVST6w0nc
        pdLlQmt/Keh8U8Cjl784ZPAxd3KZk3PhiqlIay/ZAv2f5NcK
X-Google-Smtp-Source: ABdhPJxUe6vsNGIDLMLQNgFPIhR1w/U9mKArsLkGe9Q/D7bmmFfk18jvmojo+DP/2TpXjH0EbyMs2WD6QdEycXbVuhnGHh3IPH/j
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cc:b0:2d3:c344:6dcd with SMTP id
 s12-20020a056e0218cc00b002d3c3446dcdmr4038366ilu.155.1654199368927; Thu, 02
 Jun 2022 12:49:28 -0700 (PDT)
Date:   Thu, 02 Jun 2022 12:49:28 -0700
In-Reply-To: <000000000000bb7f1c05da29b601@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5d58405e07c4d15@google.com>
Subject: Re: [syzbot] general protection fault in __device_attach
From:   syzbot <syzbot+dd3c97de244683533381@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    d1dc87763f40 assoc_array: Fix BUG_ON during garbage collect
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17d2e7f5f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c51cd24814bb5665
dashboard link: https://syzkaller.appspot.com/bug?extid=dd3c97de244683533381
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15613e2bf00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c90adbf00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd3c97de244683533381@syzkaller.appspotmail.com

usb usb9: device_add((null)) --> -22
general protection fault, probably for non-canonical address 0xdffffc0000000021: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000108-0x000000000000010f]
CPU: 0 PID: 4190 Comm: syz-executor322 Not tainted 5.18.0-syzkaller-11972-gd1dc87763f40 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__device_attach+0xad/0x4a0 drivers/base/dd.c:948
Code: e8 03 42 80 3c 20 00 0f 85 a3 03 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 65 48 49 8d bc 24 08 01 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 06 0f 8e 6e 03 00 00 45 0f b6 b4 24 08 01 00
RSP: 0018:ffffc90003447b98 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 1ffff92000688f74 RCX: 0000000000000000
RDX: 0000000000000021 RSI: 0000000000000002 RDI: 0000000000000108
RBP: ffff88807a22f030 R08: 0000000000000000 R09: ffffffff8dbb1097
R10: fffffbfff1b76212 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 00000000fffffff0 R15: ffff88807a22f0b0
FS:  0000555557335300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2b779a90b0 CR3: 000000007a1a7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 proc_ioctl.part.0+0x48e/0x560 drivers/usb/core/devio.c:2356
 proc_ioctl drivers/usb/core/devio.c:182 [inline]
 proc_ioctl_default drivers/usb/core/devio.c:2391 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2747 [inline]
 usbdev_ioctl+0x2c08/0x36f0 drivers/usb/core/devio.c:2807
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f2b77979779
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe17c6ed98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f2b779bd184 RCX: 00007f2b77979779
RDX: 0000000020000040 RSI: 00000000c0105512 RDI: 0000000000000006
RBP: 00007ffe17c6edb0 R08: 0000000000000001 R09: 0000000000000001
R10: 000000000000ffff R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__device_attach+0xad/0x4a0 drivers/base/dd.c:948
Code: e8 03 42 80 3c 20 00 0f 85 a3 03 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 65 48 49 8d bc 24 08 01 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 06 0f 8e 6e 03 00 00 45 0f b6 b4 24 08 01 00
RSP: 0018:ffffc90003447b98 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 1ffff92000688f74 RCX: 0000000000000000
RDX: 0000000000000021 RSI: 0000000000000002 RDI: 0000000000000108
RBP: ffff88807a22f030 R08: 0000000000000000 R09: ffffffff8dbb1097
R10: fffffbfff1b76212 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 00000000fffffff0 R15: ffff88807a22f0b0
FS:  0000555557335300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2b779a90b0 CR3: 000000007a1a7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 03 42 80 3c       	callq  0x3c804208
   5:	20 00                	and    %al,(%rax)
   7:	0f 85 a3 03 00 00    	jne    0x3b0
   d:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  14:	fc ff df
  17:	4c 8b 65 48          	mov    0x48(%rbp),%r12
  1b:	49 8d bc 24 08 01 00 	lea    0x108(%r12),%rdi
  22:	00
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 06                	je     0x38
  32:	0f 8e 6e 03 00 00    	jle    0x3a6
  38:	45                   	rex.RB
  39:	0f                   	.byte 0xf
  3a:	b6 b4                	mov    $0xb4,%dh
  3c:	24 08                	and    $0x8,%al
  3e:	01 00                	add    %eax,(%rax)


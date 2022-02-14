Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997294B3EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 01:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbiBNAig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 19:38:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbiBNAie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 19:38:34 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3F551E7E
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 16:38:27 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id q15-20020a92ca4f000000b002be3e7707ffso10314449ilo.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 16:38:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oslBjvfH2dPDHnmex6Hu2I3g0wLhDfD57KNo/JS3XGQ=;
        b=vsBPUahfDzraF0StWfLN9eCWv13PoFf8cK5FGqDEZLgtvmnMOR/I8SvUumPG+ySlXr
         UFKKsI6BoON0VKBmzgNgncxQ4TVa6JY6qaOExvFSI1a2Hody9l5gWh4sdH2lvObs6/ch
         84l3RwZakfaoiK+iyaMEYp+WcQMhx4uDRFIsskdUeAkhHyWAIPdiQKRO8j1grO019KGr
         2+nEDQ6KLE6IZ/ohGC7lMwQnkm0X/qb0iSWWf05A6aFSbB/xinbXuzTTCvoykvMYkg2m
         hhbZZLebs6xlcvOGsW6Y+z2ezNM8WachyiHeGzZfrWocOyr+bAJn6diz4I0XTa3jpMcM
         ANFw==
X-Gm-Message-State: AOAM531v3+P4fhnjcogES2ngOKZxm4oCxVlh4Mfo2SXDEr/nfpJz2b+C
        0/Uj+VsQaH6iO/YXR2AKU2LZoYj8ofkf/AVw18PZa4aqzzFm
X-Google-Smtp-Source: ABdhPJzjdQvUvobFgUW3drl7ldbJ0Fw3nmdtrdl/J4RIA1hcAUg/sm1K+kTLBraohU58Kb2MnYqEOc12wBzI1veDCbHBKR41OFIZ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ca:: with SMTP id 10mr6199542ilq.225.1644799107135;
 Sun, 13 Feb 2022 16:38:27 -0800 (PST)
Date:   Sun, 13 Feb 2022 16:38:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081fe7505d7efa29f@google.com>
Subject: [syzbot] WARNING in service_outstanding_interrupt/usb_submit_urb
From:   syzbot <syzbot+1aba18b1f1bae26e79d8@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, loic.poulain@linaro.org,
        oneukum@suse.com, rikard.falkeborn@gmail.com,
        syzkaller-bugs@googlegroups.com, weiyongjun1@huawei.com,
        yangjunlin@yulong.com
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
console output: https://syzkaller.appspot.com/x/log.txt?x=131676d8700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3639fddee516775
dashboard link: https://syzkaller.appspot.com/bug?extid=1aba18b1f1bae26e79d8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1aba18b1f1bae26e79d8@syzkaller.appspotmail.com

misc raw-gadget: fail, usb_gadget_probe_driver returned -16
------------[ cut here ]------------
URB 00000000b04f647a submitted while active
WARNING: CPU: 0 PID: 17678 at drivers/usb/core/urb.c:378 usb_submit_urb+0x14e2/0x18a0 drivers/usb/core/urb.c:378
Modules linked in:
CPU: 0 PID: 17678 Comm: syz-executor.4 Not tainted 5.17.0-rc2-syzkaller-00044-gc3c9cee59282 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:usb_submit_urb+0x14e2/0x18a0 drivers/usb/core/urb.c:378
Code: 89 de e8 61 a2 a3 fd 84 db 0f 85 a9 f3 ff ff e8 74 9e a3 fd 4c 89 fe 48 c7 c7 20 d6 86 86 c6 05 e1 be 0c 05 01 e8 63 ef 05 02 <0f> 0b e9 87 f3 ff ff 41 be ed ff ff ff e9 7c f3 ff ff e8 47 9e a3
RSP: 0018:ffffc90009b4fc88 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff812bbc08 RDI: fffff52001369f83
RBP: ffff88810bf5f050 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff812b596e R11: 0000000000000000 R12: ffff88810bf5f090
R13: ffff88810bf5f050 R14: 00000000fffffff0 R15: ffff88813b7fb700
FS:  00007f5c74578700(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200014c0 CR3: 00000001144d1000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 service_outstanding_interrupt.part.0+0xfd/0x220 drivers/usb/class/cdc-wdm.c:504
 service_outstanding_interrupt drivers/usb/class/cdc-wdm.c:490 [inline]
 wdm_read+0x4f3/0xbd0 drivers/usb/class/cdc-wdm.c:591
 vfs_read+0x1b5/0x600 fs/read_write.c:479
 ksys_read+0x12d/0x250 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f5c75402059
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5c74578168 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f5c75514f60 RCX: 00007f5c75402059
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 00007f5c7545c08d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff3ee3bc7f R14: 00007f5c74578300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

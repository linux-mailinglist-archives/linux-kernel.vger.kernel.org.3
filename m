Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5F3536E7E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 23:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiE1Uqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 16:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiE1Uqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 16:46:31 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3674A2184
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 13:46:30 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id q6-20020a056e0215c600b002c2c4091914so5248807ilu.14
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 13:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=plwxnWiwuDRda2tElF8zSuOr/unxfzwclNr7d4wq3r4=;
        b=OCug+SFNzEuNRLm4JX/UT0wzXo4r8onDh69EsJSRWphU+wlgtcblBg/sDrbOlezOMP
         ka/h1kOH4/vg94F77WS+FxPVqQvwZ4Y6VPkd3BZ3TmIcaGvcbrKGpeTHsucueCc2n62U
         YYBn0nhuCDOUzgXIaow02ckpQIYZJQUMnkZtkT1ni0qsXfGKgFlQLUlHEVW/76BSPPSM
         3syakPqzkhvAEuGb9xjRpdEPXz+NkSEsyR4TEIqO3P3vWzHQyGJlswb4VYLaOo0kN6kY
         MForkCfklOBc+u3Jb3qxmBSW51MIxwPzlvdPWroKDI/zpVWePXSj6wqstJICwklorSX6
         is1A==
X-Gm-Message-State: AOAM533hX6/ICyThDTeH7vlrWY4to5V1HKS+A5KgnhpNCN6FOOoHLsfK
        h81eaSGs6126THEDGVaZcmzDvuCIb723S5IQMdkwyqNNKK3G
X-Google-Smtp-Source: ABdhPJxhApFxnQvi8joZ/AIBhnEksxTRD5blkJIkEhELyl/h2FnMLg3S8WfDCj/hv9TWnBdAXRKXwFqYloC4ZQzyIdpx9QAQVcmv
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3388:b0:330:a236:163f with SMTP id
 h8-20020a056638338800b00330a236163fmr10460245jav.93.1653770789598; Sat, 28
 May 2022 13:46:29 -0700 (PDT)
Date:   Sat, 28 May 2022 13:46:29 -0700
In-Reply-To: <000000000000361f9005dd7fea88@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000743f8505e0188496@google.com>
Subject: Re: [syzbot] WARNING in wait_til_done
From:   syzbot <syzbot+3562be49b8e09d424a6f@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    9d004b2f4fea Merge tag 'cxl-for-5.19' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=118576f3f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=34d5ab77e4ca65e1
dashboard link: https://syzkaller.appspot.com/bug?extid=3562be49b8e09d424a6f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f15913f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=157ad36bf00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3562be49b8e09d424a6f@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3690 at drivers/block/floppy.c:999 schedule_bh drivers/block/floppy.c:999 [inline]
WARNING: CPU: 0 PID: 3690 at drivers/block/floppy.c:999 wait_til_done+0x350/0x3c0 drivers/block/floppy.c:2018
Modules linked in:
CPU: 0 PID: 3690 Comm: syz-executor202 Not tainted 5.18.0-syzkaller-10643-g9d004b2f4fea #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]
RIP: 0010:wait_til_done+0x350/0x3c0 drivers/block/floppy.c:2018
Code: fc 41 83 fd 01 7e ac e8 8e 1e e0 fc 4c 89 e6 48 c7 c7 20 7b 8e 8c e8 8f b4 c0 fc e8 7a 1e e0 fc e9 c3 fd ff ff e8 70 1e e0 fc <0f> 0b e9 4b fd ff ff e8 54 38 2c fd e9 0f fe ff ff e8 5a 1e e0 fc
RSP: 0018:ffffc90002f8f718 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 1ffff920005f1ee3 RCX: 0000000000000000
RDX: ffff88801430c140 RSI: ffffffff84998450 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
R13: ffffffff84995460 R14: 0000000000000000 R15: 0000000000000003
FS:  0000555556c30300(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000088 CR3: 000000002457a000 CR4: 0000000000150ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 floppy_check_events+0x3d0/0x560 drivers/block/floppy.c:4098
 disk_check_events+0xc2/0x420 block/disk-events.c:193
 disk_clear_events block/disk-events.c:248 [inline]
 bdev_check_media_change+0x12c/0x310 block/disk-events.c:279
 floppy_open+0x75d/0xd70 drivers/block/floppy.c:4057
 blkdev_get_whole+0x99/0x2d0 block/bdev.c:673
 blkdev_get_by_dev.part.0+0x5ec/0xb90 block/bdev.c:823
 blkdev_get_by_dev+0x6b/0x80 block/bdev.c:857
 blkdev_open+0x13c/0x2c0 block/fops.c:481
 do_dentry_open+0x4a1/0x11f0 fs/open.c:824
 do_open fs/namei.c:3477 [inline]
 path_openat+0x1c71/0x2910 fs/namei.c:3610
 do_filp_open+0x1aa/0x400 fs/namei.c:3637
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1254
 do_sys_open fs/open.c:1270 [inline]
 __do_sys_openat fs/open.c:1286 [inline]
 __se_sys_openat fs/open.c:1281 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1281
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f936c227597
Code: 25 00 00 41 00 3d 00 00 41 00 74 47 64 8b 04 25 18 00 00 00 85 c0 75 6b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 95 00 00 00 48 8b 4c 24 28 64 48 2b 0c 25
RSP: 002b:00007ffc43d5dfb0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f936c227597
RDX: 0000000000000000 RSI: 00007ffc43d5e030 RDI: 00000000ffffff9c
RBP: 00007ffc43d5e030 R08: 000000000000ffff R09: 00007ffc43d5dec0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>


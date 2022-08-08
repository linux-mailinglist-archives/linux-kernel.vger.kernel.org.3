Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB6958CDB4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbiHHSfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236781AbiHHSf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:35:27 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4FD1139
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:35:26 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id d6-20020a056e020be600b002dcc7977592so7056370ilu.17
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 11:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=ogaPJSHpPjbMUvj6KD5YIrjyZ1VPcpx2+/D7i1DP9RY=;
        b=xiU4LW/AkY8t94i1/0HEDD/ly6FzI4eoMWWJBmLt1gBsEXqixfBhrdOrKmkNETIxAr
         OqNbt2osfveJDObBfCZAl76CPX22V0XgnVVTW3ecBXXIA9Sx+yGmVbaJjub/cX4xer3/
         GYneXHugw3qfBszJiUExjekUagA7b7XiAqIXTP7xQneveAgrKdQDvS5xQxrzzWDvLTPI
         fW2CpfS1YLwL8eNq+wqfpWFbiBg86qLrCwZnfYa/pqSJQyi/CtwmUlpffI8lATjt3OWY
         lcTOf1i8mH1PWKb6lx79k/NQgsQBdJ0wEuavxMbD2IhiFmgvrF82hnTpwmiBWOiv+Zk1
         F0+g==
X-Gm-Message-State: ACgBeo1kQR7NW2Drg2h51vgyAM9z6SYJD6moCH2c5SoxisBQCo8APus0
        hZxCoGjuf6ofish366f9nJI07x47IEC9BsIgzxUPqB5545k2
X-Google-Smtp-Source: AA6agR6MsYsBxoMw+TyGgl9Bu4S0Z6Upv7JHcK3PUkLYZQeQ/nB3cZrk/E4RYLrDVirutxCWNaPmg7hRRMFMiWj37IgW/ejikviN
MIME-Version: 1.0
X-Received: by 2002:a6b:640a:0:b0:684:b422:eaa with SMTP id
 t10-20020a6b640a000000b00684b4220eaamr2299464iog.205.1659983725580; Mon, 08
 Aug 2022 11:35:25 -0700 (PDT)
Date:   Mon, 08 Aug 2022 11:35:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004bda3505e5bf143e@google.com>
Subject: [syzbot] WARNING: locking bug in vtime_task_switch_generic
From:   syzbot <syzbot+0d5283dca94c28f7d52d@syzkaller.appspotmail.com>
To:     andreyknvl@gmail.com, balbi@kernel.org, gregkh@linuxfoundation.org,
        jj251510319013@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
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

HEAD commit:    8288c99fc263 usb: misc: onboard_usb_hub: Remove duplicated..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=14679fb1080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6749cc6053521b55
dashboard link: https://syzkaller.appspot.com/bug?extid=0d5283dca94c28f7d52d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0d5283dca94c28f7d52d@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(chain_key != INITIAL_CHAIN_KEY)
WARNING: CPU: 0 PID: 3855 at kernel/locking/lockdep.c:5031 __lock_acquire+0x1a0f/0x5660 kernel/locking/lockdep.c:5031
Modules linked in:
CPU: 0 PID: 3855 Comm: syz-executor.2 Not tainted 5.19.0-rc7-syzkaller-00199-g8288c99fc263 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:__lock_acquire+0x1a0f/0x5660 kernel/locking/lockdep.c:5031
Code: d2 0f 85 d4 28 00 00 44 8b 35 55 f2 b3 07 45 85 f6 0f 85 32 f4 ff ff 48 c7 c6 40 cc 47 86 48 c7 c7 e0 9b 47 86 e8 ac 94 96 04 <0f> 0b e9 1b f4 ff ff 48 c7 c2 00 96 91 8b 48 b8 00 00 00 00 00 fc
RSP: 0018:ffffc900016cf858 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 000000000000002c RCX: 0000000000000000
RDX: ffff888110643900 RSI: ffffffff812c21e8 RDI: fffff520002d9efd
RBP: ffff88811064431a R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000002 R11: 0000000000000001 R12: ffff8881106442f8
R13: ffff888110643900 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f1c31d7f700(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5c285b4d60 CR3: 00000001104c6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5665 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
 do_write_seqcount_begin_nested include/linux/seqlock.h:516 [inline]
 do_write_seqcount_begin include/linux/seqlock.h:541 [inline]
 vtime_task_switch_generic+0xb5/0x5a0 kernel/sched/cputime.c:768
 vtime_task_switch include/linux/vtime.h:95 [inline]
 finish_task_switch.isra.0+0x4e3/0xa10 kernel/sched/core.c:5020
 context_switch kernel/sched/core.c:5149 [inline]
 __schedule+0x947/0x2630 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1911
 ___down_common kernel/locking/semaphore.c:225 [inline]
 __down_common+0x363/0x770 kernel/locking/semaphore.c:246
 down_interruptible+0x7b/0xa0 kernel/locking/semaphore.c:87
 raw_event_queue_fetch drivers/usb/gadget/legacy/raw_gadget.c:99 [inline]
 raw_ioctl_event_fetch drivers/usb/gadget/legacy/raw_gadget.c:588 [inline]
 raw_ioctl+0x1010/0x2780 drivers/usb/gadget/legacy/raw_gadget.c:1256
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1c32608fc7
Code: 3c 1c 48 f7 d8 49 39 c4 72 b8 e8 34 54 02 00 85 c0 78 bd 48 83 c4 08 4c 89 e0 5b 41 5c c3 0f 1f 44 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1c31d7d098 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f1c31d7e110 RCX: 00007f1c32608fc7
RDX: 00007f1c31d7e110 RSI: 0000000080085502 RDI: 0000000000000003
RBP: 0000000000000003 R08: 000000000000ffff R09: 000000000000000b
R10: 00007f1c31d7d140 R11: 0000000000000246 R12: 0000000800000000
R13: 0000000000000000 R14: 0000000020000000 R15: 00007f1c3266ecd5
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A9659FF99
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbiHXQgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238217AbiHXQge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:36:34 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E93B9C506
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:36:33 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id g5-20020a92cda5000000b002e954ecceb0so10030337ild.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=f1APCOhFmyJ10vIxVoiKBO6T/DzVWra6hy504vTDPVU=;
        b=QL3vslEKXCxbVg18NWeHvo81tCsGfiox4qDqTplXeEE6nc+pbECQVfTTt6UyGBjuJd
         +/aNrWhEcoEyOX25PlG0dp897mUicZ8ne2ET4NTtJZZI4nTl4SHuhZ5pKhLEPh4IySSQ
         ltcCUCrWN0bQvHHnYcfYeIQTxMgsZ3WsvZHjbU++utGQq4rT0F7BHh7srYIlHcYnbdW5
         w5rKsgH715MbOcLwAp+TAIUdG2Fks9sJoCk0wYjNDSBPtZ6VBuwEtwoNcyLRKbM0OAmf
         ZRLDMw6ntM8TiUhH4hY4zSaNHDIc8Daa0kZKJ96yK9ep5Cu2RDE2zabY/q1MNq50zcmt
         hCxA==
X-Gm-Message-State: ACgBeo07R8pZrtjr582JRxfLEhu6l1hfwwGNzdYzPUiguEmE0m+0MBaP
        jn8yW1OtL8TKFojLue3yFI/OuGmWXzEZ9SefS6ud5t8jNOXL
X-Google-Smtp-Source: AA6agR7ecCArrYecq45qY/rgtsE/pntqfN3G04eYfrMGUAT3WF0WcEe5nzmEubP6RM/Cohf0Qhf9f4+asnGz9aAekMbzUAYxY2Zj
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2515:b0:349:f7c2:4a37 with SMTP id
 v21-20020a056638251500b00349f7c24a37mr3508284jat.98.1661358992964; Wed, 24
 Aug 2022 09:36:32 -0700 (PDT)
Date:   Wed, 24 Aug 2022 09:36:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ebf5605e6ff48d5@google.com>
Subject: [syzbot] WARNING in cpuset_attach
From:   syzbot <syzbot+29d3a3b4d86c8136ad9e@syzkaller.appspotmail.com>
To:     Jason@zx2c4.com, frederic@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, steven.price@arm.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c40e8341e3b3 Merge tag 'cgroup-for-6.0-rc2-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167bc60b080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=911efaff115942bb
dashboard link: https://syzkaller.appspot.com/bug?extid=29d3a3b4d86c8136ad9e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+29d3a3b4d86c8136ad9e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3684 at kernel/cpu.c:347 lockdep_assert_cpus_held kernel/cpu.c:347 [inline]
WARNING: CPU: 0 PID: 3684 at kernel/cpu.c:347 lockdep_assert_cpus_held+0xbd/0xe0 kernel/cpu.c:336
Modules linked in:
CPU: 0 PID: 3684 Comm: kvm-nx-lpage-re Not tainted 6.0.0-rc2-syzkaller-00054-gc40e8341e3b3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:lockdep_assert_cpus_held kernel/cpu.c:347 [inline]
RIP: 0010:lockdep_assert_cpus_held+0xbd/0xe0 kernel/cpu.c:336
Code: e8 38 0c 34 00 be ff ff ff ff 48 c7 c7 70 64 e3 8b e8 37 71 37 08 31 ff 89 c3 89 c6 e8 dc 08 34 00 85 db 75 d5 e8 13 0c 34 00 <0f> 0b eb cc 48 c7 c7 44 66 de 8d e8 d3 73 80 00 e9 62 ff ff ff 48
RSP: 0018:ffffc90004777c28 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88801f243b00 RSI: ffffffff8147ff0d RDI: 0000000000000005
RBP: ffff88814b0a4800 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc90004777de0
R13: ffffffff8bfdc2a0 R14: 1ffff920008eef8c R15: ffffc90004777e04
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020833000 CR3: 000000001bddc000 CR4: 00000000003526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 cpuset_attach+0x92/0x520 kernel/cgroup/cpuset.c:2292
 cgroup_migrate_execute+0xbc7/0x1220 kernel/cgroup/cgroup.c:2584
 cgroup_attach_task+0x416/0x7c0 kernel/cgroup/cgroup.c:2875
 cgroup_attach_task_all+0xde/0x140 kernel/cgroup/cgroup-v1.c:70
 kvm_vm_worker_thread+0xdd/0x5a0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:5979
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

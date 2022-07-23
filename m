Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1965C57F1D7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 00:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbiGWWFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 18:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGWWFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 18:05:23 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4726403
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 15:05:20 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id y8-20020a056602200800b0067c008bfdfeso2898890iod.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 15:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Eyh94zVlyqFbulp1UGioj7m934SJCX2nFCHL6xq/8NY=;
        b=SZXpyB4YCtHm3Cb+ozWteGRTHkN4E81lNdwFx82q1Pyre3+OoE3aL2dS3gMKf7h9Hj
         7qeKr1zBhD04mMZIEEiT4LMMtoLraGCeoKo9z/zFEVC9Tjmyw7cgVGCQdIdyYA28YySn
         YHOjuFNIwnq03EFP+d1cFn5NOb6Nz1bRYYPHqtXOBBLy/FHqxqiH5In7EYT881byeGbl
         ujLKQ3VThskBtY9IKO9NJkoHRrpNCuDZ0NKS8zBFQyKQWUqkuiypL9U73dUEycwyMzWq
         603IM4Qc07lmd6AgPjK2oI6zXZYN17TXSJTHbajICfkhVxUZwIdzMXa8cXvgTkovygb4
         d/bQ==
X-Gm-Message-State: AJIora/UK78paxxGD14ENrsgr6nIC8BDFhoxFK+nJN20U0dm+n8+S1MU
        1pNNN8vqPxZAOH7gITC9uHvNQ6SuvWLUj9jf1NIMOuqlsFF/
X-Google-Smtp-Source: AGRyM1t4btWRiXQy4VTHnd1Kn8bPy0R3agBvJ0sXVdxblWdSPV7+n0mgc52rRHNL4+OEuy63xLBjzIODR1nENUjri8Jd/9GZ0xLr
MIME-Version: 1.0
X-Received: by 2002:a6b:ba85:0:b0:67b:cd01:aef2 with SMTP id
 k127-20020a6bba85000000b0067bcd01aef2mr2050361iof.59.1658613919174; Sat, 23
 Jul 2022 15:05:19 -0700 (PDT)
Date:   Sat, 23 Jul 2022 15:05:19 -0700
In-Reply-To: <0000000000007c525005e0ff1382@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078d9e105e480258a@google.com>
Subject: Re: [syzbot] WARNING: ODEBUG bug in kvm_xen_vcpu_set_attr
From:   syzbot <syzbot+e54f930ed78eb0f85281@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    70664fc10c0d Merge tag 'riscv-for-linus-5.19-rc8' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11de4030080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95c061eee05f8e15
dashboard link: https://syzkaller.appspot.com/bug?extid=e54f930ed78eb0f85281
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e058ce080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151b2ec2080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e54f930ed78eb0f85281@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: init active (active state 0) object type: hrtimer hint: xen_timer_callback+0x0/0xb0 arch/x86/kvm/xen.c:1086
WARNING: CPU: 0 PID: 3615 at lib/debugobjects.c:502 debug_print_object+0x16e/0x250 lib/debugobjects.c:502
Modules linked in:
CPU: 0 PID: 3615 Comm: syz-executor343 Not tainted 5.19.0-rc7-syzkaller-00190-g70664fc10c0d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:502
Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 af 00 00 00 48 8b 14 dd 40 79 28 8a 4c 89 ee 48 c7 c7 20 6d 28 8a e8 7c 1e 32 05 <0f> 0b 83 05 b5 62 bb 09 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e c3
RSP: 0018:ffffc9000306f778 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff88801d968000 RSI: ffffffff8160d1a8 RDI: fffff5200060dee1
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffffffff89cee540
R13: ffffffff8a2872a0 R14: ffffffff816a72e0 R15: ffffffff9114ced8
FS:  0000555555da53c0(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000021000000 CR3: 000000001f980000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __debug_object_init+0x524/0xd10 lib/debugobjects.c:590
 debug_hrtimer_init kernel/time/hrtimer.c:414 [inline]
 debug_init kernel/time/hrtimer.c:468 [inline]
 hrtimer_init+0x23/0x2b0 kernel/time/hrtimer.c:1592
 kvm_xen_init_timer arch/x86/kvm/xen.c:168 [inline]
 kvm_xen_vcpu_set_attr+0x1ca/0x16c0 arch/x86/kvm/xen.c:716
 kvm_arch_vcpu_ioctl+0x1bb3/0x39d0 arch/x86/kvm/x86.c:5715
 kvm_vcpu_ioctl+0x973/0xf30 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4104
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f859bb34cd9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd7a0db668 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffd7a0db678 RCX: 00007f859bb34cd9
RDX: 0000000020003680 RSI: 000000004048aecb RDI: 000000000000000b
RBP: 00007ffd7a0db670 R08: 00007f859baf7b00 R09: 00007f859baf7b00
R10: 00007f859baf7b00 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


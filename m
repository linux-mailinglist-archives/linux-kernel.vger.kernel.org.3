Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CC25ACE17
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbiIEIxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236095AbiIEIxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:53:31 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BF73120B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:53:30 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id k12-20020a92c24c000000b002f18edda397so853205ilo.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 01:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=DcYC9/6aVuEAkaW9wJ/sRhJrzUJhn1ulY8RHIcC4sTg=;
        b=yUat/lsIqiI5Th6FtoL85sRJhGSJ1m5XoDLY66jPbLP9WiKnDP0jPWRHycTPz2WFBK
         QjnvyiqjtuGVs5JfLc7xV7/grfF/bOLUXfzErZ43oi58KOJbwPu4XPKPeq8Ug7VR/Acg
         uqgo+EUNSEeKY7sAT/PP1POfLldipDU/eMCjJpW9Pr+kpd1V1gAKbFuYDaOVsdO/rL/h
         yjBUQx6OyZufyhB0j4dp2F/2s5EaVyTV4Or0wwh36bnhq/IZzq2IaDqG0sbdjUhlICT5
         npKoGk78uHwtldUMLD4FdkWat0ZLVTclMHn77aNrWnrwg4O6qNj9/f3FBLLXHGsS/8/8
         uvaQ==
X-Gm-Message-State: ACgBeo1qmFVE/i/0a/AyeaY4lZ4FI8CsM5X5BJx0lA8Xp/5BTCAg79Nz
        glU3M0AmNfVO5E0WZhxyhEVRu4CWjUQ8vPg0sbw/8Z9B0X3V
X-Google-Smtp-Source: AA6agR7b6bvtofQ9B46eeste0+8wQqm61c3MOpz3L/49UpK5sEDUIB1S5/Jf6YvdNvgwauvLCaMOYwi5kzQouiMcY4u4//vMfZsm
MIME-Version: 1.0
X-Received: by 2002:a02:a883:0:b0:347:c2ed:9ff with SMTP id
 l3-20020a02a883000000b00347c2ed09ffmr24367608jam.217.1662368009437; Mon, 05
 Sep 2022 01:53:29 -0700 (PDT)
Date:   Mon, 05 Sep 2022 01:53:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b04b4705e7ea36fb@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in open_xa_dir
From:   syzbot <syzbot+3c530d01065fbfab6070@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    85413d1e802e Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=113a1bc7080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57b9bfeca947ab90
dashboard link: https://syzkaller.appspot.com/bug?extid=3c530d01065fbfab6070
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c530d01065fbfab6070@syzkaller.appspotmail.com

loop1: detected capacity change from 0 to 65534
Unable to handle kernel paging request at virtual address 0000000081a401ba
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000138114000
[0000000081a401ba] pgd=080000013d972003, p4d=080000013d972003, pud=0000000000000000
Internal error: Oops: 96000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 15506 Comm: syz-executor.1 Not tainted 6.0.0-rc3-syzkaller-16800-g85413d1e802e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : d_really_is_negative include/linux/dcache.h:465 [inline]
pc : open_xa_root fs/reiserfs/xattr.c:124 [inline]
pc : open_xa_dir+0x48/0x2a8 fs/reiserfs/xattr.c:152
lr : open_xa_dir+0x34/0x2a8 fs/reiserfs/xattr.c:148
sp : ffff80002214b850
x29: ffff80002214b870 x28: 0000000000000030 x27: ffff0000e44c7d68
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000081a40152
x23: 0000000000000000 x22: 0000000000000002 x21: ffff0000e4530190
x20: 0000000000000002 x19: ffff0000c3f35000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000002 x13: 0000000000008000 x12: 0000000000040000
x11: 000000000001f773 x10: ffff80001a24a000 x9 : ffff800008795070
x8 : ffff0000fae34b00 x7 : ffff8000086ace88 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000002 x1 : 0000000000000002 x0 : ffff0000e4530190
Call trace:
 open_xa_root fs/reiserfs/xattr.c:121 [inline]
 open_xa_dir+0x48/0x2a8 fs/reiserfs/xattr.c:152
 xattr_lookup+0x34/0x198 fs/reiserfs/xattr.c:395
 reiserfs_xattr_get+0x8c/0x680 fs/reiserfs/xattr.c:677
 reiserfs_get_acl+0x84/0x1ac fs/reiserfs/xattr_acl.c:214
 get_acl+0x104/0x330 fs/posix_acl.c:152
 check_acl+0x40/0x168 fs/namei.c:306
 acl_permission_check fs/namei.c:351 [inline]
 generic_permission+0x270/0x32c fs/namei.c:404
 reiserfs_permission+0x4c/0x6c fs/reiserfs/xattr.c:954
 do_inode_permission fs/namei.c:458 [inline]
 inode_permission+0x128/0x244 fs/namei.c:525
 may_open+0x1e4/0x2bc fs/namei.c:3185
 do_open fs/namei.c:3555 [inline]
 path_openat+0xdd0/0x11c4 fs/namei.c:3691
 do_filp_open+0xdc/0x1b8 fs/namei.c:3718
 do_sys_openat2+0xb8/0x22c fs/open.c:1311
 do_sys_open fs/open.c:1327 [inline]
 __do_sys_openat fs/open.c:1343 [inline]
 __se_sys_openat fs/open.c:1338 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1338
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
Code: 390043ff a9007fff f9433e68 f942cd18 (f9403708) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	390043ff 	strb	wzr, [sp, #16]
   4:	a9007fff 	stp	xzr, xzr, [sp]
   8:	f9433e68 	ldr	x8, [x19, #1656]
   c:	f942cd18 	ldr	x24, [x8, #1432]
* 10:	f9403708 	ldr	x8, [x24, #104] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EFA5A937D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbiIAJqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbiIAJqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:46:33 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F8211D930
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:46:31 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id o2-20020a056e0214c200b002eb8acbd27cso3487744ilk.22
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 02:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=y6NTaZhC93w7/nr+936Z1uJsicemKlFbzybdjpgrwek=;
        b=Ftpps/XM0u+/KyG1ZOkoiXaR1USMVwE2ZSJBXK35G3XZDlABfRA8W4exzxnIycypRs
         5x89Lx11MxUEFSWNqA31kruNdSQfhyY99qqHB2wY5DPH5W4cFCyAMvjN/s0DJCnPdwax
         koFZsGzP7lHrQ/WIPNJtAabqmNIStmOaE7qobUBfMxT4DoTLc7EW3i9y5+Z4a2Yrud2F
         +ocE7ppQ8aNqJEGDALZQ6D65QLWWmUZs7DSkXCZP+IaclFUfWcAnhxUoxNrn+tx2J1DO
         /gfLWU3fZkh+QENlaAnMQu8OVdvscPKAfr56SHzaVq/NhzEvzSguFag0QqCzp3oU4Tsu
         +RBQ==
X-Gm-Message-State: ACgBeo3eRMo4mNfs+u5yoJelmgWzSCsj3Lr3IRJJ5sDN+60iRgliWF6G
        gXaMmSHPwSVEEuD5zI8SkrOOzsDb2hkVOeCaJ0sKVRrIbdyW
X-Google-Smtp-Source: AA6agR6N6UoYb9mqjX0NrayBAffCgdnXlaf4s+R8D/0rDSIp85v7PKh6uUXh3TyR12Ku5i7JZ2RFBzWVFvT3NOvQoijUO2AIAdMW
MIME-Version: 1.0
X-Received: by 2002:a92:b011:0:b0:2ea:ebed:1241 with SMTP id
 x17-20020a92b011000000b002eaebed1241mr10179174ilh.245.1662025591034; Thu, 01
 Sep 2022 02:46:31 -0700 (PDT)
Date:   Thu, 01 Sep 2022 02:46:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f61bdf05e79a7c5c@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in mi_enum_attr
From:   syzbot <syzbot+28207acc70bbf3d85b74@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    a41a877bc12d Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11d7f5ad080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5cea15779c42821c
dashboard link: https://syzkaller.appspot.com/bug?extid=28207acc70bbf3d85b74
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+28207acc70bbf3d85b74@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address ffff000224d7f83a
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005
  CM = 0, WnR = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001c5736000
[ffff000224d7f83a] pgd=180000023fff8003, p4d=180000023fff8003, pud=0000000000000000
Internal error: Oops: 96000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 28529 Comm: syz-executor.3 Not tainted 6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : mi_enum_attr+0x10c/0x314 fs/ntfs3/record.c:227
lr : mi_enum_attr+0xf0/0x314 fs/ntfs3/record.c:223
sp : ffff8000220f3940
x29: ffff8000220f3940 x28: ffff000124d7f800 x27: ffff000124d7f838
x26: 00000000fffffffe x25: 0000000000000048 x24: 0000000000000000
x23: 0000000000000000 x22: 0000000000000036 x21: 0000000000000198
x20: 0000000000000038 x19: ffff000224d7f836 x18: 0000000000000002
x17: ffff80000c04d6bc x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000064 x13: 0000000000989680 x12: 0000000000040000
x11: 00000000000105f8 x10: ffff800019725000 x9 : ffff800008c10880
x8 : 00000000000105f9 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff000124d7fc00 x4 : ffff00011eb5e400 x3 : 0000000000000000
x2 : ffff8000220f3a70 x1 : 00000000fffffffe x0 : 0000000000000018
Call trace:
 mi_enum_attr+0x10c/0x314 fs/ntfs3/record.c:210
 ni_enum_attr_ex+0x174/0x29c fs/ntfs3/frecord.c:259
 ntfs_read_mft fs/ntfs3/inode.c:114 [inline]
 ntfs_iget5+0xf44/0x138c fs/ntfs3/inode.c:501
 ntfs_loadlog_and_replay+0x98/0x1ec fs/ntfs3/fsntfs.c:272
 ntfs_fill_super+0xc10/0x14a4 fs/ntfs/super.c:2904
 get_tree_bdev+0x1e8/0x2a0 fs/super.c:1323
 ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1358
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2f8/0x408 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
Code: 97da4c0f 14000039 97da4c0d 8b160293 (b9400674) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	97da4c0f 	bl	0xffffffffff69303c
   4:	14000039 	b	0xe8
   8:	97da4c0d 	bl	0xffffffffff69303c
   c:	8b160293 	add	x19, x20, x22
* 10:	b9400674 	ldr	w20, [x19, #4] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A73655D417
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiF0HL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiF0HLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:11:25 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0E35F52
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:11:24 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id d11-20020a6bb40b000000b006727828a19fso5326043iof.15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=dlXIjc1Fz8xnNFqUPA8RuqcnGDzpMp9dQqsY2cW9s0Q=;
        b=IY+AI4VD2u7INmvMj6rvaKq+4otQY/b6H3dehbD1T+IsMzj6pgwUxA8uTDvFBzkALs
         Fy40uQmBK6XVIaV3njH4AgyxscH1jAjBxx747+BWRAIq6Fet/REKKZowZlLBSccZtWgZ
         KvmDwxin8UJ9jFF4uofjnaaRVunlh5x46N+YsWBUmyptPhvHCOhPhq+SRN4tjPsh+KUd
         AfOi2wXxftiG0/w5hlkkmTdMUgNJqG+xM4ezoGJRoSOfqAfaj6rIM0QcruHQi8ngrhKY
         ZQOLv/+rJvLl161+S/zTIb42Di9tsY0y2dWIMSgh9TECoRixhzuiPzeq68qJJYm/w3hG
         1TCQ==
X-Gm-Message-State: AJIora+NMU+UC269nMxq9d0nn5Gtj05xkwbe6uWuUdeBvW/dtu3cvoKG
        kFXFb7OuLFbsYmbO9jWqE2ZjegUGIWTVN/nWi1TMVYh0dPqu
X-Google-Smtp-Source: AGRyM1uEqgM9HARc07iExUWF+t/2BiCbz5N40Sn4h7wiB9s1t77N4JufQKYvjQu2eU4f2Dkoyqxv+ZDFRcfoXIk+fZ4KGMcDPeaQ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:27c6:b0:657:7e7a:11f3 with SMTP id
 l6-20020a05660227c600b006577e7a11f3mr6157230ios.40.1656313883590; Mon, 27 Jun
 2022 00:11:23 -0700 (PDT)
Date:   Mon, 27 Jun 2022 00:11:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab092305e268a016@google.com>
Subject: [syzbot] general protection fault in gfs2_evict_inode (2)
From:   syzbot <syzbot+8a5fc6416c175cecea34@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
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

HEAD commit:    ca1fdab7fd27 Merge tag 'efi-urgent-for-v5.19-1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102e8560080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=542d3d75f0e6f36f
dashboard link: https://syzkaller.appspot.com/bug?extid=8a5fc6416c175cecea34
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8a5fc6416c175cecea34@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: first mount done, others may mount
general protection fault, probably for non-canonical address 0xdffffc0000000011: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
CPU: 1 PID: 10573 Comm: syz-executor.0 Not tainted 5.19.0-rc3-syzkaller-00038-gca1fdab7fd27 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:evict_linked_inode fs/gfs2/super.c:1329 [inline]
RIP: 0010:gfs2_evict_inode+0xbf2/0x2030 fs/gfs2/super.c:1384
Code: 03 80 3c 02 00 0f 85 bd 13 00 00 48 8b 9d 00 09 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d bb 8c 00 00 00 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 e0
RSP: 0018:ffffc90005ae7670 EFLAGS: 00010217
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90003a83000
RDX: 0000000000000011 RSI: ffffffff838de301 RDI: 000000000000008c
RBP: ffff88802cd6c000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
R13: ffff88802e1a5160 R14: ffff88802e1a5698 R15: ffff88802e1a5610
FS:  00007f4c042c5700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa58679d090 CR3: 000000007d0e3000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 evict+0x2ed/0x6b0 fs/inode.c:664
 iput_final fs/inode.c:1744 [inline]
 iput.part.0+0x562/0x820 fs/inode.c:1770
 iput+0x58/0x70 fs/inode.c:1760
 init_journal fs/gfs2/ops_fstype.c:870 [inline]
 init_inodes+0x28c/0x2720 fs/gfs2/ops_fstype.c:924
 gfs2_fill_super+0x1b49/0x28a0 fs/gfs2/ops_fstype.c:1242
 get_tree_bdev+0x440/0x760 fs/super.c:1292
 gfs2_get_tree+0x4a/0x270 fs/gfs2/ops_fstype.c:1325
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f4c0308a63a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4c042c4f88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f4c0308a63a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f4c042c4fe0
RBP: 00007f4c042c5020 R08: 00007f4c042c5020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f4c042c4fe0 R15: 0000000020047a20
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:evict_linked_inode fs/gfs2/super.c:1329 [inline]
RIP: 0010:gfs2_evict_inode+0xbf2/0x2030 fs/gfs2/super.c:1384
Code: 03 80 3c 02 00 0f 85 bd 13 00 00 48 8b 9d 00 09 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d bb 8c 00 00 00 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 e0
RSP: 0018:ffffc90005ae7670 EFLAGS: 00010217
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90003a83000
RDX: 0000000000000011 RSI: ffffffff838de301 RDI: 000000000000008c
RBP: ffff88802cd6c000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
R13: ffff88802e1a5160 R14: ffff88802e1a5698 R15: ffff88802e1a5610
FS:  00007f4c042c5700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa58679d090 CR3: 000000007d0e3000 CR4: 0000000000350ee0
----------------
Code disassembly (best guess):
   0:	03 80 3c 02 00 0f    	add    0xf00023c(%rax),%eax
   6:	85 bd 13 00 00 48    	test   %edi,0x48000013(%rbp)
   c:	8b 9d 00 09 00 00    	mov    0x900(%rbp),%ebx
  12:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  19:	fc ff df
  1c:	48 8d bb 8c 00 00 00 	lea    0x8c(%rbx),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx <-- trapping instruction
  2e:	48 89 f8             	mov    %rdi,%rax
  31:	83 e0 07             	and    $0x7,%eax
  34:	83 c0 03             	add    $0x3,%eax
  37:	38 d0                	cmp    %dl,%al
  39:	7c 08                	jl     0x43
  3b:	84 d2                	test   %dl,%dl
  3d:	0f                   	.byte 0xf
  3e:	85 e0                	test   %esp,%eax


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

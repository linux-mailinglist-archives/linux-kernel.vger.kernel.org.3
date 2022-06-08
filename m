Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB66543FB9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 01:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiFHXBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 19:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiFHXBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 19:01:37 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E292F2871A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 16:01:35 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e4-20020a056e020b2400b002d5509de6f3so4965995ilu.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 16:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9wS7qRJfVwzLGogc91/YeQ150Cd39TDOaW40s0jLDV4=;
        b=ptNy0Av3mOh6b0Ea6hoO/Sdoy/bouwYH/RTMylQDQFUHe2u/uauQtduTm0IIUtEn4B
         7Bg0M9yHx/wg/M7Vf7i7CjqXFbj4KZKa19rni+4tIbh/x1+qdJKQWABQS7oypTStl5fz
         ZD9wiMuiNjYycKdKbTE39CgxWI3CkIDpIM3yPVH/6lv9VR7uUOxMrPgVgllE6nTnEyS+
         PTSxIGRtyZBWr9XO8mqphz7mD/f0+pONJ6fBCcgvvddbg5UvPMnuSnCYelMEIRxmtSgv
         9Wu2YZN6Hj1AKsFCFNmOnFVZ67ai1pRZtAI1t5U5lUaroKqSCzEo9bAP406U7D43QgqB
         dkjA==
X-Gm-Message-State: AOAM532Yqs2jZwhYdPrE7bRBfYSgfqqmWVGUqiI6YFlTrg/3fWXZ8bWW
        TG38WOGgRWNfYywQBSunCKXCqI/HSjDBe0qguasGtPvjMaqj
X-Google-Smtp-Source: ABdhPJzYhpzErttHYBIA16Qg//CKZh2z7oZYUVIeASJkgjQYdr+HmMKNPvU0hwOuKIXXhjCO2HujXlQrr1lsRdd18S2PL/nIEGEP
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2111:b0:669:4ae8:f195 with SMTP id
 x17-20020a056602211100b006694ae8f195mr9903317iox.78.1654729295314; Wed, 08
 Jun 2022 16:01:35 -0700 (PDT)
Date:   Wed, 08 Jun 2022 16:01:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8c3f005e0f7af3d@google.com>
Subject: [syzbot] general protection fault in snd_virmidi_output_trigger
From:   syzbot <syzbot+8e407e6b1dba0a275884@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, st_kost@gmx.de, syzkaller-bugs@googlegroups.com,
        tiwai@suse.com
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

HEAD commit:    952923ddc011 Merge tag 'pull-18-rc1-work.namei' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b95d0bf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3096247591885bfa
dashboard link: https://syzkaller.appspot.com/bug?extid=8e407e6b1dba0a275884
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8e407e6b1dba0a275884@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 1 PID: 18021 Comm: syz-executor.1 Not tainted 5.18.0-syzkaller-13842-g952923ddc011 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:snd_virmidi_output_trigger+0x82/0x130 sound/core/seq/seq_virmidi.c:169
Code: 8b ad 30 01 00 00 31 ff 89 de e8 d9 8b 4f fa 85 db 48 b8 00 00 00 00 00 fc ff df 41 0f 95 c4 48 8d 7d 1c 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 60 31 ff 44 88
RSP: 0018:ffffc9000c6e7c48 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff872af747
RDX: 0000000000000003 RSI: 0000000000000000 RDI: 000000000000001c
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff888078d6c801
R13: 000000007f012000 R14: ffff88814ab3c400 R15: 0000000000001000
FS:  00007fc5b5868700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020fec000 CR3: 0000000046903000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 snd_rawmidi_output_trigger sound/core/rawmidi.c:186 [inline]
 snd_rawmidi_output_trigger sound/core/rawmidi.c:182 [inline]
 snd_rawmidi_kernel_write1+0x548/0x870 sound/core/rawmidi.c:1502
 snd_rawmidi_write+0x273/0xb90 sound/core/rawmidi.c:1555
 vfs_write+0x269/0xac0 fs/read_write.c:589
 ksys_write+0x1e8/0x250 fs/read_write.c:644
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fc5b4689109
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc5b5868168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fc5b479bf60 RCX: 00007fc5b4689109
RDX: 00000000fffffd2c RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007fc5b46e308d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc5b4ccfb1f R14: 00007fc5b5868300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:snd_virmidi_output_trigger+0x82/0x130 sound/core/seq/seq_virmidi.c:169
Code: 8b ad 30 01 00 00 31 ff 89 de e8 d9 8b 4f fa 85 db 48 b8 00 00 00 00 00 fc ff df 41 0f 95 c4 48 8d 7d 1c 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 60 31 ff 44 88
RSP: 0018:ffffc9000c6e7c48 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff872af747
RDX: 0000000000000003 RSI: 0000000000000000 RDI: 000000000000001c
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff888078d6c801
R13: 000000007f012000 R14: ffff88814ab3c400 R15: 0000000000001000
FS:  00007fc5b5868700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2bc27000 CR3: 0000000046903000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8b ad 30 01 00 00    	mov    0x130(%rbp),%ebp
   6:	31 ff                	xor    %edi,%edi
   8:	89 de                	mov    %ebx,%esi
   a:	e8 d9 8b 4f fa       	callq  0xfa4f8be8
   f:	85 db                	test   %ebx,%ebx
  11:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  18:	fc ff df
  1b:	41 0f 95 c4          	setne  %r12b
  1f:	48 8d 7d 1c          	lea    0x1c(%rbp),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	48 89 fa             	mov    %rdi,%rdx
  31:	83 e2 07             	and    $0x7,%edx
  34:	38 d0                	cmp    %dl,%al
  36:	7f 04                	jg     0x3c
  38:	84 c0                	test   %al,%al
  3a:	75 60                	jne    0x9c
  3c:	31 ff                	xor    %edi,%edi
  3e:	44                   	rex.R
  3f:	88                   	.byte 0x88


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

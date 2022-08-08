Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E01758C94A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243268AbiHHNV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242399AbiHHNV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:21:26 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FC02BFB
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 06:21:24 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id j5-20020a056e02218500b002de1cf2347bso6442878ila.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 06:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=2fuXKFyY2jLEHj97y3vzUngcZESDHWQml2x/X1IOlDQ=;
        b=7fuP6G63gnV1wx2kbOGNDJGfTxEgutjtmaus4e826xmS5NOBFdWFXNXbmhgGflyZVP
         R4nJ3mjLP4gdto4pcH+XCQgfWC7tfbKhQpX+jnOhjsucm3ozGpg2cEKnwhYJdcgV88VK
         cAfxl2dAD3YTZ0VO4f1jcVugGYtC1RxRMvsZP3Nau1DFtXmqqz93xlNlTaG9pmiubIEs
         jKQ0iqGvYur/R+5npD9opRRwLRdvTVq0FDz1zXAJ2/Zst4jzwuh1NarBN0QZPPxz8/rf
         FiQPBZ43qobNTOerwwaC9+MSGBwUdfxr5aD4SQJbQG4yxmmywdZVfeAUJZs3wbSfh9E3
         ki/A==
X-Gm-Message-State: ACgBeo1LLVG4nBfPRAoEp6UGoVMSRCIoF9oVyFKasUFDucQOor6nkE1+
        SlkVwoUioPmdbvslm7TayJYj+nfnPejxI/BIjlwduyYMSFHC
X-Google-Smtp-Source: AA6agR5xmHh9m5tQn7ICict6btzfu4Ake0f9T6RziJyStPtETo7Y+FSAOqdrFXe1lFwFUAf7y3oRbCdNwaMLmL7b5B0CCndIW9Oq
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22c9:b0:341:56cf:c447 with SMTP id
 j9-20020a05663822c900b0034156cfc447mr7741358jat.244.1659964884208; Mon, 08
 Aug 2022 06:21:24 -0700 (PDT)
Date:   Mon, 08 Aug 2022 06:21:24 -0700
In-Reply-To: <0000000000008be58e05e5b5d971@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000434f7a05e5bab1ce@google.com>
Subject: Re: [syzbot] INFO: trying to register non-static key in gsmld_write
From:   syzbot <syzbot+cf155def4e717db68a12@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
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

HEAD commit:    ca688bff68bc Add linux-next specific files for 20220808
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16c4c201080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
dashboard link: https://syzkaller.appspot.com/bug?extid=cf155def4e717db68a12
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151f2b46080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143a3171080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cf155def4e717db68a12@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 3608 Comm: syz-executor156 Not tainted 5.19.0-next-20220808-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 assign_lock_key kernel/locking/lockdep.c:979 [inline]
 register_lock_class+0xf1b/0x1120 kernel/locking/lockdep.c:1292
 __lock_acquire+0x109/0x56d0 kernel/locking/lockdep.c:4932
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 gsmld_write+0x5e/0x140 drivers/tty/n_gsm.c:3023
 do_tty_write drivers/tty/tty_io.c:1024 [inline]
 file_tty_write.constprop.0+0x499/0x8f0 drivers/tty/tty_io.c:1095
 call_write_iter include/linux/fs.h:2192 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9e9/0xdd0 fs/read_write.c:578
 ksys_write+0x127/0x250 fs/read_write.c:631
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f80104e30c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8010474268 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f801056b4d0 RCX: 00007f80104e30c9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f8010539010 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8010474280
R13: 6d74702f7665642f R14: 00007f801047427c R15: 00007f801056b4d8
 </TASK>


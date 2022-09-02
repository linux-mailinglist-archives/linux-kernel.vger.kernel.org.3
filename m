Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D94E5AAFEA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 14:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbiIBMpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 08:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237466AbiIBMnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 08:43:43 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF8EEE699
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 05:32:42 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id x15so746571uat.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 05:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=aisHGB6kliCWFYR6hktBFI6xPvEsBHOH5IFtImlUy1Y=;
        b=M3wI0e52BxZLYgTCSnZbFh8BbDd8a8KUQmpDEPATAE8yfijlAuMSq+E133hkT2rGqW
         XLoM5kTB/KGXZ+XQFk28FXOOCSlzwRwb2C1vlwAzX9LAnpvoiLkI2rYy40o53GZLubXt
         km0QsfL0zO0JV/l2bH23bzdvYxV8MKkpmXSmk0f0h5GN44bVG/TLvsPQvX6fIFJ+6xjy
         dD07jsf6adJrDcn4D5up3n3XfYtb0eah4sLfZK1pZu+ivNJFVbamYdfU1Hl3N0JVpD83
         +76HH9FAu1Qk1i35MaI/ibBbNQYrJ3Ptr59a6pC2IHe1U7teSQHAhmK15BdZw5fCPeYN
         Q9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=aisHGB6kliCWFYR6hktBFI6xPvEsBHOH5IFtImlUy1Y=;
        b=oMILWr7M/8fmlpu81Wj81XtXU1nGQat2sQmsxLuduQQLNzSHLu3elfGHrSjo4lwyWx
         JRT/L74QdMNKbl0e3kB4JYqF+ezpNXl6z3yBOl+Y6eibvxfuyjVZlCMrpl7iGjqQ1cyD
         PlrxZYenDL+B7IlXi0xrVk/nUpARRvh591QpEUpU6ON2pdZ3sdbJ4G3j9DR8VsqdokvG
         MOQDvKp3VZXJ90cqh1AR/E9ERkUMniCEUj+vSJqC8+DfysDLUQB8xcrO3K5QaY+diSmU
         QInp/lxHhWuGEIMkIFRY8N3byLxXAgBCBhd+ZHpqZZVBL//14R4SzcUb3Dtbe1nHCRP8
         0t3g==
X-Gm-Message-State: ACgBeo3oFRFvWu0tMSj1INaq88enPq+xaWDcKyy1TRlTLRgUCyMY4BkB
        zLER5vhVfENRkVYEtr8cHCkEhCDEHCvC9o7lMYvcUFLQOLIbHw==
X-Google-Smtp-Source: AA6agR4ZWOZ4z2pkadj7P4hHLA0cjbSI2VE3aHEaR44WlCMPj78gmnaMu3hFIcV5R7gKIQjoW1T1yc7ZBTVSExDUu74=
X-Received: by 2002:ab0:70c6:0:b0:39e:ed14:806b with SMTP id
 r6-20020ab070c6000000b0039eed14806bmr11023117ual.82.1662121865344; Fri, 02
 Sep 2022 05:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007e402e05e6f8b043@google.com>
In-Reply-To: <0000000000007e402e05e6f8b043@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 2 Sep 2022 14:30:54 +0200
Message-ID: <CANp29Y4u7N8wVMZmCa6pY=3kKBSVDWZnhP5n_-RfQpMDWVjOOA@mail.gmail.com>
Subject: Re: [syzbot] WARNING in handle_bug (3)
To:     syzbot <syzbot+0b1ca6d5c5cd600df7a0@syzkaller.appspotmail.com>
Cc:     arve@android.com, brauner@kernel.org, cmllamas@google.com,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        LKML <linux-kernel@vger.kernel.org>, maco@android.com,
        surenb@google.com,
        "'Aleksandr Nogikh' via syzkaller-bugs" 
        <syzkaller-bugs@googlegroups.com>, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: general protection fault in binder_alloc_new_buf

On Wed, Aug 24, 2022 at 10:44 AM syzbot
<syzbot+0b1ca6d5c5cd600df7a0@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    50cd95ac4654 Merge tag 'execve-v6.0-rc2' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=151e0ab5080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e706e91b2a433db
> dashboard link: https://syzkaller.appspot.com/bug?extid=0b1ca6d5c5cd600df7a0
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0b1ca6d5c5cd600df7a0@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 21395 at include/linux/mmap_lock.h:155 mmap_assert_locked include/linux/mmap_lock.h:155 [inline]
> WARNING: CPU: 3 PID: 21395 at include/linux/mmap_lock.h:155 find_vma+0xf8/0x270 mm/mmap.c:2255
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> RAX: 00000000000023cc RBX: 0000000000000000 RCX: ffffc90003259000
> RDX: 0000000000040000 RSI: ffffffff81b5e258 RDI: 0000000000000005
> RBP: 0000000020ffc000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff88801af3f840
>  <TASK>
>  binder_thread_write+0x664/0x3220 drivers/android/binder.c:3974
>  binder_ioctl_write_read drivers/android/binder.c:5024 [inline]
>  binder_ioctl+0x3470/0x6d00 drivers/android/binder.c:5311
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f6019a89279
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f601ac2a168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f6019b9bf80 RCX: 00007f6019a89279
> RDX: 0000000020000380 RSI: 00000000c0306201 RDI: 0000000000000004
> RBP: 00007f6019ae3189 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffd82d3b46f R14: 00007f601ac2a300 R15: 0000000000022000
>  </TASK>
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 3 PID: 21395 Comm: syz-executor.0 Not tainted 6.0.0-rc1-syzkaller-00340-g50cd95ac4654 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  panic+0x2c8/0x627 kernel/panic.c:274
>  __warn.cold+0x259/0x2c4 kernel/panic.c:624
>  report_bug+0x1bc/0x210 lib/bug.c:198
>  handle_bug+0x3c/0x60 arch/x86/kernel/traps.c:316
>  exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:336
>  asm_exc_invalid_op+0x16/0x20 arch/x86/include/asm/idtentry.h:568
> RIP: 0010:mmap_assert_locked include/linux/mmap_lock.h:155 [inline]
> RIP: 0010:find_vma+0xf8/0x270 mm/mmap.c:2255
> Code: 49 8d bc 24 28 01 00 00 be ff ff ff ff e8 a0 4a c9 07 31 ff 89 c3 89 c6 e8 75 54 c5 ff 85 db 0f 85 61 ff ff ff e8 a8 57 c5 ff <0f> 0b e9 55 ff ff ff e8 9c 57 c5 ff 4c 89 e7 e8 64 38 fb ff 0f 0b
> RSP: 0018:ffffc90003bb7530 EFLAGS: 00010212
> RAX: 00000000000023cc RBX: 0000000000000000 RCX: ffffc90003259000
> RDX: 0000000000040000 RSI: ffffffff81b5e258 RDI: 0000000000000005
> RBP: 0000000020ffc000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff88801af3f840
> R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
>  vma_lookup include/linux/mm.h:2743 [inline]
>  binder_alloc_get_vma drivers/android/binder_alloc.c:340 [inline]
>  binder_alloc_new_buf_locked drivers/android/binder_alloc.c:405 [inline]
>  binder_alloc_new_buf+0xd6/0x18b0 drivers/android/binder_alloc.c:590
>  binder_transaction+0x242e/0x9a80 drivers/android/binder.c:3187
>  binder_thread_write+0x664/0x3220 drivers/android/binder.c:3974
>  binder_ioctl_write_read drivers/android/binder.c:5024 [inline]
>  binder_ioctl+0x3470/0x6d00 drivers/android/binder.c:5311
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f6019a89279
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f601ac2a168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f6019b9bf80 RCX: 00007f6019a89279
> RDX: 0000000020000380 RSI: 00000000c0306201 RDI: 0000000000000004
> RBP: 00007f6019ae3189 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffd82d3b46f R14: 00007f601ac2a300 R15: 0000000000022000
>  </TASK>
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000007e402e05e6f8b043%40google.com.

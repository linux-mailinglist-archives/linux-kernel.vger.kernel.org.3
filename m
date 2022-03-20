Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBB14E1E37
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 00:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245410AbiCTXPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 19:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239904AbiCTXPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 19:15:45 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0B8214
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 16:14:19 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id a1-20020a927f01000000b002c76f4191c5so6608393ild.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 16:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=z8fBffXxmozrlNXGVTh3EFC7qZwmpjeuXR9nuEda1lA=;
        b=CZCrgMLqRoV3SMRj1BJ0sIz05SLmV/BLbFCxHJjqh3bqF8jYXvRfT1rsiC6Zfd7Tx8
         o2Jgp3AIx0Oup4QR81hJCpT9oDRH3SeJ49UqVvICV/XbTR3UST1I5VqzvDzkEXnR4gvA
         QLWcHVe+AMjHXnirEygbZ/jByXHC53TTfptfyutvoVxriBGzBjkOAJF0moDRz8VL0Qyy
         JftV4HElWz+dfeMtfHC+qBYiT/+dQqPlW4M7qCgFe4QpdNTCxHrlVWD3fSKErY28F4V3
         iqm77LCFDcb+soJUs8rLXAjafUKwnxb0RBXQDyqLe9E7xDZclXE4VnResxpqAzu0wREe
         PWxQ==
X-Gm-Message-State: AOAM532aIDBrlb3v9umQEi66h3hkc/zN8f4j45PMIVNuEB9RKB64Ttxc
        lXWubH8Clz4ipB0Qp/ZmZ/CbQLs71+D8f0wX9oJcW/sgY4D1
X-Google-Smtp-Source: ABdhPJzsNRXypE+dl5wbFF3CPKZ3aeifJQnBUGa3gvSkIUxGkrBbw1fAyvuIMw/JMIG9Aq7ZEwv88AT9IRRyDwRkUjrt4AcMyEkj
MIME-Version: 1.0
X-Received: by 2002:a92:c5c3:0:b0:2c7:eaa9:7b9f with SMTP id
 s3-20020a92c5c3000000b002c7eaa97b9fmr7594766ilt.249.1647818058190; Sun, 20
 Mar 2022 16:14:18 -0700 (PDT)
Date:   Sun, 20 Mar 2022 16:14:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000035b9c05daae8a5e@google.com>
Subject: [syzbot] WARNING in __do_kernel_fault (2)
From:   syzbot <syzbot+ce865a1a714eca006986@syzkaller.appspotmail.com>
To:     christophe.jaillet@wanadoo.fr, dhowells@redhat.com,
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

Hello,

syzbot found the following issue on:

HEAD commit:    97e9c8eb4bb1 Merge tag 'perf-tools-fixes-for-v5.17-2022-03..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1694a6a3700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=36a8551d1936d7cc
dashboard link: https://syzkaller.appspot.com/bug?extid=ce865a1a714eca006986
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ce865a1a714eca006986@syzkaller.appspotmail.com

 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:621
 el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:584
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 0000000000000034
WARNING: CPU: 1 PID: 7633 at arch/arm64/mm/fault.c:367 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
Modules linked in:
CPU: 1 PID: 7633 Comm: syz-executor.1 Not tainted 5.17.0-rc8-syzkaller-00072-g97e9c8eb4bb1 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
lr : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
sp : ffff80000ab7bab0
x29: ffff80000ab7bab0 x28: fcff000005d10000 x27: 0000000000000000
x26: 0000000000000020 x25: f5ff000028a57300 x24: f0ff0000035f0f00
x23: 0000000096000006 x22: 0000000000000034 x21: 0000000000000025
x20: ffff80000ab7bbd0 x19: 0000000096000006 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffc04df018
x14: 0000000000000368 x13: 0000000000000001 x12: ffff800009e648f8
x11: ffff80000a27feb8 x10: 1e6a3d37d93d9f4a x9 : 61324862b16bb242
x8 : fcff000005d10f38 x7 : f8ff000028943800 x6 : 0000004004276661
x5 : 00000000000f0510 x4 : 0000000000c0000e x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fcff000005d10000
Call trace:
 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
 do_page_fault+0x1c0/0x3b0 arch/arm64/mm/fault.c:669
 do_translation_fault+0xb0/0xc0 arch/arm64/mm/fault.c:680
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:346
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:397
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:579
 __lse_atomic_fetch_add arch/arm64/include/asm/atomic_lse.h:60 [inline]
 __lse_atomic_fetch_sub arch/arm64/include/asm/atomic_lse.h:74 [inline]
 __lse_atomic_sub_return arch/arm64/include/asm/atomic_lse.h:92 [inline]
 arch_atomic_sub_return arch/arm64/include/asm/atomic.h:53 [inline]
 arch_atomic_dec_return include/linux/atomic/atomic-arch-fallback.h:527 [inline]
 arch_atomic_dec_and_test include/linux/atomic/atomic-arch-fallback.h:1105 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:576 [inline]
 page_ref_dec_and_test include/linux/page_ref.h:210 [inline]
 put_page_testzero include/linux/mm.h:718 [inline]
 __free_pages+0x24/0x100 mm/page_alloc.c:5473
 watch_queue_set_size+0x178/0x1e4 kernel/watch_queue.c:275
 pipe_ioctl+0x70/0x18c fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __arm64_sys_ioctl+0xa8/0xec fs/ioctl.c:860
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x70/0x90 arch/arm64/kernel/syscall.c:181
 el0_svc+0x20/0x80 arch/arm64/kernel/entry-common.c:603
 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:621
 el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:584
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 0000000000000034
WARNING: CPU: 1 PID: 7633 at arch/arm64/mm/fault.c:367 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
Modules linked in:
CPU: 1 PID: 7633 Comm: syz-executor.1 Tainted: G        W         5.17.0-rc8-syzkaller-00072-g97e9c8eb4bb1 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
lr : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
sp : ffff80000ab7bab0
x29: ffff80000ab7bab0 x28: fcff000005d10000 x27: 0000000000000000
x26: 0000000000000020 x25: f5ff000028a57300 x24: f0ff0000035f0f00
x23: 0000000096000006 x22: 0000000000000034 x21: 0000000000000025
x20: ffff80000ab7bbd0 x19: 0000000096000006 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffc04df018
x14: 00000000000002b9 x13: 0000000000000001 x12: ffff800009e648f8
x11: ffff80000a27feb8 x10: 1e6a3d37d93d9f4a x9 : 61324862b16bb242
x8 : fcff000005d10f38 x7 : f8ff000028943800 x6 : 0000004004276661
x5 : 00000000000f0510 x4 : 0000000000c0000e x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fcff000005d10000
Call trace:
 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
 do_page_fault+0x1c0/0x3b0 arch/arm64/mm/fault.c:669
 do_translation_fault+0xb0/0xc0 arch/arm64/mm/fault.c:680
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:346
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:397
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:579
 __lse_atomic_fetch_add arch/arm64/include/asm/atomic_lse.h:60 [inline]
 __lse_atomic_fetch_sub arch/arm64/include/asm/atomic_lse.h:74 [inline]
 __lse_atomic_sub_return arch/arm64/include/asm/atomic_lse.h:92 [inline]
 arch_atomic_sub_return arch/arm64/include/asm/atomic.h:53 [inline]
 arch_atomic_dec_return include/linux/atomic/atomic-arch-fallback.h:527 [inline]
 arch_atomic_dec_and_test include/linux/atomic/atomic-arch-fallback.h:1105 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:576 [inline]
 page_ref_dec_and_test include/linux/page_ref.h:210 [inline]
 put_page_testzero include/linux/mm.h:718 [inline]
 __free_pages+0x24/0x100 mm/page_alloc.c:5473
 watch_queue_set_size+0x178/0x1e4 kernel/watch_queue.c:275
 pipe_ioctl+0x70/0x18c fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __arm64_sys_ioctl+0xa8/0xec fs/ioctl.c:860
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x70/0x90 arch/arm64/kernel/syscall.c:181
 el0_svc+0x20/0x80 arch/arm64/kernel/entry-common.c:603
 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:621
 el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:584
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 0000000000000034
WARNING: CPU: 1 PID: 7633 at arch/arm64/mm/fault.c:367 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
Modules linked in:
CPU: 1 PID: 7633 Comm: syz-executor.1 Tainted: G        W         5.17.0-rc8-syzkaller-00072-g97e9c8eb4bb1 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
lr : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
sp : ffff80000ab7bab0
x29: ffff80000ab7bab0 x28: fcff000005d10000 x27: 0000000000000000
x26: 0000000000000020 x25: f5ff000028a57300 x24: f0ff0000035f0f00
x23: 0000000096000006 x22: 0000000000000034 x21: 0000000000000025
x20: ffff80000ab7bbd0 x19: 0000000096000006 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffc04df018
x14: 000000000000024e x13: 0000000000000001 x12: ffff800009e648f8
x11: ffff80000a27feb8 x10: 1e6a3d37d93d9f4a x9 : 61324862b16bb242
x8 : fcff000005d10f38 x7 : f8ff000028943800 x6 : 0000004004276661
x5 : 00000000000f0510 x4 : 0000000000c0000e x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fcff000005d10000
Call trace:
 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
 do_page_fault+0x1c0/0x3b0 arch/arm64/mm/fault.c:669
 do_translation_fault+0xb0/0xc0 arch/arm64/mm/fault.c:680
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:346
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:397
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:579
 __lse_atomic_fetch_add arch/arm64/include/asm/atomic_lse.h:60 [inline]
 __lse_atomic_fetch_sub arch/arm64/include/asm/atomic_lse.h:74 [inline]
 __lse_atomic_sub_return arch/arm64/include/asm/atomic_lse.h:92 [inline]
 arch_atomic_sub_return arch/arm64/include/asm/atomic.h:53 [inline]
 arch_atomic_dec_return include/linux/atomic/atomic-arch-fallback.h:527 [inline]
 arch_atomic_dec_and_test include/linux/atomic/atomic-arch-fallback.h:1105 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:576 [inline]
 page_ref_dec_and_test include/linux/page_ref.h:210 [inline]
 put_page_testzero include/linux/mm.h:718 [inline]
 __free_pages+0x24/0x100 mm/page_alloc.c:5473
 watch_queue_set_size+0x178/0x1e4 kernel/watch_queue.c:275
 pipe_ioctl+0x70/0x18c fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __arm64_sys_ioctl+0xa8/0xec fs/ioctl.c:860
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x70/0x90 arch/arm64/kernel/syscall.c:181
 el0_svc+0x20/0x80 arch/arm64/kernel/entry-common.c:603
 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:621
 el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:584
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 0000000000000034
WARNING: CPU: 1 PID: 7633 at arch/arm64/mm/fault.c:367 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
Modules linked in:
CPU: 1 PID: 7633 Comm: syz-executor.1 Tainted: G        W         5.17.0-rc8-syzkaller-00072-g97e9c8eb4bb1 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
lr : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
sp : ffff80000ab7bab0
x29: ffff80000ab7bab0 x28: fcff000005d10000 x27: 0000000000000000
x26: 0000000000000020 x25: f5ff000028a57300 x24: f0ff0000035f0f00
x23: 0000000096000006 x22: 0000000000000034 x21: 0000000000000025
x20: ffff80000ab7bbd0 x19: 0000000096000006 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000b0295e6f7d38
x14: 0000000000000026 x13: 0000000000000026 x12: ffff800009e648f8
x11: ffff80000a27feb8 x10: 1e6a3d37d93d9f4a x9 : 61324862b16bb242
x8 : fcff000005d10f38 x7 : f8ff000028943800 x6 : 0000004004276661
x5 : 00000000000f0510 x4 : 0000000000c0000e x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fcff000005d10000
Call trace:
 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
 do_page_fault+0x1c0/0x3b0 arch/arm64/mm/fault.c:669
 do_translation_fault+0xb0/0xc0 arch/arm64/mm/fault.c:680
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:346
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:397
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:579
 __lse_atomic_fetch_add arch/arm64/include/asm/atomic_lse.h:60 [inline]
 __lse_atomic_fetch_sub arch/arm64/include/asm/atomic_lse.h:74 [inline]
 __lse_atomic_sub_return arch/arm64/include/asm/atomic_lse.h:92 [inline]
 arch_atomic_sub_return arch/arm64/include/asm/atomic.h:53 [inline]
 arch_atomic_dec_return include/linux/atomic/atomic-arch-fallback.h:527 [inline]
 arch_atomic_dec_and_test include/linux/atomic/atomic-arch-fallback.h:1105 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:576 [inline]
 page_ref_dec_and_test include/linux/page_ref.h:210 [inline]
 put_page_testzero include/linux/mm.h:718 [inline]
 __free_pages+0x24/0x100 mm/page_alloc.c:5473
 watch_queue_set_size+0x178/0x1e4 kernel/watch_queue.c:275
 pipe_ioctl+0x70/0x18c fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __arm64_sys_ioctl+0xa8/0xec fs/ioctl.c:860
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x70/0x90 arch/arm64/kernel/syscall.c:181
 el0_svc+0x20/0x80 arch/arm64/kernel/entry-common.c:603
 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:621
 el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:584
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 0000000000000034
WARNING: CPU: 1 PID: 7633 at arch/arm64/mm/fault.c:367 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
Modules linked in:
CPU: 1 PID: 7633 Comm: syz-executor.1 Tainted: G        W         5.17.0-rc8-syzkaller-00072-g97e9c8eb4bb1 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
lr : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
sp : ffff80000ab7bab0
x29: ffff80000ab7bab0 x28: fcff000005d10000 x27: 0000000000000000
x26: 0000000000000020 x25: f5ff000028a57300 x24: f0ff0000035f0f00
x23: 0000000096000006 x22: 0000000000000034 x21: 0000000000000025
x20: ffff80000ab7bbd0 x19: 0000000096000006 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000ab7b90c85c66
x14: 0000000000000071 x13: 0000000000000071 x12: ffff800009e648f8
x11: ffff80000a27feb8 x10: 1e6a3d37d93d9f4a x9 : 61324862b16bb242
x8 : fcff000005d10f38 x7 : f8ff000028943800 x6 : 0000004004276661
x5 : 00000000000f0510 x4 : 0000000000c0000e x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fcff000005d10000
Call trace:
 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
 do_page_fault+0x1c0/0x3b0 arch/arm64/mm/fault.c:669
 do_translation_fault+0xb0/0xc0 arch/arm64/mm/fault.c:680
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:346
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:397
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:579
 __lse_atomic_fetch_add arch/arm64/include/asm/atomic_lse.h:60 [inline]
 __lse_atomic_fetch_sub arch/arm64/include/asm/atomic_lse.h:74 [inline]
 __lse_atomic_sub_return arch/arm64/include/asm/atomic_lse.h:92 [inline]
 arch_atomic_sub_return arch/arm64/include/asm/atomic.h:53 [inline]
 arch_atomic_dec_return include/linux/atomic/atomic-arch-fallback.h:527 [inline]
 arch_atomic_dec_and_test include/linux/atomic/atomic-arch-fallback.h:1105 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:576 [inline]
 page_ref_dec_and_test include/linux/page_ref.h:210 [inline]
 put_page_testzero include/linux/mm.h:718 [inline]
 __free_pages+0x24/0x100 mm/page_alloc.c:5473
 watch_queue_set_size+0x178/0x1e4 kernel/watch_queue.c:275
 pipe_ioctl+0x70/0x18c fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __arm64_sys_ioctl+0xa8/0xec fs/ioctl.c:860
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x70/0x90 arch/arm64/kernel/syscall.c:181
 el0_svc+0x20/0x80 arch/arm64/kernel/entry-common.c:603
 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:621
 el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:584
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 0000000000000034
WARNING: CPU: 1 PID: 7633 at arch/arm64/mm/fault.c:367 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
Modules linked in:
CPU: 1 PID: 7633 Comm: syz-executor.1 Tainted: G        W         5.17.0-rc8-syzkaller-00072-g97e9c8eb4bb1 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
lr : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
sp : ffff80000ab7bab0
x29: ffff80000ab7bab0 x28: fcff000005d10000 x27: 0000000000000000
x26: 0000000000000020 x25: f5ff000028a57300 x24: f0ff0000035f0f00
x23: 0000000096000006 x22: 0000000000000034 x21: 0000000000000025
x20: ffff80000ab7bbd0 x19: 0000000096000006 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffc04df018
x14: 0000000000000383 x13: 0000000000000001 x12: ffff800009e648f8
x11: ffff80000a27feb8 x10: 1e6a3d37d93d9f4a x9 : 61324862b16bb242
x8 : fcff000005d10f38 x7 : f8ff000028943800 x6 : 0000004004276661
x5 : 00000000000f0510 x4 : 0000000000c0000e x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fcff000005d10000
Call trace:
 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
 do_page_fault+0x1c0/0x3b0 arch/arm64/mm/fault.c:669
 do_translation_fault+0xb0/0xc0 arch/arm64/mm/fault.c:680
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:346
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:397
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:579
 __lse_atomic_fetch_add arch/arm64/include/asm/atomic_lse.h:60 [inline]
 __lse_atomic_fetch_sub arch/arm64/include/asm/atomic_lse.h:74 [inline]
 __lse_atomic_sub_return arch/arm64/include/asm/atomic_lse.h:92 [inline]
 arch_atomic_sub_return arch/arm64/include/asm/atomic.h:53 [inline]
 arch_atomic_dec_return include/linux/atomic/atomic-arch-fallback.h:527 [inline]
 arch_atomic_dec_and_test include/linux/atomic/atomic-arch-fallback.h:1105 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:576 [inline]
 page_ref_dec_and_test include/linux/page_ref.h:210 [inline]
 put_page_testzero include/linux/mm.h:718 [inline]
 __free_pages+0x24/0x100 mm/page_alloc.c:5473
 watch_queue_set_size+0x178/0x1e4 kernel/watch_queue.c:275
 pipe_ioctl+0x70/0x18c fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __arm64_sys_ioctl+0xa8/0xec fs/ioctl.c:860
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x70/0x90 arch/arm64/kernel/syscall.c:181
 el0_svc+0x20/0x80 arch/arm64/kernel/entry-common.c:603
 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:621
 el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:584
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 0000000000000034
WARNING: CPU: 1 PID: 7633 at arch/arm64/mm/fault.c:367 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
Modules linked in:
CPU: 1 PID: 7633 Comm: syz-executor.1 Tainted: G        W         5.17.0-rc8-syzkaller-00072-g97e9c8eb4bb1 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
lr : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
sp : ffff80000ab7bab0
x29: ffff80000ab7bab0 x28: fcff000005d10000 x27: 0000000000000000
x26: 0000000000000020 x25: f5ff000028a57300 x24: f0ff0000035f0f00
x23: 0000000096000006 x22: 0000000000000034 x21: 0000000000000025
x20: ffff80000ab7bbd0 x19: 0000000096000006 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000b4cf6fe551c2
x14: 000000000000000d x13: 000000000000000d x12: ffff800009e648f8
x11: ffff80000a27feb8 x10: 1e6a3d37d93d9f4a x9 : 61324862b16bb242
x8 : fcff000005d10f38 x7 : f8ff000028943800 x6 : 0000004004276661
x5 : 00000000000f0510 x4 : 0000000000c0000e x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fcff000005d10000
Call trace:
 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
 do_page_fault+0x1c0/0x3b0 arch/arm64/mm/fault.c:669
 do_translation_fault+0xb0/0xc0 arch/arm64/mm/fault.c:680
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:346
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:397
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:579
 __lse_atomic_fetch_add arch/arm64/include/asm/atomic_lse.h:60 [inline]
 __lse_atomic_fetch_sub arch/arm64/include/asm/atomic_lse.h:74 [inline]
 __lse_atomic_sub_return arch/arm64/include/asm/atomic_lse.h:92 [inline]
 arch_atomic_sub_return arch/arm64/include/asm/atomic.h:53 [inline]
 arch_atomic_dec_return include/linux/atomic/atomic-arch-fallback.h:527 [inline]
 arch_atomic_dec_and_test include/linux/atomic/atomic-arch-fallback.h:1105 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:576 [inline]
 page_ref_dec_and_test include/linux/page_ref.h:210 [inline]
 put_page_testzero include/linux/mm.h:718 [inline]
 __free_pages+0x24/0x100 mm/page_alloc.c:5473
 watch_queue_set_size+0x178/0x1e4 kernel/watch_queue.c:275
 pipe_ioctl+0x70/0x18c fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __arm64_sys_ioctl+0xa8/0xec fs/ioctl.c:860
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x70/0x90 arch/arm64/kernel/syscall.c:181
 el0_svc+0x20/0x80 arch/arm64/kernel/entry-common.c:603
 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:621
 el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:584
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 0000000000000034
WARNING: CPU: 1 PID: 7633 at arch/arm64/mm/fault.c:367 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
Modules linked in:
CPU: 1 PID: 7633 Comm: syz-executor.1 Tainted: G        W         5.17.0-rc8-syzkaller-00072-g97e9c8eb4bb1 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
lr : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
sp : ffff80000ab7bab0
x29: ffff80000ab7bab0 x28: fcff000005d10000 x27: 0000000000000000
x26: 0000000000000020 x25: f5ff000028a57300 x24: f0ff0000035f0f00
x23: 0000000096000006 x22: 0000000000000034 x21: 0000000000000025
x20: ffff80000ab7bbd0 x19: 0000000096000006 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 0000000000000a58 x12: ffff80000ab7b7b0
x11: ffff80000a35bdf0 x10: 00000000ffffe000 x9 : ffff80000a35bdf0
x8 : ffff80000a2abdf0 x7 : ffff80000a35bdf0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fcff000005d10000
Call trace:
 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
 do_page_fault+0x1c0/0x3b0 arch/arm64/mm/fault.c:669
 do_translation_fault+0xb0/0xc0 arch/arm64/mm/fault.c:680
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:346
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:397
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:579
 __lse_atomic_fetch_add arch/arm64/include/asm/atomic_lse.h:60 [inline]
 __lse_atomic_fetch_sub arch/arm64/include/asm/atomic_lse.h:74 [inline]
 __lse_atomic_sub_return arch/arm64/include/asm/atomic_lse.h:92 [inline]
 arch_atomic_sub_return arch/arm64/include/asm/atomic.h:53 [inline]
 arch_atomic_dec_return include/linux/atomic/atomic-arch-fallback.h:527 [inline]
 arch_atomic_dec_and_test include/linux/atomic/atomic-arch-fallback.h:1105 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:576 [inline]
 page_ref_dec_and_test include/linux/page_ref.h:210 [inline]
 put_page_testzero include/linux/mm.h:718 [inline]
 __free_pages+0x24/0x100 mm/page_alloc.c:5473
 watch_queue_set_size+0x178/0x1e4 kernel/watch_queue.c:275
 pipe_ioctl+0x70/0x18c fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __arm64_sys_ioctl+0xa8/0xec fs/ioctl.c:860
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x70/0x90 arch/arm64/kernel/syscall.c:181
 el0_svc+0x20/0x80 arch/arm64/kernel/entry-common.c:603
 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:621
 el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:584
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 0000000000000034
WARNING: CPU: 1 PID: 7633 at arch/arm64/mm/fault.c:367 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
Modules linked in:
CPU: 1 PID: 7633 Comm: syz-executor.1 Tainted: G        W         5.17.0-rc8-syzkaller-00072-g97e9c8eb4bb1 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
lr : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
sp : ffff80000ab7bab0
x29: ffff80000ab7bab0 x28: fcff000005d10000 x27: 0000000000000000
x26: 0000000000000020 x25: f5ff000028a57300 x24: f0ff0000035f0f00
x23: 0000000096000006 x22: 0000000000000034 x21: 0000000000000025
x20: ffff80000ab7bbd0 x19: 0000000096000006 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 00009ffefe911fb6
x14: 00000000000001ca x13: 00000000000001ca x12: ffff800009e648f8
x11: ffff80000a27feb8 x10: 1e6a3d37d93d9f4a x9 : 61324862b16bb242
x8 : fcff000005d10f38 x7 : f8ff000028943800 x6 : 0000004004276661
x5 : 00000000000f0510 x4 : 0000000000c0000e x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fcff000005d10000
Call trace:
 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
 do_page_fault+0x1c0/0x3b0 arch/arm64/mm/fault.c:669
 do_translation_fault+0xb0/0xc0 arch/arm64/mm/fault.c:680
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:346
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:397
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:579
 __lse_atomic_fetch_add arch/arm64/include/asm/atomic_lse.h:60 [inline]
 __lse_atomic_fetch_sub arch/arm64/include/asm/atomic_lse.h:74 [inline]
 __lse_atomic_sub_return arch/arm64/include/asm/atomic_lse.h:92 [inline]
 arch_atomic_sub_return arch/arm64/include/asm/atomic.h:53 [inline]
 arch_atomic_dec_return include/linux/atomic/atomic-arch-fallback.h:527 [inline]
 arch_atomic_dec_and_test include/linux/atomic/atomic-arch-fallback.h:1105 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:576 [inline]
 page_ref_dec_and_test include/linux/page_ref.h:210 [inline]
 put_page_testzero include/linux/mm.h:718 [inline]
 __free_pages+0x24/0x100 mm/page_alloc.c:5473
 watch_queue_set_size+0x178/0x1e4 kernel/watch_queue.c:275
 pipe_ioctl+0x70/0x18c fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __arm64_sys_ioctl+0xa8/0xec fs/ioctl.c:860
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x70/0x90 arch/arm64/kernel/syscall.c:181
 el0_svc+0x20/0x80 arch/arm64/kernel/entry-common.c:603
 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:621
 el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:584
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 0000000000000034
WARNING: CPU: 1 PID: 7633 at arch/arm64/mm/fault.c:367 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
Modules linked in:
CPU: 1 PID: 7633 Comm: syz-executor.1 Tainted: G        W         5.17.0-rc8-syzkaller-00072-g97e9c8eb4bb1 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
lr : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
sp : ffff80000ab7bab0
x29: ffff80000ab7bab0 x28: fcff000005d10000 x27: 0000000000000000
x26: 0000000000000020 x25: f5ff000028a57300 x24: f0ff0000035f0f00
x23: 0000000096000006 x22: 0000000000000034 x21: 0000000000000025
x20: ffff80000ab7bbd0 x19: 0000000096000006 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffc04df018
x14: 0000000000000334 x13: 0000000000000001 x12: ffff800009e648f8
x11: ffff80000a27feb8 x10: 1e6a3d37d93d9f4a x9 : 61324862b16bb242
x8 : fcff000005d10f38 x7 : f8ff000028943800 x6 : 0000004004276661
x5 : 00000000000f0510 x4 : 0000000000c0000e x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fcff000005d10000
Call trace:
 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
 do_page_fault+0x1c0/0x3b0 arch/arm64/mm/fault.c:669
 do_translation_fault+0xb0/0xc0 arch/arm64/mm/fault.c:680
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:346
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:397
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:579
 __lse_atomic_fetch_add arch/arm64/include/asm/atomic_lse.h:60 [inline]
 __lse_atomic_fetch_sub arch/arm64/include/asm/atomic_lse.h:74 [inline]
 __lse_atomic_sub_return arch/arm64/include/asm/atomic_lse.h:92 [inline]
 arch_atomic_sub_return arch/arm64/include/asm/atomic.h:53 [inline]
 arch_atomic_dec_return include/linux/atomic/atomic-arch-fallback.h:527 [inline]
 arch_atomic_dec_and_test include/linux/atomic/atomic-arch-fallback.h:1105 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:576 [inline]
 page_ref_dec_and_test include/linux/page_ref.h:210 [inline]
 put_page_testzero include/linux/mm.h:718 [inline]
 __free_pages+0x24/0x100 mm/page_alloc.c:5473
 watch_queue_set_size+0x178/0x1e4 kernel/watch_queue.c:275
 pipe_ioctl+0x70/0x18c fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __arm64_sys_ioctl+0xa8/0xec fs/ioctl.c:860
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x70/0x90 arch/arm64/kernel/syscall.c:181
 el0_svc+0x20/0x80 arch/arm64/kernel/entry-common.c:603
 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:621
 el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:584
---[ end trace 0000000000000000 ]---
__do_kernel_fault: 38776 callbacks suppressed
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 0000000000000034
WARNING: CPU: 0 PID: 7633 at arch/arm64/mm/fault.c:367 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
Modules linked in:
CPU: 0 PID: 7633 Comm: syz-executor.1 Tainted: G        W         5.17.0-rc8-syzkaller-00072-g97e9c8eb4bb1 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
lr : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
sp : ffff80000ab7bab0
x29: ffff80000ab7bab0 x28: fcff000005d10000 x27: 0000000000000000
x26: 0000000000000020 x25: f5ff000028a57300 x24: f0ff0000035f0f00
x23: 0000000096000006 x22: 0000000000000034 x21: 0000000000000025
x20: ffff80000ab7bbd0 x19: 0000000096000006 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 0000000000000ace x12: ffff80000ab7b7b0
x11: ffff80000a35bdf0 x10: 00000000ffffe000 x9 : ffff80000a35bdf0
x8 : ffff80000a2abdf0 x7 : ffff80000a35bdf0 x6 : 0000000000000000
x5 : ffff00007fbbc9c8 x4 : 0000000000015ff5 x3 : 0000000000000001
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fcff000005d10000
Call trace:
 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
 do_page_fault+0x1c0/0x3b0 arch/arm64/mm/fault.c:669
 do_translation_fault+0xb0/0xc0 arch/arm64/mm/fault.c:680
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:346
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:397
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:579
 __lse_atomic_fetch_add arch/arm64/include/asm/atomic_lse.h:60 [inline]
 __lse_atomic_fetch_sub arch/arm64/include/asm/atomic_lse.h:74 [inline]
 __lse_atomic_sub_return arch/arm64/include/asm/atomic_lse.h:92 [inline]
 arch_atomic_sub_return arch/arm64/include/asm/atomic.h:53 [inline]
 arch_atomic_dec_return include/linux/atomic/atomic-arch-fallback.h:527 [inline]
 arch_atomic_dec_and_test include/linux/atomic/atomic-arch-fallback.h:1105 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:576 [inline]
 page_ref_dec_and_test include/linux/page_ref.h:210 [inline]
 put_page_testzero include/linux/mm.h:718 [inline]
 __free_pages+0x24/0x100 mm/page_alloc.c:5473
 watch_queue_set_size+0x178/0x1e4 kernel/watch_queue.c:275
 pipe_ioctl+0x70/0x18c fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __arm64_sys_ioctl+0xa8/0xec fs/ioctl.c:860
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x70/0x90 arch/arm64/kernel/syscall.c:181
 el0_svc+0x20/0x80 arch/arm64/kernel/entry-common.c:603
 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:621
 el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:584
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 0000000000000034
WARNING: CPU: 0 PID: 7633 at arch/arm64/mm/fault.c:367 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
Modules linked in:
CPU: 0 PID: 7633 Comm: syz-executor.1 Tainted: G        W         5.17.0-rc8-syzkaller-00072-g97e9c8eb4bb1 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
lr : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
sp : ffff80000ab7bab0
x29: ffff80000ab7bab0 x28: fcff000005d10000 x27: 0000000000000000
x26: 0000000000000020 x25: f5ff000028a57300 x24: f0ff0000035f0f00
x23: 0000000096000006 x22: 0000000000000034 x21: 0000000000000025
x20: ffff80000ab7bbd0 x19: 0000000096000006 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000a7bc8c5e1922
x14: 00000000000003b5 x13: 00000000000003b5 x12: ffff800009e648f8
x11: ffff80000a27feb8 x10: 1e6a3d37d93d9f4a x9 : 61324862b16bb242
x8 : fcff000005d10f38 x7 : ffff00007fbc3980 x6 : 0000004004276661
x5 : 00000000000f0510 x4 : 0000000000c0000e x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fcff000005d10000
Call trace:
 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
 do_page_fault+0x1c0/0x3b0 arch/arm64/mm/fault.c:669
 do_translation_fault+0xb0/0xc0 arch/arm64/mm/fault.c:680
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:346
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:397
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:579
 __lse_atomic_fetch_add arch/arm64/include/asm/atomic_lse.h:60 [inline]
 __lse_atomic_fetch_sub arch/arm64/include/asm/atomic_lse.h:74 [inline]
 __lse_atomic_sub_return arch/arm64/include/asm/atomic_lse.h:92 [inline]
 arch_atomic_sub_return arch/arm64/include/asm/atomic.h:53 [inline]
 arch_atomic_dec_return include/linux/atomic/atomic-arch-fallback.h:527 [inline]
 arch_atomic_dec_and_test include/linux/atomic/atomic-arch-fallback.h:1105 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:576 [inline]
 page_ref_dec_and_test include/linux/page_ref.h:210 [inline]
 put_page_testzero include/linux/mm.h:718 [inline]
 __free_pages+0x24/0x100 mm/page_alloc.c:5473
 watch_queue_set_size+0x178/0x1e4 kernel/watch_queue.c:275
 pipe_ioctl+0x70/0x18c fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __arm64_sys_ioctl+0xa8/0xec fs/ioctl.c:860
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x70/0x90 arch/arm64/kernel/syscall.c:181
 el0_svc+0x20/0x80 arch/arm64/kernel/entry-common.c:603
 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:621
 el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:584
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 0000000000000034
WARNING: CPU: 0 PID: 7633 at arch/arm64/mm/fault.c:367 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
Modules linked in:
CPU: 0 PID: 7633 Comm: syz-executor.1 Tainted: G        W         5.17.0-rc8-syzkaller-00072-g97e9c8eb4bb1 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
lr : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
sp : ffff80000ab7bab0
x29: ffff80000ab7bab0 x28: fcff000005d10000 x27: 0000000000000000
x26: 0000000000000020 x25: f5ff000028a57300 x24: f0ff0000035f0f00
x23: 0000000096000006 x22: 0000000000000034 x21: 0000000000000025
x20: ffff80000ab7bbd0 x19: 0000000096000006 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 0000000000000b1c x12: ffff80000ab7b7b0
x11: ffff80000a35bdf0 x10: 00000000ffffe000 x9 : ffff80000a35bdf0
x8 : ffff80000a2abdf0 x7 : ffff80000a35bdf0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fcff000005d10000
Call trace:
 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
 do_page_fault+0x1c0/0x3b0 arch/arm64/mm/fault.c:669
 do_translation_fault+0xb0/0xc0 arch/arm64/mm/fault.c:680
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:346
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:397
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:579
 __lse_atomic_fetch_add arch/arm64/include/asm/atomic_lse.h:60 [inline]
 __lse_atomic_fetch_sub arch/arm64/include/asm/atomic_lse.h:74 [inline]
 __lse_atomic_sub_return arch/arm64/include/asm/atomic_lse.h:92 [inline]
 arch_atomic_sub_return arch/arm64/include/asm/atomic.h:53 [inline]
 arch_atomic_dec_return include/linux/atomic/atomic-arch-fallback.h:527 [inline]
 arch_atomic_dec_and_test include/linux/atomic/atomic-arch-fallback.h:1105 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:576 [inline]
 page_ref_dec_and_test include/linux/page_ref.h:210 [inline]
 put_page_testzero include/linux/mm.h:718 [inline]
 __free_pages+0x24/0x100 mm/page_alloc.c:5473
 watch_queue_set_size+0x178/0x1e4 kernel/watch_queue.c:275
 pipe_ioctl+0x70/0x18c fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __arm64_sys_ioctl+0xa8/0xec fs/ioctl.c:860
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x70/0x90 arch/arm64/kernel/syscall.c:181
 el0_svc+0x20/0x80 arch/arm64/kernel/entry-common.c:603
 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:621
 el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:584
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 0000000000000034
WARNING: CPU: 0 PID: 7633 at arch/arm64/mm/fault.c:367 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
Modules linked in:
CPU: 0 PID: 7633 Comm: syz-executor.1 Tainted: G        W         5.17.0-rc8-syzkaller-00072-g97e9c8eb4bb1 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
lr : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
sp : ffff80000ab7bab0
x29: ffff80000ab7bab0 x28: fcff000005d10000 x27: 0000000000000000
x26: 0000000000000020 x25: f5ff000028a57300 x24: f0ff0000035f0f00
x23: 0000000096000006 x22: 0000000000000034 x21: 0000000000000025
x20: ffff80000ab7bbd0 x19: 0000000096000006 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 0000000000000b43 x12: ffff80000ab7b7b0
x11: ffff80000a35bdf0 x10: 00000000ffffe000 x9 : ffff80000a35bdf0
x8 : ffff80000a2abdf0 x7 : ffff80000a35bdf0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fcff000005d10000
Call trace:
 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
 do_page_fault+0x1c0/0x3b0 arch/arm64/mm/fault.c:669
 do_translation_fault+0xb0/0xc0 arch/arm64/mm/fault.c:680
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:346
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:397
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:579
 __lse_atomic_fetch_add arch/arm64/include/asm/atomic_lse.h:60 [inline]
 __lse_atomic_fetch_sub arch/arm64/include/asm/atomic_lse.h:74 [inline]
 __lse_atomic_sub_return arch/arm64/include/asm/atomic_lse.h:92 [inline]
 arch_atomic_sub_return arch/arm64/include/asm/atomic.h:53 [inline]
 arch_atomic_dec_return include/linux/atomic/atomic-arch-fallback.h:527 [inline]
 arch_atomic_dec_and_test include/linux/atomic/atomic-arch-fallback.h:1105 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:576 [inline]
 page_ref_dec_and_test include/linux/page_ref.h:210 [inline]
 put_page_testzero include/linux/mm.h:718 [inline]
 __free_pages+0x24/0x100 mm/page_alloc.c:5473
 watch_queue_set_size+0x178/0x1e4 kernel/watch_queue.c:275
 pipe_ioctl+0x70/0x18c fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __arm64_sys_ioctl+0xa8/0xec fs/ioctl.c:860
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x70/0x90 arch/arm64/kernel/syscall.c:181
 el0_svc+0x20/0x80 arch/arm64/kernel/entry-common.c:603
 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:621
 el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:584
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 0000000000000034
WARNING: CPU: 0 PID: 7633 at arch/arm64/mm/fault.c:367 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
Modules linked in:
CPU: 0 PID: 7633 Comm: syz-executor.1 Tainted: G        W         5.17.0-rc8-syzkaller-00072-g97e9c8eb4bb1 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
lr : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
sp : ffff80000ab7bab0
x29: ffff80000ab7bab0 x28: fcff000005d10000 x27: 0000000000000000
x26: 0000000000000020 x25: f5ff000028a57300 x24: f0ff0000035f0f00
x23: 0000000096000006 x22: 0000000000000034 x21: 0000000000000025
x20: ffff80000ab7bbd0 x19: 0000000096000006 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffc04df018
x14: 000000000000024e x13: 0000000000000001 x12: ffff800009e648f8
x11: ffff80000a27feb8 x10: 1e6a3d37d93d9f4a x9 : 61324862b16bb242
x8 : fcff000005d10f38 x7 : f7ff00002894a800 x6 : 0000004004276661
x5 : 00000000000f0510 x4 : 0000000000c0000e x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fcff000005d10000
Call trace:
 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
 do_page_fault+0x1c0/0x3b0 arch/arm64/mm/fault.c:669
 do_translation_fault+0xb0/0xc0 arch/arm64/mm/fault.c:680
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:346
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:397
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:579
 __lse_atomic_fetch_add arch/arm64/include/asm/atomic_lse.h:60 [inline]
 __lse_atomic_fetch_sub arch/arm64/include/asm/atomic_lse.h:74 [inline]
 __lse_atomic_sub_return arch/arm64/include/asm/atomic_lse.h:92 [inline]
 arch_atomic_sub_return arch/arm64/include/asm/atomic.h:53 [inline]
 arch_atomic_dec_return include/linux/atomic/atomic-arch-fallback.h:527 [inline]
 arch_atomic_dec_and_test include/linux/atomic/atomic-arch-fallback.h:1105 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:576 [inline]
 page_ref_dec_and_test include/linux/page_ref.h:210 [inline]
 put_page_testzero include/linux/mm.h:718 [inline]
 __free_pages+0x24/0x100 mm/page_alloc.c:5473
 watch_queue_set_size+0x178/0x1e4 kernel/watch_queue.c:275
 pipe_ioctl+0x70/0x18c fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __arm64_sys_ioctl+0xa8/0xec fs/ioctl.c:860
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x70/0x90 arch/arm64/kernel/syscall.c:181
 el0_svc+0x20/0x80 arch/arm64/kernel/entry-common.c:603
 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:621
 el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:584
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 0000000000000034
WARNING: CPU: 0 PID: 7633 at arch/arm64/mm/fault.c:367 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
Modules linked in:
CPU: 0 PID: 7633 Comm: syz-executor.1 Tainted: G        W         5.17.0-rc8-syzkaller-00072-g97e9c8eb4bb1 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
lr : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
sp : ffff80000ab7bab0
x29: ffff80000ab7bab0 x28: fcff000005d10000 x27: 0000000000000000
x26: 0000000000000020 x25: f5ff000028a57300 x24: f0ff0000035f0f00
x23: 0000000096000006 x22: 0000000000000034 x21: 0000000000000025
x20: ffff80000ab7bbd0 x19: 0000000096000006 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 0000000000000b91 x12: ffff80000ab7b7b0
x11: ffff80000a35bdf0 x10: 00000000ffffe000 x9 : ffff80000a35bdf0
x8 : ffff80000a2abdf0 x7 : ffff80000a35bdf0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fcff000005d10000
Call trace:
 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
 do_page_fault+0x1c0/0x3b0 arch/arm64/mm/fault.c:669
 do_translation_fault+0xb0/0xc0 arch/arm64/mm/fault.c:680
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:346
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:397
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:579
 __lse_atomic_fetch_add arch/arm64/include/asm/atomic_lse.h:60 [inline]
 __lse_atomic_fetch_sub arch/arm64/include/asm/atomic_lse.h:74 [inline]
 __lse_atomic_sub_return arch/arm64/include/asm/atomic_lse.h:92 [inline]
 arch_atomic_sub_return arch/arm64/include/asm/atomic.h:53 [inline]
 arch_atomic_dec_return include/linux/atomic/atomic-arch-fallback.h:527 [inline]
 arch_atomic_dec_and_test include/linux/atomic/atomic-arch-fallback.h:1105 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:576 [inline]
 page_ref_dec_and_test include/linux/page_ref.h:210 [inline]
 put_page_testzero include/linux/mm.h:718 [inline]
 __free_pages+0x24/0x100 mm/page_alloc.c:5473
 watch_queue_set_size+0x178/0x1e4 kernel/watch_queue.c:275
 pipe_ioctl+0x70/0x18c fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __arm64_sys_ioctl+0xa8/0xec fs/ioctl.c:860
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x70/0x90 arch/arm64/kernel/syscall.c:181
 el0_svc+0x20/0x80 arch/arm64/kernel/entry-common.c:603
 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:621
 el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:584
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 0000000000000034
WARNING: CPU: 0 PID: 7633 at arch/arm64/mm/fault.c:367 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
Modules linked in:
CPU: 0 PID: 7633 Comm: syz-executor.1 Tainted: G        W         5.17.0-rc8-syzkaller-00072-g97e9c8eb4bb1 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
lr : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
sp : ffff80000ab7bab0
x29: ffff80000ab7bab0 x28: fcff000005d10000 x27: 0000000000000000
x26: 0000000000000020 x25: f5ff000028a57300 x24: f0ff0000035f0f00
x23: 0000000096000006 x22: 0000000000000034 x21: 0000000000000025
x20: ffff80000ab7bbd0 x19: 0000000096000006 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffc04df018
x14: 0000000000000234 x13: 0000000000000001 x12: ffff800009e648f8
x11: ffff80000a27feb8 x10: 1e6a3d37d93d9f4a x9 : 61324862b16bb242
x8 : fcff000005d10f38 x7 : f7ff00002894a800 x6 : 0000004004276661
x5 : 00000000000f0510 x4 : 0000000000c0000e x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fcff000005d10000
Call trace:
 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
 do_page_fault+0x1c0/0x3b0 arch/arm64/mm/fault.c:669
 do_translation_fault+0xb0/0xc0 arch/arm64/mm/fault.c:680
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:346
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:397
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:579
 __lse_atomic_fetch_add arch/arm64/include/asm/atomic_lse.h:60 [inline]
 __lse_atomic_fetch_sub arch/arm64/include/asm/atomic_lse.h:74 [inline]
 __lse_atomic_sub_return arch/arm64/include/asm/atomic_lse.h:92 [inline]
 arch_atomic_sub_return arch/arm64/include/asm/atomic.h:53 [inline]
 arch_atomic_dec_return include/linux/atomic/atomic-arch-fallback.h:527 [inline]
 arch_atomic_dec_and_test include/linux/atomic/atomic-arch-fallback.h:1105 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:576 [inline]
 page_ref_dec_and_test include/linux/page_ref.h:210 [inline]
 put_page_testzero include/linux/mm.h:718 [inline]
 __free_pages+0x24/0x100 mm/page_alloc.c:5473
 watch_queue_set_size+0x178/0x1e4 kernel/watch_queue.c:275
 pipe_ioctl+0x70/0x18c fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __arm64_sys_ioctl+0xa8/0xec fs/ioctl.c:860
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x70/0x90 arch/arm64/kernel/syscall.c:181
 el0_svc+0x20/0x80 arch/arm64/kernel/entry-common.c:603
 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:621
 el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:584
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 0000000000000034
WARNING: CPU: 0 PID: 7633 at arch/arm64/mm/fault.c:367 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
Modules linked in:
CPU: 0 PID: 7633 Comm: syz-executor.1 Tainted: G        W         5.17.0-rc8-syzkaller-00072-g97e9c8eb4bb1 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
lr : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
sp : ffff80000ab7bab0
x29: ffff80000ab7bab0 x28: fcff000005d10000 x27: 0000000000000000
x26: 0000000000000020 x25: f5ff000028a57300 x24: f0ff0000035f0f00
x23: 0000000096000006 x22: 0000000000000034 x21: 0000000000000025
x20: ffff80000ab7bbd0 x19: 0000000096000006 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffc04df018
x14: 00000000000001ad x13: 0000000000000001 x12: ffff800009e648f8
x11: ffff80000a27feb8 x10: 1e6a3d37d93d9f4a x9 : 61324862b16bb242
x8 : fcff000005d10f38 x7 : f7ff00002894a800 x6 : 0000004004276661
x5 : 00000000000f0510 x4 : 0000000000c0000e x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fcff000005d10000
Call trace:
 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
 do_page_fault+0x1c0/0x3b0 arch/arm64/mm/fault.c:669
 do_translation_fault+0xb0/0xc0 arch/arm64/mm/fault.c:680
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:346
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:397
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:579
 __lse_atomic_fetch_add arch/arm64/include/asm/atomic_lse.h:60 [inline]
 __lse_atomic_fetch_sub arch/arm64/include/asm/atomic_lse.h:74 [inline]
 __lse_atomic_sub_return arch/arm64/include/asm/atomic_lse.h:92 [inline]
 arch_atomic_sub_return arch/arm64/include/asm/atomic.h:53 [inline]
 arch_atomic_dec_return include/linux/atomic/atomic-arch-fallback.h:527 [inline]
 arch_atomic_dec_and_test include/linux/atomic/atomic-arch-fallback.h:1105 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:576 [inline]
 page_ref_dec_and_test include/linux/page_ref.h:210 [inline]
 put_page_testzero include/linux/mm.h:718 [inline]
 __free_pages+0x24/0x100 mm/page_alloc.c:5473
 watch_queue_set_size+0x178/0x1e4 kernel/watch_queue.c:275
 pipe_ioctl+0x70/0x18c fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __arm64_sys_ioctl+0xa8/0xec fs/ioctl.c:860
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x70/0x90 arch/arm64/kernel/syscall.c:181
 el0_svc+0x20/0x80 arch/arm64/kernel/entry-common.c:603
 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:621
 el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:584
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 0000000000000034
WARNING: CPU: 0 PID: 7633 at arch/arm64/mm/fault.c:367 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
Modules linked in:
CPU: 0 PID: 7633 Comm: syz-executor.1 Tainted: G        W         5.17.0-rc8-syzkaller-00072-g97e9c8eb4bb1 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
lr : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
sp : ffff80000ab7bab0
x29: ffff80000ab7bab0 x28: fcff000005d10000 x27: 0000000000000000
x26: 0000000000000020 x25: f5ff000028a57300 x24: f0ff0000035f0f00
x23: 0000000096000006 x22: 0000000000000034 x21: 0000000000000025
x20: ffff80000ab7bbd0 x19: 0000000096000006 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 0000000000000c06 x12: ffff80000ab7b7b0
x11: ffff80000a35bdf0 x10: 00000000ffffe000 x9 : ffff80000a35bdf0
x8 : ffff80000a2abdf0 x7 : ffff80000a35bdf0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fcff000005d10000
Call trace:
 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
 do_page_fault+0x1c0/0x3b0 arch/arm64/mm/fault.c:669
 do_translation_fault+0xb0/0xc0 arch/arm64/mm/fault.c:680
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:346
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:397
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:579
 __lse_atomic_fetch_add arch/arm64/include/asm/atomic_lse.h:60 [inline]
 __lse_atomic_fetch_sub arch/arm64/include/asm/atomic_lse.h:74 [inline]
 __lse_atomic_sub_return arch/arm64/include/asm/atomic_lse.h:92 [inline]
 arch_atomic_sub_return arch/arm64/include/asm/atomic.h:53 [inline]
 arch_atomic_dec_return include/linux/atomic/atomic-arch-fallback.h:527 [inline]
 arch_atomic_dec_and_test include/linux/atomic/atomic-arch-fallback.h:1105 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:576 [inline]
 page_ref_dec_and_test include/linux/page_ref.h:210 [inline]
 put_page_testzero include/linux/mm.h:718 [inline]
 __free_pages+0x24/0x100 mm/page_alloc.c:5473
 watch_queue_set_size+0x178/0x1e4 kernel/watch_queue.c:275
 pipe_ioctl+0x70/0x18c fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __arm64_sys_ioctl+0xa8/0xec fs/ioctl.c:860
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x70/0x90 arch/arm64/kernel/syscall.c:181
 el0_svc+0x20/0x80 arch/arm64/kernel/entry-common.c:603
 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:621
 el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:584
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 0000000000000034
WARNING: CPU: 0 PID: 7633 at arch/arm64/mm/fault.c:367 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
Modules linked in:
CPU: 0 PID: 7633 Comm: syz-executor.1 Tainted: G        W         5.17.0-rc8-syzkaller-00072-g97e9c8eb4bb1 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
lr : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
sp : ffff80000ab7bab0
x29: ffff80000ab7bab0 x28: fcff000005d10000 x27: 0000000000000000
x26: 0000000000000020 x25: f5ff000028a57300 x24: f0ff0000035f0f00
x23: 0000000096000006 x22: 0000000000000034 x21: 0000000000000025
x20: ffff80000ab7bbd0 x19: 0000000096000006 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000ae7dd93450e2
x14: 00000000000000ab x13: 00000000000000ab x12: ffff800009e648f8
x11: ffff80000a27feb8 x10: 1e6a3d37d93d9f4a x9 : 61324862b16bb242
x8 : fcff000005d10f38 x7 : f7ff00002894a800 x6 : 0000004004276661
x5 : 00000000000f0510 x4 : 0000000000c0000e x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fcff000005d10000
Call trace:
 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
 do_page_fault+0x1c0/0x3b0 arch/arm64/mm/fault.c:669
 do_translation_fault+0xb0/0xc0 arch/arm64/mm/fault.c:680
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:346
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:397
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:579
 __lse_atomic_fetch_add arch/arm64/include/asm/atomic_lse.h:60 [inline]
 __lse_atomic_fetch_sub arch/arm64/include/asm/atomic_lse.h:74 [inline]
 __lse_atomic_sub_return arch/arm64/include/asm/atomic_lse.h:92 [inline]
 arch_atomic_sub_return arch/arm64/include/asm/atomic.h:53 [inline]
 arch_atomic_dec_return include/linux/atomic/atomic-arch-fallback.h:527 [inline]
 arch_atomic_dec_and_test include/linux/atomic/atomic-arch-fallback.h:1105 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:576 [inline]
 page_ref_dec_and_test include/linux/page_ref.h:210 [inline]
 put_page_testzero include/linux/mm.h:718 [inline]
 __free_pages+0x24/0x100 mm/page_alloc.c:5473
 watch_queue_set_size+0x178/0x1e4 kernel/watch_queue.c:275
 pipe_ioctl+0x70/0x18c fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __arm64_sys_ioctl+0xa8/0xec fs/ioctl.c:860
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x70/0x90 arch/arm64/kernel/syscall.c:181
 el0_svc+0x20/0x80 arch/arm64/kernel/entry-common.c:603
 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:621
 el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:584
---[ end trace 0000000000000000 ]---
__do_kernel_fault: 49787 callbacks suppressed
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 0000000000000034
WARNING: CPU: 0 PID: 7633 at arch/arm64/mm/fault.c:367 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
Modules linked in:
CPU: 0 PID: 7633 Comm: syz-executor.1 Tainted: G        W         5.17.0-rc8-syzkaller-00072-g97e9c8eb4bb1 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
lr : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
sp : ffff80000ab7bab0
x29: ffff80000ab7bab0 x28: fcff000005d10000 x27: 0000000000000000
x26: 0000000000000020 x25: f5ff000028a57300 x24: f0ff0000035f0f00
x23: 0000000096000006 x22: 0000000000000034 x21: 0000000000000025
x20: ffff80000ab7bbd0 x19: 0000000096000006 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 0000000000000c55 x12: ffff80000ab7b7b0
x11: ffff80000a35bdf0 x10: 00000000ffffe000 x9 : ffff80000a35bdf0
x8 : ffff80000a2abdf0 x7 : ffff80000a35bdf0 x6 : 0000000000000000
x5 : ffff00007fbbc9c8 x4 : 0000000000015ff5 x3 : 0000000000000001
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fcff000005d10000
Call trace:
 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
 do_page_fault+0x1c0/0x3b0 arch/arm64/mm/fault.c:669
 do_translation_fault+0xb0/0xc0 arch/arm64/mm/fault.c:680
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:346
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:397
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:579
 __lse_atomic_fetch_add arch/arm64/include/asm/atomic_lse.h:60 [inline]
 __lse_atomic_fetch_sub arch/arm64/include/asm/atomic_lse.h:74 [inline]
 __lse_atomic_sub_return arch/arm64/include/asm/atomic_lse.h:92 [inline]
 arch_atomic_sub_return arch/arm64/include/asm/atomic.h:53 [inline]
 arch_atomic_dec_return include/linux/atomic/atomic-arch-fallback.h:527 [inline]
 arch_atomic_dec_and_test include/linux/atomic/atomic-arch-fallback.h:1105 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:576 [inline]
 page_ref_dec_and_test include/linux/page_ref.h:210 [inline]
 put_page_testzero include/linux/mm.h:718 [inline]
 __free_pages+0x24/0x100 mm/page_alloc.c:5473
 watch_queue_set_size+0x178/0x1e4 kernel/watch_queue.c:275
 pipe_ioctl+0x70/0x18c fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __arm64_sys_ioctl+0xa8/0xec fs/ioctl.c:860
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x70/0x90 arch/arm64/kernel/syscall.c:181
 el0_svc+0x20/0x80 arch/arm64/kernel/entry-common.c:603
 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:621
 el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:584
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 0000000000000034
WARNING: CPU: 0 PID: 7633 at arch/arm64/mm/fault.c:367 __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
Modules linked in:
CPU: 0 PID: 7633 Comm: syz-executor.1 Tainted: G        W         5.17.0-rc8-syzkaller-00072-g97e9c8eb4bb1 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
lr : __do_kernel_fault+0x14c/0x1c0 arch/arm64/mm/fault.c:367
sp : ffff80000ab7bab0
x29: ffff80000ab7bab0 x28: fcff000005d10000 x27: 0000000000000000
x26: 0000000000000020 x25: f5ff000028a57300 x24: f0ff0000035f0f00
x23: 0000000096000006 x22: 0000000000000034 x21: 0000000000000025
x20: ffff80000ab7bbd0 x19: 0000000096000006

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

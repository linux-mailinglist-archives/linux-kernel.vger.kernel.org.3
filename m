Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C64586C3E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiHANtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiHANta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:49:30 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBE433E09
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 06:49:29 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id v14-20020a6b5b0e000000b0067bc967a6c0so3730297ioh.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 06:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=bEddIquHKlMsb+5oISXhSJ25u5THMB3fh2aBEcHb+uM=;
        b=kMN0g9gkA1rZzMyFYVVbXMc1Spd4PaDW77WCTEOPH0PRD5kwZWbgI6vLXcbJqXzamW
         zRtP6wjfRN2JE2QN1+DsUOp9ll4dONbkCNylrLAUonVrzdJLVKN/Vn9BY77ym0dYa9fo
         wKxTxpOpnoD9TVikpQRRZjEt3xCFYBxQcRar374VPaPdUZOhmlVYS7luTjbprSq6jdiB
         K8/CD6SyT5WHj+RNZ+DCWLWs8W+kO8e7/vBP8JWPVa3OCOlSP82l8Ux2rjUsYpS/XjGB
         QC7KDS/ved51JhfNpu4CRKjHjl8ZxbTR1IFEZrAE+lLyXCdlsbiN3fjvM4kwpQeE3+Cj
         TAdQ==
X-Gm-Message-State: AJIora/WVW9vDK/bkUQ/RZ0IibdQ4O+ZUtf07sKowrtHv4JtqpxHB8wu
        17tCrlpewe1zBlG6hvlNXSAb7D+ASZwdzUbdS9+A5kJTmDpE
X-Google-Smtp-Source: AGRyM1uGqi2grww7Yav8a4tHH6gvt65HkicyaB63ZcXyzFP7P5Zm0/mvqEKARD/oT69RyNxNXtGwLap9fhCZGtRKl4IaXBxjKOPV
MIME-Version: 1.0
X-Received: by 2002:a6b:7010:0:b0:67c:8d8:c60a with SMTP id
 l16-20020a6b7010000000b0067c08d8c60amr5733009ioc.31.1659361768629; Mon, 01
 Aug 2022 06:49:28 -0700 (PDT)
Date:   Mon, 01 Aug 2022 06:49:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5ea3505e52e44bb@google.com>
Subject: [syzbot] KASAN: use-after-free Read in send_packet
From:   syzbot <syzbot+f1a69784f6efe748c3bf@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org, sean@mess.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8288c99fc263 usb: misc: onboard_usb_hub: Remove duplicated..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=17a54e22080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6749cc6053521b55
dashboard link: https://syzkaller.appspot.com/bug?extid=f1a69784f6efe748c3bf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f1a69784f6efe748c3bf@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __create_pipe include/linux/usb.h:1945 [inline]
BUG: KASAN: use-after-free in send_packet+0xa2d/0xbc0 drivers/media/rc/imon.c:627
Read of size 4 at addr ffff888109b6b000 by task syz-executor.2/7852

CPU: 1 PID: 7852 Comm: syz-executor.2 Not tainted 5.19.0-rc7-syzkaller-00199-g8288c99fc263 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xeb/0x495 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 __create_pipe include/linux/usb.h:1945 [inline]
 send_packet+0xa2d/0xbc0 drivers/media/rc/imon.c:627
 vfd_write+0x2d9/0x550 drivers/media/rc/imon.c:991
 vfs_write+0x269/0xac0 fs/read_write.c:589
 ksys_write+0x127/0x250 fs/read_write.c:644
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f218188a209
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2180fdf168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f218199d030 RCX: 00007f218188a209
RDX: 0000000000000001 RSI: 0000000020001000 RDI: 0000000000000004
RBP: 00007f21818e4161 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdf1861bff R14: 00007f2180fdf300 R15: 0000000000022000
 </TASK>

Allocated by task 4094:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 __kasan_kmalloc+0x81/0xa0 mm/kasan/common.c:524
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 usb_alloc_dev+0x51/0xf00 drivers/usb/core/usb.c:582
 hub_port_connect drivers/usb/core/hub.c:5255 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5653 [inline]
 hub_event+0x2055/0x4690 drivers/usb/core/hub.c:5735
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Freed by task 4215:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x10f/0x190 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1754 [inline]
 slab_free_freelist_hook mm/slub.c:1780 [inline]
 slab_free mm/slub.c:3536 [inline]
 kfree+0xc1/0x4f0 mm/slub.c:4584
 device_release+0x9f/0x240 drivers/base/core.c:2241
 kobject_cleanup lib/kobject.c:673 [inline]
 kobject_release lib/kobject.c:704 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:721
 put_device+0x1b/0x30 drivers/base/core.c:3535
 hub_port_connect drivers/usb/core/hub.c:5197 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5653 [inline]
 hub_event+0x1e83/0x4690 drivers/usb/core/hub.c:5735
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2ef/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

The buggy address belongs to the object at ffff888109b6b000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 0 bytes inside of
 2048-byte region [ffff888109b6b000, ffff888109b6b800)

The buggy address belongs to the physical page:
page:ffffea000426da00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x109b68
head:ffffea000426da00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0x200000000010200(slab|head|node=0|zone=2)
raw: 0200000000010200 0000000000000000 dead000000000001 ffff888100042000
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 3509826111, free_ts 0
 prep_new_page mm/page_alloc.c:2456 [inline]
 get_page_from_freelist+0x138c/0x27a0 mm/page_alloc.c:4198
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5426
 alloc_page_interleave+0x1e/0x1e0 mm/mempolicy.c:2105
 alloc_pages+0x2b1/0x310 mm/mempolicy.c:2267
 alloc_slab_page mm/slub.c:1824 [inline]
 allocate_slab+0x26c/0x3c0 mm/slub.c:1969
 new_slab mm/slub.c:2029 [inline]
 ___slab_alloc+0x98f/0xda0 mm/slub.c:3031
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3118
 slab_alloc_node mm/slub.c:3209 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 kmem_cache_alloc_trace+0x2fd/0x3b0 mm/slub.c:3282
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 acpi_os_allocate_zeroed include/acpi/platform/aclinuxex.h:57 [inline]
 acpi_ds_create_walk_state+0x88/0x1ff drivers/acpi/acpica/dswstate.c:518
 acpi_ps_execute_method+0x19d/0x61c drivers/acpi/acpica/psxface.c:134
 acpi_ns_evaluate+0x6c7/0x966 drivers/acpi/acpica/nseval.c:205
 acpi_ut_evaluate_object+0xf1/0x3f6 drivers/acpi/acpica/uteval.c:60
 acpi_rs_get_method_data+0x7e/0xe5 drivers/acpi/acpica/rsutils.c:650
 acpi_walk_resources drivers/acpi/acpica/rsxface.c:616 [inline]
 acpi_walk_resources+0xf3/0x1ca drivers/acpi/acpica/rsxface.c:594
 __acpi_dev_get_resources drivers/acpi/resource.c:633 [inline]
 __acpi_dev_get_resources drivers/acpi/resource.c:614 [inline]
 acpi_dev_get_resources+0x1a8/0x230 drivers/acpi/resource.c:671
 acpi_device_enumeration_by_parent drivers/acpi/scan.c:1770 [inline]
 acpi_init_device_object+0xba1/0x1a30 drivers/acpi/scan.c:1794
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888109b6af00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888109b6af80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888109b6b000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888109b6b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888109b6b100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

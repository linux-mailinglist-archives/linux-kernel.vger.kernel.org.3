Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA45D51D60B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243063AbiEFK7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346693AbiEFK7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:59:07 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80235FBD
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 03:55:22 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id d7-20020a0566022d4700b0065aa0c91f27so4734933iow.14
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 03:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7cbmlPGWXyk+fdCHlmtwhn3qaAZ2YWYXT0zy2EnbwLg=;
        b=q14Xf9nQ5FOX70+Qm/l8Xip9GqUynFzYT7K8IVzm3VdTJZkAMDtYiip3iyvotZyMYR
         uFGHHOphQzJkJK5cSdOZLd6Yd3z+NyNtuWdWZ2CS+WZZ9hgNvQodR5mZLNSAYwP96PSn
         4j4k966itdUeY5YB0AwJ23wmZfL6e9O4AapGMV4S1JFkagLVa4nvMR2I40pVWp3ekQPf
         zTNzVpdIkwprkf1PUNp4mI4GqtbtWFX0M+8ol5jiAqVn2GXqCEqY60umpsEbxp3uCiy5
         05Y0MbxztYZGm4SL3BrWo1Gp8yH8EtEO9YaVs8hSB2ZviHd3iNU/ERGakGqzPA4WrCMO
         fGyw==
X-Gm-Message-State: AOAM532BVogTCXzSZccb4eZiLIRkiuOWvGyILzXJAiBLpzYCbaxBeylo
        EpWEJIu8DN8WysljObbLXgKxkbV3ncIYCHYOtObcoCsS3qDC
X-Google-Smtp-Source: ABdhPJzGzABbWl/V7xYXRh+sG74PGl6gz6Qq/20Yn9oCLv6UzXsN8kYC2LoOrUHQ97Mn2j9YCHko7zocEJ3nHScAjY/tlveURJum
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c5:b0:2cc:450a:df7d with SMTP id
 5-20020a056e0216c500b002cc450adf7dmr1011283ilx.39.1651834521991; Fri, 06 May
 2022 03:55:21 -0700 (PDT)
Date:   Fri, 06 May 2022 03:55:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9428d05de55b1cd@google.com>
Subject: [syzbot] KASAN: use-after-free Read in hiddev_disconnect (3)
From:   syzbot <syzbot+da96c65bae6fe366459b@syzkaller.appspotmail.com>
To:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    fe27d189e3f4 Merge tag 'folio-5.18f' of git://git.infradea..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12fbe186f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=331feb185f8828e0
dashboard link: https://syzkaller.appspot.com/bug?extid=da96c65bae6fe366459b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+da96c65bae6fe366459b@syzkaller.appspotmail.com

cm6533_jd 0003:0D8C:0022.000E: hiddev3,hidraw3: USB HID v0.00 Device [HID 0d8c:0022] on usb-dummy_hcd.0-1/input32
usb 6-1: USB disconnect, device number 3
==================================================================
BUG: KASAN: use-after-free in debug_spin_lock_before kernel/locking/spinlock_debug.c:85 [inline]
BUG: KASAN: use-after-free in do_raw_spin_lock+0x261/0x2a0 kernel/locking/spinlock_debug.c:114
Read of size 4 at addr ffff888055280c1c by task kworker/1:4/3656

CPU: 1 PID: 3656 Comm: kworker/1:4 Not tainted 5.18.0-rc5-syzkaller-00115-gfe27d189e3f4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xeb/0x495 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 debug_spin_lock_before kernel/locking/spinlock_debug.c:85 [inline]
 do_raw_spin_lock+0x261/0x2a0 kernel/locking/spinlock_debug.c:114
 __mutex_unlock_slowpath+0x18e/0x5e0 kernel/locking/mutex.c:918
 hiddev_disconnect+0x154/0x1c0 drivers/hid/usbhid/hiddev.c:940
 hid_disconnect+0xb4/0x1a0 drivers/hid/hid-core.c:2248
 hid_hw_stop+0x12/0x70 drivers/hid/hid-core.c:2293
 cmhid_remove+0x38/0x50 drivers/hid/hid-cmedia.c:182
 hid_device_remove+0xbf/0x200 drivers/hid/hid-core.c:2623
 device_remove+0xc8/0x170 drivers/base/dd.c:530
 __device_release_driver drivers/base/dd.c:1200 [inline]
 device_release_driver_internal+0x4a3/0x680 drivers/base/dd.c:1223
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
 device_del+0x4f3/0xc80 drivers/base/core.c:3592
 hid_remove_device drivers/hid/hid-core.c:2792 [inline]
 hid_destroy_device+0xe1/0x150 drivers/hid/hid-core.c:2811
 usbhid_disconnect+0x9f/0xe0 drivers/hid/usbhid/hid-core.c:1451
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:532 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:524
 __device_release_driver drivers/base/dd.c:1200 [inline]
 device_release_driver_internal+0x4a3/0x680 drivers/base/dd.c:1223
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
 device_del+0x4f3/0xc80 drivers/base/core.c:3592
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x278/0x6ec drivers/usb/core/hub.c:2228
 hub_port_connect drivers/usb/core/hub.c:5207 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
 port_event drivers/usb/core/hub.c:5665 [inline]
 hub_event+0x1e74/0x4680 drivers/usb/core/hub.c:5747
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>

Allocated by task 142:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 ____kasan_kmalloc mm/kasan/common.c:474 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:524
 kmalloc include/linux/slab.h:581 [inline]
 kzalloc include/linux/slab.h:714 [inline]
 hiddev_connect+0x246/0x5c0 drivers/hid/usbhid/hiddev.c:893
 hid_connect+0x26d/0x17c0 drivers/hid/hid-core.c:2169
 hid_hw_start drivers/hid/hid-core.c:2273 [inline]
 hid_hw_start+0xa2/0x130 drivers/hid/hid-core.c:2264
 cmhid_probe+0x104/0x160 drivers/hid/hid-cmedia.c:165
 hid_device_probe+0x2bd/0x3f0 drivers/hid/hid-core.c:2594
 call_driver_probe drivers/base/dd.c:542 [inline]
 really_probe+0x23e/0xb20 drivers/base/dd.c:621
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:752
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:782
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:899
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:970
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xb83/0x1e20 drivers/base/core.c:3405
 hid_add_device+0x344/0x9d0 drivers/hid/hid-core.c:2744
 usbhid_probe+0xb49/0x1040 drivers/hid/usbhid/hid-core.c:1424
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:542 [inline]
 really_probe+0x23e/0xb20 drivers/base/dd.c:621
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:752
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:782
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:899
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:970
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xb83/0x1e20 drivers/base/core.c:3405
 usb_set_configuration+0x101e/0x1900 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:542 [inline]
 really_probe+0x23e/0xb20 drivers/base/dd.c:621
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:752
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:782
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:899
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:970
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xb83/0x1e20 drivers/base/core.c:3405
 usb_new_device.cold+0x641/0x1091 drivers/usb/core/hub.c:2566
 hub_port_connect drivers/usb/core/hub.c:5363 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
 port_event drivers/usb/core/hub.c:5665 [inline]
 hub_event+0x25c6/0x4680 drivers/usb/core/hub.c:5747
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298

Freed by task 4229:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x166/0x1a0 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1728 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1754
 slab_free mm/slub.c:3510 [inline]
 kfree+0xd6/0x4d0 mm/slub.c:4552
 hiddev_release+0x402/0x520 drivers/hid/usbhid/hiddev.c:232
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:294
 __do_fast_syscall_32+0x72/0xf0 arch/x86/entry/common.c:181
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

The buggy address belongs to the object at ffff888055280c00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 28 bytes inside of
 512-byte region [ffff888055280c00, ffff888055280e00)

The buggy address belongs to the physical page:
page:ffffea000154a000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x55280
head:ffffea000154a000 order:2 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000001 ffff888010c41c80
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd2a20(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3627, tgid 3627 (syz-executor.4), ts 55925604934, free_ts 11711857198
 prep_new_page mm/page_alloc.c:2441 [inline]
 get_page_from_freelist+0xba2/0x3e00 mm/page_alloc.c:4182
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5408
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2272
 alloc_slab_page mm/slub.c:1799 [inline]
 allocate_slab+0x26c/0x3c0 mm/slub.c:1944
 new_slab mm/slub.c:2004 [inline]
 ___slab_alloc+0x8df/0xf20 mm/slub.c:3005
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3092
 slab_alloc_node mm/slub.c:3183 [inline]
 __kmalloc_node_track_caller+0x2cb/0x360 mm/slub.c:4947
 kmalloc_reserve net/core/skbuff.c:354 [inline]
 __alloc_skb+0xde/0x340 net/core/skbuff.c:426
 alloc_skb include/linux/skbuff.h:1300 [inline]
 nlmsg_new include/net/netlink.h:953 [inline]
 fdb_notify+0x98/0x190 net/bridge/br_fdb.c:191
 fdb_add_local+0x18b/0x1c0 net/bridge/br_fdb.c:434
 br_fdb_change_mac_address+0x34f/0x5e0 net/bridge/br_fdb.c:509
 br_stp_change_bridge_id+0xb2/0x3a0 net/bridge/br_stp_if.c:232
 br_set_mac_address+0x23f/0x2c0 net/bridge/br_device.c:245
 dev_set_mac_address+0x267/0x3d0 net/core/dev.c:8690
 dev_set_mac_address_user+0x2d/0x50 net/core/dev.c:8708
 do_setlink+0x184a/0x3a20 net/core/rtnetlink.c:2686
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1356 [inline]
 free_pcp_prepare+0x549/0xd20 mm/page_alloc.c:1406
 free_unref_page_prepare mm/page_alloc.c:3328 [inline]
 free_unref_page+0x19/0x6a0 mm/page_alloc.c:3423
 free_contig_range+0xb1/0x180 mm/page_alloc.c:9418
 destroy_args+0xa8/0x646 mm/debug_vm_pgtable.c:1018
 debug_vm_pgtable+0x2a51/0x2ae3 mm/debug_vm_pgtable.c:1332
 do_one_initcall+0x103/0x650 init/main.c:1298
 do_initcall_level init/main.c:1371 [inline]
 do_initcalls init/main.c:1387 [inline]
 do_basic_setup init/main.c:1406 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1613
 kernel_init+0x1a/0x1d0 init/main.c:1502
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298

Memory state around the buggy address:
 ffff888055280b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888055280b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888055280c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888055280c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888055280d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

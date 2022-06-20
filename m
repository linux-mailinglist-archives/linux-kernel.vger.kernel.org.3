Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09981551220
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239189AbiFTIFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238806AbiFTIFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:05:23 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E05FF71
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:05:21 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id i126-20020a6bb884000000b006691e030971so5724019iof.15
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xXm/i0Hgu90Aiz8MoipdXfmZ4Q0U6IUkU2hkNIxbw4Y=;
        b=1NtUC/GLkSY2LdwdQrXj3HNYwPJbpHXJgXcaBJPsfIKZjNF6w8RffIlGUydn6qWym+
         +xWluDc5ycsrsVA5UQw09/HDtkSWd64QDYIjUMCmrRwb5bVupzRWpspfOUeqOmIx2pyT
         m6jJ1w/KBJoFChMgSp9DdHLQuxj313t7/bcaRiinmqIOD7r9heRT3k/Fr5OOfPWGKb5F
         Pbgs4Wb4616wh/vwlTvA8S0CPzVNEi53gAM8vm17BjONyWeEyIEOUlnH2giLagDxkUEH
         yU6NrInWkrmsKuZvX/UGPy7bG2KEdvU/p4mK7lAU+7NGyJ9OevFZqkXmvLMVrlpDTpK1
         kI1Q==
X-Gm-Message-State: AJIora/t3DrAjEjymPdcr2VD6L3Sm8xtFIW7zQqcLUOjHbILsAWu2TTH
        xvCNr/r7FrPR+M18kaMrHV/ZW6Dk25KxpW7994xfpj99AM65
X-Google-Smtp-Source: AGRyM1sloVhCd7A6+FKLlIOePimeaON3AS85DZMEN60QRXlhNtLnu14DNsEkwdQUS61A1PGUc03Ai4oLAdu3qxvKrnuklZOsyaq4
MIME-Version: 1.0
X-Received: by 2002:a92:c54d:0:b0:2d3:dfea:c0e1 with SMTP id
 a13-20020a92c54d000000b002d3dfeac0e1mr11906037ilj.177.1655712320822; Mon, 20
 Jun 2022 01:05:20 -0700 (PDT)
Date:   Mon, 20 Jun 2022 01:05:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bba49205e1dc90a8@google.com>
Subject: [syzbot] KASAN: use-after-free Read in powermate_config_complete (3)
From:   syzbot <syzbot+b131c4a0d4802c9e13a4@syzkaller.appspotmail.com>
To:     dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        mailhol.vincent@wanadoo.fr, syzkaller-bugs@googlegroups.com
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

HEAD commit:    6012273897fe Add linux-next specific files for 20220615
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1085e108080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b4154677977b1776
dashboard link: https://syzkaller.appspot.com/bug?extid=b131c4a0d4802c9e13a4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b131c4a0d4802c9e13a4@syzkaller.appspotmail.com

powermate: config urb returned -71
powermate: config urb returned -108
powermate: config urb returned -108
==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3ab9/0x5660 kernel/locking/lockdep.c:4923
Read of size 8 at addr ffff88807e821258 by task udevd/2975

CPU: 0 PID: 2975 Comm: udevd Not tainted 5.19.0-rc2-next-20220615-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xeb/0x495 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 __lock_acquire+0x3ab9/0x5660 kernel/locking/lockdep.c:4923
 lock_acquire kernel/locking/lockdep.c:5665 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 powermate_config_complete+0x79/0xb0 drivers/input/misc/powermate.c:202
 __usb_hcd_giveback_urb+0x2b0/0x5c0 drivers/usb/core/hcd.c:1670
 usb_hcd_giveback_urb+0x367/0x410 drivers/usb/core/hcd.c:1747
 dummy_timer+0x11f9/0x32b0 drivers/usb/gadget/udc/dummy_hcd.c:1988
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1474
 expire_timers kernel/time/timer.c:1519 [inline]
 __run_timers.part.0+0x679/0xa80 kernel/time/timer.c:1790
 __run_timers kernel/time/timer.c:1768 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1803
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:571
 invoke_softirq kernel/softirq.c:445 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1106
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1b/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:list_empty_careful include/linux/list.h:329 [inline]
RIP: 0010:ep_poll fs/eventpoll.c:1867 [inline]
RIP: 0010:do_epoll_wait+0x10ad/0x1930 fs/eventpoll.c:2234
Code: 0f 84 22 02 00 00 e8 f2 19 90 ff 48 8b 74 24 28 48 8b 5c 24 08 48 89 df e8 50 d2 ff ff 48 89 df e8 88 35 92 07 e9 25 02 00 00 <e8> ce 19 90 ff 48 8b 84 24 60 01 00 00 48 39 e8 0f 85 47 fc ff ff
RSP: 0018:ffffc90002d5fc88 EFLAGS: 00000246
RAX: ffffc90002d5fde0 RBX: ffff88807c850000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81eaa567 RDI: ffff88807c850018
RBP: ffffc90002d5fde0 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffffc R11: 0000000000000001 R12: ffff88807d557d40
R13: ffff88807d557cd0 R14: ffff88807d557cd0 R15: dffffc0000000000
 __do_sys_epoll_wait fs/eventpoll.c:2246 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2241 [inline]
 __x64_sys_epoll_wait+0x158/0x270 fs/eventpoll.c:2241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f3f62f33e46
Code: 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 e8 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 90 48 83 ec 28 89 54 24 18 48 89 74 24
RSP: 002b:00007ffd5b9f9ee8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 00007ffd5b9f9fe8 RCX: 00007f3f62f33e46
RDX: 0000000000000008 RSI: 00007ffd5b9f9fe8 RDI: 000000000000000b
RBP: 00007ffd5b9f9fb0 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000000bb8 R11: 0000000000000246 R12: 0000000000000bb8
R13: 0000561a491ae800 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 6:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 ____kasan_kmalloc mm/kasan/common.c:474 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:524
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 powermate_probe+0x24a/0x12a0 drivers/input/misc/powermate.c:323
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:530 [inline]
 really_probe+0x24e/0xbb0 drivers/base/dd.c:609
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:748
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:778
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:901
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x1e4/0x530 drivers/base/dd.c:973
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xbda/0x1ea0 drivers/base/core.c:3505
 usb_set_configuration+0x101e/0x1900 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:530 [inline]
 really_probe+0x24e/0xbb0 drivers/base/dd.c:609
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:748
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:778
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:901
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x1e4/0x530 drivers/base/dd.c:973
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xbda/0x1ea0 drivers/base/core.c:3505
 usb_new_device.cold+0x641/0x1091 drivers/usb/core/hub.c:2566
 hub_port_connect drivers/usb/core/hub.c:5346 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5490 [inline]
 port_event drivers/usb/core/hub.c:5646 [inline]
 hub_event+0x25d5/0x4690 drivers/usb/core/hub.c:5728
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302

Freed by task 3684:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x166/0x1a0 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1754 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1780
 slab_free mm/slub.c:3536 [inline]
 kfree+0xd6/0x4d0 mm/slub.c:4584
 powermate_disconnect+0x1ce/0x250 drivers/input/misc/powermate.c:432
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:520 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:512
 __device_release_driver drivers/base/dd.c:1206 [inline]
 device_release_driver_internal+0x4a1/0x700 drivers/base/dd.c:1232
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
 device_del+0x4f3/0xc80 drivers/base/core.c:3692
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x278/0x6ec drivers/usb/core/hub.c:2228
 hub_port_connect drivers/usb/core/hub.c:5190 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5490 [inline]
 port_event drivers/usb/core/hub.c:5646 [inline]
 hub_event+0x1e83/0x4690 drivers/usb/core/hub.c:5728
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302

Last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
 kvfree_call_rcu+0x74/0x940 kernel/rcu/tree.c:3322
 drop_sysctl_table+0x3c0/0x4e0 fs/proc/proc_sysctl.c:1716
 unregister_sysctl_table fs/proc/proc_sysctl.c:1754 [inline]
 unregister_sysctl_table+0xc0/0x190 fs/proc/proc_sysctl.c:1729
 __addrconf_sysctl_unregister net/ipv6/addrconf.c:7108 [inline]
 addrconf_sysctl_unregister+0xee/0x1c0 net/ipv6/addrconf.c:7136
 addrconf_ifdown.isra.0+0x128c/0x1830 net/ipv6/addrconf.c:3903
 addrconf_notify+0xeb/0x1ba0 net/ipv6/addrconf.c:3673
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1943
 call_netdevice_notifiers_extack net/core/dev.c:1981 [inline]
 call_netdevice_notifiers net/core/dev.c:1995 [inline]
 unregister_netdevice_many+0x92e/0x1890 net/core/dev.c:10852
 sit_exit_batch_net+0x530/0x750 net/ipv6/sit.c:1944
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:168
 cleanup_net+0x4ea/0xb00 net/core/net_namespace.c:595
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302

Second to last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
 kvfree_call_rcu+0x74/0x940 kernel/rcu/tree.c:3322
 drop_sysctl_table+0x3c0/0x4e0 fs/proc/proc_sysctl.c:1716
 unregister_sysctl_table fs/proc/proc_sysctl.c:1754 [inline]
 unregister_sysctl_table+0xc0/0x190 fs/proc/proc_sysctl.c:1729
 __addrconf_sysctl_unregister net/ipv6/addrconf.c:7108 [inline]
 addrconf_exit_net+0x172/0x3f0 net/ipv6/addrconf.c:7230
 ops_exit_list+0xb0/0x170 net/core/net_namespace.c:163
 cleanup_net+0x4ea/0xb00 net/core/net_namespace.c:595
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302

The buggy address belongs to the object at ffff88807e821200
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 88 bytes inside of
 256-byte region [ffff88807e821200, ffff88807e821300)

The buggy address belongs to the physical page:
page:ffffea0001fa0800 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7e820
head:ffffea0001fa0800 order:1 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea0001e4ee80 dead000000000006 ffff888011841b40
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 47, tgid 47 (kworker/u4:3), ts 157338031839, free_ts 157327323829
 prep_new_page mm/page_alloc.c:2525 [inline]
 get_page_from_freelist+0x1efe/0x3a20 mm/page_alloc.c:4296
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5512
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
 alloc_slab_page mm/slub.c:1824 [inline]
 allocate_slab+0x26c/0x3c0 mm/slub.c:1969
 new_slab mm/slub.c:2029 [inline]
 ___slab_alloc+0x9c4/0xe20 mm/slub.c:3031
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3118
 slab_alloc_node mm/slub.c:3209 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 __kmalloc+0x318/0x350 mm/slub.c:4442
 kmalloc include/linux/slab.h:605 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 ieee80211_ibss_build_presp+0x138/0x1760 net/mac80211/ibss.c:70
 __ieee80211_sta_join_ibss+0x681/0x1810 net/mac80211/ibss.c:317
 ieee80211_sta_create_ibss.cold+0xcf/0x117 net/mac80211/ibss.c:1347
 ieee80211_sta_find_ibss net/mac80211/ibss.c:1477 [inline]
 ieee80211_ibss_work.cold+0x30e/0x60f net/mac80211/ibss.c:1706
 ieee80211_iface_work+0xb83/0xd10 net/mac80211/iface.c:1601
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1443 [inline]
 free_pcp_prepare+0x549/0xd20 mm/page_alloc.c:1493
 free_unref_page_prepare mm/page_alloc.c:3373 [inline]
 free_unref_page+0x19/0x560 mm/page_alloc.c:3470
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:446
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 slab_alloc_node mm/slub.c:3243 [inline]
 kmem_cache_alloc_node+0x255/0x3f0 mm/slub.c:3293
 alloc_task_struct_node kernel/fork.c:171 [inline]
 dup_task_struct kernel/fork.c:963 [inline]
 copy_process+0x5c4/0x7080 kernel/fork.c:2065
 kernel_clone+0xe7/0xab0 kernel/fork.c:2649
 __do_sys_clone+0xba/0x100 kernel/fork.c:2783
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Memory state around the buggy address:
 ffff88807e821100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807e821180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807e821200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff88807e821280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807e821300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
----------------
Code disassembly (best guess):
   0:	0f 84 22 02 00 00    	je     0x228
   6:	e8 f2 19 90 ff       	callq  0xff9019fd
   b:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
  10:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
  15:	48 89 df             	mov    %rbx,%rdi
  18:	e8 50 d2 ff ff       	callq  0xffffd26d
  1d:	48 89 df             	mov    %rbx,%rdi
  20:	e8 88 35 92 07       	callq  0x79235ad
  25:	e9 25 02 00 00       	jmpq   0x24f
* 2a:	e8 ce 19 90 ff       	callq  0xff9019fd <-- trapping instruction
  2f:	48 8b 84 24 60 01 00 	mov    0x160(%rsp),%rax
  36:	00
  37:	48 39 e8             	cmp    %rbp,%rax
  3a:	0f 85 47 fc ff ff    	jne    0xfffffc87


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

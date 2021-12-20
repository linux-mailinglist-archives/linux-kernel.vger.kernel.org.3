Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E0547A54A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 08:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbhLTHLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 02:11:24 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:49068 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbhLTHLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 02:11:23 -0500
Received: by mail-il1-f198.google.com with SMTP id k9-20020a056e02156900b002a1acf9a52dso4637132ilu.15
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 23:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/6NucGbET7DWQVLyFlBZ14TEu6bzuWH5N1DeKLfSkK8=;
        b=MBkw0HCMDdCk/0KomyO7F0jONpYBGdGVyZnNuwMEsVVw1njAyR5ZstTsrU1fsyvuqb
         5LYHNRIZUSiE2gv72OL2/M0RpgcP6pjE3f04iAE1uoF+mOMEn5fCKJpbvynCThWfhwGm
         mYsfST8bJH6Auht6gT/TyWLWuyTytKrj+2bsTN8UxtMo2HiijtZrgZk5IgpxKUbtRkzO
         MC/lPhAvbdBTINwwj8qszyTresRWWPLwMHcpgc0IPSNIGkviFCK3lf/AeDyl6618KWdL
         URwZ19jX/xBAXhYvRVdXwNqZMam6cAsPB95euCWkkjmrDig1TAE5uEueny94jWhQg6B/
         U9bQ==
X-Gm-Message-State: AOAM53309GYmTGeC2GlBH0w+WZPCghvndLUO2bYIcqLq1Dc96ZfvKx7d
        2tTGgGo5PXysMaaz4bjlQh4Xl97E4aOV6gmFHMOXfDO28ifO
X-Google-Smtp-Source: ABdhPJzC4UqcPQyPIHxT3SMR+sDEcmjspXgLyrzI3zYm5Wu7/Ao4SJiCk+eurgSMN7jnU0g0qvKD/nLlJe158wAprYkVOqENZoeT
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bac:: with SMTP id n12mr672273ili.278.1639984283015;
 Sun, 19 Dec 2021 23:11:23 -0800 (PST)
Date:   Sun, 19 Dec 2021 23:11:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a05fb005d38e986a@google.com>
Subject: [syzbot] linux-next boot error: KASAN: slab-out-of-bounds Read in cpumask_next
From:   syzbot <syzbot+4a4585cf058180034fc8@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c122052c3cb8 Add linux-next specific files for 20211217
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15ce6b6db00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b39204a5cede9652
dashboard link: https://syzkaller.appspot.com/bug?extid=4a4585cf058180034fc8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4a4585cf058180034fc8@syzkaller.appspotmail.com

usbcore: registered new interface driver smscufx
uvesafb: failed to execute /sbin/v86d
uvesafb: make sure that the v86d helper is installed and executable
uvesafb: Getting VBE info block failed (eax=0x4f00, err=-2)
uvesafb: vbe_init() failed with -22
uvesafb: probe of uvesafb.0 failed with error -22
vga16fb: mapped to 0xffff8880000a0000
Console: switching to colour frame buffer device 80x30
fb0: VGA16 VGA frame buffer device
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: button: Power Button [PWRF]
input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
ACPI: button: Sleep Button [SLPF]
ACPI: \_SB_.LNKC: Enabled at IRQ 11
virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
ACPI: \_SB_.LNKD: Enabled at IRQ 10
virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
ACPI: \_SB_.LNKB: Enabled at IRQ 10
virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driver
virtio-pci 0000:00:07.0: virtio_pci: leaving for legacy driver
N_HDLC line discipline registered with maxframe=4096
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
ACPI: bus type drm_connector registered
[drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
[drm] Initialized vkms 1.0.0 20180514 for vkms on minor 1
platform vkms: [drm] fb1: vkmsdrmfb frame buffer device
usbcore: registered new interface driver udl
brd: module loaded
loop: module loaded
zram: Added device: zram0
null_blk: module loaded
Guest personality initialized and is inactive
VMCI host device registered (name=vmci, major=10, minor=120)
Initialized host personality
usbcore: registered new interface driver rtsx_usb
usbcore: registered new interface driver viperboard
usbcore: registered new interface driver dln2
usbcore: registered new interface driver pn533_usb
nfcsim 0.2 initialized
usbcore: registered new interface driver port100
usbcore: registered new interface driver nfcmrvl
Loading iSCSI transport class v2.0-870.
scsi host0: Virtio SCSI HBA
==================================================================
BUG: KASAN: slab-out-of-bounds in find_next_bit include/linux/find.h:40 [inline]
BUG: KASAN: slab-out-of-bounds in cpumask_next+0xe8/0xf0 lib/cpumask.c:22
Read of size 8 at addr ffff88801a4bcaf0 by task swapper/0/1

CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0-rc5-next-20211217-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xa5/0x3ed mm/kasan/report.c:255
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 find_next_bit include/linux/find.h:40 [inline]
 cpumask_next+0xe8/0xf0 lib/cpumask.c:22
 blk_mq_virtio_map_queues+0x1a8/0x320 block/blk-mq-virtio.c:38
 scsi_map_queues+0x65/0xa0 drivers/scsi/scsi_lib.c:1870
 blk_mq_update_queue_map+0x3e3/0x4f0 block/blk-mq.c:4191
 blk_mq_alloc_tag_set+0x69d/0x12b0 block/blk-mq.c:4293
 scsi_add_host_with_dma.cold+0xe8/0x679 drivers/scsi/hosts.c:232
 scsi_add_host include/scsi/scsi_host.h:768 [inline]
 virtscsi_probe+0x826/0xce0 drivers/scsi/virtio_scsi.c:906
 virtio_dev_probe+0x44e/0x760 drivers/virtio/virtio.c:279
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x245/0xcc0 drivers/base/dd.c:596
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:751
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:781
 __driver_attach+0x22d/0x4e0 drivers/base/dd.c:1140
 bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:301
 bus_add_driver+0x41d/0x630 drivers/base/bus.c:618
 driver_register+0x220/0x3a0 drivers/base/driver.c:171
 is_blacklisted_cpu arch/x86/crypto/twofish_glue_3way.c:110 [inline]
 init+0xa0/0xf4 arch/x86/crypto/twofish_glue_3way.c:145
 do_one_initcall+0x103/0x650 init/main.c:1303
 do_initcall_level init/main.c:1378 [inline]
 do_initcalls init/main.c:1394 [inline]
 do_basic_setup init/main.c:1413 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1618
 kernel_init+0x1a/0x1d0 init/main.c:1507
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>

Allocated by task 0:
(stack is not available)

The buggy address belongs to the object at ffff88801a4bcae0
 which belongs to the cache kmalloc-16 of size 16
The buggy address is located 0 bytes to the right of
 16-byte region [ffff88801a4bcae0, ffff88801a4bcaf0)
The buggy address belongs to the page:
page:ffffea0000692f00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1a4bc
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 0000000000000000 dead000000000122 ffff888010c413c0
raw: 0000000000000000 0000000080800080 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12c00(GFP_NOIO|__GFP_NOWARN|__GFP_NORETRY), pid 8, ts 7922165789, free_ts 7921009973
 prep_new_page mm/page_alloc.c:2433 [inline]
 get_page_from_freelist+0xa72/0x2f40 mm/page_alloc.c:4164
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5376
 __alloc_pages_node include/linux/gfp.h:568 [inline]
 alloc_slab_page mm/slub.c:1801 [inline]
 allocate_slab mm/slub.c:1944 [inline]
 new_slab+0xaf/0x3a0 mm/slub.c:2004
 ___slab_alloc+0x6be/0xd60 mm/slub.c:3019
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3106
 slab_alloc_node mm/slub.c:3197 [inline]
 __kmalloc_node+0x2cb/0x380 mm/slub.c:4467
 kmalloc_array_node include/linux/slab.h:677 [inline]
 kcalloc_node include/linux/slab.h:682 [inline]
 blk_mq_alloc_rq_map+0xc3/0x200 block/blk-mq.c:3149
 blk_mq_alloc_map_and_rqs block/blk-mq.c:3588 [inline]
 __blk_mq_alloc_map_and_rqs block/blk-mq.c:3610 [inline]
 __blk_mq_alloc_map_and_rqs block/blk-mq.c:3601 [inline]
 __blk_mq_alloc_rq_maps block/blk-mq.c:4107 [inline]
 blk_mq_alloc_set_map_and_rqs block/blk-mq.c:4138 [inline]
 blk_mq_alloc_tag_set+0x8cc/0x12b0 block/blk-mq.c:4297
 do_floppy_init drivers/block/floppy.c:4576 [inline]
 floppy_async_init+0x2c8/0x2055 drivers/block/floppy.c:4750
 async_run_entry_fn+0x9d/0x550 kernel/async.c:127
 process_one_work+0x9ac/0x1680 kernel/workqueue.c:2307
 worker_thread+0x652/0x11c0 kernel/workqueue.c:2454
 kthread+0x405/0x4f0 kernel/kthread.c:345
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1351 [inline]
 free_pcp_prepare+0x414/0xb60 mm/page_alloc.c:1403
 free_unref_page_prepare mm/page_alloc.c:3324 [inline]
 free_unref_page_list+0x1a9/0xfa0 mm/page_alloc.c:3440
 release_pages+0x818/0x18e0 mm/swap.c:980
 tlb_batch_pages_flush mm/mmu_gather.c:50 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:243 [inline]
 tlb_flush_mmu mm/mmu_gather.c:250 [inline]
 tlb_finish_mmu+0x165/0x8c0 mm/mmu_gather.c:341
 exit_mmap+0x21b/0x670 mm/mmap.c:3181
 __mmput+0x122/0x4b0 kernel/fork.c:1116
 mmput+0x56/0x60 kernel/fork.c:1137
 free_bprm+0x65/0x2e0 fs/exec.c:1483
 kernel_execve+0x380/0x460 fs/exec.c:1980
 call_usermodehelper_exec_async+0x2e3/0x580 kernel/umh.c:112
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Memory state around the buggy address:
 ffff88801a4bc980: fa fb fc fc fa fb fc fc 00 00 fc fc 00 00 fc fc
 ffff88801a4bca00: 00 00 fc fc 00 00 fc fc fa fb fc fc 00 00 fc fc
>ffff88801a4bca80: 00 00 fc fc 00 00 fc fc 00 00 fc fc fc fc fc fc
                                                             ^
 ffff88801a4bcb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801a4bcb80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

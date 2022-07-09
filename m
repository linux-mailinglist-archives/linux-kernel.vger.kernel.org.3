Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731D256C959
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 14:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiGIMLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 08:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIMLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 08:11:08 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D35D3B97A
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 05:11:07 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id w1so1372678qtv.9
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 05:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6y+gf5qlxQAaiM8b3uWJIfmIrsnZxYXc/XCTsQKVRj4=;
        b=ZvVojauf19KhzPhUuctojGidWLuDwlOOrMFbPdJqlCDhFFxb2yx6SyY0lWOCqsK3bS
         ZIviqkeyjJODwEffQmrB8TC6dLZqLAzo61C6T+h0NDArZn3xHLQurzGql3pXcy8TlqL2
         27SX8UB7fuPGOl9sv1QcaQviseB6cji9ZgQmJ0kq3I2Cxax//bZ7D2fuOk285n4nLr6S
         jg8D1LuhSAttz8oJmVJ04X6a8DreWWISafg6YV32ckPlNowYPiIA4TTg5UKDZDhDmaFz
         F4Eyt1dNkX7+IkcaHzOWkq5bFcW7w5/iOWA7iXxThjkWrCNrrq46cvmk2+T9fdwMbunc
         ls9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6y+gf5qlxQAaiM8b3uWJIfmIrsnZxYXc/XCTsQKVRj4=;
        b=fBvjFO4XhfMjvJkwcYufyoNTIRBmc3K5A88+/z0KQo1i4bz2AYTlrrDya0DWNbDHj6
         8zTBxDC8fbqKARZ9Hed0Bk0QblUYEUepb5yck/UJkvFMxNOETliUWirQX0ot4qh6yxGz
         yTmaWd6JqVdYzClNZ2sYjKY4uMUY9FUW3dnPL3Mq0mMCd5237IGVSMyUEaIMBQQlD2Lf
         fZs2PlkqTGKU12OsSae624CCpiZRN3UAe5SUGiKtlMBldz6oVZYo7bfA2ntvJN9P7r6G
         xBOeF3IPw9ROIiwhIqQ235LwIRFuOKJHUhArCNXt5Z0GBvAd02ZBj5H85BpxhNIcoVa/
         k6Dw==
X-Gm-Message-State: AJIora/la7HE4+0+zKcQL80GmqosHfB8UOEQQlXl8ADEzcyIi45iyA+J
        aL5PH27E/xkbZSDNgakKZfU411gA32zdGUf7yJc=
X-Google-Smtp-Source: AGRyM1u47jmjtouPYZhldTvkDx/fdwwZsK+Xhk97JVxvEXkodogAoEJOv7nc+NRn8fpA5s3D3vinVczNI9dMmdu1ZNA=
X-Received: by 2002:a05:622a:190d:b0:31d:2ac7:9dc2 with SMTP id
 w13-20020a05622a190d00b0031d2ac79dc2mr7146672qtc.233.1657368665951; Sat, 09
 Jul 2022 05:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsP920dX-gFOHjk0Xo-yTaQfoFwP7YT2VsG1=b9X6kYhHg@mail.gmail.com>
 <CABXGCsOywmEoKC1Gt4JMSAH5C=E9Rvjj+X+X8FY7QeBV-13YWQ@mail.gmail.com> <8876a42f-aef0-8322-b95d-704ac6476333@gmail.com>
In-Reply-To: <8876a42f-aef0-8322-b95d-704ac6476333@gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sat, 9 Jul 2022 17:10:55 +0500
Message-ID: <CABXGCsNrnYZO6NfF624j0xrBkdF9vjZhcyF8iZrEr4eGcjpSCA@mail.gmail.com>
Subject: Re: [Bug][5.19-rc0] Between commits fdaf9a5840ac and babf0bb978e3 GPU
 stopped entering in graphic mode.
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 7, 2022 at 2:50 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 07.07.22 um 02:20 schrieb Mikhail Gavrilov:
> > On Tue, Jun 28, 2022 at 2:21 PM Mikhail Gavrilov
> > <mikhail.v.gavrilov@gmail.com> wrote:
> > Christian can you look why
> > drm_aperture_remove_conflicting_pci_framebuffers cause this kernel bug
> > on my machine?
>
> That looks like a problem outside of the amdgpu driver.
>
> What happens is that during load amdgpu requests whatever driver
> (vesafb,vgafb or efifb) is currently handling the framebuffer to unload.
> This unload in turn now crashes for some reason.
>
> My best suggestion is to try to bisect this.

Hi Christian,
if you read my initial post. You should see that I tried to bisect the issu=
e.
But it is very problematic because on each step I see different symptomes.
And if mark different symptoms with skip step we got at end lot of
possible commits:
Here is my bisect from initial post: https://pastebin.com/AhLMNfyv

If you want that I ended bisection successfully please help how to fix
this oops:
[    8.291177] page:00000000af2b6334 refcount:0 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x102a000
[    8.291202] head:00000000af2b6334 order:0 compound_mapcount:-1226
compound_pincount:0
[    8.291221] flags: 0x17ffffc0010000(head|node=3D0|zone=3D2|lastcpupid=3D=
0x1fffff)
[    8.291239] raw: 0017ffffc0010000 fffffb35c0a80008 fffffb35c0a80008
0000000000000000
[    8.291257] raw: 0000000000000000 0000000000000000 00000000ffffffff
0000000000000000
[    8.291275] page dumped because: VM_BUG_ON_PAGE(compound &&
compound_order(page) !=3D order)
[    8.291298] ------------[ cut here ]------------
[    8.291309] kernel BUG at mm/page_alloc.c:1329!
[    8.291324] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[    8.291328] CPU: 8 PID: 599 Comm: systemd-udevd Not tainted
5.18.0-rc2-003-790b45f1bc6736a8dd48ba5731b6871e0217311e+ #361
[    8.291333] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 4403 04/27/2022
[    8.291338] RIP: 0010:free_pcp_prepare+0x58d/0x5a0
[    8.291343] Code: c6 18 a2 85 a7 e8 d3 b7 fc ff 0f 0b 31 f6 48 89
df e8 97 cf 06 00 e9 29 ff ff ff 48 c7 c6 00 f1 85 a7 48 89 df e8 b3
b7 fc ff <0f> 0b 48 c7 c6 58 92 85 a7 e8 a5 b7 fc ff 0f 0b 0f 1f 00 0f
1f 44
[    8.291351] RSP: 0018:ffffb07c023ab9d8 EFLAGS: 00010296
[    8.291354] RAX: 000000000000004e RBX: fffffb35c0a80000 RCX: 00000000000=
00000
[    8.291358] RDX: 0000000000000001 RSI: ffffffffa789dbaf RDI: 00000000fff=
fffff
[    8.291361] RBP: 0000000000000009 R08: 0000000000000000 R09: ffffb07c023=
ab7c0
[    8.291365] R10: 0000000000000003 R11: ffff92ee2e2fffe8 R12: 00000000000=
00000
[    8.291368] R13: ffff92ee2a55d180 R14: 00000000fffffe00 R15: fffffb35c0a=
80000
[    8.291371] FS:  00007f80aa398680(0000) GS:ffff92edda200000(0000)
knlGS:0000000000000000
[    8.291376] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.291379] CR2: 00007f80aa38e616 CR3: 000000017d726000 CR4: 00000000003=
50ee0
[    8.291382] Call Trace:
[    8.291384]  <TASK>
[    8.291386]  ? find_held_lock+0x32/0x80
[    8.291391]  free_unref_page+0x25/0x2a0
[    8.291395]  __vunmap+0x261/0x3d0
[    8.291399]  drm_fbdev_cleanup+0x6b/0xc0
[    8.291403]  drm_fbdev_fb_destroy+0x15/0x30
[    8.291407]  unregister_framebuffer+0x2e/0x40
[    8.291411]  drm_client_dev_unregister+0x6e/0xe0
[    8.291416]  drm_dev_unregister+0x34/0x90
[    8.291419]  drm_dev_unplug+0x24/0x40
[    8.291422]  simpledrm_remove+0x11/0x20
[    8.291426]  platform_remove+0x1f/0x40
[    8.291429]  device_release_driver_internal+0x1b8/0x220
[    8.291433]  bus_remove_device+0xef/0x160
[    8.291437]  device_del+0x18c/0x3f0
[    8.291440]  platform_device_del.part.0+0x13/0x70
[    8.291444]  platform_device_unregister+0x1c/0x30
[    8.291447]  drm_aperture_detach_drivers+0xa3/0xd0
[    8.291452]  drm_aperture_remove_conflicting_pci_framebuffers+0x3f/0x70
[    8.291457]  amdgpu_pci_probe+0x126/0x3c0 [amdgpu]
[    8.291599]  local_pci_probe+0x41/0x80
[    8.291604]  pci_device_probe+0xaa/0x200
[    8.291607]  really_probe+0x1a0/0x370
[    8.291611]  __driver_probe_device+0xfb/0x170
[    8.291615]  driver_probe_device+0x1f/0x90
[    8.291618]  __driver_attach+0xbe/0x1a0
[    8.291622]  ? __device_attach_driver+0xe0/0xe0
[    8.291625]  bus_for_each_dev+0x65/0x90
[    8.291629]  bus_add_driver+0x150/0x1f0
[    8.291632]  driver_register+0x89/0xd0
[    8.291636]  ? 0xffffffffc067b000
[    8.291641]  do_one_initcall+0x69/0x350
[    8.291645]  ? do_init_module+0x22/0x260
[    8.291650]  ? rcu_read_lock_sched_held+0x3b/0x70
[    8.291654]  ? trace_kmalloc+0x3b/0x100
[    8.291658]  ? kmem_cache_alloc_trace+0x1eb/0x3a0
[    8.291662]  do_init_module+0x4a/0x260
[    8.291666]  __do_sys_finit_module+0x93/0xf0
[    8.291673]  do_syscall_64+0x3a/0x80
[    8.291677]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[    8.291681] RIP: 0033:0x7f80aaf4507d
[    8.291685] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e
fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 dd 0c 00 f7 d8 64 89
01 48
[    8.291694] RSP: 002b:00007ffe43973ce8 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[    8.291699] RAX: ffffffffffffffda RBX: 000055ce603a3fe0 RCX: 00007f80aaf=
4507d
[    8.291702] RDX: 0000000000000000 RSI: 000055ce60395ac0 RDI: 00000000000=
00011
[    8.291706] RBP: 000055ce60395ac0 R08: 0000000000000000 R09: 00007f80ab0=
13c80
[    8.291709] R10: 0000000000000011 R11: 0000000000000246 R12: 00000000000=
20000
[    8.291713] R13: 000055ce60387c30 R14: 0000000000000000 R15: 000055ce603=
8ede0
[    8.291718]  </TASK>
[    8.291719] Modules linked in: amdgpu(+) drm_ttm_helper ttm
crct10dif_pclmul crc32_pclmul iommu_v2 crc32c_intel gpu_sched ucsi_ccg
typec_ucsi nvme drm_buddy igb ccp ghash_clmulni_intel typec
drm_dp_helper sp5100_tco nvme_core dca wmi ip6_tables ip_tables
ipmi_devintf ipmi_msghandler fuse
[    8.291740] ---[ end trace 0000000000000000 ]---


> Thanks for reporting. This bug has been fixed in
>
>
> https://cgit.freedesktop.org/drm/drm/commit/?h=3Ddrm-fixes&id=3Dee7a69aa3=
8d87a3bbced7b8245c732c05ed0c6ec
>
> The patch should reach mainline next week or so.

Hi Thomas,
thanks for the patch, this patch fixes oops
But this patch does not fix the initial issue when a lot of processes
blocked by mutex which applied by amdgpu_ctx_mgr_entity_flush
[  249.491425] INFO: task (brt-dbus):1634 blocked for more than 122 seconds=
.
[  249.491520]       Tainted: G        W    L   --------  ---
5.19.0-0.rc5.20220707git9f09069cde34.43.fc37.x86_64 #1
[  249.491526] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  249.491529] task:(brt-dbus)      state:D stack:14504 pid: 1634
ppid:     1 flags:0x00000002
[  249.491541] Call Trace:
[  249.491545]  <TASK>
[  249.491556]  __schedule+0x492/0x1620
[  249.491565]  ? lock_is_held_type+0xe8/0x140
[  249.491575]  ? find_held_lock+0x32/0x80
[  249.491590]  schedule+0x4e/0xb0
[  249.491597]  schedule_preempt_disabled+0x14/0x20
[  249.491603]  __mutex_lock+0x423/0x890
[  249.491609]  ? __lock_acquire+0x387/0x1ee0
[  249.491618]  ? amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]
[  249.491849]  ? amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]
[  249.492040]  amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]
[  249.492237]  amdgpu_flush+0x25/0x40 [amdgpu]
[  249.492420]  filp_close+0x31/0x70
[  249.492429]  __close_range+0x1f3/0x490
[  249.492441]  __x64_sys_close_range+0x13/0x20
[  249.492446]  do_syscall_64+0x5b/0x80
[  249.492452]  ? lockdep_hardirqs_on+0x7d/0x100
[  249.492459]  ? do_syscall_64+0x67/0x80
[  249.492467]  ? asm_exc_page_fault+0x27/0x30
[  249.492473]  ? lockdep_hardirqs_on+0x7d/0x100
[  249.492480]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  249.492486] RIP: 0033:0x7f789d4c23cb
[  249.492512] RSP: 002b:00007ffe10773198 EFLAGS: 00000246 ORIG_RAX:
00000000000001b4
[  249.492518] RAX: ffffffffffffffda RBX: 00007ffe107731a0 RCX: 00007f789d4=
c23cb
[  249.492523] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000000=
00027
[  249.492527] RBP: 00007ffe10773220 R08: 0000000000000000 R09: 00007ffe107=
73270
[  249.492531] R10: 00007ffe107730e0 R11: 0000000000000246 R12: 00000000000=
00002
[  249.492534] R13: 00007ffe10773230 R14: 0000000000000000 R15: 00000000000=
00002
[  249.492555]  </TASK>
[  249.492559] INFO: task (time-dir):1640 blocked for more than 122 seconds=
.
[  249.492564]       Tainted: G        W    L   --------  ---
5.19.0-0.rc5.20220707git9f09069cde34.43.fc37.x86_64 #1
[  249.492568] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  249.492571] task:(time-dir)      state:D stack:14504 pid: 1640
ppid:     1 flags:0x00000002
[  249.492580] Call Trace:
[  249.492584]  <TASK>
[  249.492592]  __schedule+0x492/0x1620
[  249.492597]  ? lock_is_held_type+0xe8/0x140
[  249.492605]  ? find_held_lock+0x32/0x80
[  249.492620]  schedule+0x4e/0xb0
[  249.492627]  schedule_preempt_disabled+0x14/0x20
[  249.492632]  __mutex_lock+0x423/0x890
[  249.492638]  ? __lock_acquire+0x387/0x1ee0
[  249.492646]  ? amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]
[  249.492859]  ? amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]
[  249.493049]  amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]
[  249.493245]  amdgpu_flush+0x25/0x40 [amdgpu]
[  249.493428]  filp_close+0x31/0x70
[  249.493436]  __close_range+0x1f3/0x490
[  249.493447]  __x64_sys_close_range+0x13/0x20
[  249.493452]  do_syscall_64+0x5b/0x80
[  249.493457]  ? lockdep_hardirqs_on+0x7d/0x100
[  249.493465]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  249.493470] RIP: 0033:0x7f789d4c23cb
[  249.493478] RSP: 002b:00007ffe10773198 EFLAGS: 00000246 ORIG_RAX:
00000000000001b4
[  249.493484] RAX: ffffffffffffffda RBX: 00007ffe107731a0 RCX: 00007f789d4=
c23cb
[  249.493488] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000000=
00027
[  249.493492] RBP: 00007ffe10773220 R08: 0000000000000000 R09: 00007ffe107=
73270
[  249.493496] R10: 00007ffe107730e0 R11: 0000000000000246 R12: 00000000000=
00002
[  249.493499] R13: 00007ffe10773230 R14: 0000000000000000 R15: 00000000000=
00002
[  249.493519]  </TASK>
[  249.493528]
               Showing all locks held in the system:
[  249.493537] 1 lock held by khungtaskd/182:
[  249.493542]  #0: ffffffffba168e20 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x15/0x16b
[  249.493565] 1 lock held by systemd-journal/879:
[  249.493575] 3 locks held by gnome-shell/1633:
[  249.493579]  #0: ffff9bd4be4f8c00
(&sig->cred_guard_mutex){+.+.}-{3:3}, at: bprm_execve+0x3c/0x880
[  249.493593]  #1: ffff9bd4be4f8ca8
(&sig->exec_update_lock){++++}-{3:3}, at: begin_new_exec+0x384/0xca0
[  249.493607]  #2: ffff9bd441f20c58 (&mgr->lock#3){+.+.}-{3:3}, at:
amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]
[  249.493807] 1 lock held by (brt-dbus)/1634:
[  249.493811]  #0: ffff9bd441f20c58 (&mgr->lock#3){+.+.}-{3:3}, at:
amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]
[  249.494025] 1 lock held by (time-dir)/1640:
[  249.494029]  #0: ffff9bd441f20c58 (&mgr->lock#3){+.+.}-{3:3}, at:
amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]
[  249.494229] 1 lock held by (ostnamed)/1723:
[  249.494233]  #0: ffff9bd441f20c58 (&mgr->lock#3){+.+.}-{3:3}, at:
amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]
[  249.494432] 1 lock held by (pcscd)/1748:
[  249.494436]  #0: ffff9bd441f20c58 (&mgr->lock#3){+.+.}-{3:3}, at:
amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]

[  249.494639] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Here is pastebin from initial post: https://pastebin.com/0YHs6wyB

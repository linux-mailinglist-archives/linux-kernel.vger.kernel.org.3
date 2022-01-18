Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4344927DD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 14:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244051AbiARN4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 08:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238263AbiARN4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:56:19 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64A0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 05:56:19 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id s127so28546097oig.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 05:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y87S7FBNpMHaq8MuQHnSDxCW/m+Dk2QKe9t3OSbppQk=;
        b=Fpph1DaYOTgcZnoQYHvAe8vEdqKojRDTkZqlOLiptjcT9K9JqJQ6Z7OjNG1rf5JQtM
         5GK+lXpWVF5hJ1YLCrR87GPAuqZwenBG8kxOtP/cKxVR4C67APrsHhrIUyanKwrlGMw6
         lGudgDza4PfWT87h4rTrtL8pG03R3uqrw2iVbsv4h9RLU/8db+hVIdhFdXKj6/uIgehC
         niIXnj6voqAQkbWicE1IbILM8bW1EKlX9cewm4tyz0LZiyjaHAjTs0R15T2gd0X0lVzL
         pNyBjHnAtB2CFexmD614+Xu1XBwBkwJ9tpBaH9WBuJpbqwMtSR/Z0DZYxngOWI4YZGqr
         IvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y87S7FBNpMHaq8MuQHnSDxCW/m+Dk2QKe9t3OSbppQk=;
        b=VdFlJIio8qPN9qrvViQTTBqCHPsyHIM0wksZV1rJCU01Oj5GTGMeJWuVxqsabQLBro
         zoDn4XMybTqw0YcEnIzerduxjYzM1DX0SlLGToZS1teu5rBFM7T+yZvj3iVCf9iSUMNh
         YmIwP00w8MFyuO9kaUxAVCeIt3t1msrFE06z4F90agVMxAf98JApFuUIPSj6+K3ij1Ep
         WhEFnixEgKSm9UWmRNFX/wPFtZF5WY2G7j+wJx68Uj890VL4+EECxMYArTPxUDF88w2p
         vijautuJYcjaYpK5D0mTVaK2Hl6w46sSy8thvT953RB6BxLDuNTiSOzvTTqbziAKoDLl
         NP2A==
X-Gm-Message-State: AOAM531zQaj2xaEt0ODqZoM3PigAlbKHsaox1iCzZQ4ZUwsGCPAZ0dxk
        QGYzikm7i1jSJWY5GrwBv2wVLFHrM3zR51+Yass=
X-Google-Smtp-Source: ABdhPJyTRyvodO+yjtgI5fGAd3D0TCHtBkRf8xviS5rrDyhEWbhCh4rkJQWmVNCLfXaEi2d9hbf78fCFHrROYoraGjU=
X-Received: by 2002:aca:2b01:: with SMTP id i1mr16418519oik.158.1642514179030;
 Tue, 18 Jan 2022 05:56:19 -0800 (PST)
MIME-Version: 1.0
References: <20220117142712.3967624-1-chenwandun@huawei.com>
In-Reply-To: <20220117142712.3967624-1-chenwandun@huawei.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 18 Jan 2022 21:50:42 +0800
Message-ID: <CAA+hA=Rg=uRb_sVvSr4P=rbfbp5MTBmkGJ4pdsd-6wMRPeK39g@mail.gmail.com>
Subject: Re: [PATCH] Revert "mm/page_isolation: unset migratetype directly for
 non Buddy page"
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guillaume.tucker@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 10:12 PM Chen Wandun <chenwandun@huawei.com> wrote:
>
> This reverts commit 075782149abff45ee22f27315eced44d02b96779.
>
> commit 075782149abf ("mm/page_isolation: unset migratetype directly for
> non Buddy page") will result memory that should in buddy disappear by
> mistake. move_freepages_block move all pages in pageblock instead of
> pages indicated by input parameter, so if input pages is not in buddy
> but other pages in pageblock is in buddy, it will result in page out of
> control.
>
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>

The original patch broke imx6ul evk booting up.
Bisect shows it was caused by that patch.
After reverting, it works again.

So:
Tested-by: Dong Aisheng <aisheng.dong@nxp.com>

Below is the original error log:
[    8.710031] kworker/u2:2 invoked oom-killer:
gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0
[    8.719920] CPU: 0 PID: 29 Comm: kworker/u2:2 Not tainted
5.16.0-00095-g721fb891ad0b #95
[    8.728093] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[    8.734322] Workqueue: events_unbound deferred_probe_work_func
[    8.740258] [<c0111640>] (unwind_backtrace) from [<c010ba84>]
(show_stack+0x10/0x14)
[    8.748080] [<c010ba84>] (show_stack) from [<c0f38aa4>]
(dump_stack_lvl+0x58/0x70)
[    8.755725] [<c0f38aa4>] (dump_stack_lvl) from [<c0f32f60>]
(dump_header+0x54/0x3cc)
[    8.763534] [<c0f32f60>] (dump_header) from [<c02aec94>]
(out_of_memory+0x54c/0x5f0)
[    8.771351] [<c02aec94>] (out_of_memory) from [<c030166c>]
(__alloc_pages+0xda8/0x1224)
[    8.779427] [<c030166c>] (__alloc_pages) from [<c03102f4>]
(new_slab+0x200/0x288)
[    8.786983] [<c03102f4>] (new_slab) from [<c03129ec>]
(___slab_alloc.constprop.0+0x5b0/0xea4)
[    8.795585] [<c03129ec>] (___slab_alloc.constprop.0) from
[<c031331c>] (__slab_alloc.constprop.0+0x3c/0x5c)
[    8.805399] [<c031331c>] (__slab_alloc.constprop.0) from
[<c03135a0>] (__kmalloc_track_caller+0x264/0x3a4)
[    8.815125] [<c03135a0>] (__kmalloc_track_caller) from [<c02c8cec>]
(kstrdup_const+0x4c/0x7c)
[    8.823719] [<c02c8cec>] (kstrdup_const) from [<c03cf890>]
(__kernfs_new_node.constprop.0+0x30/0x260)
[    8.833009] [<c03cf890>] (__kernfs_new_node.constprop.0) from
[<c03d0c4c>] (kernfs_new_node+0x30/0x50)
[    8.842384] [<c03d0c4c>] (kernfs_new_node) from [<c03d2e24>]
(kernfs_create_link+0x40/0xac)
[    8.850804] [<c03d2e24>] (kernfs_create_link) from [<c03d419c>]
(sysfs_do_create_link_sd+0x5c/0xd8)
[    8.859921] [<c03d419c>] (sysfs_do_create_link_sd) from
[<c086e9a4>] (device_add+0x264/0x8a8)
[    8.868518] [<c086e9a4>] (device_add) from [<c09f99dc>]
(usb_add_gadget+0xd0/0x180)
[    8.876246] [<c09f99dc>] (usb_add_gadget) from [<c09fa124>]
(usb_add_gadget_udc+0x78/0xb4)
[    8.884580] [<c09fa124>] (usb_add_gadget_udc) from [<c09ec674>]
(ci_hdrc_gadget_init+0x368/0x3e0)
[    8.893522] [<c09ec674>] (ci_hdrc_gadget_init) from [<c09e7870>]
(ci_hdrc_probe+0x6c8/0x8b8)
[    8.902025] [<c09e7870>] (ci_hdrc_probe) from [<c08756f4>]
(platform_probe+0x58/0xbc)
[    8.909919] [<c08756f4>] (platform_probe) from [<c0872e14>]
(really_probe.part.0+0x9c/0x32c)
[    8.918427] [<c0872e14>] (really_probe.part.0) from [<c0873144>]
(__driver_probe_device+0xa0/0x138)
[    8.927544] [<c0873144>] (__driver_probe_device) from [<c087320c>]
(driver_probe_device+0x30/0x10c)
[    8.936661] [<c087320c>] (driver_probe_device) from [<c08737dc>]
(__device_attach_driver+0xb0/0xf8)
[    8.945778] [<c08737dc>] (__device_attach_driver) from [<c0870ec8>]
(bus_for_each_drv+0x80/0xd0)
[    8.954631] [<c0870ec8>] (bus_for_each_drv) from [<c08734f0>]
(__device_attach+0xd0/0x19c)
[    8.962965] [<c08734f0>] (__device_attach) from [<c0871f5c>]
(bus_probe_device+0x88/0x90)
[    8.971212] [<c0871f5c>] (bus_probe_device) from [<c086ead0>]
(device_add+0x390/0x8a8)
[    8.979195] [<c086ead0>] (device_add) from [<c0875370>]
(platform_device_add+0x100/0x208)
[    8.987436] [<c0875370>] (platform_device_add) from [<c09e686c>]
(ci_hdrc_add_device+0x400/0x538)
[    8.996369] [<c09e686c>] (ci_hdrc_add_device) from [<c09eee90>]
(ci_hdrc_imx_probe+0x250/0x62c)
[    9.005133] [<c09eee90>] (ci_hdrc_imx_probe) from [<c08756f4>]
(platform_probe+0x58/0xbc)
[    9.013375] [<c08756f4>] (platform_probe) from [<c0872e14>]
(really_probe.part.0+0x9c/0x32c)
[    9.021880] [<c0872e14>] (really_probe.part.0) from [<c0873144>]
(__driver_probe_device+0xa0/0x138)
[    9.030995] [<c0873144>] (__driver_probe_device) from [<c087320c>]
(driver_probe_device+0x30/0x10c)
[    9.040110] [<c087320c>] (driver_probe_device) from [<c08737dc>]
(__device_attach_driver+0xb0/0xf8)
[    9.049225] [<c08737dc>] (__device_attach_driver) from [<c0870ec8>]
(bus_for_each_drv+0x80/0xd0)
[    9.058081] [<c0870ec8>] (bus_for_each_drv) from [<c08734f0>]
(__device_attach+0xd0/0x19c)
[    9.066414] [<c08734f0>] (__device_attach) from [<c0871f5c>]
(bus_probe_device+0x88/0x90)
[    9.074659] [<c0871f5c>] (bus_probe_device) from [<c0872390>]
(deferred_probe_work_func+0x78/0xa8)
[    9.083691] [<c0872390>] (deferred_probe_work_func) from
[<c0149174>] (process_one_work+0x294/0x7c0)
[    9.092896] [<c0149174>] (process_one_work) from [<c01496ec>]
(worker_thread+0x4c/0x554)
[    9.101052] [<c01496ec>] (worker_thread) from [<c01525c8>]
(kthread+0x16c/0x194)
[    9.108515] [<c01525c8>] (kthread) from [<c010011c>]
(ret_from_fork+0x14/0x38)
[    9.115800] Exception stack(0xc4349fb0 to 0xc4349ff8)
[    9.120906] 9fa0:                                     00000000
00000000 00000000 00000000
[    9.129138] 9fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    9.137364] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    9.145304] Mem-Info:
[    9.147682] active_anon:0 inactive_anon:0 isolated_anon:0
[    9.147682]  active_file:0 inactive_file:0 isolated_file:0
[    9.147682]  unevictable:0 dirty:0 writeback:0
[    9.147682]  slab_reclaimable:2805 slab_unreclaimable:1466
[    9.147682]  mapped:0 shmem:0 pagetables:0 bounce:0
[    9.147682]  kernel_misc_reclaimable:0
[    9.147682]  free:0 free_pcp:5 free_cma:0
[    9.182265] Node 0 active_anon:0kB inactive_anon:0kB
active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB
isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB
writeback_tmp:0kB kerno
[    9.205657] Normal free:0kB boost:0kB min:2780kB low:3472kB
high:4164kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
present:524B
[    9.232095] lowmem_reserve[]: 0 0 0
[    9.235772] Normal: 5*4kB (UMI) 5*8kB (UEI) 10*16kB (UMEI) 9*32kB
(UME) 5*64kB (UME) 7*128kB (UMEI) 7*256kB (UMEI) 4*512kB (MEI)
2*1024kB (M) 4*2048kB (UMI) 5*4096kB (UMEI) 2*8192kB (MI) 5*16384kB
(UMEI) 10*3B
[    9.257621] 0 total pagecache pages
[    9.261441] 0 pages in swap cache
[    9.264820] Swap cache stats: add 0, delete 0, find 0/0
[    9.270258] Free swap  = 0kB
[    9.273199] Total swap = 0kB
[    9.276133] 131072 pages RAM
[    9.279293] 0 pages HighMem/MovableOnly
[    9.283188] 10061 pages reserved
[    9.286468] 16384 pages cma reserved
[    9.290239] Tasks state (memory values in pages):
[    9.295087] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes
swapents oom_score_adj name
[    9.303927] Out of memory and no killable processes...
[    9.309285] Kernel panic - not syncing: System is deadlocked on memory

Regards
Aisheng

> ---
>  mm/page_isolation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 6a0ddda6b3c5..f67c4c70f17f 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -115,7 +115,7 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>          * onlining - just onlined memory won't immediately be considered for
>          * allocation.
>          */
> -       if (!isolated_page && PageBuddy(page)) {
> +       if (!isolated_page) {
>                 nr_pages = move_freepages_block(zone, page, migratetype, NULL);
>                 __mod_zone_freepage_state(zone, nr_pages, migratetype);
>         }
> --
> 2.18.0.huawei.25
>
>

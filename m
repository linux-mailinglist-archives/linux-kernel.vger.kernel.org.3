Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F1154F3CD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381423AbiFQJEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380541AbiFQJEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:04:06 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B651222B9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:04:04 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220617090402euoutp02831f4a8db545e39492fcfeaf4b93fe52~5XQubqrmj2926529265euoutp02I
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 09:04:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220617090402euoutp02831f4a8db545e39492fcfeaf4b93fe52~5XQubqrmj2926529265euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655456642;
        bh=hbO+KUwerHLxtm6KlcfV7OPWErgphtZYtPCSkEyC3g8=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=IDzBMYHvWg4WUA33jUCVnA2FImtixgRrVemb6YSROKiCtFqG8czz3ObpgSBbysNW+
         pIYT2gCSJ0bEyJ0EnyZY7lJac8y2sQSJE+2+1zOXpcIfXfEiivZTWg+a+J9S3BsdDj
         yRjGIySAzSyDopV5bt+EsYYSUIX/bBXO/UhzJxuk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220617090401eucas1p2b7fca481fb60731001b602c7f8d95dcd~5XQtyxdRZ2271722717eucas1p2B;
        Fri, 17 Jun 2022 09:04:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C1.37.09664.1834CA26; Fri, 17
        Jun 2022 10:04:01 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220617090401eucas1p1ec8e4421c1b72b2b69202850e5839185~5XQtKG4640994409944eucas1p1l;
        Fri, 17 Jun 2022 09:04:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220617090401eusmtrp27777d698fc23bd7f671d019689b41346~5XQtJOO8l0063500635eusmtrp2F;
        Fri, 17 Jun 2022 09:04:01 +0000 (GMT)
X-AuditID: cbfec7f2-d81ff700000025c0-0e-62ac43819948
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DC.61.09038.0834CA26; Fri, 17
        Jun 2022 10:04:00 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220617090359eusmtip2d9bfb7e46929bfd21a4448487c44cc9e~5XQsBO5Gg2476424764eusmtip2G;
        Fri, 17 Jun 2022 09:03:59 +0000 (GMT)
Message-ID: <d5796286-ec24-511a-5910-5673f8ea8b10@samsung.com>
Date:   Fri, 17 Jun 2022 11:03:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.9.1
Subject: Re: Default async probing for DT based systems
Content-Language: en-US
To:     Saravana Kannan <saravanak@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAGETcx8z4dn1j05Za6nfDeC3v4r1yo30Nqu=1K2BEsvLcqqybQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7djPc7qNzmuSDB7v07GYdnESs8Xc2ZMY
        LZoXr2ez2LFdxOLp5sdMFlP+LGey2PT4GqvF5V1z2Cw+9x5htNg55ySrxdwvU5ktWvceYbfo
        OvSXzeL42nCLljumDvwe23ZvY/WYeFbXY8GmUo9NqzrZPO5c28Pm8e7cOXaP/XPXsHtsXlLv
        8XmTXABnFJdNSmpOZllqkb5dAldGy7qrzAWdQRVT/z1ma2Cc59HFyMEhIWAicfCSdhcjF4eQ
        wApGiW/P7jNBOF8YJR7d28EO4XxmlFi4ajJQhhOs49ylLYwQieWMEjNmzGSFcD4ySqxe8IcV
        pIpXwE5i8+6FbCA2i4CqxL2OL2wQcUGJkzOfsIDYogJJEvO3tYLVCwuYS8xZ/QYsziwgLnHr
        yXywO0QElrFIbGidDpWIkHhz/A6YzSZgKNH1tosN5AlOgUCJNx0qECXyEs1bZzOD9EoIrOaU
        6N55lBHibBeJVctOQr0gLPHq+BZ2CFtG4v9OkGWgwMiX+DvDGCJcIXHt9RpmCNta4s65X2Cr
        mAU0Jdbv0ocIO0oc/ruAEaKTT+LGW0GIC/gkJm2bzgwR5pXoaBOCqFaTmHV8HdzOgxcuMU9g
        VJqFFCazkPw+C8kvsxD2LmBkWcUonlpanJueWmyYl1quV5yYW1yal66XnJ+7iRGY6k7/O/5p
        B+PcVx/1DjEycTAeYpTgYFYS4TULXpkkxJuSWFmVWpQfX1Sak1p8iFGag0VJnDc5c0OikEB6
        YklqdmpqQWoRTJaJg1OqgcmA365CTEaY8c/KO4sbPti2ScS+OxRzvrOmO1qhuDKG50PRvk9+
        lxTTrK8tWT5jhaGFEXNWsv4k+YbmLffTi/tmFpXdefhdd0f7QuaG4k/X3692PDnFo3SSZ7Hj
        3rcqcW8fLk+wa9ux62LLjYv3Zv7dcU1z9UfWfCnFVI2KO6zLd6w83p1bnpf2xujn9ZudJ3kT
        jS55JInuXPlFPeTsTbNTghL6ysvTXMof54q/1t3+l5un7WXQfse3PKsDH6QGdvo+rZGKkjS1
        lPtkmjGVeXHNnfRmL7FHbjVm664FbqjNeC7s98ryX4bxWf8zOs61yS4sG/0Xn/5TlNcQW2q8
        vf7sqwBrx8NB/09K7ph7WomlOCPRUIu5qDgRAGurTSjkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsVy+t/xe7oNzmuSDNZ9tbKYdnESs8Xc2ZMY
        LZoXr2ez2LFdxOLp5sdMFlP+LGey2PT4GqvF5V1z2Cw+9x5htNg55ySrxdwvU5ktWvceYbfo
        OvSXzeL42nCLljumDvwe23ZvY/WYeFbXY8GmUo9NqzrZPO5c28Pm8e7cOXaP/XPXsHtsXlLv
        8XmTXABnlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5d
        gl5Gy7qrzAWdQRVT/z1ma2Cc59HFyMkhIWAice7SFsYuRi4OIYGljBJNOycxQiRkJE5Oa2CF
        sIUl/lzrYoMoes8o0XEYoohXwE5i8+6FbCA2i4CqxL2OL2wQcUGJkzOfsIDYogJJEvP2rgar
        FxYwl5iz+g1YnFlAXOLWk/lMIENFBFaxSGw7doK9i5EDKBEh8eqeG8SyJYwS+992MIM0sAkY
        SnS9BbmCg4NTIFDiTYcKxBwzia6tXYwQtrxE89bZzBMYhWYhOWMWknWzkLTMQtKygJFlFaNI
        amlxbnpusZFecWJucWleul5yfu4mRmCEbzv2c8sOxpWvPuodYmTiYDzEKMHBrCTCaxa8MkmI
        NyWxsiq1KD++qDQntfgQoykwLCYyS4km5wNTTF5JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6
        YklqdmpqQWoRTB8TB6dUA5OawzZ/AVkj7biwG5/v/ZMU1+Y7F1VfzrXT+5zvjya28K5fNQZu
        xq4c59pXfo06+VY0V9YxoFN02bkD3d5apV8qfnZf9jMLk7owX6D1RE3vHffCk3/nnsnetua3
        6IrawyZB07Y7fH4iyTXt08X9KZk1G61jdylZ99tKRWi2Gnxp+H56MtMMI8sZtXPqZgoGBsuH
        XA1zZjsvJH0/NLtmS/eZn1M2qTpzrQiWagnJTLl7vtHU+fxukydRNY9m1t5rtA486ih1y+f8
        0YWyG7uvqf+Ie/Cr88OEPJEXd6tizEr6j4Ys0BIOWv84/cTdVZPjTzS9+17qWS6xU2hFyXcm
        jdqGRTpKco/WJH+8GRaeo8RSnJFoqMVcVJwIABoTJDR5AwAA
X-CMS-MailID: 20220617090401eucas1p1ec8e4421c1b72b2b69202850e5839185
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220616032522eucas1p19a6c8718f01fa61c2fee795fb8945a92
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220616032522eucas1p19a6c8718f01fa61c2fee795fb8945a92
References: <CGME20220616032522eucas1p19a6c8718f01fa61c2fee795fb8945a92@eucas1p1.samsung.com>
        <CAGETcx8z4dn1j05Za6nfDeC3v4r1yo30Nqu=1K2BEsvLcqqybQ@mail.gmail.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On 16.06.2022 05:24, Saravana Kannan wrote:
> Hi,
>
> TL;DR: I want to improve boot times by enabling async probing by
> default for DT based systems. Can you give it a shot please?

Yes, I've gave it a try on my test systems. It looks that there are a 
few issues. The first one, the most obvious to notice, is related to 
__request_module() calls from various drivers and frameworks. Here are 
some examples:

------------[ cut here ]------------
WARNING: CPU: 3 PID: 73 at kernel/kmod.c:136 __request_module+0x230/0x600
Modules linked in:
CPU: 3 PID: 73 Comm: kworker/u12:5 Not tainted 5.19.0-rc2-next-20220615+ 
#5203
Hardware name: ARM Juno development board (r1) (DT)
Workqueue: events_unbound async_run_entry_fn
pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
UDC core: g_ether: couldn't find an available UDC
pc : __request_module+0x230/0x600
lr : __request_module+0x228/0x600
...
Call trace:
  __request_module+0x230/0x600
  phy_request_driver_module+0x118/0x164
  phy_device_create+0x210/0x23c
  get_phy_device+0x8c/0x160
  mdiobus_scan+0x40/0x1cc
  __mdiobus_register+0x184/0x36c
  smsc911x_drv_probe+0x648/0xa84
  platform_probe+0x68/0xe0
  really_probe+0xbc/0x2e0
  __driver_probe_device+0x78/0xe0
  driver_probe_device+0xa8/0x140
  __driver_attach_async_helper+0x50/0xbc
  async_run_entry_fn+0x34/0xd0
  process_one_work+0x288/0x6bc
  worker_thread+0x74/0x450
  kthread+0x118/0x11c
  ret_from_fork+0x10/0x20
irq event stamp: 2032
hardirqs last  enabled at (2031): [<ffff8000091b91dc>] 
_raw_spin_unlock_irqrestore+0x98/0x9c
hardirqs last disabled at (2032): [<ffff8000091ac844>] el1_dbg+0x24/0x90
softirqs last  enabled at (2018): [<ffff800008010470>] _stext+0x470/0x5e8
softirqs last disabled at (2007): [<ffff8000080a5214>] 
__irq_exit_rcu+0x180/0x1ac
---[ end trace 0000000000000000 ]---

------------[ cut here ]------------
WARNING: CPU: 0 PID: 54 at kernel/kmod.c:136 __request_module+0x230/0x600
Modules linked in: rng_core(+) rtc_meson_vrtc(+) mdio_mux_meson_g12a(+) 
meson_ir pcs_xpcs meson_canvas(+) meson_dw_hdmi dw_hdmi 
snd_soc_meson_axg_tdm_interface di
xg_tdm_formatter nvmem_meson_efuse
CPU: 0 PID: 54 Comm: kworker/u8:3 Not tainted 5.19.0-rc2-next-20220615+ 
#5203
Hardware name: Hardkernel ODROID-C4 (DT)
Workqueue: events_unbound async_run_entry_fn
pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __request_module+0x230/0x600
lr : __request_module+0x228/0x600
...
Call trace:
  __request_module+0x230/0x600
  rc_map_get+0xa8/0x134
  rc_register_device+0x10c/0x600
  devm_rc_register_device+0x4c/0x170
  meson_ir_probe+0x160/0x2bc [meson_ir]
  platform_probe+0x68/0xe0
  really_probe+0xbc/0x2e0
  __driver_probe_device+0x78/0xe0
  driver_probe_device+0x3c/0x140
  __driver_attach_async_helper+0x50/0xbc
  async_run_entry_fn+0x34/0xd0
  process_one_work+0x288/0x6bc
  worker_thread+0x74/0x450
  kthread+0x118/0x11c
  ret_from_fork+0x10/0x20
irq event stamp: 62052
hardirqs last  enabled at (62051): [<ffff800008329c08>] 
___slab_alloc+0x734/0x82c
hardirqs last disabled at (62052): [<ffff8000091ac844>] el1_dbg+0x24/0x90
softirqs last  enabled at (61920): [<ffff800008010470>] _stext+0x470/0x5e8
softirqs last disabled at (61859): [<ffff8000080a5214>] 
__irq_exit_rcu+0x180/0x1ac
---[ end trace 0000000000000000 ]---

------------[ cut here ]------------
WARNING: CPU: 0 PID: 46 at kernel/kmod.c:136 __request_module+0x230/0x600
Modules linked in:
CPU: 0 PID: 46 Comm: kworker/u4:4 Not tainted 5.19.0-rc2-next-20220615+ 
#5203
Hardware name: linux,dummy-virt (DT)
Workqueue: events_unbound async_run_entry_fn
pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __request_module+0x230/0x600
lr : __request_module+0x228/0x600
...
Call trace:
  __request_module+0x230/0x600
  parse_mtd_partitions+0x2b4/0x490
  mtd_device_parse_register+0x90/0x2bc
  physmap_flash_probe+0x4c8/0x7b0
  platform_probe+0x68/0xe0
  really_probe+0xbc/0x2e0
  __driver_probe_device+0x78/0xe0
  driver_probe_device+0xa8/0x140
  __driver_attach_async_helper+0x50/0xbc
  async_run_entry_fn+0x34/0xd0
  process_one_work+0x288/0x6bc
  worker_thread+0x74/0x450
  kthread+0x118/0x11c
  ret_from_fork+0x10/0x20
irq event stamp: 674
hardirqs last  enabled at (673): [<ffffddb219125380>] 
vprintk_store+0x440/0x4a0
hardirqs last disabled at (674): [<ffffddb21a1ac844>] el1_dbg+0x24/0x90
softirqs last  enabled at (618): [<ffffddb219010470>] _stext+0x470/0x5e8
softirqs last disabled at (613): [<ffffddb2190a5214>] 
__irq_exit_rcu+0x180/0x1ac
---[ end trace 0000000000000000 ]---

------------[ cut here ]------------
WARNING: CPU: 0 PID: 63 at kernel/kmod.c:136 __request_module+0x23c/0x42c
Modules linked in: exynos_bus soundcore s5p_mfc lima brcmutil 
drm_shmem_helper exynos_adc gpu_sched sha256_generic libsha256 
sha256_arm cfg80211 phy_exynos_usb2 s
dma_contig videobuf2_memops videobuf2_v4l2 videobuf2_common videodev 
exynosdrm analogix_dp mc exynos_ppmu rtc_s3c i2c_gpio
CPU: 0 PID: 63 Comm: kworker/u4:5 Not tainted 
5.19.0-rc2-next-20220615-00040-g868471ca3680-dirty #5205
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events_unbound async_run_entry_fn
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x40/0x4c
  dump_stack_lvl from __warn+0xcc/0x144
  __warn from warn_slowpath_fmt+0x5c/0xb4
  warn_slowpath_fmt from __request_module+0x23c/0x42c
  __request_module from try_then_request_governor+0x60/0xb0
  try_then_request_governor from devfreq_add_device+0x498/0x5c8
  devfreq_add_device from devm_devfreq_add_device+0x58/0x94
  devm_devfreq_add_device from exynos_bus_probe+0x1b4/0x6bc [exynos_bus]
  exynos_bus_probe [exynos_bus] from platform_probe+0x5c/0xb8
  platform_probe from really_probe+0xc8/0x2f0
  really_probe from __driver_probe_device+0x84/0xe4
  __driver_probe_device from driver_probe_device+0x30/0x104
  driver_probe_device from __driver_attach_async_helper+0x48/0x98
  __driver_attach_async_helper from async_run_entry_fn+0x24/0xb0
  async_run_entry_fn from process_one_work+0x1ec/0x4d0
  process_one_work from worker_thread+0x58/0x54c
  worker_thread from kthread+0xd0/0xec
  kthread from ret_from_fork+0x14/0x2c
Exception stack(0xe0349fb0 to 0xe0349ff8)
...
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 63 at kernel/kmod.c:136 __request_module+0x23c/0x42c
Modules linked in: exynos_bus soundcore s5p_mfc lima brcmutil 
drm_shmem_helper exynos_adc gpu_sched sha256_generic libsha256 
sha256_arm cfg80211 phy_exynos_usb2 s
dma_contig videobuf2_memops videobuf2_v4l2 videobuf2_common videodev 
exynosdrm analogix_dp mc exynos_ppmu rtc_s3c i2c_gpio
CPU: 0 PID: 63 Comm: kworker/u4:5 Not tainted 
5.19.0-rc2-next-20220615-00040-g868471ca3680-dirty #5205
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events_unbound async_run_entry_fn
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x40/0x4c
  dump_stack_lvl from __warn+0xcc/0x144
  __warn from warn_slowpath_fmt+0x5c/0xb4
  warn_slowpath_fmt from __request_module+0x23c/0x42c
  __request_module from try_then_request_governor+0x60/0xb0
  try_then_request_governor from devfreq_add_device+0x498/0x5c8
  devfreq_add_device from devm_devfreq_add_device+0x58/0x94
  devm_devfreq_add_device from exynos_bus_probe+0x1b4/0x6bc [exynos_bus]
  exynos_bus_probe [exynos_bus] from platform_probe+0x5c/0xb8
  platform_probe from really_probe+0xc8/0x2f0
  really_probe from __driver_probe_device+0x84/0xe4
  __driver_probe_device from driver_probe_device+0x30/0x104
  driver_probe_device from __driver_attach_async_helper+0x48/0x98
  __driver_attach_async_helper from async_run_entry_fn+0x24/0xb0
  async_run_entry_fn from process_one_work+0x1ec/0x4d0
  process_one_work from worker_thread+0x58/0x54c
  worker_thread from kthread+0xd0/0xec
  kthread from ret_from_fork+0x14/0x2c
Exception stack(0xe0349fb0 to 0xe0349ff8)
...
---[ end trace 0000000000000000 ]---

------------[ cut here ]------------
WARNING: CPU: 0 PID: 23 at kernel/kmod.c:136 __request_module+0x23c/0x42c
Modules linked in: g_ether usb_f_rndis u_ether libcomposite brcmfmac 
brcmutil sha256_generic libsha256 snd_soc_hdmi_codec snd_soc_core 
sha256_arm ac97_bus snd_pcm
_timer snd soundcore panel_samsung_ld9040 hci_uart btbcm bluetooth 
s5p_csis s5p_fimc exynos4_is_common v4l2_fwnode ecdh_generic ecc 
v4l2_async spi_gpio phy_exynos
x8998 pwm_samsung max8952 drm_shmem_helper libaes s5p_mfc gpu_sched 
s5p_jpeg v4l2_mem2mem videobuf2_dma_contig videobuf2_memops 
videobuf2_v4l2 phy_exynos_usb2 vid
m ohci_exynos ehci_exynos analogix_dp mc s5p_sss exynos_rng rtc_s3c 
s3c2410_wdt i2c_gpio
CPU: 0 PID: 23 Comm: kworker/u4:7 Not tainted 
5.19.0-rc2-next-20220615-00040-g868471ca3680-dirty #5205
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events_unbound async_run_entry_fn
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x40/0x4c
  dump_stack_lvl from __warn+0xcc/0x144
  __warn from warn_slowpath_fmt+0x5c/0xb4
  warn_slowpath_fmt from __request_module+0x23c/0x42c
  __request_module from usb_get_function_instance+0x3c/0x58 [libcomposite]
  usb_get_function_instance [libcomposite] from eth_bind+0x3c/0x334 
[g_ether]
  eth_bind [g_ether] from composite_bind+0x78/0x18c [libcomposite]
  composite_bind [libcomposite] from gadget_bind_driver+0x8c/0x1d0
  gadget_bind_driver from really_probe+0xc8/0x2f0
  really_probe from __driver_probe_device+0x84/0xe4
  __driver_probe_device from driver_probe_device+0x30/0x104
  driver_probe_device from __driver_attach_async_helper+0x48/0x98
  __driver_attach_async_helper from async_run_entry_fn+0x24/0xb0
  async_run_entry_fn from process_one_work+0x1ec/0x4d0
  process_one_work from worker_thread+0x58/0x54c
  worker_thread from kthread+0xd0/0xec
  kthread from ret_from_fork+0x14/0x2c
Exception stack(0xe08ddfb0 to 0xe08ddff8)
...
---[ end trace 0000000000000000 ]---


Some Exynos-based boards also freeze quite early, after the 'EXYNOS5420 
PMU initialized' message. I will investigate this later once I find some 
spare time.

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


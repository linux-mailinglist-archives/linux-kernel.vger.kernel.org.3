Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E414CD2C0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 11:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbiCDKuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 05:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237970AbiCDKuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:50:35 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E340C6BDCC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 02:49:46 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1C8403200E42;
        Fri,  4 Mar 2022 05:49:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 04 Mar 2022 05:49:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm2; bh=1
        J7QYW14dPap27gLX7HN9zMfszTe1igvK0ujk/vBAWo=; b=ufr1K4S4qRNLgrsn4
        ffWZFkJIn1IYVYL0wyszkVrQpqwMaid4oe+e+Stj5Po/oplmJ24OgZcbrx+sT7GA
        WowHzjJdmEMXQlHM9nbYKxd1/hVQup2MwwwfQqReGaxwrA4+cgeWOWXJcqx0TjTg
        IpY1qVN7ZFgpi3PBZmsFx38NUe5S6w4ICoWxURZVuNm2prtXb2ZC2bKvakdPwZA3
        JNPixB4jsR1jRypoEKz0S9JX4y0Z4n2BmseNd5PsiFNOPGF0IZGEHKtM1LdVGa4P
        D0JrXLtUq9d3DRrnsgHhJK1UjVzRTbUqvg8gV/cHYlPfjMeD8hsil+vkzMNZqcd4
        ceGbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=1J7QYW14dPap27gLX7HN9zMfszTe1igvK0ujk/vBA
        Wo=; b=PILf91CWuIDLnJ+Q377fv9tGtv0iotOL7fHBZB3YHYbQcRxPQ50AriV8x
        g7P2jk5Xj5cK8Ud9p2lhX7OlhkvYS/sJr4yvUoBcCB91i5k5uuBEoOj7NXHI+QXv
        MTLSmWkrUW8mmmyRMFITvuA+KsV8hXzNPSTvVQNjQPd3kDZhug3z0Q2/75Ns/DWT
        qXhnRC+pGm6Y5aujW/Dv411upABxIpsCJafjjhReDRt4t4eGggeFcL4Q+rRHUWXN
        y5AzojDBTCHWCJCzOZmCvEDKueVCpRH3L4Omo9nd6MONMTQHUkl7HQfoYRRBvaBy
        AFMWbmsKoyTM/z3obKKCdpGpXaRFA==
X-ME-Sender: <xms:ye4hYoS1GAg-hF-COag4shsxJRcFbGoBguMfFcJwTvWvYZIoPdnBNw>
    <xme:ye4hYlz9P7sx-GNJzBCW9fjLyTr4xRUAlsl62dJQBLPQ71FvjP9MzHKRu5f5vJ5zo
    iNMVVnZyYTum579rGI>
X-ME-Received: <xmr:ye4hYl3gD4jBK8eWZi5pCR2LsQkxGm3J8-dUwqHGw2gMnxlLPL_dE7RAOzUkQCi5_8YW4or6JWWc5To67tXeFBctYDG_is2aeLjfB8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtkedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfggtggusehgtderredttddvnecuhfhrohhmpeforgigihhmvgcu
    tfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrthhtvg
    hrnhepgeehvddvffelveeiuefggfeiueduvdfhfeeuhffgleejleeghfdvgedtveegleek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgi
    himhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:ye4hYsCB9fJ6SM9J90OW8ZuR2A5YD1QiCxjk2-LsFpnxPNn1rPLkTA>
    <xmx:ye4hYhiDXl7YDBQSK_wvznyJ1rnVIKzbRDXU3Fm9VNFZG2C6ZOaQ6Q>
    <xmx:ye4hYor9C0MgkCVTzaUJTWJIKWBlwdaTOHvDSFyl0loTEN-oh7zNDw>
    <xmx:ye4hYkvb3XRRntgal_USJj_KBzmM37CCeif9AYU3F6fM8UoFqyBNWA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Mar 2022 05:49:44 -0500 (EST)
Date:   Fri, 4 Mar 2022 11:49:42 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Deadlock at reboot?
Message-ID: <20220304104942.lypg3wvlgk2ywi2t@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y2zkfe2qvab2l556"
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y2zkfe2qvab2l556
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm not entirely sure who I'm supposed to send this to, so apologies if
I forgot somebody.

I've had an issue when rebooting on and off for a couple of monthes, but
I got a stacktrace from lockdep today:

[71721.872904] reboot: Restarting system
[71721.876743] ------------[ cut here ]------------
[71721.877081]
[71721.877084] ======================================================
[71721.877086] WARNING: possible circular locking dependency detected
[71721.877088] 5.17.0-rc6-next-20220303-v8+ #10 Not tainted
[71721.877092] ------------------------------------------------------
[71721.877094] swapper/1/0 is trying to acquire lock:
[71721.877097] ffffffc009610900 (console_owner){-.-.}-{0:0}, at: console_unlock+0x194/0x4e0
[71721.877117]
[71721.877117] but task is already holding lock:
[71721.877118] ffffff80fb7974d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x30/0x50
[71721.877131]
[71721.877131] which lock already depends on the new lock.
[71721.877131]
[71721.877132]
[71721.877132] the existing dependency chain (in reverse order) is:
[71721.877133]
[71721.877133] -> #4 (&rq->__lock){-.-.}-{2:2}:
[71721.877139]        __lock_acquire+0x458/0xab0
[71721.877146]        lock_acquire.part.0+0x9c/0x1e0
[71721.877152]        lock_acquire+0x68/0x84
[71721.877157]        _raw_spin_lock_nested+0x6c/0x84
[71721.877164]        raw_spin_rq_lock_nested+0x30/0x50
[71721.877169]        task_fork_fair+0x48/0x164
[71721.877175]        sched_cgroup_fork+0xd4/0x130
[71721.877181]        copy_process+0xd88/0x1380
[71721.877188]        kernel_clone+0x98/0x364
[71721.877193]        kernel_thread+0x78/0xb0
[71721.877198]        rest_init+0x38/0x2c0
[71721.877202]        arch_call_rest_init+0x1c/0x28
[71721.877207]        start_kernel+0x644/0x684
[71721.877211]        __primary_switched+0xa4/0xac
[71721.877214]
[71721.877214] -> #3 (&p->pi_lock){-.-.}-{2:2}:
[71721.877220]        __lock_acquire+0x458/0xab0
[71721.877225]        lock_acquire.part.0+0x9c/0x1e0
[71721.877230]        lock_acquire+0x68/0x84
[71721.877234]        _raw_spin_lock_irqsave+0x90/0xd0
[71721.877241]        try_to_wake_up+0x60/0x460
[71721.877247]        default_wake_function+0x28/0x50
[71721.877253]        woken_wake_function+0x2c/0x40
[71721.877257]        __wake_up_common+0xa0/0x180
[71721.877261]        __wake_up_common_lock+0x80/0xd0
[71721.877265]        __wake_up+0x24/0x30
[71721.877268]        tty_wakeup+0x40/0x80
[71721.877274]        tty_port_default_wakeup+0x2c/0x4c
[71721.877278]        tty_port_tty_wakeup+0x24/0x30
[71721.877282]        uart_write_wakeup+0x24/0x34
[71721.877288]        serial8250_tx_chars+0x110/0x250
[71721.877293]        serial8250_handle_irq.part.0+0x11c/0x170
[71721.877297]        serial8250_default_handle_irq+0x58/0x9c
[71721.877301]        serial8250_interrupt+0x5c/0xc0
[71721.877305]        __handle_irq_event_percpu+0x9c/0x1b4
[71721.877310]        handle_irq_event+0x58/0x130
[71721.877314]        handle_fasteoi_irq+0xb0/0x1f0
[71721.877321]        generic_handle_domain_irq+0x48/0x6c
[71721.877325]        gic_handle_irq+0x88/0xc0
[71721.877329]        call_on_irq_stack+0x2c/0x58
[71721.877334]        do_interrupt_handler+0x88/0xa0
[71721.877339]        el1_interrupt+0x34/0x50
[71721.877342]        el1h_64_irq_handler+0x18/0x24
[71721.877346]        el1h_64_irq+0x64/0x68
[71721.877349]        arch_cpu_idle+0x18/0x2c
[71721.877353]        default_idle_call+0x6c/0x104
[71721.877358]        cpuidle_idle_call+0x158/0x190
[71721.877362]        do_idle+0xdc/0x114
[71721.877365]        cpu_startup_entry+0x34/0xa0
[71721.877369]        rest_init+0x1bc/0x2c0
[71721.877373]        arch_call_rest_init+0x1c/0x28
[71721.877376]        start_kernel+0x644/0x684
[71721.877379]        __primary_switched+0xa4/0xac
[71721.877383]
[71721.877383] -> #2 (&tty->write_wait){-.-.}-{2:2}:
[71721.877389]        __lock_acquire+0x458/0xab0
[71721.877393]        lock_acquire.part.0+0x9c/0x1e0
[71721.877398]        lock_acquire+0x68/0x84
[71721.877403]        _raw_spin_lock_irqsave+0x90/0xd0
[71721.877408]        __wake_up_common_lock+0x60/0xd0
[71721.877412]        __wake_up+0x24/0x30
[71721.877416]        tty_wakeup+0x40/0x80
[71721.877421]        tty_port_default_wakeup+0x2c/0x4c
[71721.877425]        tty_port_tty_wakeup+0x24/0x30
[71721.877428]        uart_write_wakeup+0x24/0x34
[71721.877433]        serial8250_tx_chars+0x110/0x250
[71721.877438]        serial8250_handle_irq.part.0+0x11c/0x170
[71721.877442]        serial8250_default_handle_irq+0x58/0x9c
[71721.877446]        serial8250_interrupt+0x5c/0xc0
[71721.877450]        __handle_irq_event_percpu+0x9c/0x1b4
[71721.877454]        handle_irq_event+0x58/0x130
[71721.877459]        handle_fasteoi_irq+0xb0/0x1f0
[71721.877464]        generic_handle_domain_irq+0x48/0x6c
[71721.877468]        gic_handle_irq+0x88/0xc0
[71721.877472]        call_on_irq_stack+0x2c/0x58
[71721.877476]        do_interrupt_handler+0x88/0xa0
[71721.877481]        el1_interrupt+0x34/0x50
[71721.877484]        el1h_64_irq_handler+0x18/0x24
[71721.877487]        el1h_64_irq+0x64/0x68
[71721.877491]        arch_cpu_idle+0x18/0x2c
[71721.877494]        default_idle_call+0x6c/0x104
[71721.877499]        cpuidle_idle_call+0x158/0x190
[71721.877503]        do_idle+0xdc/0x114
[71721.877507]        cpu_startup_entry+0x34/0xa0
[71721.877510]        rest_init+0x1bc/0x2c0
[71721.877514]        arch_call_rest_init+0x1c/0x28
[71721.877518]        start_kernel+0x644/0x684
[71721.877521]        __primary_switched+0xa4/0xac
[71721.877524]
[71721.877524] -> #1 (&port_lock_key){-.-.}-{2:2}:
[71721.877529]        __lock_acquire+0x458/0xab0
[71721.877534]        lock_acquire.part.0+0x9c/0x1e0
[71721.877539]        lock_acquire+0x68/0x84
[71721.877543]        _raw_spin_lock_irqsave+0x90/0xd0
[71721.877549]        serial8250_console_write+0x1b4/0x3a0
[71721.877554]        univ8250_console_write+0x30/0x40
[71721.877557]        call_console_drivers.constprop.0+0x100/0x1fc
[71721.877561]        console_unlock+0x1ec/0x4e0
[71721.877564]        register_console+0x13c/0x2b0
[71721.877567]        uart_add_one_port+0x33c/0x370
[71721.877573]        serial8250_register_8250_port+0x328/0x420
[71721.877576]        bcm2835aux_serial_probe+0x1c0/0x290
[71721.877585]        platform_probe+0x74/0xf0
[71721.877591]        really_probe.part.0+0xa4/0x300
[71721.877596]        __driver_probe_device+0xa0/0x150
[71721.877600]        driver_probe_device+0xb4/0x150
[71721.877604]        __driver_attach+0x110/0x1b0
[71721.877608]        bus_for_each_dev+0x7c/0xe0
[71721.877612]        driver_attach+0x30/0x3c
[71721.877616]        bus_add_driver+0x15c/0x200
[71721.877620]        driver_register+0x84/0x140
[71721.877624]        __platform_driver_register+0x34/0x40
[71721.877630]        bcm2835aux_serial_driver_init+0x28/0x34
[71721.877634]        do_one_initcall+0x54/0x1a0
[71721.877638]        kernel_init_freeable+0x1dc/0x25c
[71721.877642]        kernel_init+0x30/0x140
[71721.877645]        ret_from_fork+0x10/0x20
[71721.877649]
[71721.877649] -> #0 (console_owner){-.-.}-{0:0}:
[71721.877654]        check_prev_add+0xac/0xbcc
[71721.877659]        validate_chain+0x420/0x5d0
[71721.877664]        __lock_acquire+0x458/0xab0
[71721.877668]        lock_acquire.part.0+0x9c/0x1e0
[71721.877673]        lock_acquire+0x68/0x84
[71721.877678]        console_unlock+0x1dc/0x4e0
[71721.877681]        vprintk_emit+0x1c8/0x1ec
[71721.877684]        vprintk_default+0x44/0x50
[71721.877688]        vprintk+0xc4/0x110
[71721.877691]        _printk+0x68/0x90
[71721.877697]        report_bug+0x104/0x130
[71721.877704]        bug_handler+0x2c/0x80
[71721.877707]        call_break_hook+0x70/0x84
[71721.877711]        brk_handler+0x28/0x70
[71721.877714]        do_debug_exception+0xa4/0x130
[71721.877721]        el1_dbg+0x70/0x8c
[71721.877724]        el1h_64_sync_handler+0x94/0xd0
[71721.877728]        el1h_64_sync+0x64/0x68
[71721.877731]        set_task_cpu+0x1b4/0x1f0
[71721.877736]        detach_tasks+0x148/0x380
[71721.877741]        load_balance+0x240/0x750
[71721.877746]        rebalance_domains+0x3c0/0x4d0
[71721.877751]        _nohz_idle_balance.constprop.0.isra.0+0x1ec/0x380
[71721.877757]        run_rebalance_domains+0x70/0x80
[71721.877762]        __do_softirq+0x1a0/0x37c
[71721.877765]        __irq_exit_rcu+0x120/0x160
[71721.877770]        irq_exit_rcu+0x1c/0x44
[71721.877774]        el1_interrupt+0x38/0x50
[71721.877777]        el1h_64_irq_handler+0x18/0x24
[71721.877780]        el1h_64_irq+0x64/0x68
[71721.877783]        arch_cpu_idle+0x18/0x2c
[71721.877787]        default_idle_call+0x6c/0x104
[71721.877792]        cpuidle_idle_call+0x158/0x190
[71721.877796]        do_idle+0xdc/0x114
[71721.877799]        cpu_startup_entry+0x30/0xa0
[71721.877803]        secondary_start_kernel+0xdc/0x100
[71721.877809]        __secondary_switched+0xa0/0xa4
[71721.877814]
[71721.877814] other info that might help us debug this:
[71721.877814]
[71721.877815] Chain exists of:
[71721.877815]   console_owner --> &p->pi_lock --> &rq->__lock
[71721.877815]
[71721.877821]  Possible unsafe locking scenario:
[71721.877821]
[71721.877823]        CPU0                    CPU1
[71721.877824]        ----                    ----
[71721.877825]   lock(&rq->__lock);
[71721.877827]                                lock(&p->pi_lock);
[71721.877830]                                lock(&rq->__lock);
[71721.877832]   lock(console_owner);
[71721.877835]
[71721.877835]  *** DEADLOCK ***
[71721.877835]
[71721.877836] 3 locks held by swapper/1/0:
[71721.877839]  #0: ffffffc009681fe8 (rcu_read_lock){....}-{1:2}, at: rebalance_domains+0x8c/0x4d0
[71721.877850]  #1: ffffff80fb7974d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x30/0x50
[71721.877861]  #2: ffffffc009610790 (console_lock){+.+.}-{0:0}, at: console_trylock_spinning+0x20/0x1a4
[71721.877870]
[71721.877870] stack backtrace:
[71721.877872] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.17.0-rc6-next-20220303-v8+ #10
[71721.877877] Hardware name: Raspberry Pi 4 Model B Rev 1.1 (DT)
[71721.877880] Call trace:
[71721.877881]  dump_backtrace.part.0+0xd4/0xe0
[71721.877884]  show_stack+0x24/0x80
[71721.877888]  dump_stack_lvl+0x8c/0xb8
[71721.877893]  dump_stack+0x18/0x34
[71721.877896]  print_circular_bug+0x1f8/0x200
[71721.877901]  check_noncircular+0x130/0x144
[71721.877906]  check_prev_add+0xac/0xbcc
[71721.877910]  validate_chain+0x420/0x5d0
[71721.877915]  __lock_acquire+0x458/0xab0
[71721.877920]  lock_acquire.part.0+0x9c/0x1e0
[71721.877924]  lock_acquire+0x68/0x84
[71721.877929]  console_unlock+0x1dc/0x4e0
[71721.877932]  vprintk_emit+0x1c8/0x1ec
[71721.877936]  vprintk_default+0x44/0x50
[71721.877939]  vprintk+0xc4/0x110
[71721.877943]  _printk+0x68/0x90
[71721.877948]  report_bug+0x104/0x130
[71721.877953]  bug_handler+0x2c/0x80
[71721.877956]  call_break_hook+0x70/0x84
[71721.877960]  brk_handler+0x28/0x70
[71721.877964]  do_debug_exception+0xa4/0x130
[71721.877970]  el1_dbg+0x70/0x8c
[71721.877973]  el1h_64_sync_handler+0x94/0xd0
[71721.877976]  el1h_64_sync+0x64/0x68
[71721.877980]  set_task_cpu+0x1b4/0x1f0
[71721.877985]  detach_tasks+0x148/0x380
[71721.877990]  load_balance+0x240/0x750
[71721.877995]  rebalance_domains+0x3c0/0x4d0
[71721.878000]  _nohz_idle_balance.constprop.0.isra.0+0x1ec/0x380
[71721.878006]  run_rebalance_domains+0x70/0x80
[71721.878011]  __do_softirq+0x1a0/0x37c
[71721.878014]  __irq_exit_rcu+0x120/0x160
[71721.878018]  irq_exit_rcu+0x1c/0x44
[71721.878022]  el1_interrupt+0x38/0x50
[71721.878026]  el1h_64_irq_handler+0x18/0x24
[71721.878029]  el1h_64_irq+0x64/0x68
[71721.878032]  arch_cpu_idle+0x18/0x2c
[71721.878035]  default_idle_call+0x6c/0x104
[71721.878041]  cpuidle_idle_call+0x158/0x190
[71721.878045]  do_idle+0xdc/0x114
[71721.878048]  cpu_startup_entry+0x30/0xa0
[71721.878052]  secondary_start_kernel+0xdc/0x100
[71721.878057]  __secondary_switched+0xa0/0xa4
[71722.926930] WARNING: CPU: 1 PID: 0 at kernel/sched/core.c:3052 set_task_cpu+0x1b4/0x1f0
[71722.935049] Modules linked in:
[71722.938139] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.17.0-rc6-next-20220303-v8+ #10
[71722.946164] Hardware name: Raspberry Pi 4 Model B Rev 1.1 (DT)
[71722.950095] SMP: failed to stop secondary CPUs 0-1

The board would then require a power cycle to boot again (the changes
were some registers changes in KMS, nothing that would affect this part
of the code)

I'm not entirely sure how to fix it. Some versions seems to be more
affected than others. next-20220303 seems to trigger it 100% of the
time, some older versions would reboot fine. Like I said, it's been on
and off, so I think the source has been there for some time, whether it
works or not depends probably on subtle timings or something like that.

Maxime

--y2zkfe2qvab2l556
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYiHuxgAKCRDj7w1vZxhR
xTMYAP9IjJq5OT3VlOgHGGqNel3WKv96Bi7f/iMHLFz3QQq6tAD+Lf0L70PSMkmN
QUuYrlIacIWLtsJUIa8QFuyfHR2bYg0=
=WkbR
-----END PGP SIGNATURE-----

--y2zkfe2qvab2l556--

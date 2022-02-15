Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009B54B78CF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242292AbiBOUev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:34:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbiBOUeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:34:50 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488E089CD4;
        Tue, 15 Feb 2022 12:34:39 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id p9so13544321wra.12;
        Tue, 15 Feb 2022 12:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KRSkNhIEhZMEMhWXs5iKQNZLmkUM8XOFNeLt27M+yH0=;
        b=hmXooVo0/3oV8QfjJUBlso0REBtT/7qZxc4FtjAmra0e1picrf+m3AyZe/9+8D/Qys
         dAKgFh2OJUrLVKJkf6aJmpRcU7Qan23dlXdC0svDE/UgTCkjX2BuMtea43ycfowTGPAy
         UI++sJoOrZY7O3tZRi5Sd98UNVeeD3+7UCSQRtdd8UB27UASvbssCSCmBM7W9NCdoRSy
         EwGs+mFo+Q+4AYFJcptcxtmga80wOuzuZaV1sd5mPdtoreJ+MuJe34KIj6aYUmlcWdX7
         ZPeKhgH4e1WwI7lmO1AO+RdrMWmX7QTBeP2Eg6Q5AY0fo0HHAZP//R0Ljxtl8OJ3GqRG
         eDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KRSkNhIEhZMEMhWXs5iKQNZLmkUM8XOFNeLt27M+yH0=;
        b=7zFebYcJOgR4rGL+B2CSGMfVKSvjbuv8zyEciQtu2lPjPKaO2aCY5PjE7IYtcCGhYq
         Hie7d+k3Nac9Kr+NSO5yxHH9A92g+p3hqekqWP1zQh9F6NUhr612BSuMKZWpdo0ZUQZ/
         mpB/XA78P1EDOKBPk/SFZEUwSkSo5Jd+CE5OOEfZhcFthFqZRZx8t/MF0BKMaY1r979S
         6plZoCQTdr5womrOceHoTX7l9Hn/YNKBAj2BHgoSNomoSz7hRsT+14SoPi6YsAHvQIO7
         4yJD8K+vTq7sj2XpBMgDI9BmBAFJc9Fya7S4x7yPKnbUApI/OeJ5pkPE9B/E/8TD7yqP
         a6EA==
X-Gm-Message-State: AOAM531gqW+JPGAfpU2tBgfAgHeS062mAuPlwrx613y8JiUO0A5tiNpj
        BMMSXmpeIQm2iKeroVd0pTE=
X-Google-Smtp-Source: ABdhPJx7LPF22AwP5kqzNKnc1tpYmsQB+V9uLmcnJHL/G901Xck085/9xsudMsuFVZQmfQc0vJM0Ug==
X-Received: by 2002:adf:f191:: with SMTP id h17mr568730wro.188.1644957277766;
        Tue, 15 Feb 2022 12:34:37 -0800 (PST)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id r14sm6034914wrz.84.2022.02.15.12.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 12:34:37 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Klein <michael@fossekall.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: Re: [PATCH v2] ARM: dts: sun8i: Adjust power key nodes
Date:   Tue, 15 Feb 2022 21:34:36 +0100
Message-ID: <4714494.31r3eYUQgx@kista>
In-Reply-To: <20220215002732.GA3215504@roeck-us.net>
References: <20211129165510.370717-1-jernej.skrabec@gmail.com> <20220215002732.GA3215504@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne torek, 15. februar 2022 ob 01:27:32 CET je Guenter Roeck napisal(a):
> Hi,
> 
> On Mon, Nov 29, 2021 at 05:55:10PM +0100, Jernej Skrabec wrote:
> > Several H3 and one H2+ board have power key nodes, which are slightly
> > off. Some are missing wakeup-source property and some have BTN_0 code
> > assigned instead of KEY_POWER.
> > 
> > Adjust them, so they can function as intended by designer.
> > 
> > Co-developed-by: Michael Klein <michael@fossekall.de>
> > Signed-off-by: Michael Klein <michael@fossekall.de>
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> 
> This patch results in the following traceback when rebooting an
> orangepi-pc qemu emulation.
> 
> [   30.899594]
> [   30.899685] ============================================
> [   30.899757] WARNING: possible recursive locking detected
> [   30.899938] 5.17.0-rc3-00394-gc849047c2473 #1 Not tainted
> [   30.900055] --------------------------------------------
> [   30.900124] init/307 is trying to acquire lock:
> [   30.900246] c2dfe27c (&irq_desc_lock_class){-.-.}-{2:2}, at: 
__irq_get_desc_lock+0x58/0xa0
> [   30.900900]
> [   30.900900] but task is already holding lock:
> [   30.900974] c3c0ac7c (&irq_desc_lock_class){-.-.}-{2:2}, at: 
__irq_get_desc_lock+0x58/0xa0
> [   30.901101]
> [   30.901101] other info that might help us debug this:
> [   30.901188]  Possible unsafe locking scenario:
> [   30.901188]
> [   30.901262]        CPU0
> [   30.901301]        ----
> [   30.901339]   lock(&irq_desc_lock_class);
> [   30.901411]   lock(&irq_desc_lock_class);
> [   30.901480]
> [   30.901480]  *** DEADLOCK ***
> [   30.901480]
> [   30.901554]  May be due to missing lock nesting notation
> [   30.901554]
> [   30.901657] 4 locks held by init/307:
> [   30.901724]  #0: c1f29f18 (system_transition_mutex){+.+.}-{3:3}, at: 
__do_sys_reboot+0x90/0x23c
> [   30.901889]  #1: c20f7760 (&dev->mutex){....}-{3:3}, at: 
device_shutdown+0xf4/0x224
> [   30.902016]  #2: c2e804d8 (&dev->mutex){....}-{3:3}, at: 
device_shutdown+0x104/0x224
> [   30.902138]  #3: c3c0ac7c (&irq_desc_lock_class){-.-.}-{2:2}, at: 
__irq_get_desc_lock+0x58/0xa0
> [   30.902281]
> [   30.902281] stack backtrace:
> [   30.902462] CPU: 0 PID: 307 Comm: init Not tainted 5.17.0-rc3-00394-
gc849047c2473 #1
> [   30.902572] Hardware name: Allwinner sun8i Family
> [   30.902781]  unwind_backtrace from show_stack+0x10/0x14
> [   30.902895]  show_stack from dump_stack_lvl+0x68/0x90
> [   30.902970]  dump_stack_lvl from __lock_acquire+0x1680/0x31a0
> [   30.903047]  __lock_acquire from lock_acquire+0x148/0x3dc
> [   30.903118]  lock_acquire from _raw_spin_lock_irqsave+0x50/0x6c
> [   30.903197]  _raw_spin_lock_irqsave from __irq_get_desc_lock+0x58/0xa0
> [   30.903282]  __irq_get_desc_lock from irq_set_irq_wake+0x2c/0x19c
> [   30.903366]  irq_set_irq_wake from irq_set_irq_wake+0x13c/0x19c
> [   30.903442]  irq_set_irq_wake from gpio_keys_suspend+0x80/0x1a4
> [   30.903523]  gpio_keys_suspend from gpio_keys_shutdown+0x10/0x2c
> [   30.903603]  gpio_keys_shutdown from device_shutdown+0x180/0x224
> [   30.903685]  device_shutdown from __do_sys_reboot+0x134/0x23c
> [   30.903764]  __do_sys_reboot from ret_fast_syscall+0x0/0x1c
> [   30.903894] Exception stack(0xc584ffa8 to 0xc584fff0)
> [   30.904013] ffa0:                   01234567 000c623f fee1dead 28121969 
01234567 00000000
> [   30.904117] ffc0: 01234567 000c623f 00000001 00000058 000d85c0 00000000 
00000000 00000000
> [   30.904213] ffe0: 000d8298 be84ddf4 000918bc b6eb0edc
> [   30.905189] reboot: Restarting system
> 
> The warning is no longer seen after reverting this patch.
> 
> The problem exists but is not seen in v5.17-rc4 because a bug in commit
> 8df89a7cbc63 ("pinctrl-sunxi: don't call pinctrl_gpio_direction()")
> hides it. That problem is fixed with commit 3c5412cdec9f ("pinctrl-sunxi:
> sunxi_pinctrl_gpio_direction_in/output: use correct offset") in linux-next,
> and the traceback is seen there.

Hm... These DT changes were tested with many users on older kernels for some 
time now and new properties conform to bindings. Should we revert pinctrl 
changes?

Best regards,
Jernej




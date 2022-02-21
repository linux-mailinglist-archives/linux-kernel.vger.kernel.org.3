Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916DD4BD406
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344065AbiBUCsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:48:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343585AbiBUCsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:48:08 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2CE1AF05
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 18:47:46 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id j2so9453705oie.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 18:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jlMjmCUClLgRkGDgN861wGxXsMK2HYMM+Br9VBYBldo=;
        b=Aqk6W5RcDXF6yxWqfZH2/avnegytjuNY7e69Egb+8qnzvyVI7RI4m7oXkqqRyJfTIr
         l4gQ3zeLGIulkOx8FtV6MXUidWzfiDu95z73Ch2XpFOeUDZyM7ONoCXnEh2vXgCHzsMe
         m1NUR6izYC4POz0U6qGZSdDgNO53WUJK8VHdhLoTidFAiIPe1jB9KueHmuFumEpr2wxK
         V+/wXcwueKia00S9/iu9e0BAtGsMdotcRbf5RtoASAODc7eNhVeObn1rAl6ayztAjVHL
         nWnGvdbi8/MZYiY57GkVj/56GM7MQvoVg+67Or7fQ0+ofqXso65ZLqQPatj03+6nbqhh
         lnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=jlMjmCUClLgRkGDgN861wGxXsMK2HYMM+Br9VBYBldo=;
        b=IIlmbo26RkNrqI3/aaSOauZhFk5Q6oG+LsD7lOxE6vyHQ/kV8vaNb7FUiLf/H20uPU
         pURDhirM1p27VkZ74G1wHcgJBu/VUGi7bGgcIOwuP36Ks4XwQNgeIur/O9PG/OZScnEC
         hZYRd4zn0tD8VkcHAFow5bbeCZH/H9Bw717gs7yYoJRL20YzS6rhg6+CQ1UyyUiIKsaS
         w59ZyIH6CaeKrjIGRXJYmKNIws28+zuOs+GvamQzXXdx1tNSf7uh9Ytlc+X+SU5kW3ET
         MhdepyFn+UNhoOTKquZZUiVUjrEFgAI1Ue+sEip8uajQWEmO2iZJXqyPwE9ggicGpM7Y
         Vwqw==
X-Gm-Message-State: AOAM531FOYP3M+Q2f0N0d2l9Pj8MsgLi57r2loZbx1hmR4M0BX7cgCoh
        Z2e2Yq0J91eTZXcnVFTX/jXB0PVycaliAg==
X-Google-Smtp-Source: ABdhPJymRIy/opN1+VtndhSdOmIlpovG3xrd7mDQsKsV9zZtQLeu8jO73GFFRHKn0NOYV91pQt0x4Q==
X-Received: by 2002:aca:f0c6:0:b0:2d2:fd84:b994 with SMTP id o189-20020acaf0c6000000b002d2fd84b994mr9622075oih.102.1645411665626;
        Sun, 20 Feb 2022 18:47:45 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bf13sm4745136oib.32.2022.02.20.18.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 18:47:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 20 Feb 2022 18:47:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.17-rc4
Message-ID: <20220221024743.GA4097766@roeck-us.net>
References: <CAHk-=wgpOhU0cU+KZHA86OsoN2BxqT4ZoTMYHDMuzbiiiKK1Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgpOhU0cU+KZHA86OsoN2BxqT4ZoTMYHDMuzbiiiKK1Eg@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 12:29:27PM -0800, Linus Torvalds wrote:
> Things continue to look pretty normal for 5.17. Both the diffstat and
> the number of commits looks pretty much average for an rc4 release.
> 
> About half the changes being to drivers (all over, but as usual gpu
> and networking is a noticeable part of driver changes), with arch
> updates showing up next (devicetree updates dominate, but there's
> "real code" changes too).
> 
> Other than that, we've got filesystem fixes, core networking, tooling,
> and misc core kernel fixlets.
> 
> The appended shortlog gives details as usual, nothing in here looks worrisome.
> 

Build results:
	total: 155 pass: 152 fail: 3
Failed builds:
	mips:malta_defconfig
	powerpc:skiroot_defconfig
	sparc64:allmodconfig
Qemu test results:
	total: 488 pass: 427 fail: 61
Failed tests:
	arm:orangepi-pc:multi_v7_defconfig:usb1:net,nic:sun8i-h3-orangepi-pc:rootfs
	<almost all mips tests>

---

Building powerpc:skiroot_defconfig ... failed
--------------
arch/powerpc/kernel/stacktrace.c: In function 'handle_backtrace_ipi':
arch/powerpc/kernel/stacktrace.c:171:9: error: implicit declaration of function 'nmi_cpu_backtrace'

Introduced with commit 1614b2b11fab29 ("arch: Make ARCH_STACKWALK
independent of STACKTRACE"). Discussed at
https://lore.kernel.org/lkml/YeE2VWwHO50gFw9M@hirez.programming.kicks-ass.net/T/

Fixed with commit 5a72345e6a78 ("powerpc: Fix STACKTRACE=n build") in linux-next.

---
Building arm:orangepi-pc:multi_v7_defconfig:usb1:net,nic:sun8i-h3-orangepi-pc:rootfs ... running ........R.... failed (no root file system)

Introduced with 8df89a7cbc63 ("pinctrl-sunxi: don't call
pinctrl_gpio_direction()"). Fix posted at
https://patchwork.kernel.org/project/linux-media/patch/0f536cd8-01db-5d16-2cec-ec6d19409a49@xs4all.nl/
and in linux-next as commit 3c5412cdec9f ("pinctrl-sunxi:
sunxi_pinctrl_gpio_direction_in/output: use correct offset").
The fix exposes a lockdep splat for which a fix is posted at
https://lore.kernel.org/lkml/20220216040037.22730-1-samuel@sholland.org/

---
Building mips:malta_defconfig ... failed
------------
Error log:
net/netfilter/xt_socket.c: In function ‘socket_mt_destroy’:
net/netfilter/xt_socket.c:224:3: error: implicit declaration of function ‘nf_defrag_ipv6_disable’

This problem affects all configurations with IPV4 enabled and IPV6
disabled. Caused by commit 75063c9294fb2 ("netfilter: xt_socket: fix
a typo in socket_mt_destroy()"). Build failure reported by 0-day and
fix suggested at
https://lore.kernel.org/netdev/CANn89iLS4N4cpX+Nh9ALjf_APOPQ4-aSPSX1P6iLpda8mJS8UQ@mail.gmail.com/

Fix not posted as patch as far as I know.

---
Building sparc64:allmodconfig ... failed
--------------
Error log:
<stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
sparc64-linux-ld: drivers/memory/omap-gpmc.o: in function `gpmc_probe_generic_child':
omap-gpmc.c:(.text.unlikely+0x14c4): undefined reference to `of_platform_device_create'

Introduced by commit 4cd335dae3cf ("mtd: rawnand: omap2: Prevent invalid
configuration and build error"). Reported at
https://lore.kernel.org/lkml/20220219150836.GA1035394@roeck-us.net/T/#t
Fix posted at
https://lore.kernel.org/all/20220219193600.24892-1-rogerq@kernel.org/t/

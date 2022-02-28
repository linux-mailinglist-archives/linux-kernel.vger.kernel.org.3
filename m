Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA764C6099
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 02:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiB1BRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 20:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiB1BRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 20:17:07 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789BA5C36B
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 17:16:29 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so16582051ooi.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 17:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7/ANazmQRWPjWBpokxfHRpyBE2xUY/hh0dQYknwczs0=;
        b=hHP+bkaxMofR+din6Bhv27LdxA2CIjZCDaZ5b/7WLAvw3Jizi+yr63RM5H+waPdxNK
         PJhoZ21T9lM9S4K8SSu7GqoeKHAnW2zCyBnzj+oj2P9AzhyLU+889hfMIdXVNnX+xxf5
         T5pcfFOPS2AT6d/I5iSwvoUQT+7haiZse6HUBBXqCrOfqbXGbolefUsa0MOFU1/RMNaj
         16TUe85p31szJEd39XTmChGQ1rCHQtc78RGkPrZAE7ZXVvo6QpNRRSBSCwQUMpSGE5HW
         GoY+vyV2O+3VErcl30nttLZBs8NF0IjGcl0sJDybnE0LVhvy6hNzFtOJW4oSnA/s1Z7S
         /yEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7/ANazmQRWPjWBpokxfHRpyBE2xUY/hh0dQYknwczs0=;
        b=OZoL8m/4y3HswfrmrbVbFPIdPyHyHcgsj/oBDX4VNAhoGdraHkk+ZQ1JL5+yYA3Nzf
         W9cwOCntPF0gwx1Nh1+ZIPZQylOQ0rCk49BtW4ZCZyTBOwT+O9U/UsgXhlq4LCwxfEy+
         7ODM5yHgi8VB+p/OaOxxR4KwgpPaPcRMauYq4gOkzEqhcdVtTxwJYQi00oC7TLL7l6tP
         uZ8TGk8laQNSHF/r++TBC+t9WQ9x0hdUHaZYqSCB07pz4KG9WniGRWuay84RXnho6/4w
         Sf/cEDR2GltzzDthUHKEpCG4dpkXyrUy/e3S1YTgNAC/hWLxbaZYLtB4ZPY3gLpoEoLt
         cXEw==
X-Gm-Message-State: AOAM533jLWtIFbVaK98Z+yxHmw8AWiKLBeRqfm1YcHfR0K1tPcXRp7dn
        mD4Q8HPRdM/wggaTMJL0xPAha/B5WLs=
X-Google-Smtp-Source: ABdhPJwppnxPNjsGSZK8pl5PmE2h1mOm2/Qfj21OgeH8v7grXwNnxowjU9U/fBJO/GnMdUz+Muc+cA==
X-Received: by 2002:a05:6870:7815:b0:d7:2d72:28dd with SMTP id hb21-20020a056870781500b000d72d7228ddmr762708oab.61.1646010988760;
        Sun, 27 Feb 2022 17:16:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h3-20020a4aa9c3000000b003181c02e7ccsm4123573oon.47.2022.02.27.17.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 17:16:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 27 Feb 2022 17:16:26 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.17-rc6
Message-ID: <20220228011626.GA169657@roeck-us.net>
References: <CAHk-=wjWKEQUG2Z5a=2FGUfO5+choQ0jhszqyDmHfZoTXVJYJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjWKEQUG2Z5a=2FGUfO5+choQ0jhszqyDmHfZoTXVJYJQ@mail.gmail.com>
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

On Sun, Feb 27, 2022 at 03:00:26PM -0800, Linus Torvalds wrote:
> Nobody can claim that last week was *normal*, but whatever crazy
> things are going on in the world (and I personally had "Zombie
> apocalypse" on my bingo card, not "Putin has a mental breakdown"), it
> doesn't seem to have affected the kernel much.
> 
> Things continue to look normal both in commit numbers and in
> diffstats. We have the usual bulk being drivers (networking, gpu, iio,
> clk, and usb stand out, but there's a smattering of other stuff), with
> the rest being mixed. The only thing that stands out as a bit unusual
> is some further btrfs defrag fixes.  But even they stand out not so
> much because they are enormous, as just because they are bigger than
> most of the rest, which is pretty small.
> 
> Other notable areas: core networking, tracing, and selftests. As
> usual, details are in the appended shortlog.
> 
> While things look reasonably normal, we _are_ getting pretty late in
> the release, and we still have a number of known regressions. They
> don't seem all that big and scary, but some of them were reported
> right after the rc1 release, so they are getting a bit long in the
> tooth. I'd hate to have to delay 5.17 just because of them, and I'm
> starting to be a bit worried here. I think all the affected
> maintainers know who they are...
> 
> So if you are a subsystem maintainer, and you have one of those
> regressions on your list, please go make them a priority. And if you
> don't know what I'm talking about, please do look up the reports by
> regzbot and Guenter Roeck. I added links below to make it really easy.
> 
> But on the whole things look fine. Just a few remaining warts is all.
> But the more testing to verify, the better.
> 
>                Linus
> 
> https://lore.kernel.org/all/164598944963.346832.10219407090470852309@leemhuis.info/
> https://lore.kernel.org/all/20220221024743.GA4097766@roeck-us.net/
> 

Build results:
	total: 155 pass: 153 fail: 2
Failed builds:
	powerpc:skiroot_defconfig
	sparc64:allmodconfig
Qemu test results:
	total: 488 pass: 487 fail: 1
Failed tests:
	arm:orangepi-pc:multi_v7_defconfig:usb1:net,nic:sun8i-h3-orangepi-pc:rootfs

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
Building sparc64:allmodconfig ... failed
--------------
Error log:
<stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
sparc64-linux-ld: drivers/memory/omap-gpmc.o: in function `gpmc_probe_generic_child':
omap-gpmc.c:(.text.unlikely+0x14c4): undefined reference to `of_platform_device_create'

Introduced by commit 4cd335dae3cf ("mtd: rawnand: omap2: Prevent invalid
configuration and build error").
Reported: https://lore.kernel.org/lkml/20220219150836.GA1035394@roeck-us.net/T/#t
Fix: https://patchwork.ozlabs.org/project/linux-mtd/patch/20220219193600.24892-1-rogerq@kernel.org/

Guenter

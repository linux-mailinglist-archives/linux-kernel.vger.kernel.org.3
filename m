Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11716549C23
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242610AbiFMStK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345661AbiFMSse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:48:34 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCFD6B0B9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:46:42 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso6359285pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0oMsZUdX7QBDUeBrNm/sP+J3C89hNojWjZGJeo5/1Dw=;
        b=ftHc2uarMQSmfELWVIaFl3k1WRxhaT9KN93JMzqqxeZAq8ddH+gTYc7S+eyU52XkxM
         /P9ZiyKLlzci7mMnBLEgSPFAn3DtwqNaMYEhtFhLWxEG2HWk2szPqOyOi+ySu23wWcoH
         k43Gjt2tGZEEXCSiuWH9NOyqrI8u3Ipda6gVgR10pxxMWErWYj6erGUNCk4I544iY2oN
         81M5R6UWGeqAUzWnUaRAEPpAYYQo2050U/kWZZjKnIXT1Uga/TgERl07Lck5TLgZI4N4
         MPklKEE/uI0VZbIBSYOahPiz67u7JqPaEw5wDTjEsrSz5HxY+bQra3DllM5jUXUa7BUc
         /tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0oMsZUdX7QBDUeBrNm/sP+J3C89hNojWjZGJeo5/1Dw=;
        b=5Zk9o+hzDuiUeHS49ELjMw/FMtVIOwk1IYTjdqtLmPbe0fl7KrI32BQ6XK9kN3gNSg
         WrtB7M41hsqQ63L6kBBM0RYPiCmJplnISsssJoBHT8R0QyCTi2EyFT3V+XT3TqHn243b
         xQZVLTl6S5wq72jAvlYaB6+RGwccARJvgQyMen9y44srrWRKLrpm2T7RFlEqUGHmdNbT
         zm6WwUzP7NQWJu1VNm2CxHPmeDVuKFprxM0DVgkr9L/ox/YDTGahLPtqsc8ElM6CmgRR
         KPWOwPX2i6On1+w8UGUYr5VnkMsDiWH+X8W82rFm/sgLAs5WDZArwEsm32re8YchOgHP
         prfg==
X-Gm-Message-State: AJIora+r6FybLfG6vLreopgRd/euPkEcRqkCJggJHZ7upKW+ddGWZX9P
        VpL0oUGCdYc/wRKOfHz0BWlNbxCqZ+A=
X-Google-Smtp-Source: AGRyM1sZ5FLejULCQGnqhuRhwUqc7/pR77wUYgwFIcr+0YWGCaSExHJQ0fym76CKY18M4f1YUx8C7A==
X-Received: by 2002:a17:90a:86c8:b0:1e6:7147:8b4d with SMTP id y8-20020a17090a86c800b001e671478b4dmr423988pjv.45.1655135201999;
        Mon, 13 Jun 2022 08:46:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 10-20020a62150a000000b0050dc76281d3sm5729558pfv.173.2022.06.13.08.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 08:46:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 13 Jun 2022 08:46:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.19-rc2
Message-ID: <20220613154640.GA3881687@roeck-us.net>
References: <CAHk-=wiLDbZ9ch9vSLxrYBdr-bBujr5sehH_HszWzSah54UiQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiLDbZ9ch9vSLxrYBdr-bBujr5sehH_HszWzSah54UiQw@mail.gmail.com>
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

On Sun, Jun 12, 2022 at 04:36:20PM -0700, Linus Torvalds wrote:
> It's Sunday afternoon, so it must be time for another release candidate.
> 
> As usual, rc2 is fairly small, and there isn't really a ton going on
> here. Fixes spread all over, and the diffstat is fairly flat apart
> from a few notable things that had bigger changes: some amdgpu fixes,
> the xen stub iommu driver, and some ceph and zonefs fixes. The rest is
> all pretty much one- or few-liners spread out mostly everywhere.
> 
> And yes, because I expected the rc2 week to be fairly quiet, I did a
> system update on my workstation, and as a result I spent a day or two
> then sorting out most of the fallout from the resulting compiler
> upgrade to gcc-12. Some of it ended up being a bit heavy-handed, and
> we'll be tweaking things further. And some of it ends up being an
> actual compiler misfeature, but it's being discussed too and is
> limited to just one file on the 32-bit i386 side (and does not seem to
> result in any actual bad code, just excessive stack use).
> 
> Anyway, nothing hugely scary going on, let's just keep testing and
> fixing things.
> 

Build results:
	total: 149 pass: 146 fail: 3
Failed builds:
	arm:allmodconfig
	mips:loongson2k_defconfig
	powerpc:allmodconfig
Qemu test results:
	total: 489 pass: 489 fail: 0

---
arm:allmodconfig

ERROR: modpost: missing MODULE_LICENSE() in drivers/watchdog/gxp-wdt.o

The fix is in -next, so hopefully Wim will send a pull request soon.

---
mips:loongson2k_defconfig

drivers/irqchip/irq-loongson-liointc.c: In function 'liointc_chained_handle_irq':
drivers/irqchip/irq-loongson-liointc.c:60:20: error: implicit declaration of function 'cpu_logical_map'

Caused by commit fa84f89395e03 ("irqchip/loongson-liointc: Fix build error for LoongArch").

---
powerpc:allmodconfig

Error: External symbol 'memset' referenced from prom_init.c
powerpc64-linux-ld:
	drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o uses hard float,
	drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.o uses soft float
and similar errors. No change since last week.

---
Runtime warning:

OF: amba_device_add() failed (-19) for /amba/smc@10100000
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at lib/refcount.c:28 of_platform_bus_create+0x33c/0x3dc
refcount_t: underflow; use-after-free.

Fixed in -next.

There are also various UAF and "spinlock bad magic" BUG/WARNING logs in arm
boot tests. I don't know if those are new or if I just see them now because
I enabled KFENCE. Here is an (incomplete) sample.

[    0.430290] printk: console [ramoops-1] printing thread started
[    0.436219] BUG: spinlock bad magic on CPU#0, kdevtmpfs/23
[    0.436250]  lock: noop_backing_dev_info+0x6c/0x3b0, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
[    0.436808] CPU: 0 PID: 23 Comm: kdevtmpfs Not tainted 5.19.0-rc2 #1

---

[    7.918940] ------------[ cut here ]------------
[    7.919062] WARNING: CPU: 0 PID: 0 at kernel/smp.c:913 smp_call_function_many_cond+0x38c/0x3a4
[    7.919875] Modules linked in:
[    7.920155] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc2 #1
[    7.920248] Hardware name: ARM-Versatile Express
[    7.920458]  unwind_backtrace from show_stack+0x10/0x14
[    7.920549]  show_stack from dump_stack_lvl+0x50/0x6c
[    7.920585]  dump_stack_lvl from __warn+0xcc/0x19c
[    7.920614]  __warn from warn_slowpath_fmt+0x5c/0xb4
[    7.920644]  warn_slowpath_fmt from smp_call_function_many_cond+0x38c/0x3a4
[    7.920674]  smp_call_function_many_cond from smp_call_function+0x3c/0x50
[    7.920702]  smp_call_function from set_memory_valid+0x74/0x94
[    7.920733]  set_memory_valid from kfence_guarded_free+0x280/0x4bc
[    7.920767]  kfence_guarded_free from kmem_cache_free+0x2f4/0x394

I'll try to bisect as I find the time.

Guenter

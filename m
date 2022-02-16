Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49794B7F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 05:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343698AbiBPE04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 23:26:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbiBPE0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:26:51 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893A1B86E;
        Tue, 15 Feb 2022 20:26:39 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id e19-20020a4ab993000000b0031a98fe3a9dso563432oop.6;
        Tue, 15 Feb 2022 20:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LT0nFgfu58iECyaHltrzdhXTd+LwZiIDPIbmP9t/t9o=;
        b=ivR6LRRUrRUqhges/nGaYsw1UOA96T1jPn1qxGbWmBPiz2uW/K2qljiopqaeCrzZPT
         WSsOHbQ+SOSlLhRIzELZ4OZq2QAsJT9PT43jnwOselJD7nQsOOU8NwVwOMCt3ME66/F7
         p/3Ho5xc66S811J1YoQTrtpBVUFZU8ervzUD5OEaG5IquwxDJtUYqREJDJvwBM3deNAC
         y5r665Qyb43YPPP4EEgOzK6/vBseYOmDPm256syo1R5i6brs0GEdcOsG34cO1Y82fmPo
         n857J+spdkvVmcyAAMq4KdouteiMJvFMQ/w6FcJZ5kOHPl7ucgdENTT5HxNy1A9ElgDH
         MzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LT0nFgfu58iECyaHltrzdhXTd+LwZiIDPIbmP9t/t9o=;
        b=TYTElU53HC7iyHEWXic+nAzNgHPq8nf4s3R+7iO070iBTrVzzVR0oH8mx7HnEZOFNF
         Y2MhNJFG4yEPtWRe/fVT0Y9L2DVbmiJlU9a9DUKO9wI6aofBf2mvlUU3Ss40vvrwxpvr
         hKdDWFo5OVmK/2uwhkW2sNPiPHz5HUK4qHmrvzjeYaraoGZwo+IBpuCZTflOyxU+yS5v
         pOUTP3nGIvGExw4uIPhIlFjpd4pibDueyZQueCYxQZtxf0jLW0KN3vOMz1QQpE42XcWV
         MRBaIbOztCRpKPw8c297i/TaXFdw3fu67HXwO4mgquCMfhDOKSHwgYsjV3eP0iL8WL8A
         ly/Q==
X-Gm-Message-State: AOAM5302IjhGj/7i82yQ2lcQfQn3sZNuiiHvrREp9yOVdRksEd1V+gj7
        MA3N7f7yB8KcyqKRvzqSkOw=
X-Google-Smtp-Source: ABdhPJzyD3GOhI4bv3I4PQ2oQYbNvToBTGMJaqoncptwGkOgDGQeU3ShnblQe7wT9dXLowkD1EX7TA==
X-Received: by 2002:a05:6870:c21e:b0:d1:4378:7c14 with SMTP id z30-20020a056870c21e00b000d143787c14mr2544337oae.268.1644985598931;
        Tue, 15 Feb 2022 20:26:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d7sm14264348otf.66.2022.02.15.20.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 20:26:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 15 Feb 2022 20:26:37 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: sunxi: Use unique lockdep classes for IRQs
Message-ID: <20220216042637.GB63304@roeck-us.net>
References: <20220216040037.22730-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216040037.22730-1-samuel@sholland.org>
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

On Tue, Feb 15, 2022 at 10:00:36PM -0600, Samuel Holland wrote:
> This driver, like several others, uses a chained IRQ for each GPIO bank,
> and forwards .irq_set_wake to the GPIO bank's upstream IRQ. As a result,
> a call to irq_set_irq_wake() needs to lock both the upstream and
> downstream irq_desc's. Lockdep considers this to be a possible deadlock
> when the irq_desc's share lockdep classes, which they do by default:
> 
>  ============================================
>  WARNING: possible recursive locking detected
>  5.17.0-rc3-00394-gc849047c2473 #1 Not tainted
>  --------------------------------------------
>  init/307 is trying to acquire lock:
>  c2dfe27c (&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_lock+0x58/0xa0
> 
>  but task is already holding lock:
>  c3c0ac7c (&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_lock+0x58/0xa0
> 
>  other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(&irq_desc_lock_class);
>    lock(&irq_desc_lock_class);
> 
>   *** DEADLOCK ***
> 
>   May be due to missing lock nesting notation
> 
>  4 locks held by init/307:
>   #0: c1f29f18 (system_transition_mutex){+.+.}-{3:3}, at: __do_sys_reboot+0x90/0x23c
>   #1: c20f7760 (&dev->mutex){....}-{3:3}, at: device_shutdown+0xf4/0x224
>   #2: c2e804d8 (&dev->mutex){....}-{3:3}, at: device_shutdown+0x104/0x224
>   #3: c3c0ac7c (&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_lock+0x58/0xa0
> 
>  stack backtrace:
>  CPU: 0 PID: 307 Comm: init Not tainted 5.17.0-rc3-00394-gc849047c2473 #1
>  Hardware name: Allwinner sun8i Family
>   unwind_backtrace from show_stack+0x10/0x14
>   show_stack from dump_stack_lvl+0x68/0x90
>   dump_stack_lvl from __lock_acquire+0x1680/0x31a0
>   __lock_acquire from lock_acquire+0x148/0x3dc
>   lock_acquire from _raw_spin_lock_irqsave+0x50/0x6c
>   _raw_spin_lock_irqsave from __irq_get_desc_lock+0x58/0xa0
>   __irq_get_desc_lock from irq_set_irq_wake+0x2c/0x19c
>   irq_set_irq_wake from irq_set_irq_wake+0x13c/0x19c
>     [tail call from sunxi_pinctrl_irq_set_wake]
>   irq_set_irq_wake from gpio_keys_suspend+0x80/0x1a4
>   gpio_keys_suspend from gpio_keys_shutdown+0x10/0x2c
>   gpio_keys_shutdown from device_shutdown+0x180/0x224
>   device_shutdown from __do_sys_reboot+0x134/0x23c
>   __do_sys_reboot from ret_fast_syscall+0x0/0x1c
> 
> However, this can never deadlock because the upstream and downstream
> IRQs are never the same (nor do they even involve the same irqchip).
> 
> Silence this erroneous lockdep splat by applying what appears to be the
> usual fix of moving the GPIO IRQs to separate lockdep classes.
> 
> Fixes: a59c99d9eaf9 ("pinctrl: sunxi: Forward calls to irq_set_irq_wake")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
> 
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> index 80d6750c74a6..9e6ed1175db3 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -36,6 +36,13 @@
>  #include "../core.h"
>  #include "pinctrl-sunxi.h"
>  
> +/*
> + * These lock classes tell lockdep that GPIO IRQs are in a different
> + * category than their parents, so it won't report false recursion.
> + */
> +static struct lock_class_key sunxi_pinctrl_irq_lock_class;
> +static struct lock_class_key sunxi_pinctrl_irq_request_class;
> +
>  static struct irq_chip sunxi_pinctrl_edge_irq_chip;
>  static struct irq_chip sunxi_pinctrl_level_irq_chip;
>  
> @@ -1555,6 +1562,8 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
>  	for (i = 0; i < (pctl->desc->irq_banks * IRQ_PER_BANK); i++) {
>  		int irqno = irq_create_mapping(pctl->domain, i);
>  
> +		irq_set_lockdep_class(irqno, &sunxi_pinctrl_irq_lock_class,
> +				      &sunxi_pinctrl_irq_request_class);
>  		irq_set_chip_and_handler(irqno, &sunxi_pinctrl_edge_irq_chip,
>  					 handle_edge_irq);
>  		irq_set_chip_data(irqno, pctl);
> -- 
> 2.33.1
> 

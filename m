Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3E34F621B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbiDFOpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbiDFOpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:45:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5B24DD304
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:13:06 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r13so2660206wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 04:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MnL+COforuI2mXVei9ggdp/9GCBflkVmkK2tnNbkORE=;
        b=WogqXOtHmpNavMU6fgnNTtNhMll8ksJckzg5pRKIjy1wJk9LJ91HHtR+sdml7gEWAL
         Ql8KGhpvB30TO2NPFcw6tiU8WZkDAztq4owHCSTr4urg4riJoRqukgGwL6cHgrZPRvj1
         tGrsaC9iBlXhh9FjNBdbU4sOQjWSWUoHSy6cOKEU7wAnM9ERWlZzUxOzrZdUeyup1o21
         8XukPydCC1ot+ry6QyNH6VmZ51ghtz1SVeMWZhHE3ewVQKSu3QjA2SWxNH3b6On3awE9
         MQ3KMKbjFZ2+AZ7kyTzAqbrWrO5TYJxySL/qAblfeieKz3DDyJ5KXZzqlYmPZi8g0VEw
         GTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MnL+COforuI2mXVei9ggdp/9GCBflkVmkK2tnNbkORE=;
        b=n35ULkg1VGJVcDl/AUTzsONm7It89q8FP67ToWcEjpkZPMJZGQYN+FeNgoQsQjYOc8
         QCplYe1mg1DFLS/r8Hcas2DvZsoQfRiX9oFKbJWkBXrligNJEWWgDIsMAVHzCH4oEPqh
         Jp+weqOPq1rwgUCTM4G8qbAlNCviE/Jm78BIqTfNmuAT/XiCclQWD5JfzR0hD9v8z8S4
         BmgOfnqhBPaoV3F9KdRrowyjAslta6YM1mHsDMVCg3yLf9rAzH+9fcpLdbOL9JvYDnRW
         CR/GIknFSTFa93RLNJUGcu3ZB/ukTr2YDlr6JjW6KE38zcU1JswBPqj2j0g/6rZsfi5n
         Zqfg==
X-Gm-Message-State: AOAM530mEqis/oOGyzLm2bSCHwDVQWhQ+0SyikDVOvD0riQ1UAtyswnP
        Gzwj10wnu5NQc2N3A2dCnuryWQ==
X-Google-Smtp-Source: ABdhPJyftIDm4RY1LVdNO6e9NiQqyhsq5OA2Hm3algbuYwG8QOymjxEyEGBde5xyucOsMT3SA69Fbg==
X-Received: by 2002:a5d:59ad:0:b0:205:a66c:3c2a with SMTP id p13-20020a5d59ad000000b00205a66c3c2amr6137224wrr.289.1649243585126;
        Wed, 06 Apr 2022 04:13:05 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:261f:c14c:d23b:d177? ([2a01:e34:ed2f:f020:261f:c14c:d23b:d177])
        by smtp.googlemail.com with ESMTPSA id g16-20020a05600c4ed000b0038ceb0b21b4sm5781204wmq.24.2022.04.06.04.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 04:13:04 -0700 (PDT)
Message-ID: <09d1fcda-c704-5a20-e567-b80c1ee16f1e@linaro.org>
Date:   Wed, 6 Apr 2022 13:13:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 04/10] clocksource/drivers: Add HPE GXP timer
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
 <20220310195229.109477-4-nick.hawkins@hpe.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220310195229.109477-4-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2022 20:52, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Add support for the HPE GXP SOC timer. The GXP supports several
> different kinds of timers but for the purpose of this driver there
> is only support for the General Timer. The timer has a 1us
> resolution and is 32 bits.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>   drivers/clocksource/Kconfig     |   8 ++
>   drivers/clocksource/Makefile    |   1 +
>   drivers/clocksource/gxp-timer.c | 159 ++++++++++++++++++++++++++++++++
>   3 files changed, 168 insertions(+)
>   create mode 100644 drivers/clocksource/gxp-timer.c

Please for the sake of consistency, rename the timer to timer-qxp.c


> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index cfb8ea0df3b1..5916dade7608 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -617,6 +617,14 @@ config CLKSRC_ST_LPC
>   	  Enable this option to use the Low Power controller timer
>   	  as clocksource.
>   
> +config GXP_TIMER
> +	bool "GXP timer driver"
> +	depends on ARCH_HPE
> +	default y
> +	help
> +	  Provides a driver for the timer control found on HPE
> +	  GXP SOCs. This is required for all GXP SOCs.

Regarding the silent option:

  https://www.spinics.net/lists/arm-kernel/msg936976.html

>   config ATCPIT100_TIMER
>   	bool "ATCPIT100 timer driver"
>   	depends on NDS32 || COMPILE_TEST
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index fa5f624eadb6..dbfb8c56a8a0 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -89,3 +89,4 @@ obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
>   obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
>   obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
>   obj-$(CONFIG_MSC313E_TIMER)		+= timer-msc313e.o
> +obj-$(CONFIG_GXP_TIMER)			+= gxp-timer.o
> diff --git a/drivers/clocksource/gxp-timer.c b/drivers/clocksource/gxp-timer.c
> new file mode 100644
> index 000000000000..a24cd1cc5c04
> --- /dev/null
> +++ b/drivers/clocksource/gxp-timer.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P.*/
> +
> +#include <linux/bitops.h>
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqreturn.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
This header is not needed.

> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/sched_clock.h>
> +
> +#include <asm/irq.h>

This header is not needed AFAICT.

Please double check the headers above are all needed.

> +#define TIMER0_FREQ	1000000
> +
> +/*TCS Stands for Timer Control/Status: these are masks to be used in*/
> +/* the Timer Count Registers */
> +#define MASK_TCS_ENABLE	0x01
> +#define MASK_TCS_PERIOD	0x02
> +#define MASK_TCS_RELOAD	0x04
> +#define MASK_TCS_TC	0x80
> +
> +struct gxp_timer {
> +	void __iomem *counter;
> +	void __iomem *control;
> +	struct clock_event_device evt;
> +};
> +
> +static void __iomem *system_clock __read_mostly;
> +
> +static inline struct gxp_timer *to_gxp_timer(struct clock_event_device *evt_dev)
> +{
> +	return container_of(evt_dev, struct gxp_timer, evt);
> +}
> +
> +static u64 notrace gxp_sched_read(void)
> +{
> +	return readl_relaxed(system_clock);
> +}
> +
> +static int gxp_time_set_next_event(unsigned long event,
> +								struct clock_event_device *evt_dev)
> +{
> +	struct gxp_timer *timer = to_gxp_timer(evt_dev);

nit: add a line to separate the declaration and the code below.

> +	/* Stop counting and disable interrupt before updating */
> +	writeb_relaxed(MASK_TCS_TC, timer->control);
> +	writel_relaxed(event, timer->counter);
> +	writeb_relaxed(MASK_TCS_TC | MASK_TCS_ENABLE, timer->control);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t gxp_time_interrupt(int irq, void *dev_id)

	s/gxp_time/gxp_timer/

> +{
> +	struct gxp_timer *timer = dev_id;
> +	void (*event_handler)(struct clock_event_device *timer);
> +
> +	if (!(readb_relaxed(timer->control) & MASK_TCS_TC))
> +		return IRQ_NONE;
> +
> +	writeb_relaxed(MASK_TCS_TC, timer->control);
> +
> +	event_handler = READ_ONCE(timer->evt.event_handler);
> +	event_handler(&timer->evt);

Why READ_ONCE ?

Do timer->evt.event_handler();

Or alternatively pass the request_irq() &timer->evt and use to_gxp_timer()

> +	return IRQ_HANDLED;
> +}
> +
> +static int __init gxp_timer_init(struct device_node *node)
> +{
> +	void __iomem *base_counter;
> +	void __iomem *base_control;
> +	u32 freq;
> +	int ret, irq;
> +	struct gxp_timer *gxp_timer;
> +
> +	base_counter = of_iomap(node, 0);
> +	if (!base_counter) {
> +		pr_err("Can't remap counter registers");
> +		ret = -ENXIO;
> +		return ret;

		return -ENXIO;

> +	}
> +
> +	base_control = of_iomap(node, 1);
> +	if (!base_control) {
> +		pr_err("Can't remap control registers");
> +		ret = -ENXIO;
> +		goto err_iounmap;



> +	}
> +
> +	system_clock = of_iomap(node, 2);
> +	if (!system_clock) {
> +		pr_err("Can't remap control registers");
> +		ret = -ENXIO;
> +		goto err_iounmap;
> +	}
> +
> +	if (of_property_read_u32(node, "clock-frequency", &freq)) {
> +		pr_err("Can't read clock-frequency\n");
> +		ret = -EIO;
> +		goto err_iounmap;
> +	}
> +
> +	sched_clock_register(gxp_sched_read, 32, freq);
> +	clocksource_mmio_init(system_clock, node->name, freq,
> +				300, 32, clocksource_mmio_readl_up);
> +
> +	irq = irq_of_parse_and_map(node, 0);
> +	if (irq <= 0) {
> +		ret = -EINVAL;
> +		pr_err("GXP Timer Can't parse IRQ %d", irq);
> +		goto err_iounmap;
> +	}
> +
> +	gxp_timer = kzalloc(sizeof(*gxp_timer), GFP_KERNEL);
> +	if (!gxp_timer) {
> +		ret = -ENOMEM;
> +		goto err_iounmap;
> +	}
> +
> +	gxp_timer->counter = base_counter;
> +	gxp_timer->control = base_control;
> +	gxp_timer->evt.name = node->name; > +	gxp_timer->evt.rating = 300;
> +	gxp_timer->evt.features = CLOCK_EVT_FEAT_ONESHOT;
> +	gxp_timer->evt.set_next_event = gxp_time_set_next_event;
> +	gxp_timer->evt.cpumask = cpumask_of(0);
> +

	ret = request_irq();

> +	if (request_irq(irq, gxp_time_interrupt, IRQF_TIMER | IRQF_SHARED,
> +			node->name, gxp_timer)) {
> +		ret = -EIO;

		Remove above ret = -EIO;

> +		pr_err("%s: request_irq() failed\n", "GXP Timer Tick");
> +		goto err_timer_free;
> +	}
> +
> +	clockevents_config_and_register(&gxp_timer->evt, TIMER0_FREQ,
> +					0xf, 0xffffffff);
> +
> +	pr_info("gxp: system timer (irq = %d)\n", irq);

	s/pr_info/pr_debug/

> +	return 0;
> +
> +
> +err_timer_free:
> +	kfree(gxp_timer);
> +
> +err_iounmap:
> +	iounmap(system_clock);
> +	iounmap(base_control);
> +	iounmap(base_counter);
> +	return ret;
> +}
> +
> +TIMER_OF_DECLARE(gxp, "hpe,gxp-timer", gxp_timer_init);


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

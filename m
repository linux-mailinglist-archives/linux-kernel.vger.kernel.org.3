Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC6849D081
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243632AbiAZROy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:14:54 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:40075 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243627AbiAZROw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:14:52 -0500
Received: from [192.168.100.1] ([82.142.25.174]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N7xml-1m92CK44vr-014y4F; Wed, 26 Jan 2022 18:14:24 +0100
Message-ID: <1bc0bf2d-49c6-3f68-bc35-919b2a1e4cfc@vivier.eu>
Date:   Wed, 26 Jan 2022 18:14:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: fr
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <john.stultz@linaro.org>
References: <20220121200738.2577697-1-laurent@vivier.eu>
 <20220121200738.2577697-5-laurent@vivier.eu>
 <2dc495b0-b9a1-e493-ddeb-d966afd624c0@linaro.org>
From:   Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v12 4/5] clocksource/drivers: Add a goldfish-timer
 clocksource
In-Reply-To: <2dc495b0-b9a1-e493-ddeb-d966afd624c0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TSngsJf/7ICXuJGzytnz6JqiIjFf/27jh1/ag3P2TXE4eeydH1H
 o6DvpVjIhKoHkhleSt4AsHX2CMeZ0ZLZzf7+ZoBXBWuoAYl7N4LeLxscWP5c4wNYh+2gX5A
 QTsJ5qRiIcIp1N5Nu5ZPtZiHN6ehKKpaysWdvyggpllc8zvVlkBg3DfSoduZ8bGfQHoo0qc
 dDrOzyByeT2mXlHM0SHKA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yrRrKUG4n78=:4xlhW6p0ePou239EOh6IHz
 bDcc1P8KFjRnw1MkyXraA7Tv44+KiZWec3UWDyFaNk0LBtl4xb43q6PyAOq7EyKCP9yu8y1w5
 WryUasYoRu2xT8PBjawPHbh4lvyx8hR0CpWuVOAtVhnuK7VKeNwM66EPJmNj6UxrGZaD3VXEY
 AM5FV8Fb1KRHHsNTFkpYVx7aeiejm8h/PQ9YHe45nCMUEgF0Ws1ISsGJnVe7wetL+qVlN+BJ1
 gEl4hQgoniJaV/xRBo06CMkFYyWwt+x7CbgIsSTagwEYm/Vaw0ZkP5ysfOBx1Rxnufzi0dgOD
 PRsRUiKgM0dopLLGxL4C8AfUmz0UDMmhXfmHZuSdQDx5hB55/aADSM2atoqbWHbxKhdAT0L45
 YT0ePmQS4WbKtiMSKx3qeOeYo4dSkFR4l3VLMM/6WyWRHnxXUvwxPKWezvaCFXkCZa5avMQSD
 6ahbyEeFebNnYGuyEYGBZBU4LI1wLEmFl36oTvkBZ4U68gyJqSdp4ms61fTMP5EVPOh5Uwtrl
 x92m8Ewj4MunuG594nr1wH5hNBlFskXqNX+mCXy5jxp3eIgZAqDObgsTN65joigBuLvRT+LzW
 s7jBTXDTiFgHvOCGHSFJWDfwBgy6+i/0bH6oSLtTwIQ4gFQ1sKApPDiY+RcThZ2lGpxXF22qy
 hd7MSeU2fxGfUIEQ58Y8mN6w09HLqJhmSqH7U94OQFs/OzNRK3AuTJrjsK5XjlBEFavQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/01/2022 à 12:55, Daniel Lezcano a écrit :
> 
> Hi Laurent,
> 

Hi Daniel,

> On 21/01/2022 21:07, Laurent Vivier wrote:
>> Add a clocksource based on the goldfish-rtc device.
> 
> As a first submission, please provide a more detailed description of the
> timer.

ok.

The timer uses in fact the goldifsh RTC clock so I supposed refering to drivers/rtc/rtc-goldfish.c 
could give the missing pieces of information

>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>   drivers/clocksource/Kconfig          |   7 ++
>>   drivers/clocksource/Makefile         |   1 +
>>   drivers/clocksource/timer-goldfish.c | 163 +++++++++++++++++++++++++++
>>   include/clocksource/timer-goldfish.h |  11 ++
>>   4 files changed, 182 insertions(+)
>>   create mode 100644 drivers/clocksource/timer-goldfish.c
>>   create mode 100644 include/clocksource/timer-goldfish.h
>>
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index cfb8ea0df3b1..94f00374cebb 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -721,4 +721,11 @@ config MICROCHIP_PIT64B
>>   	  modes and high resolution. It is used as a clocksource
>>   	  and a clockevent.
>>   
>> +config GOLDFISH_TIMER
>> +	bool "Clocksource using goldfish-rtc"
>> +	depends on M68K || COMPILE_TEST
>> +	depends on RTC_DRV_GOLDFISH
>> +	help
>> +	  Support for the timer/counter of goldfish-rtc
>> +
>>   endmenu
>> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
>> index fa5f624eadb6..12f5d7e8cc2d 100644
>> --- a/drivers/clocksource/Makefile
>> +++ b/drivers/clocksource/Makefile
>> @@ -89,3 +89,4 @@ obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
>>   obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
>>   obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
>>   obj-$(CONFIG_MSC313E_TIMER)		+= timer-msc313e.o
>> +obj-$(CONFIG_GOLDFISH_TIMER)		+= timer-goldfish.o
>> diff --git a/drivers/clocksource/timer-goldfish.c b/drivers/clocksource/timer-goldfish.c
>> new file mode 100644
>> index 000000000000..4c670a1aea16
>> --- /dev/null
>> +++ b/drivers/clocksource/timer-goldfish.c
>> @@ -0,0 +1,163 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/ioport.h>
>> +#include <linux/clocksource.h>
>> +#include <linux/clockchips.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/goldfish.h>
>> +#include <clocksource/timer-goldfish.h>
>> +
>> +#define TIMER_TIME_LOW		0x00	/* get low bits of current time  */
>> +					/*   and update TIMER_TIME_HIGH  */
>> +#define TIMER_TIME_HIGH		0x04	/* get high bits of time at last */
>> +					/*   TIMER_TIME_LOW read         */
>> +#define TIMER_ALARM_LOW		0x08	/* set low bits of alarm and     */
>> +					/*   activate it                 */
>> +#define TIMER_ALARM_HIGH	0x0c	/* set high bits of next alarm   */
> 
> Thanks for the comments giving the update details of the register.
> However the format is not very easy to read. I suggest to add these
> information in the log or above the macros being a bit more verbose
> 
> /*
>   * bla bla
>   */

In fact, I copied them from drivers/rtc/rtc-goldfish.c but I can update this as you say.


>> +#define TIMER_IRQ_ENABLED	0x10
>> +#define TIMER_CLEAR_ALARM	0x14
>> +#define TIMER_ALARM_STATUS	0x18
>> +#define TIMER_CLEAR_INTERRUPT	0x1c
>> +
>> +struct goldfish_timer {
>> +	struct clocksource cs;
>> +	struct clock_event_device ced;
>> +	struct resource res;
>> +	void __iomem *base;
>> +	int irq;
> 
> 'res' and 'irq' can be local variable in the init function, they are not
> used anywhere else

I agree for irq, but res is passed to request_resource() and I think it is added to a linked tree, 
so I'm not sure it can be local to the function.

Do you mean a "static" declaration in the function?

> 
>> +};
>> +
>> +static struct goldfish_timer *ced_to_gf(struct clock_event_device *ced)
>> +{
>> +	return container_of(ced, struct goldfish_timer, ced);
>> +}
>> +
>> +static struct goldfish_timer *cs_to_gf(struct clocksource *cs)
>> +{
>> +	return container_of(cs, struct goldfish_timer, cs);
>> +}
>> +
>> +static u64 goldfish_timer_read(struct clocksource *cs)
>> +{
>> +	struct goldfish_timer *timerdrv = cs_to_gf(cs);
>> +	void __iomem *base = timerdrv->base;
>> +	u32 time_low, time_high;
>> +	u64 ticks;
>> +
>> +	/*
>> +	 * time_low: get low bits of current time and update time_high
>> +	 * time_high: get high bits of time at last time_low read
>> +	 */
>> +	time_low = gf_ioread32(base + TIMER_TIME_LOW);
>> +	time_high = gf_ioread32(base + TIMER_TIME_HIGH);
>> +
>> +	ticks = ((u64)time_high << 32) | time_low;
>> +
>> +	return ticks;
>> +}
>> +
>> +static int goldfish_timer_set_oneshot(struct clock_event_device *evt)
>> +{
>> +	struct goldfish_timer *timerdrv = ced_to_gf(evt);
>> +	void __iomem *base = timerdrv->base;
>> +
>> +	gf_iowrite32(0, base + TIMER_ALARM_HIGH);
>> +	gf_iowrite32(0, base + TIMER_ALARM_LOW);
>> +	gf_iowrite32(1, base + TIMER_IRQ_ENABLED);
>> +
>> +	return 0;
>> +}
>> +
>> +static int goldfish_timer_shutdown(struct clock_event_device *evt)
>> +{
>> +	struct goldfish_timer *timerdrv = ced_to_gf(evt);
>> +	void __iomem *base = timerdrv->base;
>> +
>> +	gf_iowrite32(0, base + TIMER_IRQ_ENABLED);
>> +
>> +	return 0;
>> +}
>> +
>> +static int goldfish_timer_next_event(unsigned long delta,
>> +				     struct clock_event_device *evt)
>> +{
>> +	struct goldfish_timer *timerdrv = ced_to_gf(evt);
>> +	void __iomem *base = timerdrv->base;
>> +	u64 now;
>> +
>> +	now = goldfish_timer_read(&timerdrv->cs);
>> +
>> +	now += delta;
>> +
>> +	gf_iowrite32(upper_32_bits(now), base + TIMER_ALARM_HIGH);
>> +	gf_iowrite32(lower_32_bits(now), base + TIMER_ALARM_LOW);
>> +
>> +	return 0;
>> +}
>> +
>> +static irqreturn_t golfish_timer_tick(int irq, void *dev_id)
> 
> "timer_tick" will be confusing with "scheduler timer tick". Please
> rename it to (eg. goldfish_timer_irq)
> 
> Note: the function name 'golfish' instead of 'goldfish'

ok

> 
>> +{
>> +	struct clock_event_device *evt = dev_id;
>> +	struct goldfish_timer *timerdrv = ced_to_gf(evt);
>> +	void __iomem *base = timerdrv->base;
>> +
>> +	gf_iowrite32(1, base + TIMER_CLEAR_INTERRUPT);
>> +
>> +	evt->event_handler(evt);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +void __init goldfish_timer_init(int irq, void __iomem *base)
> 
> Error handling please
> 
> int __init goldfish_timer_init(...)

ok

> 
>> +{
>> +	struct goldfish_timer *timerdrv;
>> +	int ret;
>> +
>> +	timerdrv = kzalloc(sizeof(*timerdrv), GFP_KERNEL);
>> +	if (!timerdrv)
>> +		return;
>> +
>> +	timerdrv->base = base;
>> +	timerdrv->irq = irq;
> 
> Not needed

ok

> 
>> +	timerdrv->ced = (struct clock_event_device){
>> +		.name			= "goldfish_timer",
>> +		.features		= CLOCK_EVT_FEAT_ONESHOT,
>> +		.set_state_shutdown	= goldfish_timer_shutdown,
>> +		.set_state_oneshot      = goldfish_timer_set_oneshot,
>> +		.set_next_event		= goldfish_timer_next_event,
>> +	};
> 
> nit: add CR

ok

> 
>> +	timerdrv->res = (struct resource){
>> +		.name  = "goldfish_timer",
>> +		.start = (unsigned long)base,
>> +		.end   = (unsigned long)base + 0xfff,
>> +	};
> 
> Could be a local variable, no?

As I said above, I think the structure passed to request_resource() must not be released.

> 
>> +	if (request_resource(&iomem_resource, &timerdrv->res)) {
>> +		pr_err("Cannot allocate goldfish-timer resource\n");
> 
> nit: pr_err("Cannot allocate '%s' resource\n", res.name);

ok

> 
>> +		return;
>> +	}
>> +
>> +	timerdrv->cs = (struct clocksource){
>> +		.name		= "goldfish_timer",
>> +		.rating		= 400,
>> +		.read		= goldfish_timer_read,
>> +		.mask		= CLOCKSOURCE_MASK(64),
>> +		.flags		= 0,
>> +		.max_idle_ns	= LONG_MAX,
>> +	};
>> +
>> +	clocksource_register_hz(&timerdrv->cs, NSEC_PER_SEC);
>> +
>> +	ret = request_irq(timerdrv->irq, golfish_timer_tick, IRQF_TIMER,
>> +			  "goldfish_timer", &timerdrv->ced);
> 
> Why not pass directly 'timerdrv' ?

You're right, we can pass it directly.

> 
>> +	if (ret) {
>> +		pr_err("Couldn't register goldfish-timer interrupt\n");
>> +		return;
>> +	}
>> +
>> +	clockevents_config_and_register(&timerdrv->ced, NSEC_PER_SEC,
>> +					1, 0xffffffff);
>> +}
>> diff --git a/include/clocksource/timer-goldfish.h b/include/clocksource/timer-goldfish.h
>> new file mode 100644
>> index 000000000000..b237267844f1
>> --- /dev/null
>> +++ b/include/clocksource/timer-goldfish.h
>> @@ -0,0 +1,11 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * goldfish-timer clocksource
>> + */
>> +
>> +#ifndef _CLOCKSOURCE_GOLDFISH_TIMER_H
>> +#define _CLOCKSOURCE_GOLDFISH_TIMER_H
>> +
>> +extern void goldfish_timer_init(int irq, void __iomem *base);
>> +
>> +#endif /* _CLOCKSOURCE_GOLDFISH_TIMER_H */
>>
> 
> 


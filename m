Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1941D4B8B91
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbiBPOhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:37:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbiBPOhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:37:21 -0500
X-Greylist: delayed 325 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 06:37:08 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5655D2A64D1;
        Wed, 16 Feb 2022 06:37:07 -0800 (PST)
Received: from [192.168.100.1] ([82.142.13.146]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M5Q2f-1nIyQR0pXx-001SW8; Wed, 16 Feb 2022 15:31:14 +0100
Message-ID: <1a0f23f2-361a-25d1-b371-7a229758d248@vivier.eu>
Date:   Wed, 16 Feb 2022 15:31:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v14 4/5] clocksource/drivers: Add a goldfish-timer
 clocksource
Content-Language: fr
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220130143333.552646-1-laurent@vivier.eu>
 <20220130143333.552646-5-laurent@vivier.eu>
From:   Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20220130143333.552646-5-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7JSXb+0iPWC1kUoDSy+e0pd80DU2qFPw7Rc/A8oDGjFlcgAJFy7
 kzKNq77rh+TkVUg+/qKTeOBHMKjkYsr71BjVI+X3gh6a4lSIR7bhTvrqYqmzaVAMSKdWSYG
 h70Y55KueTU0qolvsRfHIRNDLzf/i5FzRt7afiex5KD5eD/ta2CggiXV2p9pYiyR0tFg1ka
 KF4yFXU7iM/ZdQEGvWFyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WJR0F7P8k/c=:q9M000AaJrC8fNch58wOhx
 37ZHoUNZdFi85SbI88MtO0VUV5jL11t9f58PaUCQY6j1ApdpdnMH5Am/WhREb3jVV7iq5zKlb
 SLi/a+t/DDDIu3x4O6tJZiSkbCMlzMuL2LdN9E2Ui2SB/KfXj1qEHjdG+gVvni72tuBBDUJoY
 aEKdg/COPhEqTaNGT5u0cagI+BIIpy/f5P9Zl0EQubs0+GZrd4THWq12PQxQyk1vyn8Om4/r7
 7SZPYwC2evKkukOBeaTZF6boJiNuqnhcc/RBJVUOi6iWA40dHduPv99Or1Ib9zCMKdueosv4L
 h07MW8+x6e/1PsMBQVYmGsVg+1ESRVqDSYZCVPIQNQEPo7ccwc8iDB/gCH8TRaNde1Ub43gvj
 DNhPJC9zshdhE8JnhlBX3jTaxnulVYU6Xm+TAkVS6jJUOR+WanZ8ZtLHXl+5HkJ1PwGsZ9hx0
 DLEOtyq2x4Ff80qOejCtaxEzzYAm8UbIgJZS9kJ1wAI+TI4ykffVytLLtUDBXHy7mpOez4HDc
 enMFvNq1tz5BpKbRNjkMvF62Dm2B+125+BfC8Py2KD37nYybpJGUxHRF5RCTWXkr7HK3MVJpE
 jxyYbGtRrMFbhsBIVgX1fCeis/l3p0LiDWER/rlQCoc8OkoccesxRWuFW7jxJFQzhUiGEuYc4
 OYdOON/AKsQ3wfwITajS5Cc/7KRPmARXnrlE/TCZdPzc7oHofgk74TcuPeyTPTKSo4uc=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

as you reviewed the v12, could you review this version to see if I have addressed your comments?

Thanks,
Laurent

Le 30/01/2022 à 15:33, Laurent Vivier a écrit :
> Add a clocksource based on the goldfish-rtc device.
> 
> Move the timer register definition to <clocksource/timer-goldfish.h>
> 
> This kernel implementation is based on the QEMU upstream implementation:
> 
>     https://git.qemu.org/?p=qemu.git;a=blob_plain;f=hw/rtc/goldfish_rtc.c
> 
> Details related to Goldfish devices can be found in:
> 
>    https://android.googlesource.com/platform/external/qemu/+/master/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   drivers/clocksource/Kconfig          |   7 ++
>   drivers/clocksource/Makefile         |   1 +
>   drivers/clocksource/timer-goldfish.c | 153 +++++++++++++++++++++++++++
>   drivers/rtc/rtc-goldfish.c           |  13 +--
>   include/clocksource/timer-goldfish.h |  31 ++++++
>   5 files changed, 193 insertions(+), 12 deletions(-)
>   create mode 100644 drivers/clocksource/timer-goldfish.c
>   create mode 100644 include/clocksource/timer-goldfish.h
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index cfb8ea0df3b1..94f00374cebb 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -721,4 +721,11 @@ config MICROCHIP_PIT64B
>   	  modes and high resolution. It is used as a clocksource
>   	  and a clockevent.
>   
> +config GOLDFISH_TIMER
> +	bool "Clocksource using goldfish-rtc"
> +	depends on M68K || COMPILE_TEST
> +	depends on RTC_DRV_GOLDFISH
> +	help
> +	  Support for the timer/counter of goldfish-rtc
> +
>   endmenu
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index fa5f624eadb6..12f5d7e8cc2d 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -89,3 +89,4 @@ obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
>   obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
>   obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
>   obj-$(CONFIG_MSC313E_TIMER)		+= timer-msc313e.o
> +obj-$(CONFIG_GOLDFISH_TIMER)		+= timer-goldfish.o
> diff --git a/drivers/clocksource/timer-goldfish.c b/drivers/clocksource/timer-goldfish.c
> new file mode 100644
> index 000000000000..0512d5eabc82
> --- /dev/null
> +++ b/drivers/clocksource/timer-goldfish.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/interrupt.h>
> +#include <linux/ioport.h>
> +#include <linux/clocksource.h>
> +#include <linux/clockchips.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/goldfish.h>
> +#include <clocksource/timer-goldfish.h>
> +
> +struct goldfish_timer {
> +	struct clocksource cs;
> +	struct clock_event_device ced;
> +	struct resource res;
> +	void __iomem *base;
> +};
> +
> +static struct goldfish_timer *ced_to_gf(struct clock_event_device *ced)
> +{
> +	return container_of(ced, struct goldfish_timer, ced);
> +}
> +
> +static struct goldfish_timer *cs_to_gf(struct clocksource *cs)
> +{
> +	return container_of(cs, struct goldfish_timer, cs);
> +}
> +
> +static u64 goldfish_timer_read(struct clocksource *cs)
> +{
> +	struct goldfish_timer *timerdrv = cs_to_gf(cs);
> +	void __iomem *base = timerdrv->base;
> +	u32 time_low, time_high;
> +	u64 ticks;
> +
> +	/*
> +	 * time_low: get low bits of current time and update time_high
> +	 * time_high: get high bits of time at last time_low read
> +	 */
> +	time_low = gf_ioread32(base + TIMER_TIME_LOW);
> +	time_high = gf_ioread32(base + TIMER_TIME_HIGH);
> +
> +	ticks = ((u64)time_high << 32) | time_low;
> +
> +	return ticks;
> +}
> +
> +static int goldfish_timer_set_oneshot(struct clock_event_device *evt)
> +{
> +	struct goldfish_timer *timerdrv = ced_to_gf(evt);
> +	void __iomem *base = timerdrv->base;
> +
> +	gf_iowrite32(0, base + TIMER_ALARM_HIGH);
> +	gf_iowrite32(0, base + TIMER_ALARM_LOW);
> +	gf_iowrite32(1, base + TIMER_IRQ_ENABLED);
> +
> +	return 0;
> +}
> +
> +static int goldfish_timer_shutdown(struct clock_event_device *evt)
> +{
> +	struct goldfish_timer *timerdrv = ced_to_gf(evt);
> +	void __iomem *base = timerdrv->base;
> +
> +	gf_iowrite32(0, base + TIMER_IRQ_ENABLED);
> +
> +	return 0;
> +}
> +
> +static int goldfish_timer_next_event(unsigned long delta,
> +				     struct clock_event_device *evt)
> +{
> +	struct goldfish_timer *timerdrv = ced_to_gf(evt);
> +	void __iomem *base = timerdrv->base;
> +	u64 now;
> +
> +	now = goldfish_timer_read(&timerdrv->cs);
> +
> +	now += delta;
> +
> +	gf_iowrite32(upper_32_bits(now), base + TIMER_ALARM_HIGH);
> +	gf_iowrite32(lower_32_bits(now), base + TIMER_ALARM_LOW);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t goldfish_timer_irq(int irq, void *dev_id)
> +{
> +	struct goldfish_timer *timerdrv = dev_id;
> +	struct clock_event_device *evt = &timerdrv->ced;
> +	void __iomem *base = timerdrv->base;
> +
> +	gf_iowrite32(1, base + TIMER_CLEAR_INTERRUPT);
> +
> +	evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +int __init goldfish_timer_init(int irq, void __iomem *base)
> +{
> +	struct goldfish_timer *timerdrv;
> +	int ret;
> +
> +	timerdrv = kzalloc(sizeof(*timerdrv), GFP_KERNEL);
> +	if (!timerdrv)
> +		return -ENOMEM;
> +
> +	timerdrv->base = base;
> +
> +	timerdrv->ced = (struct clock_event_device){
> +		.name			= "goldfish_timer",
> +		.features		= CLOCK_EVT_FEAT_ONESHOT,
> +		.set_state_shutdown	= goldfish_timer_shutdown,
> +		.set_state_oneshot      = goldfish_timer_set_oneshot,
> +		.set_next_event		= goldfish_timer_next_event,
> +	};
> +
> +	timerdrv->res = (struct resource){
> +		.name  = "goldfish_timer",
> +		.start = (unsigned long)base,
> +		.end   = (unsigned long)base + 0xfff,
> +	};
> +
> +	ret = request_resource(&iomem_resource, &timerdrv->res);
> +	if (ret) {
> +		pr_err("Cannot allocate '%s' resource\n", timerdrv->res.name);
> +		return ret;
> +	}
> +
> +	timerdrv->cs = (struct clocksource){
> +		.name		= "goldfish_timer",
> +		.rating		= 400,
> +		.read		= goldfish_timer_read,
> +		.mask		= CLOCKSOURCE_MASK(64),
> +		.flags		= 0,
> +		.max_idle_ns	= LONG_MAX,
> +	};
> +
> +	clocksource_register_hz(&timerdrv->cs, NSEC_PER_SEC);
> +
> +	ret = request_irq(irq, goldfish_timer_irq, IRQF_TIMER,
> +			  "goldfish_timer", timerdrv);
> +	if (ret) {
> +		pr_err("Couldn't register goldfish-timer interrupt\n");
> +		return ret;
> +	}
> +
> +	clockevents_config_and_register(&timerdrv->ced, NSEC_PER_SEC,
> +					1, 0xffffffff);
> +
> +	return 0;
> +}
> diff --git a/drivers/rtc/rtc-goldfish.c b/drivers/rtc/rtc-goldfish.c
> index eb1929b0cbb6..59c0f38cc08d 100644
> --- a/drivers/rtc/rtc-goldfish.c
> +++ b/drivers/rtc/rtc-goldfish.c
> @@ -11,18 +11,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/rtc.h>
>   #include <linux/goldfish.h>
> -
> -#define TIMER_TIME_LOW		0x00	/* get low bits of current time  */
> -					/*   and update TIMER_TIME_HIGH  */
> -#define TIMER_TIME_HIGH	0x04	/* get high bits of time at last */
> -					/*   TIMER_TIME_LOW read         */
> -#define TIMER_ALARM_LOW	0x08	/* set low bits of alarm and     */
> -					/*   activate it                 */
> -#define TIMER_ALARM_HIGH	0x0c	/* set high bits of next alarm   */
> -#define TIMER_IRQ_ENABLED	0x10
> -#define TIMER_CLEAR_ALARM	0x14
> -#define TIMER_ALARM_STATUS	0x18
> -#define TIMER_CLEAR_INTERRUPT	0x1c
> +#include <clocksource/timer-goldfish.h>
>   
>   struct goldfish_rtc {
>   	void __iomem *base;
> diff --git a/include/clocksource/timer-goldfish.h b/include/clocksource/timer-goldfish.h
> new file mode 100644
> index 000000000000..d39097729b1d
> --- /dev/null
> +++ b/include/clocksource/timer-goldfish.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * goldfish-timer clocksource
> + * Registers definition for the goldfish-timer device
> + */
> +
> +#ifndef _CLOCKSOURCE_TIMER_GOLDFISH_H
> +#define _CLOCKSOURCE_TIMER_GOLDFISH_H
> +
> +/*
> + * TIMER_TIME_LOW	 get low bits of current time and update TIMER_TIME_HIGH
> + * TIMER_TIME_HIGH	 get high bits of time at last TIMER_TIME_LOW read
> + * TIMER_ALARM_LOW	 set low bits of alarm and activate it
> + * TIMER_ALARM_HIGH	 set high bits of next alarm
> + * TIMER_IRQ_ENABLED	 enable alarm interrupt
> + * TIMER_CLEAR_ALARM	 disarm an existin alarm
> + * TIMER_ALARM_STATUS	 alarm status (running or not)
> + * TIMER_CLEAR_INTERRUPT clear interrupt
> + */
> +#define TIMER_TIME_LOW		0x00
> +#define TIMER_TIME_HIGH		0x04
> +#define TIMER_ALARM_LOW		0x08
> +#define TIMER_ALARM_HIGH	0x0c
> +#define TIMER_IRQ_ENABLED	0x10
> +#define TIMER_CLEAR_ALARM	0x14
> +#define TIMER_ALARM_STATUS	0x18
> +#define TIMER_CLEAR_INTERRUPT	0x1c
> +
> +extern int goldfish_timer_init(int irq, void __iomem *base);
> +
> +#endif /* _CLOCKSOURCE_TIMER_GOLDFISH_H */


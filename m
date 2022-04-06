Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA724F6259
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiDFOwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbiDFOv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:51:56 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58270473BC2;
        Wed,  6 Apr 2022 04:27:01 -0700 (PDT)
Received: from [192.168.100.1] ([82.142.17.26]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MaInF-1nWAdL1wZR-00WETf; Wed, 06 Apr 2022 13:26:34 +0200
Message-ID: <465da893-4e7b-33e4-2859-032724bae42f@vivier.eu>
Date:   Wed, 6 Apr 2022 13:26:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v15 4/5] clocksource/drivers: Add a goldfish-timer
 clocksource
Content-Language: fr
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20220310090048.1933020-1-laurent@vivier.eu>
 <20220310090048.1933020-5-laurent@vivier.eu>
 <f87deb83-7f1f-5acf-b6c6-040fcd02c0be@vivier.eu>
 <768c4fe5-fd36-8e4a-a9c2-1c799af3ed44@linaro.org>
From:   Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <768c4fe5-fd36-8e4a-a9c2-1c799af3ed44@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1Ddi8//vR+pwaFfa7/frty7H56BT91Uw6bSWiXvRoxv3+2QDHwq
 aJhlfY0cZkwVtNsmta6//MbumzSy9AB+GZ0QMoOHNVAdAu6qP1h4tNFSBRyvY9qLuEHrFka
 aKm0XDrrCFzkiO3FxvRJqN2Cu+pHjP5vWe9VyELfS/Q4oo4mq7tU707/cvGufgHtPcWhile
 VdoiNIUhvCCqkBd6KKxBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c6JeBJh3TZI=:O+yOSPNxA+7PCAAfgUNYya
 2URfVShTV5NexDqUmzjTjgad6UX4DQhxPdCiHzDOC9K9ZtEoYKOTpZQGPv5gbsOVXPPJtO7yO
 3dUASVhnHEwMtUJ3NxuYqGWQR119ZOROEv+Uf/I8gXV4tTSUjoCrALmnujxD65betlhja40ut
 Jzr6mJIxWI+PLVu/CujfsYByeg9WaXbDKduXAEial/riAVCg1WRav4T4lPQSBqhoA8OM81fPu
 qu/Ks1nlT09fj7/rnG/bUC485cZY2HITD6LlDK4vvm3ekOSUZMxhmMgQlncBzSQuB9BiCK9JY
 DSFS3SClaY/d3MnViDdZ+Tdrz1qa2f+ztLoj/7DzQ81jC/+Dy+KN3ZqAaLrjxZnvjZK+7TaN0
 lmeGu3Fxt4QODsabthTWmIwjODHOIDMP8/nndhO/ZkKU+JbX8XqMMKqvBKXrj907Su7xNtq20
 NV8LVxW093UHEJkdoW4H208/b1gzJ2Cfjq0Wd4g064niXdOZnNpPquVg11EshcDBfR9U8qKLe
 bo9nfGeb8AxhP2wkUXKflgARU3ynjNmud3yLDrWd8hxMF1qUP0n3B6CK/0/zPSsUXgPxoKSl3
 agKJpOH64FzlDPzWB9gGz4CtDg9hjwZMbmaVECCt2z+BHFJRgP4URuJDVijV9MCfEBJEEOUot
 Stt4L0uJnDCjei3AbUSGo0I8PGlfSev4r7sUAgOsqT+KU0+5nmO400F7owPaX39kxc/0=
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 06/04/2022 à 12:27, Daniel Lezcano a écrit :
> 
> Hi Laurent,
> 
> 
> On 01/04/2022 12:20, Laurent Vivier wrote:
>>
>> Daniel ?
>>
>> Thanks,
>> Laurent
>>
>> Le 10/03/2022 à 10:00, Laurent Vivier a écrit :
>>> Add a clocksource based on the goldfish-rtc device.
>>>
>>> Move the timer register definition to <clocksource/timer-goldfish.h>
>>>
>>> This kernel implementation is based on the QEMU upstream implementation:
>>>
>>>     https://git.qemu.org/?p=qemu.git;a=blob_plain;f=hw/rtc/goldfish_rtc.c
>>>
>>> goldfish-timer is a high-precision signed 64-bit nanosecond timer.
>>> It is part of the 'goldfish' virtual hardware platform used to run
>>> some emulated Android systems under QEMU.
>>> This timer only supports oneshot event.
>>>
>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>>> ---
>>>   drivers/clocksource/Kconfig          |   7 ++
>>>   drivers/clocksource/Makefile         |   1 +
>>>   drivers/clocksource/timer-goldfish.c | 153 +++++++++++++++++++++++++++
>>>   drivers/rtc/rtc-goldfish.c           |  13 +--
>>>   include/clocksource/timer-goldfish.h |  31 ++++++
>>>   5 files changed, 193 insertions(+), 12 deletions(-)
>>>   create mode 100644 drivers/clocksource/timer-goldfish.c
>>>   create mode 100644 include/clocksource/timer-goldfish.h
>>>
>>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>>> index cfb8ea0df3b1..94f00374cebb 100644
>>> --- a/drivers/clocksource/Kconfig
>>> +++ b/drivers/clocksource/Kconfig
>>> @@ -721,4 +721,11 @@ config MICROCHIP_PIT64B
>>>         modes and high resolution. It is used as a clocksource
>>>         and a clockevent.
>>> +config GOLDFISH_TIMER
>>> +    bool "Clocksource using goldfish-rtc"
>>> +    depends on M68K || COMPILE_TEST
>>> +    depends on RTC_DRV_GOLDFISH
>>> +    help
>>> +      Support for the timer/counter of goldfish-rtc
>>> +
>>>   endmenu
>>> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
>>> index fa5f624eadb6..12f5d7e8cc2d 100644
>>> --- a/drivers/clocksource/Makefile
>>> +++ b/drivers/clocksource/Makefile
>>> @@ -89,3 +89,4 @@ obj-$(CONFIG_GX6605S_TIMER)        += timer-gx6605s.o
>>>   obj-$(CONFIG_HYPERV_TIMER)        += hyperv_timer.o
>>>   obj-$(CONFIG_MICROCHIP_PIT64B)        += timer-microchip-pit64b.o
>>>   obj-$(CONFIG_MSC313E_TIMER)        += timer-msc313e.o
>>> +obj-$(CONFIG_GOLDFISH_TIMER)        += timer-goldfish.o
>>> diff --git a/drivers/clocksource/timer-goldfish.c b/drivers/clocksource/timer-goldfish.c
>>> new file mode 100644
>>> index 000000000000..0512d5eabc82
>>> --- /dev/null
>>> +++ b/drivers/clocksource/timer-goldfish.c
>>> @@ -0,0 +1,153 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +#include <linux/interrupt.h>
>>> +#include <linux/ioport.h>
>>> +#include <linux/clocksource.h>
>>> +#include <linux/clockchips.h>
>>> +#include <linux/module.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/goldfish.h>
> 
> Not related to this patch: would it make sense to move it to linux/soc/... ?

I don't know. goldfish is not really a soc. I didn't really find a good place where it should be.

> 
> 
>>> +#include <clocksource/timer-goldfish.h>
>>> +
>>> +struct goldfish_timer {
>>> +    struct clocksource cs;
>>> +    struct clock_event_device ced;
>>> +    struct resource res;
>>> +    void __iomem *base;
>>> +};
>>> +
>>> +static struct goldfish_timer *ced_to_gf(struct clock_event_device *ced)
>>> +{
>>> +    return container_of(ced, struct goldfish_timer, ced);
>>> +}
>>> +
>>> +static struct goldfish_timer *cs_to_gf(struct clocksource *cs)
>>> +{
>>> +    return container_of(cs, struct goldfish_timer, cs);
>>> +}
>>> +
>>> +static u64 goldfish_timer_read(struct clocksource *cs)
>>> +{
>>> +    struct goldfish_timer *timerdrv = cs_to_gf(cs);
>>> +    void __iomem *base = timerdrv->base;
>>> +    u32 time_low, time_high;
>>> +    u64 ticks;
>>> +
>>> +    /*
>>> +     * time_low: get low bits of current time and update time_high
>>> +     * time_high: get high bits of time at last time_low read
>>> +     */
>>> +    time_low = gf_ioread32(base + TIMER_TIME_LOW);
>>> +    time_high = gf_ioread32(base + TIMER_TIME_HIGH);
> 
> There is a risk here to have the counter rolling over between low and high reading, no ?

No, because value of high is frozen when we read low, so the 64bit value doesn't move between the 
two ioread32().

Thanks,
Laurent

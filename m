Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227424F61A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiDFOXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbiDFOWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:22:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F9C3919C2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:27:55 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j12so2512927wrb.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 03:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BwJ8SAExrW9RROE3H/KoFKcCEjo9fX//swBP0z59ayk=;
        b=DJsXVuR9LnT4MsrQXyeJ1YXGm1NrYFUF/KXlDFJg0R5rzk9CzQZcmR3jlrF8manMtp
         ASXneeEVMU4q6+Jap7hwKjd4Be+CLYwPoowyh44dFBJkGy8S4RY19sE1wUe9r62ycByT
         HOYz/2vRmbkG1CR3+hZqB0h4vUVzlT+OUXPMLAfbeK8tMrsozQf93/f8Xnd16/eMX8BO
         YHOGa//5Dl8yEeXXBuZTnzd5FH35Qcy0XRDxYTtyvrKUJ2GQNOlSLgAdOJSTyVqCgeQb
         qDTlMkoSMtO0BwzvIICzlSHb7wRbClWSNEOn12+h1VwnTWM7bReTHIV53mTDlmUbJuMU
         fMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BwJ8SAExrW9RROE3H/KoFKcCEjo9fX//swBP0z59ayk=;
        b=uzYlbCl0gUFo3Z0EwfIKOHLPr9NCM+DFNuSWI7friJlDh6jUsTs2QnGYz6xB7ARIp1
         cwwzI2Ed70kuD5vGGRpDCWlmWfRlMjNV12KAS/x7MZ2P7uoReOrfKjKjjCvOpGu7n5so
         dDmZ+QJSxFTftHElhtK4Ak6She6GeEynxq/RwciXPze/oSRBhPC6zVIIvGxq9D3r64fG
         Hvfef/tvRkihzeAmOechtYJlU/nuiFwDoq3uad+zBym+TwmpqGOiiawC7jurEhQusGYq
         USPubZOZSDgkcE7wAXQiqkPTReo5Tb65iW2F7lNmhvfLrdVME6WgWezcxHH7iCFLLN4l
         EHBw==
X-Gm-Message-State: AOAM532rpd4ieYZlJqQedzRRBPYq0BLoN/ojDO7Ys5OKQfOn0NALOfXo
        TaHuM978dq3YuD8m/jy8JSWPVw==
X-Google-Smtp-Source: ABdhPJxjZWm6A/FkxhLV3pL1XPdURvb/xkERbt+nv44rDcPej9lBzoqljxAT2Qz0N+zvvuec3B4ykA==
X-Received: by 2002:a5d:6dad:0:b0:204:182a:e601 with SMTP id u13-20020a5d6dad000000b00204182ae601mr6018322wrs.262.1649240874318;
        Wed, 06 Apr 2022 03:27:54 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:261f:c14c:d23b:d177? ([2a01:e34:ed2f:f020:261f:c14c:d23b:d177])
        by smtp.googlemail.com with ESMTPSA id bg20-20020a05600c3c9400b0037fa5c422c8sm5011797wmb.48.2022.04.06.03.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 03:27:52 -0700 (PDT)
Message-ID: <768c4fe5-fd36-8e4a-a9c2-1c799af3ed44@linaro.org>
Date:   Wed, 6 Apr 2022 12:27:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v15 4/5] clocksource/drivers: Add a goldfish-timer
 clocksource
Content-Language: en-US
To:     Laurent Vivier <laurent@vivier.eu>
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <f87deb83-7f1f-5acf-b6c6-040fcd02c0be@vivier.eu>
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


Hi Laurent,


On 01/04/2022 12:20, Laurent Vivier wrote:
> 
> Daniel ?
> 
> Thanks,
> Laurent
> 
> Le 10/03/2022 à 10:00, Laurent Vivier a écrit :
>> Add a clocksource based on the goldfish-rtc device.
>>
>> Move the timer register definition to <clocksource/timer-goldfish.h>
>>
>> This kernel implementation is based on the QEMU upstream implementation:
>>
>>     https://git.qemu.org/?p=qemu.git;a=blob_plain;f=hw/rtc/goldfish_rtc.c
>>
>> goldfish-timer is a high-precision signed 64-bit nanosecond timer.
>> It is part of the 'goldfish' virtual hardware platform used to run
>> some emulated Android systems under QEMU.
>> This timer only supports oneshot event.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>   drivers/clocksource/Kconfig          |   7 ++
>>   drivers/clocksource/Makefile         |   1 +
>>   drivers/clocksource/timer-goldfish.c | 153 +++++++++++++++++++++++++++
>>   drivers/rtc/rtc-goldfish.c           |  13 +--
>>   include/clocksource/timer-goldfish.h |  31 ++++++
>>   5 files changed, 193 insertions(+), 12 deletions(-)
>>   create mode 100644 drivers/clocksource/timer-goldfish.c
>>   create mode 100644 include/clocksource/timer-goldfish.h
>>
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index cfb8ea0df3b1..94f00374cebb 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -721,4 +721,11 @@ config MICROCHIP_PIT64B
>>         modes and high resolution. It is used as a clocksource
>>         and a clockevent.
>> +config GOLDFISH_TIMER
>> +    bool "Clocksource using goldfish-rtc"
>> +    depends on M68K || COMPILE_TEST
>> +    depends on RTC_DRV_GOLDFISH
>> +    help
>> +      Support for the timer/counter of goldfish-rtc
>> +
>>   endmenu
>> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
>> index fa5f624eadb6..12f5d7e8cc2d 100644
>> --- a/drivers/clocksource/Makefile
>> +++ b/drivers/clocksource/Makefile
>> @@ -89,3 +89,4 @@ obj-$(CONFIG_GX6605S_TIMER)        += timer-gx6605s.o
>>   obj-$(CONFIG_HYPERV_TIMER)        += hyperv_timer.o
>>   obj-$(CONFIG_MICROCHIP_PIT64B)        += timer-microchip-pit64b.o
>>   obj-$(CONFIG_MSC313E_TIMER)        += timer-msc313e.o
>> +obj-$(CONFIG_GOLDFISH_TIMER)        += timer-goldfish.o
>> diff --git a/drivers/clocksource/timer-goldfish.c 
>> b/drivers/clocksource/timer-goldfish.c
>> new file mode 100644
>> index 000000000000..0512d5eabc82
>> --- /dev/null
>> +++ b/drivers/clocksource/timer-goldfish.c
>> @@ -0,0 +1,153 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/ioport.h>
>> +#include <linux/clocksource.h>
>> +#include <linux/clockchips.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/goldfish.h>

Not related to this patch: would it make sense to move it to linux/soc/... ?


>> +#include <clocksource/timer-goldfish.h>
>> +
>> +struct goldfish_timer {
>> +    struct clocksource cs;
>> +    struct clock_event_device ced;
>> +    struct resource res;
>> +    void __iomem *base;
>> +};
>> +
>> +static struct goldfish_timer *ced_to_gf(struct clock_event_device *ced)
>> +{
>> +    return container_of(ced, struct goldfish_timer, ced);
>> +}
>> +
>> +static struct goldfish_timer *cs_to_gf(struct clocksource *cs)
>> +{
>> +    return container_of(cs, struct goldfish_timer, cs);
>> +}
>> +
>> +static u64 goldfish_timer_read(struct clocksource *cs)
>> +{
>> +    struct goldfish_timer *timerdrv = cs_to_gf(cs);
>> +    void __iomem *base = timerdrv->base;
>> +    u32 time_low, time_high;
>> +    u64 ticks;
>> +
>> +    /*
>> +     * time_low: get low bits of current time and update time_high
>> +     * time_high: get high bits of time at last time_low read
>> +     */
>> +    time_low = gf_ioread32(base + TIMER_TIME_LOW);
>> +    time_high = gf_ioread32(base + TIMER_TIME_HIGH);

There is a risk here to have the counter rolling over between low and 
high reading, no ?

If it is the case, you may consider using 32bits instead of 64bits, 
otherwise handle the counter wrapping around.

>> +    ticks = ((u64)time_high << 32) | time_low;
>> +
>> +    return ticks;
>> +}
>> +

[ ... ]

>> +/*
>> + * TIMER_TIME_LOW     get low bits of current time and update 
>> TIMER_TIME_HIGH
>> + * TIMER_TIME_HIGH     get high bits of time at last TIMER_TIME_LOW read
>> + * TIMER_ALARM_LOW     set low bits of alarm and activate it
>> + * TIMER_ALARM_HIGH     set high bits of next alarm
>> + * TIMER_IRQ_ENABLED     enable alarm interrupt
>> + * TIMER_CLEAR_ALARM     disarm an existin alarm

typo: s/existin/existing/

>> + * TIMER_ALARM_STATUS     alarm status (running or not)
>> + * TIMER_CLEAR_INTERRUPT clear interrupt
>> + */
>> +#define TIMER_TIME_LOW        0x00
>> +#define TIMER_TIME_HIGH        0x04
>> +#define TIMER_ALARM_LOW        0x08
>> +#define TIMER_ALARM_HIGH    0x0c
>> +#define TIMER_IRQ_ENABLED    0x10
>> +#define TIMER_CLEAR_ALARM    0x14
>> +#define TIMER_ALARM_STATUS    0x18
>> +#define TIMER_CLEAR_INTERRUPT    0x1c
>> +
>> +extern int goldfish_timer_init(int irq, void __iomem *base);
>> +
>> +#endif /* _CLOCKSOURCE_TIMER_GOLDFISH_H */





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

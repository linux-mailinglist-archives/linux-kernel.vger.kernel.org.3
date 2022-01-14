Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45C448E8D0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 12:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbiANLD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 06:03:57 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:40513 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbiANLD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 06:03:56 -0500
Received: from [192.168.100.1] ([82.142.23.158]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MVNJ3-1mjHHE2fzD-00SLnq; Fri, 14 Jan 2022 12:03:43 +0100
Message-ID: <a53e6d46-114f-7bb2-70b9-113c5f8a9c0e@vivier.eu>
Date:   Fri, 14 Jan 2022 12:03:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: fr
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-rtc@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20220113201920.3201760-1-laurent@vivier.eu>
 <20220113201920.3201760-4-laurent@vivier.eu>
 <CAK8P3a2QzMiga0FFVmTuefnq1OzsgyopiJN2he8043K0TRF1ng@mail.gmail.com>
From:   Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v6 3/4] clocksource/drivers: Add a goldfish-timer
 clocksource
In-Reply-To: <CAK8P3a2QzMiga0FFVmTuefnq1OzsgyopiJN2he8043K0TRF1ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:smzK6d4OVWNorZOCeZXQ3R0dRxq4hr/LXuhZg5brBfJJdJNCq7b
 KJIobnfgxnXbl9N3QiD4yaMtOV3IDD2CXLwOgWfVS/e8SbXR4a32dbYpaKSJLFj0xQDvmHU
 tbMfOj4eNd33mdo1/cptU9Qv/cta4toKYiTjYcpwJ1vqsA2jLVoZxB3zGov0bexexue5xWd
 BrewS1+Kbc8yjm0mFMwGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aQm5OjTfUvk=:bhDOtNIJeeqXG/AztJK+lq
 E7sWztyo5KoUKfrDdBp0MP9cpB8WWpo6E32pbT0QuYie47W22B9gqP0+xW2ttR9bNwS2LOL2U
 v83yQ5liBIZNpGky6+kjCeKJVOqwkmBArCxSslQCs2HVkv3x/DQn/vFuLvVdTwZK0UH0+FrBH
 f8iTdhJpNTqu3k6mN/6AEqmCVNSW4cibMnzoGBZvyLCyjQleTj6PreO4ol60EfZ45WDmIQh8I
 b6b3IGCOM2yC4vPtq6Xs2Kjkx9JluWXAP3DNvtpV0k41kAf+eNhNeusMKvNYF8R61JTuPxP+B
 ofs4btndAP/nVtVq1SmStaAgvo1XsjWa5jIp0Mo/sbMYxOfqOVSy1EayDMlNFUJPbBYkva2Ys
 KK5zSipzIrwkEemGCmoHz03mh9lAvlETkp/4Nf1o8dm/bjIcBXJ0dvRCfOoPY+Q5LNX+Yjf4d
 7ehAJInIp9fCjgHRZSTxELm/qHMbTrl9m3TEtdDHvyyve6vhUc7HjevJ2yIDC7B7FqdBbzn27
 vA8SfdmkcU+9oloww8zTqk7IG2FBhijw9zOV4OR1FgyXgI0VkAye0rrK0FzG0aQGijasiEOjm
 BhRxMJd/eaQ9HLCQ8ueF9VFHsSamD+m2YwFMb+EcNrOgOpz1rjWhJuw70u9qKbxA72rbklWU0
 FUkTtfUKEfAFDBKx6c5wwlABBLiPCqQEUpP2Iqgszne3+lka7+JshQ7ov+ZWmRXQg7CY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 14/01/2022 à 11:46, Arnd Bergmann a écrit :
> On Thu, Jan 13, 2022 at 9:19 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Add a clocksource based on the goldfish-rtc device.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>   drivers/clocksource/Kconfig          |   7 ++
>>   drivers/clocksource/Makefile         |   1 +
>>   drivers/clocksource/timer-goldfish.c | 130 +++++++++++++++++++++++++++
>>   include/clocksource/timer-goldfish.h |  12 +++
>>   4 files changed, 150 insertions(+)
>>   create mode 100644 drivers/clocksource/timer-goldfish.c
>>   create mode 100644 include/clocksource/timer-goldfish.h
>>
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index f65e31bab9ae..6ca9bb78407d 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -711,4 +711,11 @@ config MICROCHIP_PIT64B
>>            modes and high resolution. It is used as a clocksource
>>            and a clockevent.
>>
>> +config GOLDFISH_TIMER
>> +       bool "Clocksource using goldfish-rtc"
>> +       select RTC_CLASS
>> +       select RTC_DRV_GOLDFISH
> 
> This should probably be
> 
>            depends on M68K || COMPILE_TEST
>            depends on RTC_DRV_GOLDFISH
> 
> A driver should never 'select' another user-selectable subsystem

ok

> 
>> +static int goldfish_timer_set_oneshot(struct clock_event_device *evt)
>> +{
>> +       struct goldfish_timer *timerdrv = ced_to_gf(evt);
>> +       void __iomem *base = timerdrv->base;
>> +
>> +       __raw_writel(0, base + TIMER_ALARM_HIGH);
>> +       __raw_writel(0, base + TIMER_ALARM_LOW);
>> +       __raw_writel(1, base + TIMER_IRQ_ENABLED);
> 
> As mentioned elsewhere, the __raw_* accessors are not portable, please
> use readl()/writel() here, or possibly ioread32_be()/iowrite32_be() for
> the big-endian variant.

We can't use readl()/writel() here because it's supposed to read from a little endian device, and 
goldfish endianness depends on the endianness of the machine.

For goldfish, readl()/writel() works fine on little-endian machine but not on big-endian machine.

On m68k, you have:

#define readl(addr)      in_le32(addr)
#define writel(val,addr) out_le32((addr),(val))

and with goldfish it's wrong as the device is not little-endian, it is big-endian like the machine.

same comment with ioread32_be()/iowrite32_be(): it will work on big-endian machine not on little-endian.

We need an accessor that doesn't byteswap the value, that accesses it natively, and in all other 
parts of the kernel __raw_writel() and __raw_readl() are used.

Thanks,
Laurent


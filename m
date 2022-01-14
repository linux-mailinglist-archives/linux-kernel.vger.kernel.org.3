Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF5E48E933
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 12:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240844AbiANLbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 06:31:55 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:51057 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiANLbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 06:31:55 -0500
Received: from [192.168.100.1] ([82.142.23.158]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MJW18-1msrHl0OrI-00Ju2B; Fri, 14 Jan 2022 12:31:37 +0100
Message-ID: <d5f59216-793a-f5cf-2ab6-e3cf3a4a855f@vivier.eu>
Date:   Fri, 14 Jan 2022 12:31:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: fr
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-rtc@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20220113201920.3201760-1-laurent@vivier.eu>
 <20220113201920.3201760-4-laurent@vivier.eu>
 <CAK8P3a2QzMiga0FFVmTuefnq1OzsgyopiJN2he8043K0TRF1ng@mail.gmail.com>
 <a53e6d46-114f-7bb2-70b9-113c5f8a9c0e@vivier.eu>
 <CAMuHMdXN=2tjizcjA4vZ1FOSXDBNBkKH355fkfspgO9bOhp6_w@mail.gmail.com>
From:   Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v6 3/4] clocksource/drivers: Add a goldfish-timer
 clocksource
In-Reply-To: <CAMuHMdXN=2tjizcjA4vZ1FOSXDBNBkKH355fkfspgO9bOhp6_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0UGI68OHsoIg0aXdou6t+iNtAQu+NKLrIM+xtoNuF5A4FxrSc0N
 PSikFEz7ud2JUdT8/lrcWZgbodU4Ui7xUdXL9PvWdnNiMmS/ZsiiZBHe6r1uRXGzW7NH1Po
 11d3PZQhSg/yyAZvLUe5islJnhvOb/sCzawnMUiifWgfUMKCdCVBae02ofrNNDze0I7vA6d
 M1XOZYaFeDPiAM7Rgch6g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/ELH4PXPORM=:vY/EGpAJmAe0v8NsowcdZr
 O0pXABsu971y5qZ3KpJAOHIMLEfYweVs36N5a9WjbI+U7DbLyRxB2xbN5QVG06VUVscqohyZh
 cqYRlnVV1/BQpftbujUYhQbV5Ai4I0odpRQmQXv3UbW7eYqf5LyVymK8EbFIFZZXvm3X9UVRa
 kGkPcKqO0gXuo1tlB/0FWUJgioyqc+0NdyzGMFeixgAyNj5e34sqRs5KvSGNKzFNSy20VIGl8
 TRe6X32KTsqha6p5XzOmVG9y7u6rmfb4JBVoN5p4tieCu/WOzBbuTjMv+bOpmsGJTHU+A5X2Z
 /K1lm8gp4gIovXyrpdM3VkQD+ep3Rg+1XS/y5aIYYvfSLQp6ikc90EqXnK46NukzzUg/qD1Qf
 JbBqkxDxrn8Vv1EELZUs9PhisIRXV92hc+P34VMYxusOzWfz+b7OhR8Uf+eaCBzmg8kKOhPAv
 o8vbrTtj7ceuaAB2jDRIJxpcjOq91OF+s8YtvqSBztyqtrFETiYk6FiibDI8PdH9O8v1+3Qlu
 S0+UTKOXWT4ux3gzg0n5KHcA5gRi0tU5nSqZ1m4QFqNOs8jeYw1krZ5bQjsQTGd3Tk166QK6m
 eYEC7KO3Tp3jkkdm/+0eP4f/sAU4CI64LCTY+Upd0c7nl1gqW3E5m8i2T1kJ4LBoN0awarPy7
 ptbAZ8weyn14zf95iZGftj3xF5deShj/90EFBGBN/DVpIolTuS0diZ38+0p/3kobsKTA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 14/01/2022 à 12:12, Geert Uytterhoeven a écrit :
> Hi Laurent,
> 
> On Fri, Jan 14, 2022 at 12:03 PM Laurent Vivier <laurent@vivier.eu> wrote:
>> Le 14/01/2022 à 11:46, Arnd Bergmann a écrit :
>>> On Thu, Jan 13, 2022 at 9:19 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>>> +static int goldfish_timer_set_oneshot(struct clock_event_device *evt)
>>>> +{
>>>> +       struct goldfish_timer *timerdrv = ced_to_gf(evt);
>>>> +       void __iomem *base = timerdrv->base;
>>>> +
>>>> +       __raw_writel(0, base + TIMER_ALARM_HIGH);
>>>> +       __raw_writel(0, base + TIMER_ALARM_LOW);
>>>> +       __raw_writel(1, base + TIMER_IRQ_ENABLED);
>>>
>>> As mentioned elsewhere, the __raw_* accessors are not portable, please
>>> use readl()/writel() here, or possibly ioread32_be()/iowrite32_be() for
>>> the big-endian variant.
>>
>> We can't use readl()/writel() here because it's supposed to read from a little endian device, and
>> goldfish endianness depends on the endianness of the machine.
>>
>> For goldfish, readl()/writel() works fine on little-endian machine but not on big-endian machine.
>>
>> On m68k, you have:
>>
>> #define readl(addr)      in_le32(addr)
>> #define writel(val,addr) out_le32((addr),(val))
>>
>> and with goldfish it's wrong as the device is not little-endian, it is big-endian like the machine.
>>
>> same comment with ioread32_be()/iowrite32_be(): it will work on big-endian machine not on little-endian.
>>
>> We need an accessor that doesn't byteswap the value, that accesses it natively, and in all other
>> parts of the kernel __raw_writel() and __raw_readl() are used.
> 
> Hence Arnd's suggestion to define custom accessors in the Goldfish
> RTC driver, that map to {read,write}l() on little-endian, and to
> io{read,write}32_be() on big-endian.
> 
> BTW, I'd go for io{read,write}32() on little endian instead, for
> symmetry.

You mean something like that:

#ifdef CONFIG_CPU_BIG_ENDIAN
#define raw_ioread32 ioread32be
#define raw_iowrite32 iowrite32be
#else
#define raw_ioread32 ioread32
#define raw_iowrite32 iowrite32
#endif

and then use raw_ioread32()/raw_iowrite32() rather than readl()/writel()?

Thanks,
Laurent

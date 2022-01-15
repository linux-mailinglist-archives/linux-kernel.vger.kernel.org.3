Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581E048F920
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 20:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiAOTsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 14:48:15 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:44395 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiAOTsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 14:48:14 -0500
Received: from [192.168.100.1] ([82.142.13.186]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N79ly-1mH7NX1uCy-017Qwb; Sat, 15 Jan 2022 20:47:39 +0100
Message-ID: <db86e6b1-d6f7-3f57-246b-d7f8c882e933@vivier.eu>
Date:   Sat, 15 Jan 2022 20:47:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v8 4/4] m68k: introduce a virtual m68k machine
Content-Language: fr
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-rtc@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <20220115193245.3777833-1-laurent@vivier.eu>
 <20220115193245.3777833-5-laurent@vivier.eu>
 <CAMuHMdXBrPM5Zw+wtM3gi6k5n-i_OoWs_eZff27458hqepZV7A@mail.gmail.com>
From:   Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <CAMuHMdXBrPM5Zw+wtM3gi6k5n-i_OoWs_eZff27458hqepZV7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8IQk7dMKKQFaRROY1rEDyjyqT+yHtssPD+wgTVK1haU3bt5Nbeq
 ozwumov3iH3OBwd0H7ZOxbRiKRE91W/jjUMi3f9kVb2pbpEUqhwcnrcucXJUZCzOzc1TNyg
 nS6vNoXgLNi6XfcILwpelCkeS+8IBbuE6F5D8Oq+P/se8WgUdIhVgMB+VvCvZhPTIQbTY0N
 SeIi4dE+m+oXIUhJMQcQg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JvmOhXg6fFg=:wxZBxFyhB08Qt4HjmAXxbc
 WiA5AtqIbl+Fid7VDmAv+fwqmNObqVCbmoHwDMjE+Q1/+xI0UGnJpUlVkhzhNG1tGtAFpwLdm
 WmQvBhqrqqZGfDqMB9KWwzzIdM7ZfigCicIgbstLE3ca6mHNibUbgpwOAi+IiTJae+GxjKU8j
 es9INT7yFEY3Mb4Fa+BjKZaJgKliLKflpzph9aEFPM8DFQu30ypTTB0RgHwBeoowlAQ0KlbQ6
 gGRPXrwSg9lGKZYWqlBeiFn4FsjOXP10tAgs+4XHy9BjUvgk/ovT6n9rSX1xBgz51kvPecY8V
 scdin8pkUzfLLy0D1wFADE9vxKF1k2C1/wNq1ulUwIb0yyR2Nf9aGTiXIg5ofRIcKRSdza844
 LRKpuiIRePyXnSwfp5fY6GO7cKiD4FP7id1Y1VNlCvn+IV7qiMpR6/SnwtiRtHVV3I+eFg6AD
 Rs7Ku76EO4C4UjlxUkG1HrHgOmCzr3lgTkYZR6Aol5DSpgWqRzn/IORj4fQXLIvKGezzWrEof
 pHqpD7uaoUvDMfAulqmghS1P98Z/ZxXdN8rkBfUj6Xab+GiXnAMEnJ3fS7JOP+S3l9DsWqmxw
 s5Sufkew0SfD5d9jYjyEzxz0rRg+LK1JDiKWnoDD4OGn0wZEEyrM/w7NrTQY70grO/uQ2rCuv
 br9WXSELmN23EEgppFtJmpKDAHbK5Op4AnyzEaZ8ln6FbqwVeic3XbXqruqGNeQxQwHA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 15/01/2022 à 20:41, Geert Uytterhoeven a écrit :
> Hi Laurent,
> 
> On Sat, Jan 15, 2022 at 8:33 PM Laurent Vivier <laurent@vivier.eu> wrote:
>> This machine allows to have up to 3.2 GiB and 128 Virtio devices.
>>
>> It is based on android goldfish devices.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> 
> Thanks for your patch (the new versions keep on coming quickly).
> 
>> --- /dev/null
>> +++ b/arch/m68k/virt/platform.c
> 
>> +static int __init virt_platform_init(void)
>> +{
>> +       const struct resource goldfish_tty_res[] = {
>> +               DEFINE_RES_MEM(virt_bi_data.tty.mmio, 1),
>> +               DEFINE_RES_IRQ(virt_bi_data.tty.irq),
>> +       };
>> +       /* this is the second gf-rtc, the first one is used by the scheduler */
>> +       const struct resource goldfish_rtc_res[] = {
>> +               DEFINE_RES_MEM(virt_bi_data.rtc.mmio + 0x1000, 0x1000),
>> +               DEFINE_RES_IRQ(virt_bi_data.rtc.irq + 1),
>> +       };
>> +       extern unsigned long min_low_pfn;
> 
> checkpatch keeps on complaining.
> #include <linux/memblock.h> instead?

oh, yes, I didn't see it was defined here. Thank you.

I've updated my patch, the change will be in the next version.

Thanks,
Laurent

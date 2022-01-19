Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071F34936EA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352894AbiASJLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:11:54 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:50175 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352902AbiASJLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:11:50 -0500
Received: from [192.168.100.1] ([82.142.13.186]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MD9Ox-1n14SZ1YyP-0096n7; Wed, 19 Jan 2022 10:11:30 +0100
Message-ID: <64d4b52f-cb5b-2024-e7f9-7a5babc62170@vivier.eu>
Date:   Wed, 19 Jan 2022 10:11:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: fr
To:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        John Stultz <john.stultz@linaro.org>,
        linux-rtc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
References: <20220119000506.1299843-1-laurent@vivier.eu>
 <20220119000506.1299843-3-laurent@vivier.eu>
 <CAMuHMdXSFU4N+FLYkCLJCJcWJ74g=8Vr23Rx0cka-kDTBs6Z4Q@mail.gmail.com>
 <CAK8P3a2fjbet+nNAVt_WUxedUDWdRwb880KEa+MY1cFwYNC4SA@mail.gmail.com>
From:   Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v10 2/5] rtc: goldfish: introduce
 goldfish_ioread32()/goldfish_iowrite32()
In-Reply-To: <CAK8P3a2fjbet+nNAVt_WUxedUDWdRwb880KEa+MY1cFwYNC4SA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:T8yz0Y+A0/3p3L7v1wsH3Yxt6aKOeLEtDNJA8XfpY1VbjBfwuVk
 oq9p2rDgpFNv1++PCs29juQIeH4xVkxXK5RBZYlvQv7NehCInfzg3jvkl7z9mOebjwQrRRG
 M9zKL5wO3JV8hFx5jg+NEaHYNA2Xig9X0Pm4mRnh9hBROaACy3WggZ+oAdr/InqPnQtoy9y
 CdxQ92cnnbUusSWDuvcEw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MmoFlM7kCwg=:g3v93sE9r6Lpnljay8IzKn
 v0nf4mf9Ovz+FF4N34vKQy6Fs1sTM3Ko9ywe5XEUyciHJWkHJEAnTC5yJD5HPjLgL/aJCuNMU
 V1PUJ27HWxJ0FyfogHkSCcaN95bF4jb3cOojiruzCs9MIqYXHd6zyrZjI4lgrgLWA6guX2rJy
 szrTbez7SeGXywrgX9Culgw/s/YNLxl+k7tWRiRfxTWBGbBk1ZR9eUjbq/+/IlGNMMtjP7gb4
 V7u+px1ZHFsIHmyJyfGB3500BI5Q67z8tpcKf47lke0gvIOW1t6y1+OBfiN0EUMzqCMNeM9/z
 Cl0YQjpZt9Ro/4o0AhauOBHTMmqIIcstJEZB7XaeaWipmvzQ1Z1i/L8+zWsvlBc13K3m7Ivs7
 UIQczmxjOkcAGhaYqOxSB+K0PG8a1nZETqUxagKfKP8KbFsYY9KpXZcCa65dek9m2w3W2JFa3
 ScHqDOt9BwA3gZBPuMEidJP/lhVaYJC6C/vAKJccPz5vd0IKyH4B6CQQFUZ9bjL15MZoDjgZw
 zoazURbMEw4PjR9qgxGcXUCnakvOeZ3jKcrTZ+YCR+b6BRzeZN9jIctpdN3CN3lZceAmiioof
 KLYb59dnZ0d30i1+JIOORWYIpmSxjYQUftGsQ6sq2ODUL42DESTeQD9GQxJc3ohXPaHXxUy/Y
 O0R0vDkv9UxuyGnjrraczCd3Hn5uh/E7QAJWTGiyTFXC7lGL1yanTy4mUxjQadnXPrFA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 19/01/2022 à 09:49, Arnd Bergmann a écrit :
> On Wed, Jan 19, 2022 at 9:21 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Wed, Jan 19, 2022 at 1:05 AM Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> I've just discovered include/linux/goldfish.h, which already has gf_*()
>> accessors for 64-bit, so it'd make sense to move the above there,
>> and adjust the names.
> 
> Yes, good idea.

So the idea is to put goldfish accessors inside a "#ifdef CONFIG_M68K ... #else ... #endif" in 
include/linux/goldfish.h and not in generic-asm/io.h for the generic version and 
m68k/include/ams/io.h for the m68k version?

> 
>>
>> Arnd: note that the existing ones do use __raw_writel().
> 
> It looks like Laurent introduced that bug in da31de35cd2f ("tty: goldfish: use
> __raw_writel()/__raw_readl()") and could fix it up here. Laurent, was the intent

The idea was to use the native endianness of the CPU, I missed it can differ from the one of the 
architecture.

> of this earlier patch also to make the driver usabel for m68k, or are there
> any other targets you looked at that had mixed up endianness?
> 

Yes, the intent was to make it usable for m68k.
I think all the targets that use goldfish are little-endian, it's why there was no problem until now.

Let me know which solution you prefer, I will update the series accordingly.

Thanks,
Laurent

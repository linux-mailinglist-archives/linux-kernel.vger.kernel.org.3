Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B4448D747
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbiAMMNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:13:49 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:33721 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiAMMNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:13:49 -0500
Received: from [192.168.100.1] ([82.142.23.158]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MC2sF-1n2nNI1SaD-00CNUR; Thu, 13 Jan 2022 13:13:25 +0100
Message-ID: <9683b9b7-22f8-dd59-b8f5-3294002c9dda@vivier.eu>
Date:   Thu, 13 Jan 2022 13:13:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 3/3] m68k: virt: Remove LEGACY_TIMER_TICK
Content-Language: fr
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20220113103559.2577216-1-laurent@vivier.eu>
 <20220113103559.2577216-4-laurent@vivier.eu>
 <CAK8P3a2_cJi9+SNi9gK6+5kpBo4wmVw4hz42Bq_jm1+s6AvENQ@mail.gmail.com>
 <8c0b3146-35ee-b0b2-468b-1c8dcdaf64ee@vivier.eu>
 <CAK8P3a0GYm=Q5aPJuJJ7JoBQw4+QokgkMKv_D+YgYfzPODRYSQ@mail.gmail.com>
From:   Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <CAK8P3a0GYm=Q5aPJuJJ7JoBQw4+QokgkMKv_D+YgYfzPODRYSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gWqV6o1Xyy0Ag042sc9wQK/RLfj3E36EMp30cmMNVBJDeNyGU85
 aIJZuFvosWUhWyoOHmiJVEmNFtvR2r4JlxxaS64tkuL1pMffKw4tQaXesW5U/Ypz58LBkRC
 woKxw5weVLe0WEStN/VmUsaylE5iJvr3YHYa5RAFraushdwNs8RgyauJgAORVVC508THUMs
 cx5PSs31Fkqt0BxyPdZIw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cXQBwq5M7Nk=:WsbMwMa4YHlmaMQW7gqTjY
 /6V6FHG+p1TnGszo/P+hbJKzT6c9PGf1XOdhhZZpNsltdMC9wGJ4q893loHS2Qwt+MH6aV9XS
 uX8ZtyahyOvvolvuZAKhY/jRaNouL0zy8whiwQRJ3DD+oqhzCnEn3uqwtk3w1yyxYQSquPA3R
 zeYO+4OYfFgp/KyO90HrAKn9HwNG8hXRz8l6vm8l5qHm0URidZjhO4oNrYNyyUW9e7VRrhOXd
 wNXG/tFGxDkova74hHTJEitFgCOEDIj/5ssIafBJ1w0n93dCjaZB9LPexcrTlh1kTNgjRgN6v
 19yRMQ9lnzSCHGk7wPWSWMZOD0YsVmiN5JICJweY1rekQdDQIdgHm1ml7tusOEj9OsRaMYm1l
 Ny1r+AbM/0GifVSlltA267F7us2TcFCTC7GCUPgghkFQ9dvRJcfgMkFtJEBkpGjD1bnlMOyii
 +oiWD33hOnXX0eetenbs0VR2pkpsZHImAwbunmHO2BfLigF1o3CUlg4U5DGW9R4iBmcez5MOP
 //qb60ZR3uNhhDCNHtLKNV8hZX8LAWro6AP4hvHea/cjN9ehqVz4gfg21kn2LKhvdtNkLQUEa
 KQ2Kh5BxDWAibXYZRKpZg1PVUme+IllFltXUHq5vax4Aznjm8VBz7EmT1zkSlL6Aii5pelp6t
 7fYefoCMEJy4Bi3l2/8p4jScMdj5apojpvZcRqEkZxVXtGn+RFYwKdQUEPGb37af51OA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 13/01/2022 à 12:42, Arnd Bergmann a écrit :
> On Thu, Jan 13, 2022 at 12:32 PM Laurent Vivier <laurent@vivier.eu> wrote:
>> Le 13/01/2022 à 12:20, Arnd Bergmann a écrit :
>>> On Thu, Jan 13, 2022 at 11:35 AM Laurent Vivier <laurent@vivier.eu> wrote:
>>>>
>>>> Move virt machine to generic clockevents.
>>>>
>>>> cc: Arnd Bergmann <arnd@arndb.de>
>>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>>>
>>> The change looks good, but it appears that you only just add the legacy code
>>> in the same series, and it would be easier to just add the correct version
>>> first.
>>
>> In fact, I'd like to keep it separated for two reasons:
>> - it can be used as an example for people that want to move from legacy to clockevents,
>> - the machine with legacy timer tick is in use for more than one year by debian to propose a m68k
>> buildd and dev machine, so it is really well tested and robust. If there is a bug in my clockevents
>> use it will be easier to detect.
> 
> In general, it should be easier to do a correct generic driver than
> an implementation for the legacy interface.
> 
>>>> diff --git a/arch/m68k/virt/timer.c b/arch/m68k/virt/timer.c
>>>> index 843bf6ed7e1a..767b01f75abb 100644
>>>> --- a/arch/m68k/virt/timer.c
>>>> +++ b/arch/m68k/virt/timer.c
>>>
>>> How about moving the entire file to drivers/clocksource/timer-goldfish.c?
>>> It shouldn't even be architecture specific any more at this point. It probably
>>> still is in practice, but that could be addressed when another architecture
>>> wants to share the implementation.
>>
>> For the moment I'd like to have my m68k virt machine merged, and I think it will be easier if I hit
>> only one subsystem/maintainer. Moreover I don't know if I use correctly the goldfish-rtc,  so for
>> the moment I think it's better if I keep it hidden in arch/m68k/virt.
>>
>> But I can propose to send a patch to move this code to drivers/clocksource/timer-goldfish.c once the
>> machine is merged.
> 
> If you are not sure about that implementation, I would think that's an
> extra reason to
> submit it to the clocksource maintainers for review (added to Cc
> here). You should still
> be able to merge the driver in the new location through the m68k tree
> as part of your
> series, but regardless of where it goes I think it needs an Ack from them.
> 

OK, I move my code to drivers/clocksource/timer-goldfish.c and send a new version of the series.

Thanks,
Laurent

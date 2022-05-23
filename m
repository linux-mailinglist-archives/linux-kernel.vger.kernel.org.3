Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7564A5310A7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbiEWLQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbiEWLQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:16:13 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CDFAE75
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:16:07 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.139]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MBlgy-1o0kTv2V7E-00C9bM; Mon, 23 May 2022 13:15:39 +0200
Message-ID: <2ddd354e-a2b6-077c-25be-6ef1b2118d04@i2se.com>
Date:   Mon, 23 May 2022 13:15:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: vchiq: Performance regression since 5.18-rc1
Content-Language: en-US
To:     Phil Elwell <phil@raspberrypi.com>, paulmck@kernel.org
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        regressions@lists.linux.dev, riel@surriel.com,
        viro@zeniv.linux.org.uk
References: <77d6d498-7dd9-03eb-60f2-d7e682bb1b20@i2se.com>
 <20220521234616.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <bfad3d08-3268-5528-17c1-c17ef3949d96@i2se.com>
 <20220523044818.GS1790663@paulmck-ThinkPad-P17-Gen-1>
 <e0503433-615d-3834-4392-d0868caf47cf@i2se.com>
 <58cb7fbb-d317-83e6-0427-d3f3944b24b8@raspberrypi.com>
 <d7837ac0-fe6f-3bb2-c073-86e4864c5b5e@i2se.com>
 <aa19a0e1-2742-d74f-50b2-e81ba1fed7a6@raspberrypi.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <aa19a0e1-2742-d74f-50b2-e81ba1fed7a6@raspberrypi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:v0owzDcGf9fK8Ws4nmqKw7CTTh0KtFtbT7xHsqNwlfNkIs3Lb47
 j76pfT5mGqu42IQaykXUn6f1v9wNyleG6py7caYh1oLmg3OR2xqnRytXj0A0vCyQyNDHq4p
 bpUXeWitujI0KykBuJRIalFItdav7mnod8oFuYuoIRfWOxKnjSDEwwTSx+IGTUTEC4778uP
 WvBVOSaqyLrIq4/Zx08GQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:crw/mYeA454=:c9EahJuV/5teRXK2h66llH
 tjmO2GYEtkQYtF6LDTCSO0/wFIWdXgKie+rUunilr3hrV2sFMT+BSIRgF1TdDdNKB+7Ozz4dI
 YqYNSREonTfwWiONYz9hqm73vp0xc8NJDOGRY0b62ZZkERHv3sHqMcA3eic+hOIWUa22uksXb
 pb+7hNgcZXtpxHkD+Pyao6WVrfIWzn9uWCxhOEvz4r24sXz9Dm0fYkLtQw3J8MHG+dxoLYfNh
 0SwAH3fp6j/hCXzjLWVus/Z7PJC0Z3UXgxqgJvDChQiUo0vDGdvuLexYHRXM4kQB04P0xjFHs
 fs/6tIgzZLllgJSLO2VQLK67I1hzm1irxJJQ2/7M3MbBksbxoPuo2DpJokn0iEHi7GpJFX+Wo
 jhCgoGlXG61v+UaVauururNHwD1gJmorzb7ForHipGAbGhrk6ouk3fZQFJnZTuRBgv1/exIQS
 u9R9jFvw2M6B/SrhPP9ODJ/Wx977lnDfrXT2daqZxrZUZXxWfWkUzT9kLgzokAUQ9lrJw0V1m
 2TeqokhWV2HNdU6WjEcfvJr2ncwVzPzraANEOrut/7Lr2Je5BgNWhU/Szv96pwiQ/T7S0RPy9
 OKe/ey/eCuFxmU1HXcYsKBKNMxx+YwuMJCxnRtRyh3q3kwG56CCyVylCSqZg9Y1uThx/B+6lQ
 0JIzHs1rEawvTMIlqNehWljIebQa9sqStp+Kpw5hcoBHtiEA4NRcd5Jl/MytoI8NRglAjlQmg
 l4mU7UvnAl/6bTJ90BffvyUnYMQylRkWvrQKReSN4s+oIfkzrWZZ+Wzls8U=
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

Am 23.05.22 um 13:01 schrieb Phil Elwell:
> Hi Stefan,
>
> On 23/05/2022 11:48, Stefan Wahren wrote:
>> Hi Phil,
>>
>> Am 23.05.22 um 11:29 schrieb Phil Elwell:
>>> Hi Stefan,
>>>
>>> On 23/05/2022 07:19, Stefan Wahren wrote:
>>>> Hi Paul,
>>>>
>>>> Am 23.05.22 um 06:48 schrieb Paul E. McKenney:
>>>>> On Sun, May 22, 2022 at 05:11:36PM +0200, Stefan Wahren wrote:
>>>>>> Hi Paul,
>>>>>>
>>>>>> Am 22.05.22 um 01:46 schrieb Paul E. McKenney:
>>>>>>> On Sun, May 22, 2022 at 01:22:00AM +0200, Stefan Wahren wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> while testing the staging/vc04_services/interface/vchiq_arm 
>>>>>>>> driver with my
>>>>>>>> Raspberry Pi 3 B+ (multi_v7_defconfig) i noticed a huge 
>>>>>>>> performance
>>>>>>>> regression since [ff042f4a9b050895a42cae893cc01fa2ca81b95c] mm:
>>>>>>>> lru_cache_disable: replace work queue synchronization with 
>>>>>>>> synchronize_rcu
>>>>>>>>
>>>>>>>> Usually i run "vchiq_test -f 1" to see the driver is still 
>>>>>>>> working [1].
>>>>>>>>
>>>>>>>> Before commit:
>>>>>>>>
>>>>>>>> real    0m1,500s
>>>>>>>> user    0m0,068s
>>>>>>>> sys    0m0,846s
>>>>>>>>
>>>>>>>> After commit:
>>>>>>>>
>>>>>>>> real    7m11,449s
>>>>>>>> user    0m2,049s
>>>>>>>> sys    0m0,023s
>>>>>>>>
>>>>>>>> Best regards
>>>>>>>>
>>>>>>>> [1] - https://github.com/raspberrypi/userland
>>>>>>> Please feel free to try the patch shown below.  Or the pair of 
>>>>>>> patches
>>>>>>> from Rik here:
>>>>>>>
>>>>>>> https://lore.kernel.org/lkml/20220218183114.2867528-2-riel@surriel.com/ 
>>>>>>>
>>>>>>> https://lore.kernel.org/lkml/20220218183114.2867528-3-riel@surriel.com/ 
>>>>>>>
>>>>>> I tried your patch and Rik's patches but in both cases vchiq_test 
>>>>>> runs 7
>>>>>> minutes instead of ~ 1 second.
>>>>> That is surprising.  Do you boot with rcupdate.rcu_normal=1?
>>>> No, not explicit.
>>>>>    That would
>>>>> nullify my patch, but I would expect that Rik's patch would still 
>>>>> provide
>>>>> increased performance even in that case.
>>>> I will retest with a fresh SD card image.
>>>>>
>>>>> Could you please characterize where the slowdown is occurring?
>>>>
>>>> Unfortunately i don't have a deep insight into driver and 
>>>> vchiq_test tool. Just a user view.
>>>>
>>>> Do you think an strace would be a good starting point?
>>>>
>>>> @Phil Any advices to analyse this issue?
>>>
>>> Sending many small control packets:
>>>
>>>    vchiq_test -c 1 10000
>>>
>>> essentially tests interrupt latency. Using a small number of large 
>>> bulk transfers:
>>>
>>>    vchiq_test -b 10000 1
>>>
>>> becomes a test of how long it takes to lock down pages. It also 
>>> tests DMA transfer speeds, but since the DMA is run by the firmware 
>>> (which you aren't changing), I think you can rule that.
>> Thanks i will try.
>>>
>>> You may also find it helpful to include "force_turbo=1" in 
>>> config.txt for more predictable results.
>>>
>>> By the way, running our 5.18-rc7-based branch on a 3B+ I'm not 
>>> seeing any performance problems:
>> I assume you are using arm/bcm2709_defconfig and not 
>> arm/multi_v7_defconfig as me?
>
> That's correct. Simply switching to multi_v7_defconfig breaks vchiq 
> completely, presumably because it doesn't define CONFIG_BCM2835_VCHIQ.
sorry, forgot to mention. I that i enable VCHIQ as module on top of 
multi_v7_defconfig.
>
> Phil
>
>>>
>>> pi@raspberrypi:~$ time vchiq_test -f 1
>>> Functional test - iters:1
>>> ======== iteration 1 ========
>>> Testing bulk transfer for alignment.
>>> Testing bulk transfer at PAGE_SIZE.
>>>
>>> real    0m0.512s
>>> user    0m0.042s
>>> sys     0m0.165s
>>>
>>> Phil

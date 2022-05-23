Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39734530F6B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbiEWKtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbiEWKs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:48:56 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D534C426
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:48:54 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.139]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MZkYx-1oO4S13brb-00Wn0B; Mon, 23 May 2022 12:48:14 +0200
Message-ID: <d7837ac0-fe6f-3bb2-c073-86e4864c5b5e@i2se.com>
Date:   Mon, 23 May 2022 12:48:11 +0200
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
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <58cb7fbb-d317-83e6-0427-d3f3944b24b8@raspberrypi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BjC4OseuA4cL0PvW7RTzX5YtTVMWOqTAeYwhokeKIsXNbb9CPfw
 pUhb7dNnCm2NiusHR0APM5IMXoIePUe9WmMweMuP2WVxwAVbYImGX6WhVSf853F9+7UG4e9
 2GZ7Uk3iFa2GldSoKxwvMi3NE3rpvJmma0l/2SjnhNwQgt7DIHqI2RLZH2JPqrmA8PjiRs9
 4rZx2ntDMYgJikedgB+hQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LgeQ+gDqUY0=:Pg9ruZotr3hgP9piIWlJby
 iHXFSc9KwRG/R409IQdNYeg7HTPIz/XQut1mPqe9Hn7TEhgw9s0Kut/Sem1I4ZnsxHksj3iVk
 9/ya7KMijeC6xyQ8gqLMTvWjNoODS7jPwlawOlwpKT/c07M+BNaDrYRuEuWYmrUU9TrTIhf1j
 FaGSSwXCk1GmmH9QI/zU/uLCPDrHmoYtZTStZ+qSBulqryQARQC08JFd74C9mwXpfBiigU2nv
 U8gUGzEN3ay6iw6JYi+xz6nD6hth9i6oKfjV0Ixn5sciY4AyD4gbsuMqp47cXWlpvfqkgqwEC
 joQQrBfcxC8/UoH9S2m6LRuo8Ca1IO9CIRTZ3rA83a9qUujHM8b+mkv1LMgmvHerJpzJMtTEO
 MJXhdzzub5wkkZS8NTyV2hmClTPxnww+hX2HxcmuE611JMYbiSgeFNpGCdGYhkvbSPZTCidSs
 6YBXlBn3GnKrqyjZ+iSTHDnQjKqWVyrfVQWgFS3RPKGEsT+zbdBZA+1dBf21wvkDnfedZNi1v
 VsYiai/95I5vdVDthbNG4o2oRYke0mItwB0DopafsRLwcR4aoodlZ8EQgZp0YifHYac6gUHSW
 I8PBUhUvpIzY7R+R/2x82CkrjGCLSO0xwA5x/7eGZ6qNIEODFNLmTArzY3QU0JE9BBvZ2m9Yb
 ICBCoskLIPMHRyJQYUBwn4pJtxK1D+bSyOyScnksXux127vttI2hMb43b1MV39m6XfhfMlo0I
 A86rR/8Pbk31zIMitFSfmuiFQxBZ1+0zTdAU3cHGiaM9BFKe9AoFsbSSwTw=
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

Am 23.05.22 um 11:29 schrieb Phil Elwell:
> Hi Stefan,
>
> On 23/05/2022 07:19, Stefan Wahren wrote:
>> Hi Paul,
>>
>> Am 23.05.22 um 06:48 schrieb Paul E. McKenney:
>>> On Sun, May 22, 2022 at 05:11:36PM +0200, Stefan Wahren wrote:
>>>> Hi Paul,
>>>>
>>>> Am 22.05.22 um 01:46 schrieb Paul E. McKenney:
>>>>> On Sun, May 22, 2022 at 01:22:00AM +0200, Stefan Wahren wrote:
>>>>>> Hi,
>>>>>>
>>>>>> while testing the staging/vc04_services/interface/vchiq_arm 
>>>>>> driver with my
>>>>>> Raspberry Pi 3 B+ (multi_v7_defconfig) i noticed a huge performance
>>>>>> regression since [ff042f4a9b050895a42cae893cc01fa2ca81b95c] mm:
>>>>>> lru_cache_disable: replace work queue synchronization with 
>>>>>> synchronize_rcu
>>>>>>
>>>>>> Usually i run "vchiq_test -f 1" to see the driver is still 
>>>>>> working [1].
>>>>>>
>>>>>> Before commit:
>>>>>>
>>>>>> real    0m1,500s
>>>>>> user    0m0,068s
>>>>>> sys    0m0,846s
>>>>>>
>>>>>> After commit:
>>>>>>
>>>>>> real    7m11,449s
>>>>>> user    0m2,049s
>>>>>> sys    0m0,023s
>>>>>>
>>>>>> Best regards
>>>>>>
>>>>>> [1] - https://github.com/raspberrypi/userland
>>>>> Please feel free to try the patch shown below.  Or the pair of 
>>>>> patches
>>>>> from Rik here:
>>>>>
>>>>> https://lore.kernel.org/lkml/20220218183114.2867528-2-riel@surriel.com/ 
>>>>>
>>>>> https://lore.kernel.org/lkml/20220218183114.2867528-3-riel@surriel.com/ 
>>>>>
>>>> I tried your patch and Rik's patches but in both cases vchiq_test 
>>>> runs 7
>>>> minutes instead of ~ 1 second.
>>> That is surprising.  Do you boot with rcupdate.rcu_normal=1?
>> No, not explicit.
>>>    That would
>>> nullify my patch, but I would expect that Rik's patch would still 
>>> provide
>>> increased performance even in that case.
>> I will retest with a fresh SD card image.
>>>
>>> Could you please characterize where the slowdown is occurring?
>>
>> Unfortunately i don't have a deep insight into driver and vchiq_test 
>> tool. Just a user view.
>>
>> Do you think an strace would be a good starting point?
>>
>> @Phil Any advices to analyse this issue?
>
> Sending many small control packets:
>
>    vchiq_test -c 1 10000
>
> essentially tests interrupt latency. Using a small number of large 
> bulk transfers:
>
>    vchiq_test -b 10000 1
>
> becomes a test of how long it takes to lock down pages. It also tests 
> DMA transfer speeds, but since the DMA is run by the firmware (which 
> you aren't changing), I think you can rule that.
Thanks i will try.
>
> You may also find it helpful to include "force_turbo=1" in config.txt 
> for more predictable results.
>
> By the way, running our 5.18-rc7-based branch on a 3B+ I'm not seeing 
> any performance problems:
I assume you are using arm/bcm2709_defconfig and not 
arm/multi_v7_defconfig as me?
>
> pi@raspberrypi:~$ time vchiq_test -f 1
> Functional test - iters:1
> ======== iteration 1 ========
> Testing bulk transfer for alignment.
> Testing bulk transfer at PAGE_SIZE.
>
> real    0m0.512s
> user    0m0.042s
> sys     0m0.165s
>
> Phil

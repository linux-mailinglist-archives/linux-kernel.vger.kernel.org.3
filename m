Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D62E5A9831
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbiIANM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiIANMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:12:07 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568D53A489
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:08:13 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r22so16336259pgm.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 06:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=4WYVieycjlFw6I1nrPbVmRi8cx/ip/dDUgCKcH6IdUU=;
        b=zLVx+Iy0lwuIRgbsexns+3yQ72TiAMU7Kk4y6wBkdvQY6gKyz1uDh/AsXvcB0ylka8
         G0sa3IIbbmkCCps8/2Ye7a9JbRYlPRJGPXrgIoScoA4yVBq2yz1m/OHps4k1+Hlr0VUj
         MFpCQoMnS70zRsqBVJMV3WeQpziiLzwmEy5M9G7cQw2ratbiNpBt5FNDvyQAQjOl+cW7
         EB2VcGprWRj70MXj/BgxqbSj1Mvho1E9NGAEwrzc1IKZDykNKB1NNXipl8YfbkJPag7d
         fg0v9BRAQfGtELIi51X5p/REuZQoNZ72Cbnj6V2MfYGViG2aPVml4YZpNJEX3JKqrott
         5vUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=4WYVieycjlFw6I1nrPbVmRi8cx/ip/dDUgCKcH6IdUU=;
        b=Zva0oF0A9QOluk4eVb+IG2A2T7QV/JoiWtwAF4CCXzLcqWZhToxcM+F/HxHI1k9noc
         PHbqWyaEriBeJbtjuLEUhCYKnSgQfDyipPyiIN+JvI9TObA99xdoqIWA/0H33kNWZf+s
         DyMflWrNS1M/03Kb22DmDUSDMW/n6IpnYlFsFdDod/WoAaBN8vck1NXv2rVuJZZsKayn
         ZajgWzTpFCpk6wRWFQH/ErZfGrRcIATV1F0r5e85C2gWm8FmVt8lIfRXH4UzGnrUImMe
         efT0Ebnvt0J4TEt7JSzDghL3KrRzjZNpiw0Vuap1AHwNQMlvi/i1VpV8XUXEodmwkOMD
         QXBg==
X-Gm-Message-State: ACgBeo0JlPqDNTMffAdp/N9J3KJwoqEJirR3ediPJYusTlkVwqBJSty0
        Zk4T5/ZVejwIig2d2RdcZiFJ9A==
X-Google-Smtp-Source: AA6agR6/S/aFlGqchK3uCkAVkH/Ak2kM+OhkheqiGeuJC0oEUPbcAW/XSXtdKKnfRFlDMtP90cnm7g==
X-Received: by 2002:a05:6a00:2402:b0:52c:81cf:8df2 with SMTP id z2-20020a056a00240200b0052c81cf8df2mr30788878pfh.40.1662037692786;
        Thu, 01 Sep 2022 06:08:12 -0700 (PDT)
Received: from [10.255.214.146] ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id 4-20020a17090a198400b001f1694dafb1sm3234229pji.44.2022.09.01.06.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 06:08:12 -0700 (PDT)
Message-ID: <37991cd2-a893-9b43-d26d-db5d829d6b05@bytedance.com>
Date:   Thu, 1 Sep 2022 21:08:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: Re: [PATCH 1/5] sched/fair: ignore SIS_UTIL when has idle core
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
 <20220712082036.5130-2-wuyun.abel@bytedance.com>
 <20220829130831.odhemmcmuecqxkbz@techsingularity.net>
 <51009414-5ffb-b6ec-a501-7b2514a0f3cc@bytedance.com>
 <20220829145621.7cxrywgxow5ov7ki@techsingularity.net>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220829145621.7cxrywgxow5ov7ki@techsingularity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/22 10:56 PM, Mel Gorman Wrote:
> On Mon, Aug 29, 2022 at 10:11:39PM +0800, Abel Wu wrote:
>> Hi Mel, thanks for reviewing!
>>
> 
> No problem, sorry it took so long.
> 
>>> So, first suggestion is to move this patch to the end of the series as
>>> the other patches are relatively harmless. They could even be merged in
>>> isolation as a cleanup.
>>>
>>> Second, using the other patches as your baseline, include in the
>>> changelog what you tested that showed a benefit, what type of machine
>>> it was and in particular include the number of cores, nodes and the
>>> span of the LLC.  If you measured any regressions, include that as well
>>> and make a call on whether you think the patch wins more than it loses.
>>> The reason to include that information is because the worst corner case
>>> (all CPUs scanned uselessly) costs more the larger the span of LLC is.
>>> If all the testing was done on a 2-core SMT-2 machine, the overhead of the
>>> patch would be negligible but very different if the LLC span is 20 cores.
>>> While the patch is not obviously wrong, it definitely needs better data,
>>> Even if you do not have a large test machine available, it's still helpful
>>> to have it in the changelog because a reviewer like me can decide "this
>>> needs testing on a larger machine".
>>
>> Thanks for your detailed suggestions. I will attach benchmark results
>> along with some analysis next time when posting performance related
>> patches.
>>
> 
> Thanks, include this in the changelog. While I had different figures for
> hackbench, the figures are still fine. I had similar figures for netperf
> (~3-4% regression on some machines but not universal). The tbench figures
> are interesting because for you, it was mostly neutral but I did test
> it with a CascadeLake machine and had worse results and that machine is
> smaller in terms of core counts than yours.

Interesting, my test machine model is Intel(R) Xeon(R) Platinum 8260 CPU
@ 2.40GHz, which is based on Cascade Lake.  This time I re-tested with
SNC enabled, so each NUMA node now has 12 cores (was 24), but the tbench
result is still neutral..

I just remembered that in the Conclusion part of SIS filter v2 patchset
mentioned a suspicious 50%~90% improvement in netperf&tbench test. Seems
like the result can be misleading under certain conditions.

https://lore.kernel.org/lkml/20220409135104.3733193-1-wuyun.abel@bytedance.com/

> 
>>>
>>> I did queue this up the entire series for testing and while it sometimes
>>> benefitted, there were large counter-examples. tbench4 on Zen3 showed some
>>> large regressions (e.g. 41% loss on 64 clients with a massive increase in
>>> variability) which has multiple small L3 caches per node. tbench4 (slightly
>>> modified in mmtests to produce a usable metric) in general showed issues
>>> across multiple x86-64 machines both AMD and Intel, multiple generations
>>> with a noticable increase in system CPU usage when the client counts reach
>>> the stage where the machine is close to saturated. perfpipe for some
>>> weird reason showed a large regression apparent regresion on Broadwell
>>> but the variability was also crazy so probably can be ignored. hackbench
>>> overall looked ok so it's possible I'm wrong about the idle_cores hint
>>> being often wrong on that workload and I should double check that. It's
>>> possible the hint is wrong some of the times but right often enough to
>>> either benefit from using an idle core or by finding an idle sibling which
>>> may be preferable to stacking tasks on the same CPU.
>>
>> I attached my test result in one of my replies[1]: netperf showed ~3.5%
>> regression, hackbench improved a lot, and tbench4 drew. I tested several
>> times and the results didn't seem vary much.
>>
>>>
>>> The lack of data and the lack of a note on the potential downside is the
>>> main reason why I'm not acking patch. tbench4 was a particular concern on
>>> my own tests and it's possible a better patch would be a hybrid approach
>>> where a limited search of two cores (excluding target) is allowed even if
>>> SIS_UTIL indicates overload but has_idle_cores is true.
>>>
>>
>> Agreed. And the reason I will exclude this part in v2 is that I plan to
>> make it part of another feature, SIS filter [2]. The latest version of
>> SIS filter (not posted yet but soon) will contain all the idle cpus so
>> we don't need a full scan when has_idle_core. Scanning the filter then
>> is enough. While it may still cost too much if too many false positive
>> bits in the filter. Does this direction make sense to you?
>>
>> [1] https://lore.kernel.org/lkml/eaa543fa-421d-2194-be94-6a5e24a33b37@bytedance.com/
>> [2]
>> https://lore.kernel.org/lkml/20220619120451.95251-1-wuyun.abel@bytedance.com/
>>
> 
> The filter idea is tricky, it will always struggle with "accurate
> information" vs "cost of cpumask update" and what you link indicates that
> it's updated on the tick boundary. That will be relatively cheap but could
> mean that searches near the point of saturation or overload will have
> false positives and negatives which you are already aware of given the

I didn't exclude the CPU_NEWLY_IDLE case, yet still the filter worked
the way unexpected as I found recently. The propagation of the idle or
sched-idle cpus can be skipped if rq->avg_idle is small enough (which
is sysctl_sched_migration_cost 500us by default). This can result in
the benchmarks of frequent wakeup type losing some throughput.

So the filter of my latest version will be updated at __update_idle_core
rather than load_balance, and reset when a full domain scan fails. I
will include more details in the log when posting, and I wish you can
give some advice then.

> older series. It does not kill the idea but I would strongly suggest that
> you do the simple thing first. That would yield potentially 3-4 patches
> at the end of the series
> 
> 1. Full scan for cores (this patch effectively)
> 2. Limited scan of 2 cores when SIS_UTIL cuts off but has_idle_cores is true
>     (Compare 1 vs 2 in the changelog, not expected to be a universal win but
>      should have better "worst case" behaviour to be worth merging)
> 3. Filtered scan tracking idle CPUs as a hint while removing the
>     "limited scan"
>     (Compare 2 vs 3)
> 4. The SIS "de-entrophy" patch that tries to cope with false positives
>     and negatives
>     (Compare 3 vs 4)
> 
> That way if the later patches do not work as expected then they can be
> easily dropped without affecting the rest of the series.
> 

Copy. Thanks for your advice!

Best Regards,
Abel

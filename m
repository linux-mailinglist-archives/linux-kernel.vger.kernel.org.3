Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE9456B74A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbiGHKcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiGHKcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:32:10 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E570C237D8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 03:32:07 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id e16so10424023pfm.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 03:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=eQFy7/H89wh9U8Zp7DF25j55v5hOBUhnuJKQrnCV4WY=;
        b=TvpqDZOgTYDC169WiiIkFuG2tRMzplX0xp7d3M5n6Y3q/zbF3/BUjZiuFvWp7yLDVs
         6Ux3fdc6pET/hhNZ2fQ4X3S1h9oLHKTCi+wwSY5uptNVKZaEKoea+HEWfH0c9PiOgEvu
         6bb8FTHlwCjZr+LV13B/Tg5a5iaeLAEIsYl2QOboW0883DirLnvftnoysz5miY61bg4I
         E+UQJJbTBFrRVjzKO3bco26ySsiMl3DpoCwqrcdlJ5QjKE3XnIAJNdAKV4VgksEw4fz0
         fmdOd+MN0HMux92VIeA+HZYNHlT8OzuZbdv5beN41D+Y9dv+eFtJ33U+Q+qLD7cAQISQ
         v3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eQFy7/H89wh9U8Zp7DF25j55v5hOBUhnuJKQrnCV4WY=;
        b=xfn6z/gDtycbZ4XpNbK/ryLfvbOLMSv5VblJb1swBAXE933grL6SZmZfey0A68/jXb
         mkfJHbqHY8z3Hhf/fgfWRUjYreXGoDjNa6Do/f5gnF5ZeYLIySl6Z8+r1Jjfk+yC3muu
         uR3MOLSf6jrwMEp42JpfXI9qqwBIMoaLToC9FM01Xy0850r6Rm2OwNEKxgRqqx44bTJl
         5HYoI8+ris1NSpZ97evEEm3IKZMuDLCBSFFniU8SPkbKOwd6kTqIA1Y61sWSi4twZm6B
         5RPpxh9pqY6L1yZakis46WmIoXZxKL/+hUTOCA4Va1UwdF5T8FSjCxFdn0Y9Fk3GWr/r
         Nobg==
X-Gm-Message-State: AJIora9SSqLeZbV6Vx0nUXrX+ZUJIQucEJLuHRwd665A9efyIIVD5xKG
        I08lknzAiEgaieXVezW5tTN2Xg==
X-Google-Smtp-Source: AGRyM1tsILb67TEwo7ORCnKinZRhiVGvZLOOYC6PftWm0gYqcruw2zazD3f4SU6uNAaJ6R880pgskA==
X-Received: by 2002:aa7:9005:0:b0:528:a99b:df47 with SMTP id m5-20020aa79005000000b00528a99bdf47mr2986492pfo.71.1657276327435;
        Fri, 08 Jul 2022 03:32:07 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id y185-20020a6264c2000000b0052ab3039c4esm840783pfb.8.2022.07.08.03.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 03:32:06 -0700 (PDT)
Message-ID: <1a9656a2-024e-497f-a0e6-3ec65910ab54@bytedance.com>
Date:   Fri, 8 Jul 2022 18:31:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [External] Re: [PATCH] sched/fair: Remove unused parameter idle
 of _nohz_idle_balance()
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <20220707034143.37991-1-jiahao.os@bytedance.com>
 <CAKfTPtAb==WjCpmqOaVdwna6c+yxxskkRKwBKB7_EuJC9SrmJA@mail.gmail.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <CAKfTPtAb==WjCpmqOaVdwna6c+yxxskkRKwBKB7_EuJC9SrmJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/7 Vincent Guittot wrote:
> On Thu, 7 Jul 2022 at 05:42, Hao Jia <jiahao.os@bytedance.com> wrote:
>>
>> Since commit 7a82e5f52a35 ("sched/fair: Merge for each idle cpu
>> loop of ILB") was merged. The parameter idle of _nohz_idle_balance()
> 
> The description of the commit should be in a single line.
> 
> commit 7a82e5f52a35 ("sched/fair: Merge for each idle cpu loop of ILB")
> 

Thank you for your suggestion.

how about this？

Commit 7a82e5f52a35 ("sched/fair: Merge for each idle cpu loop of ILB")
has been merged. The parameter idle of _nohz_idle_balance()
is not used anymore so we can remove it.

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>> is not used anymore so we can remove it.
>>
>> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> 
>> ---
>>   kernel/sched/fair.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 77b2048a9326..8d4be2a95e37 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -10682,8 +10682,7 @@ static bool update_nohz_stats(struct rq *rq)
>>    * can be a simple update of blocked load or a complete load balance with
>>    * tasks movement depending of flags.
>>    */
>> -static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>> -                              enum cpu_idle_type idle)
>> +static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
>>   {
>>          /* Earliest time when we have to do rebalance again */
>>          unsigned long now = jiffies;
>> @@ -10798,7 +10797,7 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>>          if (idle != CPU_IDLE)
>>                  return false;
>>
>> -       _nohz_idle_balance(this_rq, flags, idle);
>> +       _nohz_idle_balance(this_rq, flags);
>>
>>          return true;
>>   }
>> @@ -10818,7 +10817,7 @@ void nohz_run_idle_balance(int cpu)
>>           * (ie NOHZ_STATS_KICK set) and will do the same.
>>           */
>>          if ((flags == NOHZ_NEWILB_KICK) && !need_resched())
>> -               _nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK, CPU_IDLE);
>> +               _nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK);
>>   }
>>
>>   static void nohz_newidle_balance(struct rq *this_rq)
>> --
>> 2.32.0
>>

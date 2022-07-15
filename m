Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEED576557
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 18:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbiGOQfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 12:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGOQfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 12:35:38 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7207239B84
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 09:35:36 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id e16so5068257pfm.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 09:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lKWmBSTCMlmIEeA4zRqvclaf/qy9ca8IGkb6K9HUTlc=;
        b=enu3kLeeE4/6bWKrtxdgNTcYL/Tm1XiFS61nhgw0d5zIh0wKfe7OiQVjFEkJzpgKVx
         cqhZEvsJQTONiuOgmig3u8v3wxtnXTZSgSUqhNZoNj9utSud78pbcUBq9DNyLjuftVVp
         soE8bIjibPdyMFNsxJa3AHUJ5gYE3WDZGzNYRBUQcGickNY3n/62BaLnby0L49BKZ4fx
         CqBVNH01g8sGXuhPadPHUlM2zdiV/pedJFU+YnR76HYNqOIg4DXxrw8pGSGPlwIypJIh
         CQS4YMYa96J8Z+EHXBHoTumD8MynLDk2R403WnOQodUYrUrRz3Jwdh5eH4wn+T3fEsix
         XM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lKWmBSTCMlmIEeA4zRqvclaf/qy9ca8IGkb6K9HUTlc=;
        b=mzEDxKFuwQbVve5nZ/giwh00KEI1xOnWHNb/4483PjH24r8LN0I6ya5TWEK1CFBdKY
         mFxC/BcBJf8IP+QaI9zB7pO4aIH2uGaQDYgYyOzUvLNyWRYGr0uWSuC1JeRSvp7RnNbh
         yMYzvtJ3GmBtRJOzGbZ5D/3Bd3IW5eSu5MFnZ0J9mYIrUgay2cXnPKQ1GZ19O8Q1Yc5g
         7Bp6AhMlsru7mWCMGxJXAs6q61IcZQKSe/UH9xS3Wq5ufOtrLRgSdLot519diLSHqUvX
         KGqyEjWiELASL+qaVW+HojLMU7ExCFFtP6xfINQk3GYB2dl3sSLkWJjdfxfI9Ac8J1HN
         lzTw==
X-Gm-Message-State: AJIora8sNoWzjJbDgHx9c0kpBUjHISQgQ8u4AjBfRy7Wv4QO4t/fM8XJ
        1FOK8xwuJ9UxGwNtjaje7iVx6w==
X-Google-Smtp-Source: AGRyM1uJou4x2IkNmR+pqvxyd9OYV4elaqT7GwPZmP2P2plAk5seFMlGzHIE/evqVtx6tOrm+k82oQ==
X-Received: by 2002:a63:5366:0:b0:411:415a:5888 with SMTP id t38-20020a635366000000b00411415a5888mr12786096pgl.286.1657902935909;
        Fri, 15 Jul 2022 09:35:35 -0700 (PDT)
Received: from [10.255.246.141] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902784900b0016bea2a0a8dsm3712427pln.91.2022.07.15.09.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 09:35:35 -0700 (PDT)
Message-ID: <8a54fbcc-16f5-8b0a-7254-2b14810827b1@bytedance.com>
Date:   Sat, 16 Jul 2022 00:35:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.1
Subject: Re: [External] Re: [PATCH v2 09/10] sched/fair: stop load tracking
 when task switched_from_fair()
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
 <20220713040430.25778-10-zhouchengming@bytedance.com>
 <27f0675e-8ac3-2200-749f-7290a256e3d9@arm.com>
 <fe40bae5-7ec4-d5d2-ffb8-1387300dbbaf@bytedance.com>
 <7eae9f41-7b33-2fc1-6b31-bbfd8d7b1364@arm.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <7eae9f41-7b33-2fc1-6b31-bbfd8d7b1364@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/15 19:15, Dietmar Eggemann wrote:
> On 14/07/2022 15:43, Chengming Zhou wrote:
>> On 2022/7/14 20:33, Dietmar Eggemann wrote:
>>> On 13/07/2022 06:04, Chengming Zhou wrote:
> 
> [...]
> 
>>> IMHO, a queued !fair task when switching back to fair will already be
>>> enqueued (attached) as a fair task in __sched_setscheduler() prior to
>>> the check_class_changed() call.
>>
>> Right, this is true for a queued !fair task, it will enqueued (attached) before
>> check_class_changed().
>>
>> enqueue_task_fair()
>>   enqueue_entity()
>>     update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH)
>>       if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))  --> true
>>         __update_load_avg_se(now, cfs_rq, se)  --> (1)
>> check_class_changed()
>>   switched_to_fair()
>>     attach_task_cfs_rq()
>>       attach_entity_cfs_rq()
>>         update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD)
>>           if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))  --> true
>>             __update_load_avg_se(now, cfs_rq, se)  --> (2)
>>
>>
>> 1. for queued !fair: (1) delta = (now - last_update_time), last_update_time is the time
>>    when switched_from_fair().
>>
>> 2. for !queued !fair: (2) delta = (now - last_update_time), last_update_time is the time
>>    when switched_from_fair().
>>
>> The scenario in the commit message only cover !queued !fair case, I forget the queued !fair
>> case, their problem is the same.
> 
> OK, that makes sense to me then.
> 
>>> I can't see how this will work with your proposed change in using
>>> last_update_time=0 for fair->!fair->fair class changes?
>> If we reset last_update_time=0 for !fair task, then:
>>
>> 1. for queued !fair: will not do (1) since the if condition is false.
>>
>> 2. for !queued !fair: will not do (2) since the if condition is false.
> OK.
> 
> [...]
> 
>>>> This patch reset it's sched_avg last_update_time to 0, stop load
>>>> tracking for !fair task, later in switched_to_fair() ->
>>>> update_load_avg(), we can use its saved sched_avg.
>>>>
>>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>>> ---
>>>>  kernel/sched/fair.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 50f65a2ede32..576028f5a09e 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -11552,6 +11552,11 @@ static void attach_task_cfs_rq(struct task_struct *p)
>>>>  static void switched_from_fair(struct rq *rq, struct task_struct *p)
>>>>  {
>>>>  	detach_task_cfs_rq(p);
>>>> +
>>>> +#ifdef CONFIG_SMP
>>>> +	/* Stop load tracking for !fair task */
> 
> You're not really stopping p->se load tracking by doing this. We don't
> do this outside fair anyway. IMHO, you freeze p->se's PELT _avg/_sum
> values to be used as initial values when re-entering fair.
> 

Yes, you are right, this comment is misleading and wrong, will delete it.

Thanks very much for your review!


>>>> +	p->se.avg.last_update_time = 0;
>>>> +#endif
>>>>  }
>>>>  
>>>>  static void switched_to_fair(struct rq *rq, struct task_struct *p)
> 

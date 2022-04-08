Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDAA4F8ED2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbiDHGZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiDHGZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:25:17 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFACAD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 23:23:14 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id l9so633657plg.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 23:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=geQ/KYaC6Z1QkN4BxN0MGOhNfu4u8jgolEpjQjjs6lw=;
        b=rkgjqsrLnEiB6FUAL9CYfCZCnVqJET8nRlPxaS0vomUxUYp/ey+b8Nl9QuoWhRGLvq
         lvgp8gG3SPZhRBRfQo7hqmN2n0QyprJ8e8zFaddGqIU6iSVSHgMYV+STZkcZ8Apy9EIh
         lCD+oExwjhAz/9NaNFnP1yGWi0HU14nzeOersWj0JEPsLsMQX7r8xZ5R8QGDZ9Jpwo8K
         Mw8dnxbYgO/XmYKFXGJ8f+01H+TcSLkGvYWz0I+ZpXeP8k6FsNrRx0nej3z9DZ5sQzCq
         tNCK2zF0OrkPNQZ8sDn4YflsLq+lLj6rVzqNve5W6nbpztBJ6cj47OWuFUgozpKHt0fa
         9Xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=geQ/KYaC6Z1QkN4BxN0MGOhNfu4u8jgolEpjQjjs6lw=;
        b=pXD9ehkvU21piUdkQKehd5ilTv4VU3Vk7zjvB2F1bEt1feHAxol5NWYpTaaThu+TJj
         lLVSyFxG0FRAO+PuGi69Jtc6SpidSPFX9IcIWzemc11wqZcWgwotBqD8ZQApKIGyPg78
         4c8akGVkG5EGvNETAcv2AelFRdt5i4pThE4fpN3mUl4ObTDi/ZzCGZEZskDQRezGLEcY
         0eLlIfGa/qfK0j59NFvB63URtXtpq7ug8zBes/7QzJv3lsvBwuAVXDS5jKGiTULMcGI1
         Z7fji0eqbvMP5KQKXnvJcQdm8+ZoyJ6sPkYz2kGExTDuJCHyauC5xOPp3ZcWaCbq0+d8
         2Q3g==
X-Gm-Message-State: AOAM532ILCU/KzJ4Pj5Sh9PkCUYPHfBD27gu7U/nwiSZTSfSnBqk6XcY
        cLAwvLUf0GG85eXGZilRpWgxkA==
X-Google-Smtp-Source: ABdhPJx3htSqcke6EbXNUh2XhkRjjIJ+u1h5fQfUvumoNHKzEMdLGaMqbqwCjz5amcXry7ITs26x8w==
X-Received: by 2002:a17:902:7006:b0:156:3cbe:6b04 with SMTP id y6-20020a170902700600b001563cbe6b04mr17331918plk.68.1649398993897;
        Thu, 07 Apr 2022 23:23:13 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e6c:f010:ad54:3135:7c62:394f? ([2409:8a28:e6c:f010:ad54:3135:7c62:394f])
        by smtp.gmail.com with ESMTPSA id z6-20020a056a00240600b004e17ab23340sm25998725pfh.177.2022.04.07.23.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 23:23:13 -0700 (PDT)
Message-ID: <04e7c9aa-da4f-55ba-f329-5ac236dd5a6b@bytedance.com>
Date:   Fri, 8 Apr 2022 14:23:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] Re: [PATCH 1/2] sched/fair: Fix cfs_rq_clock_pelt()
 for throttled cfs_rq
Content-Language: en-US
To:     Benjamin Segall <bsegall@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com
References: <20220407021729.16655-1-zhouchengming@bytedance.com>
 <xm26tub4vcg9.fsf@bsegall-linux.svl.corp.google.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <xm26tub4vcg9.fsf@bsegall-linux.svl.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/8 04:57, Benjamin Segall wrote:
> Chengming Zhou <zhouchengming@bytedance.com> writes:
> 
>> Since commit 23127296889f ("sched/fair: Update scale invariance of PELT")
>> change to use rq_clock_pelt() instead of rq_clock_task(), we should also
>> use rq_clock_pelt() for throttled_clock_task_time and throttled_clock_task
>> accounting.
> 
> I think this patch is indeed what we want, despite the confusing
> interactions between pelt slowdown+skipping and throttle_clock_task
> trying to freeze time.
> 
> I think it would be slightly better to rename
> throttled_clock_task(_time) to be clock_pelt rather than clock_task, but
> that's minor.

It's a good suggestion, will do and send v2.

Thanks.

> 
> Reviewed-by: Ben Segall <bsegall@google.com>
> 
>>
>> Fixes: 23127296889f ("sched/fair: Update scale invariance of PELT")
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  kernel/sched/fair.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d4bd299d67ab..e6fa5d1141b4 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4846,7 +4846,7 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
>>  
>>  	cfs_rq->throttle_count--;
>>  	if (!cfs_rq->throttle_count) {
>> -		cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
>> +		cfs_rq->throttled_clock_task_time += rq_clock_pelt(rq) -
>>  					     cfs_rq->throttled_clock_task;
>>  
>>  		/* Add cfs_rq with load or one or more already running entities to the list */
>> @@ -4864,7 +4864,7 @@ static int tg_throttle_down(struct task_group *tg, void *data)
>>  
>>  	/* group is entering throttled state, stop time */
>>  	if (!cfs_rq->throttle_count) {
>> -		cfs_rq->throttled_clock_task = rq_clock_task(rq);
>> +		cfs_rq->throttled_clock_task = rq_clock_pelt(rq);
>>  		list_del_leaf_cfs_rq(cfs_rq);
>>  	}
>>  	cfs_rq->throttle_count++;
>> @@ -5308,7 +5308,7 @@ static void sync_throttle(struct task_group *tg, int cpu)
>>  	pcfs_rq = tg->parent->cfs_rq[cpu];
>>  
>>  	cfs_rq->throttle_count = pcfs_rq->throttle_count;
>> -	cfs_rq->throttled_clock_task = rq_clock_task(cpu_rq(cpu));
>> +	cfs_rq->throttled_clock_task = rq_clock_pelt(cpu_rq(cpu));
>>  }
>>  
>>  /* conditionally throttle active cfs_rq's from put_prev_entity() */

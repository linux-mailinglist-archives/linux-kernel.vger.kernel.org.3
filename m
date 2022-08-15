Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774FD592BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiHOJtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiHOJtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:49:15 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAE01D303
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:49:14 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so6337101pjl.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=akKV4BX/2nX/XPwd/01QUdEWtkvWM/4RQ+OQ4e9dEMI=;
        b=asuo8wCUqXMiGIKHKYm91q9mo43rAs7S7mJQiaQFRgPrvu51H5D6DxVGt+8g/cTA32
         jx6YwE5icZ/VEBwefDoXW7rH+zs5McX9tBkQzDkGw5kRYAJ+WZ/LalVUQmSnUclJTlOz
         yqKhC6wtxWUs7+O5rTXT4MvONwjMio0spTisXLsxoLAXw4M9PFzHo/lomWFKuseLn6br
         Iis6wyd2CM/qVVkuymP83AiLxbA+1+yLFuQ5jMIWt5UaEt8Zq3T/dOh6eaa9767LBIEh
         30OlhqQ8DFo35Q/aPraw4IZnlPuCat9dtcw+8TNWt5ZHIarP21nQ5TcvHnUzR+o3I9OE
         JX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=akKV4BX/2nX/XPwd/01QUdEWtkvWM/4RQ+OQ4e9dEMI=;
        b=AQbP8bVCbo2G2y4KyEvComcaniJeoggHNt4poQVZAuMeWx+o7wtEGgVsES3TLRn3wJ
         DC27GvBOF4Q1OrVLRry9ncnIltucXUjhdKnMtac46aJuqv2k78lZ8iwFh+FHEM2z+1Vw
         /AAyY1PdzUUTEAaIzPRGTqajx+Bsbu832+7U2uf1kPTO89V6SpWkix6g+T3VHIdYaYxb
         HwVEfU/4BKX1hnclG2g1HY8SwJR/4UQ2Nc8CKLMxZ/oL71NSnFTqleU7JYrqpVpu9E8W
         dAAdcQftvAqlkRsZniwP90jrpay9U/h9ScBtM8/yo+kaXrabpwBdsELTMSmhHYBiouOG
         ROoA==
X-Gm-Message-State: ACgBeo26v0URsYTwTkOhFsDhxqA6xfjpCRrK/wUuGnfxVRy6UFtcb3Rx
        Yszl0JNf88jDN8kcsgIBwp4kjQ==
X-Google-Smtp-Source: AA6agR684jApq6S+DUVO4SKyY4MHlfHuGqNbvGq1j+8iIL4p7TT2xlpnNcSqnAyRmdMIObhlY5AYfw==
X-Received: by 2002:a17:902:b18e:b0:172:5c92:d8db with SMTP id s14-20020a170902b18e00b001725c92d8dbmr9554511plr.140.1660556953666;
        Mon, 15 Aug 2022 02:49:13 -0700 (PDT)
Received: from [10.94.58.189] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709026b8400b0016eede528b4sm6637786plk.61.2022.08.15.02.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 02:49:13 -0700 (PDT)
Message-ID: <b8e200da-9d13-a194-5251-31f16ab882f2@bytedance.com>
Date:   Mon, 15 Aug 2022 17:49:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v4 5/7] sched/fair: skip SIS domain search if fully busy
Content-Language: en-US
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-kernel@vger.kernel.org
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
 <20220619120451.95251-6-wuyun.abel@bytedance.com>
 <YtggcHGKVSbprXr3@BLR-5CG11610CF.amd.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <YtggcHGKVSbprXr3@BLR-5CG11610CF.amd.com>
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

Hi Gautham, thanks for your reviewing and sorry for my late reply..

On 7/20/22 11:34 PM, Gautham R. Shenoy Wrote:
> 
> [..snip..]
> 
>> @@ -6197,24 +6201,44 @@ static inline int __select_idle_cpu(int cpu, struct task_struct *p)
>>   DEFINE_STATIC_KEY_FALSE(sched_smt_present);
>>   EXPORT_SYMBOL_GPL(sched_smt_present);
>>   
>> -static inline void set_idle_cores(int cpu, int val)
>> +static inline void sd_set_state(int cpu, enum sd_state state)
> 
> Nit: We are setting the state of only the LLC domain and not any other
> domain via this function. So should we name it as
> set_llc_state()/get_llc_state() for better readability ?
> 

Makes sense, will rename in next version.

> 
>>   {
>>   	struct sched_domain_shared *sds;
>>   
>>   	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
>>   	if (sds)
>> -		WRITE_ONCE(sds->has_idle_cores, val);
>> +		WRITE_ONCE(sds->state, state);
>>   }
>>   
>> -static inline bool test_idle_cores(int cpu)
>> +static inline enum sd_state sd_get_state(int cpu)
>>   {
>>   	struct sched_domain_shared *sds;
>>   
>>   	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
>>   	if (sds)
>> -		return READ_ONCE(sds->has_idle_cores);
>> +		return READ_ONCE(sds->state);
>>   
>> -	return false;
>> +	return sd_has_icpus;
>> +}
>> +
>> +static inline void set_idle_cores(int cpu, int idle)
>                                                    ^^^^^
> I agree with Josh. We can use core_idle instead of idle here.

OK, I will make the param more verbose...

> 
>> +{
>> +	sd_set_state(cpu, idle ? sd_has_icores : sd_has_icpus);
>> +}
>> +
>> +static inline bool test_idle_cores(int cpu)
>> +{
>> +	return sd_get_state(cpu) == sd_has_icores;
>> +}
>> +
>> +static inline void set_idle_cpus(int cpu, int idle)

and this one too.

>> +{
>> +	sd_set_state(cpu, idle ? sd_has_icpus : sd_is_busy);
>> +}
>> +
>> +static inline bool test_idle_cpus(int cpu)
>> +{
>> +	return sd_get_state(cpu) != sd_is_busy;
>>   }
>>   
>>   /*
> 
> [...]
> 
> 
>> @@ -8661,6 +8702,12 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
>>   	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
>>   }
>>   
>> +static inline void sd_classify(struct sd_lb_stats *sds, struct rq *rq)
>> +{
>> +	if (sds->sd_state != sd_has_icpus && unoccupied_rq(rq))
> 
> Nit: sds->sd_state can either be sd_has_icpus or sd_is_busy. So for
> better readability, we can just use the positive check

For now, yes. But sd_state can be expanded and once that happens, the
positive check could be error prone.

> 
>          if (sds->sd_state == sd_is_busy && unoccupied_rq(rq))
> 	       sds->sd_state  = sd_has_icpus;
> 
> 
>> +		sds->sd_state = sd_has_icpus;
>> +}
>> +
>>   /**
>>    * update_sg_lb_stats - Update sched_group's statistics for load balancing.
>>    * @env: The load balancing environment.
>> @@ -8675,11 +8722,12 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>   				      struct sg_lb_stats *sgs,
>>   				      int *sg_status)
>>   {
>> -	int i, nr_running, local_group;
>> +	int i, nr_running, local_group, update_core;
>>   
>>   	memset(sgs, 0, sizeof(*sgs));
>>   
>>   	local_group = group == sds->local;
>> +	update_core = env->sd->flags & SD_SHARE_CPUCAPACITY;
>>   
>>   	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
>>   		struct rq *rq = cpu_rq(i);
>> @@ -8692,6 +8740,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>   		nr_running = rq->nr_running;
>>   		sgs->sum_nr_running += nr_running;
>>   
>> +		if (update_core)
>> +			sd_classify(sds, rq);
>> +
>>   		if (nr_running > 1)
>>   			*sg_status |= SG_OVERLOAD;
>>   
>> @@ -9220,6 +9271,12 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>>   	return idlest;
>>   }
>>   
>> +static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>> +{
>> +	if (sds->sd_state == sd_has_icpus && !test_idle_cpus(env->dst_cpu))
>> +		set_idle_cpus(env->dst_cpu, true);
> 
> We could enter this if condition when env->dst_cpu is the only idle
> CPU in the SMT domain (which is likely to be the case every time we do
> a NEW_IDLE balance). By the end of this load-balancing round, the
> env->dst_cpu can pull a task from some other CPU and thereby no longer
> remain idle but the LLC state would still be sd_has_icpus.
> 
> That would mean that some CPU on this LLC would do a full scan during
> the wakeup only to find no idle CPU and reset the state to
> sd_is_busy. Have you seen instances where this false-positive pattern
> can result in wasteful scan thereby cause a performance degradation?
> Ideally it should not be worse that what we currently have.

Yes, indeed. We will talk about this later in the 7th patch.

> 
> Apart from this, patch looks good to me.

Thanks!

> 
> I would be worth the while to explore if the LLC state can be used
> early on in select_task_rq_fair() to determine if we need to do a
> wake-affine or allow the task to stick to its previous LLC depending
> on which among the previous LLC and the waker's LLC have an idle CPU.
> 

Sounds like a good idea!

Best Regards,
Abel

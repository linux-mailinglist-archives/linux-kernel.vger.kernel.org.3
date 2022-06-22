Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAE6554103
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 05:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbiFVDw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 23:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFVDw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 23:52:27 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB0A2FE4D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 20:52:25 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o18so7213515plg.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 20:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kut2Rz7mayi203n8uE3T/p16SVfo4g6ghkNLUYfhHq0=;
        b=1rjBAy0BozhVj7DkS2urWMN1QOUSqIEi8kXWhv3W2nv9/W+DEL6R6EAIzVHYO89G0h
         aiFtUwpiwaW8RwqD6g3WTFhz395uLr+Iwek4QPDQV4VsjBIVg4rPzJ6I86IkaiYcxqhq
         JUNnpwbobymx4usIQNcp2kD8Ew0IEK+XtKdE4qglNp2FRMrf4Wh/V8HF5PGQVFUf4m6F
         Jde7g//HSFKkfZhaPOoS9/VaXJ1uLvBHDe5MEIiDbay6wYoTbdTu0K4kxtljHREwhva6
         BMS2zGLFyHnRoKajjq/8d8g46TfpHMJvUHnI+7Te4PCMBeBxnPLt7dLBvqIiQXMVEukK
         srKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kut2Rz7mayi203n8uE3T/p16SVfo4g6ghkNLUYfhHq0=;
        b=IoFcvli4pww4zLmPHrLl6PwkBGg02GLw72bTlqxZn7NbCrF2nsQtDiM6ZqiLoYHT5N
         5F54nZmzeaAOzcNTkxaehE5FJj5zmhyvyLCvSjFDidMGkWkmjzJngUA0eq+lkoJwuJCO
         H7nD6cKS81Z7hm26dij8G7p4shIt1V8iI0aZVZ8hkAYy6t+uWn0iMTSJl1fmFuHlp3yv
         kNRl+hfxJnFbTmjdLa/r5Lhe+SnUu4ZOgQCy+xcKIDnJTD3Uj0J3AZbCv7UkkuEfmzJb
         JaELmlP+EKapSkjyeM9hARRzUsjMRSl86rQkBVGhtiTYbZ/x1SS4RUCro8EiYQM4rtxL
         f+fg==
X-Gm-Message-State: AJIora94zsop3CfBibtqUGivpVrg4cZ5qkVUoyIvnFNGDSNxT3vWXX8b
        a8s1P1d1SJpICFjMjs1Q9BM2n8QXJX4D6g==
X-Google-Smtp-Source: AGRyM1usP0Cl+7+nOknMmI5gQ6vuoU18IdaCESjSF2kzdfSqfw6tcyaZHfvCzvxyaIyE9MbYm2U1aw==
X-Received: by 2002:a17:90b:3b82:b0:1ec:ac0d:5d3b with SMTP id pc2-20020a17090b3b8200b001ecac0d5d3bmr14508447pjb.158.1655869945126;
        Tue, 21 Jun 2022 20:52:25 -0700 (PDT)
Received: from [10.94.58.189] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id ji6-20020a170903324600b00163e0699260sm5849914plb.291.2022.06.21.20.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 20:52:24 -0700 (PDT)
Message-ID: <543d55e1-fad8-3df3-8bae-d79c0c8d8340@bytedance.com>
Date:   Wed, 22 Jun 2022 11:52:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [External] Re: [PATCH v4 6/7] sched/fair: skip busy cores in SIS
 search
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
 <20220619120451.95251-7-wuyun.abel@bytedance.com>
 <20220621181442.GA37168@chenyu5-mobl1>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220621181442.GA37168@chenyu5-mobl1>
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

Hi Chen, thanks for your comments!

On 6/22/22 2:14 AM, Chen Yu Wrote:
>> ...
> Reuse the data from load balance to select the unoccupied candidate
> is applicable IMO, which is also aligned with SIS_UTIL path. And I have
> a question regarding the update frequency. In v3 patch, the update is
> based on periodic tick, which is triggered at most every 1ms(CONFIG_HZ_1000).
> Then the periodic SMT load balance is launched every smt_weight ms, usually 2ms.
> I expect the 2ms is of the same scale unit as 1ms, and since task tick based
> update is acceptable, would excluding the CPU_NEWLY_IDLE balance from this patch
> reduce the overhead meanwhile not bring too much inaccuracy?

I doubt periodic balancing entry is enough. The ms-scale could still
be too large for wakeup path. Say one cpu becomes newly idle just after
an update, then it keeps untouchable until next update which is nearly
2ms (even worse in SMT4/8 case) wasting time-slices to do nothing. So
newly-idle update is important to keep the filter fresh. And the false
positive correction is there to avoid excessive updates due to newly
idle, by allowing the false positive cpus to stay in the filter for a
little longer.

>> @@ -8757,7 +8794,16 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>   		 * No need to call idle_cpu() if nr_running is not 0
>>   		 */
>>   		if (!nr_running && idle_cpu(i)) {
>> +			/*
>> +			 * Prefer the last idle cpu by overwriting
>> +			 * preious one. The first idle cpu in this
>> +			 * domain (if any) can trigger balancing
>> +			 * and fed with tasks, so we'd better choose
>> +			 * a candidate in an opposite way.
>> +			 */
>> +			sds->idle_cpu = i;
> Does it mean, only 1 idle CPU in the smt domain would be set to the
> idle cpu mask at one time? For SMT4/8 we might lose track of the
> idle siblings.

Yes. The intention of one-at-a-time propagation is
1) help spreading out load to different cores
2) reduce some update overhead
In this way, if the filter contains several cpus of a core, ideally
we can sure about that at least one of them is actually unoccupied.
For SMT4/8 we still have newly idle balance to make things right.

>>   			sgs->idle_cpus++;
>> +
>>   			/* Idle cpu can't have misfit task */
>>   			continue;
>>   		}
>> @@ -9273,8 +9319,40 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>>   
>>   static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>>   {
>> -	if (sds->sd_state == sd_has_icpus && !test_idle_cpus(env->dst_cpu))
>> -		set_idle_cpus(env->dst_cpu, true);
>> +	struct sched_domain_shared *sd_smt_shared = env->sd->shared;
>> +	enum sd_state new = sds->sd_state;
>> +	int this = env->dst_cpu;
>> +
>> +	/*
>> +	 * Parallel updating can hardly contribute accuracy to
>> +	 * the filter, besides it can be one of the burdens on
>> +	 * cache traffic.
>> +	 */
>> +	if (cmpxchg(&sd_smt_shared->updating, 0, 1))
>> +		return;
>> +
>> +	/*
>> +	 * There is at least one unoccupied cpu available, so
>> +	 * propagate it to the filter to avoid false negative
>> +	 * issue which could result in lost tracking of some
>> +	 * idle cpus thus throughupt downgraded.
>> +	 */
>> +	if (new != sd_is_busy) {
>> +		if (!test_idle_cpus(this))
>> +			set_idle_cpus(this, true);
>> +	} else {
>> +		/*
>> +		 * Nothing changes so nothing to update or
>> +		 * propagate.
>> +		 */
>> +		if (sd_smt_shared->state == sd_is_busy)
>> +			goto out;
>> +	}
>> +
>> +	sd_update_icpus(this, sds->idle_cpu);
> I wonder if we could further enhance it to facilitate idle CPU scan.
> For example, can we propagate the idle CPUs in smt domain, to its parent
> domain in a hierarchic sequence, and finally to the LLC domain. If there is

In fact, it was my first try to cache the unoccupied cpus in SMT
shared domain, but the overhead of cpumask ops seems like a major
stumbling block.

> a cluster domain between SMT and LLC domain, the cluster domain idle CPU filter
> could benefit from this mechanism.
> https://lore.kernel.org/lkml/20220609120622.47724-3-yangyicong@hisilicon.com/

Putting SIS into a hierarchical pattern is good for cache locality.
But I don't think multi-level filter is appropriate since it could
bring too much cache traffic in SIS, and it could be expected to be
a disaster for netperf/tbench or the workloads suffering frequent
context switches.

> 
> Furthermore, even if there is no cluster domain, would a 'virtual' middle
> sched domain would help reduce the contention?
> Core0(CPU0,CPU1),Core1(CPU2,CPU3) Core2(CPU4,CPU5) Core3(CPU6,CPU7)
> We can create cpumask1, which is composed of Core0 and Core1, and cpumask2
> which is composed of Core2 and Core3. The SIS would first scan in cpumask1,
> if idle cpu is not found, scan cpumask2. In this way, the CPUs in Core0 and
> Core1 only updates cpumask1, without competing with Core2 and Core3 on cpumask2.
> 
Yes, this is the best case, but the worst case is something that
we probably can't afford.

Thanks & BR,
Abel

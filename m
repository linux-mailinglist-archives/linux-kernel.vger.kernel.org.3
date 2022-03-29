Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7018D4EA623
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 05:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiC2Dia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 23:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiC2Di0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 23:38:26 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A471274E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 20:36:44 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s72so13748532pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 20:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aEnDDvOqBO26uI8oeZEyvP4E2tYRykVx4vz4h8EzQK0=;
        b=VPtEfLXBxkx6jTZjlvR3tP3/zftJHS4YZMSzzMRa8oFoyCbc+ziXM4bYm0th2iQJQW
         02JQPdzA8KQh3NnXBoGCWPoPkd/kWHWYx1FoPjwXtTgNVOAXunzL7yEgIIOzrHKe98pL
         D4XGS1oJ4VXuS6a+Dz+zGNL186726d71xgmz0aAPQleB8T3TjoRolr7FnmvnVneQwFr/
         p3m+sfb/8ADq446f8aDUKWpDz0Hu1zFuTTVz9RnOiaNwHk04QCLcisjBmYQOSaDandj+
         exgl9IVh4JwrnahLifebGin6SZ64+2EisLQb31IOkMwmc3Vfm7LJ24faCYUu0CX8cD8y
         ct9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aEnDDvOqBO26uI8oeZEyvP4E2tYRykVx4vz4h8EzQK0=;
        b=eKtH4mQAg9nbaEb8Xb0CN34qF1/Mv0TrBUzMfWtUzbA+lN6Fe2umnv0GzPnA33OevW
         Ycu+z6sN8ypGs0XOngC0k9Fk3HkkSDduE89qdcv42XcZuC1YpdS/314Fpx8YCM8BI4d3
         QEIiJjV44XSA5UZnOGWtI1kZ8nqyaJ/jbAV2eQxvkeLNFd4mv5rsZt9OeODxZJgzFF21
         91/CjrFqvqHsK1tY/N0uG8zXvwYnEhaPJ7z8+88x0QPaxlmjdGUQ4crI0ICnBeNej3Z9
         lwBy1N/nep1jpHMHs13aLIOJyOB7zmgDTtiDpD3cp+0YzlRWT2hUB95zC7Ec2oqXB+DN
         IFMA==
X-Gm-Message-State: AOAM532gdEEW8jWMFld4fLmVBgRPid44ghmn2DYriqvFU03PoADx2T8/
        YexCb8yAWk8k5k0g/ror+c+KLw==
X-Google-Smtp-Source: ABdhPJzEhFhAMboqmjGkyOHD1dOTX5mhljZoahK7JiWD26rfjV/2216gJTUGPgSF/fgA1Ve2jBHZPw==
X-Received: by 2002:a65:6955:0:b0:380:64fd:a2dd with SMTP id w21-20020a656955000000b0038064fda2ddmr476497pgq.383.1648525003904;
        Mon, 28 Mar 2022 20:36:43 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e65:74c0:705b:241a:6dc0:a4ac? ([2409:8a28:e65:74c0:705b:241a:6dc0:a4ac])
        by smtp.gmail.com with ESMTPSA id l2-20020a056a0016c200b004f7e3181a41sm18396178pfc.98.2022.03.28.20.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 20:36:43 -0700 (PDT)
Message-ID: <64a903d9-0398-2953-8a85-fd0cd238989e@bytedance.com>
Date:   Tue, 29 Mar 2022 11:36:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] Re: [PATCH] sched/fair: fix broken bandwidth control
 with nohz_full
Content-Language: en-US
To:     Benjamin Segall <bsegall@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com
References: <20220328110751.39987-1-zhouchengming@bytedance.com>
 <xm26wngduccv.fsf@google.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <xm26wngduccv.fsf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/3/29 03:05, Benjamin Segall wrote:
> Chengming Zhou <zhouchengming@bytedance.com> writes:
> 
>> With nohz_full enabled on cpu, the scheduler_tick() will be stopped
>> when only one CFS task left on rq.
>>
>> scheduler_tick()
>>   task_tick_fair()
>>     entity_tick()
>>       update_curr()
>>         account_cfs_rq_runtime(cfs_rq, delta_exec) --> stopped
>>
>> So that running task can't account its runtime periodically, but
>> the cfs_bandwidth hrtimer still __refill_cfs_bandwidth_runtime()
>> periodically. Later in one period, the task would account very
>> big delta_exec, which cause the cfs_rq to be throttled for a
>> long time.
>>
>> There are two solutions for the problem, the first is that we
>> can check in sched_can_stop_tick() if current task's cfs_rq
>> have runtime_enabled, in which case we don't stop tick. But
>> it will make nohz_full almost useless in cloud environment
>> that every container has the cpu bandwidth control setting.
>>
>> The other is what this patch implemented, cfs_bandwidth hrtimer
>> would sync unaccounted runtime from all running cfs_rqs with
>> tick stopped, just before __refill_cfs_bandwidth_runtime().
>> Also do the same thing in tg_set_cfs_bandwidth().
> 
>>
>> A testcase to reproduce:
>> ```
>> cd /sys/fs/cgroup
>> echo "+cpu" > cgroup.subtree_control
>>
>> mkdir test
>> echo "105000 100000" > test/cpu.max
> 
> 
> The other half of this problem I think would be that it also won't
> throttle when it /is/ out of bandwidth. That is, 'echo "50000 100000" >
> test/cpu.max' would not stop after 50ms of runtime is spent, it would
> only stop (with this patch) after 100ms. It would then correctly need to
> repay that debt, so the (very) long-run ratio should be correct, but a
> misbehaving task could be use practically arbitrarily more than their
> supposed quota over the ~100s of milliseconds timescales cfsb is
> generally supposed to work on.

Right, it's a problem with this patch's solution. I can't think of a
better way to make NOHZ_FULL work with bandwidth control. But it should
be no problem for most use-case? If it used over quota, it would need
to repay that debt before it can run again, so it just misbehave in that
period.

The main problem this patch solved is that task accumulated a very long
delta_exec accounted in one period, then cause very long time throttled.

> 
> However, I don't really see a way for cfsb's current design to avoid
> that on nohz_full (without vetoing sched_can_stop_tick). It might be
> possible to try and guess when quota will run out by tracking the number
> of running or runnable threads, but that would be a nontrivial
> undertaking and involve a bunch of hrtimer reprogramming (particularly
> in cases when some cgroups actually have tasks that wake/sleep frequently).
> 
> 
>>
>> echo $$ > test/cgroup.procs
>> taskset -c 1 bash -c "while true; do let i++; done"
>> ```
>> Ctrl-C and cat test/cpu.stat to see if nr_throttled > 0.
>>
>> The above testcase uses period 100ms and quota 105ms, would
>> only see nr_throttled > 0 on nohz_full system. The problem
>> is gone in test with this patch.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  kernel/sched/core.c  |  4 ++++
>>  kernel/sched/fair.c  | 30 ++++++++++++++++++++++++++++++
>>  kernel/sched/sched.h |  3 +++
>>  3 files changed, 37 insertions(+)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index d575b4914925..17b5e3d27401 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -10443,6 +10443,10 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
>>  	 */
>>  	if (runtime_enabled && !runtime_was_enabled)
>>  		cfs_bandwidth_usage_inc();
>> +
>> +	if (runtime_was_enabled)
>> +		sync_cfs_bandwidth_runtime(cfs_b);
>> +
>>  	raw_spin_lock_irq(&cfs_b->lock);
>>  	cfs_b->period = ns_to_ktime(period);
>>  	cfs_b->quota = quota;
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index ee0664c9d291..ebda70a0e3a8 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5339,6 +5339,34 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
>>  	return HRTIMER_NORESTART;
>>  }
>>  
>> +#ifdef CONFIG_NO_HZ_FULL
>> +void sync_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
>> +{
>> +	unsigned int cpu;
>> +	struct rq *rq;
>> +	struct rq_flags rf;
>> +	struct cfs_rq *cfs_rq;
>> +	struct task_group *tg;
>> +
>> +	tg = container_of(cfs_b, struct task_group, cfs_bandwidth);
>> +
>> +	for_each_online_cpu(cpu) {
>> +		if (!tick_nohz_tick_stopped_cpu(cpu))
>> +			continue;
>> +
>> +		rq = cpu_rq(cpu);
>> +		cfs_rq = tg->cfs_rq[cpu];
>> +
>> +		rq_lock_irqsave(rq, &rf);
> 
> A for-every-nohz-cpu rqlock is definitely not great when the cgroup is
> likely to be running on much fewer cpus. I'm not sure what the current
> opinion would be on doing some sort of optimistic locking like
> 
> if (!READ_ONCE(cfs_rq->curr)) continue;
> rq_lock_irqsave(...);
> if (cfs_rq->curr) { ... }

I think it's better, will changed to this if Peter is ok with this patch.

Thanks.

> 
> but solutions to the other problem I mentioned earlier might provide
> help here anyways.
> 
> 
>> +		if (cfs_rq->curr) {
>> +			update_rq_clock(rq);
>> +			update_curr(cfs_rq);
>> +		}
>> +		rq_unlock_irqrestore(rq, &rf);
>> +	}
>> +}
>> +#endif
>> +
>>  extern const u64 max_cfs_quota_period;
>>  
>>  static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>> @@ -5350,6 +5378,8 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>>  	int idle = 0;
>>  	int count = 0;
>>  
>> +	sync_cfs_bandwidth_runtime(cfs_b);
>> +
>>  	raw_spin_lock_irqsave(&cfs_b->lock, flags);
>>  	for (;;) {
>>  		overrun = hrtimer_forward_now(timer, cfs_b->period);
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 58263f90c559..57f9da9c50c1 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -2351,9 +2351,12 @@ static inline void sched_update_tick_dependency(struct rq *rq)
>>  	else
>>  		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
>>  }
>> +
>> +extern void sync_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b);
>>  #else
>>  static inline int sched_tick_offload_init(void) { return 0; }
>>  static inline void sched_update_tick_dependency(struct rq *rq) { }
>> +static inline void sync_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b) {}
>>  #endif
>>  
>>  static inline void add_nr_running(struct rq *rq, unsigned count)

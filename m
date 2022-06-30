Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E24B561388
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiF3Hqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbiF3Hqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:46:36 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4F03CFF9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:46:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d17so17336747pfq.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A0/g0Qm8HLOkT+fTK/nZ6DZU53beDhvgr+CMx6jZgX8=;
        b=4G7o0+iVvZMIaI9mXZK1is6ZI0OE6eXBMiYNDYNuRJpiZVlDuV+eh3y85S39mB8LHd
         20qLvAvz0V9Gqj7Oq5+TzCOUNIn4QfFK0+61ftixbKi+vL2V5V8w2ANtIi/OLMsbjnlp
         MZpiKjtctu9aTDeqqCeY/wH+rYMe5tqi5TlPK7rG4LNv/og4XmAJZ9Gqq7uxHuQALNfU
         pCHuUYoyN3XkEPP6t1ctFV9WwxHldUgdde9MQfubgBfyfGGLgPqm0Q51iaD9h7/j6Uw8
         FTh8uZutm/xwkW7UuhaQr5bpy0oAwkzNJqT7qESGq4USO1g0QIB5FH6lc+GaEW/FA8S5
         mDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A0/g0Qm8HLOkT+fTK/nZ6DZU53beDhvgr+CMx6jZgX8=;
        b=Yu4uSHg50jxuZatCZVTl4vJfkRJrrj8bGlsOhkzKcFYxYN7HaYAbrJnON2ucCQKGb/
         /zD0Tco713gpeHzfTbxUK2Hot1iHs/eoAo68+oqYTpUNh+SCC3ezzfk5T2YnKncKrH+L
         nj0pBmA41BXocEMMd1yWKV7N+TMedZt6yN8gtszqoVB5r0hAYj1xYYaRfUZtO6q0YWcQ
         TYdotF3DIke+pn4jrbIHTkSV8TEskqT2Ia6aFIFTHkXeyRhBQ/b1VOgIg0cje3nrfYFd
         SAXunjRP/f1S3TwRKtfkG0XnmKNUHu0FzPXBKZIWpFMmprXq0qOHr3IZ9oQFNKv+EsAb
         Ir3w==
X-Gm-Message-State: AJIora8VU6QIWr7YOjm5hhIaZ35yzmY0T76scOHAcnuz8LL4+IJ7b8LR
        FtcYE5mU0yixAB7atQKjJA+2TA==
X-Google-Smtp-Source: AGRyM1ulkMzOVBNVJ1QmSgD7Kp6E2Hqk/2WY9UbjDD8e3hzujJlCLrLE21hlo+wWqQAumk00/xpabQ==
X-Received: by 2002:a05:6a00:f8f:b0:525:537d:69b1 with SMTP id ct15-20020a056a000f8f00b00525537d69b1mr14561356pfb.52.1656575192823;
        Thu, 30 Jun 2022 00:46:32 -0700 (PDT)
Received: from [10.94.58.189] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id kv18-20020a17090b169200b001dcf49d92a1sm3783015pjb.28.2022.06.30.00.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 00:46:32 -0700 (PDT)
Message-ID: <9e6b8d11-aa7a-fe6e-acc4-c226874d91f0@bytedance.com>
Date:   Thu, 30 Jun 2022 15:46:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4 7/7] sched/fair: de-entropy for SIS filter
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
 <20220619120451.95251-8-wuyun.abel@bytedance.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220619120451.95251-8-wuyun.abel@bytedance.com>
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


On 6/19/22 8:04 PM, Abel Wu Wrote:
> Now when updating core state, there are two main problems that could
> pollute the SIS filter:
> 
>    - The updating is before task migration, so if dst_cpu is
>      selected to be propagated which might be fed with tasks
>      soon, the efforts we paid is no more than setting a busy
>      cpu into the SIS filter. While on the other hand it is
>      important that we update as early as possible to keep the
>      filter fresh, so it's not wise to delay the update to the
>      end of load balancing.
> 
>    - False negative propagation hurts performance since some
>      idle cpus could be out of reach. So in general we will
>      aggressively propagate idle cpus but allow false positive
>      continue to exist for a while, which may lead to filter
>      being fully polluted.
> 
> Pains can be relieved by a force correction when false positive
> continuously detected.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>   include/linux/sched/topology.h |  7 +++++
>   kernel/sched/fair.c            | 51 ++++++++++++++++++++++++++++++++--
>   2 files changed, 55 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index b93edf587d84..e3552ce192a9 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -91,6 +91,12 @@ struct sched_group;
>    *	search, and is also used as a fallback state of the other
>    *	states.
>    *
> + * - sd_may_idle
> + *	This state implies the unstableness of the SIS filter, and
> + *	some bits of it may out of date. This state is only used in
> + *	SMT domains as an intermediate state between sd_has_icpus
> + *	and sd_is_busy.
> + *
>    * - sd_is_busy
>    *	This state indicates there are no unoccupied cpus in this
>    *	domain. So for LLC domains, it gives the hint on whether
> @@ -111,6 +117,7 @@ struct sched_group;
>   enum sd_state {
>   	sd_has_icores,
>   	sd_has_icpus,
> +	sd_may_idle,
>   	sd_is_busy
>   };
>   
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d55fdcedf2c0..9713d183d35e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8768,6 +8768,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>   
>   	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
>   		struct rq *rq = cpu_rq(i);
> +		bool update = update_core && (env->dst_cpu != i);
>   
>   		sgs->group_load += cpu_load(rq);
>   		sgs->group_util += cpu_util_cfs(i);
> @@ -8777,7 +8778,11 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>   		nr_running = rq->nr_running;
>   		sgs->sum_nr_running += nr_running;
>   
> -		if (update_core)
> +		/*
> +		 * The dst_cpu is not preferred since it might
> +		 * be fed with tasks soon.
> +		 */
> +		if (update)
>   			sd_classify(sds, rq, i);
>   
>   		if (nr_running > 1)
> @@ -8801,7 +8806,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>   			 * and fed with tasks, so we'd better choose
>   			 * a candidate in an opposite way.
>   			 */
> -			sds->idle_cpu = i;
> +			if (update)
> +				sds->idle_cpu = i;
>   			sgs->idle_cpus++;
>   
>   			/* Idle cpu can't have misfit task */
> @@ -9321,7 +9327,7 @@ static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>   {
>   	struct sched_domain_shared *sd_smt_shared = env->sd->shared;
>   	enum sd_state new = sds->sd_state;
> -	int this = env->dst_cpu;
> +	int icpu = sds->idle_cpu, this = env->dst_cpu;
>   
>   	/*
>   	 * Parallel updating can hardly contribute accuracy to
> @@ -9331,6 +9337,22 @@ static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>   	if (cmpxchg(&sd_smt_shared->updating, 0, 1))
>   		return;
>   
> +	/*
> +	 * The dst_cpu is likely to be fed with tasks soon.
> +	 * If it is the only unoccupied cpu in this domain,
> +	 * we still handle it the same way as as_has_icpus
> +	 * but turn the SMT into the unstable state, rather
> +	 * than waiting to the end of load balancing since
> +	 * it's also important that update the filter as
> +	 * early as possible to keep it fresh.
> +	 */
> +	if (new == sd_is_busy) {
> +		if (idle_cpu(this) || sched_idle_cpu(this)) {
> +			new = sd_may_idle;
> +			icpu = this;
> +		}
> +	}
> +
>   	/*
>   	 * There is at least one unoccupied cpu available, so
>   	 * propagate it to the filter to avoid false negative
> @@ -9338,6 +9360,12 @@ static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>   	 * idle cpus thus throughupt downgraded.
>   	 */
>   	if (new != sd_is_busy) {
> +		/*
> +		 * The sd_may_idle state is taken into
> +		 * consideration as well because from
> +		 * here we couldn't actually know task
> +		 * migrations would happen or not.
> +		 */
>   		if (!test_idle_cpus(this))
>   			set_idle_cpus(this, true);
>   	} else {
> @@ -9347,9 +9375,26 @@ static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>   		 */
>   		if (sd_smt_shared->state == sd_is_busy)
>   			goto out;
> +
> +		/*
> +		 * Allow false positive to exist for some time
> +		 * to make a tradeoff of accuracy of the filter
> +		 * for relieving cache traffic.
> +		 */
> +		if (sd_smt_shared->state == sd_has_icpus) {
> +			new = sd_may_idle;
> +			goto update;
> +		}
> +
> +		/*
> +		 * If the false positive issue has already been
> +		 * there for a while, a correction of the filter
> +		 * is needed.
> +		 */
>   	}
>   
>   	sd_update_icpus(this, sds->idle_cpu);

The @icpu should be used here rather than 'sds->idle_cpu'..
Will be fixed in next version.

> +update:
>   	sd_smt_shared->state = new;
>   out:
>   	xchg(&sd_smt_shared->updating, 0);

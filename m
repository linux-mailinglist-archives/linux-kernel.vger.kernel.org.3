Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65645703D9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiGKNIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiGKNIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:08:05 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CAE2E6AB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:08:04 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j12so4373470plj.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=V1wH7tcHpda9uPkXa38KZ5phS+rVELFv/nxObkPScN4=;
        b=gfNcTMlgx8i6qPwjRu8OBTNafibUga3WUgF2eFWii7ZHrIp4R6NbMrcTR60b32WhAP
         1XgKdTItHswlf1G3dPZJn4azkT04i6lts0CCEzebVZHeCkhflqALTMsF/qxaEGI2yECJ
         MuO75GQrwiAP5SMDd95ENyESG+lgEdz13LukeT0cNsUqfzrKxGq/tjKh9mpGtgnwxioL
         fpnlUpSUmcdEX00mTP8IMc2WiITN5Is9K4c6ciSMLWDVaWwa7tFxOU8k+d5Ew5wV+kVh
         TkwDRnMK8y1/eUBeS7DRj5YajHgRZYCaZY8olxMNHle0mBT8kM0hJmQE8nlrBgnunWnx
         DdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=V1wH7tcHpda9uPkXa38KZ5phS+rVELFv/nxObkPScN4=;
        b=tLOuaoclV8L3bb1oC2CqUTDTH7sNjZ/r9wau2R88JsPkiQIMks+Qe6wspnLCUFHB3Y
         nG8qxswUXhNzjo/1ckDdrUlUDbg9spqVoqak52SETFqtGGzhpbKLQi37dSQuVtG/8Z2J
         PfZkH0bPuvlSD4jgtg1pEDVGMmk4qQF4dLHrZ0T1W+x8uk75jA3HC7eWlyTEhR4CHf7z
         b7Xm+o2btvaaE6tl71QTiY/UgNWFRVVU+wjhmUYQLhuPf3VtH1OCVSXVYjFoWGSlRT7O
         1MKpei56k2oGgXjVhDiHcWryI1/uaxlytaRhONFl4gH0ryqr6bbCbzDcQEI7+GUJRkJa
         B0jw==
X-Gm-Message-State: AJIora91CZX6fBrry0/PZm4fecrRCYp/OxI8tAm+hZIoQ3ha9G/za2lc
        mt9jz8zV0SjYHH6LpdPnPHb8GA==
X-Google-Smtp-Source: AGRyM1sxRGxloutzaiPCrSL6h8FWJ3lArFPSFFmwhqxJ0xmwYLxDEqy/eaTML2Vn1ivnaUa4eEfyDw==
X-Received: by 2002:a17:903:244d:b0:16c:52f1:d12 with SMTP id l13-20020a170903244d00b0016c52f10d12mr1619066pls.44.1657544883517;
        Mon, 11 Jul 2022 06:08:03 -0700 (PDT)
Received: from [10.255.242.206] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902d58400b0016bf5557690sm4661426plh.4.2022.07.11.06.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 06:08:03 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
X-Google-Original-From: Chengming Zhou <chengming.zhou@linux.dev>
Message-ID: <78208601-d5d8-2dad-c841-10028513233a@linux.dev>
Date:   Mon, 11 Jul 2022 21:07:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.1
Subject: Re: [PATCH 1/8] sched/fair: combine detach into dequeue when
 migrating task
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220709151353.32883-1-zhouchengming@bytedance.com>
 <20220709151353.32883-2-zhouchengming@bytedance.com>
In-Reply-To: <20220709151353.32883-2-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/9 23:13, Chengming Zhou wrote:
> When we are migrating task out of the CPU, we can combine detach and
> propagation into dequeue_entity() to save the detach_entity_cfs_rq()
> in migrate_task_rq_fair().
> 
> This optimization is like combining DO_ATTACH in the enqueue_entity()
> when migrating task to the CPU.
> 
> So we don't have to traverse the CFS tree extra time to do the
> detach_entity_cfs_rq() -> propagate_entity_cfs_rq() call, which
> wouldn't be called anymore with this patch's change.
> 
> detach_task()
>   deactivate_task()
>     dequeue_task_fair()
>       for_each_sched_entity(se)
>         dequeue_entity()
>           update_load_avg() /* (1) */
>             detach_entity_load_avg()
> 
>   set_task_cpu()
>     migrate_task_rq_fair()
>       detach_entity_cfs_rq() /* (2) */
>         update_load_avg();
>         detach_entity_load_avg();
>         propagate_entity_cfs_rq();
>           for_each_sched_entity()
>             update_load_avg()
> 
> This patch save the detach_entity_cfs_rq() called in (2) by doing
> the detach_entity_load_avg() for a CPU migrating task inside (1)
> (the task being the first se in the loop)
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a78d2e3b9d49..0689b94ed70b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4003,6 +4003,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  #define UPDATE_TG	0x1
>  #define SKIP_AGE_LOAD	0x2
>  #define DO_ATTACH	0x4
> +#define DO_DETACH	0x8
>  
>  /* Update task and its cfs_rq load average */
>  static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> @@ -4020,7 +4021,14 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  	decayed  = update_cfs_rq_load_avg(now, cfs_rq);
>  	decayed |= propagate_entity_load_avg(se);
>  
> -	if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
> +	if (flags & DO_DETACH) {
> +		/*
> +		 * DO_DETACH means we're here from dequeue_entity()
> +		 * and we are migrating task out of the CPU.
> +		 */
> +		detach_entity_load_avg(cfs_rq, se);
> +		update_tg_load_avg(cfs_rq);
> +	} else if (!se->avg.last_update_time && (flags & DO_ATTACH)) {

Should I put "DO_DETACH" case after "DO_ATTACH" case? The "DO_ATTACH" maybe more likely, right?

Thanks.

>  
>  		/*
>  		 * DO_ATTACH means we're here from enqueue_entity().
> @@ -4292,6 +4300,7 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>  #define UPDATE_TG	0x0
>  #define SKIP_AGE_LOAD	0x0
>  #define DO_ATTACH	0x0
> +#define DO_DETACH	0x0
>  
>  static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
>  {
> @@ -4511,6 +4520,11 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
>  static void
>  dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  {
> +	int action = UPDATE_TG;
> +
> +	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
> +		action |= DO_DETACH;
> +
>  	/*
>  	 * Update run-time statistics of the 'current'.
>  	 */
> @@ -4524,7 +4538,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  	 *   - For group entity, update its weight to reflect the new share
>  	 *     of its group cfs_rq.
>  	 */
> -	update_load_avg(cfs_rq, se, UPDATE_TG);
> +	update_load_avg(cfs_rq, se, action);
>  	se_update_runnable(se);
>  
>  	update_stats_dequeue_fair(cfs_rq, se, flags);
> @@ -7076,8 +7090,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  	return new_cpu;
>  }
>  
> -static void detach_entity_cfs_rq(struct sched_entity *se);
> -
>  /*
>   * Called immediately before a task is migrated to a new CPU; task_cpu(p) and
>   * cfs_rq_of(p) references at time of call are still valid and identify the
> @@ -7099,15 +7111,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>  		se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
>  	}
>  
> -	if (p->on_rq == TASK_ON_RQ_MIGRATING) {
> -		/*
> -		 * In case of TASK_ON_RQ_MIGRATING we in fact hold the 'old'
> -		 * rq->lock and can modify state directly.
> -		 */
> -		lockdep_assert_rq_held(task_rq(p));
> -		detach_entity_cfs_rq(se);
> -
> -	} else {
> +	if (!task_on_rq_migrating(p)) {
>  		remove_entity_load_avg(se);
>  
>  		/*

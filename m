Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F3847CE09
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243294AbhLVIWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239783AbhLVIWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:22:32 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CA0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:22:32 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o12so3723606lfk.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0IxB2shCzUUd3oXxhpI+E73LAvQESQOmzRcH/NWU4h0=;
        b=FwT2qGC9XtGVgOZ3j+1/6TcxecxLtgwjrZazE95TJTr7N1JODZqJi76taRN5NEv+bS
         We/ZAJVajX+y3X16BmQ2T+zgOfKA32ogtHtELkqvRH9vRrn5BTlyCQjEKiy0lpTU/UpX
         jn6z+yEL7SYpeu6Rwp4+/VnsV0ewB99JNWmD8YnuHBrEuAHpKg/t1+Ii9nJiVSZRKRNS
         wkvEvJnJAD90exnSQCgzR1HLATucNcHz0ARcrOF9T+3XRmxGmmDbnm0otdQSBTEnFBJ0
         zd4ot8SpP3/9B0BhaBoqkqu6cUwtMAUIcM5StipWyFyC/UkBJrPOaGCQmag/D6QrFnTr
         MFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0IxB2shCzUUd3oXxhpI+E73LAvQESQOmzRcH/NWU4h0=;
        b=yVwox/WqyJZK7zM/wssgctgt/bJFVBtCcsOfmtZsdyHFRiyq0QORy+9lj3XewPnhSx
         OiBRa0vcmvOi7QCJBrSawRndGPtrIyfXonJJbuet4LKwjDYCcSVM8moPPb+xAUTNlOUR
         FuWtcdyP2QwtKDrbGlLPUmDviSuqQEamLu5sDhMrjtpH07wX3QIYHXKP/AKx70o2GNC2
         vDrH+P2EEYkk3NILD8CXV8YzfNSXq9Pn32A13n6m+emzyQ55xTkXxnK/wIMu+H7xf3GP
         /EQnI4g1v6Slyiu/5QM8rIvtSuXPY3uMamjp/V+4m9aTqsbzCosbbAYvgsSUSQMFca5i
         TsMA==
X-Gm-Message-State: AOAM531DedEy+PITADvJ43r7wgYUv8BqqOr+ediel5UKTGTGDG1PolMe
        gLza8nBWspfd5q/pm44Jd/FYQLROYznJSvj3PlsZxt+zqa0=
X-Google-Smtp-Source: ABdhPJxJSgXqk8c0aPSNSzsH8GUU77WXJ4rp0tYZr/WUgheR5dpZSbqc86RxHNT1m9YjEyq5H/85QqtGoOwQsJEDV/U=
X-Received: by 2002:a05:6512:4ca:: with SMTP id w10mr1685164lfq.32.1640161350377;
 Wed, 22 Dec 2021 00:22:30 -0800 (PST)
MIME-Version: 1.0
References: <20211218055900.2704-1-rdunlap@infradead.org>
In-Reply-To: <20211218055900.2704-1-rdunlap@infradead.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 22 Dec 2021 09:22:19 +0100
Message-ID: <CAKfTPtA6z3oBPd_QhVMeE40RdpbLKm0dJ_7xk_Y3hzrTOaEXAA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: fix all kernel-doc warnings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2021 at 06:59, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Quieten all kernel-doc warnings in kernel/sched/fair.c:
>
> kernel/sched/fair.c:3663: warning: No description found for return value of 'update_cfs_rq_load_avg'
> kernel/sched/fair.c:8601: warning: No description found for return value of 'asym_smt_can_pull_tasks'
> kernel/sched/fair.c:8673: warning: Function parameter or member 'sds' not described in 'update_sg_lb_stats'
> kernel/sched/fair.c:9483: warning: contents before sections
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> v2: Tweak the Return: text of asym_smt_can_pull_tasks() [per Ricardo]
>
>  kernel/sched/fair.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> --- linux-next-20211217.orig/kernel/sched/fair.c
> +++ linux-next-20211217/kernel/sched/fair.c
> @@ -3652,7 +3652,7 @@ static inline void add_tg_cfs_propagate(
>   *
>   * cfs_rq->avg is used for task_h_load() and update_cfs_share() for example.
>   *
> - * Returns true if the load decayed or we removed load.
> + * Return: true if the load decayed or we removed load.
>   *
>   * Since both these conditions indicate a changed cfs_rq->avg.load we should
>   * call update_tg_load_avg() when this function returns true.
> @@ -8539,6 +8539,8 @@ group_type group_classify(unsigned int i
>   *
>   * If @sg does not have SMT siblings, only pull tasks if all of the SMT siblings
>   * of @dst_cpu are idle and @sg has lower priority.
> + *
> + * Return: true if @dst_cpu can pull tasks, false otherwise.
>   */
>  static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
>                                     struct sg_lb_stats *sgs,
> @@ -8614,6 +8616,7 @@ sched_asym(struct lb_env *env, struct sd
>  /**
>   * update_sg_lb_stats - Update sched_group's statistics for load balancing.
>   * @env: The load balancing environment.
> + * @sds: Load-balancing data with statistics of the local group.
>   * @group: sched_group whose statistics are to be updated.
>   * @sgs: variable to hold the statistics for this group.
>   * @sg_status: Holds flag indicating the status of the sched_group
> @@ -9421,12 +9424,11 @@ static inline void calculate_imbalance(s
>  /**
>   * find_busiest_group - Returns the busiest group within the sched_domain
>   * if there is an imbalance.
> + * @env: The load balancing environment.
>   *
>   * Also calculates the amount of runnable load which should be moved
>   * to restore balance.
>   *
> - * @env: The load balancing environment.
> - *
>   * Return:     - The busiest group if imbalance exists.
>   */
>  static struct sched_group *find_busiest_group(struct lb_env *env)

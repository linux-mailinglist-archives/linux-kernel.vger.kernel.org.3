Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536B153C9B3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244156AbiFCMIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiFCMIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:08:46 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019A615A3A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 05:08:45 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id w2so13354980ybi.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 05:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5kqHlwmrV1wou657daBuKPdc5MJ+PwGWwljNjG2zmb0=;
        b=Him0+g+1O7Hmk7Y9JaK9fWhAVt3Z48xEMCquYRbnvPmrozv+FXQHZDF6P+jUxk5hJs
         ozd8vvV3Zv/70j9/zzH12xxJsxz+lFaJm1RyvE6teR5A39TWEgGut9pj//6qVSIa4+IX
         VVjpfX//CEzqxM4ScwKvvJO+MP54xhqJ1h97PpyTfVK6Ri/mjZCKX/jJYGpQX4jsyGWZ
         YYCNHWJvhdx6Dvz6h803PsfoH90hDxihlkt7ZhFaG+gLldeHoahJ6Gc72Yo+E1zkyctR
         +WoZ/7ISTFa83yINH/HmwKZe3ivQjnrX46AoGTPV2uxO4iO3UZF8WtrkHrr3vGOp+qP/
         zNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5kqHlwmrV1wou657daBuKPdc5MJ+PwGWwljNjG2zmb0=;
        b=LTaja0dyEWx5aMkysdEx6dwWI8HaJaA2GgWWQe0a/M+NLE3ZUD5L1E/OUhCjiAT9Vp
         PmgBnrFUMoY+5r9ssxTeF4ubjeduMpsNKQxldsAHavxHyoUNY8oqCsLcvRHJtV8JX4XD
         8AmUQ3e0bOJM1wQSjEcWRrs1s3RzwCFTTpUEi8x8cY/0/TUL4k5OJEVbhw3Hnq6cwc9o
         mq7kjgUKg/DKRXNgD6SOw+v2rYEzjya1unHW56ROBQPROcnYvJaSvtSyfdJc5eU6EOfD
         iQI72+9tw+eqRbaqTbvROfgclCkXZ9+zwlqFn5LKwbE8bDqC/C1Q+oGuTXPuKprLJ3BE
         tfpA==
X-Gm-Message-State: AOAM532BoIclK+hZNG89Vxo7d75zV9Cqsi2zdSDHMROPr+pZoMHTGle9
        0q/52xHTZ0JxfVwVRpDQr+gucOWnE2bmKTo8Tdg5XQ==
X-Google-Smtp-Source: ABdhPJzmPmCGl3dc0kIwyk1e8uOu8LiEXgu38osh1nc9CfYHUppbcgtipj++Vz1u+snIa28MG7OqnwrG6TBWtv54mns=
X-Received: by 2002:a05:6902:1007:b0:660:4225:2ee1 with SMTP id
 w7-20020a056902100700b0066042252ee1mr9396661ybt.424.1654258124056; Fri, 03
 Jun 2022 05:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220601035545.82187-1-zhouchengming@bytedance.com>
In-Reply-To: <20220601035545.82187-1-zhouchengming@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 3 Jun 2022 14:08:32 +0200
Message-ID: <CAKfTPtAa9efmNq29KJgV46c-ncN866UViHuhJMdUrQYyhiNtzw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: update comments in enqueue/dequeue_entity()
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2022 at 05:55, Chengming Zhou <zhouchengming@bytedance.com> wrote:
>
> When reading the sched_avg related code, I found the comments in
> enqueue/dequeue_entity() are not updated with the current code.
>
> We don't add/subtract entity's runnable_avg from cfs_rq->runnable_avg
> during enqueue/dequeue_entity(), those are done only for attach/detach.
>
> This patch updates the comments to reflect the current code working.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b3371fa40548..e0cd4052e32f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4348,7 +4348,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>         /*
>          * When enqueuing a sched_entity, we must:
>          *   - Update loads to have both entity and cfs_rq synced with now.
> -        *   - Add its load to cfs_rq->runnable_avg
> +        *   - For group_entity, update its runnable_weight to reflect the new
> +        *     h_nr_running of its group cfs_rq.
>          *   - For group_entity, update its weight to reflect the new share of
>          *     its group cfs_rq
>          *   - Add its new weight to cfs_rq->load.weight
> @@ -4433,7 +4434,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>         /*
>          * When dequeuing a sched_entity, we must:
>          *   - Update loads to have both entity and cfs_rq synced with now.
> -        *   - Subtract its load from the cfs_rq->runnable_avg.
> +        *   - For group_entity, update its runnable_weight to reflect the new
> +        *     h_nr_running of its group cfs_rq.
>          *   - Subtract its previous weight from cfs_rq->load.weight.
>          *   - For group entity, update its weight to reflect the new share
>          *     of its group cfs_rq.
> --
> 2.36.1
>

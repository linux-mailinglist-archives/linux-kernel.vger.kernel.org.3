Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC135026AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 10:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348492AbiDOIex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 04:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbiDOIeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 04:34:50 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522C9AC073
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 01:32:22 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id q19so13481908ybd.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 01:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hrfTegALl0O/U8B/BL/vFUhDFRgz/coCvP1oiQwnYkw=;
        b=BEcrVQ45tO71/MI+fzfJ0qPmdjrocoIk3c95/acdjJEjVKDa26+H6XoIuN8cCMrga5
         4AoDcoltBj2Nxa69gLBTceauqJzTNidccUePcwJkn3f52sCOu9o0SgVTkeR1JrHdqDYQ
         je379uXFgUHixoYsqYyDoynWd63pbf+MMSsO+QS6Gu2fp9TlrRXxTzC2/0k+c3y1PGa+
         tYPZ76XToHO1i78hqCtaL95Nq7ltRKQZ2O//iQmNM+E0caDhdAovTsqlZ+TB+Wb+k2WI
         sYBnWo85YLniy4liWuP9CQOFCnaecYUtnz84kndBEUvkbLElRbA8JfxN6ADlIICKUbdC
         PQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hrfTegALl0O/U8B/BL/vFUhDFRgz/coCvP1oiQwnYkw=;
        b=r2Dm6sbdbWkrneP/WlqtvmZMn7RiCuoD/bnlWzS8mgiRyIj2uRnTTfQILMozgxyyPk
         RMb9pLoU8isdMexg0DW9r0QVREVoHAM48DzbaAWxSnKJIDN9UsdxUebDvk+Q6lXfK6LZ
         yG6iWg2t09966Wt0jKcvB6OWoGZ9zKW8o8hvSe6wb0qJguvm3PO0Mj23tUmeEpdgIaJ+
         xh+4P5PwGnsTT3WUe6Rujb5z6JlgC9xPAWJMyC/NCDlzx0EPsDv4xFCSUKUza2oJnqC7
         W9pALsKxp6bdDEIbG8OreukHeel7tgjoOb3ug4mMdVrqGnd+K/Io+IpLtvqb9kQaKbcP
         kdWQ==
X-Gm-Message-State: AOAM531/gIusn0E04ohPd58YXOp4Qwf6ZGxP8UrDK9mrjSVcixeHq8Yx
        z4y3WA81JeONDzutQ/qA8OvVsWeeBGKcdAAtofVECw==
X-Google-Smtp-Source: ABdhPJxAWKlWiFsydAgmWeOZWkt/jxzKyDSrBDYfX+p5MxTsOaDexoImpvD+t6AjxRA33t5JNrVSUOQnIlcCObzKlDw=
X-Received: by 2002:a25:ad98:0:b0:641:ce37:e254 with SMTP id
 z24-20020a25ad98000000b00641ce37e254mr4599298ybi.241.1650011541208; Fri, 15
 Apr 2022 01:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220415022246.14902-1-tao.zhou@linux.dev>
In-Reply-To: <20220415022246.14902-1-tao.zhou@linux.dev>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Apr 2022 10:32:09 +0200
Message-ID: <CAKfTPtAbxAerbV-LBcpm_qHAphhD3uU47k0hu=DDX3k6LS-Aow@mail.gmail.com>
Subject: Re: [PATCH V1 RESEND]: sched/fair: Revise comment about lb decision matrix
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
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

On Fri, 15 Apr 2022 at 04:22, Tao Zhou <tao.zhou@linux.dev> wrote:
>
> If busiest group type is group_misfit_task, the local
> group type must be group_has_spare according to below
> code in update_sd_pick_busiest():
>
> if (sgs->group_type == group_misfit_task &&
>     (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_capacity) ||
>      sds->local_stat.group_type != group_has_spare))
>          return false;
>
> group type imbalanced and overloaded and fully_busy are filtered in here.
> misfit and asym are filtered before in update_sg_lb_stats().

The behavior has changed with
cad68e552e77 ("sched/fair: Consider misfit tasks when load-balancing")
But we haven't updated the matrix

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>


> So, change the decision matrix to:
>
> busiest \ local has_spare fully_busy misfit asym imbalanced overloaded
> has_spare        nr_idle   balanced   N/A    N/A  balanced   balanced
> fully_busy       nr_idle   nr_idle    N/A    N/A  balanced   balanced
> misfit_task      force     N/A        N/A    N/A  *N/A*      *N/A*
> asym_packing     force     force      N/A    N/A  force      force
> imbalanced       force     force      N/A    N/A  force      force
> overloaded       force     force      N/A    N/A  force      avg_load
>
> Fixes: 0b0695f2b34a ("sched/fair: Rework load_balance()")
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Tao Zhou <tao.zhou@linux.dev>
> ---
>
> v1 changelog:
> (1) Send to MAINTAINERS/REVIEWS get from `./scripts/get_maintainer.pl`
>     suggested by Dietmar Eggemann.
> (2) Based on v5.18-rc2
>
>
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d4bd299d67ab..b8c67e7c8cf3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9495,7 +9495,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>   * busiest \ local has_spare fully_busy misfit asym imbalanced overloaded
>   * has_spare        nr_idle   balanced   N/A    N/A  balanced   balanced
>   * fully_busy       nr_idle   nr_idle    N/A    N/A  balanced   balanced
> - * misfit_task      force     N/A        N/A    N/A  force      force
> + * misfit_task      force     N/A        N/A    N/A  N/A        N/A
>   * asym_packing     force     force      N/A    N/A  force      force
>   * imbalanced       force     force      N/A    N/A  force      force
>   * overloaded       force     force      N/A    N/A  force      avg_load
> --
> 2.35.2
>

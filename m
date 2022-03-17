Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7CC4DBD62
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 04:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351310AbiCQDKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 23:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238537AbiCQDKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 23:10:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD98A21251
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:09:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n35so770393wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5LNjOLzXZNfaRuVCiO8zqbvLc/6WuHx1l+39+7jAPR4=;
        b=LTMntLDiHaWhOMPo6NHb0YbfdOVgi7dGsjruxRQXL8AZ+8qXvBTR+Gu+qifHcpaSkH
         aYchrmpMlnuPXOiGdjGEIL9+BfcpDZGGDLpR+b0ND4SCaF8NbmDXBv2Jgt1facQf2X57
         05DMfH8ope5tBo931ZiJtjzIuGnXwaAtVLhvKUZo0zrCmIKq5rvGnOTitLUiCiSynqPr
         GnkTHnF/6QlhpKvsA1ePcmf32eE/8RTDsCRpg7/HmmAcL9dFIMmZZgomehhNDLqw0MAl
         wIQkYCljYFs/WcSIr8MFGift1lCK9cd9FJSu1jRFvfGuix2SV28RCpJAHsQ024erLM/W
         xGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5LNjOLzXZNfaRuVCiO8zqbvLc/6WuHx1l+39+7jAPR4=;
        b=YG0MsHv1j2uU55nYYS8C7mCgYB8qZ5x6rl8grUHknRp0ikminwOOcm+x9q2XKCj+Kz
         qpbAHvnA9RyFckyD8ofVi8mUVOee+cfvanpx72yYqdulxwB943VZjTPmfVFpIdfthR6I
         Ezg5ohmfjlGJgVgh4KIfg8H2yJFjlqqwtkPD6xgrOnnJcg62PfNv+przaqtDchilxcKJ
         RbpUCKbM3yiEYG7K5DrrjGq9DTc8Le4/RHB1uIKbF4hu/TFDVYFu8M6pxG5G/mrQ8sTn
         wEGCK39VaEvbzd0Hkm2EgGhaNFY+3hcHooYgb3YplqyF8OOfzEEQ6hVqIpvwEmT5sA0U
         PHPA==
X-Gm-Message-State: AOAM531N/E+hrjVsm3HXrlZd0SqNtz1Hw59rroRyqhOh2kQ1V2NzsW5e
        4qsCTELga+fm5afATVL/Ub/xweLr9p10nZBpEAdRvQ==
X-Google-Smtp-Source: ABdhPJzUx6RY0JlJgFsNlUUwmZEbo5Ah3jIabHDqEWv45NY/xGsp06njJ4+0GIlXDp+2H5YUhTaCVO3vVOr45JeOjuc=
X-Received: by 2002:a05:600c:3d07:b0:38b:94f2:5d17 with SMTP id
 bh7-20020a05600c3d0700b0038b94f25d17mr2000148wmb.67.1647486574260; Wed, 16
 Mar 2022 20:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220314115354.144023-1-Julia.Lawall@inria.fr> <20220314115354.144023-31-Julia.Lawall@inria.fr>
In-Reply-To: <20220314115354.144023-31-Julia.Lawall@inria.fr>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 16 Mar 2022 20:09:22 -0700
Message-ID: <CAP-5=fV11-Haeh2SGQhtjkzYXotDjg1suaO9mDY-BeTmZxfs=g@mail.gmail.com>
Subject: Re: [PATCH 30/30] perf/core: fix typos in comments
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        kernel-janitors@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 5:48 AM Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  kernel/events/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index cfde994ce61c..25fcd4cca0d7 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -872,7 +872,7 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
>                          * event_filter_match() to not have to pass
>                          * task around
>                          * we pass the cpuctx->ctx to perf_cgroup_from_task()
> -                        * because cgorup events are only per-cpu
> +                        * because cgroup events are only per-cpu
>                          */
>                         cpuctx->cgrp = perf_cgroup_from_task(task,
>                                                              &cpuctx->ctx);
>

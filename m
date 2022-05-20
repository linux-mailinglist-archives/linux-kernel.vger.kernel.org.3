Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F34D52EAE9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347244AbiETLfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244015AbiETLfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:35:06 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA7456C2B;
        Fri, 20 May 2022 04:35:05 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id kq17so15092864ejb.4;
        Fri, 20 May 2022 04:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PKSnfNmh5PAwV0dZWUv7bsiyKNUHk1UCJgkK3J4/ff4=;
        b=gr/AFrCqCG9skC9OoN5O6DNBTNHMDIYrKb6oGqP1oukdOX1/tarACrvFhiwz+yVNbi
         CfSFXvg/kP61+j/v9iBSmH3aLvwBzghDyo4nE5RODochGaFILokcxnGwan6E/OjLpvQq
         7yWmndTcT1zgGjZifDOvfbAtyO6hvepZnXve+xy+tvludjRvHhA6915bJK0MP1sCavOV
         mBZeP4Qg46CZ3hTbClEteaQX4p9K9FT6fG3yw88ab6CjpIGIA1R1Gk/JcAWGIVuzGF0S
         8EF6KekUuOdQ8QTzVGkfDkOJxDzS7UsyehMLe1ydlD/mwtnz98Ldj97FynicwUpz1xqx
         5fOw==
X-Gm-Message-State: AOAM532vs4BQCXPW8UeWj0iVJw9uM3y/43AMYvxmMnhjUN/07PcN9FbQ
        SfJzLK9JxSs5kFosj2FxhDdshqMQo2Tw5XX2Tpber+wA7gc=
X-Google-Smtp-Source: ABdhPJybybsn1df97si3V7APCBEPEWfLEv95ysLynaQaitiMPM6pchF3IyTkYstUN0KjssnWoGeKy/zRZLSIYICRQPw=
X-Received: by 2002:a17:906:9753:b0:6fe:aafb:31a6 with SMTP id
 o19-20020a170906975300b006feaafb31a6mr2422367ejy.502.1653046503736; Fri, 20
 May 2022 04:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220513093433.425163-1-dietmar.eggemann@arm.com> <165299742675.4207.9389624037232636288.tip-bot2@tip-bot2>
In-Reply-To: <165299742675.4207.9389624037232636288.tip-bot2@tip-bot2>
From:   Barry Song <baohua@kernel.org>
Date:   Fri, 20 May 2022 23:34:52 +1200
Message-ID: <CAGsJ_4wdYrxPrXGnmEGBfzHfY0f8ON4gRwNz2z_EABzva7bmrw@mail.gmail.com>
Subject: Re: [tip: sched/core] topology: Remove unused cpu_cluster_mask()
To:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 9:57 AM tip-bot2 for Dietmar Eggemann
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the sched/core branch of tip:
>
> Commit-ID:     991d8d8142cad94f9c5c05db25e67fa83d6f772a
> Gitweb:        https://git.kernel.org/tip/991d8d8142cad94f9c5c05db25e67fa83d6f772a
> Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
> AuthorDate:    Fri, 13 May 2022 11:34:33 +02:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Thu, 19 May 2022 23:46:13 +02:00
>
> topology: Remove unused cpu_cluster_mask()
>
> default_topology[] uses cpu_clustergroup_mask() for the CLS level
> (guarded by CONFIG_SCHED_CLUSTER) which is currently provided by x86
> (arch/x86/kernel/smpboot.c) and arm64 (drivers/base/arch_topology.c).
>
> Fixes: 778c558f49a2c ("sched: Add cluster scheduler level in core and
> related Kconfig for ARM64")
>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Barry Song <baohua@kernel.org>
> Link: https://lore.kernel.org/r/20220513093433.425163-1-dietmar.eggemann@arm.com
> ---

Hi Peter,
I also received emails which say Greg has put it into drive-core-testing and
driver-core-next.
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=driver-core-next&id=15f214f9bdb7c1f5


>  include/linux/topology.h | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index f19bc36..4564faa 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -240,13 +240,6 @@ static inline const struct cpumask *cpu_smt_mask(int cpu)
>  }
>  #endif
>
> -#if defined(CONFIG_SCHED_CLUSTER) && !defined(cpu_cluster_mask)
> -static inline const struct cpumask *cpu_cluster_mask(int cpu)
> -{
> -       return topology_cluster_cpumask(cpu);
> -}
> -#endif
> -
>  static inline const struct cpumask *cpu_cpu_mask(int cpu)
>  {
>         return cpumask_of_node(cpu_to_node(cpu));

Thanks
Barry

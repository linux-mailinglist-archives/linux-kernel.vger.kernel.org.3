Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B7D5ADA4D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 22:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiIEUfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 16:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiIEUfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 16:35:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5657D1261C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 13:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=l7UcNVrpXm037V4EUEfk1Aj+vY0nmWg8YyBiKhmf0KM=; b=oqww3YLbWzy/kIKf0QgIZB55yI
        hGI9x3R1m01eENKIAgCCE1YPi+sZNb6MeQe4Q1k18z3PQjURe29cJXSE3vuNnRquoqaXETNaFRh+N
        2XPUUn41SIkD2LE0dUnltBBua5c6hUdT0u+22IaDuzdhDvB6uZ13SdvB5irTb+cTXHCOwoGmhN9hX
        WSyUHaDF7WYa49ebTM4rCY3Y0xV+tgMxv/DnS2xgKNs6sRLeqTEAm1WerUlGIhVsYhj4Oz5UeKep1
        5IsbiisIj+Td2ha3K62sIQu0Kdyc5/He5vq946a+pv/RpsNAajMMZ1o6/SndlqL6pZ30nXc2Y2Ley
        2AwPCSeg==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVIo4-00Ain8-5W; Mon, 05 Sep 2022 20:34:56 +0000
Message-ID: <8d77cc18-3465-9f9c-e177-857fa6ec4d82@infradead.org>
Date:   Mon, 5 Sep 2022 13:34:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH RESEND] sched/topology: Add __init for init_defrootdomain
Content-Language: en-US
To:     Bing Huang <huangbing775@126.com>, rostedt@goodmis.org,
        dietmar.eggemann@arm.com
Cc:     brauner@kernel.org, bristot@redhat.com, bsegall@google.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org
References: <20220831093927.5904-1-huangbing775@126.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220831093927.5904-1-huangbing775@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/22 02:39, Bing Huang wrote:
> From: Bing Huang <huangbing@kylinos.cn>
> 
> init_defrootdomain is only used in initialization
> 
> Signed-off-by: Bing Huang <huangbing@kylinos.cn>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  kernel/sched/sched.h    | 2 +-
>  kernel/sched/topology.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index b0bf2287dd9d..cd761f1fc60c 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -883,7 +883,7 @@ struct root_domain {
>  	struct perf_domain __rcu *pd;
>  };
>  
> -extern void init_defrootdomain(void);
> +extern void __init init_defrootdomain(void);
>  extern int sched_init_domains(const struct cpumask *cpu_map);
>  extern void rq_attach_root(struct rq *rq, struct root_domain *rd);
>  extern void sched_get_rd(struct root_domain *rd);
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 8739c2a5a54e..dea9fa39e7c0 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -578,7 +578,7 @@ static int init_rootdomain(struct root_domain *rd)
>   */
>  struct root_domain def_root_domain;
>  
> -void init_defrootdomain(void)
> +void __init init_defrootdomain(void)
>  {
>  	init_rootdomain(&def_root_domain);
>  

-- 
~Randy

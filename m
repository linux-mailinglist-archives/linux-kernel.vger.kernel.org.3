Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C065AF8FE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 02:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiIGAgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 20:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiIGAgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 20:36:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535D1857FE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 17:36:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFEAD61721
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DCBC433C1;
        Wed,  7 Sep 2022 00:36:34 +0000 (UTC)
Date:   Tue, 6 Sep 2022 20:37:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Bing Huang <huangbing775@126.com>
Cc:     dietmar.eggemann@arm.com, brauner@kernel.org, bristot@redhat.com,
        bsegall@google.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org
Subject: Re: [PATCH RESEND] sched/topology: Add __init for
 init_defrootdomain
Message-ID: <20220906203713.4b1a2bbb@gandalf.local.home>
In-Reply-To: <20220831093927.5904-1-huangbing775@126.com>
References: <20220831093927.5904-1-huangbing775@126.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2022 17:39:27 +0800
Bing Huang <huangbing775@126.com> wrote:

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

Function prototypes in headers do not need annotations like __init.

-- Steve

>  extern int sched_init_domains(const struct cpumask *cpu_map);
>  extern void rq_attach_root(struct rq *rq, struct root_domain *rd);
>  extern void sched_get_rd(struct root_domain *rd);

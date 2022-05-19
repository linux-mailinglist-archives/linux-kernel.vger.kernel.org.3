Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCEA52CA92
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 05:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiESDzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 23:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiESDzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 23:55:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3EFB41
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 20:55:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 184D361362
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A33C385B8;
        Thu, 19 May 2022 03:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652932542;
        bh=mMELOShcqFrCb7QBnJJis+SiNf1QFtI83sU806A0IHg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JjI09uTq+7kHJr9vaAnZWs495qK8jX0Teme9rpPI+LnGhCNotErIFo2ZHHXBTX+Fo
         qhWAJcAunhwi1N6iQG9o+vZl/s9MgTbiwI/g+8yGjY96D069ZTC+WEvFK68gKbUm1S
         GklGME1a1YK5TcNL8rdOQUv07+g3pSStagbl8bzMy3ixx58F8hz4vldXBFUKjRsXKv
         cEohHkeV/bVOIDqekYjP9wC+eIiteriphqQqV8454cn+QXsNp6fDOx7+AtgVvdOuGA
         JBOhAgPo9KOuC9dzeEYybXBtGrLr66ka/DCbdbK6z4BSJAsZGBN7mwIiKBf8BEyyru
         cTSKslmC3mztg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 157205C033E; Wed, 18 May 2022 20:55:42 -0700 (PDT)
Date:   Wed, 18 May 2022 20:55:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ammarfaizi2-block:paulmck/linux-rcu/dev 53/55]
 include/linux/rcupdate.h:207:34: error: implicit declaration of function
 'rcu_tasks_trace_qs'; did you mean 'rcu_tasks_classic_qs'?
Message-ID: <20220519035542.GU1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202205191043.pLKc0AwM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205191043.pLKc0AwM-lkp@intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 10:42:19AM +0800, kernel test robot wrote:
> tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev
> head:   b2a7e376a9dcfa2de46236696dfdd48275edf63d
> commit: 840470b0e655a13aae153f3b46d1e02fadf5c06a [53/55] fixup! tasks-rcu: Track blocked RCU Tasks Trace readers
> config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220519/202205191043.pLKc0AwM-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
> reproduce (this is a W=1 build):
>         # https://github.com/ammarfaizi2/linux-block/commit/840470b0e655a13aae153f3b46d1e02fadf5c06a
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev
>         git checkout 840470b0e655a13aae153f3b46d1e02fadf5c06a
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Good catch, fix is not on -rcu and will be folded into the original
with attribution.

							Thanx, Paul

> All errors (new ones prefixed by >>):
> 
>    kernel/sched/core.c:5235:20: warning: no previous prototype for 'task_sched_runtime' [-Wmissing-prototypes]
>     5235 | unsigned long long task_sched_runtime(struct task_struct *p)
>          |                    ^~~~~~~~~~~~~~~~~~
>    In file included from include/linux/rculist.h:11,
>                     from include/linux/dcache.h:8,
>                     from include/linux/fs.h:8,
>                     from include/linux/highmem.h:5,
>                     from kernel/sched/core.c:9:
>    kernel/sched/core.c: In function '__schedule':
> >> include/linux/rcupdate.h:207:34: error: implicit declaration of function 'rcu_tasks_trace_qs'; did you mean 'rcu_tasks_classic_qs'? [-Werror=implicit-function-declaration]
>      207 | #define rcu_tasks_qs(t, preempt) rcu_tasks_trace_qs(t);
>          |                                  ^~~~~~~~~~~~~~~~~~
>    include/linux/rcutiny.h:74:17: note: in expansion of macro 'rcu_tasks_qs'
>       74 |                 rcu_tasks_qs(current, (preempt)); \
>          |                 ^~~~~~~~~~~~
>    kernel/sched/core.c:6279:9: note: in expansion of macro 'rcu_note_context_switch'
>     6279 |         rcu_note_context_switch(!!sched_mode);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~
>    kernel/sched/core.c: At top level:
>    kernel/sched/core.c:9432:13: warning: no previous prototype for 'sched_init_smp' [-Wmissing-prototypes]
>     9432 | void __init sched_init_smp(void)
>          |             ^~~~~~~~~~~~~~
>    kernel/sched/core.c:9460:13: warning: no previous prototype for 'sched_init' [-Wmissing-prototypes]
>     9460 | void __init sched_init(void)
>          |             ^~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> 
> vim +207 include/linux/rcupdate.h
> 
>    201	
>    202	#define rcu_note_voluntary_context_switch(t) rcu_tasks_qs(t, false)
>    203	void exit_tasks_rcu_start(void);
>    204	void exit_tasks_rcu_finish(void);
>    205	#else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
>    206	#define rcu_tasks_classic_qs(t, preempt) do { } while (0)
>  > 207	#define rcu_tasks_qs(t, preempt) rcu_tasks_trace_qs(t);
>    208	#define rcu_note_voluntary_context_switch(t) do { } while (0)
>    209	#define call_rcu_tasks call_rcu
>    210	#define synchronize_rcu_tasks synchronize_rcu
>    211	static inline void exit_tasks_rcu_start(void) { }
>    212	static inline void exit_tasks_rcu_finish(void) { }
>    213	#endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
>    214	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

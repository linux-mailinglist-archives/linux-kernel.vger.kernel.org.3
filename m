Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5B94DCF58
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiCQUau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiCQUap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:30:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15B5117C89;
        Thu, 17 Mar 2022 13:29:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 725AEB81FA4;
        Thu, 17 Mar 2022 20:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F3BC340E9;
        Thu, 17 Mar 2022 20:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647548966;
        bh=nHZwFcPsHoZVPZiFNEOBkiOiqLLgmQsX4Mrh69nQA1o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=S1JuBb5QQZ0+q3D9jXHa386W5uyo9LclhrJH6QDKxTEVzJ2a6waIoh+e/2qmYrgCR
         DBhU9cynAiz29nIKGGrVOHsC8rI6qIgENYndg1MnThvtR8tvlTUOGHE8ZZ0p8u0iQ3
         UDmOlxF/CNhR02I/Ga39fnM1o/r/2Zpe7JS0Fxf/pxEmGl/a0Natqf7D6d+RmIkbss
         wcOikc9COeNL5xWU2ii9PFmXCQobr5GuzYb/maef3SnuPOcQnKDwo3tIpgIFz5XPl/
         G+l+3QYcSQH2GQl1Obh/jntHuTECNaTf+E6Y7yY1OK7NDULKtJuEZ78JJHitA1K+f9
         rwIW+5nr0GeLg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CA98E5C08A0; Thu, 17 Mar 2022 13:29:25 -0700 (PDT)
Date:   Thu, 17 Mar 2022 13:29:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: Re: RCU: undefined reference to irq_work_queue
Message-ID: <20220317202925.GS4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YjMcZexG/kJepYDi@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <20220317140000.GO4285@paulmck-ThinkPad-P17-Gen-1>
 <YjNSuprCqjAgGgqB@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <20220317162033.GP4285@paulmck-ThinkPad-P17-Gen-1>
 <YjNll+Iv++LORS0n@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <20220317173621.GQ4285@paulmck-ThinkPad-P17-Gen-1>
 <48d30a49-541f-ac67-aa2a-bef8b182dcd9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48d30a49-541f-ac67-aa2a-bef8b182dcd9@infradead.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 01:26:45PM -0700, Randy Dunlap wrote:
> 
> 
> On 3/17/22 10:36, Paul E. McKenney wrote:
> > On Thu, Mar 17, 2022 at 04:45:11PM +0000, Hyeonggon Yoo wrote:
> >> On Thu, Mar 17, 2022 at 09:20:33AM -0700, Paul E. McKenney wrote:
> >>> On Thu, Mar 17, 2022 at 03:24:42PM +0000, Hyeonggon Yoo wrote:
> >>>> On Thu, Mar 17, 2022 at 07:00:00AM -0700, Paul E. McKenney wrote:
> >>>>> On Thu, Mar 17, 2022 at 11:32:53AM +0000, Hyeonggon Yoo wrote:
> >>>>>> Hello RCU folks,
> >>>>>>
> 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 678a80713b21..66c5b5543511 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -38,6 +38,7 @@ config KPROBES
> >  	depends on MODULES
> >  	depends on HAVE_KPROBES
> >  	select KALLSYMS
> > +	select TASKS_RCU if PREEMPTION
> >  	help
> >  	  Kprobes allows you to trap at almost any kernel address and
> >  	  execute a callback function.  register_kprobe() establishes
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index f559870fbf8b..4f665ae0cf55 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -78,7 +78,8 @@ config TASKS_RCU_GENERIC
> >  	  task-based RCU implementations.  Not for manual selection.
> >  
> >  config TASKS_RCU
> > -	def_bool PREEMPTION
> > +	def_bool 0
> 
> preferably
> 	def_bool n
> 
> but the 0 probably works...  :)

In a later commit, it ends up like this:

config TASKS_TRACE_RCU
	bool "Enable Tasks Trace RCU"
	depends on RCU_EXPERT
	default n
	select IRQ_WORK
	help
	  This option enables a task-based RCU implementation that uses
	  explicit rcu_read_lock_trace() read-side markers, and allows
	  these readers to appear in the idle loop as well as on the CPU
	  hotplug code paths.  It can force IPIs on online CPUs, including
	  idle ones, so use with caution.

The reason being to allow people to use rcutorture without having
to have TASKS_TRACE_RCU enabled.

So you got your wish!  I think...  ;-)

							Thanx, Paul

> > +	select IRQ_WORK
> >  	help
> >  	  This option enables a task-based RCU implementation that uses
> >  	  only voluntary context switch (not preemption!), idle, and
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index 752ed89a293b..a7aaf150b704 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -127,6 +127,7 @@ config TRACING
> >  	select BINARY_PRINTF
> >  	select EVENT_TRACING
> >  	select TRACE_CLOCK
> > +	select TASKS_RCU if PREEMPTION
> >  
> >  config GENERIC_TRACER
> >  	bool
> 
> -- 
> ~Randy

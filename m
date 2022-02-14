Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69A24B5BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiBNUzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:55:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiBNUzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:55:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E4A4505D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CXEqwpQFX6+wtg9ntMCowRKmtf3vYnKkWg75N3fDGBM=; b=TOoEE9VYw3HhWdMRJcdgkO5wX6
        o+sRHoBbN6ayVTjwpsHWSjrhk4FldjYS++5hVexgMPIRaW3Rc3yLCTUMfcjhRAYRuguwlTRW9qEL/
        8sfta/Zml0CQZxIFWQU/UdeIzeCRLncKrOF5a5V94MQFu6oJuhoMY9ir6Kzoq0ueepnFaXKCTB8bp
        HQNYNFtobL1zCxIWNCYGhdYxiNHkUiUrJoTKB92R+5HYpzM7e3uaGIPeemS8Vi5z3IUTF8Hp/46lI
        w3QqWsCbVEwks61fVA868Wnw5eBkuVESaiLe5h0OCxwvxN2hjY4R16Sk0LFKvcCoEOYjO19/Vhu0G
        sMuGzPzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJh8f-00DCih-2N; Mon, 14 Feb 2022 19:35:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D255D30003C;
        Mon, 14 Feb 2022 20:35:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F6012B524F1E; Mon, 14 Feb 2022 20:35:54 +0100 (CET)
Date:   Mon, 14 Feb 2022 20:35:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        zhangqiao22@huawei.com, dietmar.eggemann@arm.com
Subject: Re: [GIT PULL] sched/urgent for 5.17-rc4
Message-ID: <YgqvGuQUF1BdpAl0@hirez.programming.kicks-ass.net>
References: <Ygj7feK+vdtPw6zj@zn.tnic>
 <CAHk-=wiHUWHHcPLCvyXQKf2wbL3L1SOQSGVuCdf-py6QZGnuqQ@mail.gmail.com>
 <YgoWoh6pIzlsQx6d@hirez.programming.kicks-ass.net>
 <YgoeCbwj5mbCR0qA@hirez.programming.kicks-ass.net>
 <YgqquDnQe3SihgJU@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgqquDnQe3SihgJU@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 09:17:12AM -1000, Tejun Heo wrote:
> Hello, Peter.
> 
> On Mon, Feb 14, 2022 at 10:16:57AM +0100, Peter Zijlstra wrote:
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index d75a528f7b21..05faebafe2b5 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -2266,6 +2266,13 @@ static __latent_entropy struct task_struct *copy_process(
> >  	if (retval)
> >  		goto bad_fork_put_pidfd;
> >  
> > +	/*
> > +	 * Now that the cgroups are pinned, re-clone the parent cgroup and put
> > +	 * the new task on the correct runqueue. All this *before* the task
> > +	 * becomes visible.
> > +	 */
> > +	sched_cgroup_fork(p, args);
> 
> Would it be less confusing to comment that this isn't ->can_fork() because
> scheduler task_group needs to be initialized for autogroup even when cgroup
> is disabled and maybe name it sched_cgroup_can_fork() even if it always
> succeeds?

So there's two things that need doing; the re-cloning of the task_group
thing, but also calling of __set_task_cpu() which sets up the proper
runqueue links.

The first is CGroup only, and *could* in theory be done in ->can_fork(),
but the second needs to be done unconditionally, and it doesn't make
much sense to split this up.

I actually tried, but it made the patch bigger/uglier -- but maybe I
didn't try hard enough.

> > +void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
> >  {
> >  	unsigned long flags;
> > -#ifdef CONFIG_CGROUP_SCHED
> > -	struct task_group *tg;
> > -#endif
> >  
> > +	/*
> > +	 * Because we're not yet on the pid-hash, p->pi_lock isn't strictly
> > +	 * required yet, but lockdep gets upset if rules are violated.
> > +	 */
> >  	raw_spin_lock_irqsave(&p->pi_lock, flags);
> >  #ifdef CONFIG_CGROUP_SCHED
> > -	tg = container_of(kargs->cset->subsys[cpu_cgrp_id],
> > -			  struct task_group, css);
> > -	p->sched_task_group = autogroup_task_group(p, tg);
> > +	if (1) {
> > +		struct task_group *tg;
> > +		tg = container_of(kargs->cset->subsys[cpu_cgrp_id],
> > +				  struct task_group, css);
> > +		tg = autogroup_task_group(p, tg);
> > +		p->sched_task_group = autogroup_task_group(p, tg);
> > +	}
> 
> I suppose the double autogroup_task_group() call is unintentional?

Yeah, that's a silly fail. Will ammend.

> Otherwise, looks good to me. The only requirement from cgroup side is that
> the membership should be initialized between ->can_fork() and ->fork()
> inclusively, and sans autogroup this would have been done as a part of
> ->can_fork() so the proposed change makes sense to me.

Thanks! I suppose I should go write me a Changelog then... assuming it
actually works :-)

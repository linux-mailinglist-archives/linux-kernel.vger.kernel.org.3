Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FCB5539F6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352654AbiFUTDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352836AbiFUTDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:03:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07C619F9E;
        Tue, 21 Jun 2022 12:03:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FF0461705;
        Tue, 21 Jun 2022 19:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22B6C3411C;
        Tue, 21 Jun 2022 19:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655838201;
        bh=DYS6SmF1cWO7uZWqH5rXy0cddt6Ll9bCEa6QEeOeldc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tXP5fJcPS71401So7CDEAaKEl9RDMnBpHBMYMOYGzZfmuoscyeROjEVTlJebW0b4f
         Igh6cjr0WORRyHc54ik1XrdMWx8j3dpS2C3hbJZk2ggmNMr71oAcWy7Yp1gPIRbm2y
         ZQ/jko6PBtHnYn0W4k77PWoMP49C3ZVFtaVvH25Ww4M98sSOB+6R1bNtMPTBDYHlCG
         CrHc23ALbK7FGiN07UU38/XNz8gdqUytcQN+o4yOrrU7Q7f6a1dIVsp9P/27KtM+rz
         Xxt1lUF5nEW8nxnPSZlDWU9Z5GXOzk6CkaqkIVIn/5k0qG9TbpU4RfXYCcigyGZopP
         GX1U7lEZRkw0g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 82BED5C09AF; Tue, 21 Jun 2022 12:03:20 -0700 (PDT)
Date:   Tue, 21 Jun 2022 12:03:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH rcu 3/3] doc: Document
 rcutree.nocb_nobypass_lim_per_jiffy kernel parameter
Message-ID: <20220621190320.GL1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220620221733.GA3839136@paulmck-ThinkPad-P17-Gen-1>
 <20220620221757.3839212-3-paulmck@kernel.org>
 <3988b203-0a65-526e-b445-c2ee9ea0f4e8@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3988b203-0a65-526e-b445-c2ee9ea0f4e8@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 10:41:54AM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 6/21/2022 3:47 AM, Paul E. McKenney wrote:
> > This commit provides documentation for the kernel parameter controlling
> > RCU's handling of callback floods on offloaded (rcu_nocbs) CPUs.
> > This parameter might be obscure, but it is always there when you need it.
> > 
> > Reported-by: Frederic Weisbecker <frederic@kernel.org>
> > Reported-by: Uladzislau Rezki <urezki@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> 
> Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> 
> >   Documentation/admin-guide/kernel-parameters.txt | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index bdf431bdbfdc4..a30890141b1a5 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -4681,6 +4681,19 @@
> >   			invoked in the context of an rcuoc kthread, which
> >   			scheduler will preempt as it does any other task.
> > +	rcutree.nocb_nobypass_lim_per_jiffy= [KNL]
> > +			On callback-offloaded (rcu_nocbs) CPUs,
> > +			RCU reduces the lock contention that would
> > +			otherwise be caused callback floods through
> 
> Minor : "caused by" ?

Good catch, fixed, thank you!

I applied your Reviewed-by to this series as well, and thank you for
that as well.

							Thanx, Paul

> Thanks
> Neeraj
> 
> > +			use of the ->nocb_bypass list.	However, in the
> > +			common non-flooded case, RCU queues directly to
> > +			the main ->cblist in order to avoid the extra
> > +			overhead of the ->nocb_bypass list and its lock.
> > +			But if there are too many callbacks queued during
> > +			a single jiffy, RCU pre-queues the callbacks into
> > +			the ->nocb_bypass queue.  The definition of "too
> > +			many" is supplied by this kernel boot parameter.
> > +
> >   	rcutree.rcu_nocb_gp_stride= [KNL]
> >   			Set the number of NOCB callback kthreads in
> >   			each group, which defaults to the square root

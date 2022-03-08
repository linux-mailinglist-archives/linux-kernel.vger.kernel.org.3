Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BFE4D1FA1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348330AbiCHSFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiCHSFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:05:25 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB735521D;
        Tue,  8 Mar 2022 10:04:28 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id h14so8686110lfk.11;
        Tue, 08 Mar 2022 10:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6SHxHLXJ2eYyw1tnxtVXf2yck6AofzgpVIfso9u7DAE=;
        b=YWxBm6Jx9v7Wlb2fdyVA4R/eCLykHIu5057o5yoxhiNe1ckeEcYcuoIlvL0CXgyUUS
         iCcHfjSkiUebD2r7d935yPKizxOzpol4fVwzGhe1sxB1SXtbSjuBLWqAfhVvXomhyf7V
         BnXT8+SGpjmpIZ/L55h1bxZ3H2uZjmLJz3IlPnl59Ufs7nykyUUz1vFD+GJdAuAbfX72
         aDVKhnqFKkHplJiX2aOCMqJuGarphm3J7iBCGW4p41f350GRxKuiNvo8YaK6XmNTj1kT
         RwpAlAlpMgMInq7c/Fe45mxLaG95Ut4PwQ1pI+fqY/6Q5msR6vrqmQMsjGVAp/pbCwXr
         RpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6SHxHLXJ2eYyw1tnxtVXf2yck6AofzgpVIfso9u7DAE=;
        b=lDBaT3/xIImb5z61/nNpvi8aXv8Y4u3xWma3Mru8rgRiKz8DwQQfWkHs/yqAl1RV2a
         ipNPpbtjG1/krBElTnAafrP3eB4DeV+5/Zi1PTFHkA2JOxNCLVt0iAX9pKEqSDetiyRx
         PMnWlXVpM4ycZr5jOfiJbz2m7hR6LFjjOthfyb7Od2CN8ZqSbKC+eNVdUtgL4S0KO8sT
         UlCMIhw5Feg8EHurBigsWQeHAO7Vad/mL9tdmGtQR0YwxD5bwbyIAx9hZ46KhY4LOiDn
         +14/7AAqm0WFUXSkHPeF2H/04tZxuFVSZeYpAWhGIr0wmpU9EQMPoJ/ep7THYb0e6WUZ
         GJbg==
X-Gm-Message-State: AOAM530Om+IiySecn3ONSCXt1YrYXdYk5v8uqFSNjeiy6FeegCkvWXQH
        aeevQD85h6yZUjWmRk4Juxc=
X-Google-Smtp-Source: ABdhPJzM/6dGiiSrzkwSlZG8G/sBalDM4RxDurXpIFsD9rt6m80xcXA4TbZGf9jQFZCFTRpLPDs6cA==
X-Received: by 2002:a05:6512:3ca2:b0:445:98f6:40df with SMTP id h34-20020a0565123ca200b0044598f640dfmr11391467lfv.293.1646762664244;
        Tue, 08 Mar 2022 10:04:24 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id l11-20020a2e834b000000b00246308690e2sm3986488ljh.85.2022.03.08.10.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 10:04:23 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 8 Mar 2022 19:04:21 +0100
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>, paulmck@kernel.org,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        rcu@vger.kernel.org, bigeasy@linutronix.de
Subject: Re: [PATCH] rcu: Only boost rcu reader tasks with lower priority
 than boost kthreads
Message-ID: <YieapfzKvy2chaHT@pc638.lan>
References: <20220304092631.4123188-1-qiang1.zhang@intel.com>
 <81f69dd4-6ca9-760c-bec5-5cb27afbe788@quicinc.com>
 <PH0PR11MB5880026EBBE3E195549E2245DA089@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220307191512.GN4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307191512.GN4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Mar 07, 2022 at 02:03:17AM +0000, Zhang, Qiang1 wrote:
> > On 3/4/2022 2:56 PM, Zqiang wrote:
> > > When RCU_BOOST is enabled, the boost kthreads will boosting readers
> > > who are blocking a given grace period, if the current reader tasks
> > > have a higher priority than boost kthreads(the boost kthreads priority
> > > not always 1, if the kthread_prio is set), boosting is useless, skip
> > > current task and select next task to boosting, reduce the time for a
> > > given grace period.
> > > 
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> 
> Adding to CC to get more eyes on this.  I am not necessarily opposed to
> it, but I don't do that much RT work myself these days.
> 
> 							Thanx, Paul
> 
> > > ---
> > >   kernel/rcu/tree_plugin.h | 10 +++++++++-
> > >   1 file changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > index c3d212bc5338..d35b6da66bbd 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -12,6 +12,7 @@
> > >    */
> > >   
> > >   #include "../locking/rtmutex_common.h"
> > > +#include <linux/sched/deadline.h>
> > >   
> > >   static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
> > >   {
> > > @@ -1065,13 +1066,20 @@ static int rcu_boost(struct rcu_node *rnp)
> > >   	 * section.
> > >   	 */
> > >   	t = container_of(tb, struct task_struct, rcu_node_entry);
> > > +	if (!rnp->exp_tasks && (dl_task(t) || t->prio <= current->prio)) {
> > > +		tb = rcu_next_node_entry(t, rnp);
> > > +		WRITE_ONCE(rnp->boost_tasks, tb);
> > > +		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > > +		goto end;
> > > +	}
> > > +
Why do you bypass the expedited grace period and boost any tasks anyway?
Same way the expedited gp can be blocked by higher prior tasks SCHED_DEADLINE
or SCHED_FIFO.

Thanks!

--
Vlad Rezki

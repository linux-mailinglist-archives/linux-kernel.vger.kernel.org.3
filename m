Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045FB4B2A93
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351622AbiBKQkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:40:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347115AbiBKQkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:40:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC0BD4B;
        Fri, 11 Feb 2022 08:40:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC74361599;
        Fri, 11 Feb 2022 16:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F83EC340E9;
        Fri, 11 Feb 2022 16:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644597639;
        bh=eeqTVzL/a+DOXrq9H7lm817bPYxq+xj7pXgT/P+7nP8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cWPKHw0iprqzFyBRz0nUwBKTgEClmy/NxMfEUCd+FhZ+5A6VsxiRFrd7wvnS+RRCY
         8+Va3pNDFnbIOmGkzSvANjgyl69LSNVvjdbbjUpVusaD4JOUgKAUhG/XGhJi7IyDLP
         CI6NyRI20lbPBKRb9/ddT6YmIAhZHTrVqrURKAE/CtM/SwPtxcGzWGo9iydD4Dl0p+
         itookMCj+wx3PqadIFpyjI7txtblAoJzgfAyINuuk/eQtzzMomy7dGqFqp+lK0+No3
         K4QFKcA4YIvLUD9n/4ZGNvOvyUDwEsFrjS3wDDSvq1WRiTRjE5ZdzuM1LByn2PRscJ
         886ljIfSDlfTg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 25A905C0610; Fri, 11 Feb 2022 08:40:39 -0800 (PST)
Date:   Fri, 11 Feb 2022 08:40:39 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: Re: [PATCH rcu 1/9] MAINTAINERS:  Add Frederic and Neeraj to their
 RCU files
Message-ID: <20220211164039.GE4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
 <20220204230805.4193767-1-paulmck@kernel.org>
 <20220211151529.GB588079@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211151529.GB588079@lothringen>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 04:15:29PM +0100, Frederic Weisbecker wrote:
> On Fri, Feb 04, 2022 at 03:07:57PM -0800, Paul E. McKenney wrote:
> > Adding Frederic as an RCU maintainer for kernel/rcu/tree_nocb.h given his
> > work with offloading and de-offloading callbacks from CPUs.  Also adding
> > Neeraj for kernel/rcu/tasks.h given his focused work on RCU Tasks Trace.
> > As in I am reasonably certain that each understands the full contents
> > of the corresponding file.
> > 
> > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Thanks! :)

Thank -you- for all the help with RCU!

I will apply on my next rebase.

							Thanx, Paul

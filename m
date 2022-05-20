Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD01252ECDA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349691AbiETNGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345583AbiETNFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:05:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A20C45;
        Fri, 20 May 2022 06:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q7pbVBAHPQM0y9nwLh5CftmxKDJeGL1/oDdQeZU/1YY=; b=ZTy9tmPTu3Gf32iVSNM3rIUxxu
        J9M58n4t7fxEb6KlEaps9T/lpbjVMdaeMM379dEG9fhvKN0Yck3EDxBHV5FUb4/ad9CWc5Gp12EHh
        uqe5c1oQjGOcsW8+YMlPuXZKx3FwXxf2p34ZTi/Womn0mITjoiPq5XP7qu/VnZcEL9fNi1Uu9MoyM
        si2PL/6Ynn0uUqgCn0Nmd2n7sBpe3wJux+8HWihak+3eBpuB5iO5rYsZjhWh79ayHF5wtS0U7Bpry
        BnyC3kF2znUBTcR1DnAtJzh2cfgznOz30dL/2h0zjTR/xhOPdmoML09C+YSNYHX+JgJZ1E75KuVM5
        nYhsAUug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ns2KC-00Dl0A-JL; Fri, 20 May 2022 13:05:48 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 256B5981243; Fri, 20 May 2022 15:05:48 +0200 (CEST)
Date:   Fri, 20 May 2022 15:05:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Barry Song <baohua@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-tip-commits@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        x86 <x86@kernel.org>
Subject: Re: [tip: sched/core] topology: Remove unused cpu_cluster_mask()
Message-ID: <20220520130548.GU2578@worktop.programming.kicks-ass.net>
References: <20220513093433.425163-1-dietmar.eggemann@arm.com>
 <165299742675.4207.9389624037232636288.tip-bot2@tip-bot2>
 <CAGsJ_4wdYrxPrXGnmEGBfzHfY0f8ON4gRwNz2z_EABzva7bmrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4wdYrxPrXGnmEGBfzHfY0f8ON4gRwNz2z_EABzva7bmrw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 11:34:52PM +1200, Barry Song wrote:
> On Fri, May 20, 2022 at 9:57 AM tip-bot2 for Dietmar Eggemann
> <tip-bot2@linutronix.de> wrote:
> >
> > The following commit has been merged into the sched/core branch of tip:
> >
> > Commit-ID:     991d8d8142cad94f9c5c05db25e67fa83d6f772a
> > Gitweb:        https://git.kernel.org/tip/991d8d8142cad94f9c5c05db25e67fa83d6f772a
> > Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
> > AuthorDate:    Fri, 13 May 2022 11:34:33 +02:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Thu, 19 May 2022 23:46:13 +02:00
> >
> > topology: Remove unused cpu_cluster_mask()
> >
> > default_topology[] uses cpu_clustergroup_mask() for the CLS level
> > (guarded by CONFIG_SCHED_CLUSTER) which is currently provided by x86
> > (arch/x86/kernel/smpboot.c) and arm64 (drivers/base/arch_topology.c).
> >
> > Fixes: 778c558f49a2c ("sched: Add cluster scheduler level in core and
> > related Kconfig for ARM64")
> >
> > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Acked-by: Barry Song <baohua@kernel.org>
> > Link: https://lore.kernel.org/r/20220513093433.425163-1-dietmar.eggemann@arm.com
> > ---
> 
> Hi Peter,
> I also received emails which say Greg has put it into drive-core-testing and
> driver-core-next.
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=driver-core-next&id=15f214f9bdb7c1f5

Damn, I must've missed that. It think git will DTRT and the trees will
merge painlessly.

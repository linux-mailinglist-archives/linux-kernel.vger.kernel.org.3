Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ED55AFE86
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiIGIG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiIGIGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:06:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA194F658
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5xZgCU1Wna/4BF7JiA7KXVQmskvEFoxTs90kjwB9gZg=; b=OiDdo0uzIzmIXCRf4iGV2u+r/+
        PMbWPVORg8Tf3nC9KCA/XHVwRxcaE8RDAOrtL6/4fUHvS0yqSxTxGcfOHsrqOyVwRPwvxMS8SH/rK
        mYs1WLKOWrFyXulmjOv9mFkUwfyXYcaewBzbnu0qI+/m4kRhHcqUJ59AO8majA/bAeY+8XEvwyycb
        FfmWCrECYV3Em3jBT4pm6R2FTGM6o3CXhekEYGvKzW4vIUtwFb1BPS0/SdhdW69wo07Y/56j/4BoV
        7RJh4Y2oNU3iHZKQMWA37U0gDjOmTSUNho5W/ct6uAO2Ajuz4DP+sdXxPQ5biR5BIMjP6MkZ/efuQ
        dK2a2Irw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVq4U-00AOrK-6t; Wed, 07 Sep 2022 08:06:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8031F3003B0;
        Wed,  7 Sep 2022 10:06:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B98C2B98C608; Wed,  7 Sep 2022 10:06:05 +0200 (CEST)
Date:   Wed, 7 Sep 2022 10:06:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     kernel test robot <lkp@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [peterz-queue:sched/psi 11/11]
 include/linux/cgroup-defs.h:432:38: error: 'NR_PSI_RESOURCES' undeclared
 here (not in a function)
Message-ID: <YxhQ7U0HggaWTmEm@hirez.programming.kicks-ass.net>
References: <202209070242.7EuRnstk-lkp@intel.com>
 <e95c6e55-a023-b6f7-1dce-4195dc22114a@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e95c6e55-a023-b6f7-1dce-4195dc22114a@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 10:45:55AM +0800, Chengming Zhou wrote:
> On 2022/9/7 02:33, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/psi
> > head:   51beb408c569e516780c84a2020920432ad4c5ed
> > commit: 51beb408c569e516780c84a2020920432ad4c5ed [11/11] sched/psi: Per-cgroup PSI accounting disable/re-enable interface
> > config: i386-randconfig-a001
> > compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
> > reproduce (this is a W=1 build):
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=51beb408c569e516780c84a2020920432ad4c5ed
> >         git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
> >         git fetch --no-tags peterz-queue sched/psi
> >         git checkout 51beb408c569e516780c84a2020920432ad4c5ed
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         make W=1 O=build_dir ARCH=i386 prepare
> > 
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    In file included from include/linux/cgroup.h:28,
> >                     from include/linux/memcontrol.h:13,
> >                     from include/linux/swap.h:9,
> >                     from include/linux/suspend.h:5,
> >                     from arch/x86/kernel/asm-offsets.c:13:
> >>> include/linux/cgroup-defs.h:432:38: error: 'NR_PSI_RESOURCES' undeclared here (not in a function)
> >      432 |         struct cgroup_file psi_files[NR_PSI_RESOURCES];
> 
> Sorry, looks like there are two problems here:
> 
> 1. NR_PSI_RESOURCES is undeclared when !CONFIG_PSI
> 
>    Should I send the below diff as a separate patch?

Please reply to the original patch with an updated version and I'll
replace it.

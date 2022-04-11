Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9F04FC46E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 20:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349286AbiDKSza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 14:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345922AbiDKSz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 14:55:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF891EC5B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 11:53:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53DF6B81863
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 18:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE826C385A3;
        Mon, 11 Apr 2022 18:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649703190;
        bh=vv84uKbVS+hxFB6giwq10nnkvVB1xuCUi3PO3ukXwWw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RVRnFGVIa8Z2l826oF1KuXc97UUKVLR3Cxfk1cUg+kiC4Y7b2z0c5oFCc4Kb34vv0
         95C1+IP6pO6DXTlBpDNGH52o4ncqkZMhb34HYQ/k6ZkW89We3rziFugXrBY7pjZrk4
         xcgqBbawuaSLKlHaH1OrQjb+FUaPpmJoQlfyzIoxidgJxaOAlOOLh/q749cAgfA0Ry
         YrODsh9xsqt7itqGueXGpdkGr90TWliaFj/+XLReAfA8/VGWboc/jP73A1rDrpXOKr
         lnhPaktgmfpBwKfs8L23ez1+q4iHRZPap1iHr0Stdzngw2SLlZJtr8gi7Nm9T7hvg9
         0B+r4IPfX0GZw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8176D5C04BE; Mon, 11 Apr 2022 11:53:09 -0700 (PDT)
Date:   Mon, 11 Apr 2022 11:53:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ammarfaizi2-block:paulmck/linux-rcu/dev 83/131]
 kernel/rcu/tree.c:3778:13: error: implicit declaration of function
 'preempt_mode_full'; did you mean 'preempt_model_full'?
Message-ID: <20220411185309.GA4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202204120207.7OoY1hZZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204120207.7OoY1hZZ-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 02:44:09AM +0800, kernel test robot wrote:
> tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev
> head:   96d35f716a63bc46750d66a5daec804997ff7cc6
> commit: 78b49c815a11d5541a7492b483eb20ec6377cafe [83/131] rcu: Fix preemption mode check on synchronize_rcu[_expedited]()
> config: xtensa-buildonly-randconfig-r003-20220411 (https://download.01.org/0day-ci/archive/20220412/202204120207.7OoY1hZZ-lkp@intel.com/config)
> compiler: xtensa-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/ammarfaizi2/linux-block/commit/78b49c815a11d5541a7492b483eb20ec6377cafe
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev
>         git checkout 78b49c815a11d5541a7492b483eb20ec6377cafe
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> Note: the ammarfaizi2-block/paulmck/linux-rcu/dev HEAD 96d35f716a63bc46750d66a5daec804997ff7cc6 builds fine.
>       It only hurts bisectability.
> 
> All errors (new ones prefixed by >>):

According to my testing, these are fixed by this commit:

57fba3cb96e7 ("rcu: Fix preemption mode check on synchronize_rcu[_expedited]()")

Please let me know if your testing disagrees.

							Thanx, Paul

>    kernel/rcu/tree.c: In function 'rcu_blocking_is_gp':
> >> kernel/rcu/tree.c:3778:13: error: implicit declaration of function 'preempt_mode_full'; did you mean 'preempt_model_full'? [-Werror=implicit-function-declaration]
>     3778 |         if (preempt_mode_full() || preempt_mode_rt())
>          |             ^~~~~~~~~~~~~~~~~
>          |             preempt_model_full
> >> kernel/rcu/tree.c:3778:36: error: implicit declaration of function 'preempt_mode_rt'; did you mean 'preempt_model_rt'? [-Werror=implicit-function-declaration]
>     3778 |         if (preempt_mode_full() || preempt_mode_rt())
>          |                                    ^~~~~~~~~~~~~~~
>          |                                    preempt_model_rt
>    cc1: some warnings being treated as errors
> 
> 
> vim +3778 kernel/rcu/tree.c
> 
>   3761	
>   3762	/*
>   3763	 * During early boot, any blocking grace-period wait automatically
>   3764	 * implies a grace period.  Later on, this is never the case for PREEMPTION.
>   3765	 *
>   3766	 * However, because a context switch is a grace period for !PREEMPTION, any
>   3767	 * blocking grace-period wait automatically implies a grace period if
>   3768	 * there is only one CPU online at any point time during execution of
>   3769	 * either synchronize_rcu() or synchronize_rcu_expedited().  It is OK to
>   3770	 * occasionally incorrectly indicate that there are multiple CPUs online
>   3771	 * when there was in fact only one the whole time, as this just adds some
>   3772	 * overhead: RCU still operates correctly.
>   3773	 */
>   3774	static int rcu_blocking_is_gp(void)
>   3775	{
>   3776		int ret;
>   3777	
> > 3778		if (preempt_mode_full() || preempt_mode_rt())
>   3779			return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
>   3780		might_sleep();  /* Check for RCU read-side critical section. */
>   3781		preempt_disable();
>   3782		/*
>   3783		 * If the rcu_state.n_online_cpus counter is equal to one,
>   3784		 * there is only one CPU, and that CPU sees all prior accesses
>   3785		 * made by any CPU that was online at the time of its access.
>   3786		 * Furthermore, if this counter is equal to one, its value cannot
>   3787		 * change until after the preempt_enable() below.
>   3788		 *
>   3789		 * Furthermore, if rcu_state.n_online_cpus is equal to one here,
>   3790		 * all later CPUs (both this one and any that come online later
>   3791		 * on) are guaranteed to see all accesses prior to this point
>   3792		 * in the code, without the need for additional memory barriers.
>   3793		 * Those memory barriers are provided by CPU-hotplug code.
>   3794		 */
>   3795		ret = READ_ONCE(rcu_state.n_online_cpus) <= 1;
>   3796		preempt_enable();
>   3797		return ret;
>   3798	}
>   3799	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

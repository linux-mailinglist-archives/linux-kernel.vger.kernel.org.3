Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7804CB3B0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiCCAJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiCCAJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:09:03 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BBDC626B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 16:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646266098; x=1677802098;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J8Job6Jz3/6btpIzlTmfqeEkAb8Rtk7UqH8NT1zmxPQ=;
  b=oBknBo9wfIq7heZ+ElMRGOQ2vThsW0Vei+B9PwkFkBKPOVFDgZU9nPnj
   FClqvH42NdpZVLYJI3TIteIzHAzJPV1mtU9TW3ageGgwGSyXa6hflR3jB
   Ao7txueiESm6Vkwsow1MSVa10JnvQR/3OWfmEuiAejBQiyNZzxsMIEkiX
   TbpW20rm0mWEp3v46hKCZvgLBnDDPrazIPvOkDErCaLCO6kCBSgRzs+WA
   Tdx7EM3nWqyiMtL7o1P/TKz0TjTq7oMOS0V2PmBBLpjhi6UwavT0dA1ka
   IiQVvG3rINnTRzvnTathO7OhqO1AjaQ2e6+HGwnVOGJO0zygY64vyQhG5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="234141531"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="234141531"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 15:00:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="709690754"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 02 Mar 2022 15:00:58 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPXxp-00022S-U0; Wed, 02 Mar 2022 23:00:57 +0000
Date:   Thu, 3 Mar 2022 07:00:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [frederic-dynticks:rcu/context-tracking 13/19]
 kernel/context_tracking.c:91:25: error: implicit declaration of function
 'rcu_irq_work_resched'
Message-ID: <202203030631.Za0lAbtO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git rcu/context-tracking
head:   e4eaff86ec91c1cbde9a113cf5232dac9f897337
commit: 5cb63f8df32ee1a43ca46337d6c8554a27d44165 [13/19] rcu/context-tracking: Move deferred nocb resched to context tracking
config: arm-randconfig-c002-20220302 (https://download.01.org/0day-ci/archive/20220303/202203030631.Za0lAbtO-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git/commit/?id=5cb63f8df32ee1a43ca46337d6c8554a27d44165
        git remote add frederic-dynticks https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
        git fetch --no-tags frederic-dynticks rcu/context-tracking
        git checkout 5cb63f8df32ee1a43ca46337d6c8554a27d44165
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/context_tracking.c: In function '__ct_user_enter':
>> kernel/context_tracking.c:91:25: error: implicit declaration of function 'rcu_irq_work_resched' [-Werror=implicit-function-declaration]
      91 |                         rcu_irq_work_resched();
         |                         ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/rcu_irq_work_resched +91 kernel/context_tracking.c

    51	
    52	/**
    53	 * __ct_user_enter - Inform the context tracking that the CPU is going
    54	 *		     to enter user or guest space mode.
    55	 *
    56	 * This function must be called right before we switch from the kernel
    57	 * to user or guest space, when it's guaranteed the remaining kernel
    58	 * instructions to execute won't use any RCU read side critical section
    59	 * because this function sets RCU in extended quiescent state.
    60	 */
    61	void noinstr __ct_user_enter(enum ctx_state state)
    62	{
    63		lockdep_assert_irqs_disabled();
    64	
    65		/* Kernel threads aren't supposed to go to userspace */
    66		WARN_ON_ONCE(!current->mm);
    67	
    68		if (!context_tracking_recursion_enter())
    69			return;
    70	
    71		if ( __this_cpu_read(context_tracking.state) != state) {
    72			if (__this_cpu_read(context_tracking.active)) {
    73				/*
    74				 * At this stage, only low level arch entry code remains and
    75				 * then we'll run in userspace. We can assume there won't be
    76				 * any RCU read-side critical section until the next call to
    77				 * user_exit() or ct_irq_enter(). Let's remove RCU's dependency
    78				 * on the tick.
    79				 */
    80				if (state == CONTEXT_USER) {
    81					instrumentation_begin();
    82					trace_user_enter(0);
    83					vtime_user_enter(current);
    84					instrumentation_end();
    85				}
    86				/*
    87				 * Other than generic entry implementation, we may be past the last
    88				 * rescheduling opportunity in the entry code. Trigger a self IPI
    89				 * that will fire and reschedule once we resume in user/guest mode.
    90				 */
  > 91				rcu_irq_work_resched();
    92				rcu_user_enter();
    93			}
    94			/*
    95			 * Even if context tracking is disabled on this CPU, because it's outside
    96			 * the full dynticks mask for example, we still have to keep track of the
    97			 * context transitions and states to prevent inconsistency on those of
    98			 * other CPUs.
    99			 * If a task triggers an exception in userspace, sleep on the exception
   100			 * handler and then migrate to another CPU, that new CPU must know where
   101			 * the exception returns by the time we call exception_exit().
   102			 * This information can only be provided by the previous CPU when it called
   103			 * exception_enter().
   104			 * OTOH we can spare the calls to vtime and RCU when context_tracking.active
   105			 * is false because we know that CPU is not tickless.
   106			 */
   107			__this_cpu_write(context_tracking.state, state);
   108		}
   109		context_tracking_recursion_exit();
   110	}
   111	EXPORT_SYMBOL_GPL(__ct_user_enter);
   112	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

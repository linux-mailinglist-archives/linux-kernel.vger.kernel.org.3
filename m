Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1109C52545F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357438AbiELSBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357459AbiELSBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:01:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDED629C80
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652378462; x=1683914462;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DRH3fQ/9iwnvlaibsfCXMZRNs+oifcTzDl9VwxdX1mE=;
  b=gl2onnycW6oBtpWWRN0h3hEIIke/rFDVKhiO3ri7/CrARKPH/sp9lEvQ
   Cz3NP2Yv6aAe5y2FPCDlEjywkixzeoS1cT5Hh1gahNKWgw7UwGuSIUuUD
   6yBnmDNJgJPsNutsHDIdH2UHlUv3K4pW5iL0YTw5VoE6DSm6VCej0yn3R
   2GJ6a6q6nlLg0TgAURrgogxVv8vZrRV+UNeqVUkuhnjdEfbSnD+gS4tFn
   xD84Tz3c0LSG72OiI8AgvEccVp7MXHSg8yoTTiGnRJqmdWGWmGmV6XuBj
   GTYu3DyMJskV+xa2LtBm+ZSfE8NAsOkr/zyhBVcHd5fnz3t9XzH5unA2l
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="252143526"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="252143526"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:00:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="553882886"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 12 May 2022 11:00:43 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npD7D-000KmX-1j;
        Thu, 12 May 2022 18:00:43 +0000
Date:   Fri, 13 May 2022 01:59:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [frederic-dynticks:rcu/context-tracking-v2 17/21]
 kernel/context_tracking.c:91:25: error: implicit declaration of function
 'rcu_irq_work_resched'
Message-ID: <202205130127.Ew9k8Q7Q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git rcu/context-tracking-v2
head:   0364ddb8830db4d4b78f7bfd9344e12d22e9cd32
commit: 0fe61091f9b097b9f0ccc4ffe3333d7e80093392 [17/21] rcu/context-tracking: Move deferred nocb resched to context tracking
config: arm-randconfig-r006-20220512 (https://download.01.org/0day-ci/archive/20220513/202205130127.Ew9k8Q7Q-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git/commit/?id=0fe61091f9b097b9f0ccc4ffe3333d7e80093392
        git remote add frederic-dynticks https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
        git fetch --no-tags frederic-dynticks rcu/context-tracking-v2
        git checkout 0fe61091f9b097b9f0ccc4ffe3333d7e80093392
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/vtime.h:5,
                    from include/linux/context_tracking.h:6,
                    from kernel/context_tracking.c:18:
   include/linux/context_tracking_state.h: In function 'ct_dynticks_cpu_acquire':
   include/linux/context_tracking_state.h:51:36: error: passing argument 1 of 'atomic_read_acquire' from incompatible pointer type [-Werror=incompatible-pointer-types]
      51 |         return atomic_read_acquire(&ct->state);
         |                                    ^~~~~~~~~~
         |                                    |
         |                                    enum ctx_state *
   In file included from include/linux/atomic.h:82,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/context_tracking.h:5,
                    from kernel/context_tracking.c:18:
   include/linux/atomic/atomic-instrumented.h:32:37: note: expected 'const atomic_t *' but argument is of type 'enum ctx_state *'
      32 | atomic_read_acquire(const atomic_t *v)
         |                     ~~~~~~~~~~~~~~~~^
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

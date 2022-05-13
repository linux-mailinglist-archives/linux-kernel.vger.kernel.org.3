Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093B6525B17
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 07:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377123AbiEMFnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 01:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377109AbiEMFnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 01:43:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1564D1D89F0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 22:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652420583; x=1683956583;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=deAtSYXCcNXoH+m9zjoF937RMzn6ISZvaO5JMy0o/AQ=;
  b=S8pP5xWzDc7LFIvfVwJEc6cwTGFyfUf1VoNKgtEFwy3RXOZx8tkbdvtr
   aw6Y+miQ5C5gPYFtH0P5ZJX5od0P8wQOnS2vWs4uc32TJY/PxtZ3oeinW
   oqS7P124CSThPBnkNEwjai2OUzurAqSbuN6dozTw21UB/cKE1Qvv5IoG9
   HZF8lmQe6uSTzGY5c0Na9zFTaGasTLeXQn3NwTK04euChRk1dm3RElccw
   EDUFE9hyQssnOoBpizQTsol+SkehNdtOykI9rDZ6uRijZy6lXBcPTYKeg
   9EfbaBBPI1bhti4/RJ4DflQCyFG91J263uEagAXedeiWRZswpb0Z8af+h
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="270356057"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="270356057"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 22:43:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="572836594"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 12 May 2022 22:43:01 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npO4q-000LNc-Sx;
        Fri, 13 May 2022 05:43:00 +0000
Date:   Fri, 13 May 2022 13:42:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [frederic-dynticks:rcu/context-tracking-v2 17/21]
 kernel/context_tracking.c:91:4: error: call to undeclared function
 'rcu_irq_work_resched'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202205131353.DZ30D5rD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git rcu/context-tracking-v2
head:   0364ddb8830db4d4b78f7bfd9344e12d22e9cd32
commit: 0fe61091f9b097b9f0ccc4ffe3333d7e80093392 [17/21] rcu/context-tracking: Move deferred nocb resched to context tracking
config: arm-randconfig-r023-20220512 (https://download.01.org/0day-ci/archive/20220513/202205131353.DZ30D5rD-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 9519dacab7b8afd537811fc2abaceb4d14f4e16a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git/commit/?id=0fe61091f9b097b9f0ccc4ffe3333d7e80093392
        git remote add frederic-dynticks https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
        git fetch --no-tags frederic-dynticks rcu/context-tracking-v2
        git checkout 0fe61091f9b097b9f0ccc4ffe3333d7e80093392
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/context_tracking.c:18:
   In file included from include/linux/context_tracking.h:6:
   In file included from include/linux/vtime.h:5:
   include/linux/context_tracking_state.h:51:29: error: incompatible pointer types passing 'enum ctx_state *' to parameter of type 'const atomic_t *' [-Werror,-Wincompatible-pointer-types]
           return atomic_read_acquire(&ct->state);
                                      ^~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:32:37: note: passing argument to parameter 'v' here
   atomic_read_acquire(const atomic_t *v)
                                       ^
>> kernel/context_tracking.c:91:4: error: call to undeclared function 'rcu_irq_work_resched'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                           rcu_irq_work_resched();
                           ^
   2 errors generated.


vim +/rcu_irq_work_resched +91 kernel/context_tracking.c

  > 18	#include <linux/context_tracking.h>
    19	#include <linux/rcupdate.h>
    20	#include <linux/sched.h>
    21	#include <linux/hardirq.h>
    22	#include <linux/export.h>
    23	#include <linux/kprobes.h>
    24	
    25	#ifdef CONFIG_CONTEXT_TRACKING_USER
    26	
    27	#define CREATE_TRACE_POINTS
    28	#include <trace/events/context_tracking.h>
    29	
    30	DEFINE_STATIC_KEY_FALSE(context_tracking_key);
    31	EXPORT_SYMBOL_GPL(context_tracking_key);
    32	
    33	static noinstr bool context_tracking_recursion_enter(void)
    34	{
    35		int recursion;
    36	
    37		recursion = __this_cpu_inc_return(context_tracking.recursion);
    38		if (recursion == 1)
    39			return true;
    40	
    41		WARN_ONCE((recursion < 1), "Invalid context tracking recursion value %d\n", recursion);
    42		__this_cpu_dec(context_tracking.recursion);
    43	
    44		return false;
    45	}
    46	
    47	static __always_inline void context_tracking_recursion_exit(void)
    48	{
    49		__this_cpu_dec(context_tracking.recursion);
    50	}
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

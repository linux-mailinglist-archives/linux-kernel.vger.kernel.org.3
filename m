Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D6751C9BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384425AbiEEUAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241858AbiEEUAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:00:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E35E56FBD
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 12:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651780581; x=1683316581;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KwanYcUMTk/tFXkADBVfoZ8TSGBgi+TKmiWKVnS1X1U=;
  b=lbxfmLsmwT0Q6/0oEWrIx6icGd6FYeDOUuaYnQchthPVZBf+TIwO1ZbY
   achy9jYzOA12A7o2ziW3JL2Pxmr4fyDGGCsQ5acEDZ6oIATMOtSq7AHSJ
   2QivWkA0xKCY1S0AVNASi2bzER4VSZ9tDzeMkzFSNvQWCpYVqMhgJNPFn
   3Msf3llj8iOtTahSYdDqUMQupeRdFWfeHMmXZNlMjRT/jPTVkF7AbDR+A
   qrMbWbBFREf03VqFbfZtibVuT43el5hzdd8fRIaIqYoDRmzkee6KBKHhZ
   1n4KOSDF0zVUOFbiAve2cEFtTtWrhMc/M/QO7br2RsiPn2WBOFSKcRWVt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="328775386"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="328775386"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 12:56:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="517675586"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 May 2022 12:56:19 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmhaE-000Chc-P8;
        Thu, 05 May 2022 19:56:18 +0000
Date:   Fri, 6 May 2022 03:56:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [ammarfaizi2-block:paulmck/linux-rcu/context-tracking.2022.05.03a
 54/58] kernel/context_tracking.c:91:4: error: call to undeclared function
 'rcu_irq_work_resched'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202205060346.y3d1cOFv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/context-tracking.2022.05.03a
head:   9527c561aed6424e77fd2a8827c37f1103c89177
commit: cc2a2df362d428cc4c660df04d3e3403562fafb2 [54/58] rcu/context-tracking: Move deferred nocb resched to context tracking
config: riscv-randconfig-c006-20220505 (https://download.01.org/0day-ci/archive/20220506/202205060346.y3d1cOFv-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e004fb787698440a387750db7f8028e7cb14cfc)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/cc2a2df362d428cc4c660df04d3e3403562fafb2
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/context-tracking.2022.05.03a
        git checkout cc2a2df362d428cc4c660df04d3e3403562fafb2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

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
   In file included from kernel/context_tracking.c:21:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from kernel/context_tracking.c:21:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from kernel/context_tracking.c:21:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:1024:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
>> kernel/context_tracking.c:91:4: error: call to undeclared function 'rcu_irq_work_resched'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                           rcu_irq_work_resched();
                           ^
   7 warnings and 2 errors generated.


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

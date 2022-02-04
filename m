Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDC04AA464
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378196AbiBDXgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:36:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:48189 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231367AbiBDXf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644017759; x=1675553759;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M9wPMFyv7fuslXfnUJ34OScj+CJGAXieFhwUhiLYLFQ=;
  b=OQYG7S8gCWGwSSKozrDglN+iQyY4LmiUrWp5k8qlW+0Cu+ol9Gw3Jlfa
   l1n8jz/ZpSHCMoaubbHXHKEI67CZE/Ytu8/l+i6V5gl7BkOT3LswF/zZf
   GMOdt3ab2t3WkC069VUIPlNu39cdWdDDopGo9khjqkjml3UirODRHZSSD
   lBR9/ftgbbEASLOH6WDrLAbBVNwrkAi4HTT9yyMj0g7ayWV2MzfEw4ywc
   5uzpKCWUT1NE5TXIazQeEzKyxCw8MsOB2Udi0GzJp0a+kauDyFCUzMPB2
   MtwARHaya5OzEijor/2XtswXbgRq3d5eE9EXr9z9FTqSOvhDL/5cW1YHc
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="232027525"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="232027525"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 15:35:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="627925865"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 04 Feb 2022 15:35:57 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nG87Q-000YJf-NY; Fri, 04 Feb 2022 23:35:56 +0000
Date:   Sat, 5 Feb 2022 07:35:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mark:arm64/preempt-dynamic-static-key 7/7]
 kernel/rcu/rcutorture.c:408:3: error: implicit declaration of function
 'preempt_schedule'
Message-ID: <202202050711.Ze2cgnZY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/preempt-dynamic-static-key
head:   fb01536865a3af674b204f6d0fe0935264c4b434
commit: fb01536865a3af674b204f6d0fe0935264c4b434 [7/7] arm64: support PREEMPT_DYNAMIC
config: arm64-randconfig-r025-20220131 (https://download.01.org/0day-ci/archive/20220205/202202050711.Ze2cgnZY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a73e4ce6a59b01f0e37037761c1e6889d539d233)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=fb01536865a3af674b204f6d0fe0935264c4b434
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/preempt-dynamic-static-key
        git checkout fb01536865a3af674b204f6d0fe0935264c4b434
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/rcu/rcutorture.c:408:3: error: implicit declaration of function 'preempt_schedule' [-Werror,-Wimplicit-function-declaration]
                   torture_preempt_schedule();  /* QS only if preemptible. */
                   ^
   include/linux/torture.h:121:36: note: expanded from macro 'torture_preempt_schedule'
   #define torture_preempt_schedule() preempt_schedule()
                                      ^
   kernel/rcu/rcutorture.c:408:3: note: did you mean 'preempt_schedule_irq'?
   include/linux/torture.h:121:36: note: expanded from macro 'torture_preempt_schedule'
   #define torture_preempt_schedule() preempt_schedule()
                                      ^
   include/linux/sched.h:296:17: note: 'preempt_schedule_irq' declared here
   asmlinkage void preempt_schedule_irq(void);
                   ^
   kernel/rcu/rcutorture.c:2087:5: error: implicit declaration of function 'preempt_schedule' [-Werror,-Wimplicit-function-declaration]
                                   preempt_schedule();
                                   ^
   2 errors generated.


vim +/preempt_schedule +408 kernel/rcu/rcutorture.c

72e9bb549280b3 kernel/rcutorture.c     Paul E. McKenney 2006-06-27  376  
c116dba68d1924 kernel/rcu/rcutorture.c Paul E. McKenney 2018-07-13  377  static void
c116dba68d1924 kernel/rcu/rcutorture.c Paul E. McKenney 2018-07-13  378  rcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
b2896d2e75c87e kernel/rcutorture.c     Paul E. McKenney 2006-10-04  379  {
d0af39e89ec59f kernel/rcu/rcutorture.c Paul E. McKenney 2016-10-10  380  	unsigned long started;
d0af39e89ec59f kernel/rcu/rcutorture.c Paul E. McKenney 2016-10-10  381  	unsigned long completed;
b8d57a76d9f92a kernel/rcutorture.c     Josh Triplett    2009-09-08  382  	const unsigned long shortdelay_us = 200;
1e69676592edaf kernel/rcu/rcutorture.c Paul E. McKenney 2018-07-20  383  	unsigned long longdelay_ms = 300;
d0af39e89ec59f kernel/rcu/rcutorture.c Paul E. McKenney 2016-10-10  384  	unsigned long long ts;
b2896d2e75c87e kernel/rcutorture.c     Paul E. McKenney 2006-10-04  385  
b8d57a76d9f92a kernel/rcutorture.c     Josh Triplett    2009-09-08  386  	/* We want a short delay sometimes to make a reader delay the grace
b8d57a76d9f92a kernel/rcutorture.c     Josh Triplett    2009-09-08  387  	 * period, and we want a long delay occasionally to trigger
b8d57a76d9f92a kernel/rcutorture.c     Josh Triplett    2009-09-08  388  	 * force_quiescent_state. */
b2896d2e75c87e kernel/rcutorture.c     Paul E. McKenney 2006-10-04  389  
102c14d2f87976 kernel/rcu/rcutorture.c Paul E. McKenney 2019-12-21  390  	if (!READ_ONCE(rcu_fwd_cb_nodelay) &&
4871848531af1d kernel/rcu/rcutorture.c Paul E. McKenney 2018-08-15  391  	    !(torture_random(rrsp) % (nrealreaders * 2000 * longdelay_ms))) {
17ef2fe97c8c8e kernel/rcu/rcutorture.c Paul E. McKenney 2018-04-27  392  		started = cur_ops->get_gp_seq();
d0af39e89ec59f kernel/rcu/rcutorture.c Paul E. McKenney 2016-10-10  393  		ts = rcu_trace_clock_local();
1e69676592edaf kernel/rcu/rcutorture.c Paul E. McKenney 2018-07-20  394  		if (preempt_count() & (SOFTIRQ_MASK | HARDIRQ_MASK))
1e69676592edaf kernel/rcu/rcutorture.c Paul E. McKenney 2018-07-20  395  			longdelay_ms = 5; /* Avoid triggering BH limits. */
b8d57a76d9f92a kernel/rcutorture.c     Josh Triplett    2009-09-08  396  		mdelay(longdelay_ms);
c116dba68d1924 kernel/rcu/rcutorture.c Paul E. McKenney 2018-07-13  397  		rtrsp->rt_delay_ms = longdelay_ms;
17ef2fe97c8c8e kernel/rcu/rcutorture.c Paul E. McKenney 2018-04-27  398  		completed = cur_ops->get_gp_seq();
d0af39e89ec59f kernel/rcu/rcutorture.c Paul E. McKenney 2016-10-10  399  		do_trace_rcu_torture_read(cur_ops->name, NULL, ts,
d0af39e89ec59f kernel/rcu/rcutorture.c Paul E. McKenney 2016-10-10  400  					  started, completed);
d0af39e89ec59f kernel/rcu/rcutorture.c Paul E. McKenney 2016-10-10  401  	}
c116dba68d1924 kernel/rcu/rcutorture.c Paul E. McKenney 2018-07-13  402  	if (!(torture_random(rrsp) % (nrealreaders * 2 * shortdelay_us))) {
b8d57a76d9f92a kernel/rcutorture.c     Josh Triplett    2009-09-08  403  		udelay(shortdelay_us);
c116dba68d1924 kernel/rcu/rcutorture.c Paul E. McKenney 2018-07-13  404  		rtrsp->rt_delay_us = shortdelay_us;
c116dba68d1924 kernel/rcu/rcutorture.c Paul E. McKenney 2018-07-13  405  	}
51b1130eb5823d kernel/rcu/rcutorture.c Paul E. McKenney 2014-01-27  406  	if (!preempt_count() &&
c116dba68d1924 kernel/rcu/rcutorture.c Paul E. McKenney 2018-07-13  407  	    !(torture_random(rrsp) % (nrealreaders * 500))) {
cc1321c96f8555 kernel/rcu/rcutorture.c Paul E. McKenney 2017-10-16 @408  		torture_preempt_schedule();  /* QS only if preemptible. */
c116dba68d1924 kernel/rcu/rcutorture.c Paul E. McKenney 2018-07-13  409  		rtrsp->rt_preempted = true;
c116dba68d1924 kernel/rcu/rcutorture.c Paul E. McKenney 2018-07-13  410  	}
b2896d2e75c87e kernel/rcutorture.c     Paul E. McKenney 2006-10-04  411  }
b2896d2e75c87e kernel/rcutorture.c     Paul E. McKenney 2006-10-04  412  

:::::: The code at line 408 was first introduced by commit
:::::: cc1321c96f855525fbd847fec130f000daa1bb1f torture: Reduce #ifdefs for preempt_schedule()

:::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
:::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

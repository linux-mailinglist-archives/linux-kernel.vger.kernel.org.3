Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FC64AA749
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 08:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376414AbiBEHNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 02:13:19 -0500
Received: from mga03.intel.com ([134.134.136.65]:8807 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229835AbiBEHNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 02:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644045198; x=1675581198;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kDIp3wm96nE80qVSlRCyB/EwmxrIMayFs4fbOk2vZsM=;
  b=aDczl3SbQQCXzDGLfQuFXPYpXKk+i72IaW2MlvfVaaYQGoRepmG23o1j
   EjULm+577TTo5ENjMd2YLAu9L0XU7Bam647Yswk0bU+nBkhYy+tY2Lnoh
   M89knfZx3HFo/t7jwFWDUi63bsuA2zFMcUdj0AJ1g5Ap6QJmwfrhk22c7
   aOlxxAjp8JfyBiaFB1U3hXlhZTtvbig5JcYSVI0GCsDscakn2E4DiDwPs
   i90TjOVc5MUtZzjsm8CDV82cVZxsBDm8XaMW2+QsG9OsCRvbHMfZ4NoqV
   hy1KbZVDrezgc2susTJjfqr9ZQ3ck6hse9bgo8Tg1T6DFGnMOAXEjdj24
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="248442980"
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="248442980"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 23:13:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="524556815"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 04 Feb 2022 23:13:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGFFz-000YkK-T3; Sat, 05 Feb 2022 07:13:15 +0000
Date:   Sat, 5 Feb 2022 15:13:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mark:arm64/preempt-dynamic-static-key 7/7]
 kernel/locking/locktorture.c:122:3: error: implicit declaration of function
 'preempt_schedule'
Message-ID: <202202051545.EqPMbpRh-lkp@intel.com>
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
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220205/202202051545.EqPMbpRh-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/panel/ kernel/locking/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/locking/locktorture.c:122:3: error: implicit declaration of function 'preempt_schedule' [-Werror,-Wimplicit-function-declaration]
                   torture_preempt_schedule();  /* Allow test to be preempted. */
                   ^
   include/linux/torture.h:121:36: note: expanded from macro 'torture_preempt_schedule'
   #define torture_preempt_schedule() preempt_schedule()
                                      ^
   kernel/locking/locktorture.c:122:3: note: did you mean 'preempt_schedule_irq'?
   include/linux/torture.h:121:36: note: expanded from macro 'torture_preempt_schedule'
   #define torture_preempt_schedule() preempt_schedule()
                                      ^
   include/linux/sched.h:296:17: note: 'preempt_schedule_irq' declared here
   asmlinkage void preempt_schedule_irq(void);
                   ^
   kernel/locking/locktorture.c:170:3: error: implicit declaration of function 'preempt_schedule' [-Werror,-Wimplicit-function-declaration]
                   torture_preempt_schedule();  /* Allow test to be preempted. */
                   ^
   include/linux/torture.h:121:36: note: expanded from macro 'torture_preempt_schedule'
   #define torture_preempt_schedule() preempt_schedule()
                                      ^
   kernel/locking/locktorture.c:349:3: error: implicit declaration of function 'preempt_schedule' [-Werror,-Wimplicit-function-declaration]
                   torture_preempt_schedule();  /* Allow test to be preempted. */
                   ^
   include/linux/torture.h:121:36: note: expanded from macro 'torture_preempt_schedule'
   #define torture_preempt_schedule() preempt_schedule()
                                      ^
   kernel/locking/locktorture.c:524:3: error: implicit declaration of function 'preempt_schedule' [-Werror,-Wimplicit-function-declaration]
                   torture_preempt_schedule();  /* Allow test to be preempted. */
                   ^
   include/linux/torture.h:121:36: note: expanded from macro 'torture_preempt_schedule'
   #define torture_preempt_schedule() preempt_schedule()
                                      ^
   kernel/locking/locktorture.c:564:3: error: implicit declaration of function 'preempt_schedule' [-Werror,-Wimplicit-function-declaration]
                   torture_preempt_schedule();  /* Allow test to be preempted. */
                   ^
   include/linux/torture.h:121:36: note: expanded from macro 'torture_preempt_schedule'
   #define torture_preempt_schedule() preempt_schedule()
                                      ^
   kernel/locking/locktorture.c:591:3: error: implicit declaration of function 'preempt_schedule' [-Werror,-Wimplicit-function-declaration]
                   torture_preempt_schedule();  /* Allow test to be preempted. */
                   ^
   include/linux/torture.h:121:36: note: expanded from macro 'torture_preempt_schedule'
   #define torture_preempt_schedule() preempt_schedule()
                                      ^
   6 errors generated.


vim +/preempt_schedule +122 kernel/locking/locktorture.c

e086481baf9d04 Paul E. McKenney 2014-02-11  112  
e086481baf9d04 Paul E. McKenney 2014-02-11  113  static void torture_lock_busted_write_delay(struct torture_random_state *trsp)
e086481baf9d04 Paul E. McKenney 2014-02-11  114  {
61d49d2f9888ac Paul E. McKenney 2015-04-01  115  	const unsigned long longdelay_ms = 100;
e086481baf9d04 Paul E. McKenney 2014-02-11  116  
e086481baf9d04 Paul E. McKenney 2014-02-11  117  	/* We want a long delay occasionally to force massive contention.  */
e086481baf9d04 Paul E. McKenney 2014-02-11  118  	if (!(torture_random(trsp) %
61d49d2f9888ac Paul E. McKenney 2015-04-01  119  	      (cxt.nrealwriters_stress * 2000 * longdelay_ms)))
61d49d2f9888ac Paul E. McKenney 2015-04-01  120  		mdelay(longdelay_ms);
630952c22b04ad Davidlohr Bueso  2014-09-11  121  	if (!(torture_random(trsp) % (cxt.nrealwriters_stress * 20000)))
cc1321c96f8555 Paul E. McKenney 2017-10-16 @122  		torture_preempt_schedule();  /* Allow test to be preempted. */
e086481baf9d04 Paul E. McKenney 2014-02-11  123  }
e086481baf9d04 Paul E. McKenney 2014-02-11  124  

:::::: The code at line 122 was first introduced by commit
:::::: cc1321c96f855525fbd847fec130f000daa1bb1f torture: Reduce #ifdefs for preempt_schedule()

:::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
:::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

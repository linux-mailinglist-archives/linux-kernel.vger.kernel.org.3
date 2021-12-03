Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0276C4680B7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354258AbhLCXnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:43:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:24276 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354148AbhLCXnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:43:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="237015463"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="237015463"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 15:40:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="603757862"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 03 Dec 2021 15:40:26 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtIAD-000ICp-Co; Fri, 03 Dec 2021 23:40:25 +0000
Date:   Sat, 4 Dec 2021 07:39:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mark:arm64/preempt-dynamic-static-key 6/6]
 kernel/locking/locktorture.c:122:3: error: implicit declaration of function
 'preempt_schedule'
Message-ID: <202112040752.yaWl1AdY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/preempt-dynamic-static-key
head:   d8d8c0b10c8545aedf353b146905a1e61e3176f5
commit: d8d8c0b10c8545aedf353b146905a1e61e3176f5 [6/6] arm64: support PREEMPT_DYNAMIC
config: arm64-randconfig-r015-20211203 (https://download.01.org/0day-ci/archive/20211204/202112040752.yaWl1AdY-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d30fcadf07ee552f20156ea90be2fdb54cb9cb08)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=d8d8c0b10c8545aedf353b146905a1e61e3176f5
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/preempt-dynamic-static-key
        git checkout d8d8c0b10c8545aedf353b146905a1e61e3176f5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash kernel/locking/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/locking/locktorture.c:122:3: error: implicit declaration of function 'preempt_schedule' [-Werror,-Wimplicit-function-declaration]
                   torture_preempt_schedule();  /* Allow test to be preempted. */
                   ^
   include/linux/torture.h:126:36: note: expanded from macro 'torture_preempt_schedule'
   #define torture_preempt_schedule() preempt_schedule()
                                      ^
   kernel/locking/locktorture.c:122:3: note: did you mean 'preempt_schedule_irq'?
   include/linux/torture.h:126:36: note: expanded from macro 'torture_preempt_schedule'
   #define torture_preempt_schedule() preempt_schedule()
                                      ^
   include/linux/sched.h:291:17: note: 'preempt_schedule_irq' declared here
   asmlinkage void preempt_schedule_irq(void);
                   ^
   kernel/locking/locktorture.c:170:3: error: implicit declaration of function 'preempt_schedule' [-Werror,-Wimplicit-function-declaration]
                   torture_preempt_schedule();  /* Allow test to be preempted. */
                   ^
   include/linux/torture.h:126:36: note: expanded from macro 'torture_preempt_schedule'
   #define torture_preempt_schedule() preempt_schedule()
                                      ^
   kernel/locking/locktorture.c:349:3: error: implicit declaration of function 'preempt_schedule' [-Werror,-Wimplicit-function-declaration]
                   torture_preempt_schedule();  /* Allow test to be preempted. */
                   ^
   include/linux/torture.h:126:36: note: expanded from macro 'torture_preempt_schedule'
   #define torture_preempt_schedule() preempt_schedule()
                                      ^
   kernel/locking/locktorture.c:524:3: error: implicit declaration of function 'preempt_schedule' [-Werror,-Wimplicit-function-declaration]
                   torture_preempt_schedule();  /* Allow test to be preempted. */
                   ^
   include/linux/torture.h:126:36: note: expanded from macro 'torture_preempt_schedule'
   #define torture_preempt_schedule() preempt_schedule()
                                      ^
   kernel/locking/locktorture.c:564:3: error: implicit declaration of function 'preempt_schedule' [-Werror,-Wimplicit-function-declaration]
                   torture_preempt_schedule();  /* Allow test to be preempted. */
                   ^
   include/linux/torture.h:126:36: note: expanded from macro 'torture_preempt_schedule'
   #define torture_preempt_schedule() preempt_schedule()
                                      ^
   kernel/locking/locktorture.c:591:3: error: implicit declaration of function 'preempt_schedule' [-Werror,-Wimplicit-function-declaration]
                   torture_preempt_schedule();  /* Allow test to be preempted. */
                   ^
   include/linux/torture.h:126:36: note: expanded from macro 'torture_preempt_schedule'
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAA650985E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385254AbiDUGwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385223AbiDUGvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:51:42 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B44B18B1A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523573; x=1682059573;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=awOFkgJe1AEZQFzltpN+IGCAwDyxgcT7fZSQ2W+9jBo=;
  b=V9mDmPtQ30PDn8j8pun8kownFj75WPit1M8fLTcuHa5ca6DxkC+QdnU9
   XA/vB2N6fVxCbHmoyJ1OaaDfgKjoferB9ry5Iwqcqp+emZHLDQom98Lkl
   JoFnicVvKGRzko6XHGl9kl78bDoQjlj4b6zIsr1LK+NdYNpRijl5RwO8L
   dWy/LLKXVsIfZEmx9P2WDpY1qrVV9lFtQbuI9yVroRKSuET8HlnKjpy2f
   8blhfCiHTEz4MDsoi9xqoXE/fO6ZafkkBy/q45nn3mX2tOoQbedSYp7UN
   SBFulKGtbVz1r/bqzk2jAlZC1ZWa1e3kCoU5hUM8CtoNZtgUjlSYN0vVa
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="244839097"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="244839097"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:45:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="593513510"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Apr 2022 23:45:52 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQZb-00082r-SQ;
        Thu, 21 Apr 2022 06:45:51 +0000
Date:   Thu, 21 Apr 2022 14:45:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: kernel/sched/sched.h:2664:9: error: implicit declaration of function
 'rq_clock_clear_update'; did you mean 'rq_clock_skip_update'?
Message-ID: <202204211205.jmkEQtvQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220421-031406/Hao-Jia/sched-core-Avoid-obvious-double-update_rq_clock-warning/20220418-171117
head:   9b7d107f881024e9bdcc15a1da7f8a89cd04e14e
commit: 9b7d107f881024e9bdcc15a1da7f8a89cd04e14e sched/core: Avoid obvious double update_rq_clock warning
date:   10 hours ago
config: openrisc-randconfig-r011-20220420 (https://download.01.org/0day-ci/archive/20220421/202204211205.jmkEQtvQ-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9b7d107f881024e9bdcc15a1da7f8a89cd04e14e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220421-031406/Hao-Jia/sched-core-Avoid-obvious-double-update_rq_clock-warning/20220418-171117
        git checkout 9b7d107f881024e9bdcc15a1da7f8a89cd04e14e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/sched/core.c:81:
   kernel/sched/sched.h: In function 'double_rq_lock':
>> kernel/sched/sched.h:2664:9: error: implicit declaration of function 'rq_clock_clear_update'; did you mean 'rq_clock_skip_update'? [-Werror=implicit-function-declaration]
    2664 |         rq_clock_clear_update(rq1, rq2);
         |         ^~~~~~~~~~~~~~~~~~~~~
         |         rq_clock_skip_update
   kernel/sched/core.c: At top level:
   kernel/sched/core.c:5235:20: warning: no previous prototype for 'task_sched_runtime' [-Wmissing-prototypes]
    5235 | unsigned long long task_sched_runtime(struct task_struct *p)
         |                    ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:9432:13: warning: no previous prototype for 'sched_init_smp' [-Wmissing-prototypes]
    9432 | void __init sched_init_smp(void)
         |             ^~~~~~~~~~~~~~
   kernel/sched/core.c:9460:13: warning: no previous prototype for 'sched_init' [-Wmissing-prototypes]
    9460 | void __init sched_init(void)
         |             ^~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from kernel/sched/fair.c:53:
   kernel/sched/sched.h: In function 'double_rq_lock':
>> kernel/sched/sched.h:2664:9: error: implicit declaration of function 'rq_clock_clear_update'; did you mean 'rq_clock_skip_update'? [-Werror=implicit-function-declaration]
    2664 |         rq_clock_clear_update(rq1, rq2);
         |         ^~~~~~~~~~~~~~~~~~~~~
         |         rq_clock_skip_update
   cc1: some warnings being treated as errors
--
   In file included from kernel/sched/build_policy.c:33:
   kernel/sched/sched.h: In function 'double_rq_lock':
>> kernel/sched/sched.h:2664:9: error: implicit declaration of function 'rq_clock_clear_update'; did you mean 'rq_clock_skip_update'? [-Werror=implicit-function-declaration]
    2664 |         rq_clock_clear_update(rq1, rq2);
         |         ^~~~~~~~~~~~~~~~~~~~~
         |         rq_clock_skip_update
   In file included from kernel/sched/build_policy.c:43:
   kernel/sched/rt.c: At top level:
   kernel/sched/rt.c:666:6: warning: no previous prototype for 'sched_rt_bandwidth_account' [-Wmissing-prototypes]
     666 | bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +2664 kernel/sched/sched.h

  2649	
  2650	/*
  2651	 * double_rq_lock - safely lock two runqueues
  2652	 *
  2653	 * Note this does not disable interrupts like task_rq_lock,
  2654	 * you need to do so manually before calling.
  2655	 */
  2656	static inline void double_rq_lock(struct rq *rq1, struct rq *rq2)
  2657		__acquires(rq1->lock)
  2658		__acquires(rq2->lock)
  2659	{
  2660		BUG_ON(!irqs_disabled());
  2661		BUG_ON(rq1 != rq2);
  2662		raw_spin_rq_lock(rq1);
  2663		__acquire(rq2->lock);	/* Fake it out ;) */
> 2664		rq_clock_clear_update(rq1, rq2);
  2665	}
  2666	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

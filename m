Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7A349D59E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 23:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiAZWr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 17:47:28 -0500
Received: from mga09.intel.com ([134.134.136.24]:27941 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229672AbiAZWrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643237245; x=1674773245;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eowpr9egM0K6i5/T3Bb5j1R2wkVLkpVyJ/OXXMM2LeU=;
  b=kiItJkIz+do4fS9MP9CPprajpo5R01+E2XqAlPfBCL7Dvn3/1CV5enkb
   P8vNLDouchuNQU0U0O33Pmdq+Xs3egczlSjOWlJrXwvfSIQjgIs4kh0DO
   DMOoZ6slSfKK23485BeRnRy4xsQW/DApFMUKYjriVdrRk4a6O/bnkbK2z
   h/JZlb4GqB8+uqXblHn714remzbM3bUe3xfGQ11CzOBhdFsOYhJ89Gjpp
   P8q6tSLGEEBCYsoDOTxUgMm/h/4N3BEkp3KjattuGIizCaawuEMYMxf8m
   4wXuPgYn9xhDPqyRp8Ef27w/rRTZVCZ/O0GtEw7xVLi9W+NDGmQL+2mjN
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="246450617"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="246450617"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 14:47:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="628459407"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Jan 2022 14:47:23 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCr4U-000Lje-KE; Wed, 26 Jan 2022 22:47:22 +0000
Date:   Thu, 27 Jan 2022 06:47:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:sched/core 5/8] kernel/sched/sched.h:3006:25: warning:
 incompatible pointer to integer conversion passing 'struct rq *' to
 parameter of type 'int'
Message-ID: <202201270632.OV8jDPXB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
head:   dbaafd0f1651b35e07c20e33f8c3f133fc65705e
commit: 6dd3d475cf576edd705885c66b6f1d638a6818f4 [5/8] sched/sugov: Ignore 'busy' filter when rq is capped by uclamp_max
config: x86_64-randconfig-a003 (https://download.01.org/0day-ci/archive/20220127/202201270632.OV8jDPXB-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2a1b7aa016c0f4b5598806205bdfbab1ea2d92c4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=6dd3d475cf576edd705885c66b6f1d638a6818f4
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/core
        git checkout 6dd3d475cf576edd705885c66b6f1d638a6818f4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/core.c:13:
>> kernel/sched/sched.h:3006:25: warning: incompatible pointer to integer conversion passing 'struct rq *' to parameter of type 'int' [-Wint-conversion]
           rq_util = cpu_util_cfs(rq) + cpu_util_rt(rq);
                                  ^~
   kernel/sched/sched.h:2919:46: note: passing argument to parameter 'cpu' here
   static inline unsigned long cpu_util_cfs(int cpu)
                                                ^
   kernel/sched/core.c:3454:6: warning: no previous prototype for function 'sched_set_stop_task' [-Wmissing-prototypes]
   void sched_set_stop_task(int cpu, struct task_struct *stop)
        ^
   kernel/sched/core.c:3454:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void sched_set_stop_task(int cpu, struct task_struct *stop)
   ^
   static 
   kernel/sched/core.c:1672:1: warning: unused function 'uclamp_update_active' [-Wunused-function]
   uclamp_update_active(struct task_struct *p)
   ^
   3 warnings generated.
--
   In file included from kernel/sched/loadavg.c:9:
>> kernel/sched/sched.h:3006:25: warning: incompatible pointer to integer conversion passing 'struct rq *' to parameter of type 'int' [-Wint-conversion]
           rq_util = cpu_util_cfs(rq) + cpu_util_rt(rq);
                                  ^~
   kernel/sched/sched.h:2919:46: note: passing argument to parameter 'cpu' here
   static inline unsigned long cpu_util_cfs(int cpu)
                                                ^
   1 warning generated.
--
   In file included from kernel/sched/fair.c:23:
>> kernel/sched/sched.h:3006:25: warning: incompatible pointer to integer conversion passing 'struct rq *' to parameter of type 'int' [-Wint-conversion]
           rq_util = cpu_util_cfs(rq) + cpu_util_rt(rq);
                                  ^~
   kernel/sched/sched.h:2919:46: note: passing argument to parameter 'cpu' here
   static inline unsigned long cpu_util_cfs(int cpu)
                                                ^
   kernel/sched/fair.c:8405:19: warning: unused function 'check_misfit_status' [-Wunused-function]
   static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
                     ^
   2 warnings generated.
--
   In file included from kernel/sched/rt.c:6:
>> kernel/sched/sched.h:3006:25: warning: incompatible pointer to integer conversion passing 'struct rq *' to parameter of type 'int' [-Wint-conversion]
           rq_util = cpu_util_cfs(rq) + cpu_util_rt(rq);
                                  ^~
   kernel/sched/sched.h:2919:46: note: passing argument to parameter 'cpu' here
   static inline unsigned long cpu_util_cfs(int cpu)
                                                ^
   kernel/sched/rt.c:680:6: warning: no previous prototype for function 'sched_rt_bandwidth_account' [-Wmissing-prototypes]
   bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
        ^
   kernel/sched/rt.c:680:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
   ^
   static 
   2 warnings generated.


vim +3006 kernel/sched/sched.h

  2996	
  2997	/* Is the rq being capped/throttled by uclamp_max? */
  2998	static inline bool uclamp_rq_is_capped(struct rq *rq)
  2999	{
  3000		unsigned long rq_util;
  3001		unsigned long max_util;
  3002	
  3003		if (!static_branch_likely(&sched_uclamp_used))
  3004			return false;
  3005	
> 3006		rq_util = cpu_util_cfs(rq) + cpu_util_rt(rq);
  3007		max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
  3008	
  3009		return max_util != SCHED_CAPACITY_SCALE && rq_util >= max_util;
  3010	}
  3011	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

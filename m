Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DE549D2D7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244564AbiAZTyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:54:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:51623 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234640AbiAZTyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643226857; x=1674762857;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4UGc3CeO/OspTG3NRY/RBwL+r4c3O6Xlmt3tmC0uRWE=;
  b=QPP5qX4XeSDsvCaMEO3LhYxpVPoPw/hfCocRoIxPze8GGMqZ3BjusLvX
   nZ2wIaE9fsqYYZ3sZiD0XuvTiznSOcsDvOTSIvY4R2J4+QzmV8yL8X/1e
   cxJFuwaxmysOBsK3tSZvrsEd87kneBIQBSKgMT/f3LzpjD+Rq6T3DUjMd
   kizMOj0LgNT+MA3pkHlzSVVYfO0LIeUEq4PuFsDWmTLnzWblqX/lzXf+F
   d0M8EL209O0wkpRrO7B6h/T2eUHTgFwuDD+b+O3yg1SzEqedsE8nh6hqE
   jsTs7g8ivrJWRcCqprSb/l4b/mIwhKFqTd/u+gtYLPEtKkFVqZw1q6PVe
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226614564"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="226614564"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 11:54:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="477588538"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Jan 2022 11:54:15 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCoMw-000Lao-PP; Wed, 26 Jan 2022 19:54:14 +0000
Date:   Thu, 27 Jan 2022 03:53:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:sched/core 5/8] kernel/sched/sched.h:3006:32: warning:
 passing argument 1 of 'cpu_util_cfs' makes integer from pointer without a
 cast
Message-ID: <202201270319.tmnG6ICK-lkp@intel.com>
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
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220127/202201270319.tmnG6ICK-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=6dd3d475cf576edd705885c66b6f1d638a6818f4
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/core
        git checkout 6dd3d475cf576edd705885c66b6f1d638a6818f4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/core.c:13:
   kernel/sched/sched.h: In function 'uclamp_rq_is_capped':
>> kernel/sched/sched.h:3006:32: warning: passing argument 1 of 'cpu_util_cfs' makes integer from pointer without a cast [-Wint-conversion]
    3006 |         rq_util = cpu_util_cfs(rq) + cpu_util_rt(rq);
         |                                ^~
         |                                |
         |                                struct rq *
   kernel/sched/sched.h:2919:46: note: expected 'int' but argument is of type 'struct rq *'
    2919 | static inline unsigned long cpu_util_cfs(int cpu)
         |                                          ~~~~^~~
   kernel/sched/core.c: At top level:
   kernel/sched/core.c:3454:6: warning: no previous prototype for 'sched_set_stop_task' [-Wmissing-prototypes]
    3454 | void sched_set_stop_task(int cpu, struct task_struct *stop)
         |      ^~~~~~~~~~~~~~~~~~~
--
   In file included from kernel/sched/loadavg.c:9:
   kernel/sched/sched.h: In function 'uclamp_rq_is_capped':
>> kernel/sched/sched.h:3006:32: warning: passing argument 1 of 'cpu_util_cfs' makes integer from pointer without a cast [-Wint-conversion]
    3006 |         rq_util = cpu_util_cfs(rq) + cpu_util_rt(rq);
         |                                ^~
         |                                |
         |                                struct rq *
   kernel/sched/sched.h:2919:46: note: expected 'int' but argument is of type 'struct rq *'
    2919 | static inline unsigned long cpu_util_cfs(int cpu)
         |                                          ~~~~^~~
--
   In file included from kernel/sched/fair.c:23:
   kernel/sched/sched.h: In function 'uclamp_rq_is_capped':
>> kernel/sched/sched.h:3006:32: warning: passing argument 1 of 'cpu_util_cfs' makes integer from pointer without a cast [-Wint-conversion]
    3006 |         rq_util = cpu_util_cfs(rq) + cpu_util_rt(rq);
         |                                ^~
         |                                |
         |                                struct rq *
   kernel/sched/sched.h:2919:46: note: expected 'int' but argument is of type 'struct rq *'
    2919 | static inline unsigned long cpu_util_cfs(int cpu)
         |                                          ~~~~^~~
   kernel/sched/fair.c: At top level:
   kernel/sched/fair.c:11049:6: warning: no previous prototype for 'task_vruntime_update' [-Wmissing-prototypes]
   11049 | void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi)
         |      ^~~~~~~~~~~~~~~~~~~~
--
   In file included from kernel/sched/rt.c:6:
   kernel/sched/sched.h: In function 'uclamp_rq_is_capped':
>> kernel/sched/sched.h:3006:32: warning: passing argument 1 of 'cpu_util_cfs' makes integer from pointer without a cast [-Wint-conversion]
    3006 |         rq_util = cpu_util_cfs(rq) + cpu_util_rt(rq);
         |                                ^~
         |                                |
         |                                struct rq *
   kernel/sched/sched.h:2919:46: note: expected 'int' but argument is of type 'struct rq *'
    2919 | static inline unsigned long cpu_util_cfs(int cpu)
         |                                          ~~~~^~~
   kernel/sched/rt.c: At top level:
   kernel/sched/rt.c:680:6: warning: no previous prototype for 'sched_rt_bandwidth_account' [-Wmissing-prototypes]
     680 | bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/cpu_util_cfs +3006 kernel/sched/sched.h

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

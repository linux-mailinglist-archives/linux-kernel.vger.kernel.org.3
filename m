Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE834EBAD3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243348AbiC3Geg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243314AbiC3Ge3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:34:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EA356748
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648621964; x=1680157964;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ehRZXhIQ6P74JT5H+hAEA9YioHh54bmsy2IPvhhNd2Y=;
  b=HvohF3hmfdTzWrl2ESn5BfgiQPxatHlydogj4CF41xyEsffb2nb5ywGy
   yzVjfvmujgzA71UwIagIGQT1qqL3JrR/H42O+klwlVLhftbpA+G3Km6NA
   kjegTz6O4KTdrSrqzlXXkjhIDsjf/8a0mhOWL+sgT7KeULiDXaSPMuGbB
   WumgEe2R9S91pmQ2yZfzUluQhjLmxKF1sIZgAPbXB82GAjZifPrgiybUn
   k7UEX+cUaLJOhKSyWK21VKGy1KNrvExLB4Vd0nYrlj2IsQxJMHftifSTU
   04k58huGnYSI8/sCBzM9yv+in7BMJxjwKBuh/UuWV25nZgb55eYTOyFMv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="322639891"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="322639891"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 23:32:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="653630659"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Mar 2022 23:32:42 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZRsn-00013a-R0; Wed, 30 Mar 2022 06:32:41 +0000
Date:   Wed, 30 Mar 2022 14:32:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baisong Zhong <zhongbaisong@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [mcgrof:sysctl-next 6/18] kernel/sched/core.c:10164: undefined
 reference to `sched_rt_can_attach'
Message-ID: <202203301416.W3kVLYCm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git sysctl-next
head:   84053cc7ef2f2f86caeea6a8c0944b2f0b3f33ca
commit: d82a599294a1c50168a2177d49fe0a9a791275c3 [6/18] sched/rt: fix build error when CONFIG_SYSCTL is disable
config: ia64-randconfig-r021-20220327 (https://download.01.org/0day-ci/archive/20220330/202203301416.W3kVLYCm-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?id=d82a599294a1c50168a2177d49fe0a9a791275c3
        git remote add mcgrof https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
        git fetch --no-tags mcgrof sysctl-next
        git checkout d82a599294a1c50168a2177d49fe0a9a791275c3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ia64-linux-ld: kernel/sched/core.o: in function `cpu_cgroup_can_attach':
>> kernel/sched/core.c:10164: undefined reference to `sched_rt_can_attach'


vim +10164 kernel/sched/core.c

eeb61e53ea19be kernel/sched/core.c Kirill Tkhai       2014-10-27  10155  
1f7dd3e5a6e4f0 kernel/sched/core.c Tejun Heo          2015-12-03  10156  static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
68318b8e0b61f9 kernel/sched.c      Srivatsa Vaddagiri 2007-10-18  10157  {
bb9d97b6dffa10 kernel/sched.c      Tejun Heo          2011-12-12  10158  	struct task_struct *task;
1f7dd3e5a6e4f0 kernel/sched/core.c Tejun Heo          2015-12-03  10159  	struct cgroup_subsys_state *css;
7dc603c9028ea5 kernel/sched/core.c Peter Zijlstra     2016-06-16  10160  	int ret = 0;
bb9d97b6dffa10 kernel/sched.c      Tejun Heo          2011-12-12  10161  
1f7dd3e5a6e4f0 kernel/sched/core.c Tejun Heo          2015-12-03  10162  	cgroup_taskset_for_each(task, css, tset) {
b68aa2300cabeb kernel/sched.c      Peter Zijlstra     2008-02-13  10163  #ifdef CONFIG_RT_GROUP_SCHED
eb95419b023aba kernel/sched/core.c Tejun Heo          2013-08-08 @10164  		if (!sched_rt_can_attach(css_tg(css), task))
b68aa2300cabeb kernel/sched.c      Peter Zijlstra     2008-02-13  10165  			return -EINVAL;
b68aa2300cabeb kernel/sched.c      Peter Zijlstra     2008-02-13  10166  #endif
7dc603c9028ea5 kernel/sched/core.c Peter Zijlstra     2016-06-16  10167  		/*
b19a888c1e9bdf kernel/sched/core.c Tal Zussman        2020-11-12  10168  		 * Serialize against wake_up_new_task() such that if it's
7dc603c9028ea5 kernel/sched/core.c Peter Zijlstra     2016-06-16  10169  		 * running, we're sure to observe its full state.
7dc603c9028ea5 kernel/sched/core.c Peter Zijlstra     2016-06-16  10170  		 */
7dc603c9028ea5 kernel/sched/core.c Peter Zijlstra     2016-06-16  10171  		raw_spin_lock_irq(&task->pi_lock);
7dc603c9028ea5 kernel/sched/core.c Peter Zijlstra     2016-06-16  10172  		/*
7dc603c9028ea5 kernel/sched/core.c Peter Zijlstra     2016-06-16  10173  		 * Avoid calling sched_move_task() before wake_up_new_task()
7dc603c9028ea5 kernel/sched/core.c Peter Zijlstra     2016-06-16  10174  		 * has happened. This would lead to problems with PELT, due to
7dc603c9028ea5 kernel/sched/core.c Peter Zijlstra     2016-06-16  10175  		 * move wanting to detach+attach while we're not attached yet.
7dc603c9028ea5 kernel/sched/core.c Peter Zijlstra     2016-06-16  10176  		 */
2f064a59a11ff9 kernel/sched/core.c Peter Zijlstra     2021-06-11  10177  		if (READ_ONCE(task->__state) == TASK_NEW)
7dc603c9028ea5 kernel/sched/core.c Peter Zijlstra     2016-06-16  10178  			ret = -EINVAL;
7dc603c9028ea5 kernel/sched/core.c Peter Zijlstra     2016-06-16  10179  		raw_spin_unlock_irq(&task->pi_lock);
7dc603c9028ea5 kernel/sched/core.c Peter Zijlstra     2016-06-16  10180  
7dc603c9028ea5 kernel/sched/core.c Peter Zijlstra     2016-06-16  10181  		if (ret)
7dc603c9028ea5 kernel/sched/core.c Peter Zijlstra     2016-06-16  10182  			break;
bb9d97b6dffa10 kernel/sched.c      Tejun Heo          2011-12-12  10183  	}
7dc603c9028ea5 kernel/sched/core.c Peter Zijlstra     2016-06-16  10184  	return ret;
be367d09927023 kernel/sched.c      Ben Blum           2009-09-23  10185  }
68318b8e0b61f9 kernel/sched.c      Srivatsa Vaddagiri 2007-10-18  10186  

:::::: The code at line 10164 was first introduced by commit
:::::: eb95419b023abacb415e2a18fea899023ce7624d cgroup: pass around cgroup_subsys_state instead of cgroup in subsystem methods

:::::: TO: Tejun Heo <tj@kernel.org>
:::::: CC: Tejun Heo <tj@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

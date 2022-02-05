Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5F44AA542
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 02:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378842AbiBEBRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 20:17:08 -0500
Received: from mga01.intel.com ([192.55.52.88]:14164 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233537AbiBEBRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 20:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644023827; x=1675559827;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+83K354TWmbRnp0+/tL54UpgXu0dywYx0vn0B9L1ySw=;
  b=F+2mXSiHcNNA6r3wvrCjkTWaiLxQbKMIutt++XccC2Fj1QTCgX1tiFam
   59EkxZ+CL8aIcWnbuhMW/jw8+2IYSB5dfqu41SxpYnDbqyXgRXIPd1kEQ
   8XDnkorTcX9XfUseQCwakV8AeX4K/cJWy+wKVs8Dyl8FdBIL0iwYzJWC4
   7oDpVI5g1xresYNAU1kPqhLFATAT9LNYAs/cYE6j1MGSSsQeglKbm76+u
   2zgq9+JhvQC/0LpWiWPReNdITcF0D0+O+uNftuWi8F/jRV4mLyTMlM+Ur
   2y9ablmSpXtXyBLxw2GD0DJ6i6T7mQcvlVDF87DeSGUFkmv7sfD7RPIer
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="272978670"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="272978670"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 17:17:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="481010039"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Feb 2022 17:17:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nG9hI-000YPm-3A; Sat, 05 Feb 2022 01:17:04 +0000
Date:   Sat, 5 Feb 2022 09:17:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>
Subject: [frederic-dynticks:isolation/split-v2 4/8]
 kernel/rcu/tree_plugin.h:1217:43: error: use of undeclared identifier
 'HK_FLAG_RCU'; did you mean 'HK_TYPE_RCU'?
Message-ID: <202202050945.aaHWawTf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git isolation/split-v2
head:   31b398242699300304defda3f388cc15b314c1b0
commit: 6c70f095e7a266b13de678c358d3852b92c95799 [4/8] sched/isolation: Use single feature type while referring to housekeeping cpumask
config: arm64-randconfig-r025-20220131 (https://download.01.org/0day-ci/archive/20220205/202202050945.aaHWawTf-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a73e4ce6a59b01f0e37037761c1e6889d539d233)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git/commit/?id=6c70f095e7a266b13de678c358d3852b92c95799
        git remote add frederic-dynticks https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
        git fetch --no-tags frederic-dynticks isolation/split-v2
        git checkout 6c70f095e7a266b13de678c358d3852b92c95799
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/rcu/tree.c:4783:
>> kernel/rcu/tree_plugin.h:1217:43: error: use of undeclared identifier 'HK_FLAG_RCU'; did you mean 'HK_TYPE_RCU'?
           cpumask_and(cm, cm, housekeeping_cpumask(HK_FLAG_RCU));
                                                    ^~~~~~~~~~~
                                                    HK_TYPE_RCU
   include/linux/sched/isolation.h:10:2: note: 'HK_TYPE_RCU' declared here
           HK_TYPE_RCU,
           ^
   In file included from kernel/rcu/tree.c:4783:
   kernel/rcu/tree_plugin.h:1219:41: error: use of undeclared identifier 'HK_FLAG_RCU'; did you mean 'HK_TYPE_RCU'?
                   cpumask_copy(cm, housekeeping_cpumask(HK_FLAG_RCU));
                                                         ^~~~~~~~~~~
                                                         HK_TYPE_RCU
   include/linux/sched/isolation.h:10:2: note: 'HK_TYPE_RCU' declared here
           HK_TYPE_RCU,
           ^
   2 errors generated.


vim +1217 kernel/rcu/tree_plugin.h

27f4d28057adf9 kernel/rcutree_plugin.h  Paul E. McKenney 2011-02-07  1192  
f8b7fc6b514f34 kernel/rcutree_plugin.h  Paul E. McKenney 2011-06-16  1193  /*
f8b7fc6b514f34 kernel/rcutree_plugin.h  Paul E. McKenney 2011-06-16  1194   * Set the per-rcu_node kthread's affinity to cover all CPUs that are
f8b7fc6b514f34 kernel/rcutree_plugin.h  Paul E. McKenney 2011-06-16  1195   * served by the rcu_node in question.  The CPU hotplug lock is still
f8b7fc6b514f34 kernel/rcutree_plugin.h  Paul E. McKenney 2011-06-16  1196   * held, so the value of rnp->qsmaskinit will be stable.
f8b7fc6b514f34 kernel/rcutree_plugin.h  Paul E. McKenney 2011-06-16  1197   *
f8b7fc6b514f34 kernel/rcutree_plugin.h  Paul E. McKenney 2011-06-16  1198   * We don't include outgoingcpu in the affinity set, use -1 if there is
f8b7fc6b514f34 kernel/rcutree_plugin.h  Paul E. McKenney 2011-06-16  1199   * no outgoing CPU.  If there are no CPUs left in the affinity set,
f8b7fc6b514f34 kernel/rcutree_plugin.h  Paul E. McKenney 2011-06-16  1200   * this function allows the kthread to execute on any CPU.
f8b7fc6b514f34 kernel/rcutree_plugin.h  Paul E. McKenney 2011-06-16  1201   */
5d01bbd111d6ff kernel/rcutree_plugin.h  Thomas Gleixner  2012-07-16  1202  static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
f8b7fc6b514f34 kernel/rcutree_plugin.h  Paul E. McKenney 2011-06-16  1203  {
5d01bbd111d6ff kernel/rcutree_plugin.h  Thomas Gleixner  2012-07-16  1204  	struct task_struct *t = rnp->boost_kthread_task;
0aa04b055e71bd kernel/rcu/tree_plugin.h Paul E. McKenney 2015-01-23  1205  	unsigned long mask = rcu_rnp_online_cpus(rnp);
f8b7fc6b514f34 kernel/rcutree_plugin.h  Paul E. McKenney 2011-06-16  1206  	cpumask_var_t cm;
f8b7fc6b514f34 kernel/rcutree_plugin.h  Paul E. McKenney 2011-06-16  1207  	int cpu;
f8b7fc6b514f34 kernel/rcutree_plugin.h  Paul E. McKenney 2011-06-16  1208  
5d01bbd111d6ff kernel/rcutree_plugin.h  Thomas Gleixner  2012-07-16  1209  	if (!t)
f8b7fc6b514f34 kernel/rcutree_plugin.h  Paul E. McKenney 2011-06-16  1210  		return;
5d01bbd111d6ff kernel/rcutree_plugin.h  Thomas Gleixner  2012-07-16  1211  	if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
f8b7fc6b514f34 kernel/rcutree_plugin.h  Paul E. McKenney 2011-06-16  1212  		return;
bc75e99983df1e kernel/rcu/tree_plugin.h Mark Rutland     2016-06-03  1213  	for_each_leaf_node_possible_cpu(rnp, cpu)
bc75e99983df1e kernel/rcu/tree_plugin.h Mark Rutland     2016-06-03  1214  		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
bc75e99983df1e kernel/rcu/tree_plugin.h Mark Rutland     2016-06-03  1215  		    cpu != outgoingcpu)
f8b7fc6b514f34 kernel/rcutree_plugin.h  Paul E. McKenney 2011-06-16  1216  			cpumask_set_cpu(cpu, cm);
c2cf0767e98eb4 kernel/rcu/tree_plugin.h Zqiang           2021-11-15 @1217  	cpumask_and(cm, cm, housekeeping_cpumask(HK_FLAG_RCU));
5d0b0249730275 kernel/rcu/tree_plugin.h Paul E. McKenney 2014-11-10  1218  	if (cpumask_weight(cm) == 0)
c2cf0767e98eb4 kernel/rcu/tree_plugin.h Zqiang           2021-11-15  1219  		cpumask_copy(cm, housekeeping_cpumask(HK_FLAG_RCU));
5d01bbd111d6ff kernel/rcutree_plugin.h  Thomas Gleixner  2012-07-16  1220  	set_cpus_allowed_ptr(t, cm);
f8b7fc6b514f34 kernel/rcutree_plugin.h  Paul E. McKenney 2011-06-16  1221  	free_cpumask_var(cm);
f8b7fc6b514f34 kernel/rcutree_plugin.h  Paul E. McKenney 2011-06-16  1222  }
f8b7fc6b514f34 kernel/rcutree_plugin.h  Paul E. McKenney 2011-06-16  1223  

:::::: The code at line 1217 was first introduced by commit
:::::: c2cf0767e98eb4487444e5c7ebba491a866811ce rcu: Avoid running boost kthreads on isolated CPUs

:::::: TO: Zqiang <qiang.zhang1211@gmail.com>
:::::: CC: Paul E. McKenney <paulmck@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

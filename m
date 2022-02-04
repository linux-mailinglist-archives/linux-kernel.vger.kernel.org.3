Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FB94A9F96
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiBDTAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:00:44 -0500
Received: from mga05.intel.com ([192.55.52.43]:1988 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229737AbiBDTAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644001243; x=1675537243;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zrxrqnItirGDqOflzuRIvi6maD/Es5mByGhVqgoscdw=;
  b=W0IIWThgb+9/5Yjnv4I9eAwsZiCzup4Er1BHfSWmZjAueQzsmG5ffM57
   hHltFuLTedhNJmOBe3HU2q/+nAZRElw0XOwXz6W0kWs3+9mjp8QUPxV/1
   cZZXYsT0AvCUxcHMNpcX8J7KY33XwUjI5OhAVL9i+3uEbf/S5B7xt1rus
   2iYzwSkGlK43rlh+VKO5pKUxey3xWS97X7Yph4T/xfpjzCzu0yk79KjBr
   zUkeim7c3483n/1hcwLNDgc3nku44ygeoHdh5DmsDCHAubWr4zsgbxVMV
   0DK7d/acMat85eScYVlASis7VWWD7N4JwpAz08nmmapcReAKk8AcTKJSr
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="334820486"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="334820486"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 11:00:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="620909919"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Feb 2022 11:00:41 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nG3p2-000Y25-Ku; Fri, 04 Feb 2022 19:00:40 +0000
Date:   Sat, 5 Feb 2022 03:00:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>
Subject: [frederic-dynticks:isolation/split-v2 4/8]
 kernel/rcu/tree_plugin.h:1217:50: error: 'HK_FLAG_RCU' undeclared
Message-ID: <202202050256.iEjqVGhm-lkp@intel.com>
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
config: arc-randconfig-r043-20220131 (https://download.01.org/0day-ci/archive/20220205/202202050256.iEjqVGhm-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git/commit/?id=6c70f095e7a266b13de678c358d3852b92c95799
        git remote add frederic-dynticks https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
        git fetch --no-tags frederic-dynticks isolation/split-v2
        git checkout 6c70f095e7a266b13de678c358d3852b92c95799
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/rcu/tree.c:4783:
   kernel/rcu/tree_plugin.h: In function 'rcu_boost_kthread_setaffinity':
>> kernel/rcu/tree_plugin.h:1217:50: error: 'HK_FLAG_RCU' undeclared (first use in this function)
    1217 |         cpumask_and(cm, cm, housekeeping_cpumask(HK_FLAG_RCU));
         |                                                  ^~~~~~~~~~~
   kernel/rcu/tree_plugin.h:1217:50: note: each undeclared identifier is reported only once for each function it appears in


vim +/HK_FLAG_RCU +1217 kernel/rcu/tree_plugin.h

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

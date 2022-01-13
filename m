Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C8948DDED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237739AbiAMS4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:56:19 -0500
Received: from mga11.intel.com ([192.55.52.93]:18335 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237737AbiAMS4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642100178; x=1673636178;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0UNevOJF4fJKF2CvFjQKd+AReGcnvxU7BVcSlDGRpG8=;
  b=CKjtYmHL2xIxhvAoYmkPNpX8nhiKMccipmhpJ7OX7rb23IvQW7TTn9jP
   Oza30cMJEAIP6yn3+Cg/LB5RNJxicRmKLNt4jHfUcZjFgWelGdDt1vwY/
   7BY8gIEJRO10A3yQ2VWgCej4c4/uBFJrd5gbaASWBoDsEzrAP2CvraSR+
   RxfLqUs6oGZnWUK5X8AESVIXHpNjkIk2VYgVk3K3DyRSJi5wcvngyfVpj
   WU1WNMTpW9CFxrrpJS5mHBcYP6KBBcb/v7TNoc6J8gEw63i+f7EyRBHPy
   pnZ20oX0qiTKHmTKv5n7y23Fi/2cslC8x1hqEHeJCx16e3/yBca3O8pzm
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="241651466"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="241651466"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 10:56:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="491234367"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 Jan 2022 10:56:00 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n85GR-0007Ya-Pi; Thu, 13 Jan 2022 18:55:59 +0000
Date:   Fri, 14 Jan 2022 02:55:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1793/2382] kernel/sched/fair.c:10758:6: warning:
 no previous prototype for 'nohz_balance_enter_idle'
Message-ID: <202201140251.J3IHIgTm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   1a880941a087613ed42f77001229edfcf75ea8a5
commit: 90af8efc5f313f5faa40d7e7bc58986a4342828a [1793/2382] headers/deps: Reorganize, clean up and optimize kernel/sched/sched.h dependencies
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220114/202201140251.J3IHIgTm-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=90af8efc5f313f5faa40d7e7bc58986a4342828a
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 90af8efc5f313f5faa40d7e7bc58986a4342828a
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/sched/fair.c:5486:6: warning: no previous prototype for 'init_cfs_bandwidth' [-Wmissing-prototypes]
    5486 | void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
         |      ^~~~~~~~~~~~~~~~~~
>> kernel/sched/fair.c:10758:6: warning: no previous prototype for 'nohz_balance_enter_idle' [-Wmissing-prototypes]
   10758 | void nohz_balance_enter_idle(int cpu)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11880:6: warning: no previous prototype for 'free_fair_sched_group' [-Wmissing-prototypes]
   11880 | void free_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11882:5: warning: no previous prototype for 'alloc_fair_sched_group' [-Wmissing-prototypes]
   11882 | int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11887:6: warning: no previous prototype for 'online_fair_sched_group' [-Wmissing-prototypes]
   11887 | void online_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11889:6: warning: no previous prototype for 'unregister_fair_sched_group' [-Wmissing-prototypes]
   11889 | void unregister_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/nohz_balance_enter_idle +10758 kernel/sched/fair.c

69e1e811dcc436 kernel/sched/fair.c Suresh Siddha       2011-12-01  10753  
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra      2009-12-17  10754  /*
97fb7a0a8944bd kernel/sched/fair.c Ingo Molnar         2018-03-03  10755   * This routine will record that the CPU is going idle with tick stopped.
0b005cf54eac17 kernel/sched/fair.c Suresh Siddha       2011-12-01  10756   * This info will be used in performing idle load balancing in the future.
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra      2009-12-17  10757   */
c1cc017c59c44d kernel/sched/fair.c Alex Shi            2012-09-10 @10758  void nohz_balance_enter_idle(int cpu)
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra      2009-12-17  10759  {
00357f5ec5d67a kernel/sched/fair.c Peter Zijlstra      2017-12-21  10760  	struct rq *rq = cpu_rq(cpu);
00357f5ec5d67a kernel/sched/fair.c Peter Zijlstra      2017-12-21  10761  
00357f5ec5d67a kernel/sched/fair.c Peter Zijlstra      2017-12-21  10762  	SCHED_WARN_ON(cpu != smp_processor_id());
00357f5ec5d67a kernel/sched/fair.c Peter Zijlstra      2017-12-21  10763  
97fb7a0a8944bd kernel/sched/fair.c Ingo Molnar         2018-03-03  10764  	/* If this CPU is going down, then nothing needs to be done: */
71325960d16cd6 kernel/sched/fair.c Suresh Siddha       2012-01-19  10765  	if (!cpu_active(cpu))
71325960d16cd6 kernel/sched/fair.c Suresh Siddha       2012-01-19  10766  		return;
71325960d16cd6 kernel/sched/fair.c Suresh Siddha       2012-01-19  10767  
387bc8b5536eeb kernel/sched/fair.c Frederic Weisbecker 2017-06-19  10768  	/* Spare idle load balancing on CPUs that don't want to be disturbed: */
de201559df872f kernel/sched/fair.c Frederic Weisbecker 2017-10-27  10769  	if (!housekeeping_cpu(cpu, HK_FLAG_SCHED))
387bc8b5536eeb kernel/sched/fair.c Frederic Weisbecker 2017-06-19  10770  		return;
387bc8b5536eeb kernel/sched/fair.c Frederic Weisbecker 2017-06-19  10771  
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10772  	/*
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10773  	 * Can be set safely without rq->lock held
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10774  	 * If a clear happens, it will have evaluated last additions because
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10775  	 * rq->lock is held during the check and the clear
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10776  	 */
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10777  	rq->has_blocked_load = 1;
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10778  
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10779  	/*
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10780  	 * The tick is still stopped but load could have been added in the
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10781  	 * meantime. We set the nohz.has_blocked flag to trig a check of the
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10782  	 * *_avg. The CPU is already part of nohz.idle_cpus_mask so the clear
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10783  	 * of nohz.has_blocked can only happen after checking the new load
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10784  	 */
00357f5ec5d67a kernel/sched/fair.c Peter Zijlstra      2017-12-21  10785  	if (rq->nohz_tick_stopped)
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10786  		goto out;
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra      2009-12-17  10787  
97fb7a0a8944bd kernel/sched/fair.c Ingo Molnar         2018-03-03  10788  	/* If we're a completely isolated CPU, we don't play: */
00357f5ec5d67a kernel/sched/fair.c Peter Zijlstra      2017-12-21  10789  	if (on_null_domain(rq))
d987fc7f3228bf kernel/sched/fair.c Mike Galbraith      2011-12-05  10790  		return;
d987fc7f3228bf kernel/sched/fair.c Mike Galbraith      2011-12-05  10791  
00357f5ec5d67a kernel/sched/fair.c Peter Zijlstra      2017-12-21  10792  	rq->nohz_tick_stopped = 1;
00357f5ec5d67a kernel/sched/fair.c Peter Zijlstra      2017-12-21  10793  
83cd4fe27ad844 kernel/sched_fair.c Venkatesh Pallipadi 2010-05-21  10794  	cpumask_set_cpu(cpu, nohz.idle_cpus_mask);
0b005cf54eac17 kernel/sched/fair.c Suresh Siddha       2011-12-01  10795  	atomic_inc(&nohz.nr_cpus);
00357f5ec5d67a kernel/sched/fair.c Peter Zijlstra      2017-12-21  10796  
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10797  	/*
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10798  	 * Ensures that if nohz_idle_balance() fails to observe our
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10799  	 * @idle_cpus_mask store, it must observe the @has_blocked
7fd7a9e0caba10 kernel/sched/fair.c Valentin Schneider  2021-08-23  10800  	 * and @needs_update stores.
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10801  	 */
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10802  	smp_mb__after_atomic();
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10803  
00357f5ec5d67a kernel/sched/fair.c Peter Zijlstra      2017-12-21  10804  	set_cpu_sd_state_idle(cpu);
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10805  
7fd7a9e0caba10 kernel/sched/fair.c Valentin Schneider  2021-08-23  10806  	WRITE_ONCE(nohz.needs_update, 1);
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10807  out:
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10808  	/*
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10809  	 * Each time a cpu enter idle, we assume that it has blocked load and
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10810  	 * enable the periodic update of the load of idle cpus
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10811  	 */
f643ea2207010d kernel/sched/fair.c Vincent Guittot     2018-02-13  10812  	WRITE_ONCE(nohz.has_blocked, 1);
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra      2009-12-17  10813  }
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra      2009-12-17  10814  

:::::: The code at line 10758 was first introduced by commit
:::::: c1cc017c59c44d9ede7003631c43adc0cfdce2f9 sched/nohz: Clean up select_nohz_load_balancer()

:::::: TO: Alex Shi <alex.shi@intel.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

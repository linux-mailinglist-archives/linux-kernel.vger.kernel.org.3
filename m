Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A165540E6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 05:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356539AbiFVD2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 23:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355822AbiFVD1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 23:27:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8096313A0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 20:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655868464; x=1687404464;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T3rfUrUSRWJCt3br/xDFwCC1GlNeJIVTmQDtDaDDqRQ=;
  b=NJGZa6e0E+79KCu7devilJHW7s+NrvxXwIouv20APkX8YDewpyZbglD8
   sHeR+FvLADQH8WuK7Ztyy64GyN3UFVTQsFlLYxB9gaoF+Xj8VxUOjIm0p
   g8OPO0oLkkvBIE2ltCJPeMCccm6+wfUg5IcPRYvFkM8Zz6x7WRp3M4Gfn
   kqlLRtj+V5HJKZ6w75V82cz/VnRF6JZbYOLmc5Q7KG+bJlsaFf0AAoj9g
   /Md1Kr2ZR+Ys9vhqL+PEiQt9yDF0sLLJzrC12EngvCJsrWNuQdMgz0TL/
   GbuSUqw5TMV3PIs6e/6S/Tbr5bw6pKr8qFvU1JwCjyKl/5efSfLGFITRl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="281031980"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="281031980"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 20:27:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="715220796"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 21 Jun 2022 20:27:29 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3r1d-0000n3-2Y;
        Wed, 22 Jun 2022 03:27:29 +0000
Date:   Wed, 22 Jun 2022 11:26:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: kernel/sched/fair.c:9246:81: error: 'select_idle_mask' undeclared;
 did you mean 'select_idle_cpu'?
Message-ID: <202206221127.ZB5LLKZT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/Vincent-Donnefort/feec-energy-margin-removal/20220621-170631
head:   2059fff7a5a2b6016ef5843c673845283a00a646
commit: a4a1ec79913664ac49b72cda8c3756c4da7c16b4 sched/fair: Rename select_idle_mask to select_rq_mask
date:   18 hours ago
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220622/202206221127.ZB5LLKZT-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/a4a1ec79913664ac49b72cda8c3756c4da7c16b4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vincent-Donnefort/feec-energy-margin-removal/20220621-170631
        git checkout a4a1ec79913664ac49b72cda8c3756c4da7c16b4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/percpu.h:7,
                    from arch/x86/include/asm/percpu.h:390,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/energy_model.h:5,
                    from kernel/sched/fair.c:23:
   kernel/sched/fair.c: In function 'find_idlest_group':
>> kernel/sched/fair.c:9246:81: error: 'select_idle_mask' undeclared (first use in this function); did you mean 'select_idle_cpu'?
    9246 |                                 struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
         |                                                                                 ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/cpumask.h:761:37: note: in expansion of macro 'this_cpu_ptr'
     761 | #define this_cpu_cpumask_var_ptr(x) this_cpu_ptr(x)
         |                                     ^~~~~~~~~~~~
   kernel/sched/fair.c:9246:56: note: in expansion of macro 'this_cpu_cpumask_var_ptr'
    9246 |                                 struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
         |                                                        ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:9246:81: note: each undeclared identifier is reported only once for each function it appears in
    9246 |                                 struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
         |                                                                                 ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/cpumask.h:761:37: note: in expansion of macro 'this_cpu_ptr'
     761 | #define this_cpu_cpumask_var_ptr(x) this_cpu_ptr(x)
         |                                     ^~~~~~~~~~~~
   kernel/sched/fair.c:9246:56: note: in expansion of macro 'this_cpu_cpumask_var_ptr'
    9246 |                                 struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
         |                                                        ^~~~~~~~~~~~~~~~~~~~~~~~


vim +9246 kernel/sched/fair.c

57abff067a08488 Vincent Guittot    2019-10-18  9103  
57abff067a08488 Vincent Guittot    2019-10-18  9104  /*
57abff067a08488 Vincent Guittot    2019-10-18  9105   * find_idlest_group() finds and returns the least busy CPU group within the
57abff067a08488 Vincent Guittot    2019-10-18  9106   * domain.
57abff067a08488 Vincent Guittot    2019-10-18  9107   *
57abff067a08488 Vincent Guittot    2019-10-18  9108   * Assumes p is allowed on at least one CPU in sd.
57abff067a08488 Vincent Guittot    2019-10-18  9109   */
57abff067a08488 Vincent Guittot    2019-10-18  9110  static struct sched_group *
45da27732b0b9b7 Valentin Schneider 2020-04-15  9111  find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
57abff067a08488 Vincent Guittot    2019-10-18  9112  {
57abff067a08488 Vincent Guittot    2019-10-18  9113  	struct sched_group *idlest = NULL, *local = NULL, *group = sd->groups;
57abff067a08488 Vincent Guittot    2019-10-18  9114  	struct sg_lb_stats local_sgs, tmp_sgs;
57abff067a08488 Vincent Guittot    2019-10-18  9115  	struct sg_lb_stats *sgs;
57abff067a08488 Vincent Guittot    2019-10-18  9116  	unsigned long imbalance;
57abff067a08488 Vincent Guittot    2019-10-18  9117  	struct sg_lb_stats idlest_sgs = {
57abff067a08488 Vincent Guittot    2019-10-18  9118  			.avg_load = UINT_MAX,
57abff067a08488 Vincent Guittot    2019-10-18  9119  			.group_type = group_overloaded,
57abff067a08488 Vincent Guittot    2019-10-18  9120  	};
57abff067a08488 Vincent Guittot    2019-10-18  9121  
57abff067a08488 Vincent Guittot    2019-10-18  9122  	do {
57abff067a08488 Vincent Guittot    2019-10-18  9123  		int local_group;
57abff067a08488 Vincent Guittot    2019-10-18  9124  
57abff067a08488 Vincent Guittot    2019-10-18  9125  		/* Skip over this group if it has no CPUs allowed */
57abff067a08488 Vincent Guittot    2019-10-18  9126  		if (!cpumask_intersects(sched_group_span(group),
57abff067a08488 Vincent Guittot    2019-10-18  9127  					p->cpus_ptr))
57abff067a08488 Vincent Guittot    2019-10-18  9128  			continue;
57abff067a08488 Vincent Guittot    2019-10-18  9129  
97886d9dcd86820 Aubrey Li          2021-03-24  9130  		/* Skip over this group if no cookie matched */
97886d9dcd86820 Aubrey Li          2021-03-24  9131  		if (!sched_group_cookie_match(cpu_rq(this_cpu), p, group))
97886d9dcd86820 Aubrey Li          2021-03-24  9132  			continue;
97886d9dcd86820 Aubrey Li          2021-03-24  9133  
57abff067a08488 Vincent Guittot    2019-10-18  9134  		local_group = cpumask_test_cpu(this_cpu,
57abff067a08488 Vincent Guittot    2019-10-18  9135  					       sched_group_span(group));
57abff067a08488 Vincent Guittot    2019-10-18  9136  
57abff067a08488 Vincent Guittot    2019-10-18  9137  		if (local_group) {
57abff067a08488 Vincent Guittot    2019-10-18  9138  			sgs = &local_sgs;
57abff067a08488 Vincent Guittot    2019-10-18  9139  			local = group;
57abff067a08488 Vincent Guittot    2019-10-18  9140  		} else {
57abff067a08488 Vincent Guittot    2019-10-18  9141  			sgs = &tmp_sgs;
57abff067a08488 Vincent Guittot    2019-10-18  9142  		}
57abff067a08488 Vincent Guittot    2019-10-18  9143  
57abff067a08488 Vincent Guittot    2019-10-18  9144  		update_sg_wakeup_stats(sd, group, sgs, p);
57abff067a08488 Vincent Guittot    2019-10-18  9145  
57abff067a08488 Vincent Guittot    2019-10-18  9146  		if (!local_group && update_pick_idlest(idlest, &idlest_sgs, group, sgs)) {
57abff067a08488 Vincent Guittot    2019-10-18  9147  			idlest = group;
57abff067a08488 Vincent Guittot    2019-10-18  9148  			idlest_sgs = *sgs;
57abff067a08488 Vincent Guittot    2019-10-18  9149  		}
57abff067a08488 Vincent Guittot    2019-10-18  9150  
57abff067a08488 Vincent Guittot    2019-10-18  9151  	} while (group = group->next, group != sd->groups);
57abff067a08488 Vincent Guittot    2019-10-18  9152  
57abff067a08488 Vincent Guittot    2019-10-18  9153  
57abff067a08488 Vincent Guittot    2019-10-18  9154  	/* There is no idlest group to push tasks to */
57abff067a08488 Vincent Guittot    2019-10-18  9155  	if (!idlest)
57abff067a08488 Vincent Guittot    2019-10-18  9156  		return NULL;
57abff067a08488 Vincent Guittot    2019-10-18  9157  
7ed735c33104f3c Vincent Guittot    2019-12-04  9158  	/* The local group has been skipped because of CPU affinity */
7ed735c33104f3c Vincent Guittot    2019-12-04  9159  	if (!local)
7ed735c33104f3c Vincent Guittot    2019-12-04  9160  		return idlest;
7ed735c33104f3c Vincent Guittot    2019-12-04  9161  
57abff067a08488 Vincent Guittot    2019-10-18  9162  	/*
57abff067a08488 Vincent Guittot    2019-10-18  9163  	 * If the local group is idler than the selected idlest group
57abff067a08488 Vincent Guittot    2019-10-18  9164  	 * don't try and push the task.
57abff067a08488 Vincent Guittot    2019-10-18  9165  	 */
57abff067a08488 Vincent Guittot    2019-10-18  9166  	if (local_sgs.group_type < idlest_sgs.group_type)
57abff067a08488 Vincent Guittot    2019-10-18  9167  		return NULL;
57abff067a08488 Vincent Guittot    2019-10-18  9168  
57abff067a08488 Vincent Guittot    2019-10-18  9169  	/*
57abff067a08488 Vincent Guittot    2019-10-18  9170  	 * If the local group is busier than the selected idlest group
57abff067a08488 Vincent Guittot    2019-10-18  9171  	 * try and push the task.
57abff067a08488 Vincent Guittot    2019-10-18  9172  	 */
57abff067a08488 Vincent Guittot    2019-10-18  9173  	if (local_sgs.group_type > idlest_sgs.group_type)
57abff067a08488 Vincent Guittot    2019-10-18  9174  		return idlest;
57abff067a08488 Vincent Guittot    2019-10-18  9175  
57abff067a08488 Vincent Guittot    2019-10-18  9176  	switch (local_sgs.group_type) {
57abff067a08488 Vincent Guittot    2019-10-18  9177  	case group_overloaded:
57abff067a08488 Vincent Guittot    2019-10-18  9178  	case group_fully_busy:
5c339005f854fa7 Mel Gorman         2020-11-20  9179  
5c339005f854fa7 Mel Gorman         2020-11-20  9180  		/* Calculate allowed imbalance based on load */
5c339005f854fa7 Mel Gorman         2020-11-20  9181  		imbalance = scale_load_down(NICE_0_LOAD) *
5c339005f854fa7 Mel Gorman         2020-11-20  9182  				(sd->imbalance_pct-100) / 100;
5c339005f854fa7 Mel Gorman         2020-11-20  9183  
57abff067a08488 Vincent Guittot    2019-10-18  9184  		/*
57abff067a08488 Vincent Guittot    2019-10-18  9185  		 * When comparing groups across NUMA domains, it's possible for
57abff067a08488 Vincent Guittot    2019-10-18  9186  		 * the local domain to be very lightly loaded relative to the
57abff067a08488 Vincent Guittot    2019-10-18  9187  		 * remote domains but "imbalance" skews the comparison making
57abff067a08488 Vincent Guittot    2019-10-18  9188  		 * remote CPUs look much more favourable. When considering
57abff067a08488 Vincent Guittot    2019-10-18  9189  		 * cross-domain, add imbalance to the load on the remote node
57abff067a08488 Vincent Guittot    2019-10-18  9190  		 * and consider staying local.
57abff067a08488 Vincent Guittot    2019-10-18  9191  		 */
57abff067a08488 Vincent Guittot    2019-10-18  9192  
57abff067a08488 Vincent Guittot    2019-10-18  9193  		if ((sd->flags & SD_NUMA) &&
57abff067a08488 Vincent Guittot    2019-10-18  9194  		    ((idlest_sgs.avg_load + imbalance) >= local_sgs.avg_load))
57abff067a08488 Vincent Guittot    2019-10-18  9195  			return NULL;
57abff067a08488 Vincent Guittot    2019-10-18  9196  
57abff067a08488 Vincent Guittot    2019-10-18  9197  		/*
57abff067a08488 Vincent Guittot    2019-10-18  9198  		 * If the local group is less loaded than the selected
57abff067a08488 Vincent Guittot    2019-10-18  9199  		 * idlest group don't try and push any tasks.
57abff067a08488 Vincent Guittot    2019-10-18  9200  		 */
57abff067a08488 Vincent Guittot    2019-10-18  9201  		if (idlest_sgs.avg_load >= (local_sgs.avg_load + imbalance))
57abff067a08488 Vincent Guittot    2019-10-18  9202  			return NULL;
57abff067a08488 Vincent Guittot    2019-10-18  9203  
57abff067a08488 Vincent Guittot    2019-10-18  9204  		if (100 * local_sgs.avg_load <= sd->imbalance_pct * idlest_sgs.avg_load)
57abff067a08488 Vincent Guittot    2019-10-18  9205  			return NULL;
57abff067a08488 Vincent Guittot    2019-10-18  9206  		break;
57abff067a08488 Vincent Guittot    2019-10-18  9207  
57abff067a08488 Vincent Guittot    2019-10-18  9208  	case group_imbalanced:
57abff067a08488 Vincent Guittot    2019-10-18  9209  	case group_asym_packing:
57abff067a08488 Vincent Guittot    2019-10-18  9210  		/* Those type are not used in the slow wakeup path */
57abff067a08488 Vincent Guittot    2019-10-18  9211  		return NULL;
57abff067a08488 Vincent Guittot    2019-10-18  9212  
57abff067a08488 Vincent Guittot    2019-10-18  9213  	case group_misfit_task:
57abff067a08488 Vincent Guittot    2019-10-18  9214  		/* Select group with the highest max capacity */
57abff067a08488 Vincent Guittot    2019-10-18  9215  		if (local->sgc->max_capacity >= idlest->sgc->max_capacity)
57abff067a08488 Vincent Guittot    2019-10-18  9216  			return NULL;
57abff067a08488 Vincent Guittot    2019-10-18  9217  		break;
57abff067a08488 Vincent Guittot    2019-10-18  9218  
57abff067a08488 Vincent Guittot    2019-10-18  9219  	case group_has_spare:
cb29a5c19d2d68a Mel Gorman         2022-05-20  9220  #ifdef CONFIG_NUMA
57abff067a08488 Vincent Guittot    2019-10-18  9221  		if (sd->flags & SD_NUMA) {
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9222  			int imb_numa_nr = sd->imb_numa_nr;
57abff067a08488 Vincent Guittot    2019-10-18  9223  #ifdef CONFIG_NUMA_BALANCING
57abff067a08488 Vincent Guittot    2019-10-18  9224  			int idlest_cpu;
57abff067a08488 Vincent Guittot    2019-10-18  9225  			/*
57abff067a08488 Vincent Guittot    2019-10-18  9226  			 * If there is spare capacity at NUMA, try to select
57abff067a08488 Vincent Guittot    2019-10-18  9227  			 * the preferred node
57abff067a08488 Vincent Guittot    2019-10-18  9228  			 */
57abff067a08488 Vincent Guittot    2019-10-18  9229  			if (cpu_to_node(this_cpu) == p->numa_preferred_nid)
57abff067a08488 Vincent Guittot    2019-10-18  9230  				return NULL;
57abff067a08488 Vincent Guittot    2019-10-18  9231  
57abff067a08488 Vincent Guittot    2019-10-18  9232  			idlest_cpu = cpumask_first(sched_group_span(idlest));
57abff067a08488 Vincent Guittot    2019-10-18  9233  			if (cpu_to_node(idlest_cpu) == p->numa_preferred_nid)
57abff067a08488 Vincent Guittot    2019-10-18  9234  				return idlest;
cb29a5c19d2d68a Mel Gorman         2022-05-20  9235  #endif /* CONFIG_NUMA_BALANCING */
57abff067a08488 Vincent Guittot    2019-10-18  9236  			/*
2cfb7a1b031b0e8 Mel Gorman         2022-02-08  9237  			 * Otherwise, keep the task close to the wakeup source
2cfb7a1b031b0e8 Mel Gorman         2022-02-08  9238  			 * and improve locality if the number of running tasks
2cfb7a1b031b0e8 Mel Gorman         2022-02-08  9239  			 * would remain below threshold where an imbalance is
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9240  			 * allowed while accounting for the possibility the
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9241  			 * task is pinned to a subset of CPUs. If there is a
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9242  			 * real need of migration, periodic load balance will
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9243  			 * take care of it.
57abff067a08488 Vincent Guittot    2019-10-18  9244  			 */
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9245  			if (p->nr_cpus_allowed != NR_CPUS) {
f5b2eeb49991047 K Prateek Nayak    2022-04-07 @9246  				struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9247  
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9248  				cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9249  				imb_numa_nr = min(cpumask_weight(cpus), sd->imb_numa_nr);
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9250  			}
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9251  
cb29a5c19d2d68a Mel Gorman         2022-05-20  9252  			imbalance = abs(local_sgs.idle_cpus - idlest_sgs.idle_cpus);
cb29a5c19d2d68a Mel Gorman         2022-05-20  9253  			if (!adjust_numa_imbalance(imbalance,
cb29a5c19d2d68a Mel Gorman         2022-05-20  9254  						   local_sgs.sum_nr_running + 1,
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9255  						   imb_numa_nr)) {
57abff067a08488 Vincent Guittot    2019-10-18  9256  				return NULL;
57abff067a08488 Vincent Guittot    2019-10-18  9257  			}
cb29a5c19d2d68a Mel Gorman         2022-05-20  9258  		}
cb29a5c19d2d68a Mel Gorman         2022-05-20  9259  #endif /* CONFIG_NUMA */
57abff067a08488 Vincent Guittot    2019-10-18  9260  
57abff067a08488 Vincent Guittot    2019-10-18  9261  		/*
57abff067a08488 Vincent Guittot    2019-10-18  9262  		 * Select group with highest number of idle CPUs. We could also
57abff067a08488 Vincent Guittot    2019-10-18  9263  		 * compare the utilization which is more stable but it can end
57abff067a08488 Vincent Guittot    2019-10-18  9264  		 * up that the group has less spare capacity but finally more
57abff067a08488 Vincent Guittot    2019-10-18  9265  		 * idle CPUs which means more opportunity to run task.
57abff067a08488 Vincent Guittot    2019-10-18  9266  		 */
57abff067a08488 Vincent Guittot    2019-10-18  9267  		if (local_sgs.idle_cpus >= idlest_sgs.idle_cpus)
57abff067a08488 Vincent Guittot    2019-10-18  9268  			return NULL;
57abff067a08488 Vincent Guittot    2019-10-18  9269  		break;
57abff067a08488 Vincent Guittot    2019-10-18  9270  	}
57abff067a08488 Vincent Guittot    2019-10-18  9271  
57abff067a08488 Vincent Guittot    2019-10-18  9272  	return idlest;
57abff067a08488 Vincent Guittot    2019-10-18  9273  }
57abff067a08488 Vincent Guittot    2019-10-18  9274  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

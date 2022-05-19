Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8769152C97E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 03:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiESBz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 21:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiESBzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 21:55:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0452C5E78
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 18:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652925323; x=1684461323;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/OJOg3dkfXm6fOQKLVJsKGOFJ1zSff74S9bw8dTQlms=;
  b=BbLwlEbS8O4QRYANhqd+VWY9LzHNEh/Y5aqs3bY/ynuLVbnpVSFWOU2F
   9u9hUCKaXQ5CKWhVVaM8zKSxD5ikI9cxGNKSbpdIfQURpFQVdVdl1ctZW
   sxAIJVLOaO1VDn3vk1x0BzsHDmaCE+aYC3ev3SRCW9y/PNi7NUN3E8N48
   WHgfi7WS566kdOASfVhMEzYkQ9JWbubYOgnePNuzW7TQDuIHQjU047zPz
   Qjx5LdqsMZfOwKNZUKzAD3T+IScpFRSytzbMCWEKr2tFhXBF8Jlkvc7/f
   rmv4MJsHmjrfyCkRKnmx3jLjDljWVThlFSPHiOrGc54unPjFVrnxmE8Ix
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="254022838"
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="254022838"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 18:55:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="661457872"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 18 May 2022 18:55:21 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrVNp-0002vB-7X;
        Thu, 19 May 2022 01:55:21 +0000
Date:   Thu, 19 May 2022 09:55:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:sched/core 6/8] kernel/sched/fair.c:9199:30: error:
 implicit declaration of function 'adjust_numa_imbalance'
Message-ID: <202205190911.n5iX1ftB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
head:   45ff65aa1bfd4826331c9c4daafdca21ef8f79f8
commit: c81394419b54c2df2644a34892a6d6434fd922b3 [6/8] sched/numa: Apply imbalance limitations consistently
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220519/202205190911.n5iX1ftB-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=c81394419b54c2df2644a34892a6d6434fd922b3
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/core
        git checkout c81394419b54c2df2644a34892a6d6434fd922b3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/sched/fair.c: In function 'find_idlest_group':
>> kernel/sched/fair.c:9199:30: error: implicit declaration of function 'adjust_numa_imbalance' [-Werror=implicit-function-declaration]
    9199 |                         if (!adjust_numa_imbalance(imbalance,
         |                              ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/adjust_numa_imbalance +9199 kernel/sched/fair.c

  9060	
  9061	/*
  9062	 * find_idlest_group() finds and returns the least busy CPU group within the
  9063	 * domain.
  9064	 *
  9065	 * Assumes p is allowed on at least one CPU in sd.
  9066	 */
  9067	static struct sched_group *
  9068	find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
  9069	{
  9070		struct sched_group *idlest = NULL, *local = NULL, *group = sd->groups;
  9071		struct sg_lb_stats local_sgs, tmp_sgs;
  9072		struct sg_lb_stats *sgs;
  9073		unsigned long imbalance;
  9074		struct sg_lb_stats idlest_sgs = {
  9075				.avg_load = UINT_MAX,
  9076				.group_type = group_overloaded,
  9077		};
  9078	
  9079		do {
  9080			int local_group;
  9081	
  9082			/* Skip over this group if it has no CPUs allowed */
  9083			if (!cpumask_intersects(sched_group_span(group),
  9084						p->cpus_ptr))
  9085				continue;
  9086	
  9087			/* Skip over this group if no cookie matched */
  9088			if (!sched_group_cookie_match(cpu_rq(this_cpu), p, group))
  9089				continue;
  9090	
  9091			local_group = cpumask_test_cpu(this_cpu,
  9092						       sched_group_span(group));
  9093	
  9094			if (local_group) {
  9095				sgs = &local_sgs;
  9096				local = group;
  9097			} else {
  9098				sgs = &tmp_sgs;
  9099			}
  9100	
  9101			update_sg_wakeup_stats(sd, group, sgs, p);
  9102	
  9103			if (!local_group && update_pick_idlest(idlest, &idlest_sgs, group, sgs)) {
  9104				idlest = group;
  9105				idlest_sgs = *sgs;
  9106			}
  9107	
  9108		} while (group = group->next, group != sd->groups);
  9109	
  9110	
  9111		/* There is no idlest group to push tasks to */
  9112		if (!idlest)
  9113			return NULL;
  9114	
  9115		/* The local group has been skipped because of CPU affinity */
  9116		if (!local)
  9117			return idlest;
  9118	
  9119		/*
  9120		 * If the local group is idler than the selected idlest group
  9121		 * don't try and push the task.
  9122		 */
  9123		if (local_sgs.group_type < idlest_sgs.group_type)
  9124			return NULL;
  9125	
  9126		/*
  9127		 * If the local group is busier than the selected idlest group
  9128		 * try and push the task.
  9129		 */
  9130		if (local_sgs.group_type > idlest_sgs.group_type)
  9131			return idlest;
  9132	
  9133		switch (local_sgs.group_type) {
  9134		case group_overloaded:
  9135		case group_fully_busy:
  9136	
  9137			/* Calculate allowed imbalance based on load */
  9138			imbalance = scale_load_down(NICE_0_LOAD) *
  9139					(sd->imbalance_pct-100) / 100;
  9140	
  9141			/*
  9142			 * When comparing groups across NUMA domains, it's possible for
  9143			 * the local domain to be very lightly loaded relative to the
  9144			 * remote domains but "imbalance" skews the comparison making
  9145			 * remote CPUs look much more favourable. When considering
  9146			 * cross-domain, add imbalance to the load on the remote node
  9147			 * and consider staying local.
  9148			 */
  9149	
  9150			if ((sd->flags & SD_NUMA) &&
  9151			    ((idlest_sgs.avg_load + imbalance) >= local_sgs.avg_load))
  9152				return NULL;
  9153	
  9154			/*
  9155			 * If the local group is less loaded than the selected
  9156			 * idlest group don't try and push any tasks.
  9157			 */
  9158			if (idlest_sgs.avg_load >= (local_sgs.avg_load + imbalance))
  9159				return NULL;
  9160	
  9161			if (100 * local_sgs.avg_load <= sd->imbalance_pct * idlest_sgs.avg_load)
  9162				return NULL;
  9163			break;
  9164	
  9165		case group_imbalanced:
  9166		case group_asym_packing:
  9167			/* Those type are not used in the slow wakeup path */
  9168			return NULL;
  9169	
  9170		case group_misfit_task:
  9171			/* Select group with the highest max capacity */
  9172			if (local->sgc->max_capacity >= idlest->sgc->max_capacity)
  9173				return NULL;
  9174			break;
  9175	
  9176		case group_has_spare:
  9177			if (sd->flags & SD_NUMA) {
  9178	#ifdef CONFIG_NUMA_BALANCING
  9179				int idlest_cpu;
  9180				/*
  9181				 * If there is spare capacity at NUMA, try to select
  9182				 * the preferred node
  9183				 */
  9184				if (cpu_to_node(this_cpu) == p->numa_preferred_nid)
  9185					return NULL;
  9186	
  9187				idlest_cpu = cpumask_first(sched_group_span(idlest));
  9188				if (cpu_to_node(idlest_cpu) == p->numa_preferred_nid)
  9189					return idlest;
  9190	#endif
  9191				/*
  9192				 * Otherwise, keep the task close to the wakeup source
  9193				 * and improve locality if the number of running tasks
  9194				 * would remain below threshold where an imbalance is
  9195				 * allowed. If there is a real need of migration,
  9196				 * periodic load balance will take care of it.
  9197				 */
  9198				imbalance = abs(local_sgs.idle_cpus - idlest_sgs.idle_cpus);
> 9199				if (!adjust_numa_imbalance(imbalance,
  9200							   local_sgs.sum_nr_running + 1,
  9201							   sd->imb_numa_nr)) {
  9202					return NULL;
  9203				}
  9204			}
  9205	
  9206			/*
  9207			 * Select group with highest number of idle CPUs. We could also
  9208			 * compare the utilization which is more stable but it can end
  9209			 * up that the group has less spare capacity but finally more
  9210			 * idle CPUs which means more opportunity to run task.
  9211			 */
  9212			if (local_sgs.idle_cpus >= idlest_sgs.idle_cpus)
  9213				return NULL;
  9214			break;
  9215		}
  9216	
  9217		return idlest;
  9218	}
  9219	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

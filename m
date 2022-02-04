Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44544A9D8F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376856AbiBDRSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:18:51 -0500
Received: from mga12.intel.com ([192.55.52.136]:3932 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349319AbiBDRSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643995131; x=1675531131;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=H6JsNS4k6lAN+ph09h1fkrO9MV3r0nkNnGhq/yb3Fh8=;
  b=hpX08MNHsuOqCXVdK5rBmMe+9Uea6FtxIOaTjfqsXvRXk7Vz9JYc/wvY
   pjUVWWrMbrnU3AfBm6D6/Hr2iGxlu3Ci5zqdzV/ErsRUMObGhKyNaJfIt
   XEKnB7enNWZ23ajPP+D++k+MmEvQ7epve2eTQyIz8WFAYDVx1CAyqCda2
   GKNr86V4WBzByYLdYc1l9xhGJV3ZHqeDaEt1kwy5Z8ISjdDtreHxvZTA8
   T59MV8CnOYjERQt8c5/9w7WZuJkIOKNdlf1vzmdHChDOapKFFmDzMndso
   +sYeIZMnJSaIF1gZIivj1+LJK6i9zPf+MenNduz9SvYfHsni0c3EjvFU/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="228376435"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="228376435"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 09:18:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="584190781"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Feb 2022 09:18:36 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nG2EF-000XvO-Oa; Fri, 04 Feb 2022 17:18:35 +0000
Date:   Sat, 5 Feb 2022 01:18:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [nsaenz-rpi:pcplists-rcu-drain-v1 2/2] mm/page_alloc.c:3245:28:
 sparse: sparse: incorrect type in assignment (different address spaces)
Message-ID: <202202050150.PQssjWMS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git pcplists-rcu-drain-v1
head:   01b58921eae8d67b3ad6b05e73c2a1dd7106ae28
commit: 01b58921eae8d67b3ad6b05e73c2a1dd7106ae28 [2/2] mm/page_alloc: Add remote draining support to per-cpu lists
config: h8300-randconfig-s032-20220201 (https://download.01.org/0day-ci/archive/20220205/202202050150.PQssjWMS-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git/commit/?id=01b58921eae8d67b3ad6b05e73c2a1dd7106ae28
        git remote add nsaenz-rpi https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git
        git fetch --no-tags nsaenz-rpi pcplists-rcu-drain-v1
        git checkout 01b58921eae8d67b3ad6b05e73c2a1dd7106ae28
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=h8300 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   mm/page_alloc.c:1475:30: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected struct list_head *list @@     got struct list_head [noderef] * @@
   mm/page_alloc.c:1475:30: sparse:     expected struct list_head *list
   mm/page_alloc.c:1475:30: sparse:     got struct list_head [noderef] *
>> mm/page_alloc.c:3245:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct pcplists [noderef] *lp @@     got struct pcplists [noderef] __rcu * @@
   mm/page_alloc.c:3245:28: sparse:     expected struct pcplists [noderef] *lp
   mm/page_alloc.c:3245:28: sparse:     got struct pcplists [noderef] __rcu *
   mm/page_alloc.c:3250:36: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct pcplists [noderef] *lp @@     got struct pcplists [noderef] __rcu * @@
   mm/page_alloc.c:3250:36: sparse:     expected struct pcplists [noderef] *lp
   mm/page_alloc.c:3250:36: sparse:     got struct pcplists [noderef] __rcu *
   mm/page_alloc.c:3435:40: sparse: sparse: incorrect type in argument 2 (different modifiers) @@     expected struct list_head *head @@     got struct list_head [noderef] * @@
   mm/page_alloc.c:3435:40: sparse:     expected struct list_head *head
   mm/page_alloc.c:3435:40: sparse:     got struct list_head [noderef] *
   mm/page_alloc.c:3726:14: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected struct list_head *list @@     got struct list_head [noderef] * @@
   mm/page_alloc.c:3726:14: sparse:     expected struct list_head *list
   mm/page_alloc.c:3726:14: sparse:     got struct list_head [noderef] *
   mm/page_alloc.c:3727:15: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected int *count @@     got int [noderef] * @@
   mm/page_alloc.c:3727:15: sparse:     expected int *count
   mm/page_alloc.c:3727:15: sparse:     got int [noderef] *
   mm/page_alloc.c:5349:18: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected struct list_head *pcp_list @@     got struct list_head [noderef] * @@
   mm/page_alloc.c:5349:18: sparse:     expected struct list_head *pcp_list
   mm/page_alloc.c:5349:18: sparse:     got struct list_head [noderef] *
   mm/page_alloc.c:5350:15: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected int *count @@     got int [noderef] * @@
   mm/page_alloc.c:5350:15: sparse:     expected int *count
   mm/page_alloc.c:5350:15: sparse:     got int [noderef] *
   mm/page_alloc.c:5966:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct pcplists [noderef] *lp @@     got struct pcplists [noderef] __rcu * @@
   mm/page_alloc.c:5966:28: sparse:     expected struct pcplists [noderef] *lp
   mm/page_alloc.c:5966:28: sparse:     got struct pcplists [noderef] __rcu *
   mm/page_alloc.c:6064:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct pcplists [noderef] *lp @@     got struct pcplists [noderef] __rcu * @@
   mm/page_alloc.c:6064:28: sparse:     expected struct pcplists [noderef] *lp
   mm/page_alloc.c:6064:28: sparse:     got struct pcplists [noderef] __rcu *
>> mm/page_alloc.c:7020:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct pcplists [noderef] __rcu *lp @@     got struct pcplists [noderef] * @@
   mm/page_alloc.c:7020:17: sparse:     expected struct pcplists [noderef] __rcu *lp
   mm/page_alloc.c:7020:17: sparse:     got struct pcplists [noderef] *
>> mm/page_alloc.c:7024:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct list_head *list @@     got struct list_head [noderef] __rcu * @@
   mm/page_alloc.c:7024:47: sparse:     expected struct list_head *list
   mm/page_alloc.c:7024:47: sparse:     got struct list_head [noderef] __rcu *
   mm/page_alloc.c:7025:50: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct list_head *list @@     got struct list_head [noderef] * @@
   mm/page_alloc.c:7025:50: sparse:     expected struct list_head *list
   mm/page_alloc.c:7025:50: sparse:     got struct list_head [noderef] *
   mm/page_alloc.c:1460:17: sparse: sparse: dereference of noderef expression
   mm/page_alloc.c:1515:9: sparse: sparse: dereference of noderef expression
   mm/page_alloc.c:3157:13: sparse: sparse: dereference of noderef expression
   mm/page_alloc.c:3158:42: sparse: sparse: dereference of noderef expression
   mm/page_alloc.c:3246:29: sparse: sparse: dereference of noderef expression
   mm/page_alloc.c:3251:37: sparse: sparse: dereference of noderef expression
   mm/page_alloc.c:3286:36: sparse: sparse: dereference of noderef expression
   mm/page_alloc.c:3293:25: sparse: sparse: dereference of noderef expression
   mm/page_alloc.c:3436:9: sparse: sparse: dereference of noderef expression
   mm/page_alloc.c:3438:13: sparse: sparse: dereference of noderef expression
   mm/page_alloc.c: note: in included file (through include/linux/mm.h):
   include/linux/gfp.h:368:27: sparse: sparse: restricted gfp_t degrades to integer
   include/linux/gfp.h:368:27: sparse: sparse: restricted gfp_t degrades to integer
   mm/page_alloc.c:5967:37: sparse: sparse: dereference of noderef expression
   mm/page_alloc.c:6065:37: sparse: sparse: dereference of noderef expression
   mm/page_alloc.c:6069:17: sparse: sparse: dereference of noderef expression

vim +3245 mm/page_alloc.c

  3194	
  3195	/*
  3196	 * The implementation of drain_all_pages(), exposing an extra parameter to
  3197	 * drain on all cpus.
  3198	 *
  3199	 * drain_all_pages() is optimized to only execute on cpus where pcplists are
  3200	 * not empty. The check for non-emptiness can however race with a free to
  3201	 * pcplist that has not yet increased the lp->count from 0 to 1. Callers
  3202	 * that need the guarantee that every CPU has drained can disable the
  3203	 * optimizing racy check.
  3204	 */
  3205	static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
  3206	{
  3207		struct per_cpu_pages *pcp;
  3208		struct zone *z;
  3209		int cpu;
  3210	
  3211		/*
  3212		 * Allocate in the BSS so we won't require allocation in
  3213		 * direct reclaim path for CONFIG_CPUMASK_OFFSTACK=y
  3214		 */
  3215		static cpumask_t cpus_with_pcps;
  3216	
  3217		/*
  3218		 * Do not drain if one is already in progress unless it's specific to
  3219		 * a zone. Such callers are primarily CMA and memory hotplug and need
  3220		 * the drain to be complete when the call returns.
  3221		 */
  3222		if (unlikely(!mutex_trylock(&pcpu_drain_mutex))) {
  3223			if (!zone)
  3224				return;
  3225			mutex_lock(&pcpu_drain_mutex);
  3226		}
  3227	
  3228		/*
  3229		 * We don't care about racing with CPU hotplug event
  3230		 * as offline notification will cause the notified
  3231		 * cpu to drain that CPU pcps and on_each_cpu_mask
  3232		 * disables preemption as part of its processing
  3233		 */
  3234		for_each_online_cpu(cpu) {
  3235			bool has_pcps = false;
  3236			struct pcplists *lp;
  3237	
  3238			if (force_all_cpus) {
  3239				/*
  3240				 * The lp->count check is racy, some callers need a
  3241				 * guarantee that no cpu is missed.
  3242				 */
  3243				has_pcps = true;
  3244			} else if (zone) {
> 3245				lp = READ_ONCE(per_cpu_ptr(zone->per_cpu_pageset, cpu)->lp);
  3246				if (lp->count)
  3247					has_pcps = true;
  3248			} else {
  3249				for_each_populated_zone(z) {
  3250					lp = READ_ONCE(per_cpu_ptr(z->per_cpu_pageset, cpu)->lp);
  3251					if (lp->count) {
  3252						has_pcps = true;
  3253						break;
  3254					}
  3255				}
  3256			}
  3257	
  3258			if (has_pcps)
  3259				cpumask_set_cpu(cpu, &cpus_with_pcps);
  3260			else
  3261				cpumask_clear_cpu(cpu, &cpus_with_pcps);
  3262		}
  3263	
  3264		if (!force_all_cpus && cpumask_empty(&cpus_with_pcps))
  3265		       goto exit;
  3266	
  3267		for_each_cpu(cpu, &cpus_with_pcps) {
  3268		       for_each_populated_zone(z) {
  3269			       if (zone && zone != z)
  3270				       continue;
  3271	
  3272			       pcp = per_cpu_ptr(z->per_cpu_pageset, cpu);
  3273			       pcp->drain = rcu_replace_pointer(pcp->lp, pcp->drain,
  3274						       mutex_is_locked(&pcpu_drain_mutex));
  3275		       }
  3276		}
  3277	
  3278		synchronize_rcu();
  3279	
  3280		for_each_cpu(cpu, &cpus_with_pcps) {
  3281			for_each_populated_zone(z) {
  3282				unsigned long flags;
  3283				int count;
  3284	
  3285				pcp = per_cpu_ptr(z->per_cpu_pageset, cpu);
  3286				count = pcp->drain->count;
  3287				if (!count)
  3288				       continue;
  3289	
  3290				local_irq_save(flags);
  3291				free_pcppages_bulk(z, count, READ_ONCE(pcp->batch), pcp->drain);
  3292				local_irq_restore(flags);
  3293				VM_BUG_ON(pcp->drain->count);
  3294			}
  3295		}
  3296	
  3297	exit:
  3298		mutex_unlock(&pcpu_drain_mutex);
  3299	}
  3300	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

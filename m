Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884C150CD74
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 22:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbiDWU64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 16:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237044AbiDWU6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 16:58:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E779135B06
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 13:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650747353; x=1682283353;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3RhEuqKdaLu2nl2YQVk3uv7C9E53XCGPjWaM/Ew0MuI=;
  b=XwUR+FHL8rVL5S/fhqu7YAPcXWlYMEWXEZDl7Mk1NbtUj8/tWI6GFYRC
   m4/NYPx+7NBmrXuDheO4YP6+z+QJfZ890e/qtj7mcg8d5ZNHykTgHp0Fc
   Ymr374J/WisDGdEFcjj7rtPrTOCPVPSsjRuGbj4Aeo9WiBaw4FpLu15Bp
   JDjbaTYnk4NQ+4fGxNZTF9dEsMGOJoBEfs8AqScy5GwnA8VRb9l2prV/e
   ZSgBCh6zApr68IJMYp15NqByWfVt9uVt2LY0n5NzMDGk+L82hCtdafYy7
   zfyGTV+rZ9H80SuBH/IxEGXjKwmXFH9hcH5qEegbtztf+AXiZl9tLyzEt
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="245524022"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="245524022"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 13:55:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="615911267"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 23 Apr 2022 13:55:51 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niMnG-0000T9-DB;
        Sat, 23 Apr 2022 20:55:50 +0000
Date:   Sun, 24 Apr 2022 04:55:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: kernel/sched/core.c:6890:43: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202204240435.ZC4wNETv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   13bc32bad7059d6c5671e9d037e6e3ed001cc0f4
commit: 2558aacff8586699bcd248b406febb28b0a25de2 sched/hotplug: Ensure only per-cpu kthreads run during hotplug
date:   1 year, 5 months ago
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220424/202204240435.ZC4wNETv-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2558aacff8586699bcd248b406febb28b0a25de2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2558aacff8586699bcd248b406febb28b0a25de2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/sched/core.c:611:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:611:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:611:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:666:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/core.c:666:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/core.c:666:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/core.c:1693:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:1693:33: sparse:     expected struct task_struct *p
   kernel/sched/core.c:1693:33: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:1693:68: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:1693:68: sparse:     expected struct task_struct *tsk
   kernel/sched/core.c:1693:68: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:2435:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/core.c:2435:17: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/core.c:2435:17: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/core.c:2627:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct const *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2627:36: sparse:     expected struct task_struct const *p
   kernel/sched/core.c:2627:36: sparse:     got struct task_struct [noderef] __rcu *curr
>> kernel/sched/core.c:6890:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *push_task @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:6890:43: sparse:     expected struct task_struct *push_task
   kernel/sched/core.c:6890:43: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:4030:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:4030:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:4030:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:4115:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:4115:14: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:4115:14: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:4463:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *prev @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:4463:14: sparse:     expected struct task_struct *prev
   kernel/sched/core.c:4463:14: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:4926:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:4926:17: sparse:    struct task_struct *
   kernel/sched/core.c:4926:17: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:5128:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:5128:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:5128:22: sparse:    struct task_struct *
   kernel/sched/core.c:8578:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:8578:25: sparse:     expected struct task_struct *p
   kernel/sched/core.c:8578:25: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c: note: in included file:
   kernel/sched/pelt.h:85:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct const *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/pelt.h:85:13: sparse:     expected struct task_struct const *p
   kernel/sched/pelt.h:85:13: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:1684:33: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:1685:19: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:1686:37: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:1703:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1703:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1703:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1848:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1848:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1848:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1854:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1854:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1854:9: sparse:    struct task_struct *
   kernel/sched/core.c:1659:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:1659:38: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:1659:38: sparse:    struct task_struct const *
   kernel/sched/sched.h:1703:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1703:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1703:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1848:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1848:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1848:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1848:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1848:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1848:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1703:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1703:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1703:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1848:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1848:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1848:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1854:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1854:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1854:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1703:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1703:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1703:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1848:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1848:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1848:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1854:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1854:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1854:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1703:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1703:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1703:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1848:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1848:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1848:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1854:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1854:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1854:9: sparse:    struct task_struct *

vim +6890 kernel/sched/core.c

  6884	
  6885	/*
  6886	 * Ensure we only run per-cpu kthreads once the CPU goes !active.
  6887	 */
  6888	static void balance_push(struct rq *rq)
  6889	{
> 6890		struct task_struct *push_task = rq->curr;
  6891	
  6892		lockdep_assert_held(&rq->lock);
  6893		SCHED_WARN_ON(rq->cpu != smp_processor_id());
  6894	
  6895		/*
  6896		 * Both the cpu-hotplug and stop task are in this case and are
  6897		 * required to complete the hotplug process.
  6898		 */
  6899		if (is_per_cpu_kthread(push_task))
  6900			return;
  6901	
  6902		get_task_struct(push_task);
  6903		/*
  6904		 * Temporarily drop rq->lock such that we can wake-up the stop task.
  6905		 * Both preemption and IRQs are still disabled.
  6906		 */
  6907		raw_spin_unlock(&rq->lock);
  6908		stop_one_cpu_nowait(rq->cpu, __balance_push_cpu_stop, push_task,
  6909				    this_cpu_ptr(&push_work));
  6910		/*
  6911		 * At this point need_resched() is true and we'll take the loop in
  6912		 * schedule(). The next pick is obviously going to be the stop task
  6913		 * which is_per_cpu_kthread() and will push this task away.
  6914		 */
  6915		raw_spin_lock(&rq->lock);
  6916	}
  6917	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581414EA6B5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 06:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiC2Evm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 00:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiC2Evj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 00:51:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AECDF4B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 21:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648529397; x=1680065397;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fE8T8+OF3nlyzvigsZn0OhCxH8BVRICMlnryBTAXd1Q=;
  b=enZCPsry6GpDZJZ+Lw7BRn8/M/iDapIaL0fn/fJXq78/WsYHckMxCNCB
   5UwOb5zp8VbogrnPkGpN/KLVQfxJAdkT9wiiwRJHGJ0YyX4wblzxfzo86
   Quv7+kx68+Wj8XNzM+QgPmPIOd1EtxDjAFnhmoDuk00v5fzpTnHGNplTm
   ZyGqmdRGoW72KOSi/gKnoB9F9n4FIjqyzwXkICtHy1zqFkci/DXNSdlgF
   avFE/d0sLw2VlCym/nJziqXvTi9d8Rfl7YVUHQl26UyJ3gxuyxy/uTYh/
   buXh4aT5IOKlA28lhLINf6q6rLwnbzn8/js6ld3hkBH4PA08WfDSO1MJO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="246650327"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="246650327"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 21:49:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="719379472"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 28 Mar 2022 21:49:55 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZ3nm-0002f6-Rc; Tue, 29 Mar 2022 04:49:54 +0000
Date:   Tue, 29 Mar 2022 12:49:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rick Yiu <rickyiu@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.10
 9999/9999] kernel/sched/pelt.c:220:5: warning: no previous prototype for
 '___update_load_sum'
Message-ID: <202203291253.hHVqFjjU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.10
head:   e3356ca0a6c24e1ccdde6e9f80875701218ab090
commit: e3356ca0a6c24e1ccdde6e9f80875701218ab090 [9999/9999] ANDROID: sched: Add vendor hook for util-update related functions
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220329/202203291253.hHVqFjjU-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/e3356ca0a6c24e1ccdde6e9f80875701218ab090
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.10
        git checkout e3356ca0a6c24e1ccdde6e9f80875701218ab090
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/sched/pelt.c:220:5: warning: no previous prototype for '___update_load_sum' [-Wmissing-prototypes]
     220 | int ___update_load_sum(u64 now, struct sched_avg *sa,
         |     ^~~~~~~~~~~~~~~~~~
>> kernel/sched/pelt.c:297:6: warning: no previous prototype for '___update_load_avg' [-Wmissing-prototypes]
     297 | void ___update_load_avg(struct sched_avg *sa, unsigned long load)
         |      ^~~~~~~~~~~~~~~~~~


vim +/___update_load_sum +220 kernel/sched/pelt.c

   191	
   192	/*
   193	 * We can represent the historical contribution to runnable average as the
   194	 * coefficients of a geometric series.  To do this we sub-divide our runnable
   195	 * history into segments of approximately 1ms (1024us); label the segment that
   196	 * occurred N-ms ago p_N, with p_0 corresponding to the current period, e.g.
   197	 *
   198	 * [<- 1024us ->|<- 1024us ->|<- 1024us ->| ...
   199	 *      p0            p1           p2
   200	 *     (now)       (~1ms ago)  (~2ms ago)
   201	 *
   202	 * Let u_i denote the fraction of p_i that the entity was runnable.
   203	 *
   204	 * We then designate the fractions u_i as our co-efficients, yielding the
   205	 * following representation of historical load:
   206	 *   u_0 + u_1*y + u_2*y^2 + u_3*y^3 + ...
   207	 *
   208	 * We choose y based on the with of a reasonably scheduling period, fixing:
   209	 *   y^32 = 0.5
   210	 *
   211	 * This means that the contribution to load ~32ms ago (u_32) will be weighted
   212	 * approximately half as much as the contribution to load within the last ms
   213	 * (u_0).
   214	 *
   215	 * When a period "rolls over" and we have new u_0`, multiplying the previous
   216	 * sum again by y is sufficient to update:
   217	 *   load_avg = u_0` + y*(u_0 + u_1*y + u_2*y^2 + ... )
   218	 *            = u_0 + u_1*y + u_2*y^2 + ... [re-labeling u_i --> u_{i+1}]
   219	 */
 > 220	int ___update_load_sum(u64 now, struct sched_avg *sa,
   221			       unsigned long load, unsigned long runnable, int running)
   222	{
   223		u64 delta;
   224	
   225		delta = now - sa->last_update_time;
   226		/*
   227		 * This should only happen when time goes backwards, which it
   228		 * unfortunately does during sched clock init when we swap over to TSC.
   229		 */
   230		if ((s64)delta < 0) {
   231			sa->last_update_time = now;
   232			return 0;
   233		}
   234	
   235		/*
   236		 * Use 1024ns as the unit of measurement since it's a reasonable
   237		 * approximation of 1us and fast to compute.
   238		 */
   239		delta >>= 10;
   240		if (!delta)
   241			return 0;
   242	
   243		sa->last_update_time += delta << 10;
   244	
   245		/*
   246		 * running is a subset of runnable (weight) so running can't be set if
   247		 * runnable is clear. But there are some corner cases where the current
   248		 * se has been already dequeued but cfs_rq->curr still points to it.
   249		 * This means that weight will be 0 but not running for a sched_entity
   250		 * but also for a cfs_rq if the latter becomes idle. As an example,
   251		 * this happens during idle_balance() which calls
   252		 * update_blocked_averages().
   253		 *
   254		 * Also see the comment in accumulate_sum().
   255		 */
   256		if (!load)
   257			runnable = running = 0;
   258	
   259		/*
   260		 * Now we know we crossed measurement unit boundaries. The *_avg
   261		 * accrues by two steps:
   262		 *
   263		 * Step 1: accumulate *_sum since last_update_time. If we haven't
   264		 * crossed period boundaries, finish.
   265		 */
   266		if (!accumulate_sum(delta, sa, load, runnable, running))
   267			return 0;
   268	
   269		return 1;
   270	}
   271	EXPORT_SYMBOL_GPL(___update_load_sum);
   272	
   273	/*
   274	 * When syncing *_avg with *_sum, we must take into account the current
   275	 * position in the PELT segment otherwise the remaining part of the segment
   276	 * will be considered as idle time whereas it's not yet elapsed and this will
   277	 * generate unwanted oscillation in the range [1002..1024[.
   278	 *
   279	 * The max value of *_sum varies with the position in the time segment and is
   280	 * equals to :
   281	 *
   282	 *   LOAD_AVG_MAX*y + sa->period_contrib
   283	 *
   284	 * which can be simplified into:
   285	 *
   286	 *   LOAD_AVG_MAX - 1024 + sa->period_contrib
   287	 *
   288	 * because LOAD_AVG_MAX*y == LOAD_AVG_MAX-1024
   289	 *
   290	 * The same care must be taken when a sched entity is added, updated or
   291	 * removed from a cfs_rq and we need to update sched_avg. Scheduler entities
   292	 * and the cfs rq, to which they are attached, have the same position in the
   293	 * time segment because they use the same clock. This means that we can use
   294	 * the period_contrib of cfs_rq when updating the sched_avg of a sched_entity
   295	 * if it's more convenient.
   296	 */
 > 297	void ___update_load_avg(struct sched_avg *sa, unsigned long load)
   298	{
   299		u32 divider = get_pelt_divider(sa);
   300	
   301		/*
   302		 * Step 2: update *_avg.
   303		 */
   304		sa->load_avg = div_u64(load * sa->load_sum, divider);
   305		sa->runnable_avg = div_u64(sa->runnable_sum, divider);
   306		WRITE_ONCE(sa->util_avg, sa->util_sum / divider);
   307	}
   308	EXPORT_SYMBOL_GPL(___update_load_avg);
   309	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

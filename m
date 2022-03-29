Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B60E4EA7D2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 08:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiC2GYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 02:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiC2GYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:24:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CF82487AB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 23:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648534981; x=1680070981;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jH8lK4wm4s104d0EZM6nlnG5qbED2yGtvQreJbYlw/M=;
  b=lKvflQjPY4eQVJJNZTJ/qiqvQ2WE3iJblK5ul6CHmz9LfoNNCRvIBW74
   a4yUaH63L679/LkvVGOwXCq/P9UwCw1tvwRKTtFkaxzN7272fNvldK3dD
   W7RAXLjLEndx4VAHC7aWzR8U/coqZIarPPvJMCgPtXQIlo4H4gxyzXQQ5
   vWneu7n3Qs1lPTTIuvkY27gG5ar/pAAhmdZxQmrtC2AVpYdgM1CkCoZNh
   pp5q026KKK2HFkw8y6/Uhjj7tSytZJFumgQCnF0uBF6c2Sa+KsgT76mt6
   /IHneYMUXjJ7wjk3lcfW9vqeSZFnIDvnQP8z8Aytg0JTV3OMZHqvChuaI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="259143062"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="259143062"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 23:23:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="719402093"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 28 Mar 2022 23:22:58 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZ5Fq-0002jo-3C; Tue, 29 Mar 2022 06:22:58 +0000
Date:   Tue, 29 Mar 2022 14:22:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rick Yiu <rickyiu@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.10
 9999/9999] kernel/sched/pelt.c:220:5: warning: no previous prototype for
 function '___update_load_sum'
Message-ID: <202203291453.o1x3SHpH-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.10
head:   e3356ca0a6c24e1ccdde6e9f80875701218ab090
commit: e3356ca0a6c24e1ccdde6e9f80875701218ab090 [9999/9999] ANDROID: sched: Add vendor hook for util-update related functions
config: arm64-randconfig-r032-20220327 (https://download.01.org/0day-ci/archive/20220329/202203291453.o1x3SHpH-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/e3356ca0a6c24e1ccdde6e9f80875701218ab090
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.10
        git checkout e3356ca0a6c24e1ccdde6e9f80875701218ab090
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/sched/pelt.c:220:5: warning: no previous prototype for function '___update_load_sum' [-Wmissing-prototypes]
   int ___update_load_sum(u64 now, struct sched_avg *sa,
       ^
   kernel/sched/pelt.c:220:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int ___update_load_sum(u64 now, struct sched_avg *sa,
   ^
   static 
>> kernel/sched/pelt.c:297:6: warning: no previous prototype for function '___update_load_avg' [-Wmissing-prototypes]
   void ___update_load_avg(struct sched_avg *sa, unsigned long load)
        ^
   kernel/sched/pelt.c:297:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void ___update_load_avg(struct sched_avg *sa, unsigned long load)
   ^
   static 
   2 warnings generated.


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

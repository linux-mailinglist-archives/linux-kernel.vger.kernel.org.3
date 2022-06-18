Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DABB55022B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 04:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383975AbiFRCxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 22:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383974AbiFRCxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 22:53:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D2919C3D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 19:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655520785; x=1687056785;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zuPEmyO8eYY7zSXxbbfC5HUCoHoNIGO/jbMLdKiwzw4=;
  b=ZI8gfojF39jdVErijMQBabO0ohtyRSwRL6bC9fN5nox4/oDvh+hNLORK
   IKgYm9YdPT8LMP/gYmA7Tu09L/jGV3ltSy8irI4maVM8rXGt34txu0jB9
   6/101budwFBZDpmYTfrc0RcFX2NrTwOs7w6lkJwqycm1142W/LF69SXxY
   SWaCWtG4lkJr1++FZZlqsdzUlUmgDHnYWCgtetdgZjD6m3MD6TEzX3ORj
   4NJVXZ01EXVbfi5gtBn8dLkXpMAB4hFY+fiPyVhSd7zOPiA42LWCdYFn8
   oH/jbtCU/BiOoiPEGnb0m453ATkc0uKKgQBhEE18zwt6eodCQnTLd0SI2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="278396802"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="278396802"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 19:53:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="579652596"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 17 Jun 2022 19:53:02 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2Oa5-000PxH-RN;
        Sat, 18 Jun 2022 02:53:01 +0000
Date:   Sat, 18 Jun 2022 10:52:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [jsarha:topic/cros-sof-v4.14-rebase 1524/9999]
 drivers/cpuidle/governors/menu.c:418 menu_select() warn: inconsistent
 indenting
Message-ID: <202206181048.YmvaXnUu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.14-rebase
head:   18a233f3f676a98dde00947535d99ab1a54da340
commit: 308c4300425e678cc31b75bdc9e38e7f886bcb2b [1524/9999] UPSTREAM: cpuidle: menu: Refine idle state selection for running tick
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220618/202206181048.YmvaXnUu-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/cpuidle/governors/menu.c:418 menu_select() warn: inconsistent indenting

vim +418 drivers/cpuidle/governors/menu.c

   278	
   279	/**
   280	 * menu_select - selects the next idle state to enter
   281	 * @drv: cpuidle driver containing state data
   282	 * @dev: the CPU
   283	 * @stop_tick: indication on whether or not to stop the tick
   284	 */
   285	static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
   286			       bool *stop_tick)
   287	{
   288		struct menu_device *data = this_cpu_ptr(&menu_devices);
   289		struct device *device = get_cpu_device(dev->cpu);
   290		int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
   291		int i;
   292		int first_idx;
   293		int idx;
   294		unsigned int interactivity_req;
   295		unsigned int expected_interval;
   296		unsigned long nr_iowaiters, cpu_load;
   297		int resume_latency = dev_pm_qos_raw_read_value(device);
   298		ktime_t delta_next;
   299	
   300		if (data->needs_update) {
   301			menu_update(drv, dev);
   302			data->needs_update = 0;
   303		}
   304	
   305		/* resume_latency is 0 means no restriction */
   306		if (resume_latency && resume_latency < latency_req)
   307			latency_req = resume_latency;
   308	
   309		/* Special case when user has set very strict latency requirement */
   310		if (unlikely(latency_req == 0)) {
   311			*stop_tick = false;
   312			return 0;
   313		}
   314	
   315		/* determine the expected residency time, round up */
   316		data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
   317	
   318		get_iowait_load(&nr_iowaiters, &cpu_load);
   319		data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
   320	
   321		/*
   322		 * Force the result of multiplication to be 64 bits even if both
   323		 * operands are 32 bits.
   324		 * Make sure to round up for half microseconds.
   325		 */
   326		data->predicted_us = DIV_ROUND_CLOSEST_ULL((uint64_t)data->next_timer_us *
   327						 data->correction_factor[data->bucket],
   328						 RESOLUTION * DECAY);
   329	
   330		expected_interval = get_typical_interval(data);
   331		expected_interval = min(expected_interval, data->next_timer_us);
   332	
   333		first_idx = 0;
   334		if (drv->states[0].flags & CPUIDLE_FLAG_POLLING) {
   335			struct cpuidle_state *s = &drv->states[1];
   336			unsigned int polling_threshold;
   337	
   338			/*
   339			 * We want to default to C1 (hlt), not to busy polling
   340			 * unless the timer is happening really really soon, or
   341			 * C1's exit latency exceeds the user configured limit.
   342			 */
   343			polling_threshold = max_t(unsigned int, 20, s->target_residency);
   344			if (data->next_timer_us > polling_threshold &&
   345			    latency_req > s->exit_latency && !s->disabled &&
   346			    !dev->states_usage[1].disable)
   347				first_idx = 1;
   348		}
   349	
   350		/*
   351		 * Use the lowest expected idle interval to pick the idle state.
   352		 */
   353		data->predicted_us = min(data->predicted_us, expected_interval);
   354	
   355		/*
   356		 * Use the performance multiplier and the user-configurable
   357		 * latency_req to determine the maximum exit latency.
   358		 */
   359		interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
   360		if (latency_req > interactivity_req)
   361			latency_req = interactivity_req;
   362	
   363		expected_interval = data->predicted_us;
   364		/*
   365		 * Find the idle state with the lowest power while satisfying
   366		 * our constraints.
   367		 */
   368		idx = -1;
   369		for (i = first_idx; i < drv->state_count; i++) {
   370			struct cpuidle_state *s = &drv->states[i];
   371			struct cpuidle_state_usage *su = &dev->states_usage[i];
   372	
   373			if (s->disabled || su->disable)
   374				continue;
   375			if (idx == -1)
   376				idx = i; /* first enabled state */
   377			if (s->target_residency > data->predicted_us)
   378				break;
   379			if (s->exit_latency > latency_req) {
   380				/*
   381				 * If we break out of the loop for latency reasons, use
   382				 * the target residency of the selected state as the
   383				 * expected idle duration so that the tick is retained
   384				 * as long as that target residency is low enough.
   385				 */
   386				expected_interval = drv->states[idx].target_residency;
   387				break;
   388			}
   389			idx = i;
   390		}
   391	
   392		if (idx == -1)
   393			idx = 0; /* No states enabled. Must use 0. */
   394	
   395		/*
   396		 * Don't stop the tick if the selected state is a polling one or if the
   397		 * expected idle duration is shorter than the tick period length.
   398		 */
   399		if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
   400		    expected_interval < TICK_USEC) {
   401			unsigned int delta_next_us = ktime_to_us(delta_next);
   402	
   403			*stop_tick = false;
   404	
   405			if (!tick_nohz_tick_stopped() && idx > 0 &&
   406			    drv->states[idx].target_residency > delta_next_us) {
   407				/*
   408				 * The tick is not going to be stopped and the target
   409				 * residency of the state to be returned is not within
   410				 * the time until the next timer event including the
   411				 * tick, so try to correct that.
   412				 */
   413				for (i = idx - 1; i >= 0; i--) {
   414				    if (drv->states[i].disabled ||
   415				        dev->states_usage[i].disable)
   416						continue;
   417	
 > 418					idx = i;
   419					if (drv->states[i].target_residency <= delta_next_us)
   420						break;
   421				}
   422			}
   423		}
   424	
   425		data->last_state_idx = idx;
   426	
   427		return data->last_state_idx;
   428	}
   429	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

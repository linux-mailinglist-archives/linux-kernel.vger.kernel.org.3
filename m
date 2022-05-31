Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E4F539954
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 00:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348226AbiEaWFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 18:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243412AbiEaWFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:05:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE029B1B0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 15:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654034730; x=1685570730;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GLTEccP2tod58Wa6O71k2ppOxftaIENVQo7iDOa2bBU=;
  b=dY8IN3g2PDjCYn/tudqoWe6rUscJAEgS/Vm/kbHX1w4yTvo4i+/CnQBT
   ST+Ag1Xd9WH32HEVsevbX1sb0HgfU+lIO9RnBvIf377hLRiwZlaNLrqjw
   T3Ge6juUfOfLHhb1wyT7K35EuCoK42XXifihR9yEtzuf94z1oc3iIOnO9
   mX2oOD75HbgUxkg744rUhnQGqKPxtskX+PSfCKEv9ftvY8Cb+BdWHf/PJ
   IrF+98Y6VFnpm9uRMt//BS3HSWHQNU2Ys9uBe6tSiR/nao84pl2+x1yKx
   cfNJKdLB29FTW38vexkde6pTTKuvhMODytH8cTi7VvME/dXBHQY+Z4Hdx
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="275479817"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="275479817"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 15:05:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="529786543"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 31 May 2022 15:05:28 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nw9zT-00038W-Sw;
        Tue, 31 May 2022 22:05:27 +0000
Date:   Wed, 1 Jun 2022 06:04:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:perf/wip.cleanup 9/10]
 arch/x86/events/intel/core.c:2841:28: error: 'struct hw_perf_event' has no
 member named 'indx'; did you mean 'idx'?
Message-ID: <202206010539.5AhXIxwi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/wip.cleanup
head:   7e88da7861a18513ec10118c915d6886a916587b
commit: b1e1e07adc4ce6fc0c484ffa3fa718bc7ff144f6 [9/10] perf/x86/intel: Optimize short PEBS counters
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220601/202206010539.5AhXIxwi-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=b1e1e07adc4ce6fc0c484ffa3fa718bc7ff144f6
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue perf/wip.cleanup
        git checkout b1e1e07adc4ce6fc0c484ffa3fa718bc7ff144f6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/events/intel/core.c: In function 'intel_pmu_handle_short_pebs':
>> arch/x86/events/intel/core.c:2841:28: error: 'struct hw_perf_event' has no member named 'indx'; did you mean 'idx'?
    2841 |         if (!test_bit(hwc->indx, cpuc->active_mask))
         |                            ^~~~
         |                            idx


vim +2841 arch/x86/events/intel/core.c

  2834	
  2835	static void intel_pmu_handle_short_pebs(struct perf_event *event)
  2836	{
  2837		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
  2838		struct hw_perf_event *hwc = &event->hw;
  2839	
  2840		/* if the event is not enabled; intel_pmu_pebs_enable() DTRT */
> 2841		if (!test_bit(hwc->indx, cpuc->active_mask))
  2842			return;
  2843	
  2844		WARN_ON_ONCE(cpuc->enabled);
  2845	
  2846		if (intel_pmu_is_short_pebs(event)) {
  2847	
  2848			/* stripped down intel_pmu_pebs_disable() */
  2849			cpuc->pebs_enabled &= ~(1ULL << hwc->idx);
  2850			hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
  2851	
  2852			intel_pmu_update_config(event);
  2853	
  2854		} else if (!(cpuc->pebs_enabled & (1ULL << hwc->idx))) {
  2855	
  2856			/* stripped down intel_pmu_pebs_enable() */
  2857			hwc->config &= ~ARCH_PERFMON_EVENTSEL_INT;
  2858			cpuc->pebs_enabled |= (1ULL << hwc->idx);
  2859	
  2860			intel_pmu_update_config(event);
  2861		}
  2862	}
  2863	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

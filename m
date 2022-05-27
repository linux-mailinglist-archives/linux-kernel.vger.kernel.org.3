Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDB453686F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 23:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354726AbiE0V12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 17:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbiE0V1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 17:27:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8D0663E7
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 14:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653686843; x=1685222843;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=idr9u9D8DYGWWA6IpXmUHs7VDuavvV+0TFf4SMnnYQU=;
  b=brV2DqLPyg/ypc6x32oUehzAIelznFtNkztrhm2CM6kCD/EFRBc4RykX
   zbN8ou1pBz8sWlNi8SqVINkugvfMZzMUP1kxDEBXbs1Euj3uwMk2Rahal
   CGlr/ZuSEpn+SfqVKQdGuTUrXr3IdWZA8PGsKLO55s873/3ZfnMHBIImE
   BASwa1gfiJrROQsRPW/uyOWncKirZMtPNG7CXN5basG2U6ZiymLG9jkDM
   RZxBv74X8AuDQmrRJg2dmadnS4fDR+/dMLYvJ4MyzzPTqBau0dkYbwZjf
   qSC9sGDA2BDCUjkrKOK82Fi3NRUo6FdcFH6PbHlJRsyRrSBhzcyAKinKN
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="360965422"
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="360965422"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 14:27:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="610527978"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 May 2022 14:27:21 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuhUO-00059H-Pg;
        Fri, 27 May 2022 21:27:20 +0000
Date:   Sat, 28 May 2022 05:26:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:perf/wip.cleanup 9/10]
 arch/x86/events/intel/core.c:2841:33: error: invalid operands to binary &
 (have 'long unsigned int *' and 'long long unsigned int')
Message-ID: <202205280542.Let1ciha-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/wip.cleanup
head:   81b127cf734295445d2b31328e951d229dd1e961
commit: 134b7aa4469b0f1f382548c52ced29367f9f0c7a [9/10] perf/x86/intel: Optimize short PEBS counters
config: x86_64-rhel-8.3-kunit (https://download.01.org/0day-ci/archive/20220528/202205280542.Let1ciha-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=134b7aa4469b0f1f382548c52ced29367f9f0c7a
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue perf/wip.cleanup
        git checkout 134b7aa4469b0f1f382548c52ced29367f9f0c7a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/events/intel/core.c: In function 'intel_pmu_handle_short_pebs':
>> arch/x86/events/intel/core.c:2841:33: error: invalid operands to binary & (have 'long unsigned int *' and 'long long unsigned int')
    2841 |         if (!(cpuc->active_mask & (1ULL << hwc->idx)))
         |               ~~~~              ^ ~~~~~~~~~~~~~~~~~~
         |               |                         |
         |               long unsigned int *       long long unsigned int


vim +2841 arch/x86/events/intel/core.c

  2834	
  2835	static void intel_pmu_handle_short_pebs(struct perf_event *event)
  2836	{
  2837		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
  2838		struct hw_perf_event *hwc = &event->hw;
  2839	
  2840		/* if the event is not enabled; intel_pmu_pebs_enable() DTRT */
> 2841		if (!(cpuc->active_mask & (1ULL << hwc->idx)))
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

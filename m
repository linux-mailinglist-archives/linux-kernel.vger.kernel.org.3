Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095605389E0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 04:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243538AbiEaCO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 22:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbiEaCOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 22:14:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CD592D3E
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 19:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653963292; x=1685499292;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FWVmcsxA2ui4raYa9LzBDvzmY+HcdfFqPCQKmRv4j1M=;
  b=EY5KlbJlFkH+THeF6d9BZM3ytpjgP+oOh92GQH3fOJv9ZiVjeAtH5VLl
   Vsfc4SHahUiou1EbqEEkd3uLyIWibLBlXU12GwM+LB2w/sJXFOnIC5+P3
   xj/P1wjlFt/+serXVl4GwNBKUSBRh2eY2fseAbE3Dguam/UzvbUOUZdaK
   +ZWOCAQEsZ8+E2R/QA/lhtH42SJPBD2Bbrm6gJqrKYilYpMeyIHnmRbW9
   MBXoDxn4pE22ISVLG1OBagsSdUbRo1maaJYeMGyEX2FdoVRMpa185nH+F
   gCWrzxEN3iRRbp5fFe/8Q6fI4Rpstd+E+HAwla+ER4GJDwUKoAIlLFpN3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="254987977"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="254987977"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 19:14:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="823059146"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 30 May 2022 19:14:51 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvrPG-0002De-Fm;
        Tue, 31 May 2022 02:14:50 +0000
Date:   Tue, 31 May 2022 10:14:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:perf/wip.cleanup 9/10]
 arch/x86/events/intel/core.c:2841:33: error: invalid operands to binary &
 (have 'long unsigned int *' and 'long long unsigned int')
Message-ID: <202205311009.FeTWYwId-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/wip.cleanup
head:   d096f17be1e500e9b733118925230e46b4c3a14c
commit: be787b9861afcf5c89dd697a71367a3b6aae6dca [9/10] perf/x86/intel: Optimize short PEBS counters
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220531/202205311009.FeTWYwId-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=be787b9861afcf5c89dd697a71367a3b6aae6dca
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue perf/wip.cleanup
        git checkout be787b9861afcf5c89dd697a71367a3b6aae6dca
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

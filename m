Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B42D5389E6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 04:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243587AbiEaCY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 22:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243571AbiEaCYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 22:24:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7713A9345C
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 19:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653963894; x=1685499894;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aR0PHKL++ulIC/jYDhmlRB/ENp4XVEkPyXmnkAx4ymI=;
  b=ULdvquEwe5UPJgHkHBe2Abi2AwcFsQ6YyfVEDoaTcZCvm13da6K9ZCp4
   i7l5lQoMuFvwInB6mjLSwfbxgHWmJItV1Ehj5+1TqAttdB01oaKyVwFDZ
   BJrz7VyAFTnKwNq273JMnlWNQkNaN4sHRO2upiKpa9C5QIOF3QBEcfqBN
   uP/ry1G0fFdylcIKnWqLPv9axcpG/8tz1guWBzSvjLKLiEn+smNA1WyAu
   dtMkk8Jddl7ObHyTuwKMLMm3th4tmS/PvZURWJmLouiBAEoR9yM9EwZdW
   FfqRmFYjkBW9eqfaCeFxPay8RhZOkcBO3Lmkz+DFYy4UsduSDHqPgKBxX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="361493421"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="361493421"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 19:24:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="753612812"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 30 May 2022 19:24:51 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvrYw-0002Dy-PS;
        Tue, 31 May 2022 02:24:50 +0000
Date:   Tue, 31 May 2022 10:24:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [peterz-queue:perf/wip.cleanup 9/10]
 arch/x86/events/intel/core.c:2841:26: error: invalid operands to binary
 expression ('unsigned long[1]' and 'unsigned long long')
Message-ID: <202205311016.hS64MKjw-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/wip.cleanup
head:   d096f17be1e500e9b733118925230e46b4c3a14c
commit: be787b9861afcf5c89dd697a71367a3b6aae6dca [9/10] perf/x86/intel: Optimize short PEBS counters
config: x86_64-randconfig-a011-20220530 (https://download.01.org/0day-ci/archive/20220531/202205311016.hS64MKjw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0776c48f9b7e69fa447bee57c7c0985caa856be9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=be787b9861afcf5c89dd697a71367a3b6aae6dca
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue perf/wip.cleanup
        git checkout be787b9861afcf5c89dd697a71367a3b6aae6dca
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/events/intel/core.c:2841:26: error: invalid operands to binary expression ('unsigned long[1]' and 'unsigned long long')
           if (!(cpuc->active_mask & (1ULL << hwc->idx)))
                 ~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~
   1 error generated.


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

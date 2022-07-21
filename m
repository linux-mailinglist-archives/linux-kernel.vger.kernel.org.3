Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF8057C297
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 05:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiGUDPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 23:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGUDPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 23:15:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C4CE0A4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 20:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658373332; x=1689909332;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iulKdsPgQfFrWl24JS9SnoJbG4Ic0GKj3Ek47eUYTTk=;
  b=W5YrFDHEgYtrRnO1/ZqKtAM1Ks4/PxJFebE7FI02LIoYh7x5mrl0iQtb
   OvFTjJ87hSg0NPDqKtSkiurfgYZicfhKYS/2+nLG+0cH4UAw/eg/cNNc2
   l5PIqDRbrQ/tcM+Ii3t9MziphTH97mOEKtxy0F2kkk5vQVU+EafLVod/z
   vY+pcqBaeqQO3lUM+G0rp8bDUNQ0ExT6uP236s7EV8SpD0j3SWmWqqtXH
   yh421v4yRfFf0lefyZQqKyQFIdyk1d+i5oklnuRQHmt6Idh4GSSxODITU
   RZuB2ND1MvA0Iusvw+qsQx4/aaJlf4UoC89VbpAYRl9pB/EFiuMAQ2TOP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="350926799"
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="350926799"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 20:15:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="573564986"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Jul 2022 20:15:30 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oEMev-0001OD-F9;
        Thu, 21 Jul 2022 03:15:29 +0000
Date:   Thu, 21 Jul 2022 11:15:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [linux-stable-rc:linux-5.10.y 3585/7104]
 drivers/gpu/drm/i915/gt/intel_gt.c:732:2: error: format string is not a
 string literal (potentially insecure)
Message-ID: <202207211126.LnCtB2kQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
head:   024476cf51e88407e84736ff298652322459beb5
commit: 6a6acf927895c38bdd9f3cd76b8dbfc25ac03e88 [3585/7104] drm/i915: Flush TLBs before releasing backing store
config: i386-randconfig-a002-20220718 (https://download.01.org/0day-ci/archive/20220721/202207211126.LnCtB2kQ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project dd5635541cd7bbd62cd59b6694dfb759b6e9a0d8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=6a6acf927895c38bdd9f3cd76b8dbfc25ac03e88
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.10.y
        git checkout 6a6acf927895c38bdd9f3cd76b8dbfc25ac03e88
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/i915/gt/intel_gt.c:732:2: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
           GEM_TRACE("\n");
           ^~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_gem.h:69:24: note: expanded from macro 'GEM_TRACE'
   #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
                          ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:724:3: note: expanded from macro 'trace_printk'
                   do_trace_printk(fmt, ##__VA_ARGS__);    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:738:30: note: expanded from macro 'do_trace_printk'
                   __trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);   \
                                              ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/gt/intel_gt.c:732:2: note: treat the string as an argument to avoid this
   drivers/gpu/drm/i915/i915_gem.h:69:24: note: expanded from macro 'GEM_TRACE'
   #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
                          ^
   include/linux/kernel.h:724:3: note: expanded from macro 'trace_printk'
                   do_trace_printk(fmt, ##__VA_ARGS__);    \
                   ^
   include/linux/kernel.h:738:30: note: expanded from macro 'do_trace_printk'
                   __trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);   \
                                              ^
   1 error generated.


vim +732 drivers/gpu/drm/i915/gt/intel_gt.c

   693	
   694	void intel_gt_invalidate_tlbs(struct intel_gt *gt)
   695	{
   696		static const i915_reg_t gen8_regs[] = {
   697			[RENDER_CLASS]			= GEN8_RTCR,
   698			[VIDEO_DECODE_CLASS]		= GEN8_M1TCR, /* , GEN8_M2TCR */
   699			[VIDEO_ENHANCEMENT_CLASS]	= GEN8_VTCR,
   700			[COPY_ENGINE_CLASS]		= GEN8_BTCR,
   701		};
   702		static const i915_reg_t gen12_regs[] = {
   703			[RENDER_CLASS]			= GEN12_GFX_TLB_INV_CR,
   704			[VIDEO_DECODE_CLASS]		= GEN12_VD_TLB_INV_CR,
   705			[VIDEO_ENHANCEMENT_CLASS]	= GEN12_VE_TLB_INV_CR,
   706			[COPY_ENGINE_CLASS]		= GEN12_BLT_TLB_INV_CR,
   707		};
   708		struct drm_i915_private *i915 = gt->i915;
   709		struct intel_uncore *uncore = gt->uncore;
   710		struct intel_engine_cs *engine;
   711		enum intel_engine_id id;
   712		const i915_reg_t *regs;
   713		unsigned int num = 0;
   714	
   715		if (I915_SELFTEST_ONLY(gt->awake == -ENODEV))
   716			return;
   717	
   718		if (INTEL_GEN(i915) == 12) {
   719			regs = gen12_regs;
   720			num = ARRAY_SIZE(gen12_regs);
   721		} else if (INTEL_GEN(i915) >= 8 && INTEL_GEN(i915) <= 11) {
   722			regs = gen8_regs;
   723			num = ARRAY_SIZE(gen8_regs);
   724		} else if (INTEL_GEN(i915) < 8) {
   725			return;
   726		}
   727	
   728		if (drm_WARN_ONCE(&i915->drm, !num,
   729				  "Platform does not implement TLB invalidation!"))
   730			return;
   731	
 > 732		GEM_TRACE("\n");

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

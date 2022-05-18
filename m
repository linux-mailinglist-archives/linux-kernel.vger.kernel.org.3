Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA4152B065
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 04:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiERCLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 22:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbiERCLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 22:11:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12A952B3B
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 19:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652839906; x=1684375906;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sDi1b/n6+eMEJdLkZx6KM/2L6PvkOIYVb/LPTYgoEPo=;
  b=O2CV7xh1ah7INqbAdzXZ31EfgnuiJfMExXL70VMUOL3QYBhb2JgMxqAx
   klZUUhPTyWI55DTm8oZmfHd4jdxMK1Ve0W1du9AKjlwbMEUPtscLZmp1g
   sAVbQ4vbD1wKGpXhomy8GjKzwsEviviHcm0RcJWk2KVRI1LMPHiGnqFhx
   vQnzqb4odjuNwj+NxzwEim1oYtpx81TkYkLYlYD/yW6Al0m4wvtIZTNwq
   +xDoRtfd9K9hyQb5Pccx2343UwleGIUag7gI1pgrG9hIxGtzD3WMlxQ+a
   1T0gYmfWV/rvfAZLtdWgSEWU+leHuQIe+y/fbWCkvOMbkwh9snHGkIcFO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="253479338"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="253479338"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 19:11:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="700362894"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 17 May 2022 19:11:12 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nr99b-0001gz-FB;
        Wed, 18 May 2022 02:11:11 +0000
Date:   Wed, 18 May 2022 10:10:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [linux-stable-rc:linux-5.4.y 2248/3625]
 drivers/gpu/drm/i915/gt/intel_gt.c:335:2: error: format string is not a
 string literal (potentially insecure)
Message-ID: <202205180933.FHJdKHSI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
head:   25f2e99af01b5b7328f55bbadab563cb26478289
commit: 1b5553c79d52f17e735cd924ff2178a2409e6d0b [2248/3625] drm/i915: Flush TLBs before releasing backing store
config: x86_64-randconfig-r031-20220516 (https://download.01.org/0day-ci/archive/20220518/202205180933.FHJdKHSI-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 853fa8ee225edf2d0de94b0dcbd31bea916e825e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=1b5553c79d52f17e735cd924ff2178a2409e6d0b
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.4.y
        git checkout 1b5553c79d52f17e735cd924ff2178a2409e6d0b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/i915/gt/intel_gt.c:335:2: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
           GEM_TRACE("\n");
           ^~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_gem.h:68:24: note: expanded from macro 'GEM_TRACE'
   #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
                          ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:716:3: note: expanded from macro 'trace_printk'
                   do_trace_printk(fmt, ##__VA_ARGS__);    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:730:30: note: expanded from macro 'do_trace_printk'
                   __trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);   \
                                              ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/gt/intel_gt.c:335:2: note: treat the string as an argument to avoid this
   drivers/gpu/drm/i915/i915_gem.h:68:24: note: expanded from macro 'GEM_TRACE'
   #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
                          ^
   include/linux/kernel.h:716:3: note: expanded from macro 'trace_printk'
                   do_trace_printk(fmt, ##__VA_ARGS__);    \
                   ^
   include/linux/kernel.h:730:30: note: expanded from macro 'do_trace_printk'
                   __trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);   \
                                              ^
   1 error generated.


vim +335 drivers/gpu/drm/i915/gt/intel_gt.c

   297	
   298	void intel_gt_invalidate_tlbs(struct intel_gt *gt)
   299	{
   300		static const i915_reg_t gen8_regs[] = {
   301			[RENDER_CLASS]			= GEN8_RTCR,
   302			[VIDEO_DECODE_CLASS]		= GEN8_M1TCR, /* , GEN8_M2TCR */
   303			[VIDEO_ENHANCEMENT_CLASS]	= GEN8_VTCR,
   304			[COPY_ENGINE_CLASS]		= GEN8_BTCR,
   305		};
   306		static const i915_reg_t gen12_regs[] = {
   307			[RENDER_CLASS]			= GEN12_GFX_TLB_INV_CR,
   308			[VIDEO_DECODE_CLASS]		= GEN12_VD_TLB_INV_CR,
   309			[VIDEO_ENHANCEMENT_CLASS]	= GEN12_VE_TLB_INV_CR,
   310			[COPY_ENGINE_CLASS]		= GEN12_BLT_TLB_INV_CR,
   311		};
   312		struct drm_i915_private *i915 = gt->i915;
   313		struct intel_uncore *uncore = gt->uncore;
   314		struct intel_engine_cs *engine;
   315		enum intel_engine_id id;
   316		const i915_reg_t *regs;
   317		unsigned int num = 0;
   318	
   319		if (I915_SELFTEST_ONLY(gt->awake == -ENODEV))
   320			return;
   321	
   322		if (INTEL_GEN(i915) == 12) {
   323			regs = gen12_regs;
   324			num = ARRAY_SIZE(gen12_regs);
   325		} else if (INTEL_GEN(i915) >= 8 && INTEL_GEN(i915) <= 11) {
   326			regs = gen8_regs;
   327			num = ARRAY_SIZE(gen8_regs);
   328		} else if (INTEL_GEN(i915) < 8) {
   329			return;
   330		}
   331	
   332		if (WARN_ONCE(!num, "Platform does not implement TLB invalidation!"))
   333			return;
   334	
 > 335		GEM_TRACE("\n");

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

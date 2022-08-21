Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5636B59B14C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 04:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbiHUCOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 22:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236549AbiHUCOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 22:14:43 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402161EAC1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 19:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661048081; x=1692584081;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X78ZVW51kkCwee4yfFupe/rwb6/p6rckcmItmL0kifk=;
  b=HDuY+LCwmSwUS9YmjMsjYvHHIeehdOmlFIfe6QMCPk8OMhmRoshidZp+
   fkgaImk+Kq3JZxYb69wgdwCMivHTDLvOnUZqkx+kpadSYi+hXQRhdY1d1
   y1Yf9jIBYeejR0c/zgOZBPd7oW1eQKbH6Xr9VxsAhv83J3kdpLFYYQeLl
   mERQFAtKstMnYYzO08c8RXv7XO4JVkUs74OMo+7GbTZL7LutRGSj4+jS7
   FOFyJ9s6XQsTeZHbm3R21RsmQxVlTsAh36K5eOnWSBQVWk6UHmAMpjtTt
   3MhjLWufdsNueJttr5ko3PMwxtDSR9I0AjYaX5v/ejNZzNsqPJFlk76xZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="272973601"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="272973601"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 19:14:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="559340729"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Aug 2022 19:14:26 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPaTq-0003WP-0T;
        Sun, 21 Aug 2022 02:14:26 +0000
Date:   Sun, 21 Aug 2022 10:13:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [linux-stable-rc:linux-5.15.y 3230/9817]
 drivers/gpu/drm/i915/gt/intel_gt.c:966:2: error: format string is not a
 string literal (potentially insecure)
Message-ID: <202208211050.Lgvya5QM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tvrtko,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   decfb75fa34c3fc79f494f44b36d56d1d744edd5
commit: 8a17a077e7e9ecce25c95dbdb27843d2d6c2f0f7 [3230/9817] drm/i915: Flush TLBs before releasing backing store
config: x86_64-randconfig-r011-20220815 (https://download.01.org/0day-ci/archive/20220821/202208211050.Lgvya5QM-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 6afcc4a459ead8809a0d6d9b4bf7b64bcc13582b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=8a17a077e7e9ecce25c95dbdb27843d2d6c2f0f7
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout 8a17a077e7e9ecce25c95dbdb27843d2d6c2f0f7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/i915/gt/intel_gt.c:966:2: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
           GEM_TRACE("\n");
           ^~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_gem.h:76:24: note: expanded from macro 'GEM_TRACE'
   #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
                          ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:366:3: note: expanded from macro 'trace_printk'
                   do_trace_printk(fmt, ##__VA_ARGS__);    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:380:30: note: expanded from macro 'do_trace_printk'
                   __trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);   \
                                              ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/gt/intel_gt.c:966:2: note: treat the string as an argument to avoid this
   drivers/gpu/drm/i915/i915_gem.h:76:24: note: expanded from macro 'GEM_TRACE'
   #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
                          ^
   include/linux/kernel.h:366:3: note: expanded from macro 'trace_printk'
                   do_trace_printk(fmt, ##__VA_ARGS__);    \
                   ^
   include/linux/kernel.h:380:30: note: expanded from macro 'do_trace_printk'
                   __trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);   \
                                              ^
   1 error generated.


vim +966 drivers/gpu/drm/i915/gt/intel_gt.c

   927	
   928	void intel_gt_invalidate_tlbs(struct intel_gt *gt)
   929	{
   930		static const i915_reg_t gen8_regs[] = {
   931			[RENDER_CLASS]			= GEN8_RTCR,
   932			[VIDEO_DECODE_CLASS]		= GEN8_M1TCR, /* , GEN8_M2TCR */
   933			[VIDEO_ENHANCEMENT_CLASS]	= GEN8_VTCR,
   934			[COPY_ENGINE_CLASS]		= GEN8_BTCR,
   935		};
   936		static const i915_reg_t gen12_regs[] = {
   937			[RENDER_CLASS]			= GEN12_GFX_TLB_INV_CR,
   938			[VIDEO_DECODE_CLASS]		= GEN12_VD_TLB_INV_CR,
   939			[VIDEO_ENHANCEMENT_CLASS]	= GEN12_VE_TLB_INV_CR,
   940			[COPY_ENGINE_CLASS]		= GEN12_BLT_TLB_INV_CR,
   941		};
   942		struct drm_i915_private *i915 = gt->i915;
   943		struct intel_uncore *uncore = gt->uncore;
   944		struct intel_engine_cs *engine;
   945		enum intel_engine_id id;
   946		const i915_reg_t *regs;
   947		unsigned int num = 0;
   948	
   949		if (I915_SELFTEST_ONLY(gt->awake == -ENODEV))
   950			return;
   951	
   952		if (GRAPHICS_VER(i915) == 12) {
   953			regs = gen12_regs;
   954			num = ARRAY_SIZE(gen12_regs);
   955		} else if (GRAPHICS_VER(i915) >= 8 && GRAPHICS_VER(i915) <= 11) {
   956			regs = gen8_regs;
   957			num = ARRAY_SIZE(gen8_regs);
   958		} else if (GRAPHICS_VER(i915) < 8) {
   959			return;
   960		}
   961	
   962		if (drm_WARN_ONCE(&i915->drm, !num,
   963				  "Platform does not implement TLB invalidation!"))
   964			return;
   965	
 > 966		GEM_TRACE("\n");

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69E45390A4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344216AbiEaMXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344204AbiEaMX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:23:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F658FFB4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653999807; x=1685535807;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nL2+Ikam+GBqRnVV+mHEQYa/V/rwiJja/RdNvaJ6QqY=;
  b=NoVKQgkUD30A70ZvU4NHPK5Fpzow8RnNdNyB18WconhoId3Dy/45yMP+
   0tCcV17KdKHHGmbc9+MQM7D9Vw5dGVSSSUKxcKdA9C2C5sMeMOIJSr+uB
   vyc8shrTpTya2xNtRXiprEmdYwdqVL1ygrzN/gIJs88CAUgy+UU/LV3Tf
   q87GUaSmnu+FNZ4d4M+y6C6yb3NulMbhzI/j7ZVkca7LJrIDkCMRJPPOg
   kbzMvM5KcER2Np1sYDKTwV059x4ydRgEd0pjT8UFwwBV+B52fmT8kpJSC
   OLPPI/SLC80M3yLkFKBFhxqv8VzkXBybj7P5IFQJGIynP+xYdCi9cYRt3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="361611400"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="361611400"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 05:23:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="679553332"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 31 May 2022 05:23:10 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nw0ty-0002h9-6Z;
        Tue, 31 May 2022 12:23:10 +0000
Date:   Tue, 31 May 2022 20:22:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [stable:linux-5.15.y 3230/6856]
 drivers/gpu/drm/i915/gt/intel_gt.c:966:2: error: format string is not a
 string literal (potentially insecure)
Message-ID: <202205312043.eacilUVl-lkp@intel.com>
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

Hi Tvrtko,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
head:   4e67be407725b1d8b829ed2075987037abec98ec
commit: 8a17a077e7e9ecce25c95dbdb27843d2d6c2f0f7 [3230/6856] drm/i915: Flush TLBs before releasing backing store
config: x86_64-randconfig-a014-20220530 (https://download.01.org/0day-ci/archive/20220531/202205312043.eacilUVl-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0776c48f9b7e69fa447bee57c7c0985caa856be9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=8a17a077e7e9ecce25c95dbdb27843d2d6c2f0f7
        git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
        git fetch --no-tags stable linux-5.15.y
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

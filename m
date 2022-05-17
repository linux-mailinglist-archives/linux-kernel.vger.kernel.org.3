Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6285296DD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 03:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbiEQBmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 21:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237129AbiEQBmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 21:42:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9EC45ACA
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 18:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652751721; x=1684287721;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jC8CasluGEzTR24qDOd2wFlDjfT6+GpR14ulY4IaFUQ=;
  b=GFZ4Ho3AagR//mF1nz1rbmBfe5p1c+9niXnhsOKeeqfqM7qBQVV+gx5/
   8mi816pqCzxgy95hx07IyQNuvWXAYVdMZiPR/FWsp3MK6TrIOw+h3PbdU
   pz85x7sCzrcnRxGyDxXp5A00p0xqHRFuwCJ+gk3xRcufzHlcHVykqicvi
   yORcyCBCPY+/f4ZJ4ibWaeOAYTc0o4R0b4rVkP1UBujd4O2XeVaL1mcok
   0csUdp0vlCg2e77kQKFFTobbTdUo1/JqLYBYYFkhW6Ev13S16jVYZV3Fu
   ZxR9DfeV/pRtnO71/FK5zNxIHRCv4bz7/SwatYWvQxcsyVsq5+ylqH8jD
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="258581312"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="258581312"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 18:42:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="544637724"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 May 2022 18:41:59 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqmDm-0000Tk-S9;
        Tue, 17 May 2022 01:41:58 +0000
Date:   Tue, 17 May 2022 09:41:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [linux-stable-rc:linux-5.15.y 3230/6576]
 drivers/gpu/drm/i915/gt/intel_gt.c:966:2: error: format string is not a
 string literal (potentially insecure)
Message-ID: <202205170906.EotxYXVJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tvrtko,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   4aa8770e7dfca33d694a86ec8fc85900ada99c26
commit: 8a17a077e7e9ecce25c95dbdb27843d2d6c2f0f7 [3230/6576] drm/i915: Flush TLBs before releasing backing store
config: x86_64-randconfig-r031-20220516 (https://download.01.org/0day-ci/archive/20220517/202205170906.EotxYXVJ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 853fa8ee225edf2d0de94b0dcbd31bea916e825e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=8a17a077e7e9ecce25c95dbdb27843d2d6c2f0f7
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout 8a17a077e7e9ecce25c95dbdb27843d2d6c2f0f7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag as appropriate
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

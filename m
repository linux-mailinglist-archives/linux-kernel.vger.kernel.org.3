Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56EC5025E5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350781AbiDOGzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241069AbiDOGzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:55:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E3AB6444
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650005590; x=1681541590;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GlgB78Vxt7cNey9ECop60fQY0mVinshCTBVsHQ/wSuo=;
  b=M2IxiRm12Nn6ljARt9B6yc6Wbit7We5D25espL2ewDk/ac7LqJHMpe0c
   0KRMYUoIbKHtgLLciy7Qzulg1lBLC2c/yVuUb8Mbq2ke0qHMZ9bg+8Ekh
   +oJX/6sLqAoQAI2hP3H1hOLi/QHyJG+xMNhZA8xjnqdlo+8eyKGxhK9y0
   29W9A2emuHEjbuhzoJT8MlUXp8d19FcwkQHPcVNLOQdLYdVSVzXPWE0A8
   1MAsnr9ychiiI8HHwS7nh2CbxJdOLJmzzoX6GEosW7JnmcN8Qh8MW5PYC
   lZ9y+IZYbJXVZLzxrIu8tEZrdWyv287kpb1MygTgF1LAY2yo2s/1pgljZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="262549956"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="262549956"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 23:53:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="560473421"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 14 Apr 2022 23:53:06 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfFpJ-0001fl-He;
        Fri, 15 Apr 2022 06:53:05 +0000
Date:   Fri, 15 Apr 2022 14:52:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mahesh Kumar <mahesh1.kumar@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Shashank Sharma <shashank.sharma@intel.com>,
        Vidya Srinivas <vidya.srinivas@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Carlos Santa <carlos.santa@intel.com>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.14-rebase 2219/9999]
 drivers/gpu/drm/i915/intel_pm.c:5103:25: error: variable 'crtc' set but not
 used
Message-ID: <202204151416.NqZgp8Zo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mahesh,

FYI, the error/warning still remains.

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.14-rebase
head:   18a233f3f676a98dde00947535d99ab1a54da340
commit: f3f74d31fd569a167450cb3845589755aa39e989 [2219/9999] UPSTREAM: drm/i915/skl: split skl_compute_ddb function
config: i386-randconfig-a011-20220411 (https://download.01.org/0day-ci/archive/20220415/202204151416.NqZgp8Zo-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/jsarha/linux/commit/f3f74d31fd569a167450cb3845589755aa39e989
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.14-rebase
        git checkout f3f74d31fd569a167450cb3845589755aa39e989
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/i915/intel_pm.c: In function 'pipes_modified':
   drivers/gpu/drm/i915/intel_pm.c:4982:25: error: variable 'cstate' set but not used [-Werror=unused-but-set-variable]
     struct drm_crtc_state *cstate;
                            ^~~~~~
   drivers/gpu/drm/i915/intel_pm.c: In function 'skl_print_wm_changes':
   drivers/gpu/drm/i915/intel_pm.c:5069:31: error: variable 'cstate' set but not used [-Werror=unused-but-set-variable]
     const struct drm_crtc_state *cstate;
                                  ^~~~~~
   drivers/gpu/drm/i915/intel_pm.c: In function 'skl_ddb_add_affected_pipes':
   drivers/gpu/drm/i915/intel_pm.c:5104:31: error: variable 'cstate' set but not used [-Werror=unused-but-set-variable]
     const struct drm_crtc_state *cstate;
                                  ^~~~~~
>> drivers/gpu/drm/i915/intel_pm.c:5103:25: error: variable 'crtc' set but not used [-Werror=unused-but-set-variable]
     const struct drm_crtc *crtc;
                            ^~~~
   cc1: all warnings being treated as errors


vim +/crtc +5103 drivers/gpu/drm/i915/intel_pm.c

  5097	
  5098	static int
  5099	skl_ddb_add_affected_pipes(struct drm_atomic_state *state, bool *changed)
  5100	{
  5101		struct drm_device *dev = state->dev;
  5102		const struct drm_i915_private *dev_priv = to_i915(dev);
> 5103		const struct drm_crtc *crtc;
  5104		const struct drm_crtc_state *cstate;
  5105		struct intel_crtc *intel_crtc;
  5106		struct intel_atomic_state *intel_state = to_intel_atomic_state(state);
  5107		uint32_t realloc_pipes = pipes_modified(state);
  5108		int ret, i;
  5109	
  5110		/*
  5111		 * When we distrust bios wm we always need to recompute to set the
  5112		 * expected DDB allocations for each CRTC.
  5113		 */
  5114		if (dev_priv->wm.distrust_bios_wm)
  5115			(*changed) = true;
  5116	
  5117		/*
  5118		 * If this transaction isn't actually touching any CRTC's, don't
  5119		 * bother with watermark calculation.  Note that if we pass this
  5120		 * test, we're guaranteed to hold at least one CRTC state mutex,
  5121		 * which means we can safely use values like dev_priv->active_crtcs
  5122		 * since any racing commits that want to update them would need to
  5123		 * hold _all_ CRTC state mutexes.
  5124		 */
  5125		for_each_new_crtc_in_state(state, crtc, cstate, i)
  5126			(*changed) = true;
  5127	
  5128		if (!*changed)
  5129			return 0;
  5130	
  5131		/*
  5132		 * If this is our first atomic update following hardware readout,
  5133		 * we can't trust the DDB that the BIOS programmed for us.  Let's
  5134		 * pretend that all pipes switched active status so that we'll
  5135		 * ensure a full DDB recompute.
  5136		 */
  5137		if (dev_priv->wm.distrust_bios_wm) {
  5138			ret = drm_modeset_lock(&dev->mode_config.connection_mutex,
  5139					       state->acquire_ctx);
  5140			if (ret)
  5141				return ret;
  5142	
  5143			intel_state->active_pipe_changes = ~0;
  5144	
  5145			/*
  5146			 * We usually only initialize intel_state->active_crtcs if we
  5147			 * we're doing a modeset; make sure this field is always
  5148			 * initialized during the sanitization process that happens
  5149			 * on the first commit too.
  5150			 */
  5151			if (!intel_state->modeset)
  5152				intel_state->active_crtcs = dev_priv->active_crtcs;
  5153		}
  5154	
  5155		/*
  5156		 * If the modeset changes which CRTC's are active, we need to
  5157		 * recompute the DDB allocation for *all* active pipes, even
  5158		 * those that weren't otherwise being modified in any way by this
  5159		 * atomic commit.  Due to the shrinking of the per-pipe allocations
  5160		 * when new active CRTC's are added, it's possible for a pipe that
  5161		 * we were already using and aren't changing at all here to suddenly
  5162		 * become invalid if its DDB needs exceeds its new allocation.
  5163		 *
  5164		 * Note that if we wind up doing a full DDB recompute, we can't let
  5165		 * any other display updates race with this transaction, so we need
  5166		 * to grab the lock on *all* CRTC's.
  5167		 */
  5168		if (intel_state->active_pipe_changes) {
  5169			realloc_pipes = ~0;
  5170			intel_state->wm_results.dirty_pipes = ~0;
  5171		}
  5172	
  5173		/*
  5174		 * We're not recomputing for the pipes not included in the commit, so
  5175		 * make sure we start with the current state.
  5176		 */
  5177		for_each_intel_crtc_mask(dev, intel_crtc, realloc_pipes) {
  5178			struct intel_crtc_state *cstate;
  5179	
  5180			cstate = intel_atomic_get_crtc_state(state, intel_crtc);
  5181			if (IS_ERR(cstate))
  5182				return PTR_ERR(cstate);
  5183		}
  5184	
  5185		return 0;
  5186	}
  5187	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

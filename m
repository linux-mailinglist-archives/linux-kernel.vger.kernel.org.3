Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5195194E7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343949AbiEDCAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 22:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344074AbiEDB7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:59:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F8249FA5
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651629215; x=1683165215;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JDxQddswnaAtAEe6Yd2ih6qHUHQiMwv8N9U0jVI8plg=;
  b=c37yO31caGrTAYuZ9exPASDTyji7fEXeY07J4g/qwIFeANMQ5PQ/QGVE
   OuEAq5FpLssIyIOwTMLtMZPekiJq3sE4zP+JkXU9rNrIYCDf9S7SCL7dJ
   M1/YSTQgJ/AgYRlHSfQDCsEjJRr7o+YH0fDjBLVMVxg2aSL5t507rEa6u
   P6hC+OqBLsYy/T2ec2GYHAXp9RgcKw5ZTUDAGa+l1PZOjMKQsewPzEGtK
   W95SV4GwLtBlLu6hucz1zabACu/TspcujxWVm0zhGoIhRCVCszDPzhmh5
   9wS/NSwPzRLNpmPo/GcJgMgvdfaBKFMQJCHIF5RYA5A3pxY6aISL6mugI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="248180730"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="248180730"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 18:53:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="734182002"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 May 2022 18:53:33 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nm4Cr-000AxP-98;
        Wed, 04 May 2022 01:53:33 +0000
Date:   Wed, 4 May 2022 09:52:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [vsyrjala:crtc_clock_compute_8 10/26]
 drivers/gpu/drm/i915/display/intel_ddi.c:325:5: warning: no previous
 prototype for function 'intel_crtc_dotclock'
Message-ID: <202205040931.3Rt8hNR2-lkp@intel.com>
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

tree:   https://github.com/vsyrjala/linux.git crtc_clock_compute_8
head:   aee27a93a2e9c552d016d4eadaff5aa87dccce13
commit: eb839775996f072098b810f91bc34757d1ea008e [10/26] drm/i915: Extract intel_crtc_dotclock()
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220504/202205040931.3Rt8hNR2-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 363b3a645a1e30011cc8da624f13dac5fd915628)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/vsyrjala/linux/commit/eb839775996f072098b810f91bc34757d1ea008e
        git remote add vsyrjala https://github.com/vsyrjala/linux.git
        git fetch --no-tags vsyrjala crtc_clock_compute_8
        git checkout eb839775996f072098b810f91bc34757d1ea008e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/i915/display/intel_ddi.c:325:5: warning: no previous prototype for function 'intel_crtc_dotclock' [-Wmissing-prototypes]
   int intel_crtc_dotclock(const struct intel_crtc_state *pipe_config)
       ^
   drivers/gpu/drm/i915/display/intel_ddi.c:325:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int intel_crtc_dotclock(const struct intel_crtc_state *pipe_config)
   ^
   static 
   1 warning generated.


vim +/intel_crtc_dotclock +325 drivers/gpu/drm/i915/display/intel_ddi.c

   324	
 > 325	int intel_crtc_dotclock(const struct intel_crtc_state *pipe_config)
   326	{
   327		int dotclock;
   328	
   329		if (intel_crtc_has_dp_encoder(pipe_config))
   330			dotclock = intel_dotclock_calculate(pipe_config->port_clock,
   331							    &pipe_config->dp_m_n);
   332		else if (pipe_config->has_hdmi_sink && pipe_config->pipe_bpp > 24)
   333			dotclock = pipe_config->port_clock * 24 / pipe_config->pipe_bpp;
   334		else
   335			dotclock = pipe_config->port_clock;
   336	
   337		if (pipe_config->output_format == INTEL_OUTPUT_FORMAT_YCBCR420 &&
   338		    !intel_crtc_has_dp_encoder(pipe_config))
   339			dotclock *= 2;
   340	
   341		if (pipe_config->pixel_multiplier)
   342			dotclock /= pipe_config->pixel_multiplier;
   343	
   344		return dotclock;
   345	}
   346	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

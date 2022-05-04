Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B0A51985F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345845AbiEDHh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345883AbiEDHgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:36:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E232409C
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 00:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651649582; x=1683185582;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MHhfMqQDOoJ9yfAH++kCDJ9iYJiXmFxk5uyPkNVpZ2s=;
  b=D5EEccXmqbehoGcpTaVuhG58auabsLSpTD/rP3Z78YkEAx1HrAzaHA0O
   6DVrdg5gh0S0UOpkp7/a/QIPMsUy6WbJhUzVIWpHhZtxkRWcpNsxKflzJ
   mad0K7xE0AbfPtbyiVhAImtnOXMpkM1+uY/1V52SyJlV+kFpudZu+VldX
   rCTh1JCk1p92x7knjVLDf3V7JNZ9TRbS6kc8cDE2i4AamsuEVu3BxSD8y
   XDVZmUvvS/yndr8/XVPFyvojPfMIjZpvJ6d4JycOoaX3r0ZrZ8hmnAXGV
   ddwcSQGCfyIceFf/6V/h3POdhJQ8IfKy9GdEkevomhf+yKyJmgElmCuOT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="255153697"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="255153697"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 00:32:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="548416555"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 04 May 2022 00:32:56 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nm9VI-000BAw-0u;
        Wed, 04 May 2022 07:32:56 +0000
Date:   Wed, 4 May 2022 15:32:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [vsyrjala:crtc_clock_compute_8 10/26]
 drivers/gpu/drm/i915/display/intel_ddi.c:325:5: error: no previous prototype
 for function 'intel_crtc_dotclock'
Message-ID: <202205041506.Q9YdhHrE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/vsyrjala/linux.git crtc_clock_compute_8
head:   aee27a93a2e9c552d016d4eadaff5aa87dccce13
commit: eb839775996f072098b810f91bc34757d1ea008e [10/26] drm/i915: Extract intel_crtc_dotclock()
config: x86_64-randconfig-r023-20220502 (https://download.01.org/0day-ci/archive/20220504/202205041506.Q9YdhHrE-lkp@intel.com/config)
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

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/i915/display/intel_ddi.c:325:5: error: no previous prototype for function 'intel_crtc_dotclock' [-Werror,-Wmissing-prototypes]
   int intel_crtc_dotclock(const struct intel_crtc_state *pipe_config)
       ^
   drivers/gpu/drm/i915/display/intel_ddi.c:325:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int intel_crtc_dotclock(const struct intel_crtc_state *pipe_config)
   ^
   static 
   1 error generated.


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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F26250CE29
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 02:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237318AbiDXApG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 20:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbiDXApD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 20:45:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAF8329A0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 17:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650760924; x=1682296924;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=67a/xKtE5fI16VIULEgBimFlKNFF8v6uBIlSTuJbyyI=;
  b=IpD1WVKwtgFiKxC20AsGqWmcxjE1JPLgQI26dupf5/QQjMTM170Ijugr
   FBzPyiv3SW6IdtVFwZF5wxFSJWvmmXLQDm9e3iyHeimlIP/p7fMryrJhM
   A+PS43pda1iL0MFBgXu77bShXcS+mjKFMSRHEhbvWpDqiBHtKMTvEBMK5
   oHwxzY7xrver7Jjf9qQeVKvfOZ6dckHK0OFlL9eyCJ0VGqfxgtIC1Dukr
   dZ9vxIzrGDpoTpDHseVMperZp8mmSzASmsogoAcKPIhvVpNnei9/pUOPA
   J6eGLA2LHn6yutH3fOmMa9SQ4l09A2H989Z9MtgqVZ0tuu2DlBJIZyw6T
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="252316016"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="252316016"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 17:42:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="512090746"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Apr 2022 17:42:02 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niQK9-0000lt-FT;
        Sun, 24 Apr 2022 00:42:01 +0000
Date:   Sun, 24 Apr 2022 08:41:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Hsieh <paul.hsieh@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Eric Yang <Eric.Yang2@amd.com>
Subject: [agd5f:drm-next 67/201]
 drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c:618:6:
 warning: no previous prototype for function 'dcn31_set_low_power_state'
Message-ID: <202204240845.twj3M5Ei-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   a2443ef0a8046ca98868224ee9bd6861c17e4995
commit: 06bab5897c51e15d9a6b7ec11b1eacc4f2e1a145 [67/201] drm/amd/display: Power down hardware if timer not trigger
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220424/202204240845.twj3M5Ei-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 06bab5897c51e15d9a6b7ec11b1eacc4f2e1a145
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c:49:
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.h:30:
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dmub/dmub_srv.h:67:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:3049:12: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
                   uint64_t temp;
                            ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c:618:6: warning: no previous prototype for function 'dcn31_set_low_power_state' [-Wmissing-prototypes]
   void dcn31_set_low_power_state(struct clk_mgr *clk_mgr_base)
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c:618:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void dcn31_set_low_power_state(struct clk_mgr *clk_mgr_base)
   ^
   static 
   2 warnings generated.


vim +/dcn31_set_low_power_state +618 drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c

   617	
 > 618	void dcn31_set_low_power_state(struct clk_mgr *clk_mgr_base)
   619	{
   620		int display_count;
   621		struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
   622		struct dc *dc = clk_mgr_base->ctx->dc;
   623		struct dc_state *context = dc->current_state;
   624	
   625		if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_LOW_POWER) {
   626			display_count = dcn31_get_active_display_cnt_wa(dc, context);
   627			/* if we can go lower, go lower */
   628			if (display_count == 0) {
   629				union display_idle_optimization_u idle_info = { 0 };
   630	
   631				idle_info.idle_info.df_request_disabled = 1;
   632				idle_info.idle_info.phy_ref_clk_off = 1;
   633				idle_info.idle_info.s0i2_rdy = 1;
   634				dcn31_smu_set_display_idle_optimization(clk_mgr, idle_info.data);
   635				/* update power state */
   636				clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_LOW_POWER;
   637			}
   638		}
   639	}
   640	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

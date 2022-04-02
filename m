Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D724F0167
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 14:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242281AbiDBMUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 08:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242959AbiDBMUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 08:20:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E814D1274E
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 05:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648901930; x=1680437930;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EXvD+vaHxStS1h1LN86nr4iKdKQrUMNfdRXkPwJhflc=;
  b=CU6vzFmBS09HlW5ZWXYXqncn9r+Ab2xApyHDgulxXuXGbL2XE4H/ktob
   uOvYIBVZeF2bcRTN5KYqhjnhTjyxCibQfYfTqXLHIzViqYcPhHwUoIP7b
   RudcENu8c9m6EriwyT6uuHqV3MG7r3NSLoqjzFnXbQmpUj+TjSX1MKhZb
   2/S7Swwv5J6zitIsSOkU5zAK4BHmjOWQvmeOEj6HxAH9REJS1IDXQk4fK
   5UXP4f7vvk4XEQBH7iUGkiQBJUJ8jL9S7+nM5epbcSQeqNzwltI3qiC6a
   eqUk6fXfM/bg2uYNUgWUU/phcceUPw8H2gqOMfgKkUw9g0TCx6R605//r
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="259126474"
X-IronPort-AV: E=Sophos;i="5.90,230,1643702400"; 
   d="scan'208";a="259126474"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 05:18:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,230,1643702400"; 
   d="scan'208";a="504448703"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 02 Apr 2022 05:18:48 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naciO-00007p-3S;
        Sat, 02 Apr 2022 12:18:48 +0000
Date:   Sat, 2 Apr 2022 20:17:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Hsieh <paul.hsieh@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Eric Yang <Eric.Yang2@amd.com>
Subject: [agd5f:drm-next 67/96]
 drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c:618:6:
 warning: no previous prototype for 'dcn31_set_low_power_state'
Message-ID: <202204022040.87CAsqVS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   e45422695c196dbc665a95526c85ff4b8752aff2
commit: 06bab5897c51e15d9a6b7ec11b1eacc4f2e1a145 [67/96] drm/amd/display: Power down hardware if timer not trigger
config: powerpc64-randconfig-s032-20220402 (https://download.01.org/0day-ci/archive/20220402/202204022040.87CAsqVS-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 06bab5897c51e15d9a6b7ec11b1eacc4f2e1a145
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../display/dmub/dmub_srv.h:67,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c:49:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h: In function 'dmub_rb_flush_pending':
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:3049:26: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
    3049 |                 uint64_t temp;
         |                          ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c: At top level:
>> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c:618:6: warning: no previous prototype for 'dcn31_set_low_power_state' [-Wmissing-prototypes]
     618 | void dcn31_set_low_power_state(struct clk_mgr *clk_mgr_base)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/resource.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/hw/clk_mgr_internal.h:36,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c:29:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:129:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     129 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:126:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     126 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:125:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     125 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~


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

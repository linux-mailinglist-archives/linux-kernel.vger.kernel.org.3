Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CC450D22E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 16:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbiDXONt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 10:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbiDXONp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 10:13:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6638F193D6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650809444; x=1682345444;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QPi/+0OWCYaltKXE+JgSt4MjUfW2TiPg2Y4eWrYeKLE=;
  b=eP72bs/eriCOIoiK//V37muHFsxis6CZ/CUZiPyQSfvJ4xRWpHR5UGqB
   hw2fjW18YuI71p7T4U+i5EI/dG1VcXs8t+dWkhl5W2VfmMTdbrzr4fjL5
   StVTE68NQeCJwBxgerYdkpeGqPM+kJ/+LfGDcfzLhinIR6pVqvuV9GlSD
   isEMskGUoNtkVO1Lfso9hofAys20S/T8ZwczzSliAw8I18n4co1Cg4jss
   0fKbMabjfd7y1lA6V/FYwirXm/5Rt7WIM+UJiAApMuE1PPVfjOXB4x6eN
   3PcuUDoCXxP9PcWRmNi3G1FRc79gWz/cvpHTC2vtE8D1ghGt8N07w++gD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="264555696"
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="264555696"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 07:10:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="512262745"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Apr 2022 07:10:42 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nicwj-0001Vp-NN;
        Sun, 24 Apr 2022 14:10:41 +0000
Date:   Sun, 24 Apr 2022 22:10:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Hsieh <paul.hsieh@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Martin Leung <Martin.Leung@amd.com>
Subject: [agd5f:drm-next 151/201]
 drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c:618:6:
 warning: no previous prototype for 'dcn31_set_low_power_state'
Message-ID: <202204242243.jhz4z3rX-lkp@intel.com>
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
commit: 593692d2de458a68c8e2326d48d1325d87947d90 [151/201] drm/amd/display: Power down hardware if timer not trigger
config: powerpc64-buildonly-randconfig-r004-20220424 (https://download.01.org/0day-ci/archive/20220424/202204242243.jhz4z3rX-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 593692d2de458a68c8e2326d48d1325d87947d90
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

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

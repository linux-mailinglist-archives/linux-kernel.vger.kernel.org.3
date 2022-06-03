Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B049053C358
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiFCCw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 22:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiFCCwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 22:52:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22EC237E0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 19:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654224773; x=1685760773;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Hrra3fUBgDeLA/XvDHrVdOmC2xlDgugKSB++AYO2cvU=;
  b=kB+U8+c1BuJHEpQ8GUqU+Jb1Ty+4inCBqWa+QMcS5nCC1h3AYgmDooby
   atpH7NqsVhotK3Qqg3GUaM1cCdjE5z/VRGhlvE2Y0n/S/pjEkkUPGsLLc
   njy4xIwBwQd4yfo7d2qUesT2jg8IXEsC7Q91zaqTAPqh1lQAO7+fz9xV2
   lXqdW4/jl3ACjVCwjU27AuNzwH27MUwhh8egXrS8rwG39zoj5kJC9uxbU
   aofBN4BnvirHuwDoCvQ2AE269jjYcQtyDIHLiwu/wj396F+wu4TxdqO7D
   UvsWX4CW67WIBJE7bLw043Zeb+Ce03HHuyUJ2hS7ly1sPJ5QdGYmByjUQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="301519492"
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="301519492"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 19:52:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="530840377"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Jun 2022 19:52:51 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwxQh-0005vJ-7A;
        Fri, 03 Jun 2022 02:52:51 +0000
Date:   Fri, 3 Jun 2022 10:50:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [agd5f:drm-next 34/63]
 drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c:414:6:
 warning: no previous prototype for 'dcn32_clock_read_ss_info'
Message-ID: <202206031013.jYog18lK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   0401cdad37f8a62e64363b2a6fc16c7fafba66e2
commit: b5dbe04a9c8ce5c728b827c452b99517c0e387af [34/63] drm/amd/display: add CLKMGR changes for DCN32/321
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220603/202206031013.jYog18lK-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout b5dbe04a9c8ce5c728b827c452b99517c0e387af
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c:414:6: warning: no previous prototype for 'dcn32_clock_read_ss_info' [-Wmissing-prototypes]
     414 | void dcn32_clock_read_ss_info(struct clk_mgr_internal *clk_mgr)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/resource.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/hw/clk_mgr_internal.h:36,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c:27:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:133:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     133 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:130:17: warning: 'DP_SINK_BRANCH_DEV_NAME_7580' defined but not used [-Wunused-const-variable=]
     130 | static const u8 DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:128:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     128 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/dcn32_clock_read_ss_info +414 drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c

   413	
 > 414	void dcn32_clock_read_ss_info(struct clk_mgr_internal *clk_mgr)
   415	{
   416		struct dc_bios *bp = clk_mgr->base.ctx->dc_bios;
   417		int ss_info_num = bp->funcs->get_ss_entry_number(
   418				bp, AS_SIGNAL_TYPE_GPU_PLL);
   419	
   420		if (ss_info_num) {
   421			struct spread_spectrum_info info = { { 0 } };
   422			enum bp_result result = bp->funcs->get_spread_spectrum_info(
   423					bp, AS_SIGNAL_TYPE_GPU_PLL, 0, &info);
   424	
   425			/* SSInfo.spreadSpectrumPercentage !=0 would be sign
   426			 * that SS is enabled
   427			 */
   428			if (result == BP_RESULT_OK &&
   429					info.spread_spectrum_percentage != 0) {
   430				clk_mgr->ss_on_dprefclk = true;
   431				clk_mgr->dprefclk_ss_divider = info.spread_percentage_divider;
   432	
   433				if (info.type.CENTER_MODE == 0) {
   434					/* Currently for DP Reference clock we
   435					 * need only SS percentage for
   436					 * downspread
   437					 */
   438					clk_mgr->dprefclk_ss_percentage =
   439							info.spread_spectrum_percentage;
   440				}
   441			}
   442		}
   443	}
   444	static void dcn32_notify_wm_ranges(struct clk_mgr *clk_mgr_base)
   445	{
   446		struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
   447		WatermarksExternal_t *table = (WatermarksExternal_t *) clk_mgr->wm_range_table;
   448	
   449		if (!clk_mgr->smu_present)
   450			return;
   451	
   452		if (!table)
   453			return;
   454	
   455		memset(table, 0, sizeof(*table));
   456	
   457		dcn30_smu_set_dram_addr_high(clk_mgr, clk_mgr->wm_range_table_addr >> 32);
   458		dcn30_smu_set_dram_addr_low(clk_mgr, clk_mgr->wm_range_table_addr & 0xFFFFFFFF);
   459		dcn32_smu_transfer_wm_table_dram_2_smu(clk_mgr);
   460	}
   461	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

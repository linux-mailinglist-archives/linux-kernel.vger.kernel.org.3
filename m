Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E6E567CE0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiGFD6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiGFD62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:58:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83472BE1A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 20:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657079904; x=1688615904;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EAdXzx5Lllf14F28DD21r/lTfnEgHmeW44/wqPxVY4U=;
  b=V4Jn56Jg5dpwG+IDJ2haw73+q1d05xhZr6ye89FgyP2ASJTtighrycps
   VTPHzUMn6Hlxm96JUEGmSsYAwZhLS7MNeyHdprokqdAf1djQ76FzglLVo
   w3o1m/PqWoNtRiGaed+XPzjoGySQow/caarAcOPaTapIUIeu3Q1fnhBd5
   Ln0TIvYoQqvwGaGOMyshQZq1CRy8wlxgY5wCyWMwBo9kgFfp/OHostsIS
   TigLJBms6piXo8IwJXsg1/AwEDuyIFnUOnHBGxsv0xMnOEXew969A3MSv
   5ATLtAT0aZyL5h0FA9SL6XN+eJo+r+dYmQJAuHuVLzyTC0Rdsrix8ur5L
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="263421963"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="263421963"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 20:58:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="567891433"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Jul 2022 20:58:22 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8wBB-000JyP-He;
        Wed, 06 Jul 2022 03:58:21 +0000
Date:   Wed, 6 Jul 2022 11:58:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [agd5f:drm-next 350/388]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:1902:5:
 warning: no previous prototype for 'get_refresh_rate'
Message-ID: <202207061138.fLHTrZu1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   fc25fd602b1e101a45650475a8d2f00d7bb8e971
commit: 00fa7f031dd4b885175da390e24cb02f6a45977e [350/388] drm/amd/display: Add basic infrastructure for enabling FAMS
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220706/202207061138.fLHTrZu1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 00fa7f031dd4b885175da390e24cb02f6a45977e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:118:29: note: in expansion of macro 'BASE'
     118 |                 .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
         |                             ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:386:9: note: in expansion of macro 'SR'
     386 |         SR(MPC_CRC_RESULT_GB), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:624:17: note: in expansion of macro 'HWSEQ_DCN30_REG_LIST'
     624 |                 HWSEQ_DCN30_REG_LIST()
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:373:52: note: (near initialization for 'hwseq_reg.MPC_CRC_RESULT_GB')
     373 | #define DCN_BASE__INST0_SEG3                       0x00009000
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:113:25: note: in expansion of macro 'DCN_BASE__INST0_SEG3'
     113 | #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:115:19: note: in expansion of macro 'BASE_INNER'
     115 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:118:29: note: in expansion of macro 'BASE'
     118 |                 .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
         |                             ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:386:9: note: in expansion of macro 'SR'
     386 |         SR(MPC_CRC_RESULT_GB), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:624:17: note: in expansion of macro 'HWSEQ_DCN30_REG_LIST'
     624 |                 HWSEQ_DCN30_REG_LIST()
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:373:52: warning: initialized field overwritten [-Woverride-init]
     373 | #define DCN_BASE__INST0_SEG3                       0x00009000
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:113:25: note: in expansion of macro 'DCN_BASE__INST0_SEG3'
     113 | #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:115:19: note: in expansion of macro 'BASE_INNER'
     115 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:118:29: note: in expansion of macro 'BASE'
     118 |                 .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
         |                             ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:387:9: note: in expansion of macro 'SR'
     387 |         SR(MPC_CRC_RESULT_C), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:624:17: note: in expansion of macro 'HWSEQ_DCN30_REG_LIST'
     624 |                 HWSEQ_DCN30_REG_LIST()
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:373:52: note: (near initialization for 'hwseq_reg.MPC_CRC_RESULT_C')
     373 | #define DCN_BASE__INST0_SEG3                       0x00009000
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:113:25: note: in expansion of macro 'DCN_BASE__INST0_SEG3'
     113 | #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:115:19: note: in expansion of macro 'BASE_INNER'
     115 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:118:29: note: in expansion of macro 'BASE'
     118 |                 .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
         |                             ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:387:9: note: in expansion of macro 'SR'
     387 |         SR(MPC_CRC_RESULT_C), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:624:17: note: in expansion of macro 'HWSEQ_DCN30_REG_LIST'
     624 |                 HWSEQ_DCN30_REG_LIST()
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:373:52: warning: initialized field overwritten [-Woverride-init]
     373 | #define DCN_BASE__INST0_SEG3                       0x00009000
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:113:25: note: in expansion of macro 'DCN_BASE__INST0_SEG3'
     113 | #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:115:19: note: in expansion of macro 'BASE_INNER'
     115 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:118:29: note: in expansion of macro 'BASE'
     118 |                 .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
         |                             ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:388:9: note: in expansion of macro 'SR'
     388 |         SR(MPC_CRC_RESULT_AR), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:624:17: note: in expansion of macro 'HWSEQ_DCN30_REG_LIST'
     624 |                 HWSEQ_DCN30_REG_LIST()
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:373:52: note: (near initialization for 'hwseq_reg.MPC_CRC_RESULT_AR')
     373 | #define DCN_BASE__INST0_SEG3                       0x00009000
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:113:25: note: in expansion of macro 'DCN_BASE__INST0_SEG3'
     113 | #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:115:19: note: in expansion of macro 'BASE_INNER'
     115 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:118:29: note: in expansion of macro 'BASE'
     118 |                 .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
         |                             ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:388:9: note: in expansion of macro 'SR'
     388 |         SR(MPC_CRC_RESULT_AR), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:624:17: note: in expansion of macro 'HWSEQ_DCN30_REG_LIST'
     624 |                 HWSEQ_DCN30_REG_LIST()
         |                 ^~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:1902:5: warning: no previous prototype for 'get_refresh_rate' [-Wmissing-prototypes]
    1902 | int get_refresh_rate(struct dc_state *context)
         |     ^~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:1933:5: warning: no previous prototype for 'get_frame_rate_at_max_stretch_100hz' [-Wmissing-prototypes]
    1933 | int get_frame_rate_at_max_stretch_100hz(struct dc_state *context)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:1963:6: warning: no previous prototype for 'is_refresh_rate_support_mclk_switch_using_fw_based_vblank_stretch' [-Wmissing-prototypes]
    1963 | bool is_refresh_rate_support_mclk_switch_using_fw_based_vblank_stretch(struct dc_state *context)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:1980:6: warning: no previous prototype for 'dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch' [-Wmissing-prototypes]
    1980 | bool dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc, struct dc_state *context)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:2040:5: warning: no previous prototype for 'dcn30_find_dummy_latency_index_for_fw_based_mclk_switch' [-Wmissing-prototypes]
    2040 | int dcn30_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc, struct dc_state *context,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/resource.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:32:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:137:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     137 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:134:17: warning: 'DP_SINK_BRANCH_DEV_NAME_7580' defined but not used [-Wunused-const-variable=]
     134 | static const u8 DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:132:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     132 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:131:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     131 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:273:9: warning: no previous prototype for 'dc_dmub_srv_get_pipes_for_stream' [-Wmissing-prototypes]
     273 | uint8_t dc_dmub_srv_get_pipes_for_stream(struct dc *dc, struct dc_stream_state *stream)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:287:5: warning: no previous prototype for 'dc_dmub_srv_get_timing_generator_offset' [-Wmissing-prototypes]
     287 | int dc_dmub_srv_get_timing_generator_offset(struct dc *dc, struct dc_stream_state *stream)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:636:6: warning: no previous prototype for 'dc_dmub_setup_subvp_dmub_command' [-Wmissing-prototypes]
     636 | void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:31:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:137:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     137 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:134:17: warning: 'DP_SINK_BRANCH_DEV_NAME_7580' defined but not used [-Wunused-const-variable=]
     134 | static const u8 DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:132:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     132 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:131:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     131 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/get_refresh_rate +1902 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c

  1901	
> 1902	int get_refresh_rate(struct dc_state *context)
  1903	{
  1904		int refresh_rate = 0;
  1905		int h_v_total = 0;
  1906		struct dc_crtc_timing *timing = NULL;
  1907	
  1908		if (context == NULL || context->streams[0] == NULL)
  1909			return 0;
  1910	
  1911		/* check if refresh rate at least 120hz */
  1912		timing = &context->streams[0]->timing;
  1913		if (timing == NULL)
  1914			return 0;
  1915	
  1916		h_v_total = timing->h_total * timing->v_total;
  1917		if (h_v_total == 0)
  1918			return 0;
  1919	
  1920		refresh_rate = ((timing->pix_clk_100hz * 100) / (h_v_total)) + 1;
  1921		return refresh_rate;
  1922	}
  1923	
  1924	#define MAX_STRETCHED_V_BLANK 500 // in micro-seconds
  1925	/*
  1926	 * Scaling factor for v_blank stretch calculations considering timing in
  1927	 * micro-seconds and pixel clock in 100hz.
  1928	 * Note: the parenthesis are necessary to ensure the correct order of
  1929	 * operation where V_SCALE is used.
  1930	 */
  1931	#define V_SCALE (10000 / MAX_STRETCHED_V_BLANK)
  1932	
> 1933	int get_frame_rate_at_max_stretch_100hz(struct dc_state *context)
  1934	{
  1935		struct dc_crtc_timing *timing = NULL;
  1936		uint32_t sec_per_100_lines;
  1937		uint32_t max_v_blank;
  1938		uint32_t curr_v_blank;
  1939		uint32_t v_stretch_max;
  1940		uint32_t stretched_frame_pix_cnt;
  1941		uint32_t scaled_stretched_frame_pix_cnt;
  1942		uint32_t scaled_refresh_rate;
  1943	
  1944		if (context == NULL || context->streams[0] == NULL)
  1945			return 0;
  1946	
  1947		/* check if refresh rate at least 120hz */
  1948		timing = &context->streams[0]->timing;
  1949		if (timing == NULL)
  1950			return 0;
  1951	
  1952		sec_per_100_lines = timing->pix_clk_100hz / timing->h_total + 1;
  1953		max_v_blank = sec_per_100_lines / V_SCALE + 1;
  1954		curr_v_blank = timing->v_total - timing->v_addressable;
  1955		v_stretch_max = (max_v_blank > curr_v_blank) ? (max_v_blank - curr_v_blank) : (0);
  1956		stretched_frame_pix_cnt = (v_stretch_max + timing->v_total) * timing->h_total;
  1957		scaled_stretched_frame_pix_cnt = stretched_frame_pix_cnt / 10000;
  1958		scaled_refresh_rate = (timing->pix_clk_100hz) / scaled_stretched_frame_pix_cnt + 1;
  1959	
  1960		return scaled_refresh_rate;
  1961	}
  1962	
> 1963	bool is_refresh_rate_support_mclk_switch_using_fw_based_vblank_stretch(struct dc_state *context)
  1964	{
  1965		int refresh_rate_max_stretch_100hz;
  1966		int min_refresh_100hz;
  1967	
  1968		if (context == NULL || context->streams[0] == NULL)
  1969			return false;
  1970	
  1971		refresh_rate_max_stretch_100hz = get_frame_rate_at_max_stretch_100hz(context);
  1972		min_refresh_100hz = context->streams[0]->timing.min_refresh_in_uhz / 10000;
  1973	
  1974		if (refresh_rate_max_stretch_100hz < min_refresh_100hz)
  1975			return false;
  1976	
  1977		return true;
  1978	}
  1979	
> 1980	bool dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc, struct dc_state *context)
  1981	{
  1982		int refresh_rate = 0;
  1983		const int minimum_refreshrate_supported = 120;
  1984	
  1985		if (context == NULL || context->streams[0] == NULL)
  1986			return false;
  1987	
  1988		if (context->streams[0]->sink->edid_caps.panel_patch.disable_fams)
  1989			return false;
  1990	
  1991		if (dc->debug.disable_fams)
  1992			return false;
  1993	
  1994		if (!dc->caps.dmub_caps.mclk_sw)
  1995			return false;
  1996	
  1997		if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching_shut_down)
  1998			return false;
  1999	
  2000		/* more then 1 monitor connected */
  2001		if (context->stream_count != 1)
  2002			return false;
  2003	
  2004		refresh_rate = get_refresh_rate(context);
  2005		if (refresh_rate < minimum_refreshrate_supported)
  2006			return false;
  2007	
  2008		if (!is_refresh_rate_support_mclk_switch_using_fw_based_vblank_stretch(context))
  2009			return false;
  2010	
  2011		// check if freesync enabled
  2012		if (!context->streams[0]->allow_freesync)
  2013			return false;
  2014	
  2015		if (context->streams[0]->vrr_active_variable)
  2016			return false;
  2017	
  2018		return true;
  2019	}
  2020	
  2021	/*
  2022	 * set up FPO watermarks, pstate, dram latency
  2023	 */
  2024	void dcn30_setup_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc, struct dc_state *context)
  2025	{
  2026		ASSERT(dc != NULL && context != NULL);
  2027		if (dc == NULL || context == NULL)
  2028			return;
  2029	
  2030		/* Set wm_a.pstate so high natural MCLK switches are impossible: 4 seconds */
  2031		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns = 4U * 1000U * 1000U * 1000U;
  2032	}
  2033	
  2034	/*
  2035	 * Finds dummy_latency_index when MCLK switching using firmware based
  2036	 * vblank stretch is enabled. This function will iterate through the
  2037	 * table of dummy pstate latencies until the lowest value that allows
  2038	 * dm_allow_self_refresh_and_mclk_switch to happen is found
  2039	 */
> 2040	int dcn30_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc, struct dc_state *context,
  2041			display_e2e_pipe_params_st *pipes, int pipe_cnt, int vlevel)
  2042	{
  2043		const int max_latency_table_entries = 4;
  2044		int dummy_latency_index = 0;
  2045	
  2046		while (dummy_latency_index < max_latency_table_entries) {
  2047			context->bw_ctx.dml.soc.dram_clock_change_latency_us =
  2048					dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dummy_pstate_latency_us;
  2049			dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, false);
  2050	
  2051			if (context->bw_ctx.dml.soc.allow_dram_self_refresh_or_dram_clock_change_in_vblank ==
  2052				dm_allow_self_refresh_and_mclk_switch)
  2053				break;
  2054	
  2055			dummy_latency_index++;
  2056		}
  2057	
  2058		if (dummy_latency_index == max_latency_table_entries) {
  2059			ASSERT(dummy_latency_index != max_latency_table_entries);
  2060			/* If the execution gets here, it means dummy p_states are
  2061			 * not possible. This should never happen and would mean
  2062			 * something is severely wrong.
  2063			 * Here we reset dummy_latency_index to 3, because it is
  2064			 * better to have underflows than system crashes.
  2065			 */
  2066			dummy_latency_index = 3;
  2067		}
  2068	
  2069		return dummy_latency_index;
  2070	}
  2071	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

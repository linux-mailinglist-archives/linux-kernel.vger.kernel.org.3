Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3825ADFA3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 08:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbiIFGR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 02:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238549AbiIFGRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 02:17:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2610AB85D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 23:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662444974; x=1693980974;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0N9pL1NUgGD++VIOugXELfvpfUnyAORyqRski/3wmoI=;
  b=hqAvtnp5ux6wswXiHwtSSd2lq+aHFL6OSO65zYzbF0t/C+PnXMMaE87W
   fmfZpGdayEeYzxOIRGmoyoqK+XkIrFw2bfQfrSSPruA/xL48xPG2SbYHy
   h8WcR9bxGdEZ6+7MVt+R9qSzEXixz+HPqb1Z7Hz2VnnVS8Kc2cSuZT6RR
   DNVbKHYZVPfPyoW1KAomBVJkxyLl92FSSW7MlQbiSPProC/oZYB9sSYm1
   jwnxOu9eqPgSO/OjR525abLfjlaQfqm/kHUc2GRmHqy1jt5yPxv+nJEfN
   NfXbC1HbC66B1H40g5eUxDUqrM25NLxB8hLEuvYqyoz1ITWpqbfmwtoqk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="276251821"
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="276251821"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 23:16:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="564975197"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 05 Sep 2022 23:16:11 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVRsY-0004s7-36;
        Tue, 06 Sep 2022 06:16:10 +0000
Date:   Tue, 6 Sep 2022 14:15:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:1933:5:
 warning: no previous prototype for 'get_frame_rate_at_max_stretch_100hz'
Message-ID: <202209061427.nCA7sXSr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodrigo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   53e99dcff61e1523ec1c3628b2d564ba15d32eb7
commit: 00fa7f031dd4b885175da390e24cb02f6a45977e drm/amd/display: Add basic infrastructure for enabling FAMS
date:   9 weeks ago
config: i386-buildonly-randconfig-r004-20220905 (https://download.01.org/0day-ci/archive/20220906/202209061427.nCA7sXSr-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=00fa7f031dd4b885175da390e24cb02f6a45977e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 00fa7f031dd4b885175da390e24cb02f6a45977e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

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
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:1902:5: warning: no previous prototype for 'get_refresh_rate' [-Wmissing-prototypes]
    1902 | int get_refresh_rate(struct dc_state *context)
         |     ^~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:1933:5: warning: no previous prototype for 'get_frame_rate_at_max_stretch_100hz' [-Wmissing-prototypes]
    1933 | int get_frame_rate_at_max_stretch_100hz(struct dc_state *context)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:1963:6: warning: no previous prototype for 'is_refresh_rate_support_mclk_switch_using_fw_based_vblank_stretch' [-Wmissing-prototypes]
    1963 | bool is_refresh_rate_support_mclk_switch_using_fw_based_vblank_stretch(struct dc_state *context)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:1980:6: warning: no previous prototype for 'dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch' [-Wmissing-prototypes]
    1980 | bool dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc, struct dc_state *context)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:2040:5: warning: no previous prototype for 'dcn30_find_dummy_latency_index_for_fw_based_mclk_switch' [-Wmissing-prototypes]
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


vim +/get_frame_rate_at_max_stretch_100hz +1933 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c

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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

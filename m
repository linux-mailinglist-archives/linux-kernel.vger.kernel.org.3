Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A7A50986A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385221AbiDUGtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385409AbiDUGrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:47:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6C721A3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523494; x=1682059494;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qqo6RJP87YZNDwXCvKc8abvdUGY3umQwWqdxetqZLCg=;
  b=DEtq0x7fbtJLBvmJ34+4cPz/97tYkj/UWnpt1mEuxsew+f3VRZxY/CjR
   dvHwaKKIyqgomtrry8DqHWqwsGTyqoisc0ufgyfWFDcJ/rqva7Z34lpeF
   0cUzdftr30Z4syZH3gD06iRD69F+dD5doGNENGDteOBd3ejxXLWAgPpZd
   XgtkmfM1iTZ01sVrDo7XbEhZD2n5OO65bOQht7a4tS6iI4mIpk2UPCLjG
   G3LqtMj9G8Ng5qFMliec59YncZNpB/5JgwhBTdfOdw0CyF7BWAP0ulak3
   irSL1gYN8+kstmlpDFYlAoFwiOq+2oE3qLvSP+TjZx6XSElOH64TU/dLk
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263723148"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="263723148"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="702961665"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Apr 2022 23:44:52 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQYd-000828-Io;
        Thu, 21 Apr 2022 06:44:51 +0000
Date:   Thu, 21 Apr 2022 14:44:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luben Tuikov <luben.tuikov@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:1113:32:
 warning: variable 'clk_src' set but not used
Message-ID: <202204210927.eUQN113S-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b253435746d9a4a701b5f09211b9c14d3370d0da
commit: 20f2ffe504728612d7b0c34e4f8280e34251e704 drm/amdgpu: fold CONFIG_DRM_AMD_DC_DCN3* into CONFIG_DRM_AMD_DC_DCN (v3)
date:   1 year, 5 months ago
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220421/202204210927.eUQN113S-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=20f2ffe504728612d7b0c34e4f8280e34251e704
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 20f2ffe504728612d7b0c34e4f8280e34251e704
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/platform/intel-quark/ drivers/gpu/drm/amd/amdgpu/ drivers/gpu/drm/amd/display/dc/ drivers/gpu/drm/radeon/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c: In function 'dcn3_get_pix_clk_dividers':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:1113:32: warning: variable 'clk_src' set but not used [-Wunused-but-set-variable]
    1113 |         struct dce110_clk_src *clk_src;
         |                                ^~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:86,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:32:
   At top level:
   drivers/gpu/drm/amd/amdgpu/../display/dc/inc/hw/dpp.h:50:42: warning: 'dpp_input_csc_matrix' defined but not used [-Wunused-const-variable=]
      50 | static const struct dpp_input_csc_matrix dpp_input_csc_matrix[] = {
         |                                          ^~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:32:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:126:22: warning: 'DP_DVI_CONVERTER_ID_5' defined but not used [-Wunused-const-variable=]
     126 | static const uint8_t DP_DVI_CONVERTER_ID_5[] = "3393N2";
         |                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:125:22: warning: 'DP_DVI_CONVERTER_ID_4' defined but not used [-Wunused-const-variable=]
     125 | static const uint8_t DP_DVI_CONVERTER_ID_4[] = "m2DVIa";
         |                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_3' defined but not used [-Wunused-const-variable=]
     123 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:121:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_2' defined but not used [-Wunused-const-variable=]
     121 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:35,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:28:
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:76:32: warning: 'dc_fixpt_ln2_div_2' defined but not used [-Wunused-const-variable=]
      76 | static const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
         |                                ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:75:32: warning: 'dc_fixpt_ln2' defined but not used [-Wunused-const-variable=]
      75 | static const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
         |                                ^~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:74:32: warning: 'dc_fixpt_e' defined but not used [-Wunused-const-variable=]
      74 | static const struct fixed31_32 dc_fixpt_e = { 11674931555LL };
         |                                ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:73:32: warning: 'dc_fixpt_two_pi' defined but not used [-Wunused-const-variable=]
      73 | static const struct fixed31_32 dc_fixpt_two_pi = { 26986075409LL };
         |                                ^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:72:32: warning: 'dc_fixpt_pi' defined but not used [-Wunused-const-variable=]
      72 | static const struct fixed31_32 dc_fixpt_pi = { 13493037705LL };
         |                                ^~~~~~~~~~~
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: In function 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3052:24: warning: variable 'MaxUsedBW' set but not used [-Wunused-but-set-variable]
    3052 |                 double MaxUsedBW = 0;
         |                        ^~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:27:
   At top level:
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:76:32: warning: 'dc_fixpt_ln2_div_2' defined but not used [-Wunused-const-variable=]
      76 | static const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
         |                                ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:75:32: warning: 'dc_fixpt_ln2' defined but not used [-Wunused-const-variable=]
      75 | static const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
         |                                ^~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:74:32: warning: 'dc_fixpt_e' defined but not used [-Wunused-const-variable=]
      74 | static const struct fixed31_32 dc_fixpt_e = { 11674931555LL };
         |                                ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:73:32: warning: 'dc_fixpt_two_pi' defined but not used [-Wunused-const-variable=]
      73 | static const struct fixed31_32 dc_fixpt_two_pi = { 26986075409LL };
         |                                ^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:72:32: warning: 'dc_fixpt_pi' defined but not used [-Wunused-const-variable=]
      72 | static const struct fixed31_32 dc_fixpt_pi = { 13493037705LL };
         |                                ^~~~~~~~~~~
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hubp.c: In function 'hubp3_set_vm_system_aperture_settings':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hubp.c:50:30: warning: variable 'mc_vm_apt_default' set but not used [-Wunused-but-set-variable]
      50 |         PHYSICAL_ADDRESS_LOC mc_vm_apt_default;
         |                              ^~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/hw/mem_input.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/hw/hubp.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/../dcn10/dcn10_hubp.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hubp.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hubp.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hubp.c:26:
   At top level:
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:76:32: warning: 'dc_fixpt_ln2_div_2' defined but not used [-Wunused-const-variable=]
      76 | static const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
         |                                ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:75:32: warning: 'dc_fixpt_ln2' defined but not used [-Wunused-const-variable=]
      75 | static const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
         |                                ^~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:74:32: warning: 'dc_fixpt_e' defined but not used [-Wunused-const-variable=]
      74 | static const struct fixed31_32 dc_fixpt_e = { 11674931555LL };
         |                                ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:73:32: warning: 'dc_fixpt_two_pi' defined but not used [-Wunused-const-variable=]
      73 | static const struct fixed31_32 dc_fixpt_two_pi = { 26986075409LL };
         |                                ^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:72:32: warning: 'dc_fixpt_pi' defined but not used [-Wunused-const-variable=]
      72 | static const struct fixed31_32 dc_fixpt_pi = { 13493037705LL };
         |                                ^~~~~~~~~~~
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c: In function 'dcn30_enable_writeback':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:322:34: warning: variable 'optc' set but not used [-Wunused-but-set-variable]
     322 |         struct timing_generator *optc;
         |                                  ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c: In function 'dcn30_update_info_frame':
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:654:14: warning: variable 'is_dp' set but not used [-Wunused-but-set-variable]
     654 |         bool is_dp;
         |              ^~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:86,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:29:
   At top level:
   drivers/gpu/drm/amd/amdgpu/../display/dc/inc/hw/dpp.h:50:42: warning: 'dpp_input_csc_matrix' defined but not used [-Wunused-const-variable=]
      50 | static const struct dpp_input_csc_matrix dpp_input_csc_matrix[] = {
         |                                          ^~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:29:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:126:22: warning: 'DP_DVI_CONVERTER_ID_5' defined but not used [-Wunused-const-variable=]
     126 | static const uint8_t DP_DVI_CONVERTER_ID_5[] = "3393N2";
         |                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:125:22: warning: 'DP_DVI_CONVERTER_ID_4' defined but not used [-Wunused-const-variable=]
     125 | static const uint8_t DP_DVI_CONVERTER_ID_4[] = "m2DVIa";
         |                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_3' defined but not used [-Wunused-const-variable=]
     123 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:121:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_2' defined but not used [-Wunused-const-variable=]
     121 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:35,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:27:
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:76:32: warning: 'dc_fixpt_ln2_div_2' defined but not used [-Wunused-const-variable=]
      76 | static const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
         |                                ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:75:32: warning: 'dc_fixpt_ln2' defined but not used [-Wunused-const-variable=]
      75 | static const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
         |                                ^~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:74:32: warning: 'dc_fixpt_e' defined but not used [-Wunused-const-variable=]
      74 | static const struct fixed31_32 dc_fixpt_e = { 11674931555LL };
         |                                ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:73:32: warning: 'dc_fixpt_two_pi' defined but not used [-Wunused-const-variable=]
      73 | static const struct fixed31_32 dc_fixpt_two_pi = { 26986075409LL };
         |                                ^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:72:32: warning: 'dc_fixpt_pi' defined but not used [-Wunused-const-variable=]
      72 | static const struct fixed31_32 dc_fixpt_pi = { 13493037705LL };
         |                                ^~~~~~~~~~~
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_afmt.c: In function 'afmt3_se_audio_setup':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_afmt.c:122:18: warning: variable 'speakers' set but not used [-Wunused-but-set-variable]
     122 |         uint32_t speakers = 0;
         |                  ^~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:35,
                    from drivers/gpu/drm/amd/amdgpu/../display/include/bios_parser_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_bios_types.h:39,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_afmt.c:27:
   At top level:
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:76:32: warning: 'dc_fixpt_ln2_div_2' defined but not used [-Wunused-const-variable=]
      76 | static const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
         |                                ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:75:32: warning: 'dc_fixpt_ln2' defined but not used [-Wunused-const-variable=]
      75 | static const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
         |                                ^~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:74:32: warning: 'dc_fixpt_e' defined but not used [-Wunused-const-variable=]
      74 | static const struct fixed31_32 dc_fixpt_e = { 11674931555LL };
         |                                ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:73:32: warning: 'dc_fixpt_two_pi' defined but not used [-Wunused-const-variable=]
      73 | static const struct fixed31_32 dc_fixpt_two_pi = { 26986075409LL };
         |                                ^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:72:32: warning: 'dc_fixpt_pi' defined but not used [-Wunused-const-variable=]
      72 | static const struct fixed31_32 dc_fixpt_pi = { 13493037705LL };
         |                                ^~~~~~~~~~~


vim +/clk_src +1113 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c

4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1106  
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1107  static uint32_t dcn3_get_pix_clk_dividers(
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1108  		struct clock_source *cs,
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1109  		struct pixel_clk_params *pix_clk_params,
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1110  		struct pll_settings *pll_settings)
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1111  {
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1112  	unsigned long long actual_pix_clk_100Hz = pix_clk_params->requested_pix_clk_100hz;
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21 @1113  	struct dce110_clk_src *clk_src;
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1114  
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1115  	clk_src = TO_DCE110_CLK_SRC(cs);
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1116  	DC_LOGGER_INIT();
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1117  
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1118  	if (pix_clk_params == NULL || pll_settings == NULL
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1119  			|| pix_clk_params->requested_pix_clk_100hz == 0) {
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1120  		DC_LOG_ERROR(
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1121  			"%s: Invalid parameters!!\n", __func__);
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1122  		return -1;
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1123  	}
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1124  
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1125  	memset(pll_settings, 0, sizeof(*pll_settings));
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1126  	/* Adjust for HDMI Type A deep color */
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1127  	if (pix_clk_params->signal_type == SIGNAL_TYPE_HDMI_TYPE_A) {
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1128  		switch (pix_clk_params->color_depth) {
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1129  		case COLOR_DEPTH_101010:
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1130  			actual_pix_clk_100Hz = (actual_pix_clk_100Hz * 5) >> 2;
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1131  			break;
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1132  		case COLOR_DEPTH_121212:
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1133  			actual_pix_clk_100Hz = (actual_pix_clk_100Hz * 6) >> 2;
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1134  			break;
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1135  		case COLOR_DEPTH_161616:
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1136  			actual_pix_clk_100Hz = actual_pix_clk_100Hz * 2;
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1137  			break;
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1138  		default:
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1139  			break;
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1140  		}
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1141  	}
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1142  	pll_settings->actual_pix_clk_100hz = (unsigned int) actual_pix_clk_100Hz;
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1143  	pll_settings->adjusted_pix_clk_100hz = (unsigned int) actual_pix_clk_100Hz;
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1144  	pll_settings->calculated_pix_clk_100hz = (unsigned int) actual_pix_clk_100Hz;
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1145  
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1146  	return 0;
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1147  }
4d55b0dd1cdd85 Bhawanpreet Lakha 2020-05-21  1148  

:::::: The code at line 1113 was first introduced by commit
:::::: 4d55b0dd1cdd8535ffd6057f210465575117d807 drm/amd/display: Add DCN3 CLK_MGR

:::::: TO: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

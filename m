Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C92453D6BF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 14:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbiFDMXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 08:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiFDMXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 08:23:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FED7BE15
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 05:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654345417; x=1685881417;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+R9Qymz/L8hZ0wReWkCLktjzxnyyLmRUHgd06yYdRos=;
  b=iGlF8aPScjBeZNiluIlWyzX3aJCMgHCegCqid3Y3dqOXkwCZbrgh8mbf
   WSAFh3cGbgup3vvpdUpp9x4POz/5zBWCB2mou0QOI7HLx7cO2w5047GhA
   yJvSj8ct7US+Iol+VfgVVkwdqyfZXER7Ghiaee1dExxMmwhPbGZeuu1Ct
   3lU3DPTOspsoqhjySqfa7mp50OJ0bxOd08ynE5ziAJoox5ibf+4vYP2yG
   LroBnppPhboxsNle5i2r6IX9WlVtAsNxHG5URFAPh/XsD/fpMHp3Zb1wc
   dP3UZRpixAAk408T1sfy619Ok6OF/8wO4wapvOwIUkLJAGbO8ovVa8jnK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="273991039"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="273991039"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 05:23:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="668822718"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jun 2022 05:23:35 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxSoZ-000Aox-0p;
        Sat, 04 Jun 2022 12:23:35 +0000
Date:   Sat, 4 Jun 2022 20:22:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [agd5f:drm-next 36/63]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_dccg.c:664:6: warning:
 no previous prototype for 'dccg31_otg_add_pixel'
Message-ID: <202206042022.JhJXBMCY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   0401cdad37f8a62e64363b2a6fc16c7fafba66e2
commit: 9b0e0d433f743790e4afde2b81fc30d8f8beb7d7 [36/63] drm/amd/display: Add dependant changes for DCN32/321
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220604/202206042022.JhJXBMCY-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 9b0e0d433f743790e4afde2b81fc30d8f8beb7d7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_dccg.c:664:6: warning: no previous prototype for 'dccg31_otg_add_pixel' [-Wmissing-prototypes]
     664 | void dccg31_otg_add_pixel(struct dccg *dccg,
         |      ^~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_dccg.c:673:6: warning: no previous prototype for 'dccg31_otg_drop_pixel' [-Wmissing-prototypes]
     673 | void dccg31_otg_drop_pixel(struct dccg *dccg,
         |      ^~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_dccg.c:27:
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
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:892:17: note: in expansion of macro 'HWSEQ_DCN32_MASK_SH_LIST'
     892 |                 HWSEQ_DCN32_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_2_0_sh_mask.h:2823:111: warning: initialized field overwritten [-Woverride-init]
    2823 | #define DOMAIN16_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN16_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:876:9: note: in expansion of macro 'HWS_SF'
     876 |         HWS_SF(, DOMAIN16_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:892:17: note: in expansion of macro 'HWSEQ_DCN32_MASK_SH_LIST'
     892 |                 HWSEQ_DCN32_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_2_0_sh_mask.h:2823:111: note: (near initialization for 'hwseq_mask.DOMAIN_PGFSM_PWR_STATUS')
    2823 | #define DOMAIN16_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN16_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:876:9: note: in expansion of macro 'HWS_SF'
     876 |         HWS_SF(, DOMAIN16_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:892:17: note: in expansion of macro 'HWSEQ_DCN32_MASK_SH_LIST'
     892 |                 HWSEQ_DCN32_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_2_0_sh_mask.h:2833:111: warning: initialized field overwritten [-Woverride-init]
    2833 | #define DOMAIN17_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN17_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:877:9: note: in expansion of macro 'HWS_SF'
     877 |         HWS_SF(, DOMAIN17_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:892:17: note: in expansion of macro 'HWSEQ_DCN32_MASK_SH_LIST'
     892 |                 HWSEQ_DCN32_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_2_0_sh_mask.h:2833:111: note: (near initialization for 'hwseq_mask.DOMAIN_PGFSM_PWR_STATUS')
    2833 | #define DOMAIN17_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN17_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:877:9: note: in expansion of macro 'HWS_SF'
     877 |         HWS_SF(, DOMAIN17_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:892:17: note: in expansion of macro 'HWSEQ_DCN32_MASK_SH_LIST'
     892 |                 HWSEQ_DCN32_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_2_0_sh_mask.h:2843:111: warning: initialized field overwritten [-Woverride-init]
    2843 | #define DOMAIN18_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN18_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:878:9: note: in expansion of macro 'HWS_SF'
     878 |         HWS_SF(, DOMAIN18_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:892:17: note: in expansion of macro 'HWSEQ_DCN32_MASK_SH_LIST'
     892 |                 HWSEQ_DCN32_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_2_0_sh_mask.h:2843:111: note: (near initialization for 'hwseq_mask.DOMAIN_PGFSM_PWR_STATUS')
    2843 | #define DOMAIN18_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN18_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:878:9: note: in expansion of macro 'HWS_SF'
     878 |         HWS_SF(, DOMAIN18_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:892:17: note: in expansion of macro 'HWSEQ_DCN32_MASK_SH_LIST'
     892 |                 HWSEQ_DCN32_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_2_0_sh_mask.h:2853:111: warning: initialized field overwritten [-Woverride-init]
    2853 | #define DOMAIN19_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN19_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:879:9: note: in expansion of macro 'HWS_SF'
     879 |         HWS_SF(, DOMAIN19_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:892:17: note: in expansion of macro 'HWSEQ_DCN32_MASK_SH_LIST'
     892 |                 HWSEQ_DCN32_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_2_0_sh_mask.h:2853:111: note: (near initialization for 'hwseq_mask.DOMAIN_PGFSM_PWR_STATUS')
    2853 | #define DOMAIN19_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN19_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:879:9: note: in expansion of macro 'HWS_SF'
     879 |         HWS_SF(, DOMAIN19_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:892:17: note: in expansion of macro 'HWSEQ_DCN32_MASK_SH_LIST'
     892 |                 HWSEQ_DCN32_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c: In function 'dcn32_acquire_post_bldn_3dlut':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:1716:31: warning: variable 'state' set but not used [-Wunused-but-set-variable]
    1716 |         union dc_3dlut_state *state;
         |                               ^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c: At top level:
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:3029:6: warning: no previous prototype for 'dcn32_calculate_wm_and_dlg_fp' [-Wmissing-prototypes]
    3029 | void dcn32_calculate_wm_and_dlg_fp(
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/resource.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:32:
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
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hubbub.c:712:6: warning: no previous prototype for 'hubbub32_force_usr_retraining_allow' [-Wmissing-prototypes]
     712 | void hubbub32_force_usr_retraining_allow(struct hubbub *hubbub, bool allow)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hubbub.c:772:6: warning: no previous prototype for 'hubbub32_init_watermarks' [-Wmissing-prototypes]
     772 | void hubbub32_init_watermarks(struct hubbub *hubbub)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hubbub.c:823:6: warning: no previous prototype for 'hubbub32_wm_read_state' [-Wmissing-prototypes]
     823 | void hubbub32_wm_read_state(struct hubbub *hubbub,
         |      ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hubbub.c:912:6: warning: no previous prototype for 'hubbub32_force_wm_propagate_to_pipes' [-Wmissing-prototypes]
     912 | void hubbub32_force_wm_propagate_to_pipes(struct hubbub *hubbub)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hubbub.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hubbub.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubbub.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hubbub.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hubbub.c:27:
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
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_init.c:146:6: warning: no previous prototype for 'dcn32_hw_sequencer_init_functions' [-Wmissing-prototypes]
     146 | void dcn32_hw_sequencer_init_functions(struct dc *dc)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_init.c:26:
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
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dccg.c:142:6: warning: no previous prototype for 'dccg32_set_dtbclk_dto' [-Wmissing-prototypes]
     142 | void dccg32_set_dtbclk_dto(
         |      ^~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dccg.c:198:6: warning: no previous prototype for 'dccg32_set_dpstreamclk' [-Wmissing-prototypes]
     198 | void dccg32_set_dpstreamclk(
         |      ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dccg.c:234:6: warning: no previous prototype for 'dccg32_otg_add_pixel' [-Wmissing-prototypes]
     234 | void dccg32_otg_add_pixel(struct dccg *dccg,
         |      ^~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dccg.c:243:6: warning: no previous prototype for 'dccg32_otg_drop_pixel' [-Wmissing-prototypes]
     243 | void dccg32_otg_drop_pixel(struct dccg *dccg,
         |      ^~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dccg.c:27:
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
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_optc.c:157:6: warning: no previous prototype for 'optc32_phantom_crtc_post_enable' [-Wmissing-prototypes]
     157 | void optc32_phantom_crtc_post_enable(struct timing_generator *optc)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_mmhubbub.c:103:6: warning: no previous prototype for 'mmhubbub32_config_mcif_buf' [-Wmissing-prototypes]
     103 | void mmhubbub32_config_mcif_buf(struct mcif_wb *mcif_wb,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/resource.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_mmhubbub.c:28:
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
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dpp.c:34:6: warning: no previous prototype for 'dscl32_calc_lb_num_partitions' [-Wmissing-prototypes]
      34 | void dscl32_calc_lb_num_partitions(
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dpp.c:27:
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
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dio_stream_encoder.c:63:6: warning: no previous prototype for 'enc32_stream_encoder_dvi_set_stream_attribute' [-Wmissing-prototypes]
      63 | void enc32_stream_encoder_dvi_set_stream_attribute(
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dio_link_encoder.c:65:6: warning: no previous prototype for 'enc32_hw_init' [-Wmissing-prototypes]
      65 | void enc32_hw_init(struct link_encoder *enc)
         |      ^~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dio_link_encoder.c:109:6: warning: no previous prototype for 'dcn32_link_encoder_enable_dp_output' [-Wmissing-prototypes]
     109 | void dcn32_link_encoder_enable_dp_output(
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dio_link_encoder.c:120:6: warning: no previous prototype for 'dcn32_link_encoder_is_in_alt_mode' [-Wmissing-prototypes]
     120 | bool dcn32_link_encoder_is_in_alt_mode(struct link_encoder *enc)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dio_link_encoder.c: In function 'dcn32_link_encoder_is_in_alt_mode':
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dio_link_encoder.c:122:36: warning: unused variable 'enc10' [-Wunused-variable]
     122 |         struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
         |                                    ^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dio_link_encoder.c: At top level:
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dio_link_encoder.c:135:6: warning: no previous prototype for 'dcn32_link_encoder_get_max_link_cap' [-Wmissing-prototypes]
     135 | void dcn32_link_encoder_get_max_link_cap(struct link_encoder *enc,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dio_link_encoder.c: In function 'dcn32_link_encoder_get_max_link_cap':
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dio_link_encoder.c:138:36: warning: unused variable 'enc10' [-Wunused-variable]
     138 |         struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
         |                                    ^~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dio_link_encoder.c:29:
   At top level:
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
..


vim +/dccg31_otg_add_pixel +664 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_dccg.c

   663	
 > 664	void dccg31_otg_add_pixel(struct dccg *dccg,
   665			uint32_t otg_inst)
   666	{
   667		struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
   668	
   669		REG_UPDATE(OTG_PIXEL_RATE_CNTL[otg_inst],
   670				OTG_ADD_PIXEL[otg_inst], 1);
   671	}
   672	
 > 673	void dccg31_otg_drop_pixel(struct dccg *dccg,
   674			uint32_t otg_inst)
   675	{
   676		struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
   677	
   678		REG_UPDATE(OTG_PIXEL_RATE_CNTL[otg_inst],
   679				OTG_DROP_PIXEL[otg_inst], 1);
   680	}
   681	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

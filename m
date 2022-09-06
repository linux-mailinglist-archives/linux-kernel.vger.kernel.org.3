Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8B25ADCE0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 03:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiIFBZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 21:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiIFBZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 21:25:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C57F28E2A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 18:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662427509; x=1693963509;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FV42WX/Fpzy1hP3IDKmYXHZ7KgovfI934xBrTm4gD9M=;
  b=b5rIqfkh2xwLQCv0bxo6WLDp1V2ygbMtIExw9HXNGPqCc/3wb7h3d6ha
   bxMg/7i+lKuxZr5kF2rj3O2ob0gOYv/lX26VV50LQDmDmChm98c8aH5eC
   nHHmy7E57+GUKtekd2/w5W50lXbJY0aY5XYz6EquPtSU2l3P1mCjXXfmt
   pMi+2Ecg1PnBOCwP2NCI0eA7onYbAga4qJ5E5aqIqqFEVtFlaZ7C2rQB+
   kBwshPNn4aYC8uNl8zhRCQMSqCJH63YWdRjh3eMQ0aLjhfHRHeCXBmE5T
   LW0+Vpwv5QMUG3NAYYXgriuiNaI8VUXAbNUy01TZ3j0Nmpj7eQnMHudTl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="382771510"
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="382771510"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 18:25:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="942263870"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 05 Sep 2022 18:25:05 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVNKq-0004i1-3C;
        Tue, 06 Sep 2022 01:25:04 +0000
Date:   Tue, 6 Sep 2022 09:24:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dccg.c:142:6:
 warning: no previous prototype for 'dccg32_set_dtbclk_dto'
Message-ID: <202209060918.ZYOpWa61-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aurabindo,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   53e99dcff61e1523ec1c3628b2d564ba15d32eb7
commit: d3dfceb58de5f897640cdd424f6c2538d9514367 drm/amd/display: Add dependant changes for DCN32/321
date:   3 months ago
config: i386-buildonly-randconfig-r004-20220905 (https://download.01.org/0day-ci/archive/20220906/202209060918.ZYOpWa61-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d3dfceb58de5f897640cdd424f6c2538d9514367
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d3dfceb58de5f897640cdd424f6c2538d9514367
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

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
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:3029:6: warning: no previous prototype for 'dcn32_calculate_wm_and_dlg_fp' [-Wmissing-prototypes]
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
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_mpc.c:475:6: warning: no previous prototype for 'mpc32_program_shaper' [-Wmissing-prototypes]
     475 | bool mpc32_program_shaper(
         |      ^~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_mpc.c:667:6: warning: no previous prototype for 'mpc32_program_3dlut' [-Wmissing-prototypes]
     667 | bool mpc32_program_3dlut(
         |      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_mpc.c:786:6: warning: no previous prototype for 'dcn32_mpc_construct' [-Wmissing-prototypes]
     786 | void dcn32_mpc_construct(struct dcn30_mpc *mpc30,
         |      ^~~~~~~~~~~~~~~~~~~
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_optc.c:107: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Enable CRTC


vim +/dccg32_set_dtbclk_dto +142 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_dccg.c

235c67634230b0 Aurabindo Pillai 2022-02-23  140  
235c67634230b0 Aurabindo Pillai 2022-02-23  141  /* Controls the generation of pixel valid for OTG in (OTG -> HPO case) */
235c67634230b0 Aurabindo Pillai 2022-02-23 @142  void dccg32_set_dtbclk_dto(
235c67634230b0 Aurabindo Pillai 2022-02-23  143  		struct dccg *dccg,
d3dfceb58de5f8 Aurabindo Pillai 2022-02-23  144  		const struct dtbclk_dto_params *params)
235c67634230b0 Aurabindo Pillai 2022-02-23  145  {
235c67634230b0 Aurabindo Pillai 2022-02-23  146  	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
235c67634230b0 Aurabindo Pillai 2022-02-23  147  	/* DTO Output Rate / Pixel Rate = 1/4 */
d3dfceb58de5f8 Aurabindo Pillai 2022-02-23  148  	int req_dtbclk_khz = params->pixclk_khz / 4;
235c67634230b0 Aurabindo Pillai 2022-02-23  149  
d3dfceb58de5f8 Aurabindo Pillai 2022-02-23  150  	if (params->ref_dtbclk_khz && req_dtbclk_khz) {
235c67634230b0 Aurabindo Pillai 2022-02-23  151  		uint32_t modulo, phase;
235c67634230b0 Aurabindo Pillai 2022-02-23  152  
235c67634230b0 Aurabindo Pillai 2022-02-23  153  		// phase / modulo = dtbclk / dtbclk ref
d3dfceb58de5f8 Aurabindo Pillai 2022-02-23  154  		modulo = params->ref_dtbclk_khz * 1000;
d3dfceb58de5f8 Aurabindo Pillai 2022-02-23  155  		phase = req_dtbclk_khz * 1000;
235c67634230b0 Aurabindo Pillai 2022-02-23  156  
d3dfceb58de5f8 Aurabindo Pillai 2022-02-23  157  		REG_WRITE(DTBCLK_DTO_MODULO[params->otg_inst], modulo);
d3dfceb58de5f8 Aurabindo Pillai 2022-02-23  158  		REG_WRITE(DTBCLK_DTO_PHASE[params->otg_inst], phase);
235c67634230b0 Aurabindo Pillai 2022-02-23  159  
d3dfceb58de5f8 Aurabindo Pillai 2022-02-23  160  		REG_UPDATE(OTG_PIXEL_RATE_CNTL[params->otg_inst],
d3dfceb58de5f8 Aurabindo Pillai 2022-02-23  161  				DTBCLK_DTO_ENABLE[params->otg_inst], 1);
235c67634230b0 Aurabindo Pillai 2022-02-23  162  
d3dfceb58de5f8 Aurabindo Pillai 2022-02-23  163  		REG_WAIT(OTG_PIXEL_RATE_CNTL[params->otg_inst],
d3dfceb58de5f8 Aurabindo Pillai 2022-02-23  164  				DTBCLKDTO_ENABLE_STATUS[params->otg_inst], 1,
235c67634230b0 Aurabindo Pillai 2022-02-23  165  				1, 100);
235c67634230b0 Aurabindo Pillai 2022-02-23  166  
235c67634230b0 Aurabindo Pillai 2022-02-23  167  		/* program OTG_PIXEL_RATE_DIV for DIVK1 and DIVK2 fields */
d3dfceb58de5f8 Aurabindo Pillai 2022-02-23  168  		dccg32_set_pixel_rate_div(dccg, params->otg_inst, PIXEL_RATE_DIV_BY_1, PIXEL_RATE_DIV_BY_1);
235c67634230b0 Aurabindo Pillai 2022-02-23  169  
235c67634230b0 Aurabindo Pillai 2022-02-23  170  		/* The recommended programming sequence to enable DTBCLK DTO to generate
235c67634230b0 Aurabindo Pillai 2022-02-23  171  		 * valid pixel HPO DPSTREAM ENCODER, specifies that DTO source select should
235c67634230b0 Aurabindo Pillai 2022-02-23  172  		 * be set only after DTO is enabled
235c67634230b0 Aurabindo Pillai 2022-02-23  173  		 */
d3dfceb58de5f8 Aurabindo Pillai 2022-02-23  174  		REG_UPDATE(OTG_PIXEL_RATE_CNTL[params->otg_inst],
d3dfceb58de5f8 Aurabindo Pillai 2022-02-23  175  				PIPE_DTO_SRC_SEL[params->otg_inst], 2);
235c67634230b0 Aurabindo Pillai 2022-02-23  176  	} else {
d3dfceb58de5f8 Aurabindo Pillai 2022-02-23  177  		REG_UPDATE_2(OTG_PIXEL_RATE_CNTL[params->otg_inst],
d3dfceb58de5f8 Aurabindo Pillai 2022-02-23  178  				DTBCLK_DTO_ENABLE[params->otg_inst], 0,
d3dfceb58de5f8 Aurabindo Pillai 2022-02-23  179  				PIPE_DTO_SRC_SEL[params->otg_inst], 1);
235c67634230b0 Aurabindo Pillai 2022-02-23  180  
d3dfceb58de5f8 Aurabindo Pillai 2022-02-23  181  		REG_WRITE(DTBCLK_DTO_MODULO[params->otg_inst], 0);
d3dfceb58de5f8 Aurabindo Pillai 2022-02-23  182  		REG_WRITE(DTBCLK_DTO_PHASE[params->otg_inst], 0);
235c67634230b0 Aurabindo Pillai 2022-02-23  183  	}
235c67634230b0 Aurabindo Pillai 2022-02-23  184  }
235c67634230b0 Aurabindo Pillai 2022-02-23  185  
235c67634230b0 Aurabindo Pillai 2022-02-23  186  static void dccg32_get_dccg_ref_freq(struct dccg *dccg,
235c67634230b0 Aurabindo Pillai 2022-02-23  187  		unsigned int xtalin_freq_inKhz,
235c67634230b0 Aurabindo Pillai 2022-02-23  188  		unsigned int *dccg_ref_freq_inKhz)
235c67634230b0 Aurabindo Pillai 2022-02-23  189  {
235c67634230b0 Aurabindo Pillai 2022-02-23  190  	/*
235c67634230b0 Aurabindo Pillai 2022-02-23  191  	 * Assume refclk is sourced from xtalin
235c67634230b0 Aurabindo Pillai 2022-02-23  192  	 * expect 100MHz
235c67634230b0 Aurabindo Pillai 2022-02-23  193  	 */
235c67634230b0 Aurabindo Pillai 2022-02-23  194  	*dccg_ref_freq_inKhz = xtalin_freq_inKhz;
235c67634230b0 Aurabindo Pillai 2022-02-23  195  	return;
235c67634230b0 Aurabindo Pillai 2022-02-23  196  }
235c67634230b0 Aurabindo Pillai 2022-02-23  197  
235c67634230b0 Aurabindo Pillai 2022-02-23 @198  void dccg32_set_dpstreamclk(
235c67634230b0 Aurabindo Pillai 2022-02-23  199  		struct dccg *dccg,
235c67634230b0 Aurabindo Pillai 2022-02-23  200  		enum streamclk_source src,
235c67634230b0 Aurabindo Pillai 2022-02-23  201  		int otg_inst)
235c67634230b0 Aurabindo Pillai 2022-02-23  202  {
235c67634230b0 Aurabindo Pillai 2022-02-23  203  	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
235c67634230b0 Aurabindo Pillai 2022-02-23  204  
235c67634230b0 Aurabindo Pillai 2022-02-23  205  	/* set the dtbclk_p source */
235c67634230b0 Aurabindo Pillai 2022-02-23  206  	dccg32_set_dtbclk_p_src(dccg, src, otg_inst);
235c67634230b0 Aurabindo Pillai 2022-02-23  207  
235c67634230b0 Aurabindo Pillai 2022-02-23  208  	/* enabled to select one of the DTBCLKs for pipe */
235c67634230b0 Aurabindo Pillai 2022-02-23  209  	switch (otg_inst)
235c67634230b0 Aurabindo Pillai 2022-02-23  210  	{
235c67634230b0 Aurabindo Pillai 2022-02-23  211  	case 0:
235c67634230b0 Aurabindo Pillai 2022-02-23  212  		REG_UPDATE_2(DPSTREAMCLK_CNTL,
235c67634230b0 Aurabindo Pillai 2022-02-23  213  			     DPSTREAMCLK0_EN,
235c67634230b0 Aurabindo Pillai 2022-02-23  214  			     (src == REFCLK) ? 0 : 1, DPSTREAMCLK0_SRC_SEL, 0);
235c67634230b0 Aurabindo Pillai 2022-02-23  215  		break;
235c67634230b0 Aurabindo Pillai 2022-02-23  216  	case 1:
235c67634230b0 Aurabindo Pillai 2022-02-23  217  		REG_UPDATE_2(DPSTREAMCLK_CNTL, DPSTREAMCLK1_EN,
235c67634230b0 Aurabindo Pillai 2022-02-23  218  			     (src == REFCLK) ? 0 : 1, DPSTREAMCLK1_SRC_SEL, 1);
235c67634230b0 Aurabindo Pillai 2022-02-23  219  		break;
235c67634230b0 Aurabindo Pillai 2022-02-23  220  	case 2:
235c67634230b0 Aurabindo Pillai 2022-02-23  221  		REG_UPDATE_2(DPSTREAMCLK_CNTL, DPSTREAMCLK2_EN,
235c67634230b0 Aurabindo Pillai 2022-02-23  222  			     (src == REFCLK) ? 0 : 1, DPSTREAMCLK2_SRC_SEL, 2);
235c67634230b0 Aurabindo Pillai 2022-02-23  223  		break;
235c67634230b0 Aurabindo Pillai 2022-02-23  224  	case 3:
235c67634230b0 Aurabindo Pillai 2022-02-23  225  		REG_UPDATE_2(DPSTREAMCLK_CNTL, DPSTREAMCLK3_EN,
235c67634230b0 Aurabindo Pillai 2022-02-23  226  			     (src == REFCLK) ? 0 : 1, DPSTREAMCLK3_SRC_SEL, 3);
235c67634230b0 Aurabindo Pillai 2022-02-23  227  		break;
235c67634230b0 Aurabindo Pillai 2022-02-23  228  	default:
235c67634230b0 Aurabindo Pillai 2022-02-23  229  		BREAK_TO_DEBUGGER();
235c67634230b0 Aurabindo Pillai 2022-02-23  230  		return;
235c67634230b0 Aurabindo Pillai 2022-02-23  231  	}
235c67634230b0 Aurabindo Pillai 2022-02-23  232  }
235c67634230b0 Aurabindo Pillai 2022-02-23  233  
235c67634230b0 Aurabindo Pillai 2022-02-23 @234  void dccg32_otg_add_pixel(struct dccg *dccg,
235c67634230b0 Aurabindo Pillai 2022-02-23  235  		uint32_t otg_inst)
235c67634230b0 Aurabindo Pillai 2022-02-23  236  {
235c67634230b0 Aurabindo Pillai 2022-02-23  237  	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
235c67634230b0 Aurabindo Pillai 2022-02-23  238  
235c67634230b0 Aurabindo Pillai 2022-02-23  239  	REG_UPDATE(OTG_PIXEL_RATE_CNTL[otg_inst],
235c67634230b0 Aurabindo Pillai 2022-02-23  240  			OTG_ADD_PIXEL[otg_inst], 1);
235c67634230b0 Aurabindo Pillai 2022-02-23  241  }
235c67634230b0 Aurabindo Pillai 2022-02-23  242  
235c67634230b0 Aurabindo Pillai 2022-02-23 @243  void dccg32_otg_drop_pixel(struct dccg *dccg,
235c67634230b0 Aurabindo Pillai 2022-02-23  244  		uint32_t otg_inst)
235c67634230b0 Aurabindo Pillai 2022-02-23  245  {
235c67634230b0 Aurabindo Pillai 2022-02-23  246  	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
235c67634230b0 Aurabindo Pillai 2022-02-23  247  
235c67634230b0 Aurabindo Pillai 2022-02-23  248  	REG_UPDATE(OTG_PIXEL_RATE_CNTL[otg_inst],
235c67634230b0 Aurabindo Pillai 2022-02-23  249  			OTG_DROP_PIXEL[otg_inst], 1);
235c67634230b0 Aurabindo Pillai 2022-02-23  250  }
235c67634230b0 Aurabindo Pillai 2022-02-23  251  

:::::: The code at line 142 was first introduced by commit
:::::: 235c67634230b0f9ad8c0185272fed36c892b1c4 drm/amd/display: add DCN32/321 specific files for Display Core

:::::: TO: Aurabindo Pillai <aurabindo.pillai@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

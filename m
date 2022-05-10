Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFC95212F7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240525AbiEJLCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240470AbiEJLC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:02:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9FF2311C4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652180310; x=1683716310;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hXtxTLWjRw77FTEFJybiBu2bHX2PKC9r5af4RVYhk7E=;
  b=RFS6JbPBpZqFiqXEdcSexVb9lLopuZjUCaAtbwnxjpV34JKQQSm3nrb8
   D+lXtOxZLl62KByDriNcEMYyxmVV5jN9Jvn20jet6bdT2YJylbSgdckoD
   IJTVarB/4596Pft3DJqyjZHJobf4i/3/Zy33T6hCgyR0PUL2mEECBI/v8
   kCO0Csw3w6CYRDN6JDaEMCQRJqfliTGVY5IC58zqTcPx22fSGcnbPRcOg
   dds2k/Vv7X7jIB+6D3jy54S6/Q5KxiZ/a5xb/8AagswbBl9M2fm0jtDxF
   MLB2v3keMeFWlE57o8zW66X/SqWjCYegj3gWCVoRwP0a2h1IXfgOJeNNi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="249867510"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="249867510"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 03:58:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="541722567"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 10 May 2022 03:58:26 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noNZR-000Hjm-MR;
        Tue, 10 May 2022 10:58:25 +0000
Date:   Tue, 10 May 2022 18:58:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robin Chen <po-tchen@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:121:22:
 warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used
Message-ID: <202205101837.hI7VSSFg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9be9ed2612b5aedb52a2c240edb1630b6b743cb6
commit: 548f212514151b0d6ec911c87e61f189f530255b drm/amd/display: To support sending TPS3 pattern when restoring link
date:   6 months ago
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220510/202205101837.hI7VSSFg-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=548f212514151b0d6ec911c87e61f189f530255b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 548f212514151b0d6ec911c87e61f189f530255b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:244:19: note: in expansion of macro 'BASE_INNER'
     244 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:247:29: note: in expansion of macro 'BASE'
     247 |                 .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
         |                             ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:386:9: note: in expansion of macro 'SR'
     386 |         SR(MPC_CRC_RESULT_GB), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:753:17: note: in expansion of macro 'HWSEQ_DCN30_REG_LIST'
     753 |                 HWSEQ_DCN30_REG_LIST()
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:373:52: warning: initialized field overwritten [-Woverride-init]
     373 | #define DCN_BASE__INST0_SEG3                       0x00009000
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:242:25: note: in expansion of macro 'DCN_BASE__INST0_SEG3'
     242 | #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:244:19: note: in expansion of macro 'BASE_INNER'
     244 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:247:29: note: in expansion of macro 'BASE'
     247 |                 .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
         |                             ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:387:9: note: in expansion of macro 'SR'
     387 |         SR(MPC_CRC_RESULT_C), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:753:17: note: in expansion of macro 'HWSEQ_DCN30_REG_LIST'
     753 |                 HWSEQ_DCN30_REG_LIST()
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:373:52: note: (near initialization for 'hwseq_reg.MPC_CRC_RESULT_C')
     373 | #define DCN_BASE__INST0_SEG3                       0x00009000
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:242:25: note: in expansion of macro 'DCN_BASE__INST0_SEG3'
     242 | #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:244:19: note: in expansion of macro 'BASE_INNER'
     244 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:247:29: note: in expansion of macro 'BASE'
     247 |                 .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
         |                             ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:387:9: note: in expansion of macro 'SR'
     387 |         SR(MPC_CRC_RESULT_C), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:753:17: note: in expansion of macro 'HWSEQ_DCN30_REG_LIST'
     753 |                 HWSEQ_DCN30_REG_LIST()
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:373:52: warning: initialized field overwritten [-Woverride-init]
     373 | #define DCN_BASE__INST0_SEG3                       0x00009000
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:242:25: note: in expansion of macro 'DCN_BASE__INST0_SEG3'
     242 | #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:244:19: note: in expansion of macro 'BASE_INNER'
     244 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:247:29: note: in expansion of macro 'BASE'
     247 |                 .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
         |                             ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:388:9: note: in expansion of macro 'SR'
     388 |         SR(MPC_CRC_RESULT_AR), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:753:17: note: in expansion of macro 'HWSEQ_DCN30_REG_LIST'
     753 |                 HWSEQ_DCN30_REG_LIST()
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:373:52: note: (near initialization for 'hwseq_reg.MPC_CRC_RESULT_AR')
     373 | #define DCN_BASE__INST0_SEG3                       0x00009000
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:242:25: note: in expansion of macro 'DCN_BASE__INST0_SEG3'
     242 | #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:244:19: note: in expansion of macro 'BASE_INNER'
     244 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:247:29: note: in expansion of macro 'BASE'
     247 |                 .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
         |                             ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:388:9: note: in expansion of macro 'SR'
     388 |         SR(MPC_CRC_RESULT_AR), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:753:17: note: in expansion of macro 'HWSEQ_DCN30_REG_LIST'
     753 |                 HWSEQ_DCN30_REG_LIST()
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:878:6: warning: no previous prototype for 'dcn30_dpp_destroy' [-Wmissing-prototypes]
     878 | void dcn30_dpp_destroy(struct dpp **dpp)
         |      ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:995:16: warning: no previous prototype for 'dcn30_hubbub_create' [-Wmissing-prototypes]
     995 | struct hubbub *dcn30_hubbub_create(struct dc_context *ctx)
         |                ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:1146:24: warning: no previous prototype for 'dcn30_stream_encoder_create' [-Wmissing-prototypes]
    1146 | struct stream_encoder *dcn30_stream_encoder_create(
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:1182:19: warning: no previous prototype for 'dcn30_hwseq_create' [-Wmissing-prototypes]
    1182 | struct dce_hwseq *dcn30_hwseq_create(
         |                   ^~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/resource.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:32:
>> drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:121:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     121 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:120:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     120 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_init.c:143:6: warning: no previous prototype for 'dcn301_hw_sequencer_construct' [-Wmissing-prototypes]
     143 | void dcn301_hw_sequencer_construct(struct dc *dc)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_init.c:26:
>> drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:121:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     121 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:120:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     120 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:110:25: note: in expansion of macro 'DCN_BASE__INST0_SEG2'
     110 | #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:112:19: note: in expansion of macro 'BASE_INNER'
     112 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:115:29: note: in expansion of macro 'BASE'
     115 |                 .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
         |                             ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubbub.h:42:9: note: in expansion of macro 'SR'
      42 |         SR(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_D),\
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_hubbub.h:33:9: note: in expansion of macro 'HUBBUB_HVM_REG_LIST'
      33 |         HUBBUB_HVM_REG_LIST()
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:569:17: note: in expansion of macro 'HUBBUB_REG_LIST_DCN301'
     569 |                 HUBBUB_REG_LIST_DCN301(0)
         |                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:454:52: warning: initialized field overwritten [-Woverride-init]
     454 | #define DCN_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:110:25: note: in expansion of macro 'DCN_BASE__INST0_SEG2'
     110 | #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:112:19: note: in expansion of macro 'BASE_INNER'
     112 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:115:29: note: in expansion of macro 'BASE'
     115 |                 .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
         |                             ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:399:9: note: in expansion of macro 'SR'
     399 |         SR(DCFCLK_CNTL), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:593:17: note: in expansion of macro 'HWSEQ_DCN301_REG_LIST'
     593 |                 HWSEQ_DCN301_REG_LIST()
         |                 ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:454:52: note: (near initialization for 'hwseq_reg.DCFCLK_CNTL')
     454 | #define DCN_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:110:25: note: in expansion of macro 'DCN_BASE__INST0_SEG2'
     110 | #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:112:19: note: in expansion of macro 'BASE_INNER'
     112 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:115:29: note: in expansion of macro 'BASE'
     115 |                 .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
         |                             ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:399:9: note: in expansion of macro 'SR'
     399 |         SR(DCFCLK_CNTL), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:593:17: note: in expansion of macro 'HWSEQ_DCN301_REG_LIST'
     593 |                 HWSEQ_DCN301_REG_LIST()
         |                 ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:720:6: warning: no previous prototype for 'dcn301_dpp_destroy' [-Wmissing-prototypes]
     720 | void dcn301_dpp_destroy(struct dpp **dpp)
         |      ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:726:13: warning: no previous prototype for 'dcn301_dpp_create' [-Wmissing-prototypes]
     726 | struct dpp *dcn301_dpp_create(
         |             ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:744:32: warning: no previous prototype for 'dcn301_opp_create' [-Wmissing-prototypes]
     744 | struct output_pixel_processor *dcn301_opp_create(
         |                                ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:760:17: warning: no previous prototype for 'dcn301_aux_engine_create' [-Wmissing-prototypes]
     760 | struct dce_aux *dcn301_aux_engine_create(
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:796:20: warning: no previous prototype for 'dcn301_i2c_hw_create' [-Wmissing-prototypes]
     796 | struct dce_i2c_hw *dcn301_i2c_hw_create(
         |                    ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:832:16: warning: no previous prototype for 'dcn301_hubbub_create' [-Wmissing-prototypes]
     832 | struct hubbub *dcn301_hubbub_create(struct dc_context *ctx)
         |                ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:863:26: warning: no previous prototype for 'dcn301_timing_generator_create' [-Wmissing-prototypes]
     863 | struct timing_generator *dcn301_timing_generator_create(
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:897:22: warning: no previous prototype for 'dcn301_link_encoder_create' [-Wmissing-prototypes]
     897 | struct link_encoder *dcn301_link_encoder_create(
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:918:20: warning: no previous prototype for 'dcn301_panel_cntl_create' [-Wmissing-prototypes]
     918 | struct panel_cntl *dcn301_panel_cntl_create(const struct panel_cntl_init_data *init_data)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:1000:24: warning: no previous prototype for 'dcn301_stream_encoder_create' [-Wmissing-prototypes]
    1000 | struct stream_encoder *dcn301_stream_encoder_create(
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:1036:19: warning: no previous prototype for 'dcn301_hwseq_create' [-Wmissing-prototypes]
    1036 | struct dce_hwseq *dcn301_hwseq_create(
         |                   ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:1185:14: warning: no previous prototype for 'dcn301_hubp_create' [-Wmissing-prototypes]
    1185 | struct hubp *dcn301_hubp_create(
         |              ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:1204:6: warning: no previous prototype for 'dcn301_dwbc_create' [-Wmissing-prototypes]
    1204 | bool dcn301_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
         |      ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:1229:6: warning: no previous prototype for 'dcn301_mmhubbub_create' [-Wmissing-prototypes]
    1229 | bool dcn301_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/resource.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:32:
>> drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:121:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     121 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:120:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     120 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dce110/irq_service_dce110.c:40:
>> drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:121:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     121 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:120:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     120 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dmub/dmub_srv.h:67,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:48:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h: In function 'dmub_rb_flush_pending':
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2892:26: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
    2892 |                 uint64_t temp;
         |                          ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c: In function 'dcn30_enable_writeback':
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:324:34: warning: variable 'optc' set but not used [-Wunused-but-set-variable]
     324 |         struct timing_generator *optc;
         |                                  ^~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:29:
   At top level:
>> drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:121:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     121 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:120:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     120 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dmub/dmub_srv.h:67,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_panel_cntl.c:28:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h: In function 'dmub_rb_flush_pending':
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2892:26: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
    2892 |                 uint64_t temp;
         |                          ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_panel_cntl.c: At top level:
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_panel_cntl.c:96:10: warning: no previous prototype for 'dcn301_panel_cntl_hw_init' [-Wmissing-prototypes]
      96 | uint32_t dcn301_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_panel_cntl.c:150:6: warning: no previous prototype for 'dcn301_panel_cntl_destroy' [-Wmissing-prototypes]
     150 | void dcn301_panel_cntl_destroy(struct panel_cntl **panel_cntl)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_panel_cntl.c:158:6: warning: no previous prototype for 'dcn301_is_panel_backlight_on' [-Wmissing-prototypes]
     158 | bool dcn301_is_panel_backlight_on(struct panel_cntl *panel_cntl)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_panel_cntl.c:168:6: warning: no previous prototype for 'dcn301_is_panel_powered_on' [-Wmissing-prototypes]
     168 | bool dcn301_is_panel_powered_on(struct panel_cntl *panel_cntl)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_panel_cntl.c:180:6: warning: no previous prototype for 'dcn301_store_backlight_level' [-Wmissing-prototypes]
     180 | void dcn301_store_backlight_level(struct panel_cntl *panel_cntl)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_panel_cntl.c:27:
>> drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:121:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     121 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:120:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     120 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
     207 |         SRI(TMDS_CTL_BITS, DIG, id), \
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_link_encoder.h:238:9: note: in expansion of macro 'DPCS_DCN2_CMN_REG_LIST'
     238 |         DPCS_DCN2_CMN_REG_LIST(id), \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:980:33: note: in expansion of macro 'DPCS_DCN2_REG_LIST'
     980 |                                 DPCS_DCN2_REG_LIST(id), \
         |                                 ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:989:17: note: in expansion of macro 'link_regs'
     989 |                 link_regs(4, E)
         |                 ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/dimgrey_cavefish_ip_offset.h:365:52: note: (near initialization for 'link_enc_regs[4].TMDS_CTL_BITS')
     365 | #define DCN_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:310:25: note: in expansion of macro 'DCN_BASE__INST0_SEG2'
     310 | #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:312:19: note: in expansion of macro 'BASE_INNER'
     312 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:321:29: note: in expansion of macro 'BASE'
     321 |                 .reg_name = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + mm ## block ## id ## _ ## reg_name
         |                             ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_link_encoder.h:207:9: note: in expansion of macro 'SRI'
     207 |         SRI(TMDS_CTL_BITS, DIG, id), \
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_link_encoder.h:238:9: note: in expansion of macro 'DPCS_DCN2_CMN_REG_LIST'
     238 |         DPCS_DCN2_CMN_REG_LIST(id), \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:980:33: note: in expansion of macro 'DPCS_DCN2_REG_LIST'
     980 |                                 DPCS_DCN2_REG_LIST(id), \
         |                                 ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:989:17: note: in expansion of macro 'link_regs'
     989 |                 link_regs(4, E)
         |                 ^~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:66:
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_0_2_sh_mask.h:34336:111: warning: initialized field overwritten [-Woverride-init]
   34336 | #define DIG0_TMDS_CTL_BITS__TMDS_CTL0__SHIFT                                                                  0x0
         |                                                                                                               ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_link_encoder.h:173:23: note: in expansion of macro 'DIG0_TMDS_CTL_BITS__TMDS_CTL0__SHIFT'
     173 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_link_encoder.h:184:9: note: in expansion of macro 'LE_SF'
     184 |         LE_SF(DIG0_TMDS_CTL_BITS, TMDS_CTL0, mask_sh), \
         |         ^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_dio_link_encoder.h:58:9: note: in expansion of macro 'LINK_ENCODER_MASK_SH_LIST_DCN20'
      58 |         LINK_ENCODER_MASK_SH_LIST_DCN20(mask_sh)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:993:17: note: in expansion of macro 'LINK_ENCODER_MASK_SH_LIST_DCN30'
     993 |                 LINK_ENCODER_MASK_SH_LIST_DCN30(__SHIFT),
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_0_2_sh_mask.h:34336:111: note: (near initialization for 'le_shift.TMDS_CTL0')
   34336 | #define DIG0_TMDS_CTL_BITS__TMDS_CTL0__SHIFT                                                                  0x0
         |                                                                                                               ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_link_encoder.h:173:23: note: in expansion of macro 'DIG0_TMDS_CTL_BITS__TMDS_CTL0__SHIFT'
     173 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_link_encoder.h:184:9: note: in expansion of macro 'LE_SF'
     184 |         LE_SF(DIG0_TMDS_CTL_BITS, TMDS_CTL0, mask_sh), \
         |         ^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_dio_link_encoder.h:58:9: note: in expansion of macro 'LINK_ENCODER_MASK_SH_LIST_DCN20'
      58 |         LINK_ENCODER_MASK_SH_LIST_DCN20(mask_sh)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:993:17: note: in expansion of macro 'LINK_ENCODER_MASK_SH_LIST_DCN30'
     993 |                 LINK_ENCODER_MASK_SH_LIST_DCN30(__SHIFT),
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:66:
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_0_2_sh_mask.h:34340:111: warning: initialized field overwritten [-Woverride-init]
   34340 | #define DIG0_TMDS_CTL_BITS__TMDS_CTL0_MASK                                                                    0x00000001L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_0_2_sh_mask.h:34340:111: note: in definition of macro 'DIG0_TMDS_CTL_BITS__TMDS_CTL0_MASK'
   34340 | #define DIG0_TMDS_CTL_BITS__TMDS_CTL0_MASK                                                                    0x00000001L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_link_encoder.h:184:9: note: in expansion of macro 'LE_SF'
     184 |         LE_SF(DIG0_TMDS_CTL_BITS, TMDS_CTL0, mask_sh), \
         |         ^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_dio_link_encoder.h:58:9: note: in expansion of macro 'LINK_ENCODER_MASK_SH_LIST_DCN20'
      58 |         LINK_ENCODER_MASK_SH_LIST_DCN20(mask_sh)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:998:17: note: in expansion of macro 'LINK_ENCODER_MASK_SH_LIST_DCN30'
     998 |                 LINK_ENCODER_MASK_SH_LIST_DCN30(_MASK),
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_0_2_sh_mask.h:34340:111: note: (near initialization for 'le_mask.TMDS_CTL0')
   34340 | #define DIG0_TMDS_CTL_BITS__TMDS_CTL0_MASK                                                                    0x00000001L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_0_2_sh_mask.h:34340:111: note: in definition of macro 'DIG0_TMDS_CTL_BITS__TMDS_CTL0_MASK'
   34340 | #define DIG0_TMDS_CTL_BITS__TMDS_CTL0_MASK                                                                    0x00000001L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_link_encoder.h:184:9: note: in expansion of macro 'LE_SF'
     184 |         LE_SF(DIG0_TMDS_CTL_BITS, TMDS_CTL0, mask_sh), \
         |         ^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_dio_link_encoder.h:58:9: note: in expansion of macro 'LINK_ENCODER_MASK_SH_LIST_DCN20'
      58 |         LINK_ENCODER_MASK_SH_LIST_DCN20(mask_sh)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:998:17: note: in expansion of macro 'LINK_ENCODER_MASK_SH_LIST_DCN30'
     998 |                 LINK_ENCODER_MASK_SH_LIST_DCN30(_MASK),
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:27:
>> drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:121:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     121 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:120:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     120 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
..


vim +/DP_SINK_DEVICE_STR_ID_2 +121 drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h

   119	
 > 120	static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
 > 121	static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
   122	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

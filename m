Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490DF56C8FE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 12:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiGIK2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 06:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGIK2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:28:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F4C62F8;
        Sat,  9 Jul 2022 03:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657362520; x=1688898520;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TJoKdRNNRLEvCgZxlJTJjiRbod7IwlCBSuLQLTBiTDQ=;
  b=EA2cwwDuY2qnFk1oEYyvSFa8MNQ1j4THR48FMgMN1X8bCo82txXNszf/
   LDiK1JedT1puN43c44QMuN7NLv1Zem4BvZ05M4kgS7wjL16VPt2JZndnK
   f6Wvut8cWqvamzH6QBhMZHrju5lPVf6DVvcm4vaaeseYpe3TvM99KLTjp
   68Npxy+WCEcDg609NyvR6KaWNJmsxcRV+Vul1tBljm72dC3sKom2QcE1p
   8oQAah7Sjw7M8YXv+jBN3TMhG2UZajvYN7F8SDv2uo6AWps+z9Ot0bfoG
   Bln78ts39A9e26iqbTLDML0MyspRa0i6oRAR5s0K0eBkC4yjFwLdKRPB0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="281977057"
X-IronPort-AV: E=Sophos;i="5.92,258,1650956400"; 
   d="scan'208";a="281977057"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 03:28:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,258,1650956400"; 
   d="scan'208";a="921267008"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jul 2022 03:28:38 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oA7hV-000OeU-JT;
        Sat, 09 Jul 2022 10:28:37 +0000
Date:   Sat, 9 Jul 2022 18:28:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roman Li <roman.li@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-doc@vger.kernel.org
Subject: [agd5f:drm-next 417/419]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_optc.c:47: warning:
 This comment starts with '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202207091834.eU8oYvaJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

First bad commit (maybe != root cause):

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   e35cc9020f7b4540f5fbbff9fbe08808aab9addc
commit: 27690f09d1c0305fd5536c028ca893dde13d7cc4 [417/419] drm/amd/display: Enable DCN314 in DC
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220709/202207091834.eU8oYvaJ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 27690f09d1c0305fd5536c028ca893dde13d7cc4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn314/irq_service_dcn314.c:41:20: warning: no previous prototype for 'to_dal_irq_source_dcn314' [-Wmissing-prototypes]
      41 | enum dc_irq_source to_dal_irq_source_dcn314(
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
--
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_resource.c:946:17: note: in expansion of macro 'HWSEQ_DCN31_MASK_SH_LIST'
     946 |                 HWSEQ_DCN31_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_1_4_sh_mask.h:10026:111: warning: initialized field overwritten [-Woverride-init]
   10026 | #define DOMAIN16_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN16_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_resource.c:927:9: note: in expansion of macro 'HWS_SF'
     927 |         HWS_SF(, DOMAIN16_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_resource.c:946:17: note: in expansion of macro 'HWSEQ_DCN31_MASK_SH_LIST'
     946 |                 HWSEQ_DCN31_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_1_4_sh_mask.h:10026:111: note: (near initialization for 'hwseq_mask.DOMAIN_PGFSM_PWR_STATUS')
   10026 | #define DOMAIN16_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN16_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_resource.c:927:9: note: in expansion of macro 'HWS_SF'
     927 |         HWS_SF(, DOMAIN16_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_resource.c:946:17: note: in expansion of macro 'HWSEQ_DCN31_MASK_SH_LIST'
     946 |                 HWSEQ_DCN31_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_1_4_sh_mask.h:10036:111: warning: initialized field overwritten [-Woverride-init]
   10036 | #define DOMAIN17_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN17_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_resource.c:928:9: note: in expansion of macro 'HWS_SF'
     928 |         HWS_SF(, DOMAIN17_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_resource.c:946:17: note: in expansion of macro 'HWSEQ_DCN31_MASK_SH_LIST'
     946 |                 HWSEQ_DCN31_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_1_4_sh_mask.h:10036:111: note: (near initialization for 'hwseq_mask.DOMAIN_PGFSM_PWR_STATUS')
   10036 | #define DOMAIN17_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN17_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_resource.c:928:9: note: in expansion of macro 'HWS_SF'
     928 |         HWS_SF(, DOMAIN17_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_resource.c:946:17: note: in expansion of macro 'HWSEQ_DCN31_MASK_SH_LIST'
     946 |                 HWSEQ_DCN31_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_1_4_sh_mask.h:10046:111: warning: initialized field overwritten [-Woverride-init]
   10046 | #define DOMAIN18_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN18_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_resource.c:929:9: note: in expansion of macro 'HWS_SF'
     929 |         HWS_SF(, DOMAIN18_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_resource.c:946:17: note: in expansion of macro 'HWSEQ_DCN31_MASK_SH_LIST'
     946 |                 HWSEQ_DCN31_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_1_4_sh_mask.h:10046:111: note: (near initialization for 'hwseq_mask.DOMAIN_PGFSM_PWR_STATUS')
   10046 | #define DOMAIN18_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN18_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_resource.c:929:9: note: in expansion of macro 'HWS_SF'
     929 |         HWS_SF(, DOMAIN18_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_resource.c:946:17: note: in expansion of macro 'HWSEQ_DCN31_MASK_SH_LIST'
     946 |                 HWSEQ_DCN31_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_1_4_sh_mask.h:10056:111: warning: initialized field overwritten [-Woverride-init]
   10056 | #define DOMAIN19_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN19_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_resource.c:930:9: note: in expansion of macro 'HWS_SF'
     930 |         HWS_SF(, DOMAIN19_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_resource.c:946:17: note: in expansion of macro 'HWSEQ_DCN31_MASK_SH_LIST'
     946 |                 HWSEQ_DCN31_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_1_4_sh_mask.h:10056:111: note: (near initialization for 'hwseq_mask.DOMAIN_PGFSM_PWR_STATUS')
   10056 | #define DOMAIN19_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:678:35: note: in expansion of macro 'DOMAIN19_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     678 |         .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_resource.c:930:9: note: in expansion of macro 'HWS_SF'
     930 |         HWS_SF(, DOMAIN19_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_resource.c:946:17: note: in expansion of macro 'HWSEQ_DCN31_MASK_SH_LIST'
     946 |                 HWSEQ_DCN31_MASK_SH_LIST(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_resource.c:124:29: warning: 'DCN_BASE' defined but not used [-Wunused-const-variable=]
     124 | static const struct IP_BASE DCN_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00, 0, 0, 0 } },
         |                             ^~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/resource.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_resource.c:34:
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
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_dio_stream_encoder.c:64:6: warning: no previous prototype for 'enc314_stream_encoder_dvi_set_stream_attribute' [-Wmissing-prototypes]
      64 | void enc314_stream_encoder_dvi_set_stream_attribute(
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_dccg.c:140:6: warning: no previous prototype for 'dccg314_set_dtbclk_dto' [-Wmissing-prototypes]
     140 | void dccg314_set_dtbclk_dto(
         |      ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_dccg.c:184:6: warning: no previous prototype for 'dccg314_set_dpstreamclk' [-Wmissing-prototypes]
     184 | void dccg314_set_dpstreamclk(
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_dccg.c:28:
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
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_optc.c:153:6: warning: no previous prototype for 'optc314_phantom_crtc_post_enable' [-Wmissing-prototypes]
     153 | void optc314_phantom_crtc_post_enable(struct timing_generator *optc)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_optc.c:47: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Enable CRTC


vim +47 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn314/dcn314_optc.c

0629e353943a6d8 Roman Li 2022-06-28   35  
0629e353943a6d8 Roman Li 2022-06-28   36  #define REG(reg)\
0629e353943a6d8 Roman Li 2022-06-28   37  	optc1->tg_regs->reg
0629e353943a6d8 Roman Li 2022-06-28   38  
0629e353943a6d8 Roman Li 2022-06-28   39  #define CTX \
0629e353943a6d8 Roman Li 2022-06-28   40  	optc1->base.ctx
0629e353943a6d8 Roman Li 2022-06-28   41  
0629e353943a6d8 Roman Li 2022-06-28   42  #undef FN
0629e353943a6d8 Roman Li 2022-06-28   43  #define FN(reg_name, field_name) \
0629e353943a6d8 Roman Li 2022-06-28   44  	optc1->tg_shift->field_name, optc1->tg_mask->field_name
0629e353943a6d8 Roman Li 2022-06-28   45  
0629e353943a6d8 Roman Li 2022-06-28   46  /**
0629e353943a6d8 Roman Li 2022-06-28  @47   * Enable CRTC
0629e353943a6d8 Roman Li 2022-06-28   48   * Enable CRTC - call ASIC Control Object to enable Timing generator.
0629e353943a6d8 Roman Li 2022-06-28   49   */
0629e353943a6d8 Roman Li 2022-06-28   50  
0629e353943a6d8 Roman Li 2022-06-28   51  static void optc314_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_cnt,
0629e353943a6d8 Roman Li 2022-06-28   52  		struct dc_crtc_timing *timing)
0629e353943a6d8 Roman Li 2022-06-28   53  {
0629e353943a6d8 Roman Li 2022-06-28   54  	struct optc *optc1 = DCN10TG_FROM_TG(optc);
0629e353943a6d8 Roman Li 2022-06-28   55  	uint32_t memory_mask = 0;
0629e353943a6d8 Roman Li 2022-06-28   56  	int h_active = timing->h_addressable + timing->h_border_left + timing->h_border_right;
0629e353943a6d8 Roman Li 2022-06-28   57  	int mpcc_hactive = h_active / opp_cnt;
0629e353943a6d8 Roman Li 2022-06-28   58  	/* Each memory instance is 2048x(314x2) bits to support half line of 4096 */
0629e353943a6d8 Roman Li 2022-06-28   59  	int odm_mem_count = (h_active + 2047) / 2048;
0629e353943a6d8 Roman Li 2022-06-28   60  
0629e353943a6d8 Roman Li 2022-06-28   61  	/*
0629e353943a6d8 Roman Li 2022-06-28   62  	 * display <= 4k : 2 memories + 2 pipes
0629e353943a6d8 Roman Li 2022-06-28   63  	 * 4k < display <= 8k : 4 memories + 2 pipes
0629e353943a6d8 Roman Li 2022-06-28   64  	 * 8k < display <= 12k : 6 memories + 4 pipes
0629e353943a6d8 Roman Li 2022-06-28   65  	 */
0629e353943a6d8 Roman Li 2022-06-28   66  	if (opp_cnt == 4) {
0629e353943a6d8 Roman Li 2022-06-28   67  		if (odm_mem_count <= 2)
0629e353943a6d8 Roman Li 2022-06-28   68  			memory_mask = 0x3;
0629e353943a6d8 Roman Li 2022-06-28   69  		else if (odm_mem_count <= 4)
0629e353943a6d8 Roman Li 2022-06-28   70  			memory_mask = 0xf;
0629e353943a6d8 Roman Li 2022-06-28   71  		else
0629e353943a6d8 Roman Li 2022-06-28   72  			memory_mask = 0x3f;
0629e353943a6d8 Roman Li 2022-06-28   73  	} else {
0629e353943a6d8 Roman Li 2022-06-28   74  		if (odm_mem_count <= 2)
0629e353943a6d8 Roman Li 2022-06-28   75  			memory_mask = 0x1 << (opp_id[0] * 2) | 0x1 << (opp_id[1] * 2);
0629e353943a6d8 Roman Li 2022-06-28   76  		else if (odm_mem_count <= 4)
0629e353943a6d8 Roman Li 2022-06-28   77  			memory_mask = 0x3 << (opp_id[0] * 2) | 0x3 << (opp_id[1] * 2);
0629e353943a6d8 Roman Li 2022-06-28   78  		else
0629e353943a6d8 Roman Li 2022-06-28   79  			memory_mask = 0x77;
0629e353943a6d8 Roman Li 2022-06-28   80  	}
0629e353943a6d8 Roman Li 2022-06-28   81  
0629e353943a6d8 Roman Li 2022-06-28   82  	REG_SET(OPTC_MEMORY_CONFIG, 0,
0629e353943a6d8 Roman Li 2022-06-28   83  		OPTC_MEM_SEL, memory_mask);
0629e353943a6d8 Roman Li 2022-06-28   84  
0629e353943a6d8 Roman Li 2022-06-28   85  	if (opp_cnt == 2) {
0629e353943a6d8 Roman Li 2022-06-28   86  		REG_SET_3(OPTC_DATA_SOURCE_SELECT, 0,
0629e353943a6d8 Roman Li 2022-06-28   87  				OPTC_NUM_OF_INPUT_SEGMENT, 1,
0629e353943a6d8 Roman Li 2022-06-28   88  				OPTC_SEG0_SRC_SEL, opp_id[0],
0629e353943a6d8 Roman Li 2022-06-28   89  				OPTC_SEG1_SRC_SEL, opp_id[1]);
0629e353943a6d8 Roman Li 2022-06-28   90  	} else if (opp_cnt == 4) {
0629e353943a6d8 Roman Li 2022-06-28   91  		REG_SET_5(OPTC_DATA_SOURCE_SELECT, 0,
0629e353943a6d8 Roman Li 2022-06-28   92  				OPTC_NUM_OF_INPUT_SEGMENT, 3,
0629e353943a6d8 Roman Li 2022-06-28   93  				OPTC_SEG0_SRC_SEL, opp_id[0],
0629e353943a6d8 Roman Li 2022-06-28   94  				OPTC_SEG1_SRC_SEL, opp_id[1],
0629e353943a6d8 Roman Li 2022-06-28   95  				OPTC_SEG2_SRC_SEL, opp_id[2],
0629e353943a6d8 Roman Li 2022-06-28   96  				OPTC_SEG3_SRC_SEL, opp_id[3]);
0629e353943a6d8 Roman Li 2022-06-28   97  	}
0629e353943a6d8 Roman Li 2022-06-28   98  
0629e353943a6d8 Roman Li 2022-06-28   99  	REG_UPDATE(OPTC_WIDTH_CONTROL,
0629e353943a6d8 Roman Li 2022-06-28  100  			OPTC_SEGMENT_WIDTH, mpcc_hactive);
0629e353943a6d8 Roman Li 2022-06-28  101  
0629e353943a6d8 Roman Li 2022-06-28  102  	REG_SET(OTG_H_TIMING_CNTL, 0, OTG_H_TIMING_DIV_MODE, opp_cnt - 1);
0629e353943a6d8 Roman Li 2022-06-28  103  	optc1->opp_count = opp_cnt;
0629e353943a6d8 Roman Li 2022-06-28  104  }
0629e353943a6d8 Roman Li 2022-06-28  105  
0629e353943a6d8 Roman Li 2022-06-28  106  static bool optc314_enable_crtc(struct timing_generator *optc)
0629e353943a6d8 Roman Li 2022-06-28  107  {
0629e353943a6d8 Roman Li 2022-06-28  108  	struct optc *optc1 = DCN10TG_FROM_TG(optc);
0629e353943a6d8 Roman Li 2022-06-28  109  
0629e353943a6d8 Roman Li 2022-06-28  110  	/* opp instance for OTG, 1 to 1 mapping and odm will adjust */
0629e353943a6d8 Roman Li 2022-06-28  111  	REG_UPDATE(OPTC_DATA_SOURCE_SELECT,
0629e353943a6d8 Roman Li 2022-06-28  112  			OPTC_SEG0_SRC_SEL, optc->inst);
0629e353943a6d8 Roman Li 2022-06-28  113  
0629e353943a6d8 Roman Li 2022-06-28  114  	/* VTG enable first is for HW workaround */
0629e353943a6d8 Roman Li 2022-06-28  115  	REG_UPDATE(CONTROL,
0629e353943a6d8 Roman Li 2022-06-28  116  			VTG0_ENABLE, 1);
0629e353943a6d8 Roman Li 2022-06-28  117  
0629e353943a6d8 Roman Li 2022-06-28  118  	REG_SEQ_START();
0629e353943a6d8 Roman Li 2022-06-28  119  
0629e353943a6d8 Roman Li 2022-06-28  120  	/* Enable CRTC */
0629e353943a6d8 Roman Li 2022-06-28  121  	REG_UPDATE_2(OTG_CONTROL,
0629e353943a6d8 Roman Li 2022-06-28  122  			OTG_DISABLE_POINT_CNTL, 2,
0629e353943a6d8 Roman Li 2022-06-28  123  			OTG_MASTER_EN, 1);
0629e353943a6d8 Roman Li 2022-06-28  124  
0629e353943a6d8 Roman Li 2022-06-28  125  	REG_SEQ_SUBMIT();
0629e353943a6d8 Roman Li 2022-06-28  126  	REG_SEQ_WAIT_DONE();
0629e353943a6d8 Roman Li 2022-06-28  127  
0629e353943a6d8 Roman Li 2022-06-28  128  	return true;
0629e353943a6d8 Roman Li 2022-06-28  129  }
0629e353943a6d8 Roman Li 2022-06-28  130  
0629e353943a6d8 Roman Li 2022-06-28  131  /* disable_crtc */
0629e353943a6d8 Roman Li 2022-06-28  132  static bool optc314_disable_crtc(struct timing_generator *optc)
0629e353943a6d8 Roman Li 2022-06-28  133  {
0629e353943a6d8 Roman Li 2022-06-28  134  	struct optc *optc1 = DCN10TG_FROM_TG(optc);
0629e353943a6d8 Roman Li 2022-06-28  135  
0629e353943a6d8 Roman Li 2022-06-28  136  	/* disable otg request until end of the first line
0629e353943a6d8 Roman Li 2022-06-28  137  	 * in the vertical blank region
0629e353943a6d8 Roman Li 2022-06-28  138  	 */
0629e353943a6d8 Roman Li 2022-06-28  139  	REG_UPDATE(OTG_CONTROL,
0629e353943a6d8 Roman Li 2022-06-28  140  			OTG_MASTER_EN, 0);
0629e353943a6d8 Roman Li 2022-06-28  141  
0629e353943a6d8 Roman Li 2022-06-28  142  	REG_UPDATE(CONTROL,
0629e353943a6d8 Roman Li 2022-06-28  143  			VTG0_ENABLE, 0);
0629e353943a6d8 Roman Li 2022-06-28  144  
0629e353943a6d8 Roman Li 2022-06-28  145  	/* CRTC disabled, so disable  clock. */
0629e353943a6d8 Roman Li 2022-06-28  146  	REG_WAIT(OTG_CLOCK_CONTROL,
0629e353943a6d8 Roman Li 2022-06-28  147  			OTG_BUSY, 0,
0629e353943a6d8 Roman Li 2022-06-28  148  			1, 100000);
0629e353943a6d8 Roman Li 2022-06-28  149  
0629e353943a6d8 Roman Li 2022-06-28  150  	return true;
0629e353943a6d8 Roman Li 2022-06-28  151  }
0629e353943a6d8 Roman Li 2022-06-28  152  
0629e353943a6d8 Roman Li 2022-06-28 @153  void optc314_phantom_crtc_post_enable(struct timing_generator *optc)
0629e353943a6d8 Roman Li 2022-06-28  154  {
0629e353943a6d8 Roman Li 2022-06-28  155  	struct optc *optc1 = DCN10TG_FROM_TG(optc);
0629e353943a6d8 Roman Li 2022-06-28  156  
0629e353943a6d8 Roman Li 2022-06-28  157  	/* Disable immediately. */
0629e353943a6d8 Roman Li 2022-06-28  158  	REG_UPDATE_2(OTG_CONTROL, OTG_DISABLE_POINT_CNTL, 0, OTG_MASTER_EN, 0);
0629e353943a6d8 Roman Li 2022-06-28  159  
0629e353943a6d8 Roman Li 2022-06-28  160  	/* CRTC disabled, so disable  clock. */
0629e353943a6d8 Roman Li 2022-06-28  161  	REG_WAIT(OTG_CLOCK_CONTROL, OTG_BUSY, 0, 1, 100000);
0629e353943a6d8 Roman Li 2022-06-28  162  }
0629e353943a6d8 Roman Li 2022-06-28  163  

:::::: The code at line 47 was first introduced by commit
:::::: 0629e353943a6d88b73ff6d4e9b3182f45de65e4 drm/amd/display: Add DCN314 DC resources

:::::: TO: Roman Li <roman.li@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

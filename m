Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CBB522F13
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbiEKJOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbiEKJOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:14:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F295182D05
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652260479; x=1683796479;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q5VukMMAwBjthMsFf3//MzZvkuPn/3mSMuJMba8EQJY=;
  b=XKPFyRpQtrqYmTp6vYFMZjBaQsi+ursws79Rn0rzcpCWNPE6kqYuuaJG
   SBTjUVUemDKzhD/e//NDDcX+M0PEj9RbKvx3bAujNii2CsivgH33KLNGS
   mrdBuRH/o1+CFZjJe5qKlG+BUE2EltSVVbIx/pGwVz2RCCq/7hajgle2s
   JYQr6s2br1JqDJU48SFHe6+4G3796QOk5rZ/9R/VtdJLHTBXHdm/VH8TN
   dkvufsVwXvMbGjmFW1vVb71q/bt9zClRfEiDc3j7EFhD3phj1sCpAQF2Y
   wL2w+i0aQ9wvQRn+vgoBbnkN71drXojAdwmcedbtOkmRevkFsyHGiyWYg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="267230963"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="267230963"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 02:14:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="623861704"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 11 May 2022 02:14:36 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noiQW-000Ivb-3q;
        Wed, 11 May 2022 09:14:36 +0000
Date:   Wed, 11 May 2022 17:14:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22:
 warning: 'SYNAPTICS_DEVICE_ID' defined but not used
Message-ID: <202205111741.n2Dx30dq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   feb9c5e19e913b53cb536a7aa7c9f20107bb51ec
commit: 9cc370435cde6b672b6e2221115c2f535e8bd4ec drm/amd/display: Add DSC Enable for Synaptics Hub
date:   4 months ago
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220511/202205111741.n2Dx30dq-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9cc370435cde6b672b6e2221115c2f535e8bd4ec
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9cc370435cde6b672b6e2221115c2f535e8bd4ec
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_optc.h:56:9: note: in expansion of macro 'SF'
      56 |         SF(OTG0_OTG_VUPDATE_KEEPOUT, MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET, mask_sh), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:514:9: note: in expansion of macro 'TG_COMMON_MASK_SH_LIST_DCN201'
     514 |         TG_COMMON_MASK_SH_LIST_DCN201(_MASK)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_3_sh_mask.h:14887:111: warning: initialized field overwritten [-Woverride-init]
   14887 | #define OTG0_OTG_VUPDATE_KEEPOUT__MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET_MASK                          0x03FF0000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_audio.h:45:23: note: in expansion of macro 'OTG0_OTG_VUPDATE_KEEPOUT__MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET_MASK'
      45 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_optc.h:57:9: note: in expansion of macro 'SF'
      57 |         SF(OTG0_OTG_VUPDATE_KEEPOUT, MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET, mask_sh), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:514:9: note: in expansion of macro 'TG_COMMON_MASK_SH_LIST_DCN201'
     514 |         TG_COMMON_MASK_SH_LIST_DCN201(_MASK)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_3_sh_mask.h:14887:111: note: (near initialization for 'tg_mask.MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET')
   14887 | #define OTG0_OTG_VUPDATE_KEEPOUT__MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET_MASK                          0x03FF0000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_audio.h:45:23: note: in expansion of macro 'OTG0_OTG_VUPDATE_KEEPOUT__MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET_MASK'
      45 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_optc.h:57:9: note: in expansion of macro 'SF'
      57 |         SF(OTG0_OTG_VUPDATE_KEEPOUT, MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET, mask_sh), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:514:9: note: in expansion of macro 'TG_COMMON_MASK_SH_LIST_DCN201'
     514 |         TG_COMMON_MASK_SH_LIST_DCN201(_MASK)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_3_sh_mask.h:15730:111: warning: initialized field overwritten [-Woverride-init]
   15730 | #define DWB_SOURCE_SELECT__OPTC_DWB1_SOURCE_SELECT_MASK                                                       0x00000038L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_audio.h:45:23: note: in expansion of macro 'DWB_SOURCE_SELECT__OPTC_DWB1_SOURCE_SELECT_MASK'
      45 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_optc.h:68:9: note: in expansion of macro 'SF'
      68 |         SF(DWB_SOURCE_SELECT, OPTC_DWB1_SOURCE_SELECT, mask_sh)
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:514:9: note: in expansion of macro 'TG_COMMON_MASK_SH_LIST_DCN201'
     514 |         TG_COMMON_MASK_SH_LIST_DCN201(_MASK)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_3_sh_mask.h:15730:111: note: (near initialization for 'tg_mask.OPTC_DWB1_SOURCE_SELECT')
   15730 | #define DWB_SOURCE_SELECT__OPTC_DWB1_SOURCE_SELECT_MASK                                                       0x00000038L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_audio.h:45:23: note: in expansion of macro 'DWB_SOURCE_SELECT__OPTC_DWB1_SOURCE_SELECT_MASK'
      45 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_optc.h:68:9: note: in expansion of macro 'SF'
      68 |         SF(DWB_SOURCE_SELECT, OPTC_DWB1_SOURCE_SELECT, mask_sh)
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:514:9: note: in expansion of macro 'TG_COMMON_MASK_SH_LIST_DCN201'
     514 |         TG_COMMON_MASK_SH_LIST_DCN201(_MASK)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:61:
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:247:52: warning: initialized field overwritten [-Woverride-init]
     247 | #define DMU_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:247:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
     247 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:249:19: note: in expansion of macro 'BASE_INNER'
     249 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:252:29: note: in expansion of macro 'BASE'
     252 |                 .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
         |                             ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:178:9: note: in expansion of macro 'SR'
     178 |         SR(DCFCLK_CNTL), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:349:9: note: in expansion of macro 'HWSEQ_DCN_REG_LIST'
     349 |         HWSEQ_DCN_REG_LIST(), \
         |         ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:868:17: note: in expansion of macro 'HWSEQ_DCN201_REG_LIST'
     868 |                 HWSEQ_DCN201_REG_LIST()
         |                 ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:247:52: note: (near initialization for 'hwseq_reg.DCFCLK_CNTL')
     247 | #define DMU_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:247:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
     247 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:249:19: note: in expansion of macro 'BASE_INNER'
     249 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:252:29: note: in expansion of macro 'BASE'
     252 |                 .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
         |                             ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:178:9: note: in expansion of macro 'SR'
     178 |         SR(DCFCLK_CNTL), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:349:9: note: in expansion of macro 'HWSEQ_DCN_REG_LIST'
     349 |         HWSEQ_DCN_REG_LIST(), \
         |         ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:868:17: note: in expansion of macro 'HWSEQ_DCN201_REG_LIST'
     868 |                 HWSEQ_DCN201_REG_LIST()
         |                 ^~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/resource.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:31:
>> drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:124:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     124 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     123 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c: In function 'gpu_addr_to_uma':
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c:88:14: warning: variable 'is_in_uma' set but not used [-Wunused-but-set-variable]
      88 |         bool is_in_uma;
         |              ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c: In function 'dcn201_pipe_control_lock':
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c:545:22: warning: variable 'hubp' set but not used [-Wunused-but-set-variable]
     545 |         struct hubp *hubp = NULL;
         |                      ^~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/basics/dc_common.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c:27:
   At top level:
>> drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:124:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     124 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     123 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hubbub.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hubbub.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hubbub.c:26:
>> drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:124:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     124 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     123 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dmub/dmub_srv.h:67,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:28:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h: In function 'dmub_rb_flush_pending':
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2918:26: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
    2918 |                 uint64_t temp;
         |                          ^~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:30:
   At top level:
>> drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.c: In function 'dpp201_get_optimal_number_of_taps':
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.c:185:18: warning: variable 'pixel_width' set but not used [-Wunused-but-set-variable]
     185 |         uint32_t pixel_width;
         |                  ^~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.c:28:
   At top level:
>> drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:124:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     124 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     123 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dmub/dmub_srv.h:67,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:48:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h: In function 'dmub_rb_flush_pending':
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2918:26: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
    2918 |                 uint64_t temp;
         |                          ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c: In function 'dcn30_enable_writeback':
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:324:34: warning: variable 'optc' set but not used [-Wunused-but-set-variable]
     324 |         struct timing_generator *optc;
         |                                  ^~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:29:
   At top level:
>> drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:124:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     124 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     123 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dmub/dmub_srv.h:67,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm.c:29:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h: In function 'dmub_rb_flush_pending':
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2918:26: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
    2918 |                 uint64_t temp;
         |                          ^~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm.c:31:
   At top level:
>> drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:124:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     124 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     123 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
         |                             ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:386:9: note: in expansion of macro 'SR'
     386 |         SR(MPC_CRC_RESULT_GB), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:753:17: note: in expansion of macro 'HWSEQ_DCN30_REG_LIST'
     753 |                 HWSEQ_DCN30_REG_LIST()
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:373:52: note: (near initialization for 'hwseq_reg.MPC_CRC_RESULT_GB')
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
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/resource.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:32:
>> drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:124:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     124 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     123 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
..


vim +/SYNAPTICS_DEVICE_ID +127 drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h

   125	
   126	/*MST Dock*/
 > 127	static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
   128	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

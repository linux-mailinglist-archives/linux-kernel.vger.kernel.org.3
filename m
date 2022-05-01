Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6481D5164E9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 17:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347989AbiEAPNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 11:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbiEAPNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 11:13:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4893C19C23
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651417783; x=1682953783;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OvjyxPs+yKpEthVMr9GV7lntbC2H03bBrr63zq5TIPc=;
  b=nznVHiAnE1JAR2zMXsv1vzG7vjneZCLhXTVn4fFOF3lUbuwJj/KUTCgl
   HKwjILdxWWGrL+fV4r+eR7o6goHfFpLkJjlPKGZBcrnEwFE327Qu9WYH+
   ANtnmhNB1FDoE1PHs88+K/JfThS/lZJogJ87Ya3eefsT1Ujm/o1ZJeMlE
   V6sK7QUh64RnRHIrDThM+m24b0K0XsIdLOyoidXziwRCA04aLyhy1DQ6T
   qmrG2AJ9nd7pfrEuaJSKW72DB//0i3p3yGJG5xI49D0QsOrV95KJ25YV/
   35VlgrlTOLEDYulIemv1RuN44cZSY2vbm4VkiMySUzNmr2w42mxJO6g53
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="265872046"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="265872046"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 08:09:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="598240297"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 May 2022 08:09:40 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlBCd-0008qN-G3;
        Sun, 01 May 2022 15:09:39 +0000
Date:   Sun, 1 May 2022 23:08:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:3957:6:
 warning: stack frame size (2424) exceeds limit (2048) in
 'dml31_ModeSupportAndSystemConfigurationFull'
Message-ID: <202205012240.7qrNLV84-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   57ae8a492116910bad2b3497ffe555b3a4b4180f
commit: 8fe44c080a53ac0ccbe88053a2e40f9acca33091 drm/amdgpu/display: fold DRM_AMD_DC_DCN3_1 into DRM_AMD_DC_DCN
date:   10 months ago
config: x86_64-buildonly-randconfig-r002-20220425 (https://download.01.org/0day-ci/archive/20220501/202205012240.7qrNLV84-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8fe44c080a53ac0ccbe88053a2e40f9acca33091
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8fe44c080a53ac0ccbe88053a2e40f9acca33091
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/ drivers/media/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_smu.c:98:5: warning: no previous prototype for function 'dcn31_smu_send_msg_with_param' [-Wmissing-prototypes]
   int dcn31_smu_send_msg_with_param(
       ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_smu.c:98:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int dcn31_smu_send_msg_with_param(
   ^
   static 
   1 warning generated.
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c:54:5: warning: no previous prototype for function 'dcn31_get_active_display_cnt_wa' [-Wmissing-prototypes]
   int dcn31_get_active_display_cnt_wa(
       ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c:54:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int dcn31_get_active_display_cnt_wa(
   ^
   static 
>> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c:491:6: warning: no previous prototype for function 'dcn31_clk_mgr_helper_populate_bw_params' [-Wmissing-prototypes]
   void dcn31_clk_mgr_helper_populate_bw_params(
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c:491:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void dcn31_clk_mgr_helper_populate_bw_params(
   ^
   static 
   2 warnings generated.
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn31/irq_service_dcn31.c:39:20: warning: no previous prototype for function 'to_dal_irq_source_dcn31' [-Wmissing-prototypes]
   enum dc_irq_source to_dal_irq_source_dcn31(
                      ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn31/irq_service_dcn31.c:39:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   enum dc_irq_source to_dal_irq_source_dcn31(
   ^
   static 
   1 warning generated.
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:3957:6: warning: stack frame size (2424) exceeds limit (2048) in 'dml31_ModeSupportAndSystemConfigurationFull' [-Wframe-larger-than]
   void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
        ^
   1 warning generated.
--
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:642:28: note: expanded from macro 'HWS_SF'
           .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:21:1: note: expanded from here
   DOMAIN2_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h:5635:111: note: expanded from macro 'DOMAIN2_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
   #define DOMAIN2_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                       0xC0000000L
                                                                                                                 ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c:838:3: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
                   HWSEQ_DCN31_MASK_SH_LIST(_MASK)
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c:822:2: note: expanded from macro 'HWSEQ_DCN31_MASK_SH_LIST'
           HWS_SF(, DOMAIN16_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:642:28: note: expanded from macro 'HWS_SF'
           .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:27:1: note: expanded from here
   DOMAIN16_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h:5655:111: note: expanded from macro 'DOMAIN16_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
   #define DOMAIN16_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
                                                                                                                 ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c:838:3: note: previous initialization is here
                   HWSEQ_DCN31_MASK_SH_LIST(_MASK)
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c:821:2: note: expanded from macro 'HWSEQ_DCN31_MASK_SH_LIST'
           HWS_SF(, DOMAIN3_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:642:28: note: expanded from macro 'HWS_SF'
           .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:24:1: note: expanded from here
   DOMAIN3_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h:5645:111: note: expanded from macro 'DOMAIN3_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
   #define DOMAIN3_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                       0xC0000000L
                                                                                                                 ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c:838:3: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
                   HWSEQ_DCN31_MASK_SH_LIST(_MASK)
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c:823:2: note: expanded from macro 'HWSEQ_DCN31_MASK_SH_LIST'
           HWS_SF(, DOMAIN17_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:642:28: note: expanded from macro 'HWS_SF'
           .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:30:1: note: expanded from here
   DOMAIN17_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h:5665:111: note: expanded from macro 'DOMAIN17_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
   #define DOMAIN17_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
                                                                                                                 ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c:838:3: note: previous initialization is here
                   HWSEQ_DCN31_MASK_SH_LIST(_MASK)
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c:822:2: note: expanded from macro 'HWSEQ_DCN31_MASK_SH_LIST'
           HWS_SF(, DOMAIN16_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:642:28: note: expanded from macro 'HWS_SF'
           .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:27:1: note: expanded from here
   DOMAIN16_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h:5655:111: note: expanded from macro 'DOMAIN16_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
   #define DOMAIN16_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
                                                                                                                 ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c:838:3: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
                   HWSEQ_DCN31_MASK_SH_LIST(_MASK)
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c:824:2: note: expanded from macro 'HWSEQ_DCN31_MASK_SH_LIST'
           HWS_SF(, DOMAIN18_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:642:28: note: expanded from macro 'HWS_SF'
           .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:33:1: note: expanded from here
   DOMAIN18_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h:5675:111: note: expanded from macro 'DOMAIN18_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
   #define DOMAIN18_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
                                                                                                                 ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c:838:3: note: previous initialization is here
                   HWSEQ_DCN31_MASK_SH_LIST(_MASK)
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c:823:2: note: expanded from macro 'HWSEQ_DCN31_MASK_SH_LIST'
           HWS_SF(, DOMAIN17_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:642:28: note: expanded from macro 'HWS_SF'
           .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:30:1: note: expanded from here
   DOMAIN17_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h:5665:111: note: expanded from macro 'DOMAIN17_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
   #define DOMAIN17_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
                                                                                                                 ^~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c:1197:20: warning: no previous prototype for function 'dcn31_panel_cntl_create' [-Wmissing-prototypes]
   struct panel_cntl *dcn31_panel_cntl_create(const struct panel_cntl_init_data *init_data)
                      ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c:1197:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct panel_cntl *dcn31_panel_cntl_create(const struct panel_cntl_init_data *init_data)
   ^
   static 
   102 warnings generated.
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_init.c:141:6: warning: no previous prototype for function 'dcn31_hw_sequencer_construct' [-Wmissing-prototypes]
   void dcn31_hw_sequencer_construct(struct dc *dc)
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_init.c:141:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void dcn31_hw_sequencer_construct(struct dc *dc)
   ^
   static 
   1 warning generated.
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_dccg.c:112:6: warning: no previous prototype for function 'dccg31_set_dtbclk_dto' [-Wmissing-prototypes]
   void dccg31_set_dtbclk_dto(
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_dccg.c:112:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void dccg31_set_dtbclk_dto(
   ^
   static 
   1 warning generated.
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_dio_link_encoder.c:139:6: warning: no previous prototype for function 'enc31_hw_init' [-Wmissing-prototypes]
   void enc31_hw_init(struct link_encoder *enc)
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_dio_link_encoder.c:139:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void enc31_hw_init(struct link_encoder *enc)
   ^
   static 
   1 warning generated.
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_panel_cntl.c:68:10: warning: no previous prototype for function 'dcn31_panel_cntl_hw_init' [-Wmissing-prototypes]
   uint32_t dcn31_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
            ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_panel_cntl.c:68:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   uint32_t dcn31_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
   ^
   static 
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_panel_cntl.c:99:6: warning: no previous prototype for function 'dcn31_panel_cntl_destroy' [-Wmissing-prototypes]
   void dcn31_panel_cntl_destroy(struct panel_cntl **panel_cntl)
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_panel_cntl.c:99:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void dcn31_panel_cntl_destroy(struct panel_cntl **panel_cntl)
   ^
   static 
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_panel_cntl.c:107:6: warning: no previous prototype for function 'dcn31_is_panel_backlight_on' [-Wmissing-prototypes]
   bool dcn31_is_panel_backlight_on(struct panel_cntl *panel_cntl)
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_panel_cntl.c:107:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool dcn31_is_panel_backlight_on(struct panel_cntl *panel_cntl)
   ^
   static 
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_panel_cntl.c:117:6: warning: no previous prototype for function 'dcn31_is_panel_powered_on' [-Wmissing-prototypes]
   bool dcn31_is_panel_powered_on(struct panel_cntl *panel_cntl)
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_panel_cntl.c:117:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool dcn31_is_panel_powered_on(struct panel_cntl *panel_cntl)
   ^
   static 
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_panel_cntl.c:127:6: warning: no previous prototype for function 'dcn31_store_backlight_level' [-Wmissing-prototypes]
   void dcn31_store_backlight_level(struct panel_cntl *panel_cntl)
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_panel_cntl.c:127:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void dcn31_store_backlight_level(struct panel_cntl *panel_cntl)
   ^
   static 
   5 warnings generated.


vim +/dml31_ModeSupportAndSystemConfigurationFull +3957 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c

74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3956  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19 @3957  void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3958  {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3959  	struct vba_vars_st *v = &mode_lib->vba;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3960  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3961  	int i, j;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3962  	unsigned int k, m;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3963  	int ReorderingBytes;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3964  	int MinPrefetchMode = 0, MaxPrefetchMode = 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3965  	bool NoChroma = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3966  	bool EnoughWritebackUnits = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3967  	bool P2IWith420 = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3968  	bool DSCOnlyIfNecessaryWithBPP = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3969  	bool DSC422NativeNotSupported = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3970  	double MaxTotalVActiveRDBandwidth;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3971  	bool ViewportExceedsSurface = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3972  	bool FMTBufferExceeded = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3973  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3974  	/*MODE SUPPORT, VOLTAGE STATE AND SOC CONFIGURATION*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3975  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3976  	CalculateMinAndMaxPrefetchMode(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3977  		mode_lib->vba.AllowDRAMSelfRefreshOrDRAMClockChangeInVblank,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3978  		&MinPrefetchMode, &MaxPrefetchMode);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3979  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3980  	/*Scale Ratio, taps Support Check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3981  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3982  	v->ScaleRatioAndTapsSupport = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3983  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3984  		if (v->ScalerEnabled[k] == false
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3985  				&& ((v->SourcePixelFormat[k] != dm_444_64 && v->SourcePixelFormat[k] != dm_444_32
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3986  						&& v->SourcePixelFormat[k] != dm_444_16 && v->SourcePixelFormat[k] != dm_mono_16
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3987  						&& v->SourcePixelFormat[k] != dm_mono_8 && v->SourcePixelFormat[k] != dm_rgbe
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3988  						&& v->SourcePixelFormat[k] != dm_rgbe_alpha) || v->HRatio[k] != 1.0 || v->htaps[k] != 1.0
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3989  						|| v->VRatio[k] != 1.0 || v->vtaps[k] != 1.0)) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3990  			v->ScaleRatioAndTapsSupport = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3991  		} else if (v->vtaps[k] < 1.0 || v->vtaps[k] > 8.0 || v->htaps[k] < 1.0 || v->htaps[k] > 8.0
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3992  				|| (v->htaps[k] > 1.0 && (v->htaps[k] % 2) == 1) || v->HRatio[k] > v->MaxHSCLRatio
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3993  				|| v->VRatio[k] > v->MaxVSCLRatio || v->HRatio[k] > v->htaps[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3994  				|| v->VRatio[k] > v->vtaps[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3995  				|| (v->SourcePixelFormat[k] != dm_444_64 && v->SourcePixelFormat[k] != dm_444_32
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3996  						&& v->SourcePixelFormat[k] != dm_444_16 && v->SourcePixelFormat[k] != dm_mono_16
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3997  						&& v->SourcePixelFormat[k] != dm_mono_8 && v->SourcePixelFormat[k] != dm_rgbe
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3998  						&& (v->VTAPsChroma[k] < 1 || v->VTAPsChroma[k] > 8 || v->HTAPsChroma[k] < 1
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  3999  								|| v->HTAPsChroma[k] > 8 || (v->HTAPsChroma[k] > 1 && v->HTAPsChroma[k] % 2 == 1)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4000  								|| v->HRatioChroma[k] > v->MaxHSCLRatio
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4001  								|| v->VRatioChroma[k] > v->MaxVSCLRatio
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4002  								|| v->HRatioChroma[k] > v->HTAPsChroma[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4003  								|| v->VRatioChroma[k] > v->VTAPsChroma[k]))) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4004  			v->ScaleRatioAndTapsSupport = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4005  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4006  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4007  	/*Source Format, Pixel Format and Scan Support Check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4008  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4009  	v->SourceFormatPixelAndScanSupport = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4010  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4011  		if ((v->SurfaceTiling[k] == dm_sw_linear && (!(v->SourceScan[k] != dm_vert) || v->DCCEnable[k] == true))
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4012  				|| ((v->SurfaceTiling[k] == dm_sw_64kb_d || v->SurfaceTiling[k] == dm_sw_64kb_d_t
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4013  						|| v->SurfaceTiling[k] == dm_sw_64kb_d_x) && !(v->SourcePixelFormat[k] == dm_444_64))) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4014  			v->SourceFormatPixelAndScanSupport = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4015  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4016  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4017  	/*Bandwidth Support Check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4018  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4019  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4020  		CalculateBytePerPixelAnd256BBlockSizes(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4021  				v->SourcePixelFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4022  				v->SurfaceTiling[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4023  				&v->BytePerPixelY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4024  				&v->BytePerPixelC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4025  				&v->BytePerPixelInDETY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4026  				&v->BytePerPixelInDETC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4027  				&v->Read256BlockHeightY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4028  				&v->Read256BlockHeightC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4029  				&v->Read256BlockWidthY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4030  				&v->Read256BlockWidthC[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4031  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4032  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4033  		if (v->SourceScan[k] != dm_vert) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4034  			v->SwathWidthYSingleDPP[k] = v->ViewportWidth[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4035  			v->SwathWidthCSingleDPP[k] = v->ViewportWidthChroma[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4036  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4037  			v->SwathWidthYSingleDPP[k] = v->ViewportHeight[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4038  			v->SwathWidthCSingleDPP[k] = v->ViewportHeightChroma[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4039  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4040  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4041  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4042  		v->ReadBandwidthLuma[k] = v->SwathWidthYSingleDPP[k] * dml_ceil(v->BytePerPixelInDETY[k], 1.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4043  				/ (v->HTotal[k] / v->PixelClock[k]) * v->VRatio[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4044  		v->ReadBandwidthChroma[k] = v->SwathWidthYSingleDPP[k] / 2 * dml_ceil(v->BytePerPixelInDETC[k], 2.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4045  				/ (v->HTotal[k] / v->PixelClock[k]) * v->VRatio[k] / 2.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4046  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4047  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4048  		if (v->WritebackEnable[k] == true && v->WritebackPixelFormat[k] == dm_444_64) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4049  			v->WriteBandwidth[k] = v->WritebackDestinationWidth[k] * v->WritebackDestinationHeight[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4050  					/ (v->WritebackSourceHeight[k] * v->HTotal[k] / v->PixelClock[k]) * 8.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4051  		} else if (v->WritebackEnable[k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4052  			v->WriteBandwidth[k] = v->WritebackDestinationWidth[k] * v->WritebackDestinationHeight[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4053  					/ (v->WritebackSourceHeight[k] * v->HTotal[k] / v->PixelClock[k]) * 4.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4054  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4055  			v->WriteBandwidth[k] = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4056  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4057  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4058  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4059  	/*Writeback Latency support check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4060  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4061  	v->WritebackLatencySupport = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4062  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4063  		if (v->WritebackEnable[k] == true && (v->WriteBandwidth[k] > v->WritebackInterfaceBufferSize * 1024 / v->WritebackLatency)) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4064  			v->WritebackLatencySupport = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4065  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4066  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4067  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4068  	/*Writeback Mode Support Check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4069  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4070  	v->TotalNumberOfActiveWriteback = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4071  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4072  		if (v->WritebackEnable[k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4073  			v->TotalNumberOfActiveWriteback = v->TotalNumberOfActiveWriteback + 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4074  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4075  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4076  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4077  	if (v->TotalNumberOfActiveWriteback > v->MaxNumWriteback) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4078  		EnoughWritebackUnits = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4079  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4080  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4081  	/*Writeback Scale Ratio and Taps Support Check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4082  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4083  	v->WritebackScaleRatioAndTapsSupport = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4084  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4085  		if (v->WritebackEnable[k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4086  			if (v->WritebackHRatio[k] > v->WritebackMaxHSCLRatio || v->WritebackVRatio[k] > v->WritebackMaxVSCLRatio
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4087  					|| v->WritebackHRatio[k] < v->WritebackMinHSCLRatio
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4088  					|| v->WritebackVRatio[k] < v->WritebackMinVSCLRatio
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4089  					|| v->WritebackHTaps[k] > v->WritebackMaxHSCLTaps
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4090  					|| v->WritebackVTaps[k] > v->WritebackMaxVSCLTaps
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4091  					|| v->WritebackHRatio[k] > v->WritebackHTaps[k] || v->WritebackVRatio[k] > v->WritebackVTaps[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4092  					|| (v->WritebackHTaps[k] > 2.0 && ((v->WritebackHTaps[k] % 2) == 1))) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4093  				v->WritebackScaleRatioAndTapsSupport = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4094  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4095  			if (2.0 * v->WritebackDestinationWidth[k] * (v->WritebackVTaps[k] - 1) * 57 > v->WritebackLineBufferSize) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4096  				v->WritebackScaleRatioAndTapsSupport = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4097  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4098  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4099  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4100  	/*Maximum DISPCLK/DPPCLK Support check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4101  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4102  	v->WritebackRequiredDISPCLK = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4103  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4104  		if (v->WritebackEnable[k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4105  			v->WritebackRequiredDISPCLK = dml_max(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4106  					v->WritebackRequiredDISPCLK,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4107  					dml31_CalculateWriteBackDISPCLK(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4108  							v->WritebackPixelFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4109  							v->PixelClock[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4110  							v->WritebackHRatio[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4111  							v->WritebackVRatio[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4112  							v->WritebackHTaps[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4113  							v->WritebackVTaps[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4114  							v->WritebackSourceWidth[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4115  							v->WritebackDestinationWidth[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4116  							v->HTotal[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4117  							v->WritebackLineBufferSize));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4118  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4119  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4120  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4121  		if (v->HRatio[k] > 1.0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4122  			v->PSCL_FACTOR[k] = dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4123  					v->MaxDCHUBToPSCLThroughput,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4124  					v->MaxPSCLToLBThroughput * v->HRatio[k] / dml_ceil(v->htaps[k] / 6.0, 1.0));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4125  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4126  			v->PSCL_FACTOR[k] = dml_min(v->MaxDCHUBToPSCLThroughput, v->MaxPSCLToLBThroughput);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4127  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4128  		if (v->BytePerPixelC[k] == 0.0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4129  			v->PSCL_FACTOR_CHROMA[k] = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4130  			v->MinDPPCLKUsingSingleDPP[k] = v->PixelClock[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4131  					* dml_max3(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4132  							v->vtaps[k] / 6.0 * dml_min(1.0, v->HRatio[k]),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4133  							v->HRatio[k] * v->VRatio[k] / v->PSCL_FACTOR[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4134  							1.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4135  			if ((v->htaps[k] > 6.0 || v->vtaps[k] > 6.0) && v->MinDPPCLKUsingSingleDPP[k] < 2.0 * v->PixelClock[k]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4136  				v->MinDPPCLKUsingSingleDPP[k] = 2.0 * v->PixelClock[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4137  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4138  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4139  			if (v->HRatioChroma[k] > 1.0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4140  				v->PSCL_FACTOR_CHROMA[k] = dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4141  						v->MaxDCHUBToPSCLThroughput,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4142  						v->MaxPSCLToLBThroughput * v->HRatioChroma[k] / dml_ceil(v->HTAPsChroma[k] / 6.0, 1.0));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4143  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4144  				v->PSCL_FACTOR_CHROMA[k] = dml_min(v->MaxDCHUBToPSCLThroughput, v->MaxPSCLToLBThroughput);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4145  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4146  			v->MinDPPCLKUsingSingleDPP[k] = v->PixelClock[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4147  					* dml_max5(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4148  							v->vtaps[k] / 6.0 * dml_min(1.0, v->HRatio[k]),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4149  							v->HRatio[k] * v->VRatio[k] / v->PSCL_FACTOR[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4150  							v->VTAPsChroma[k] / 6.0 * dml_min(1.0, v->HRatioChroma[k]),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4151  							v->HRatioChroma[k] * v->VRatioChroma[k] / v->PSCL_FACTOR_CHROMA[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4152  							1.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4153  			if ((v->htaps[k] > 6.0 || v->vtaps[k] > 6.0 || v->HTAPsChroma[k] > 6.0 || v->VTAPsChroma[k] > 6.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4154  					&& v->MinDPPCLKUsingSingleDPP[k] < 2.0 * v->PixelClock[k]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4155  				v->MinDPPCLKUsingSingleDPP[k] = 2.0 * v->PixelClock[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4156  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4157  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4158  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4159  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4160  		int MaximumSwathWidthSupportLuma;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4161  		int MaximumSwathWidthSupportChroma;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4162  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4163  		if (v->SurfaceTiling[k] == dm_sw_linear) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4164  			MaximumSwathWidthSupportLuma = 8192.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4165  		} else if (v->SourceScan[k] == dm_vert && v->BytePerPixelC[k] > 0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4166  			MaximumSwathWidthSupportLuma = 2880.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4167  		} else if (v->SourcePixelFormat[k] == dm_rgbe_alpha) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4168  			MaximumSwathWidthSupportLuma = 3840.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4169  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4170  			MaximumSwathWidthSupportLuma = 5760.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4171  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4172  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4173  		if (v->SourcePixelFormat[k] == dm_420_8 || v->SourcePixelFormat[k] == dm_420_10 || v->SourcePixelFormat[k] == dm_420_12) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4174  			MaximumSwathWidthSupportChroma = MaximumSwathWidthSupportLuma / 2.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4175  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4176  			MaximumSwathWidthSupportChroma = MaximumSwathWidthSupportLuma;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4177  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4178  		v->MaximumSwathWidthInLineBufferLuma = v->LineBufferSize * dml_max(v->HRatio[k], 1.0) / v->LBBitPerPixel[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4179  				/ (v->vtaps[k] + dml_max(dml_ceil(v->VRatio[k], 1.0) - 2, 0.0));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4180  		if (v->BytePerPixelC[k] == 0.0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4181  			v->MaximumSwathWidthInLineBufferChroma = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4182  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4183  			v->MaximumSwathWidthInLineBufferChroma = v->LineBufferSize * dml_max(v->HRatioChroma[k], 1.0) / v->LBBitPerPixel[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4184  					/ (v->VTAPsChroma[k] + dml_max(dml_ceil(v->VRatioChroma[k], 1.0) - 2, 0.0));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4185  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4186  		v->MaximumSwathWidthLuma[k] = dml_min(MaximumSwathWidthSupportLuma, v->MaximumSwathWidthInLineBufferLuma);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4187  		v->MaximumSwathWidthChroma[k] = dml_min(MaximumSwathWidthSupportChroma, v->MaximumSwathWidthInLineBufferChroma);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4188  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4189  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4190  	CalculateSwathAndDETConfiguration(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4191  			true,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4192  			v->NumberOfActivePlanes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4193  			v->DETBufferSizeInKByte[0],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4194  			v->MaximumSwathWidthLuma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4195  			v->MaximumSwathWidthChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4196  			v->SourceScan,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4197  			v->SourcePixelFormat,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4198  			v->SurfaceTiling,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4199  			v->ViewportWidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4200  			v->ViewportHeight,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4201  			v->SurfaceWidthY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4202  			v->SurfaceWidthC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4203  			v->SurfaceHeightY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4204  			v->SurfaceHeightC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4205  			v->Read256BlockHeightY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4206  			v->Read256BlockHeightC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4207  			v->Read256BlockWidthY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4208  			v->Read256BlockWidthC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4209  			v->odm_combine_dummy,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4210  			v->BlendingAndTiming,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4211  			v->BytePerPixelY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4212  			v->BytePerPixelC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4213  			v->BytePerPixelInDETY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4214  			v->BytePerPixelInDETC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4215  			v->HActive,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4216  			v->HRatio,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4217  			v->HRatioChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4218  			v->NoOfDPPThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4219  			v->swath_width_luma_ub_this_state,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4220  			v->swath_width_chroma_ub_this_state,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4221  			v->SwathWidthYThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4222  			v->SwathWidthCThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4223  			v->SwathHeightYThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4224  			v->SwathHeightCThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4225  			v->DETBufferSizeYThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4226  			v->DETBufferSizeCThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4227  			v->SingleDPPViewportSizeSupportPerPlane,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4228  			&v->ViewportSizeSupport[0][0]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4229  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4230  	for (i = 0; i < v->soc.num_states; i++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4231  		for (j = 0; j < 2; j++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4232  			v->MaxDispclkRoundedDownToDFSGranularity = RoundToDFSGranularityDown(v->MaxDispclk[i], v->DISPCLKDPPCLKVCOSpeed);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4233  			v->MaxDppclkRoundedDownToDFSGranularity = RoundToDFSGranularityDown(v->MaxDppclk[i], v->DISPCLKDPPCLKVCOSpeed);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4234  			v->RequiredDISPCLK[i][j] = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4235  			v->DISPCLK_DPPCLK_Support[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4236  			for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4237  				v->PlaneRequiredDISPCLKWithoutODMCombine = v->PixelClock[k] * (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4238  						* (1.0 + v->DISPCLKRampingMargin / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4239  				if ((v->PlaneRequiredDISPCLKWithoutODMCombine >= v->MaxDispclk[i]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4240  						&& v->MaxDispclk[i] == v->MaxDispclk[v->soc.num_states - 1]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4241  						&& v->MaxDppclk[i] == v->MaxDppclk[v->soc.num_states - 1])) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4242  					v->PlaneRequiredDISPCLKWithoutODMCombine = v->PixelClock[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4243  							* (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4244  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4245  				v->PlaneRequiredDISPCLKWithODMCombine2To1 = v->PixelClock[k] / 2 * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4246  						* (1 + v->DISPCLKRampingMargin / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4247  				if ((v->PlaneRequiredDISPCLKWithODMCombine2To1 >= v->MaxDispclk[i]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4248  						&& v->MaxDispclk[i] == v->MaxDispclk[v->soc.num_states - 1]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4249  						&& v->MaxDppclk[i] == v->MaxDppclk[v->soc.num_states - 1])) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4250  					v->PlaneRequiredDISPCLKWithODMCombine2To1 = v->PixelClock[k] / 2
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4251  							* (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4252  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4253  				v->PlaneRequiredDISPCLKWithODMCombine4To1 = v->PixelClock[k] / 4 * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4254  						* (1 + v->DISPCLKRampingMargin / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4255  				if ((v->PlaneRequiredDISPCLKWithODMCombine4To1 >= v->MaxDispclk[i]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4256  						&& v->MaxDispclk[i] == v->MaxDispclk[v->soc.num_states - 1]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4257  						&& v->MaxDppclk[i] == v->MaxDppclk[v->soc.num_states - 1])) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4258  					v->PlaneRequiredDISPCLKWithODMCombine4To1 = v->PixelClock[k] / 4
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4259  							* (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4260  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4261  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4262  				if (v->ODMCombinePolicy == dm_odm_combine_policy_none
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4263  						|| !(v->Output[k] == dm_dp ||
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4264  						     v->Output[k] == dm_edp)) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4265  					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_disabled;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4266  					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithoutODMCombine;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4267  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4268  					if (v->HActive[k] / 2 > DCN31_MAX_FMT_420_BUFFER_WIDTH)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4269  						FMTBufferExceeded = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4270  				} else if (v->ODMCombinePolicy == dm_odm_combine_policy_2to1) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4271  					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4272  					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine2To1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4273  				} else if (v->ODMCombinePolicy == dm_odm_combine_policy_4to1
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4274  						|| v->PlaneRequiredDISPCLKWithODMCombine2To1 > v->MaxDispclkRoundedDownToDFSGranularity) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4275  					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_4to1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4276  					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine4To1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4277  				} else if (v->PlaneRequiredDISPCLKWithoutODMCombine > v->MaxDispclkRoundedDownToDFSGranularity) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4278  					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4279  					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine2To1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4280  				} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4281  					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_disabled;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4282  					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithoutODMCombine;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4283  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4284  				if (v->DSCEnabled[k] && v->HActive[k] > DCN31_MAX_DSC_IMAGE_WIDTH
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4285  						&& v->ODMCombineEnablePerState[i][k] != dm_odm_combine_mode_4to1) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4286  					if (v->HActive[k] / 2 > DCN31_MAX_DSC_IMAGE_WIDTH) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4287  						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_4to1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4288  						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine4To1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4289  					} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4290  						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4291  						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine2To1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4292  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4293  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4294  				if (v->OutputFormat[k] == dm_420 && v->HActive[k] > DCN31_MAX_FMT_420_BUFFER_WIDTH
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4295  						&& v->ODMCombineEnablePerState[i][k] != dm_odm_combine_mode_4to1) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4296  					if (v->HActive[k] / 2 > DCN31_MAX_FMT_420_BUFFER_WIDTH) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4297  						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_4to1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4298  						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine4To1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4299  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4300  						if (v->HActive[k] / 4 > DCN31_MAX_FMT_420_BUFFER_WIDTH)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4301  							FMTBufferExceeded = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4302  					} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4303  						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4304  						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine2To1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4305  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4306  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4307  				if (v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_4to1) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4308  					v->MPCCombine[i][j][k] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4309  					v->NoOfDPP[i][j][k] = 4;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4310  					v->RequiredDPPCLK[i][j][k] = v->MinDPPCLKUsingSingleDPP[k] * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) / 4;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4311  				} else if (v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_2to1) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4312  					v->MPCCombine[i][j][k] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4313  					v->NoOfDPP[i][j][k] = 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4314  					v->RequiredDPPCLK[i][j][k] = v->MinDPPCLKUsingSingleDPP[k] * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) / 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4315  				} else if ((v->WhenToDoMPCCombine == dm_mpc_never
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4316  						|| (v->MinDPPCLKUsingSingleDPP[k] * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4317  								<= v->MaxDppclkRoundedDownToDFSGranularity && v->SingleDPPViewportSizeSupportPerPlane[k] == true))) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4318  					v->MPCCombine[i][j][k] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4319  					v->NoOfDPP[i][j][k] = 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4320  					v->RequiredDPPCLK[i][j][k] = v->MinDPPCLKUsingSingleDPP[k] * (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4321  				} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4322  					v->MPCCombine[i][j][k] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4323  					v->NoOfDPP[i][j][k] = 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4324  					v->RequiredDPPCLK[i][j][k] = v->MinDPPCLKUsingSingleDPP[k] * (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) / 2.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4325  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4326  				v->RequiredDISPCLK[i][j] = dml_max(v->RequiredDISPCLK[i][j], v->PlaneRequiredDISPCLK);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4327  				if ((v->MinDPPCLKUsingSingleDPP[k] / v->NoOfDPP[i][j][k] * (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4328  						> v->MaxDppclkRoundedDownToDFSGranularity)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4329  						|| (v->PlaneRequiredDISPCLK > v->MaxDispclkRoundedDownToDFSGranularity)) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4330  					v->DISPCLK_DPPCLK_Support[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4331  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4332  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4333  			v->TotalNumberOfActiveDPP[i][j] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4334  			v->TotalNumberOfSingleDPPPlanes[i][j] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4335  			for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4336  				v->TotalNumberOfActiveDPP[i][j] = v->TotalNumberOfActiveDPP[i][j] + v->NoOfDPP[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4337  				if (v->NoOfDPP[i][j][k] == 1)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4338  					v->TotalNumberOfSingleDPPPlanes[i][j] = v->TotalNumberOfSingleDPPPlanes[i][j] + 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4339  				if (v->SourcePixelFormat[k] == dm_420_8 || v->SourcePixelFormat[k] == dm_420_10
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4340  						|| v->SourcePixelFormat[k] == dm_420_12 || v->SourcePixelFormat[k] == dm_rgbe_alpha)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4341  					NoChroma = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4342  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4343  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4344  			// UPTO
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4345  			if (j == 1 && v->WhenToDoMPCCombine != dm_mpc_never
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4346  					&& !UnboundedRequest(v->UseUnboundedRequesting, v->TotalNumberOfActiveDPP[i][j], NoChroma, v->Output[0])) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4347  				while (!(v->TotalNumberOfActiveDPP[i][j] >= v->MaxNumDPP || v->TotalNumberOfSingleDPPPlanes[i][j] == 0)) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4348  					double BWOfNonSplitPlaneOfMaximumBandwidth;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4349  					unsigned int NumberOfNonSplitPlaneOfMaximumBandwidth;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4350  					BWOfNonSplitPlaneOfMaximumBandwidth = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4351  					NumberOfNonSplitPlaneOfMaximumBandwidth = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4352  					for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4353  						if (v->ReadBandwidthLuma[k] + v->ReadBandwidthChroma[k] > BWOfNonSplitPlaneOfMaximumBandwidth
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4354  								&& v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_disabled && v->MPCCombine[i][j][k] == false) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4355  							BWOfNonSplitPlaneOfMaximumBandwidth = v->ReadBandwidthLuma[k] + v->ReadBandwidthChroma[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4356  							NumberOfNonSplitPlaneOfMaximumBandwidth = k;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4357  						}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4358  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4359  					v->MPCCombine[i][j][NumberOfNonSplitPlaneOfMaximumBandwidth] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4360  					v->NoOfDPP[i][j][NumberOfNonSplitPlaneOfMaximumBandwidth] = 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4361  					v->RequiredDPPCLK[i][j][NumberOfNonSplitPlaneOfMaximumBandwidth] =
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4362  							v->MinDPPCLKUsingSingleDPP[NumberOfNonSplitPlaneOfMaximumBandwidth]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4363  									* (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100) / 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4364  					v->TotalNumberOfActiveDPP[i][j] = v->TotalNumberOfActiveDPP[i][j] + 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4365  					v->TotalNumberOfSingleDPPPlanes[i][j] = v->TotalNumberOfSingleDPPPlanes[i][j] - 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4366  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4367  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4368  			if (v->TotalNumberOfActiveDPP[i][j] > v->MaxNumDPP) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4369  				v->RequiredDISPCLK[i][j] = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4370  				v->DISPCLK_DPPCLK_Support[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4371  				for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4372  					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_disabled;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4373  					if (v->SingleDPPViewportSizeSupportPerPlane[k] == false && v->WhenToDoMPCCombine != dm_mpc_never) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4374  						v->MPCCombine[i][j][k] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4375  						v->NoOfDPP[i][j][k] = 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4376  						v->RequiredDPPCLK[i][j][k] = v->MinDPPCLKUsingSingleDPP[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4377  								* (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) / 2.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4378  					} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4379  						v->MPCCombine[i][j][k] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4380  						v->NoOfDPP[i][j][k] = 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4381  						v->RequiredDPPCLK[i][j][k] = v->MinDPPCLKUsingSingleDPP[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4382  								* (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4383  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4384  					if (!(v->MaxDispclk[i] == v->MaxDispclk[v->soc.num_states - 1]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4385  							&& v->MaxDppclk[i] == v->MaxDppclk[v->soc.num_states - 1])) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4386  						v->PlaneRequiredDISPCLK = v->PixelClock[k] * (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4387  								* (1.0 + v->DISPCLKRampingMargin / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4388  					} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4389  						v->PlaneRequiredDISPCLK = v->PixelClock[k] * (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4390  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4391  					v->RequiredDISPCLK[i][j] = dml_max(v->RequiredDISPCLK[i][j], v->PlaneRequiredDISPCLK);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4392  					if ((v->MinDPPCLKUsingSingleDPP[k] / v->NoOfDPP[i][j][k] * (1.0 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4393  							> v->MaxDppclkRoundedDownToDFSGranularity)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4394  							|| (v->PlaneRequiredDISPCLK > v->MaxDispclkRoundedDownToDFSGranularity)) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4395  						v->DISPCLK_DPPCLK_Support[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4396  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4397  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4398  				v->TotalNumberOfActiveDPP[i][j] = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4399  				for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4400  					v->TotalNumberOfActiveDPP[i][j] = v->TotalNumberOfActiveDPP[i][j] + v->NoOfDPP[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4401  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4402  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4403  			v->RequiredDISPCLK[i][j] = dml_max(v->RequiredDISPCLK[i][j], v->WritebackRequiredDISPCLK);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4404  			if (v->MaxDispclkRoundedDownToDFSGranularity < v->WritebackRequiredDISPCLK) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4405  				v->DISPCLK_DPPCLK_Support[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4406  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4407  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4408  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4409  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4410  	/*Total Available Pipes Support Check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4411  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4412  	for (i = 0; i < v->soc.num_states; i++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4413  		for (j = 0; j < 2; j++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4414  			if (v->TotalNumberOfActiveDPP[i][j] <= v->MaxNumDPP) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4415  				v->TotalAvailablePipesSupport[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4416  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4417  				v->TotalAvailablePipesSupport[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4418  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4419  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4420  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4421  	/*Display IO and DSC Support Check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4422  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4423  	v->NonsupportedDSCInputBPC = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4424  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4425  		if (!(v->DSCInputBitPerComponent[k] == 12.0 || v->DSCInputBitPerComponent[k] == 10.0 || v->DSCInputBitPerComponent[k] == 8.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4426  				|| v->DSCInputBitPerComponent[k] > v->MaximumDSCBitsPerComponent) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4427  			v->NonsupportedDSCInputBPC = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4428  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4429  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4430  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4431  	/*Number Of DSC Slices*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4432  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4433  		if (v->BlendingAndTiming[k] == k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4434  			if (v->PixelClockBackEnd[k] > 3200) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4435  				v->NumberOfDSCSlices[k] = dml_ceil(v->PixelClockBackEnd[k] / 400.0, 4.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4436  			} else if (v->PixelClockBackEnd[k] > 1360) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4437  				v->NumberOfDSCSlices[k] = 8;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4438  			} else if (v->PixelClockBackEnd[k] > 680) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4439  				v->NumberOfDSCSlices[k] = 4;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4440  			} else if (v->PixelClockBackEnd[k] > 340) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4441  				v->NumberOfDSCSlices[k] = 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4442  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4443  				v->NumberOfDSCSlices[k] = 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4444  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4445  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4446  			v->NumberOfDSCSlices[k] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4447  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4448  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4449  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4450  	for (i = 0; i < v->soc.num_states; i++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4451  		for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4452  			v->RequiresDSC[i][k] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4453  			v->RequiresFEC[i][k] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4454  			if (v->BlendingAndTiming[k] == k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4455  				if (v->Output[k] == dm_hdmi) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4456  					v->RequiresDSC[i][k] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4457  					v->RequiresFEC[i][k] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4458  					v->OutputBppPerState[i][k] = TruncToValidBPP(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4459  							dml_min(600.0, v->PHYCLKPerState[i]) * 10,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4460  							3,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4461  							v->HTotal[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4462  							v->HActive[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4463  							v->PixelClockBackEnd[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4464  							v->ForcedOutputLinkBPP[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4465  							false,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4466  							v->Output[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4467  							v->OutputFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4468  							v->DSCInputBitPerComponent[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4469  							v->NumberOfDSCSlices[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4470  							v->AudioSampleRate[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4471  							v->AudioSampleLayout[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4472  							v->ODMCombineEnablePerState[i][k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4473  				} else if (v->Output[k] == dm_dp || v->Output[k] == dm_edp) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4474  					if (v->DSCEnable[k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4475  						v->RequiresDSC[i][k] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4476  						v->LinkDSCEnable = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4477  						if (v->Output[k] == dm_dp) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4478  							v->RequiresFEC[i][k] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4479  						} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4480  							v->RequiresFEC[i][k] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4481  						}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4482  					} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4483  						v->RequiresDSC[i][k] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4484  						v->LinkDSCEnable = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4485  						v->RequiresFEC[i][k] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4486  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4487  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4488  					v->Outbpp = BPP_INVALID;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4489  					if (v->PHYCLKPerState[i] >= 270.0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4490  						v->Outbpp = TruncToValidBPP(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4491  								(1.0 - v->Downspreading / 100.0) * 2700,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4492  								v->OutputLinkDPLanes[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4493  								v->HTotal[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4494  								v->HActive[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4495  								v->PixelClockBackEnd[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4496  								v->ForcedOutputLinkBPP[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4497  								v->LinkDSCEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4498  								v->Output[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4499  								v->OutputFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4500  								v->DSCInputBitPerComponent[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4501  								v->NumberOfDSCSlices[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4502  								v->AudioSampleRate[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4503  								v->AudioSampleLayout[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4504  								v->ODMCombineEnablePerState[i][k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4505  						v->OutputBppPerState[i][k] = v->Outbpp;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4506  						// TODO: Need some other way to handle this nonsense
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4507  						// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR"
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4508  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4509  					if (v->Outbpp == BPP_INVALID && v->PHYCLKPerState[i] >= 540.0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4510  						v->Outbpp = TruncToValidBPP(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4511  								(1.0 - v->Downspreading / 100.0) * 5400,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4512  								v->OutputLinkDPLanes[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4513  								v->HTotal[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4514  								v->HActive[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4515  								v->PixelClockBackEnd[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4516  								v->ForcedOutputLinkBPP[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4517  								v->LinkDSCEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4518  								v->Output[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4519  								v->OutputFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4520  								v->DSCInputBitPerComponent[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4521  								v->NumberOfDSCSlices[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4522  								v->AudioSampleRate[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4523  								v->AudioSampleLayout[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4524  								v->ODMCombineEnablePerState[i][k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4525  						v->OutputBppPerState[i][k] = v->Outbpp;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4526  						// TODO: Need some other way to handle this nonsense
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4527  						// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR2"
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4528  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4529  					if (v->Outbpp == BPP_INVALID && v->PHYCLKPerState[i] >= 810.0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4530  						v->Outbpp = TruncToValidBPP(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4531  								(1.0 - v->Downspreading / 100.0) * 8100,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4532  								v->OutputLinkDPLanes[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4533  								v->HTotal[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4534  								v->HActive[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4535  								v->PixelClockBackEnd[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4536  								v->ForcedOutputLinkBPP[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4537  								v->LinkDSCEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4538  								v->Output[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4539  								v->OutputFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4540  								v->DSCInputBitPerComponent[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4541  								v->NumberOfDSCSlices[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4542  								v->AudioSampleRate[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4543  								v->AudioSampleLayout[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4544  								v->ODMCombineEnablePerState[i][k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4545  						v->OutputBppPerState[i][k] = v->Outbpp;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4546  						// TODO: Need some other way to handle this nonsense
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4547  						// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR3"
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4548  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4549  					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 10000.0 / 18) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4550  						v->Outbpp = TruncToValidBPP(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4551  								(1.0 - v->Downspreading / 100.0) * 10000,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4552  								4,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4553  								v->HTotal[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4554  								v->HActive[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4555  								v->PixelClockBackEnd[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4556  								v->ForcedOutputLinkBPP[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4557  								v->LinkDSCEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4558  								v->Output[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4559  								v->OutputFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4560  								v->DSCInputBitPerComponent[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4561  								v->NumberOfDSCSlices[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4562  								v->AudioSampleRate[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4563  								v->AudioSampleLayout[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4564  								v->ODMCombineEnablePerState[i][k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4565  						v->OutputBppPerState[i][k] = v->Outbpp;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4566  						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "10x4";
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4567  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4568  					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 12000.0 / 18) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4569  						v->Outbpp = TruncToValidBPP(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4570  								12000,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4571  								4,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4572  								v->HTotal[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4573  								v->HActive[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4574  								v->PixelClockBackEnd[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4575  								v->ForcedOutputLinkBPP[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4576  								v->LinkDSCEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4577  								v->Output[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4578  								v->OutputFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4579  								v->DSCInputBitPerComponent[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4580  								v->NumberOfDSCSlices[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4581  								v->AudioSampleRate[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4582  								v->AudioSampleLayout[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4583  								v->ODMCombineEnablePerState[i][k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4584  						v->OutputBppPerState[i][k] = v->Outbpp;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4585  						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "12x4";
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4586  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4587  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4588  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4589  				v->OutputBppPerState[i][k] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4590  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4591  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4592  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4593  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4594  	for (i = 0; i < v->soc.num_states; i++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4595  		v->LinkCapacitySupport[i] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4596  		for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4597  			if (v->BlendingAndTiming[k] == k
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4598  					&& (v->Output[k] == dm_dp ||
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4599  					    v->Output[k] == dm_edp ||
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4600  					    v->Output[k] == dm_hdmi) && v->OutputBppPerState[i][k] == 0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4601  				v->LinkCapacitySupport[i] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4602  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4603  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4604  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4605  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4606  	// UPTO 2172
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4607  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4608  		if (v->BlendingAndTiming[k] == k
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4609  				&& (v->Output[k] == dm_dp ||
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4610  				    v->Output[k] == dm_edp ||
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4611  				    v->Output[k] == dm_hdmi)) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4612  			if (v->OutputFormat[k] == dm_420 && v->Interlace[k] == 1 && v->ProgressiveToInterlaceUnitInOPP == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4613  				P2IWith420 = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4614  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4615  			if (v->DSCEnable[k] == true && v->OutputFormat[k] == dm_n422
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4616  					&& !v->DSC422NativeSupport) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4617  				DSC422NativeNotSupported = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4618  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4619  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4620  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4621  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4622  	for (i = 0; i < v->soc.num_states; ++i) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4623  		v->ODMCombine4To1SupportCheckOK[i] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4624  		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4625  			if (v->BlendingAndTiming[k] == k && v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_4to1
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4626  					&& (v->ODMCombine4To1Supported == false || v->Output[k] == dm_dp || v->Output[k] == dm_edp
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4627  							|| v->Output[k] == dm_hdmi)) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4628  				v->ODMCombine4To1SupportCheckOK[i] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4629  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4630  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4631  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4632  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4633  	/* Skip dscclk validation: as long as dispclk is supported, dscclk is also implicitly supported */
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4634  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4635  	for (i = 0; i < v->soc.num_states; i++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4636  		v->NotEnoughDSCUnits[i] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4637  		v->TotalDSCUnitsRequired = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4638  		for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4639  			if (v->RequiresDSC[i][k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4640  				if (v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_4to1) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4641  					v->TotalDSCUnitsRequired = v->TotalDSCUnitsRequired + 4.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4642  				} else if (v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_2to1) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4643  					v->TotalDSCUnitsRequired = v->TotalDSCUnitsRequired + 2.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4644  				} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4645  					v->TotalDSCUnitsRequired = v->TotalDSCUnitsRequired + 1.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4646  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4647  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4648  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4649  		if (v->TotalDSCUnitsRequired > v->NumberOfDSC) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4650  			v->NotEnoughDSCUnits[i] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4651  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4652  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4653  	/*DSC Delay per state*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4654  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4655  	for (i = 0; i < v->soc.num_states; i++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4656  		for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4657  			if (v->OutputBppPerState[i][k] == BPP_INVALID) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4658  				v->BPP = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4659  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4660  				v->BPP = v->OutputBppPerState[i][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4661  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4662  			if (v->RequiresDSC[i][k] == true && v->BPP != 0.0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4663  				if (v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_disabled) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4664  					v->DSCDelayPerState[i][k] = dscceComputeDelay(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4665  							v->DSCInputBitPerComponent[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4666  							v->BPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4667  							dml_ceil(1.0 * v->HActive[k] / v->NumberOfDSCSlices[k], 1.0),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4668  							v->NumberOfDSCSlices[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4669  							v->OutputFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4670  							v->Output[k]) + dscComputeDelay(v->OutputFormat[k], v->Output[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4671  				} else if (v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_2to1) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4672  					v->DSCDelayPerState[i][k] = 2.0
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4673  							* (dscceComputeDelay(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4674  									v->DSCInputBitPerComponent[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4675  									v->BPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4676  									dml_ceil(1.0 * v->HActive[k] / v->NumberOfDSCSlices[k], 1.0),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4677  									v->NumberOfDSCSlices[k] / 2,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4678  									v->OutputFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4679  									v->Output[k]) + dscComputeDelay(v->OutputFormat[k], v->Output[k]));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4680  				} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4681  					v->DSCDelayPerState[i][k] = 4.0
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4682  							* (dscceComputeDelay(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4683  									v->DSCInputBitPerComponent[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4684  									v->BPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4685  									dml_ceil(1.0 * v->HActive[k] / v->NumberOfDSCSlices[k], 1.0),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4686  									v->NumberOfDSCSlices[k] / 4,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4687  									v->OutputFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4688  									v->Output[k]) + dscComputeDelay(v->OutputFormat[k], v->Output[k]));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4689  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4690  				v->DSCDelayPerState[i][k] = v->DSCDelayPerState[i][k] * v->PixelClock[k] / v->PixelClockBackEnd[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4691  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4692  				v->DSCDelayPerState[i][k] = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4693  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4694  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4695  		for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4696  			for (m = 0; m < v->NumberOfActivePlanes; m++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4697  				if (v->BlendingAndTiming[k] == m && v->RequiresDSC[i][m] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4698  					v->DSCDelayPerState[i][k] = v->DSCDelayPerState[i][m];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4699  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4700  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4701  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4702  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4703  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4704  	//Calculate Swath, DET Configuration, DCFCLKDeepSleep
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4705  	//
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4706  	for (i = 0; i < v->soc.num_states; ++i) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4707  		for (j = 0; j <= 1; ++j) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4708  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4709  				v->RequiredDPPCLKThisState[k] = v->RequiredDPPCLK[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4710  				v->NoOfDPPThisState[k] = v->NoOfDPP[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4711  				v->ODMCombineEnableThisState[k] = v->ODMCombineEnablePerState[i][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4712  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4713  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4714  			CalculateSwathAndDETConfiguration(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4715  					false,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4716  					v->NumberOfActivePlanes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4717  					v->DETBufferSizeInKByte[0],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4718  					v->MaximumSwathWidthLuma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4719  					v->MaximumSwathWidthChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4720  					v->SourceScan,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4721  					v->SourcePixelFormat,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4722  					v->SurfaceTiling,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4723  					v->ViewportWidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4724  					v->ViewportHeight,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4725  					v->SurfaceWidthY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4726  					v->SurfaceWidthC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4727  					v->SurfaceHeightY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4728  					v->SurfaceHeightC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4729  					v->Read256BlockHeightY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4730  					v->Read256BlockHeightC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4731  					v->Read256BlockWidthY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4732  					v->Read256BlockWidthC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4733  					v->ODMCombineEnableThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4734  					v->BlendingAndTiming,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4735  					v->BytePerPixelY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4736  					v->BytePerPixelC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4737  					v->BytePerPixelInDETY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4738  					v->BytePerPixelInDETC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4739  					v->HActive,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4740  					v->HRatio,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4741  					v->HRatioChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4742  					v->NoOfDPPThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4743  					v->swath_width_luma_ub_this_state,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4744  					v->swath_width_chroma_ub_this_state,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4745  					v->SwathWidthYThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4746  					v->SwathWidthCThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4747  					v->SwathHeightYThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4748  					v->SwathHeightCThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4749  					v->DETBufferSizeYThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4750  					v->DETBufferSizeCThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4751  					v->dummystring,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4752  					&v->ViewportSizeSupport[i][j]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4753  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4754  			CalculateDCFCLKDeepSleep(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4755  					mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4756  					v->NumberOfActivePlanes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4757  					v->BytePerPixelY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4758  					v->BytePerPixelC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4759  					v->VRatio,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4760  					v->VRatioChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4761  					v->SwathWidthYThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4762  					v->SwathWidthCThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4763  					v->NoOfDPPThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4764  					v->HRatio,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4765  					v->HRatioChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4766  					v->PixelClock,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4767  					v->PSCL_FACTOR,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4768  					v->PSCL_FACTOR_CHROMA,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4769  					v->RequiredDPPCLKThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4770  					v->ReadBandwidthLuma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4771  					v->ReadBandwidthChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4772  					v->ReturnBusWidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4773  					&v->ProjectedDCFCLKDeepSleep[i][j]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4774  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4775  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4776  				v->swath_width_luma_ub_all_states[i][j][k] = v->swath_width_luma_ub_this_state[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4777  				v->swath_width_chroma_ub_all_states[i][j][k] = v->swath_width_chroma_ub_this_state[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4778  				v->SwathWidthYAllStates[i][j][k] = v->SwathWidthYThisState[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4779  				v->SwathWidthCAllStates[i][j][k] = v->SwathWidthCThisState[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4780  				v->SwathHeightYAllStates[i][j][k] = v->SwathHeightYThisState[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4781  				v->SwathHeightCAllStates[i][j][k] = v->SwathHeightCThisState[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4782  				v->DETBufferSizeYAllStates[i][j][k] = v->DETBufferSizeYThisState[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4783  				v->DETBufferSizeCAllStates[i][j][k] = v->DETBufferSizeCThisState[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4784  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4785  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4786  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4787  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4788  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4789  		v->cursor_bw[k] = v->NumberOfCursors[k] * v->CursorWidth[k][0] * v->CursorBPP[k][0] / 8.0
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4790  				/ (v->HTotal[k] / v->PixelClock[k]) * v->VRatio[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4791  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4792  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4793  	for (i = 0; i < v->soc.num_states; i++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4794  		for (j = 0; j < 2; j++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4795  			bool NotUrgentLatencyHiding[DC__NUM_DPP__MAX];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4796  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4797  			for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4798  				v->swath_width_luma_ub_this_state[k] = v->swath_width_luma_ub_all_states[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4799  				v->swath_width_chroma_ub_this_state[k] = v->swath_width_chroma_ub_all_states[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4800  				v->SwathWidthYThisState[k] = v->SwathWidthYAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4801  				v->SwathWidthCThisState[k] = v->SwathWidthCAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4802  				v->SwathHeightYThisState[k] = v->SwathHeightYAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4803  				v->SwathHeightCThisState[k] = v->SwathHeightCAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4804  				v->DETBufferSizeYThisState[k] = v->DETBufferSizeYAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4805  				v->DETBufferSizeCThisState[k] = v->DETBufferSizeCAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4806  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4807  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4808  			v->TotalNumberOfDCCActiveDPP[i][j] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4809  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4810  				if (v->DCCEnable[k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4811  					v->TotalNumberOfDCCActiveDPP[i][j] = v->TotalNumberOfDCCActiveDPP[i][j] + v->NoOfDPP[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4812  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4813  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4814  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4815  			for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4816  				if (v->SourcePixelFormat[k] == dm_420_8 || v->SourcePixelFormat[k] == dm_420_10
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4817  						|| v->SourcePixelFormat[k] == dm_420_12 || v->SourcePixelFormat[k] == dm_rgbe_alpha) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4818  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4819  					if ((v->SourcePixelFormat[k] == dm_420_10 || v->SourcePixelFormat[k] == dm_420_12)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4820  							&& v->SourceScan[k] != dm_vert) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4821  						v->PTEBufferSizeInRequestsForLuma = (v->PTEBufferSizeInRequestsLuma + v->PTEBufferSizeInRequestsChroma)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4822  								/ 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4823  						v->PTEBufferSizeInRequestsForChroma = v->PTEBufferSizeInRequestsForLuma;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4824  					} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4825  						v->PTEBufferSizeInRequestsForLuma = v->PTEBufferSizeInRequestsLuma;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4826  						v->PTEBufferSizeInRequestsForChroma = v->PTEBufferSizeInRequestsChroma;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4827  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4828  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4829  					v->PDEAndMetaPTEBytesPerFrameC = CalculateVMAndRowBytes(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4830  							mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4831  							v->DCCEnable[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4832  							v->Read256BlockHeightC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4833  							v->Read256BlockWidthC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4834  							v->SourcePixelFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4835  							v->SurfaceTiling[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4836  							v->BytePerPixelC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4837  							v->SourceScan[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4838  							v->SwathWidthCThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4839  							v->ViewportHeightChroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4840  							v->GPUVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4841  							v->HostVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4842  							v->HostVMMaxNonCachedPageTableLevels,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4843  							v->GPUVMMinPageSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4844  							v->HostVMMinPageSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4845  							v->PTEBufferSizeInRequestsForChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4846  							v->PitchC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4847  							0.0,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4848  							&v->MacroTileWidthC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4849  							&v->MetaRowBytesC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4850  							&v->DPTEBytesPerRowC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4851  							&v->PTEBufferSizeNotExceededC[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4852  							&v->dummyinteger7,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4853  							&v->dpte_row_height_chroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4854  							&v->dummyinteger28,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4855  							&v->dummyinteger26,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4856  							&v->dummyinteger23,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4857  							&v->meta_row_height_chroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4858  							&v->dummyinteger8,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4859  							&v->dummyinteger9,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4860  							&v->dummyinteger19,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4861  							&v->dummyinteger20,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4862  							&v->dummyinteger17,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4863  							&v->dummyinteger10,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4864  							&v->dummyinteger11);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4865  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4866  					v->PrefetchLinesC[i][j][k] = CalculatePrefetchSourceLines(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4867  							mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4868  							v->VRatioChroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4869  							v->VTAPsChroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4870  							v->Interlace[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4871  							v->ProgressiveToInterlaceUnitInOPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4872  							v->SwathHeightCThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4873  							v->ViewportYStartC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4874  							&v->PrefillC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4875  							&v->MaxNumSwC[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4876  				} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4877  					v->PTEBufferSizeInRequestsForLuma = v->PTEBufferSizeInRequestsLuma + v->PTEBufferSizeInRequestsChroma;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4878  					v->PTEBufferSizeInRequestsForChroma = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4879  					v->PDEAndMetaPTEBytesPerFrameC = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4880  					v->MetaRowBytesC = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4881  					v->DPTEBytesPerRowC = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4882  					v->PrefetchLinesC[i][j][k] = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4883  					v->PTEBufferSizeNotExceededC[i][j][k] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4884  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4885  				v->PDEAndMetaPTEBytesPerFrameY = CalculateVMAndRowBytes(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4886  						mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4887  						v->DCCEnable[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4888  						v->Read256BlockHeightY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4889  						v->Read256BlockWidthY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4890  						v->SourcePixelFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4891  						v->SurfaceTiling[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4892  						v->BytePerPixelY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4893  						v->SourceScan[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4894  						v->SwathWidthYThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4895  						v->ViewportHeight[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4896  						v->GPUVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4897  						v->HostVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4898  						v->HostVMMaxNonCachedPageTableLevels,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4899  						v->GPUVMMinPageSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4900  						v->HostVMMinPageSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4901  						v->PTEBufferSizeInRequestsForLuma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4902  						v->PitchY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4903  						v->DCCMetaPitchY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4904  						&v->MacroTileWidthY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4905  						&v->MetaRowBytesY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4906  						&v->DPTEBytesPerRowY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4907  						&v->PTEBufferSizeNotExceededY[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4908  						&v->dummyinteger7,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4909  						&v->dpte_row_height[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4910  						&v->dummyinteger29,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4911  						&v->dummyinteger27,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4912  						&v->dummyinteger24,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4913  						&v->meta_row_height[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4914  						&v->dummyinteger25,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4915  						&v->dpte_group_bytes[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4916  						&v->dummyinteger21,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4917  						&v->dummyinteger22,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4918  						&v->dummyinteger18,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4919  						&v->dummyinteger5,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4920  						&v->dummyinteger6);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4921  				v->PrefetchLinesY[i][j][k] = CalculatePrefetchSourceLines(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4922  						mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4923  						v->VRatio[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4924  						v->vtaps[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4925  						v->Interlace[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4926  						v->ProgressiveToInterlaceUnitInOPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4927  						v->SwathHeightYThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4928  						v->ViewportYStartY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4929  						&v->PrefillY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4930  						&v->MaxNumSwY[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4931  				v->PDEAndMetaPTEBytesPerFrame[i][j][k] = v->PDEAndMetaPTEBytesPerFrameY + v->PDEAndMetaPTEBytesPerFrameC;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4932  				v->MetaRowBytes[i][j][k] = v->MetaRowBytesY + v->MetaRowBytesC;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4933  				v->DPTEBytesPerRow[i][j][k] = v->DPTEBytesPerRowY + v->DPTEBytesPerRowC;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4934  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4935  				CalculateRowBandwidth(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4936  						v->GPUVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4937  						v->SourcePixelFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4938  						v->VRatio[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4939  						v->VRatioChroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4940  						v->DCCEnable[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4941  						v->HTotal[k] / v->PixelClock[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4942  						v->MetaRowBytesY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4943  						v->MetaRowBytesC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4944  						v->meta_row_height[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4945  						v->meta_row_height_chroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4946  						v->DPTEBytesPerRowY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4947  						v->DPTEBytesPerRowC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4948  						v->dpte_row_height[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4949  						v->dpte_row_height_chroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4950  						&v->meta_row_bandwidth[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4951  						&v->dpte_row_bandwidth[i][j][k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4952  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4953  			v->UrgLatency[i] = CalculateUrgentLatency(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4954  					v->UrgentLatencyPixelDataOnly,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4955  					v->UrgentLatencyPixelMixedWithVMData,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4956  					v->UrgentLatencyVMDataOnly,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4957  					v->DoUrgentLatencyAdjustment,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4958  					v->UrgentLatencyAdjustmentFabricClockComponent,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4959  					v->UrgentLatencyAdjustmentFabricClockReference,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4960  					v->FabricClockPerState[i]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4961  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4962  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4963  				CalculateUrgentBurstFactor(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4964  						v->swath_width_luma_ub_this_state[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4965  						v->swath_width_chroma_ub_this_state[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4966  						v->SwathHeightYThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4967  						v->SwathHeightCThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4968  						v->HTotal[k] / v->PixelClock[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4969  						v->UrgLatency[i],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4970  						v->CursorBufferSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4971  						v->CursorWidth[k][0],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4972  						v->CursorBPP[k][0],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4973  						v->VRatio[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4974  						v->VRatioChroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4975  						v->BytePerPixelInDETY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4976  						v->BytePerPixelInDETC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4977  						v->DETBufferSizeYThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4978  						v->DETBufferSizeCThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4979  						&v->UrgentBurstFactorCursor[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4980  						&v->UrgentBurstFactorLuma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4981  						&v->UrgentBurstFactorChroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4982  						&NotUrgentLatencyHiding[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4983  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4984  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4985  			v->NotEnoughUrgentLatencyHidingA[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4986  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4987  				if (NotUrgentLatencyHiding[k]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4988  					v->NotEnoughUrgentLatencyHidingA[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4989  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4990  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4991  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4992  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4993  				v->VActivePixelBandwidth[i][j][k] = v->ReadBandwidthLuma[k] * v->UrgentBurstFactorLuma[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4994  						+ v->ReadBandwidthChroma[k] * v->UrgentBurstFactorChroma[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4995  				v->VActiveCursorBandwidth[i][j][k] = v->cursor_bw[k] * v->UrgentBurstFactorCursor[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4996  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4997  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4998  			v->TotalVActivePixelBandwidth[i][j] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  4999  			v->TotalVActiveCursorBandwidth[i][j] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5000  			v->TotalMetaRowBandwidth[i][j] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5001  			v->TotalDPTERowBandwidth[i][j] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5002  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5003  				v->TotalVActivePixelBandwidth[i][j] = v->TotalVActivePixelBandwidth[i][j] + v->VActivePixelBandwidth[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5004  				v->TotalVActiveCursorBandwidth[i][j] = v->TotalVActiveCursorBandwidth[i][j] + v->VActiveCursorBandwidth[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5005  				v->TotalMetaRowBandwidth[i][j] = v->TotalMetaRowBandwidth[i][j] + v->NoOfDPP[i][j][k] * v->meta_row_bandwidth[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5006  				v->TotalDPTERowBandwidth[i][j] = v->TotalDPTERowBandwidth[i][j] + v->NoOfDPP[i][j][k] * v->dpte_row_bandwidth[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5007  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5008  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5009  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5010  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5011  	//Calculate Return BW
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5012  	for (i = 0; i < v->soc.num_states; ++i) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5013  		for (j = 0; j <= 1; ++j) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5014  			for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5015  				if (v->BlendingAndTiming[k] == k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5016  					if (v->WritebackEnable[k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5017  						v->WritebackDelayTime[k] = v->WritebackLatency
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5018  								+ CalculateWriteBackDelay(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5019  										v->WritebackPixelFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5020  										v->WritebackHRatio[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5021  										v->WritebackVRatio[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5022  										v->WritebackVTaps[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5023  										v->WritebackDestinationWidth[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5024  										v->WritebackDestinationHeight[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5025  										v->WritebackSourceHeight[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5026  										v->HTotal[k]) / v->RequiredDISPCLK[i][j];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5027  					} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5028  						v->WritebackDelayTime[k] = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5029  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5030  					for (m = 0; m < v->NumberOfActivePlanes; m++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5031  						if (v->BlendingAndTiming[m] == k && v->WritebackEnable[m] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5032  							v->WritebackDelayTime[k] = dml_max(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5033  									v->WritebackDelayTime[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5034  									v->WritebackLatency
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5035  											+ CalculateWriteBackDelay(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5036  													v->WritebackPixelFormat[m],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5037  													v->WritebackHRatio[m],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5038  													v->WritebackVRatio[m],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5039  													v->WritebackVTaps[m],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5040  													v->WritebackDestinationWidth[m],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5041  													v->WritebackDestinationHeight[m],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5042  													v->WritebackSourceHeight[m],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5043  													v->HTotal[m]) / v->RequiredDISPCLK[i][j]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5044  						}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5045  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5046  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5047  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5048  			for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5049  				for (m = 0; m < v->NumberOfActivePlanes; m++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5050  					if (v->BlendingAndTiming[k] == m) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5051  						v->WritebackDelayTime[k] = v->WritebackDelayTime[m];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5052  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5053  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5054  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5055  			v->MaxMaxVStartup[i][j] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5056  			for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5057  				v->MaximumVStartup[i][j][k] =
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5058  						(v->Interlace[k] && !v->ProgressiveToInterlaceUnitInOPP) ?
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5059  								dml_floor((v->VTotal[k] - v->VActive[k]) / 2.0, 1.0) :
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5060  								v->VTotal[k] - v->VActive[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5061  										- dml_max(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5062  												1.0,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5063  												dml_ceil(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5064  														1.0 * v->WritebackDelayTime[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5065  																/ (v->HTotal[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5066  																		/ v->PixelClock[k]),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5067  														1.0));
5d9e7fe8ef9b1c Nikola Cornij       2021-06-07  5068  				if (v->MaximumVStartup[i][j][k] > 1023)
5d9e7fe8ef9b1c Nikola Cornij       2021-06-07  5069  					v->MaximumVStartup[i][j][k] = 1023;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5070  				v->MaxMaxVStartup[i][j] = dml_max(v->MaxMaxVStartup[i][j], v->MaximumVStartup[i][j][k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5071  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5072  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5073  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5074  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5075  	ReorderingBytes = v->NumberOfChannels
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5076  			* dml_max3(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5077  					v->UrgentOutOfOrderReturnPerChannelPixelDataOnly,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5078  					v->UrgentOutOfOrderReturnPerChannelPixelMixedWithVMData,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5079  					v->UrgentOutOfOrderReturnPerChannelVMDataOnly);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5080  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5081  	for (i = 0; i < v->soc.num_states; ++i) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5082  		for (j = 0; j <= 1; ++j) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5083  			v->DCFCLKState[i][j] = v->DCFCLKPerState[i];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5084  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5085  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5086  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5087  	if (v->UseMinimumRequiredDCFCLK == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5088  		UseMinimumDCFCLK(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5089  				mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5090  				v->MaxInterDCNTileRepeaters,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5091  				MaxPrefetchMode,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5092  				v->DRAMClockChangeLatency,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5093  				v->SREnterPlusExitTime,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5094  				v->ReturnBusWidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5095  				v->RoundTripPingLatencyCycles,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5096  				ReorderingBytes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5097  				v->PixelChunkSizeInKByte,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5098  				v->MetaChunkSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5099  				v->GPUVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5100  				v->GPUVMMaxPageTableLevels,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5101  				v->HostVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5102  				v->NumberOfActivePlanes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5103  				v->HostVMMinPageSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5104  				v->HostVMMaxNonCachedPageTableLevels,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5105  				v->DynamicMetadataVMEnabled,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5106  				v->ImmediateFlipRequirement,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5107  				v->ProgressiveToInterlaceUnitInOPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5108  				v->MaxAveragePercentOfIdealFabricAndSDPPortBWDisplayCanUseInNormalSystemOperation,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5109  				v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5110  				v->VTotal,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5111  				v->VActive,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5112  				v->DynamicMetadataTransmittedBytes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5113  				v->DynamicMetadataLinesBeforeActiveRequired,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5114  				v->Interlace,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5115  				v->RequiredDPPCLK,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5116  				v->RequiredDISPCLK,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5117  				v->UrgLatency,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5118  				v->NoOfDPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5119  				v->ProjectedDCFCLKDeepSleep,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5120  				v->MaximumVStartup,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5121  				v->TotalVActivePixelBandwidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5122  				v->TotalVActiveCursorBandwidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5123  				v->TotalMetaRowBandwidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5124  				v->TotalDPTERowBandwidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5125  				v->TotalNumberOfActiveDPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5126  				v->TotalNumberOfDCCActiveDPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5127  				v->dpte_group_bytes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5128  				v->PrefetchLinesY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5129  				v->PrefetchLinesC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5130  				v->swath_width_luma_ub_all_states,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5131  				v->swath_width_chroma_ub_all_states,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5132  				v->BytePerPixelY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5133  				v->BytePerPixelC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5134  				v->HTotal,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5135  				v->PixelClock,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5136  				v->PDEAndMetaPTEBytesPerFrame,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5137  				v->DPTEBytesPerRow,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5138  				v->MetaRowBytes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5139  				v->DynamicMetadataEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5140  				v->VActivePixelBandwidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5141  				v->VActiveCursorBandwidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5142  				v->ReadBandwidthLuma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5143  				v->ReadBandwidthChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5144  				v->DCFCLKPerState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5145  				v->DCFCLKState);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5146  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5147  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5148  	for (i = 0; i < v->soc.num_states; ++i) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5149  		for (j = 0; j <= 1; ++j) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5150  			double IdealFabricAndSDPPortBandwidthPerState = dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5151  					v->ReturnBusWidth * v->DCFCLKState[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5152  					v->FabricClockPerState[i] * v->FabricDatapathToDCNDataReturn);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5153  			double IdealDRAMBandwidthPerState = v->DRAMSpeedPerState[i] * v->NumberOfChannels * v->DRAMChannelWidth;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5154  			double PixelDataOnlyReturnBWPerState = dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5155  					IdealFabricAndSDPPortBandwidthPerState * v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency / 100.0,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5156  					IdealDRAMBandwidthPerState * v->PercentOfIdealDRAMBWReceivedAfterUrgLatencyPixelDataOnly / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5157  			double PixelMixedWithVMDataReturnBWPerState = dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5158  					IdealFabricAndSDPPortBandwidthPerState * v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency / 100.0,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5159  					IdealDRAMBandwidthPerState * v->PercentOfIdealDRAMBWReceivedAfterUrgLatencyPixelMixedWithVMData / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5160  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5161  			if (v->HostVMEnable != true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5162  				v->ReturnBWPerState[i][j] = PixelDataOnlyReturnBWPerState;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5163  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5164  				v->ReturnBWPerState[i][j] = PixelMixedWithVMDataReturnBWPerState;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5165  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5166  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5167  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5168  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5169  	//Re-ordering Buffer Support Check
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5170  	for (i = 0; i < v->soc.num_states; ++i) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5171  		for (j = 0; j <= 1; ++j) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5172  			if ((v->ROBBufferSizeInKByte - v->PixelChunkSizeInKByte) * 1024 / v->ReturnBWPerState[i][j]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5173  					> (v->RoundTripPingLatencyCycles + __DML_ARB_TO_RET_DELAY__) / v->DCFCLKState[i][j] + ReorderingBytes / v->ReturnBWPerState[i][j]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5174  				v->ROBSupport[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5175  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5176  				v->ROBSupport[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5177  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5178  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5179  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5180  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5181  	//Vertical Active BW support check
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5182  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5183  	MaxTotalVActiveRDBandwidth = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5184  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5185  		MaxTotalVActiveRDBandwidth = MaxTotalVActiveRDBandwidth + v->ReadBandwidthLuma[k] + v->ReadBandwidthChroma[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5186  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5187  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5188  	for (i = 0; i < v->soc.num_states; ++i) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5189  		for (j = 0; j <= 1; ++j) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5190  			v->MaxTotalVerticalActiveAvailableBandwidth[i][j] = dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5191  					dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5192  							v->ReturnBusWidth * v->DCFCLKState[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5193  							v->FabricClockPerState[i] * v->FabricDatapathToDCNDataReturn)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5194  							* v->MaxAveragePercentOfIdealFabricAndSDPPortBWDisplayCanUseInNormalSystemOperation / 100,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5195  					v->DRAMSpeedPerState[i] * v->NumberOfChannels * v->DRAMChannelWidth
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5196  							* v->MaxAveragePercentOfIdealDRAMBWDisplayCanUseInNormalSystemOperation / 100);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5197  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5198  			if (MaxTotalVActiveRDBandwidth <= v->MaxTotalVerticalActiveAvailableBandwidth[i][j]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5199  				v->TotalVerticalActiveBandwidthSupport[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5200  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5201  				v->TotalVerticalActiveBandwidthSupport[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5202  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5203  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5204  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5205  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5206  	v->UrgentLatency = CalculateUrgentLatency(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5207  			v->UrgentLatencyPixelDataOnly,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5208  			v->UrgentLatencyPixelMixedWithVMData,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5209  			v->UrgentLatencyVMDataOnly,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5210  			v->DoUrgentLatencyAdjustment,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5211  			v->UrgentLatencyAdjustmentFabricClockComponent,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5212  			v->UrgentLatencyAdjustmentFabricClockReference,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5213  			v->FabricClock);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5214  	//Prefetch Check
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5215  	for (i = 0; i < v->soc.num_states; ++i) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5216  		for (j = 0; j <= 1; ++j) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5217  			double VMDataOnlyReturnBWPerState;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5218  			double HostVMInefficiencyFactor = 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5219  			int NextPrefetchModeState = MinPrefetchMode;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5220  			bool UnboundedRequestEnabledThisState = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5221  			int CompressedBufferSizeInkByteThisState = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5222  			double dummy;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5223  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5224  			v->TimeCalc = 24 / v->ProjectedDCFCLKDeepSleep[i][j];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5225  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5226  			v->BandwidthWithoutPrefetchSupported[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5227  			if (v->TotalVActivePixelBandwidth[i][j] + v->TotalVActiveCursorBandwidth[i][j] + v->TotalMetaRowBandwidth[i][j]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5228  					+ v->TotalDPTERowBandwidth[i][j] > v->ReturnBWPerState[i][j] || v->NotEnoughUrgentLatencyHidingA[i][j]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5229  				v->BandwidthWithoutPrefetchSupported[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5230  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5231  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5232  			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5233  				v->NoOfDPPThisState[k] = v->NoOfDPP[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5234  				v->swath_width_luma_ub_this_state[k] = v->swath_width_luma_ub_all_states[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5235  				v->swath_width_chroma_ub_this_state[k] = v->swath_width_chroma_ub_all_states[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5236  				v->SwathWidthYThisState[k] = v->SwathWidthYAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5237  				v->SwathWidthCThisState[k] = v->SwathWidthCAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5238  				v->SwathHeightYThisState[k] = v->SwathHeightYAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5239  				v->SwathHeightCThisState[k] = v->SwathHeightCAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5240  				v->DETBufferSizeYThisState[k] = v->DETBufferSizeYAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5241  				v->DETBufferSizeCThisState[k] = v->DETBufferSizeCAllStates[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5242  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5243  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5244  			VMDataOnlyReturnBWPerState = dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5245  					dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5246  							v->ReturnBusWidth * v->DCFCLKState[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5247  							v->FabricClockPerState[i] * v->FabricDatapathToDCNDataReturn)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5248  							* v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency / 100.0,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5249  					v->DRAMSpeedPerState[i] * v->NumberOfChannels * v->DRAMChannelWidth
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5250  							* v->PercentOfIdealDRAMBWReceivedAfterUrgLatencyVMDataOnly / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5251  			if (v->GPUVMEnable && v->HostVMEnable)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5252  				HostVMInefficiencyFactor = v->ReturnBWPerState[i][j] / VMDataOnlyReturnBWPerState;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5253  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5254  			v->ExtraLatency = CalculateExtraLatency(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5255  					v->RoundTripPingLatencyCycles,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5256  					ReorderingBytes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5257  					v->DCFCLKState[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5258  					v->TotalNumberOfActiveDPP[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5259  					v->PixelChunkSizeInKByte,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5260  					v->TotalNumberOfDCCActiveDPP[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5261  					v->MetaChunkSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5262  					v->ReturnBWPerState[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5263  					v->GPUVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5264  					v->HostVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5265  					v->NumberOfActivePlanes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5266  					v->NoOfDPPThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5267  					v->dpte_group_bytes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5268  					HostVMInefficiencyFactor,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5269  					v->HostVMMinPageSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5270  					v->HostVMMaxNonCachedPageTableLevels);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5271  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5272  			v->NextMaxVStartup = v->MaxMaxVStartup[i][j];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5273  			do {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5274  				v->PrefetchModePerState[i][j] = NextPrefetchModeState;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5275  				v->MaxVStartup = v->NextMaxVStartup;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5276  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5277  				v->TWait = CalculateTWait(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5278  						v->PrefetchModePerState[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5279  						v->DRAMClockChangeLatency,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5280  						v->UrgLatency[i],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5281  						v->SREnterPlusExitTime);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5282  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5283  				for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5284  					Pipe myPipe;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5285  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5286  					myPipe.DPPCLK = v->RequiredDPPCLK[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5287  					myPipe.DISPCLK = v->RequiredDISPCLK[i][j];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5288  					myPipe.PixelClock = v->PixelClock[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5289  					myPipe.DCFCLKDeepSleep = v->ProjectedDCFCLKDeepSleep[i][j];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5290  					myPipe.DPPPerPlane = v->NoOfDPP[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5291  					myPipe.ScalerEnabled = v->ScalerEnabled[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5292  					myPipe.SourceScan = v->SourceScan[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5293  					myPipe.BlockWidth256BytesY = v->Read256BlockWidthY[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5294  					myPipe.BlockHeight256BytesY = v->Read256BlockHeightY[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5295  					myPipe.BlockWidth256BytesC = v->Read256BlockWidthC[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5296  					myPipe.BlockHeight256BytesC = v->Read256BlockHeightC[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5297  					myPipe.InterlaceEnable = v->Interlace[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5298  					myPipe.NumberOfCursors = v->NumberOfCursors[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5299  					myPipe.VBlank = v->VTotal[k] - v->VActive[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5300  					myPipe.HTotal = v->HTotal[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5301  					myPipe.DCCEnable = v->DCCEnable[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5302  					myPipe.ODMCombineIsEnabled = v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_4to1
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5303  							|| v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_2to1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5304  					myPipe.SourcePixelFormat = v->SourcePixelFormat[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5305  					myPipe.BytePerPixelY = v->BytePerPixelY[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5306  					myPipe.BytePerPixelC = v->BytePerPixelC[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5307  					myPipe.ProgressiveToInterlaceUnitInOPP = v->ProgressiveToInterlaceUnitInOPP;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5308  					v->NoTimeForPrefetch[i][j][k] = CalculatePrefetchSchedule(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5309  							mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5310  							HostVMInefficiencyFactor,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5311  							&myPipe,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5312  							v->DSCDelayPerState[i][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5313  							v->DPPCLKDelaySubtotal + v->DPPCLKDelayCNVCFormater,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5314  							v->DPPCLKDelaySCL,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5315  							v->DPPCLKDelaySCLLBOnly,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5316  							v->DPPCLKDelayCNVCCursor,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5317  							v->DISPCLKDelaySubtotal,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5318  							v->SwathWidthYThisState[k] / v->HRatio[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5319  							v->OutputFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5320  							v->MaxInterDCNTileRepeaters,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5321  							dml_min(v->MaxVStartup, v->MaximumVStartup[i][j][k]),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5322  							v->MaximumVStartup[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5323  							v->GPUVMMaxPageTableLevels,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5324  							v->GPUVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5325  							v->HostVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5326  							v->HostVMMaxNonCachedPageTableLevels,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5327  							v->HostVMMinPageSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5328  							v->DynamicMetadataEnable[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5329  							v->DynamicMetadataVMEnabled,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5330  							v->DynamicMetadataLinesBeforeActiveRequired[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5331  							v->DynamicMetadataTransmittedBytes[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5332  							v->UrgLatency[i],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5333  							v->ExtraLatency,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5334  							v->TimeCalc,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5335  							v->PDEAndMetaPTEBytesPerFrame[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5336  							v->MetaRowBytes[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5337  							v->DPTEBytesPerRow[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5338  							v->PrefetchLinesY[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5339  							v->SwathWidthYThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5340  							v->PrefillY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5341  							v->MaxNumSwY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5342  							v->PrefetchLinesC[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5343  							v->SwathWidthCThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5344  							v->PrefillC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5345  							v->MaxNumSwC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5346  							v->swath_width_luma_ub_this_state[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5347  							v->swath_width_chroma_ub_this_state[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5348  							v->SwathHeightYThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5349  							v->SwathHeightCThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5350  							v->TWait,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5351  							&v->DSTXAfterScaler[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5352  							&v->DSTYAfterScaler[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5353  							&v->LineTimesForPrefetch[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5354  							&v->PrefetchBW[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5355  							&v->LinesForMetaPTE[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5356  							&v->LinesForMetaAndDPTERow[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5357  							&v->VRatioPreY[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5358  							&v->VRatioPreC[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5359  							&v->RequiredPrefetchPixelDataBWLuma[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5360  							&v->RequiredPrefetchPixelDataBWChroma[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5361  							&v->NoTimeForDynamicMetadata[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5362  							&v->Tno_bw[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5363  							&v->prefetch_vmrow_bw[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5364  							&v->dummy7[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5365  							&v->dummy8[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5366  							&v->dummy13[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5367  							&v->VUpdateOffsetPix[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5368  							&v->VUpdateWidthPix[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5369  							&v->VReadyOffsetPix[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5370  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5371  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5372  				for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5373  					CalculateUrgentBurstFactor(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5374  							v->swath_width_luma_ub_this_state[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5375  							v->swath_width_chroma_ub_this_state[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5376  							v->SwathHeightYThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5377  							v->SwathHeightCThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5378  							v->HTotal[k] / v->PixelClock[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5379  							v->UrgentLatency,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5380  							v->CursorBufferSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5381  							v->CursorWidth[k][0],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5382  							v->CursorBPP[k][0],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5383  							v->VRatioPreY[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5384  							v->VRatioPreC[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5385  							v->BytePerPixelInDETY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5386  							v->BytePerPixelInDETC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5387  							v->DETBufferSizeYThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5388  							v->DETBufferSizeCThisState[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5389  							&v->UrgentBurstFactorCursorPre[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5390  							&v->UrgentBurstFactorLumaPre[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5391  							&v->UrgentBurstFactorChroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5392  							&v->NotUrgentLatencyHidingPre[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5393  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5394  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5395  				v->MaximumReadBandwidthWithPrefetch = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5396  				for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5397  					v->cursor_bw_pre[k] = v->NumberOfCursors[k] * v->CursorWidth[k][0] * v->CursorBPP[k][0] / 8.0
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5398  							/ (v->HTotal[k] / v->PixelClock[k]) * v->VRatioPreY[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5399  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5400  					v->MaximumReadBandwidthWithPrefetch =
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5401  							v->MaximumReadBandwidthWithPrefetch
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5402  									+ dml_max4(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5403  											v->VActivePixelBandwidth[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5404  											v->VActiveCursorBandwidth[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5405  													+ v->NoOfDPP[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5406  															* (v->meta_row_bandwidth[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5407  																	+ v->dpte_row_bandwidth[i][j][k]),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5408  											v->NoOfDPP[i][j][k] * v->prefetch_vmrow_bw[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5409  											v->NoOfDPP[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5410  													* (v->RequiredPrefetchPixelDataBWLuma[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5411  															* v->UrgentBurstFactorLumaPre[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5412  															+ v->RequiredPrefetchPixelDataBWChroma[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5413  																	* v->UrgentBurstFactorChromaPre[k])
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5414  													+ v->cursor_bw_pre[k] * v->UrgentBurstFactorCursorPre[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5415  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5416  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5417  				v->NotEnoughUrgentLatencyHidingPre = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5418  				for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5419  					if (v->NotUrgentLatencyHidingPre[k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5420  						v->NotEnoughUrgentLatencyHidingPre = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5421  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5422  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5423  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5424  				v->PrefetchSupported[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5425  				if (v->BandwidthWithoutPrefetchSupported[i][j] == false || v->MaximumReadBandwidthWithPrefetch > v->ReturnBWPerState[i][j]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5426  						|| v->NotEnoughUrgentLatencyHidingPre == 1) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5427  					v->PrefetchSupported[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5428  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5429  				for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5430  					if (v->LineTimesForPrefetch[k] < 2.0 || v->LinesForMetaPTE[k] >= 32.0 || v->LinesForMetaAndDPTERow[k] >= 16.0
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5431  							|| v->NoTimeForPrefetch[i][j][k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5432  						v->PrefetchSupported[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5433  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5434  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5435  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5436  				v->DynamicMetadataSupported[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5437  				for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5438  					if (v->NoTimeForDynamicMetadata[i][j][k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5439  						v->DynamicMetadataSupported[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5440  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5441  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5442  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5443  				v->VRatioInPrefetchSupported[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5444  				for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5445  					if (v->VRatioPreY[i][j][k] > 4.0 || v->VRatioPreC[i][j][k] > 4.0 || v->NoTimeForPrefetch[i][j][k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5446  						v->VRatioInPrefetchSupported[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5447  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5448  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5449  				v->AnyLinesForVMOrRowTooLarge = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5450  				for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5451  					if (v->LinesForMetaAndDPTERow[k] >= 16 || v->LinesForMetaPTE[k] >= 32) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5452  						v->AnyLinesForVMOrRowTooLarge = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5453  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5454  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5455  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5456  				v->NextPrefetchMode = v->NextPrefetchMode + 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5457  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5458  				if (v->PrefetchSupported[i][j] == true && v->VRatioInPrefetchSupported[i][j] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5459  					v->BandwidthAvailableForImmediateFlip = v->ReturnBWPerState[i][j];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5460  					for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5461  						v->BandwidthAvailableForImmediateFlip = v->BandwidthAvailableForImmediateFlip
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5462  								- dml_max(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5463  										v->VActivePixelBandwidth[i][j][k] + v->VActiveCursorBandwidth[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5464  										v->NoOfDPP[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5465  												* (v->RequiredPrefetchPixelDataBWLuma[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5466  														* v->UrgentBurstFactorLumaPre[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5467  														+ v->RequiredPrefetchPixelDataBWChroma[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5468  																* v->UrgentBurstFactorChromaPre[k])
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5469  												+ v->cursor_bw_pre[k] * v->UrgentBurstFactorCursorPre[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5470  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5471  					v->TotImmediateFlipBytes = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5472  					for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5473  						v->TotImmediateFlipBytes = v->TotImmediateFlipBytes
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5474  								+ v->NoOfDPP[i][j][k] * v->PDEAndMetaPTEBytesPerFrame[i][j][k] + v->MetaRowBytes[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5475  								+ v->DPTEBytesPerRow[i][j][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5476  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5477  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5478  					for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5479  						CalculateFlipSchedule(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5480  								mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5481  								HostVMInefficiencyFactor,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5482  								v->ExtraLatency,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5483  								v->UrgLatency[i],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5484  								v->GPUVMMaxPageTableLevels,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5485  								v->HostVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5486  								v->HostVMMaxNonCachedPageTableLevels,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5487  								v->GPUVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5488  								v->HostVMMinPageSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5489  								v->PDEAndMetaPTEBytesPerFrame[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5490  								v->MetaRowBytes[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5491  								v->DPTEBytesPerRow[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5492  								v->BandwidthAvailableForImmediateFlip,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5493  								v->TotImmediateFlipBytes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5494  								v->SourcePixelFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5495  								v->HTotal[k] / v->PixelClock[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5496  								v->VRatio[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5497  								v->VRatioChroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5498  								v->Tno_bw[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5499  								v->DCCEnable[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5500  								v->dpte_row_height[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5501  								v->meta_row_height[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5502  								v->dpte_row_height_chroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5503  								v->meta_row_height_chroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5504  								&v->DestinationLinesToRequestVMInImmediateFlip[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5505  								&v->DestinationLinesToRequestRowInImmediateFlip[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5506  								&v->final_flip_bw[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5507  								&v->ImmediateFlipSupportedForPipe[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5508  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5509  					v->total_dcn_read_bw_with_flip = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5510  					for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5511  						v->total_dcn_read_bw_with_flip = v->total_dcn_read_bw_with_flip
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5512  								+ dml_max3(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5513  										v->NoOfDPP[i][j][k] * v->prefetch_vmrow_bw[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5514  										v->NoOfDPP[i][j][k] * v->final_flip_bw[k] + v->VActivePixelBandwidth[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5515  												+ v->VActiveCursorBandwidth[i][j][k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5516  										v->NoOfDPP[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5517  												* (v->final_flip_bw[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5518  														+ v->RequiredPrefetchPixelDataBWLuma[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5519  																* v->UrgentBurstFactorLumaPre[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5520  														+ v->RequiredPrefetchPixelDataBWChroma[i][j][k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5521  																* v->UrgentBurstFactorChromaPre[k])
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5522  												+ v->cursor_bw_pre[k] * v->UrgentBurstFactorCursorPre[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5523  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5524  					v->ImmediateFlipSupportedForState[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5525  					if (v->total_dcn_read_bw_with_flip > v->ReturnBWPerState[i][j]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5526  						v->ImmediateFlipSupportedForState[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5527  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5528  					for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5529  						if (v->ImmediateFlipSupportedForPipe[k] == false) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5530  							v->ImmediateFlipSupportedForState[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5531  						}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5532  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5533  				} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5534  					v->ImmediateFlipSupportedForState[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5535  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5536  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5537  				if (v->MaxVStartup <= __DML_VBA_MIN_VSTARTUP__ || v->AnyLinesForVMOrRowTooLarge == false) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5538  					v->NextMaxVStartup = v->MaxMaxVStartup[i][j];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5539  					NextPrefetchModeState = NextPrefetchModeState + 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5540  				} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5541  					v->NextMaxVStartup = v->NextMaxVStartup - 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5542  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5543  				v->NextPrefetchMode = v->NextPrefetchMode + 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5544  			} while (!((v->PrefetchSupported[i][j] == true && v->DynamicMetadataSupported[i][j] == true && v->VRatioInPrefetchSupported[i][j] == true
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5545  					&& ((v->HostVMEnable == false && v->ImmediateFlipRequirement != dm_immediate_flip_required)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5546  							|| v->ImmediateFlipSupportedForState[i][j] == true))
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5547  					|| (v->NextMaxVStartup == v->MaxMaxVStartup[i][j] && NextPrefetchModeState > MaxPrefetchMode)));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5548  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5549  			CalculateUnboundedRequestAndCompressedBufferSize(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5550  					v->DETBufferSizeInKByte[0],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5551  					v->ConfigReturnBufferSizeInKByte,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5552  					v->UseUnboundedRequesting,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5553  					v->TotalNumberOfActiveDPP[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5554  					NoChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5555  					v->MaxNumDPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5556  					v->CompressedBufferSegmentSizeInkByte,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5557  					v->Output,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5558  					&UnboundedRequestEnabledThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5559  					&CompressedBufferSizeInkByteThisState);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5560  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5561  			CalculateWatermarksAndDRAMSpeedChangeSupport(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5562  					mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5563  					v->PrefetchModePerState[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5564  					v->NumberOfActivePlanes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5565  					v->MaxLineBufferLines,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5566  					v->LineBufferSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5567  					v->WritebackInterfaceBufferSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5568  					v->DCFCLKState[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5569  					v->ReturnBWPerState[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5570  					v->SynchronizedVBlank,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5571  					v->dpte_group_bytes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5572  					v->MetaChunkSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5573  					v->UrgLatency[i],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5574  					v->ExtraLatency,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5575  					v->WritebackLatency,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5576  					v->WritebackChunkSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5577  					v->SOCCLKPerState[i],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5578  					v->DRAMClockChangeLatency,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5579  					v->SRExitTime,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5580  					v->SREnterPlusExitTime,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5581  					v->SRExitZ8Time,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5582  					v->SREnterPlusExitZ8Time,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5583  					v->ProjectedDCFCLKDeepSleep[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5584  					v->DETBufferSizeYThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5585  					v->DETBufferSizeCThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5586  					v->SwathHeightYThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5587  					v->SwathHeightCThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5588  					v->LBBitPerPixel,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5589  					v->SwathWidthYThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5590  					v->SwathWidthCThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5591  					v->HRatio,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5592  					v->HRatioChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5593  					v->vtaps,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5594  					v->VTAPsChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5595  					v->VRatio,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5596  					v->VRatioChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5597  					v->HTotal,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5598  					v->PixelClock,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5599  					v->BlendingAndTiming,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5600  					v->NoOfDPPThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5601  					v->BytePerPixelInDETY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5602  					v->BytePerPixelInDETC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5603  					v->DSTXAfterScaler,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5604  					v->DSTYAfterScaler,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5605  					v->WritebackEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5606  					v->WritebackPixelFormat,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5607  					v->WritebackDestinationWidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5608  					v->WritebackDestinationHeight,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5609  					v->WritebackSourceHeight,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5610  					UnboundedRequestEnabledThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5611  					CompressedBufferSizeInkByteThisState,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5612  					&v->DRAMClockChangeSupport[i][j],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5613  					&v->UrgentWatermark,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5614  					&v->WritebackUrgentWatermark,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5615  					&v->DRAMClockChangeWatermark,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5616  					&v->WritebackDRAMClockChangeWatermark,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5617  					&dummy,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5618  					&dummy,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5619  					&dummy,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5620  					&dummy,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5621  					&v->MinActiveDRAMClockChangeLatencySupported);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5622  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5623  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5624  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5625  	/*PTE Buffer Size Check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5626  	for (i = 0; i < v->soc.num_states; i++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5627  		for (j = 0; j < 2; j++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5628  			v->PTEBufferSizeNotExceeded[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5629  			for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5630  				if (v->PTEBufferSizeNotExceededY[i][j][k] == false || v->PTEBufferSizeNotExceededC[i][j][k] == false) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5631  					v->PTEBufferSizeNotExceeded[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5632  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5633  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5634  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5635  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5636  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5637  	/*Cursor Support Check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5638  	v->CursorSupport = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5639  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5640  		if (v->CursorWidth[k][0] > 0.0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5641  			if (v->CursorBPP[k][0] == 64 && v->Cursor64BppSupport == false) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5642  				v->CursorSupport = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5643  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5644  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5645  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5646  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5647  	/*Valid Pitch Check*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5648  	v->PitchSupport = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5649  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5650  		v->AlignedYPitch[k] = dml_ceil(dml_max(v->PitchY[k], v->SurfaceWidthY[k]), v->MacroTileWidthY[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5651  		if (v->DCCEnable[k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5652  			v->AlignedDCCMetaPitchY[k] = dml_ceil(dml_max(v->DCCMetaPitchY[k], v->SurfaceWidthY[k]), 64.0 * v->Read256BlockWidthY[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5653  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5654  			v->AlignedDCCMetaPitchY[k] = v->DCCMetaPitchY[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5655  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5656  		if (v->SourcePixelFormat[k] != dm_444_64 && v->SourcePixelFormat[k] != dm_444_32 && v->SourcePixelFormat[k] != dm_444_16
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5657  				&& v->SourcePixelFormat[k] != dm_mono_16 && v->SourcePixelFormat[k] != dm_rgbe
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5658  				&& v->SourcePixelFormat[k] != dm_mono_8) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5659  			v->AlignedCPitch[k] = dml_ceil(dml_max(v->PitchC[k], v->SurfaceWidthC[k]), v->MacroTileWidthC[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5660  			if (v->DCCEnable[k] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5661  				v->AlignedDCCMetaPitchC[k] = dml_ceil(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5662  						dml_max(v->DCCMetaPitchC[k], v->SurfaceWidthC[k]),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5663  						64.0 * v->Read256BlockWidthC[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5664  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5665  				v->AlignedDCCMetaPitchC[k] = v->DCCMetaPitchC[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5666  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5667  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5668  			v->AlignedCPitch[k] = v->PitchC[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5669  			v->AlignedDCCMetaPitchC[k] = v->DCCMetaPitchC[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5670  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5671  		if (v->AlignedYPitch[k] > v->PitchY[k] || v->AlignedCPitch[k] > v->PitchC[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5672  				|| v->AlignedDCCMetaPitchY[k] > v->DCCMetaPitchY[k] || v->AlignedDCCMetaPitchC[k] > v->DCCMetaPitchC[k]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5673  			v->PitchSupport = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5674  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5675  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5676  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5677  	for (k = 0; k < v->NumberOfActivePlanes; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5678  		if (v->ViewportWidth[k] > v->SurfaceWidthY[k] || v->ViewportHeight[k] > v->SurfaceHeightY[k]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5679  			ViewportExceedsSurface = true;
28a0a14423b855 Wan Jiabing         2021-06-09  5680  			if (v->SourcePixelFormat[k] != dm_444_64 && v->SourcePixelFormat[k] != dm_444_32
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5681  					&& v->SourcePixelFormat[k] != dm_444_16 && v->SourcePixelFormat[k] != dm_444_8
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5682  					&& v->SourcePixelFormat[k] != dm_rgbe) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5683  				if (v->ViewportWidthChroma[k] > v->SurfaceWidthC[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5684  						|| v->ViewportHeightChroma[k] > v->SurfaceHeightC[k]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5685  					ViewportExceedsSurface = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5686  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5687  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5688  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5689  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5690  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5691  	/*Mode Support, Voltage State and SOC Configuration*/
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5692  	for (i = v->soc.num_states - 1; i >= 0; i--) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5693  		for (j = 0; j < 2; j++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5694  			if (v->ScaleRatioAndTapsSupport == true && v->SourceFormatPixelAndScanSupport == true && v->ViewportSizeSupport[i][j] == true
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5695  					&& v->LinkCapacitySupport[i] == true && !P2IWith420 && !DSCOnlyIfNecessaryWithBPP
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5696  					&& !DSC422NativeNotSupported && v->ODMCombine4To1SupportCheckOK[i] == true && v->NotEnoughDSCUnits[i] == false
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5697  					&& v->DTBCLKRequiredMoreThanSupported[i] == false
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5698  					&& v->ROBSupport[i][j] == true && v->DISPCLK_DPPCLK_Support[i][j] == true
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5699  					&& v->TotalAvailablePipesSupport[i][j] == true && EnoughWritebackUnits == true
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5700  					&& v->WritebackLatencySupport == true && v->WritebackScaleRatioAndTapsSupport == true
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5701  					&& v->CursorSupport == true && v->PitchSupport == true && ViewportExceedsSurface == false
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5702  					&& v->PrefetchSupported[i][j] == true && v->DynamicMetadataSupported[i][j] == true
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5703  					&& v->TotalVerticalActiveBandwidthSupport[i][j] == true && v->VRatioInPrefetchSupported[i][j] == true
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5704  					&& v->PTEBufferSizeNotExceeded[i][j] == true && v->NonsupportedDSCInputBPC == false
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5705  					&& ((v->HostVMEnable == false && v->ImmediateFlipRequirement != dm_immediate_flip_required)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5706  							|| v->ImmediateFlipSupportedForState[i][j] == true)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5707  					&& FMTBufferExceeded == false) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5708  				v->ModeSupport[i][j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5709  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5710  				v->ModeSupport[i][j] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5711  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5712  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5713  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5714  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5715  	{
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5716  		unsigned int MaximumMPCCombine = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5717  		for (i = v->soc.num_states; i >= 0; i--) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5718  			if (i == v->soc.num_states || v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5719  				v->VoltageLevel = i;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5720  				v->ModeIsSupported = v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5721  				if (v->ModeSupport[i][0] == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5722  					MaximumMPCCombine = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5723  				} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5724  					MaximumMPCCombine = 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5725  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5726  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5727  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5728  		v->ImmediateFlipSupport = v->ImmediateFlipSupportedForState[v->VoltageLevel][MaximumMPCCombine];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5729  		for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5730  			v->MPCCombineEnable[k] = v->MPCCombine[v->VoltageLevel][MaximumMPCCombine][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5731  			v->DPPPerPlane[k] = v->NoOfDPP[v->VoltageLevel][MaximumMPCCombine][k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5732  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5733  		v->DCFCLK = v->DCFCLKState[v->VoltageLevel][MaximumMPCCombine];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5734  		v->DRAMSpeed = v->DRAMSpeedPerState[v->VoltageLevel];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5735  		v->FabricClock = v->FabricClockPerState[v->VoltageLevel];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5736  		v->SOCCLK = v->SOCCLKPerState[v->VoltageLevel];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5737  		v->ReturnBW = v->ReturnBWPerState[v->VoltageLevel][MaximumMPCCombine];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5738  		v->maxMpcComb = MaximumMPCCombine;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5739  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5740  }
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  5741  

:::::: The code at line 3957 was first introduced by commit
:::::: 74458c081fcfb0423877e630de2746daefdb16e4 drm/amd/display: Add DCN3.1 DML calculation support

:::::: TO: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

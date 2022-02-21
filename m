Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5055E4BD473
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 05:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbiBUDzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 22:55:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiBUDzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 22:55:31 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8384751E5E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 19:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645415707; x=1676951707;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BuWchOjFDc1+IKvlJHfhZN7vIAOMQ/w7DiUcMnOe6M0=;
  b=erjPjZQwBsPu3SEhzlrV9cKxMyJNnFXxBG4O/qypsefd9LSMkthy2+R8
   QKUOD2yFUXO7dVLevj8Gf9FYhRHhs+dCChNfBwCrUKNZTLRGvYgO8V3ee
   osU4ZvHX1BwYHxMO+ThfE8C6Pq/kjOAeDPx1PEP9fQ8w2OUU9TMXQalPm
   6nOWuSFu1CguMQHn7ChFmn3Hx7qwN0TXWWobapVmhDefOHg4rm2FlsBmJ
   OPax280aglhl2sYVPHWWpb6ixtOsVoEwIROw2KHKZmWBYXb4w3uHSQVkB
   hT8BK/kBDfBasvIcWivBwwMxusGiLMJ+cYxGKvFoEo6zCAvQk/g/lZZ5Y
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="312172619"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="312172619"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 19:55:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="507486914"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Feb 2022 19:55:05 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLzmz-0001Hw-6w; Mon, 21 Feb 2022 03:55:05 +0000
Date:   Mon, 21 Feb 2022 11:54:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qingqing Zhuo <qingqing.zhuo@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [agd5f:drm-next 100/114]
 drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn315/dcn315_smu.c:126:5:
 warning: no previous prototype for 'dcn315_smu_send_msg_with_param'
Message-ID: <202202211133.HYWcMRIV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   ad72a74cfe7edab15aef40519727a388285e7510
commit: f9490399614050a47472ff127c67830cb4e311f4 [100/114] drm/amd/display: Add DCN315 CLK_MGR
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220221/202202211133.HYWcMRIV-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout f9490399614050a47472ff127c67830cb4e311f4
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn315/dcn315_smu.c:126:5: warning: no previous prototype for 'dcn315_smu_send_msg_with_param' [-Wmissing-prototypes]
     126 | int dcn315_smu_send_msg_with_param(
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn315/dcn315_smu.c:184:5: warning: no previous prototype for 'dcn315_smu_set_voltage_via_phyclk' [-Wmissing-prototypes]
     184 | int dcn315_smu_set_voltage_via_phyclk(struct clk_mgr_internal *clk_mgr, int requested_phyclk_khz)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn315/dcn315_smu.c:26:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
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
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c:42:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h: In function 'dmub_rb_flush_pending':
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2921:12: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
    2921 |   uint64_t temp;
         |            ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c: At top level:
>> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c:436:6: warning: no previous prototype for 'dcn315_clk_mgr_helper_populate_bw_params' [-Wmissing-prototypes]
     436 | void dcn315_clk_mgr_helper_populate_bw_params(
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/resource.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/hw/clk_mgr_internal.h:36,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c:29:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:124:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     124 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     123 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/dcn315_smu_send_msg_with_param +126 drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn315/dcn315_smu.c

   125	
 > 126	int dcn315_smu_send_msg_with_param(
   127			struct clk_mgr_internal *clk_mgr,
   128			unsigned int msg_id, unsigned int param)
   129	{
   130		uint32_t result;
   131	
   132		result = dcn315_smu_wait_for_response(clk_mgr, 10, 200000);
   133		ASSERT(result == VBIOSSMC_Result_OK);
   134	
   135		if (result == VBIOSSMC_Status_BUSY) {
   136			return -1;
   137		}
   138	
   139		/* First clear response register */
   140		REG_WRITE(MP1_SMN_C2PMSG_38, VBIOSSMC_Status_BUSY);
   141	
   142		/* Set the parameter register for the SMU message, unit is Mhz */
   143		REG_WRITE(MP1_SMN_C2PMSG_37, param);
   144	
   145		/* Trigger the message transaction by writing the message ID */
   146		generic_write_indirect_reg(CTX,
   147			REG_NBIO(RSMU_INDEX), REG_NBIO(RSMU_DATA),
   148			mmMP1_C2PMSG_3, msg_id);
   149	
   150		result = dcn315_smu_wait_for_response(clk_mgr, 10, 200000);
   151	
   152		if (result == VBIOSSMC_Status_BUSY) {
   153			ASSERT(0);
   154			dm_helpers_smu_timeout(CTX, msg_id, param, 10 * 200000);
   155		}
   156	
   157		return REG_READ(MP1_SMN_C2PMSG_37);
   158	}
   159	
   160	int dcn315_smu_get_smu_version(struct clk_mgr_internal *clk_mgr)
   161	{
   162		return dcn315_smu_send_msg_with_param(
   163				clk_mgr,
   164				VBIOSSMC_MSG_GetPmfwVersion,
   165				0);
   166	}
   167	
   168	
   169	int dcn315_smu_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_dispclk_khz)
   170	{
   171		int actual_dispclk_set_mhz = -1;
   172	
   173		if (!clk_mgr->smu_present)
   174			return requested_dispclk_khz;
   175	
   176		/*  Unit of SMU msg parameter is Mhz */
   177		actual_dispclk_set_mhz = dcn315_smu_send_msg_with_param(
   178				clk_mgr,
   179				VBIOSSMC_MSG_SetDispclkFreq,
   180				khz_to_mhz_ceil(requested_dispclk_khz));
   181	
   182		return actual_dispclk_set_mhz * 1000;
   183	}
 > 184	int dcn315_smu_set_voltage_via_phyclk(struct clk_mgr_internal *clk_mgr, int requested_phyclk_khz)
   185	{
   186		int actual_phypclk_set_mhz = -1;
   187	
   188		if (!clk_mgr->smu_present && requested_phyclk_khz)
   189			return requested_phyclk_khz;
   190	
   191		/*  Unit of SMU msg parameter is Mhz */
   192		actual_phypclk_set_mhz = dcn315_smu_send_msg_with_param(
   193				clk_mgr,
   194				VBIOSSMC_MSG_SetPhyclkVoltageByFreq,
   195				khz_to_mhz_ceil(requested_phyclk_khz));
   196	
   197		return actual_phypclk_set_mhz * 1000;
   198	}
   199	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

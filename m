Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C274BD3A2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245734AbiBUCNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:13:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241988AbiBUCN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:13:27 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354BA31227
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 18:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645409585; x=1676945585;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jdAQJaYkl0lLht+N0EhCcQXAek3BwhAmG1ZJX9BZMnk=;
  b=S5271XELDEmr3wcslf7nJGRaTTP5Et7f3XSPQVwYjdkMwWWdFMbtDsrZ
   qf7aWVVWmmEJiaJJ3OEDIIz/e0ypdR328oBagdtHRUpUK9w85mg/WSYDa
   fI7e9rlhQrsQJ4uPMVbux9Tde0YCXcTLexA9d8BSgnBs9bmhW4M2sY2zj
   U2B3KUMKUzTQAplkp1czf6gK2Kce94TPauDw7DdVJ60dlP1fmUKGHEyqx
   40PfvWWZoSH9OZtzmXO62WRwXGzAidEaGmMiFmHzTYTSCdMRfbTcyz0wx
   IfcwZrVM8tMGYfDXYN0WOfxje+PiOAojmgUTJxjcs5qSYcuRVqMlJsEBk
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="249001191"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="249001191"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 18:13:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="507465664"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Feb 2022 18:13:02 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLyCE-0001Ba-7W; Mon, 21 Feb 2022 02:13:02 +0000
Date:   Mon, 21 Feb 2022 10:12:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hansen Dsouza <Hansen.Dsouza@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Charlene Liu <Charlene.Liu@amd.com>,
        Leo Li <sunpeng.li@amd.com>
Subject: [agd5f:drm-next-5.18 65/86]
 drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn316/dcn316_smu.c:114:5:
 warning: no previous prototype for 'dcn316_smu_send_msg_with_param'
Message-ID: <202202211018.P5xaC86f-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next-5.18
head:   b63c54d978236dd6014cf2ffba96d626e97c915c
commit: c477eaa6a79da6af7e59f74e69af7d6b3af52a23 [65/86] drm/amd/display: Add DCN316 resource and SMU clock manager
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220221/202202211018.P5xaC86f-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next-5.18
        git checkout c477eaa6a79da6af7e59f74e69af7d6b3af52a23
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn316/dcn316_smu.c:114:5: warning: no previous prototype for 'dcn316_smu_send_msg_with_param' [-Wmissing-prototypes]
     114 | int dcn316_smu_send_msg_with_param(
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn316/dcn316_smu.c:171:5: warning: no previous prototype for 'dcn316_smu_set_voltage_via_phyclk' [-Wmissing-prototypes]
     171 | int dcn316_smu_set_voltage_via_phyclk(struct clk_mgr_internal *clk_mgr, int requested_phyclk_khz)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn316/dcn316_smu.c:26:
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
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c:41:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h: In function 'dmub_rb_flush_pending':
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2921:12: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
    2921 |   uint64_t temp;
         |            ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c: At top level:
>> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c:488:6: warning: no previous prototype for 'dcn316_clk_mgr_helper_populate_bw_params' [-Wmissing-prototypes]
     488 | void dcn316_clk_mgr_helper_populate_bw_params(
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/resource.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/hw/clk_mgr_internal.h:36,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c:29:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:124:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     124 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     123 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/dcn316_smu_send_msg_with_param +114 drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn316/dcn316_smu.c

   113	
 > 114	int dcn316_smu_send_msg_with_param(
   115			struct clk_mgr_internal *clk_mgr,
   116			unsigned int msg_id, unsigned int param)
   117	{
   118		uint32_t result;
   119	
   120		result = dcn316_smu_wait_for_response(clk_mgr, 10, 200000);
   121		ASSERT(result == VBIOSSMC_Result_OK);
   122	
   123		if (result == VBIOSSMC_Status_BUSY) {
   124			return -1;
   125		}
   126	
   127		/* First clear response register */
   128		REG_WRITE(MP1_SMN_C2PMSG_91, VBIOSSMC_Status_BUSY);
   129	
   130		/* Set the parameter register for the SMU message, unit is Mhz */
   131		REG_WRITE(MP1_SMN_C2PMSG_83, param);
   132	
   133		/* Trigger the message transaction by writing the message ID */
   134		REG_WRITE(MP1_SMN_C2PMSG_67, msg_id);
   135	
   136		result = dcn316_smu_wait_for_response(clk_mgr, 10, 200000);
   137	
   138		if (result == VBIOSSMC_Status_BUSY) {
   139			ASSERT(0);
   140			dm_helpers_smu_timeout(CTX, msg_id, param, 10 * 200000);
   141		}
   142	
   143		return REG_READ(MP1_SMN_C2PMSG_83);
   144	}
   145	
   146	int dcn316_smu_get_smu_version(struct clk_mgr_internal *clk_mgr)
   147	{
   148		return dcn316_smu_send_msg_with_param(
   149				clk_mgr,
   150				VBIOSSMC_MSG_GetPmfwVersion,
   151				0);
   152	}
   153	
   154	
   155	int dcn316_smu_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_dispclk_khz)
   156	{
   157		int actual_dispclk_set_mhz = -1;
   158	
   159		if (!clk_mgr->smu_present)
   160			return requested_dispclk_khz;
   161	
   162		/*  Unit of SMU msg parameter is Mhz */
   163		actual_dispclk_set_mhz = dcn316_smu_send_msg_with_param(
   164				clk_mgr,
   165				VBIOSSMC_MSG_SetDispclkFreq,
   166				khz_to_mhz_ceil(requested_dispclk_khz));
   167	
   168		return actual_dispclk_set_mhz * 1000;
   169	}
   170	
 > 171	int dcn316_smu_set_voltage_via_phyclk(struct clk_mgr_internal *clk_mgr, int requested_phyclk_khz)
   172	{
   173		int actual_phypclk_set_mhz = -1;
   174	
   175		if (!clk_mgr->smu_present && requested_phyclk_khz)
   176			return requested_phyclk_khz;
   177	
   178		/*  Unit of SMU msg parameter is Mhz */
   179		actual_phypclk_set_mhz = dcn316_smu_send_msg_with_param(
   180				clk_mgr,
   181				VBIOSSMC_MSG_SetPhyclkVoltageByFreq,
   182				khz_to_mhz_ceil(requested_phyclk_khz));
   183	
   184		return actual_phypclk_set_mhz * 1000;
   185	}
   186	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

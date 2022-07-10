Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B6756CCA2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 06:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiGJEP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 00:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGJEP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 00:15:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71A213CD5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 21:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657426554; x=1688962554;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Oa8vB2Etwte8KuUE6ABPYYI3bKwfsLM+B7UpvhuaSYE=;
  b=GSJp21d0jaQZWMWJ4nKR2JAdXmC/yj0NBm95SA+eTScv41mmOlFAY+EV
   5f572FZ/UnWBRnpgDOQK8vPlhBGjxeaU+T52NvGiD0QQVyI0sCGCk4B+r
   WDmcY5JbOvOvCfGyRikgd5q2G3p+IUlZa1FmQMyWLzIgqljpYlYfoW6QG
   t1K9Jv72vjg2nbqkuVtHbI1MFaWiapap1F70m4koMxsISe5FcCPW0OPyW
   LXfiZxCIvPersiCPdTfUtZDizOYWQT3LAKU8eML1XwG+4y5NvxsLYpTO2
   6+xC3rvHinVrj4/JrtoCk1n7JENDtJjfgj2GeBhtlCMMap+ms8JKme7Uh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="370790569"
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="370790569"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 21:15:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="594518531"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Jul 2022 21:15:52 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAOMJ-000PSk-CB;
        Sun, 10 Jul 2022 04:15:51 +0000
Date:   Sun, 10 Jul 2022 12:15:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alvin Lee <Alvin.Lee2@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Jun Lei <Jun.Lei@amd.com>
Subject: [agd5f:drm-next 341/419]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:549:6: warning: no
 previous prototype for 'dc_dmub_setup_subvp_dmub_command'
Message-ID: <202207101258.OBsIdqAD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   e35cc9020f7b4540f5fbbff9fbe08808aab9addc
commit: 85f4bc0c333ceed24cbc9f69a2a77fab1ae3d4d1 [341/419] drm/amd/display: Add SubVP required code
config: microblaze-randconfig-r004-20220710 (https://download.01.org/0day-ci/archive/20220710/202207101258.OBsIdqAD-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 85f4bc0c333ceed24cbc9f69a2a77fab1ae3d4d1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: the agd5f/drm-next HEAD e35cc9020f7b4540f5fbbff9fbe08808aab9addc builds fine.
      It only hurts bisectability.

All error/warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:549:6: warning: no previous prototype for 'dc_dmub_setup_subvp_dmub_command' [-Wmissing-prototypes]
     549 | void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:31:
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
   microblaze-linux-ld: drivers/gpu/drm/amd/display/dc/dc_dmub_srv.o: in function `populate_subvp_cmd_pipe_info':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:517: undefined reference to `__floatunsidf'
>> microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:516: undefined reference to `__floatunsidf'
>> microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:516: undefined reference to `__divdf3'
>> microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:516: undefined reference to `__floatunsidf'
>> microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:516: undefined reference to `__muldf3'
>> microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:517: undefined reference to `__adddf3'
>> microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:517: undefined reference to `__subdf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:517: undefined reference to `__divdf3'
>> microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:515: undefined reference to `__fixunsdfsi'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:521: undefined reference to `__floatunsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:520: undefined reference to `__floatunsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:520: undefined reference to `__divdf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:520: undefined reference to `__floatunsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:520: undefined reference to `__muldf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:521: undefined reference to `__adddf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:521: undefined reference to `__subdf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:521: undefined reference to `__divdf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:519: undefined reference to `__fixunsdfsi'
   microblaze-linux-ld: drivers/gpu/drm/amd/display/dc/dc_dmub_srv.o: in function `update_subvp_prefetch_end_to_mall_start':
   drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:446: undefined reference to `__floatunsidf'
>> microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:446: undefined reference to `__floatsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:445: undefined reference to `__floatunsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:445: undefined reference to `__divdf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:446: undefined reference to `__muldf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:446: undefined reference to `__adddf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:445: undefined reference to `__fixunsdfsi'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:448: undefined reference to `__floatunsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:447: undefined reference to `__floatunsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:447: undefined reference to `__divdf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:448: undefined reference to `__muldf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:448: undefined reference to `__adddf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:447: undefined reference to `__fixunsdfsi'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:457: undefined reference to `__floatunsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:456: undefined reference to `__floatunsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:456: undefined reference to `__divdf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:456: undefined reference to `__muldf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:457: undefined reference to `__adddf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:457: undefined reference to `__subdf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:457: undefined reference to `__divdf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:455: undefined reference to `__fixunsdfsi'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:464: undefined reference to `__floatunsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:463: undefined reference to `__floatunsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:463: undefined reference to `__divdf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:463: undefined reference to `__muldf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:464: undefined reference to `__adddf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:464: undefined reference to `__subdf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:464: undefined reference to `__divdf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:462: undefined reference to `__fixunsdfsi'
   microblaze-linux-ld: drivers/gpu/drm/amd/display/dc/dc_dmub_srv.o: in function `populate_subvp_cmd_drr_info':
   drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:332: undefined reference to `__floatunsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:335: undefined reference to `__floatunsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:334: undefined reference to `__floatunsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:334: undefined reference to `__divdf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:335: undefined reference to `__muldf3'
>> microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:334: undefined reference to `__fixdfsi'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:338: undefined reference to `__floatunsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:340: undefined reference to `__floatunsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:340: undefined reference to `__divdf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:341: undefined reference to `__muldf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:341: undefined reference to `__floatsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:341: undefined reference to `__adddf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:340: undefined reference to `__fixdfsi'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:343: undefined reference to `__floatunsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:344: undefined reference to `__floatunsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:343: undefined reference to `__divdf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:344: undefined reference to `__muldf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:343: undefined reference to `__fixdfsi'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:345: undefined reference to `__floatunsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:345: undefined reference to `__divdf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:346: undefined reference to `__muldf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:345: undefined reference to `__fixdfsi'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:331: undefined reference to `__floatunsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:331: undefined reference to `__divdf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:332: undefined reference to `__muldf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:331: undefined reference to `__fixdfsi'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:337: undefined reference to `__floatsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:337: undefined reference to `__divdf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:337: undefined reference to `__muldf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:337: undefined reference to `__divdf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:337: undefined reference to `__fixdfsi'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:347: undefined reference to `__floatsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:347: undefined reference to `__muldf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:347: undefined reference to `__floatsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:347: undefined reference to `__adddf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:347: undefined reference to `__fixdfsi'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:350: undefined reference to `__floatsidf'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:350: undefined reference to `__divdf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:350: undefined reference to `__muldf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:350: undefined reference to `__divdf3'
   microblaze-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:350: undefined reference to `__fixdfsi'


vim +/dc_dmub_setup_subvp_dmub_command +549 drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c

   414	
   415	/**
   416	 * ***********************************************************************************************
   417	 * update_subvp_prefetch_end_to_mall_start: Helper for SubVP + SubVP case
   418	 *
   419	 * For SubVP + SubVP, we use a single vertical interrupt to start the microschedule for both
   420	 * SubVP pipes. In order for this to work correctly, the MALL REGION of both SubVP pipes must
   421	 * start at the same time. This function lengthens the prefetch end to mall start delay of the
   422	 * SubVP pipe that has the shorter prefetch so that both MALL REGION's will start at the same time.
   423	 *
   424	 * @param [in] dc: current dc state
   425	 * @param [in] context: new dc state
   426	 * @param [in] cmd: DMUB cmd to be populated with SubVP info
   427	 * @param [in] subvp_pipes: Array of SubVP pipes (should always be length 2)
   428	 *
   429	 * @return: void
   430	 *
   431	 * ***********************************************************************************************
   432	 */
   433	static void update_subvp_prefetch_end_to_mall_start(struct dc *dc,
   434			struct dc_state *context,
   435			union dmub_rb_cmd *cmd,
   436			struct pipe_ctx *subvp_pipes[])
   437	{
   438		uint32_t subvp0_prefetch_us = 0;
   439		uint32_t subvp1_prefetch_us = 0;
   440		uint32_t prefetch_delta_us = 0;
   441		struct dc_crtc_timing *phantom_timing0 = &subvp_pipes[0]->stream->mall_stream_config.paired_stream->timing;
   442		struct dc_crtc_timing *phantom_timing1 = &subvp_pipes[1]->stream->mall_stream_config.paired_stream->timing;
   443		struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2 *pipe_data = NULL;
   444	
   445		subvp0_prefetch_us = (phantom_timing0->v_total - phantom_timing0->v_front_porch) * phantom_timing0->h_total /
 > 446					(double)(phantom_timing0->pix_clk_100hz * 100) * 1000000 + dc->caps.subvp_prefetch_end_to_mall_start_us;
   447		subvp1_prefetch_us = (phantom_timing1->v_total - phantom_timing1->v_front_porch) * phantom_timing1->h_total /
   448						(double)(phantom_timing1->pix_clk_100hz * 100) * 1000000 + dc->caps.subvp_prefetch_end_to_mall_start_us;
   449	
   450		// Whichever SubVP PIPE has the smaller prefetch (including the prefetch end to mall start time)
   451		// should increase it's prefetch time to match the other
   452		if (subvp0_prefetch_us > subvp1_prefetch_us) {
   453			pipe_data = &cmd->fw_assisted_mclk_switch_v2.config_data.pipe_data[1];
   454			prefetch_delta_us = subvp0_prefetch_us - subvp1_prefetch_us;
   455			pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
   456						(((double)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us) / 1000000) *
   457						(phantom_timing1->pix_clk_100hz * 100) + phantom_timing1->h_total - 1) /
   458						(double)phantom_timing1->h_total;
   459		} else if (subvp1_prefetch_us >  subvp0_prefetch_us) {
   460			pipe_data = &cmd->fw_assisted_mclk_switch_v2.config_data.pipe_data[0];
   461			prefetch_delta_us = subvp1_prefetch_us - subvp0_prefetch_us;
   462			pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
   463						(((double)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us) / 1000000) *
   464						(phantom_timing0->pix_clk_100hz * 100) + phantom_timing0->h_total - 1) /
   465						(double)phantom_timing0->h_total;
   466		}
   467	}
   468	
   469	/**
   470	 * ***************************************************************************************
   471	 * setup_subvp_dmub_command: Helper to populate the SubVP pipe info for the DMUB subvp command
   472	 *
   473	 * Populate the DMCUB SubVP command with SubVP pipe info. All the information required to
   474	 * calculate the microschedule for the SubVP pipe is stored in the pipe_data of the DMCUB
   475	 * SubVP command.
   476	 *
   477	 * @param [in] dc: current dc state
   478	 * @param [in] context: new dc state
   479	 * @param [in] cmd: DMUB cmd to be populated with SubVP info
   480	 * @param [in] subvp_pipe: pipe_ctx for the SubVP pipe
   481	 * @param [in] cmd_pipe_index: index for the pipe array in DMCUB SubVP cmd
   482	 *
   483	 * @return: void
   484	 *
   485	 * ***************************************************************************************
   486	 */
   487	static void populate_subvp_cmd_pipe_info(struct dc *dc,
   488			struct dc_state *context,
   489			union dmub_rb_cmd *cmd,
   490			struct pipe_ctx *subvp_pipe,
   491			uint8_t cmd_pipe_index)
   492	{
   493		uint32_t j;
   494		struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2 *pipe_data =
   495				&cmd->fw_assisted_mclk_switch_v2.config_data.pipe_data[cmd_pipe_index];
   496		struct dc_crtc_timing *main_timing = &subvp_pipe->stream->timing;
   497		struct dc_crtc_timing *phantom_timing = &subvp_pipe->stream->mall_stream_config.paired_stream->timing;
   498	
   499		pipe_data->mode = SUBVP;
   500		pipe_data->pipe_config.subvp_data.pix_clk_100hz = subvp_pipe->stream->timing.pix_clk_100hz;
   501		pipe_data->pipe_config.subvp_data.htotal = subvp_pipe->stream->timing.h_total;
   502		pipe_data->pipe_config.subvp_data.vtotal = subvp_pipe->stream->timing.v_total;
   503		pipe_data->pipe_config.subvp_data.main_vblank_start =
   504				main_timing->v_total - main_timing->v_front_porch;
   505		pipe_data->pipe_config.subvp_data.main_vblank_end =
   506				main_timing->v_total - main_timing->v_front_porch - main_timing->v_addressable;
   507		pipe_data->pipe_config.subvp_data.mall_region_lines = phantom_timing->v_addressable;
   508		pipe_data->pipe_config.subvp_data.main_pipe_index = subvp_pipe->pipe_idx;
   509	
   510		// Prefetch lines is equal to VACTIVE + BP + VSYNC
   511		pipe_data->pipe_config.subvp_data.prefetch_lines =
   512				phantom_timing->v_total - phantom_timing->v_front_porch;
   513	
   514		// Round up
 > 515		pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
 > 516				(((double)dc->caps.subvp_prefetch_end_to_mall_start_us / 1000000) *
 > 517				(phantom_timing->pix_clk_100hz * 100) + phantom_timing->h_total - 1) /
   518				(double)phantom_timing->h_total;
   519		pipe_data->pipe_config.subvp_data.processing_delay_lines =
   520				(((double)dc->caps.subvp_fw_processing_delay_us / 1000000) *
   521				(phantom_timing->pix_clk_100hz * 100) + phantom_timing->h_total - 1) /
   522				(double)phantom_timing->h_total;
   523		// Find phantom pipe index based on phantom stream
   524		for (j = 0; j < dc->res_pool->pipe_count; j++) {
   525			struct pipe_ctx *phantom_pipe = &context->res_ctx.pipe_ctx[j];
   526	
   527			if (phantom_pipe->stream == subvp_pipe->stream->mall_stream_config.paired_stream) {
   528				pipe_data->pipe_config.subvp_data.phantom_pipe_index = phantom_pipe->pipe_idx;
   529				break;
   530			}
   531		}
   532	}
   533	
   534	/**
   535	 * ***************************************************************************************
   536	 * dc_dmub_setup_subvp_dmub_command: Populate the DMCUB SubVP command
   537	 *
   538	 * This function loops through each pipe and populates the DMUB
   539	 * SubVP CMD info based on the pipe (e.g. SubVP, VBLANK).
   540	 *
   541	 * @param [in] dc: current dc state
   542	 * @param [in] context: new dc state
   543	 * @param [in] cmd: DMUB cmd to be populated with SubVP info
   544	 *
   545	 * @return: void
   546	 *
   547	 * ***************************************************************************************
   548	 */
 > 549	void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
   550			struct dc_state *context,
   551			bool enable)
   552	{
   553		uint8_t cmd_pipe_index = 0;
   554		uint32_t i, pipe_idx;
   555		uint8_t subvp_count = 0;
   556		union dmub_rb_cmd cmd;
   557		struct pipe_ctx *subvp_pipes[2];
   558		uint32_t wm_val_refclk = 0;
   559	
   560		memset(&cmd, 0, sizeof(cmd));
   561		// FW command for SUBVP
   562		cmd.fw_assisted_mclk_switch_v2.header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
   563		cmd.fw_assisted_mclk_switch_v2.header.sub_type = DMUB_CMD__HANDLE_SUBVP_CMD;
   564		cmd.fw_assisted_mclk_switch_v2.header.payload_bytes =
   565				sizeof(cmd.fw_assisted_mclk_switch_v2) - sizeof(cmd.fw_assisted_mclk_switch_v2.header);
   566	
   567		for (i = 0; i < dc->res_pool->pipe_count; i++) {
   568			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
   569	
   570			if (!pipe->stream)
   571				continue;
   572	
   573			if (pipe->plane_state && !pipe->top_pipe &&
   574					pipe->stream->mall_stream_config.type == SUBVP_MAIN)
   575				subvp_pipes[subvp_count++] = pipe;
   576		}
   577	
   578		if (enable) {
   579			// For each pipe that is a "main" SUBVP pipe, fill in pipe data for DMUB SUBVP cmd
   580			for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
   581				struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
   582	
   583				if (!pipe->stream)
   584					continue;
   585	
   586				if (pipe->plane_state && pipe->stream->mall_stream_config.paired_stream &&
   587						pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
   588					populate_subvp_cmd_pipe_info(dc, context, &cmd, pipe, cmd_pipe_index++);
   589				} else if (pipe->plane_state && pipe->stream->mall_stream_config.type == SUBVP_NONE) {
   590					// Don't need to check for ActiveDRAMClockChangeMargin < 0, not valid in cases where
   591					// we run through DML without calculating "natural" P-state support
   592					populate_subvp_cmd_vblank_pipe_info(dc, context, &cmd, pipe, cmd_pipe_index++);
   593	
   594				}
   595				pipe_idx++;
   596			}
   597			if (subvp_count == 2) {
   598				update_subvp_prefetch_end_to_mall_start(dc, context, &cmd, subvp_pipes);
   599			}
   600			cmd.fw_assisted_mclk_switch_v2.config_data.pstate_allow_width_us = dc->caps.subvp_pstate_allow_width_us;
   601			cmd.fw_assisted_mclk_switch_v2.config_data.vertical_int_margin_us = dc->caps.subvp_vertical_int_margin_us;
   602	
   603			// Store the original watermark value for this SubVP config so we can lower it when the
   604			// MCLK switch starts
   605			wm_val_refclk = context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns *
   606					dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000 / 1000;
   607	
   608			cmd.fw_assisted_mclk_switch_v2.config_data.watermark_a_cache = wm_val_refclk < 0xFFFF ? wm_val_refclk : 0xFFFF;
   609		}
   610		dc_dmub_srv_cmd_queue(dc->ctx->dmub_srv, &cmd);
   611		dc_dmub_srv_cmd_execute(dc->ctx->dmub_srv);
   612		dc_dmub_srv_wait_idle(dc->ctx->dmub_srv);
   613	}
   614	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

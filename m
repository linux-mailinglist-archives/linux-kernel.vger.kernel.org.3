Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DE14AB2C9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 00:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347379AbiBFXCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 18:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239597AbiBFXCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 18:02:51 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16701C061348
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 15:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644188570; x=1675724570;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CFTenF8ljg+fwYpM5U7HsnvBDP/el1aekAIVzXMGqbY=;
  b=Au0/79xft8YHEe2cSsYLMhNp4o9TJ8GhCxqpi7c0vsnF9vvgK26MUFZr
   3ISIU0FHOKds9mC6M9rVS6XNem0dTjUyFfX9/KA7P+gsM3dRlgd/TYUpw
   /OoDp8aNyr/5FJ4RyafQrxN7pMrVUC2vKZG3Q4htByKWu1jzsOucEvbjz
   TmkNpww05FcDoFrgAeGigIHqgdp3CFiJvCGOGXpeqwGGVBRIas4WLkjKG
   J52r4YgTedpTERO2YdlhXCjRlhjzVJrQBLt3qjyafGpNBftZxU/783mhP
   OYca9HfHB+NATMxWbYBDdmbbaiBj+ieOO3bh1IW5GzoFQaKD9FtZRPsJS
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="248376373"
X-IronPort-AV: E=Sophos;i="5.88,348,1635231600"; 
   d="scan'208";a="248376373"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 15:02:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,348,1635231600"; 
   d="scan'208";a="524927978"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 Feb 2022 15:02:48 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGqYR-000apQ-Ba; Sun, 06 Feb 2022 23:02:47 +0000
Date:   Mon, 7 Feb 2022 07:01:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn301/dcn301_fpu.c:304:1:
 warning: the frame size of 1096 bytes is larger than 1024 bytes
Message-ID: <202202070626.PbnOctY3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qingqing,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dfd42facf1e4ada021b939b4e19c935dcdd55566
commit: 31484207feb23e6cdb12827560442ab294855923 drm/amd/display: move FPU associated DCN301 code to DML folder
date:   3 months ago
config: i386-randconfig-r012-20220207 (https://download.01.org/0day-ci/archive/20220207/202202070626.PbnOctY3-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=31484207feb23e6cdb12827560442ab294855923
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 31484207feb23e6cdb12827560442ab294855923
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn301/dcn301_fpu.c: In function 'dcn301_update_bw_bounding_box':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn301/dcn301_fpu.c:304:1: warning: the frame size of 1096 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     304 | }
         | ^


vim +304 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn301/dcn301_fpu.c

   247	
   248	void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
   249	{
   250		struct dcn301_resource_pool *pool = TO_DCN301_RES_POOL(dc->res_pool);
   251		struct clk_limit_table *clk_table = &bw_params->clk_table;
   252		struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
   253		unsigned int i, closest_clk_lvl;
   254		int j;
   255	
   256		dc_assert_fp_enabled();
   257	
   258		/* Default clock levels are used for diags, which may lead to overclocking. */
   259		if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
   260			dcn3_01_ip.max_num_otg = pool->base.res_cap->num_timing_generator;
   261			dcn3_01_ip.max_num_dpp = pool->base.pipe_count;
   262			dcn3_01_soc.num_chans = bw_params->num_channels;
   263	
   264			ASSERT(clk_table->num_entries);
   265			for (i = 0; i < clk_table->num_entries; i++) {
   266				/* loop backwards*/
   267				for (closest_clk_lvl = 0, j = dcn3_01_soc.num_states - 1; j >= 0; j--) {
   268					if ((unsigned int) dcn3_01_soc.clock_limits[j].dcfclk_mhz <= clk_table->entries[i].dcfclk_mhz) {
   269						closest_clk_lvl = j;
   270						break;
   271					}
   272				}
   273	
   274				clock_limits[i].state = i;
   275				clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
   276				clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
   277				clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
   278				clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
   279	
   280				clock_limits[i].dispclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
   281				clock_limits[i].dppclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
   282				clock_limits[i].dram_bw_per_chan_gbps = dcn3_01_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
   283				clock_limits[i].dscclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
   284				clock_limits[i].dtbclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
   285				clock_limits[i].phyclk_d18_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
   286				clock_limits[i].phyclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
   287			}
   288	
   289			for (i = 0; i < clk_table->num_entries; i++)
   290				dcn3_01_soc.clock_limits[i] = clock_limits[i];
   291	
   292			if (clk_table->num_entries) {
   293				dcn3_01_soc.num_states = clk_table->num_entries;
   294				/* duplicate last level */
   295				dcn3_01_soc.clock_limits[dcn3_01_soc.num_states] = dcn3_01_soc.clock_limits[dcn3_01_soc.num_states - 1];
   296				dcn3_01_soc.clock_limits[dcn3_01_soc.num_states].state = dcn3_01_soc.num_states;
   297			}
   298		}
   299	
   300		dcn3_01_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
   301		dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
   302	
   303		dml_init_instance(&dc->dml, &dcn3_01_soc, &dcn3_01_ip, DML_PROJECT_DCN30);
 > 304	}
   305	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

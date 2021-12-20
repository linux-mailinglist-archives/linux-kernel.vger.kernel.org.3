Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEE247A311
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 01:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbhLTARu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 19:17:50 -0500
Received: from mga03.intel.com ([134.134.136.65]:9596 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231496AbhLTARt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 19:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639959469; x=1671495469;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B4612cnzwqqoxNHP5GCepLC22DEtW7I78S9cbryf0z8=;
  b=DUb/aZ3H/BQ+q180NANqd9CvzjsQbRlI1qLmrLMU29EO3oRjQDeUAFSm
   7avJP+8J0XxjbMfofYB2+zfPaCZHFyAREQ06JjzEstLDPZZVaPnkE3DIN
   Km5OuDXoEYGA6km4fw817pZ8T0S05oY8Q/PlWepQ5wh2bGsCqIXH6C47q
   XaxH0Vgbcp8iG3NpQkqWvEsGNtMPw3rJlQZiHryW/fuPGb5eLMlaJ89zF
   KOmHq+H4yrj60GK0ImkszABh2mPIN3xRVvPUB2XkQCrlIWv0kCH8C46GA
   LobCgwTwy4crvTlIeoV+ESjS9Nzt6M4RVKr2zi8yYdWrBdMhRosQd+pBy
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="240021572"
X-IronPort-AV: E=Sophos;i="5.88,219,1635231600"; 
   d="scan'208";a="240021572"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2021 16:17:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,219,1635231600"; 
   d="scan'208";a="507482261"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 19 Dec 2021 16:17:47 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mz6N8-0007NN-Mm; Mon, 20 Dec 2021 00:17:46 +0000
Date:   Mon, 20 Dec 2021 08:17:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c:640
 dcn31_clk_mgr_construct() warn: inconsistent indenting
Message-ID: <202112200801.HcZHxY7X-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f291e2d899d120880bfe8e0fa6fe22a97a54e054
commit: 8fe44c080a53ac0ccbe88053a2e40f9acca33091 drm/amdgpu/display: fold DRM_AMD_DC_DCN3_1 into DRM_AMD_DC_DCN
date:   6 months ago
config: x86_64-randconfig-m001-20211207 (https://download.01.org/0day-ci/archive/20211220/202112200801.HcZHxY7X-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c:640 dcn31_clk_mgr_construct() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:533 get_meta_and_pte_attr() warn: right shifting more than type allows 32 vs 4294966273
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:709 get_meta_and_pte_attr() warn: add some parenthesis here?
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:709 get_meta_and_pte_attr() warn: maybe use && instead of &
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:1204 dml_rq_dlg_get_dlg_params() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hwseq.c:132 dcn31_init_hw() warn: variable dereferenced before check 'res_pool->dccg' (see line 79)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hwseq.c:293 dcn31_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 75)
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:1398 CalculatePrefetchSchedule() warn: inconsistent indenting

Old smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:549 get_meta_and_pte_attr() warn: right shifting more than type allows 32 vs 4294966273

vim +640 drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c

118a331516581c Nicholas Kazlauskas 2021-05-19  575  
118a331516581c Nicholas Kazlauskas 2021-05-19  576  void dcn31_clk_mgr_construct(
118a331516581c Nicholas Kazlauskas 2021-05-19  577  		struct dc_context *ctx,
118a331516581c Nicholas Kazlauskas 2021-05-19  578  		struct clk_mgr_dcn31 *clk_mgr,
118a331516581c Nicholas Kazlauskas 2021-05-19  579  		struct pp_smu_funcs *pp_smu,
118a331516581c Nicholas Kazlauskas 2021-05-19  580  		struct dccg *dccg)
118a331516581c Nicholas Kazlauskas 2021-05-19  581  {
118a331516581c Nicholas Kazlauskas 2021-05-19  582  	struct dcn31_smu_dpm_clks smu_dpm_clks = { 0 };
118a331516581c Nicholas Kazlauskas 2021-05-19  583  
118a331516581c Nicholas Kazlauskas 2021-05-19  584  	clk_mgr->base.base.ctx = ctx;
118a331516581c Nicholas Kazlauskas 2021-05-19  585  	clk_mgr->base.base.funcs = &dcn31_funcs;
118a331516581c Nicholas Kazlauskas 2021-05-19  586  
118a331516581c Nicholas Kazlauskas 2021-05-19  587  	clk_mgr->base.pp_smu = pp_smu;
118a331516581c Nicholas Kazlauskas 2021-05-19  588  
118a331516581c Nicholas Kazlauskas 2021-05-19  589  	clk_mgr->base.dccg = dccg;
118a331516581c Nicholas Kazlauskas 2021-05-19  590  	clk_mgr->base.dfs_bypass_disp_clk = 0;
118a331516581c Nicholas Kazlauskas 2021-05-19  591  
118a331516581c Nicholas Kazlauskas 2021-05-19  592  	clk_mgr->base.dprefclk_ss_percentage = 0;
118a331516581c Nicholas Kazlauskas 2021-05-19  593  	clk_mgr->base.dprefclk_ss_divider = 1000;
118a331516581c Nicholas Kazlauskas 2021-05-19  594  	clk_mgr->base.ss_on_dprefclk = false;
118a331516581c Nicholas Kazlauskas 2021-05-19  595  
118a331516581c Nicholas Kazlauskas 2021-05-19  596  	clk_mgr->smu_wm_set.wm_set = (struct dcn31_watermarks *)dm_helpers_allocate_gpu_mem(
118a331516581c Nicholas Kazlauskas 2021-05-19  597  				clk_mgr->base.base.ctx,
118a331516581c Nicholas Kazlauskas 2021-05-19  598  				DC_MEM_ALLOC_TYPE_FRAME_BUFFER,
118a331516581c Nicholas Kazlauskas 2021-05-19  599  				sizeof(struct dcn31_watermarks),
118a331516581c Nicholas Kazlauskas 2021-05-19  600  				&clk_mgr->smu_wm_set.mc_address.quad_part);
118a331516581c Nicholas Kazlauskas 2021-05-19  601  
118a331516581c Nicholas Kazlauskas 2021-05-19  602  	if (clk_mgr->smu_wm_set.wm_set == 0) {
118a331516581c Nicholas Kazlauskas 2021-05-19  603  		clk_mgr->smu_wm_set.wm_set = &dummy_wms;
118a331516581c Nicholas Kazlauskas 2021-05-19  604  		clk_mgr->smu_wm_set.mc_address.quad_part = 0;
118a331516581c Nicholas Kazlauskas 2021-05-19  605  	}
118a331516581c Nicholas Kazlauskas 2021-05-19  606  	ASSERT(clk_mgr->smu_wm_set.wm_set);
118a331516581c Nicholas Kazlauskas 2021-05-19  607  
118a331516581c Nicholas Kazlauskas 2021-05-19  608  	smu_dpm_clks.dpm_clks = (DpmClocks_t *)dm_helpers_allocate_gpu_mem(
118a331516581c Nicholas Kazlauskas 2021-05-19  609  				clk_mgr->base.base.ctx,
118a331516581c Nicholas Kazlauskas 2021-05-19  610  				DC_MEM_ALLOC_TYPE_FRAME_BUFFER,
118a331516581c Nicholas Kazlauskas 2021-05-19  611  				sizeof(DpmClocks_t),
118a331516581c Nicholas Kazlauskas 2021-05-19  612  				&smu_dpm_clks.mc_address.quad_part);
118a331516581c Nicholas Kazlauskas 2021-05-19  613  
118a331516581c Nicholas Kazlauskas 2021-05-19  614  	if (smu_dpm_clks.dpm_clks == NULL) {
118a331516581c Nicholas Kazlauskas 2021-05-19  615  		smu_dpm_clks.dpm_clks = &dummy_clocks;
118a331516581c Nicholas Kazlauskas 2021-05-19  616  		smu_dpm_clks.mc_address.quad_part = 0;
118a331516581c Nicholas Kazlauskas 2021-05-19  617  	}
118a331516581c Nicholas Kazlauskas 2021-05-19  618  
118a331516581c Nicholas Kazlauskas 2021-05-19  619  	ASSERT(smu_dpm_clks.dpm_clks);
118a331516581c Nicholas Kazlauskas 2021-05-19  620  
118a331516581c Nicholas Kazlauskas 2021-05-19  621  	if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment)) {
118a331516581c Nicholas Kazlauskas 2021-05-19  622  		clk_mgr->base.base.funcs = &dcn3_fpga_funcs;
118a331516581c Nicholas Kazlauskas 2021-05-19  623  	} else {
118a331516581c Nicholas Kazlauskas 2021-05-19  624  		struct clk_log_info log_info = {0};
118a331516581c Nicholas Kazlauskas 2021-05-19  625  
118a331516581c Nicholas Kazlauskas 2021-05-19  626  		clk_mgr->base.smu_ver = dcn31_smu_get_smu_version(&clk_mgr->base);
118a331516581c Nicholas Kazlauskas 2021-05-19  627  
118a331516581c Nicholas Kazlauskas 2021-05-19  628  		if (clk_mgr->base.smu_ver)
118a331516581c Nicholas Kazlauskas 2021-05-19  629  			clk_mgr->base.smu_present = true;
118a331516581c Nicholas Kazlauskas 2021-05-19  630  
118a331516581c Nicholas Kazlauskas 2021-05-19  631  		/* TODO: Check we get what we expect during bringup */
118a331516581c Nicholas Kazlauskas 2021-05-19  632  		clk_mgr->base.base.dentist_vco_freq_khz = get_vco_frequency_from_reg(&clk_mgr->base);
118a331516581c Nicholas Kazlauskas 2021-05-19  633  
118a331516581c Nicholas Kazlauskas 2021-05-19  634  		if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType) {
118a331516581c Nicholas Kazlauskas 2021-05-19  635  			dcn31_bw_params.wm_table = lpddr5_wm_table;
118a331516581c Nicholas Kazlauskas 2021-05-19  636  		} else {
118a331516581c Nicholas Kazlauskas 2021-05-19  637  			dcn31_bw_params.wm_table = ddr4_wm_table;
118a331516581c Nicholas Kazlauskas 2021-05-19  638  		}
118a331516581c Nicholas Kazlauskas 2021-05-19  639  		/* Saved clocks configured at boot for debug purposes */
118a331516581c Nicholas Kazlauskas 2021-05-19 @640  		 dcn31_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, &clk_mgr->base.base, &log_info);
118a331516581c Nicholas Kazlauskas 2021-05-19  641  
118a331516581c Nicholas Kazlauskas 2021-05-19  642  	}
118a331516581c Nicholas Kazlauskas 2021-05-19  643  
118a331516581c Nicholas Kazlauskas 2021-05-19  644  	clk_mgr->base.base.dprefclk_khz = 600000;
118a331516581c Nicholas Kazlauskas 2021-05-19  645  	clk_mgr->base.dccg->ref_dtbclk_khz = 600000;
118a331516581c Nicholas Kazlauskas 2021-05-19  646  	dce_clock_read_ss_info(&clk_mgr->base);
118a331516581c Nicholas Kazlauskas 2021-05-19  647  
118a331516581c Nicholas Kazlauskas 2021-05-19  648  	clk_mgr->base.base.bw_params = &dcn31_bw_params;
118a331516581c Nicholas Kazlauskas 2021-05-19  649  
118a331516581c Nicholas Kazlauskas 2021-05-19  650  	if (clk_mgr->base.base.ctx->dc->debug.pstate_enabled) {
118a331516581c Nicholas Kazlauskas 2021-05-19  651  		dcn31_get_dpm_table_from_smu(&clk_mgr->base, &smu_dpm_clks);
118a331516581c Nicholas Kazlauskas 2021-05-19  652  
118a331516581c Nicholas Kazlauskas 2021-05-19  653  		if (ctx->dc_bios && ctx->dc_bios->integrated_info) {
118a331516581c Nicholas Kazlauskas 2021-05-19  654  			dcn31_clk_mgr_helper_populate_bw_params(
118a331516581c Nicholas Kazlauskas 2021-05-19  655  					&clk_mgr->base,
118a331516581c Nicholas Kazlauskas 2021-05-19  656  					ctx->dc_bios->integrated_info,
118a331516581c Nicholas Kazlauskas 2021-05-19  657  					smu_dpm_clks.dpm_clks);
118a331516581c Nicholas Kazlauskas 2021-05-19  658  		}
118a331516581c Nicholas Kazlauskas 2021-05-19  659  	}
118a331516581c Nicholas Kazlauskas 2021-05-19  660  
118a331516581c Nicholas Kazlauskas 2021-05-19  661  	if (smu_dpm_clks.dpm_clks && smu_dpm_clks.mc_address.quad_part != 0)
118a331516581c Nicholas Kazlauskas 2021-05-19  662  		dm_helpers_free_gpu_mem(clk_mgr->base.base.ctx, DC_MEM_ALLOC_TYPE_FRAME_BUFFER,
118a331516581c Nicholas Kazlauskas 2021-05-19  663  				smu_dpm_clks.dpm_clks);
118a331516581c Nicholas Kazlauskas 2021-05-19  664  }
118a331516581c Nicholas Kazlauskas 2021-05-19  665  

:::::: The code at line 640 was first introduced by commit
:::::: 118a331516581c3acf1279857b0f663a54b7f31b drm/amd/display: Add DCN3.1 clock manager support

:::::: TO: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

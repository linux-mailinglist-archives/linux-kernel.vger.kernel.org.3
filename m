Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EF8549EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350940AbiFMUPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351017AbiFMUP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:15:27 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C67A466
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 11:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655146260; x=1686682260;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=btZ2DDWADYFitiE6G71jQJhV6+EnDLrzhpPSIBe+Om0=;
  b=fCovo/r9QlcBllhoUzO2plZXONSJMFBqdPfcEkHMoLuYGYmXpNKjQOxb
   INBhA6vzcUWoXEFYJJjJkbBvhQPQEJg25Xg5+qEUneaYc9pLBpr9Lz54O
   CSlTjH6wQfOSZZFHgFslgKTgtc9G9qlWpPnL9Cu8rqcZMhox3ggNLIisM
   C/mrpuA+N5plZRSG1AQ1Kfe/RViJhG0nfcheBzd0rjlEII8EnItu2DfLA
   mDClyw5C7RGv4RmTGEIHRwIl9k+GcKCYYz93+fAmwiqIEUvQtpjdk10XG
   cyZ8cnl2P+CTddY0XXo3+3fiGf3wh+pX3ItzmcIzkz3X+10nfe+jHCS5d
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258208413"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="258208413"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 11:50:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="829940878"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jun 2022 11:50:57 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0p9N-000L3t-6m;
        Mon, 13 Jun 2022 18:50:57 +0000
Date:   Tue, 14 Jun 2022 02:50:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:939:13:
 warning: stack frame size (1212) exceeds limit (1024) in
 'dml_rq_dlg_get_dlg_params'
Message-ID: <202206140206.M2jSzh1h-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
commit: 8fe44c080a53ac0ccbe88053a2e40f9acca33091 drm/amdgpu/display: fold DRM_AMD_DC_DCN3_1 into DRM_AMD_DC_DCN
date:   12 months ago
config: i386-buildonly-randconfig-r002-20220613 (https://download.01.org/0day-ci/archive/20220614/202206140206.M2jSzh1h-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d378268ead93c85803c270277f0243737b536ae7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8fe44c080a53ac0ccbe88053a2e40f9acca33091
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8fe44c080a53ac0ccbe88053a2e40f9acca33091
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:1007:15: warning: variable 'dispclk_delay_subtotal' set but not used [-Wunused-but-set-variable]
           unsigned int dispclk_delay_subtotal;
                        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:1006:15: warning: variable 'dppclk_delay_subtotal' set but not used [-Wunused-but-set-variable]
           unsigned int dppclk_delay_subtotal;
                        ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:939:13: warning: stack frame size (1212) exceeds limit (1024) in 'dml_rq_dlg_get_dlg_params' [-Wframe-larger-than]
   static void dml_rq_dlg_get_dlg_params(
               ^
   3 warnings generated.


vim +/dml_rq_dlg_get_dlg_params +939 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c

74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   936  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   937  // Note: currently taken in as is.
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   938  // Nice to decouple code from hw register implement and extract code that are repeated for luma and chroma.
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  @939  static void dml_rq_dlg_get_dlg_params(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   940  		struct display_mode_lib *mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   941  		const display_e2e_pipe_params_st *e2e_pipe_param,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   942  		const unsigned int num_pipes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   943  		const unsigned int pipe_idx,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   944  		display_dlg_regs_st *disp_dlg_regs,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   945  		display_ttu_regs_st *disp_ttu_regs,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   946  		const display_rq_dlg_params_st rq_dlg_param,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   947  		const display_dlg_sys_params_st dlg_sys_param,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   948  		const bool cstate_en,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   949  		const bool pstate_en,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   950  		const bool vm_en,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   951  		const bool ignore_viewport_pos,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   952  		const bool immediate_flip_support)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   953  {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   954  	const display_pipe_source_params_st *src = &e2e_pipe_param[pipe_idx].pipe.src;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   955  	const display_pipe_dest_params_st *dst = &e2e_pipe_param[pipe_idx].pipe.dest;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   956  	const display_output_params_st *dout = &e2e_pipe_param[pipe_idx].dout;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   957  	const display_clocks_and_cfg_st *clks = &e2e_pipe_param[pipe_idx].clks_cfg;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   958  	const scaler_ratio_depth_st *scl = &e2e_pipe_param[pipe_idx].pipe.scale_ratio_depth;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   959  	const scaler_taps_st *taps = &e2e_pipe_param[pipe_idx].pipe.scale_taps;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   960  	unsigned int pipe_index_in_combine[DC__NUM_PIPES__MAX];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   961  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   962  	// -------------------------
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   963  	// Section 1.15.2.1: OTG dependent Params
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   964  	// -------------------------
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   965  	// Timing
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   966  	unsigned int htotal = dst->htotal;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   967  	unsigned int hblank_end = dst->hblank_end;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   968  	unsigned int vblank_start = dst->vblank_start;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   969  	unsigned int vblank_end = dst->vblank_end;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   970  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   971  	double dppclk_freq_in_mhz = clks->dppclk_mhz;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   972  	double refclk_freq_in_mhz = clks->refclk_mhz;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   973  	double pclk_freq_in_mhz = dst->pixel_rate_mhz;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   974  	bool interlaced = dst->interlaced;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   975  	double ref_freq_to_pix_freq = refclk_freq_in_mhz / pclk_freq_in_mhz;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   976  	double min_ttu_vblank;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   977  	unsigned int dlg_vblank_start;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   978  	bool dual_plane;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   979  	bool mode_422;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   980  	unsigned int access_dir;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   981  	unsigned int vp_height_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   982  	unsigned int vp_width_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   983  	unsigned int vp_height_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   984  	unsigned int vp_width_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   985  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   986  	// Scaling
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   987  	unsigned int htaps_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   988  	unsigned int htaps_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   989  	double hratio_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   990  	double hratio_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   991  	double vratio_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   992  	double vratio_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   993  	bool scl_enable;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   994  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   995  	unsigned int swath_width_ub_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   996  	unsigned int dpte_groups_per_row_ub_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   997  	unsigned int swath_width_ub_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   998  	unsigned int dpte_groups_per_row_ub_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19   999  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1000  	unsigned int meta_chunks_per_row_ub_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1001  	unsigned int meta_chunks_per_row_ub_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1002  	unsigned int vupdate_offset;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1003  	unsigned int vupdate_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1004  	unsigned int vready_offset;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1005  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1006  	unsigned int dppclk_delay_subtotal;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1007  	unsigned int dispclk_delay_subtotal;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1008  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1009  	unsigned int vstartup_start;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1010  	unsigned int dst_x_after_scaler;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1011  	unsigned int dst_y_after_scaler;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1012  	double dst_y_prefetch;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1013  	double dst_y_per_vm_vblank;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1014  	double dst_y_per_row_vblank;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1015  	double dst_y_per_vm_flip;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1016  	double dst_y_per_row_flip;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1017  	double max_dst_y_per_vm_vblank;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1018  	double max_dst_y_per_row_vblank;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1019  	double vratio_pre_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1020  	double vratio_pre_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1021  	unsigned int req_per_swath_ub_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1022  	unsigned int req_per_swath_ub_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1023  	unsigned int meta_row_height_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1024  	unsigned int meta_row_height_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1025  	unsigned int swath_width_pixels_ub_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1026  	unsigned int swath_width_pixels_ub_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1027  	unsigned int scaler_rec_in_width_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1028  	unsigned int scaler_rec_in_width_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1029  	unsigned int dpte_row_height_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1030  	unsigned int dpte_row_height_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1031  	double hscale_pixel_rate_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1032  	double hscale_pixel_rate_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1033  	double min_hratio_fact_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1034  	double min_hratio_fact_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1035  	double refcyc_per_line_delivery_pre_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1036  	double refcyc_per_line_delivery_pre_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1037  	double refcyc_per_line_delivery_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1038  	double refcyc_per_line_delivery_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1039  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1040  	double refcyc_per_req_delivery_pre_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1041  	double refcyc_per_req_delivery_pre_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1042  	double refcyc_per_req_delivery_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1043  	double refcyc_per_req_delivery_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1044  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1045  	unsigned int full_recout_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1046  	double refcyc_per_req_delivery_pre_cur0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1047  	double refcyc_per_req_delivery_cur0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1048  	double refcyc_per_req_delivery_pre_cur1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1049  	double refcyc_per_req_delivery_cur1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1050  	int unsigned vba__min_dst_y_next_start = get_min_dst_y_next_start(mode_lib, e2e_pipe_param, num_pipes, pipe_idx); // FROM VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1051  	int unsigned vba__vready_after_vcount0 = get_vready_at_or_after_vsync(mode_lib, e2e_pipe_param, num_pipes, pipe_idx); // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1052  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1053  	float vba__refcyc_per_line_delivery_pre_l = get_refcyc_per_line_delivery_pre_l_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz; // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1054  	float vba__refcyc_per_line_delivery_l = get_refcyc_per_line_delivery_l_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz; // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1055  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1056  	float vba__refcyc_per_req_delivery_pre_l = get_refcyc_per_req_delivery_pre_l_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;  // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1057  	float vba__refcyc_per_req_delivery_l = get_refcyc_per_req_delivery_l_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;  // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1058  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1059  	memset(disp_dlg_regs, 0, sizeof(*disp_dlg_regs));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1060  	memset(disp_ttu_regs, 0, sizeof(*disp_ttu_regs));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1061  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1062  	dml_print("DML_DLG: %s: cstate_en = %d\n", __func__, cstate_en);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1063  	dml_print("DML_DLG: %s: pstate_en = %d\n", __func__, pstate_en);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1064  	dml_print("DML_DLG: %s: vm_en     = %d\n", __func__, vm_en);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1065  	dml_print("DML_DLG: %s: ignore_viewport_pos  = %d\n", __func__, ignore_viewport_pos);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1066  	dml_print("DML_DLG: %s: immediate_flip_support  = %d\n", __func__, immediate_flip_support);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1067  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1068  	dml_print("DML_DLG: %s: dppclk_freq_in_mhz     = %3.2f\n", __func__, dppclk_freq_in_mhz);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1069  	dml_print("DML_DLG: %s: refclk_freq_in_mhz     = %3.2f\n", __func__, refclk_freq_in_mhz);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1070  	dml_print("DML_DLG: %s: pclk_freq_in_mhz       = %3.2f\n", __func__, pclk_freq_in_mhz);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1071  	dml_print("DML_DLG: %s: interlaced             = %d\n", __func__, interlaced); ASSERT(ref_freq_to_pix_freq < 4.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1072  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1073  	disp_dlg_regs->ref_freq_to_pix_freq = (unsigned int) (ref_freq_to_pix_freq * dml_pow(2, 19));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1074  	disp_dlg_regs->refcyc_per_htotal = (unsigned int) (ref_freq_to_pix_freq * (double) htotal * dml_pow(2, 8));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1075  	disp_dlg_regs->dlg_vblank_end = interlaced ? (vblank_end / 2) : vblank_end;	// 15 bits
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1076  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1077  	//set_prefetch_mode(mode_lib, cstate_en, pstate_en, ignore_viewport_pos, immediate_flip_support);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1078  	min_ttu_vblank = get_min_ttu_vblank_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);	// From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1079  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1080  	dlg_vblank_start = interlaced ? (vblank_start / 2) : vblank_start;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1081  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1082  	disp_dlg_regs->min_dst_y_next_start = (unsigned int) (((double) dlg_vblank_start) * dml_pow(2, 2));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1083  	ASSERT(disp_dlg_regs->min_dst_y_next_start < (unsigned int)dml_pow(2, 18));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1084  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1085  	dml_print("DML_DLG: %s: min_ttu_vblank (us)         = %3.2f\n", __func__, min_ttu_vblank);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1086  	dml_print("DML_DLG: %s: min_dst_y_next_start        = 0x%0x\n", __func__, disp_dlg_regs->min_dst_y_next_start);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1087  	dml_print("DML_DLG: %s: dlg_vblank_start            = 0x%0x\n", __func__, dlg_vblank_start);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1088  	dml_print("DML_DLG: %s: ref_freq_to_pix_freq        = %3.2f\n", __func__, ref_freq_to_pix_freq);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1089  	dml_print("DML_DLG: %s: vba__min_dst_y_next_start   = 0x%0x\n", __func__, vba__min_dst_y_next_start);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1090  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1091  	//old_impl_vs_vba_impl("min_dst_y_next_start", dlg_vblank_start, vba__min_dst_y_next_start);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1092  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1093  	// -------------------------
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1094  	// Section 1.15.2.2: Prefetch, Active and TTU
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1095  	// -------------------------
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1096  	// Prefetch Calc
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1097  	// Source
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1098  	dual_plane = is_dual_plane((enum source_format_class) (src->source_format));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1099  	mode_422 = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1100  	access_dir = (src->source_scan == dm_vert);	// vp access direction: horizontal or vertical accessed
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1101  	vp_height_l = src->viewport_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1102  	vp_width_l = src->viewport_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1103  	vp_height_c = src->viewport_height_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1104  	vp_width_c = src->viewport_width_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1105  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1106  	// Scaling
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1107  	htaps_l = taps->htaps;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1108  	htaps_c = taps->htaps_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1109  	hratio_l = scl->hscl_ratio;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1110  	hratio_c = scl->hscl_ratio_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1111  	vratio_l = scl->vscl_ratio;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1112  	vratio_c = scl->vscl_ratio_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1113  	scl_enable = scl->scl_enable;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1114  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1115  	swath_width_ub_l = rq_dlg_param.rq_l.swath_width_ub;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1116  	dpte_groups_per_row_ub_l = rq_dlg_param.rq_l.dpte_groups_per_row_ub;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1117  	swath_width_ub_c = rq_dlg_param.rq_c.swath_width_ub;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1118  	dpte_groups_per_row_ub_c = rq_dlg_param.rq_c.dpte_groups_per_row_ub;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1119  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1120  	meta_chunks_per_row_ub_l = rq_dlg_param.rq_l.meta_chunks_per_row_ub;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1121  	meta_chunks_per_row_ub_c = rq_dlg_param.rq_c.meta_chunks_per_row_ub;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1122  	vupdate_offset = dst->vupdate_offset;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1123  	vupdate_width = dst->vupdate_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1124  	vready_offset = dst->vready_offset;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1125  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1126  	dppclk_delay_subtotal = mode_lib->ip.dppclk_delay_subtotal;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1127  	dispclk_delay_subtotal = mode_lib->ip.dispclk_delay_subtotal;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1128  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1129  	if (scl_enable)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1130  		dppclk_delay_subtotal += mode_lib->ip.dppclk_delay_scl;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1131  	else
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1132  		dppclk_delay_subtotal += mode_lib->ip.dppclk_delay_scl_lb_only;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1133  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1134  	dppclk_delay_subtotal += mode_lib->ip.dppclk_delay_cnvc_formatter + src->num_cursors * mode_lib->ip.dppclk_delay_cnvc_cursor;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1135  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1136  	if (dout->dsc_enable) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1137  		double dsc_delay = get_dsc_delay(mode_lib, e2e_pipe_param, num_pipes, pipe_idx); // FROM VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1138  		dispclk_delay_subtotal += dsc_delay;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1139  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1140  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1141  	vstartup_start = dst->vstartup_start;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1142  	if (interlaced) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1143  		if (vstartup_start / 2.0 - (double) (vready_offset + vupdate_width + vupdate_offset) / htotal <= vblank_end / 2.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1144  			disp_dlg_regs->vready_after_vcount0 = 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1145  		else
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1146  			disp_dlg_regs->vready_after_vcount0 = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1147  	} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1148  		if (vstartup_start - (double) (vready_offset + vupdate_width + vupdate_offset) / htotal <= vblank_end)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1149  			disp_dlg_regs->vready_after_vcount0 = 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1150  		else
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1151  			disp_dlg_regs->vready_after_vcount0 = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1152  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1153  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1154  	dml_print("DML_DLG: %s: vready_after_vcount0 = %d\n", __func__, disp_dlg_regs->vready_after_vcount0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1155  	dml_print("DML_DLG: %s: vba__vready_after_vcount0 = %d\n", __func__, vba__vready_after_vcount0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1156  	//old_impl_vs_vba_impl("vready_after_vcount0", disp_dlg_regs->vready_after_vcount0, vba__vready_after_vcount0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1157  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1158  	if (interlaced)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1159  		vstartup_start = vstartup_start / 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1160  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1161  	dst_x_after_scaler = get_dst_x_after_scaler(mode_lib, e2e_pipe_param, num_pipes, pipe_idx); // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1162  	dst_y_after_scaler = get_dst_y_after_scaler(mode_lib, e2e_pipe_param, num_pipes, pipe_idx); // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1163  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1164  	// do some adjustment on the dst_after scaler to account for odm combine mode
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1165  	dml_print("DML_DLG: %s: input dst_x_after_scaler   = %d\n", __func__, dst_x_after_scaler);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1166  	dml_print("DML_DLG: %s: input dst_y_after_scaler   = %d\n", __func__, dst_y_after_scaler);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1167  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1168  	// need to figure out which side of odm combine we're in
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1169  	if (dst->odm_combine) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1170  		// figure out which pipes go together
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1171  		bool visited[DC__NUM_PIPES__MAX];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1172  		unsigned int i, j, k;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1173  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1174  		for (k = 0; k < num_pipes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1175  			visited[k] = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1176  			pipe_index_in_combine[k] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1177  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1178  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1179  		for (i = 0; i < num_pipes; i++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1180  			if (e2e_pipe_param[i].pipe.src.is_hsplit && !visited[i]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1181  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1182  				unsigned int grp = e2e_pipe_param[i].pipe.src.hsplit_grp;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1183  				unsigned int grp_idx = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1184  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1185  				for (j = i; j < num_pipes; j++) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1186  					if (e2e_pipe_param[j].pipe.src.hsplit_grp == grp && e2e_pipe_param[j].pipe.src.is_hsplit && !visited[j]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1187  						pipe_index_in_combine[j] = grp_idx;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1188  						dml_print("DML_DLG: %s: pipe[%d] is in grp %d idx %d\n", __func__, j, grp, grp_idx);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1189  						grp_idx++;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1190  						visited[j] = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1191  					}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1192  				}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1193  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1194  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1195  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1196  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1197  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1198  	if (dst->odm_combine == dm_odm_combine_mode_disabled) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1199  		disp_dlg_regs->refcyc_h_blank_end = (unsigned int) ((double) hblank_end * ref_freq_to_pix_freq);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1200  	} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1201  		unsigned int odm_combine_factor = (dst->odm_combine == dm_odm_combine_mode_2to1 ? 2 : 4); // TODO: We should really check that 4to1 is supported before setting it to 4
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1202  		unsigned int odm_pipe_index = pipe_index_in_combine[pipe_idx];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1203  		disp_dlg_regs->refcyc_h_blank_end = (unsigned int) (((double) hblank_end + odm_pipe_index * (double) dst->hactive / odm_combine_factor) * ref_freq_to_pix_freq);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1204  	} ASSERT(disp_dlg_regs->refcyc_h_blank_end < (unsigned int)dml_pow(2, 13));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1205  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1206  	dml_print("DML_DLG: %s: htotal                     = %d\n", __func__, htotal);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1207  	dml_print("DML_DLG: %s: dst_x_after_scaler[%d]     = %d\n", __func__, pipe_idx, dst_x_after_scaler);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1208  	dml_print("DML_DLG: %s: dst_y_after_scaler[%d]     = %d\n", __func__, pipe_idx, dst_y_after_scaler);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1209  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1210  	dst_y_prefetch = get_dst_y_prefetch(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);        // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1211  	dst_y_per_vm_vblank = get_dst_y_per_vm_vblank(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);        // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1212  	dst_y_per_row_vblank = get_dst_y_per_row_vblank(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);        // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1213  	dst_y_per_vm_flip = get_dst_y_per_vm_flip(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);        // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1214  	dst_y_per_row_flip = get_dst_y_per_row_flip(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);        // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1215  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1216  	max_dst_y_per_vm_vblank = 32.0;        //U5.2
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1217  	max_dst_y_per_row_vblank = 16.0;        //U4.2
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1218  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1219  	// magic!
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1220  	if (htotal <= 75) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1221  		max_dst_y_per_vm_vblank = 100.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1222  		max_dst_y_per_row_vblank = 100.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1223  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1224  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1225  	dml_print("DML_DLG: %s: dst_y_prefetch (after rnd) = %3.2f\n", __func__, dst_y_prefetch);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1226  	dml_print("DML_DLG: %s: dst_y_per_vm_flip    = %3.2f\n", __func__, dst_y_per_vm_flip);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1227  	dml_print("DML_DLG: %s: dst_y_per_row_flip   = %3.2f\n", __func__, dst_y_per_row_flip);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1228  	dml_print("DML_DLG: %s: dst_y_per_vm_vblank  = %3.2f\n", __func__, dst_y_per_vm_vblank);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1229  	dml_print("DML_DLG: %s: dst_y_per_row_vblank = %3.2f\n", __func__, dst_y_per_row_vblank);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1230  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1231  	ASSERT(dst_y_per_vm_vblank < max_dst_y_per_vm_vblank); ASSERT(dst_y_per_row_vblank < max_dst_y_per_row_vblank);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1232  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1233  	ASSERT(dst_y_prefetch > (dst_y_per_vm_vblank + dst_y_per_row_vblank));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1234  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1235  	vratio_pre_l = get_vratio_prefetch_l(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);    // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1236  	vratio_pre_c = get_vratio_prefetch_c(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);    // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1237  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1238  	dml_print("DML_DLG: %s: vratio_pre_l = %3.2f\n", __func__, vratio_pre_l);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1239  	dml_print("DML_DLG: %s: vratio_pre_c = %3.2f\n", __func__, vratio_pre_c);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1240  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1241  	// Active
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1242  	req_per_swath_ub_l = rq_dlg_param.rq_l.req_per_swath_ub;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1243  	req_per_swath_ub_c = rq_dlg_param.rq_c.req_per_swath_ub;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1244  	meta_row_height_l = rq_dlg_param.rq_l.meta_row_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1245  	meta_row_height_c = rq_dlg_param.rq_c.meta_row_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1246  	swath_width_pixels_ub_l = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1247  	swath_width_pixels_ub_c = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1248  	scaler_rec_in_width_l = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1249  	scaler_rec_in_width_c = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1250  	dpte_row_height_l = rq_dlg_param.rq_l.dpte_row_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1251  	dpte_row_height_c = rq_dlg_param.rq_c.dpte_row_height;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1252  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1253  	if (mode_422) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1254  		swath_width_pixels_ub_l = swath_width_ub_l * 2;  // *2 for 2 pixel per element
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1255  		swath_width_pixels_ub_c = swath_width_ub_c * 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1256  	} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1257  		swath_width_pixels_ub_l = swath_width_ub_l * 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1258  		swath_width_pixels_ub_c = swath_width_ub_c * 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1259  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1260  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1261  	hscale_pixel_rate_l = 0.;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1262  	hscale_pixel_rate_c = 0.;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1263  	min_hratio_fact_l = 1.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1264  	min_hratio_fact_c = 1.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1265  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1266  	if (hratio_l <= 1)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1267  		min_hratio_fact_l = 2.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1268  	else if (htaps_l <= 6) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1269  		if ((hratio_l * 2.0) > 4.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1270  			min_hratio_fact_l = 4.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1271  		else
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1272  			min_hratio_fact_l = hratio_l * 2.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1273  	} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1274  		if (hratio_l > 4.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1275  			min_hratio_fact_l = 4.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1276  		else
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1277  			min_hratio_fact_l = hratio_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1278  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1279  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1280  	hscale_pixel_rate_l = min_hratio_fact_l * dppclk_freq_in_mhz;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1281  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1282  	dml_print("DML_DLG: %s: hratio_l = %3.2f\n", __func__, hratio_l);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1283  	dml_print("DML_DLG: %s: min_hratio_fact_l = %3.2f\n", __func__, min_hratio_fact_l);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1284  	dml_print("DML_DLG: %s: hscale_pixel_rate_l = %3.2f\n", __func__, hscale_pixel_rate_l);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1285  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1286  	if (hratio_c <= 1)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1287  		min_hratio_fact_c = 2.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1288  	else if (htaps_c <= 6) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1289  		if ((hratio_c * 2.0) > 4.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1290  			min_hratio_fact_c = 4.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1291  		else
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1292  			min_hratio_fact_c = hratio_c * 2.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1293  	} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1294  		if (hratio_c > 4.0)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1295  			min_hratio_fact_c = 4.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1296  		else
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1297  			min_hratio_fact_c = hratio_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1298  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1299  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1300  	hscale_pixel_rate_c = min_hratio_fact_c * dppclk_freq_in_mhz;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1301  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1302  	refcyc_per_line_delivery_pre_l = 0.;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1303  	refcyc_per_line_delivery_pre_c = 0.;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1304  	refcyc_per_line_delivery_l = 0.;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1305  	refcyc_per_line_delivery_c = 0.;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1306  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1307  	refcyc_per_req_delivery_pre_l = 0.;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1308  	refcyc_per_req_delivery_pre_c = 0.;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1309  	refcyc_per_req_delivery_l = 0.;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1310  	refcyc_per_req_delivery_c = 0.;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1311  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1312  	full_recout_width = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1313  	// In ODM
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1314  	if (src->is_hsplit) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1315  		// This "hack"  is only allowed (and valid) for MPC combine. In ODM
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1316  		// combine, you MUST specify the full_recout_width...according to Oswin
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1317  		if (dst->full_recout_width == 0 && !dst->odm_combine) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1318  			dml_print("DML_DLG: %s: Warning: full_recout_width not set in hsplit mode\n", __func__);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1319  			full_recout_width = dst->recout_width * 2; // assume half split for dcn1
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1320  		} else
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1321  			full_recout_width = dst->full_recout_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1322  	} else
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1323  		full_recout_width = dst->recout_width;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1324  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1325  	// As of DCN2, mpc_combine and odm_combine are mutually exclusive
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1326  	refcyc_per_line_delivery_pre_l = get_refcyc_per_delivery(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1327  			mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1328  			refclk_freq_in_mhz,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1329  			pclk_freq_in_mhz,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1330  			dst->odm_combine,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1331  			full_recout_width,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1332  			dst->hactive,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1333  			vratio_pre_l,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1334  			hscale_pixel_rate_l,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1335  			swath_width_pixels_ub_l,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1336  			1); // per line
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1337  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1338  	refcyc_per_line_delivery_l = get_refcyc_per_delivery(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1339  			mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1340  			refclk_freq_in_mhz,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1341  			pclk_freq_in_mhz,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1342  			dst->odm_combine,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1343  			full_recout_width,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1344  			dst->hactive,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1345  			vratio_l,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1346  			hscale_pixel_rate_l,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1347  			swath_width_pixels_ub_l,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1348  			1); // per line
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1349  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1350  	dml_print("DML_DLG: %s: full_recout_width              = %d\n", __func__, full_recout_width);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1351  	dml_print("DML_DLG: %s: hscale_pixel_rate_l            = %3.2f\n", __func__, hscale_pixel_rate_l);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1352  	dml_print("DML_DLG: %s: refcyc_per_line_delivery_pre_l = %3.2f\n", __func__, refcyc_per_line_delivery_pre_l);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1353  	dml_print("DML_DLG: %s: refcyc_per_line_delivery_l     = %3.2f\n", __func__, refcyc_per_line_delivery_l);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1354  	dml_print("DML_DLG: %s: vba__refcyc_per_line_delivery_pre_l = %3.2f\n", __func__, vba__refcyc_per_line_delivery_pre_l);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1355  	dml_print("DML_DLG: %s: vba__refcyc_per_line_delivery_l     = %3.2f\n", __func__, vba__refcyc_per_line_delivery_l);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1356  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1357  	//old_impl_vs_vba_impl("refcyc_per_line_delivery_pre_l", refcyc_per_line_delivery_pre_l, vba__refcyc_per_line_delivery_pre_l);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1358  	//old_impl_vs_vba_impl("refcyc_per_line_delivery_l", refcyc_per_line_delivery_l, vba__refcyc_per_line_delivery_l);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1359  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1360  	if (dual_plane) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1361  		float vba__refcyc_per_line_delivery_pre_c = get_refcyc_per_line_delivery_pre_c_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz; // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1362  		float vba__refcyc_per_line_delivery_c = get_refcyc_per_line_delivery_c_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz; // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1363  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1364  		refcyc_per_line_delivery_pre_c = get_refcyc_per_delivery(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1365  				mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1366  				refclk_freq_in_mhz,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1367  				pclk_freq_in_mhz,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1368  				dst->odm_combine,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1369  				full_recout_width,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1370  				dst->hactive,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1371  				vratio_pre_c,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1372  				hscale_pixel_rate_c,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1373  				swath_width_pixels_ub_c,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1374  				1); // per line
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1375  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1376  		refcyc_per_line_delivery_c = get_refcyc_per_delivery(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1377  				mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1378  				refclk_freq_in_mhz,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1379  				pclk_freq_in_mhz,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1380  				dst->odm_combine,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1381  				full_recout_width,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1382  				dst->hactive,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1383  				vratio_c,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1384  				hscale_pixel_rate_c,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1385  				swath_width_pixels_ub_c,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1386  				1); // per line
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1387  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1388  		dml_print("DML_DLG: %s: refcyc_per_line_delivery_pre_c = %3.2f\n", __func__, refcyc_per_line_delivery_pre_c);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1389  		dml_print("DML_DLG: %s: refcyc_per_line_delivery_c     = %3.2f\n", __func__, refcyc_per_line_delivery_c);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1390  		dml_print("DML_DLG: %s: vba__refcyc_per_line_delivery_pre_c = %3.2f\n", __func__, vba__refcyc_per_line_delivery_pre_c);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1391  		dml_print("DML_DLG: %s: vba__refcyc_per_line_delivery_c     = %3.2f\n", __func__, vba__refcyc_per_line_delivery_c);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1392  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1393  		//old_impl_vs_vba_impl("refcyc_per_line_delivery_pre_c", refcyc_per_line_delivery_pre_c, vba__refcyc_per_line_delivery_pre_c);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1394  		//old_impl_vs_vba_impl("refcyc_per_line_delivery_c", refcyc_per_line_delivery_c, vba__refcyc_per_line_delivery_c);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1395  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1396  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1397  	if (src->dynamic_metadata_enable && src->gpuvm)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1398  		disp_dlg_regs->refcyc_per_vm_dmdata = get_refcyc_per_vm_dmdata_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz; // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1399  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1400  	disp_dlg_regs->dmdata_dl_delta = get_dmdata_dl_delta_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz; // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1401  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1402  	// TTU - Luma / Chroma
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1403  	if (access_dir) {  // vertical access
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1404  		scaler_rec_in_width_l = vp_height_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1405  		scaler_rec_in_width_c = vp_height_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1406  	} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1407  		scaler_rec_in_width_l = vp_width_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1408  		scaler_rec_in_width_c = vp_width_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1409  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1410  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1411  	refcyc_per_req_delivery_pre_l = get_refcyc_per_delivery(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1412  			mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1413  			refclk_freq_in_mhz,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1414  			pclk_freq_in_mhz,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1415  			dst->odm_combine,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1416  			full_recout_width,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1417  			dst->hactive,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1418  			vratio_pre_l,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1419  			hscale_pixel_rate_l,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1420  			scaler_rec_in_width_l,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1421  			req_per_swath_ub_l);  // per req
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1422  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1423  	refcyc_per_req_delivery_l = get_refcyc_per_delivery(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1424  			mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1425  			refclk_freq_in_mhz,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1426  			pclk_freq_in_mhz,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1427  			dst->odm_combine,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1428  			full_recout_width,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1429  			dst->hactive,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1430  			vratio_l,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1431  			hscale_pixel_rate_l,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1432  			scaler_rec_in_width_l,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1433  			req_per_swath_ub_l);  // per req
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1434  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1435  	dml_print("DML_DLG: %s: refcyc_per_req_delivery_pre_l = %3.2f\n", __func__, refcyc_per_req_delivery_pre_l);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1436  	dml_print("DML_DLG: %s: refcyc_per_req_delivery_l     = %3.2f\n", __func__, refcyc_per_req_delivery_l);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1437  	dml_print("DML_DLG: %s: vba__refcyc_per_req_delivery_pre_l = %3.2f\n", __func__, vba__refcyc_per_req_delivery_pre_l);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1438  	dml_print("DML_DLG: %s: vba__refcyc_per_req_delivery_l     = %3.2f\n", __func__, vba__refcyc_per_req_delivery_l);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1439  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1440  	//old_impl_vs_vba_impl("refcyc_per_req_delivery_pre_l", refcyc_per_req_delivery_pre_l, vba__refcyc_per_req_delivery_pre_l);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1441  	//old_impl_vs_vba_impl("refcyc_per_req_delivery_l", refcyc_per_req_delivery_l, vba__refcyc_per_req_delivery_l);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1442  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1443  	ASSERT(refcyc_per_req_delivery_pre_l < dml_pow(2, 13)); ASSERT(refcyc_per_req_delivery_l < dml_pow(2, 13));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1444  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1445  	if (dual_plane) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1446  		float vba__refcyc_per_req_delivery_pre_c = get_refcyc_per_req_delivery_pre_c_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;  // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1447  		float vba__refcyc_per_req_delivery_c = get_refcyc_per_req_delivery_c_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;  // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1448  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1449  		refcyc_per_req_delivery_pre_c = get_refcyc_per_delivery(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1450  				mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1451  				refclk_freq_in_mhz,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1452  				pclk_freq_in_mhz,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1453  				dst->odm_combine,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1454  				full_recout_width,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1455  				dst->hactive,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1456  				vratio_pre_c,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1457  				hscale_pixel_rate_c,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1458  				scaler_rec_in_width_c,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1459  				req_per_swath_ub_c);  // per req
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1460  		refcyc_per_req_delivery_c = get_refcyc_per_delivery(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1461  				mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1462  				refclk_freq_in_mhz,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1463  				pclk_freq_in_mhz,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1464  				dst->odm_combine,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1465  				full_recout_width,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1466  				dst->hactive,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1467  				vratio_c,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1468  				hscale_pixel_rate_c,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1469  				scaler_rec_in_width_c,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1470  				req_per_swath_ub_c);  // per req
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1471  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1472  		dml_print("DML_DLG: %s: refcyc_per_req_delivery_pre_c = %3.2f\n", __func__, refcyc_per_req_delivery_pre_c);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1473  		dml_print("DML_DLG: %s: refcyc_per_req_delivery_c     = %3.2f\n", __func__, refcyc_per_req_delivery_c);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1474  		dml_print("DML_DLG: %s: vba__refcyc_per_req_delivery_pre_c = %3.2f\n", __func__, vba__refcyc_per_req_delivery_pre_c);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1475  		dml_print("DML_DLG: %s: vba__refcyc_per_req_delivery_c     = %3.2f\n", __func__, vba__refcyc_per_req_delivery_c);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1476  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1477  		//old_impl_vs_vba_impl("refcyc_per_req_delivery_pre_c", refcyc_per_req_delivery_pre_c, vba__refcyc_per_req_delivery_pre_c);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1478  		//old_impl_vs_vba_impl("refcyc_per_req_delivery_c", refcyc_per_req_delivery_c, vba__refcyc_per_req_delivery_c);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1479  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1480  		ASSERT(refcyc_per_req_delivery_pre_c < dml_pow(2, 13)); ASSERT(refcyc_per_req_delivery_c < dml_pow(2, 13));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1481  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1482  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1483  	// TTU - Cursor
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1484  	refcyc_per_req_delivery_pre_cur0 = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1485  	refcyc_per_req_delivery_cur0 = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1486  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1487  	ASSERT(src->num_cursors <= 1);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1488  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1489  	if (src->num_cursors > 0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1490  		float vba__refcyc_per_req_delivery_pre_cur0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1491  		float vba__refcyc_per_req_delivery_cur0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1492  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1493  		calculate_ttu_cursor(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1494  				mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1495  				&refcyc_per_req_delivery_pre_cur0,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1496  				&refcyc_per_req_delivery_cur0,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1497  				refclk_freq_in_mhz,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1498  				ref_freq_to_pix_freq,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1499  				hscale_pixel_rate_l,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1500  				scl->hscl_ratio,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1501  				vratio_pre_l,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1502  				vratio_l,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1503  				src->cur0_src_width,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1504  				(enum cursor_bpp) (src->cur0_bpp));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1505  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1506  		vba__refcyc_per_req_delivery_pre_cur0 = get_refcyc_per_cursor_req_delivery_pre_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz; // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1507  		vba__refcyc_per_req_delivery_cur0 = get_refcyc_per_cursor_req_delivery_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz; // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1508  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1509  		dml_print("DML_DLG: %s: refcyc_per_req_delivery_pre_cur0 = %3.2f\n", __func__, refcyc_per_req_delivery_pre_cur0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1510  		dml_print("DML_DLG: %s: refcyc_per_req_delivery_cur0     = %3.2f\n", __func__, refcyc_per_req_delivery_cur0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1511  		dml_print("DML_DLG: %s: vba__refcyc_per_req_delivery_pre_cur0 = %3.2f\n", __func__, vba__refcyc_per_req_delivery_pre_cur0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1512  		dml_print("DML_DLG: %s: vba__refcyc_per_req_delivery_cur0     = %3.2f\n", __func__, vba__refcyc_per_req_delivery_cur0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1513  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1514  		//old_impl_vs_vba_impl("refcyc_per_req_delivery_pre_cur0", refcyc_per_req_delivery_pre_cur0, vba__refcyc_per_req_delivery_pre_cur0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1515  		//old_impl_vs_vba_impl("refcyc_per_req_delivery_cur0", refcyc_per_req_delivery_cur0, vba__refcyc_per_req_delivery_cur0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1516  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1517  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1518  	refcyc_per_req_delivery_pre_cur1 = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1519  	refcyc_per_req_delivery_cur1 = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1520  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1521  	// TTU - Misc
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1522  	// all hard-coded
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1523  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1524  	// Assignment to register structures
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1525  	disp_dlg_regs->dst_y_after_scaler = dst_y_after_scaler;	// in terms of line
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1526  	ASSERT(disp_dlg_regs->dst_y_after_scaler < (unsigned int)8);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1527  	disp_dlg_regs->refcyc_x_after_scaler = dst_x_after_scaler * ref_freq_to_pix_freq;	// in terms of refclk
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1528  	ASSERT(disp_dlg_regs->refcyc_x_after_scaler < (unsigned int)dml_pow(2, 13));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1529  	disp_dlg_regs->dst_y_prefetch = (unsigned int) (dst_y_prefetch * dml_pow(2, 2));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1530  	disp_dlg_regs->dst_y_per_vm_vblank = (unsigned int) (dst_y_per_vm_vblank * dml_pow(2, 2));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1531  	disp_dlg_regs->dst_y_per_row_vblank = (unsigned int) (dst_y_per_row_vblank * dml_pow(2, 2));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1532  	disp_dlg_regs->dst_y_per_vm_flip = (unsigned int) (dst_y_per_vm_flip * dml_pow(2, 2));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1533  	disp_dlg_regs->dst_y_per_row_flip = (unsigned int) (dst_y_per_row_flip * dml_pow(2, 2));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1534  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1535  	disp_dlg_regs->vratio_prefetch = (unsigned int) (vratio_pre_l * dml_pow(2, 19));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1536  	disp_dlg_regs->vratio_prefetch_c = (unsigned int) (vratio_pre_c * dml_pow(2, 19));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1537  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1538  	dml_print("DML_DLG: %s: disp_dlg_regs->dst_y_per_vm_vblank  = 0x%x\n", __func__, disp_dlg_regs->dst_y_per_vm_vblank);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1539  	dml_print("DML_DLG: %s: disp_dlg_regs->dst_y_per_row_vblank = 0x%x\n", __func__, disp_dlg_regs->dst_y_per_row_vblank);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1540  	dml_print("DML_DLG: %s: disp_dlg_regs->dst_y_per_vm_flip    = 0x%x\n", __func__, disp_dlg_regs->dst_y_per_vm_flip);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1541  	dml_print("DML_DLG: %s: disp_dlg_regs->dst_y_per_row_flip   = 0x%x\n", __func__, disp_dlg_regs->dst_y_per_row_flip);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1542  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1543  	// hack for FPGA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1544  	if (mode_lib->project == DML_PROJECT_DCN31_FPGA) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1545  		if (disp_dlg_regs->vratio_prefetch >= (unsigned int) dml_pow(2, 22)) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1546  			disp_dlg_regs->vratio_prefetch = (unsigned int) dml_pow(2, 22) - 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1547  			dml_print("vratio_prefetch exceed the max value, the register field is [21:0]\n");
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1548  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1549  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1550  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1551  	disp_dlg_regs->refcyc_per_pte_group_vblank_l = (unsigned int) (dst_y_per_row_vblank * (double) htotal * ref_freq_to_pix_freq / (double) dpte_groups_per_row_ub_l);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1552  	ASSERT(disp_dlg_regs->refcyc_per_pte_group_vblank_l < (unsigned int)dml_pow(2, 13));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1553  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1554  	if (dual_plane) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1555  		disp_dlg_regs->refcyc_per_pte_group_vblank_c = (unsigned int) (dst_y_per_row_vblank * (double) htotal * ref_freq_to_pix_freq / (double) dpte_groups_per_row_ub_c);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1556  		ASSERT(disp_dlg_regs->refcyc_per_pte_group_vblank_c < (unsigned int)dml_pow(2, 13));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1557  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1558  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1559  	disp_dlg_regs->refcyc_per_meta_chunk_vblank_l = (unsigned int) (dst_y_per_row_vblank * (double) htotal * ref_freq_to_pix_freq / (double) meta_chunks_per_row_ub_l);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1560  	ASSERT(disp_dlg_regs->refcyc_per_meta_chunk_vblank_l < (unsigned int)dml_pow(2, 13));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1561  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1562  	disp_dlg_regs->refcyc_per_meta_chunk_vblank_c = disp_dlg_regs->refcyc_per_meta_chunk_vblank_l; // dcc for 4:2:0 is not supported in dcn1.0.  assigned to be the same as _l for now
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1563  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1564  	disp_dlg_regs->refcyc_per_pte_group_flip_l = (unsigned int) (dst_y_per_row_flip * htotal * ref_freq_to_pix_freq) / dpte_groups_per_row_ub_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1565  	disp_dlg_regs->refcyc_per_meta_chunk_flip_l = (unsigned int) (dst_y_per_row_flip * htotal * ref_freq_to_pix_freq) / meta_chunks_per_row_ub_l;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1566  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1567  	if (dual_plane) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1568  		disp_dlg_regs->refcyc_per_pte_group_flip_c = (unsigned int) (dst_y_per_row_flip * htotal * ref_freq_to_pix_freq) / dpte_groups_per_row_ub_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1569  		disp_dlg_regs->refcyc_per_meta_chunk_flip_c = (unsigned int) (dst_y_per_row_flip * htotal * ref_freq_to_pix_freq) / meta_chunks_per_row_ub_c;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1570  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1571  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1572  	disp_dlg_regs->refcyc_per_vm_group_vblank = get_refcyc_per_vm_group_vblank_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;            // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1573  	disp_dlg_regs->refcyc_per_vm_group_flip = get_refcyc_per_vm_group_flip_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;            // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1574  	disp_dlg_regs->refcyc_per_vm_req_vblank = get_refcyc_per_vm_req_vblank_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz * dml_pow(2, 10); // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1575  	disp_dlg_regs->refcyc_per_vm_req_flip = get_refcyc_per_vm_req_flip_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz * dml_pow(2, 10);   // From VBA
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1576  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1577  	// Clamp to max for now
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1578  	if (disp_dlg_regs->refcyc_per_vm_group_vblank >= (unsigned int) dml_pow(2, 23))
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1579  		disp_dlg_regs->refcyc_per_vm_group_vblank = dml_pow(2, 23) - 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1580  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1581  	if (disp_dlg_regs->refcyc_per_vm_group_flip >= (unsigned int) dml_pow(2, 23))
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1582  		disp_dlg_regs->refcyc_per_vm_group_flip = dml_pow(2, 23) - 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1583  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1584  	if (disp_dlg_regs->refcyc_per_vm_req_vblank >= (unsigned int) dml_pow(2, 23))
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1585  		disp_dlg_regs->refcyc_per_vm_req_vblank = dml_pow(2, 23) - 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1586  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1587  	if (disp_dlg_regs->refcyc_per_vm_req_flip >= (unsigned int) dml_pow(2, 23))
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1588  		disp_dlg_regs->refcyc_per_vm_req_flip = dml_pow(2, 23) - 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1589  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1590  	disp_dlg_regs->dst_y_per_pte_row_nom_l = (unsigned int) ((double) dpte_row_height_l / (double) vratio_l * dml_pow(2, 2));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1591  	ASSERT(disp_dlg_regs->dst_y_per_pte_row_nom_l < (unsigned int)dml_pow(2, 17));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1592  	if (dual_plane) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1593  		disp_dlg_regs->dst_y_per_pte_row_nom_c = (unsigned int) ((double) dpte_row_height_c / (double) vratio_c * dml_pow(2, 2));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1594  		if (disp_dlg_regs->dst_y_per_pte_row_nom_c >= (unsigned int) dml_pow(2, 17)) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1595  			dml_print(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1596  					"DML_DLG: %s: Warning dst_y_per_pte_row_nom_c %u larger than supported by register format U15.2 %u\n",
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1597  					__func__,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1598  					disp_dlg_regs->dst_y_per_pte_row_nom_c,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1599  					(unsigned int) dml_pow(2, 17) - 1);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1600  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1601  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1602  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1603  	disp_dlg_regs->dst_y_per_meta_row_nom_l = (unsigned int) ((double) meta_row_height_l / (double) vratio_l * dml_pow(2, 2));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1604  	ASSERT(disp_dlg_regs->dst_y_per_meta_row_nom_l < (unsigned int)dml_pow(2, 17));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1605  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1606  	disp_dlg_regs->dst_y_per_meta_row_nom_c = (unsigned int) ((double) meta_row_height_c / (double) vratio_c * dml_pow(2, 2));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1607  	ASSERT(disp_dlg_regs->dst_y_per_meta_row_nom_c < (unsigned int)dml_pow(2, 17));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1608  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1609  	disp_dlg_regs->refcyc_per_pte_group_nom_l = (unsigned int) ((double) dpte_row_height_l / (double) vratio_l * (double) htotal * ref_freq_to_pix_freq
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1610  			/ (double) dpte_groups_per_row_ub_l);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1611  	if (disp_dlg_regs->refcyc_per_pte_group_nom_l >= (unsigned int) dml_pow(2, 23))
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1612  		disp_dlg_regs->refcyc_per_pte_group_nom_l = dml_pow(2, 23) - 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1613  	disp_dlg_regs->refcyc_per_meta_chunk_nom_l = (unsigned int) ((double) meta_row_height_l / (double) vratio_l * (double) htotal * ref_freq_to_pix_freq
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1614  			/ (double) meta_chunks_per_row_ub_l);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1615  	if (disp_dlg_regs->refcyc_per_meta_chunk_nom_l >= (unsigned int) dml_pow(2, 23))
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1616  		disp_dlg_regs->refcyc_per_meta_chunk_nom_l = dml_pow(2, 23) - 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1617  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1618  	if (dual_plane) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1619  		disp_dlg_regs->refcyc_per_pte_group_nom_c = (unsigned int) ((double) dpte_row_height_c / (double) vratio_c * (double) htotal * ref_freq_to_pix_freq
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1620  				/ (double) dpte_groups_per_row_ub_c);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1621  		if (disp_dlg_regs->refcyc_per_pte_group_nom_c >= (unsigned int) dml_pow(2, 23))
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1622  			disp_dlg_regs->refcyc_per_pte_group_nom_c = dml_pow(2, 23) - 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1623  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1624  		// TODO: Is this the right calculation? Does htotal need to be halved?
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1625  		disp_dlg_regs->refcyc_per_meta_chunk_nom_c = (unsigned int) ((double) meta_row_height_c / (double) vratio_c * (double) htotal * ref_freq_to_pix_freq
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1626  				/ (double) meta_chunks_per_row_ub_c);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1627  		if (disp_dlg_regs->refcyc_per_meta_chunk_nom_c >= (unsigned int) dml_pow(2, 23))
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1628  			disp_dlg_regs->refcyc_per_meta_chunk_nom_c = dml_pow(2, 23) - 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1629  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1630  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1631  	disp_dlg_regs->refcyc_per_line_delivery_pre_l = (unsigned int) dml_floor(refcyc_per_line_delivery_pre_l, 1);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1632  	disp_dlg_regs->refcyc_per_line_delivery_l = (unsigned int) dml_floor(refcyc_per_line_delivery_l, 1);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1633  	ASSERT(disp_dlg_regs->refcyc_per_line_delivery_pre_l < (unsigned int)dml_pow(2, 13)); ASSERT(disp_dlg_regs->refcyc_per_line_delivery_l < (unsigned int)dml_pow(2, 13));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1634  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1635  	disp_dlg_regs->refcyc_per_line_delivery_pre_c = (unsigned int) dml_floor(refcyc_per_line_delivery_pre_c, 1);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1636  	disp_dlg_regs->refcyc_per_line_delivery_c = (unsigned int) dml_floor(refcyc_per_line_delivery_c, 1);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1637  	ASSERT(disp_dlg_regs->refcyc_per_line_delivery_pre_c < (unsigned int)dml_pow(2, 13)); ASSERT(disp_dlg_regs->refcyc_per_line_delivery_c < (unsigned int)dml_pow(2, 13));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1638  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1639  	disp_dlg_regs->chunk_hdl_adjust_cur0 = 3;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1640  	disp_dlg_regs->dst_y_offset_cur0 = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1641  	disp_dlg_regs->chunk_hdl_adjust_cur1 = 3;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1642  	disp_dlg_regs->dst_y_offset_cur1 = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1643  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1644  	disp_dlg_regs->dst_y_delta_drq_limit = 0x7fff; // off
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1645  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1646  	disp_ttu_regs->refcyc_per_req_delivery_pre_l = (unsigned int) (refcyc_per_req_delivery_pre_l * dml_pow(2, 10));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1647  	disp_ttu_regs->refcyc_per_req_delivery_l = (unsigned int) (refcyc_per_req_delivery_l * dml_pow(2, 10));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1648  	disp_ttu_regs->refcyc_per_req_delivery_pre_c = (unsigned int) (refcyc_per_req_delivery_pre_c * dml_pow(2, 10));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1649  	disp_ttu_regs->refcyc_per_req_delivery_c = (unsigned int) (refcyc_per_req_delivery_c * dml_pow(2, 10));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1650  	disp_ttu_regs->refcyc_per_req_delivery_pre_cur0 = (unsigned int) (refcyc_per_req_delivery_pre_cur0 * dml_pow(2, 10));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1651  	disp_ttu_regs->refcyc_per_req_delivery_cur0 = (unsigned int) (refcyc_per_req_delivery_cur0 * dml_pow(2, 10));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1652  	disp_ttu_regs->refcyc_per_req_delivery_pre_cur1 = (unsigned int) (refcyc_per_req_delivery_pre_cur1 * dml_pow(2, 10));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1653  	disp_ttu_regs->refcyc_per_req_delivery_cur1 = (unsigned int) (refcyc_per_req_delivery_cur1 * dml_pow(2, 10));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1654  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1655  	disp_ttu_regs->qos_level_low_wm = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1656  	ASSERT(disp_ttu_regs->qos_level_low_wm < dml_pow(2, 14));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1657  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1658  	disp_ttu_regs->qos_level_high_wm = (unsigned int) (4.0 * (double) htotal * ref_freq_to_pix_freq);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1659  	ASSERT(disp_ttu_regs->qos_level_high_wm < dml_pow(2, 14));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1660  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1661  	disp_ttu_regs->qos_level_flip = 14;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1662  	disp_ttu_regs->qos_level_fixed_l = 8;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1663  	disp_ttu_regs->qos_level_fixed_c = 8;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1664  	disp_ttu_regs->qos_level_fixed_cur0 = 8;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1665  	disp_ttu_regs->qos_ramp_disable_l = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1666  	disp_ttu_regs->qos_ramp_disable_c = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1667  	disp_ttu_regs->qos_ramp_disable_cur0 = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1668  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1669  	disp_ttu_regs->min_ttu_vblank = min_ttu_vblank * refclk_freq_in_mhz;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1670  	ASSERT(disp_ttu_regs->min_ttu_vblank < dml_pow(2, 24));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1671  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1672  	print__ttu_regs_st(mode_lib, *disp_ttu_regs);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1673  	print__dlg_regs_st(mode_lib, *disp_dlg_regs);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1674  }
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  1675  

:::::: The code at line 939 was first introduced by commit
:::::: 74458c081fcfb0423877e630de2746daefdb16e4 drm/amd/display: Add DCN3.1 DML calculation support

:::::: TO: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

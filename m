Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DEB54B22C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244404AbiFNNSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiFNNSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:18:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53BF3B00A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 06:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655212714; x=1686748714;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/6AnLH3w+sWIStKpImC06dX2mgGWf5/Ok+tp5pEp2CU=;
  b=KLlLX5Ibg+vo1CE/K7W5NBJeVv7RpUflseAjSi4BUvuUpro99wjwm3zD
   7w4UQXWxMPUnmpumh5q39levh8zDfUQIh+Jd5ABEunM7qgIcy0d3XbBBw
   kBuC00frjJN/frTtpc05rkx99ZCFGTmbE1uBfPXtm0FgB+4OWd4C9ZulP
   8tvvDoFvMiblR9sMS9wSYL5TqUs7ZkyIbllzbt3mpnK6N8KSEmDUopps2
   F4oo94dUmAjllkqNfCazuyEf9Zz4XqYpE9IRUtcf2ew2e4ftur8gxsCh0
   6AGIxlIVM0dJJLF/DnXtaKH77/RyaMtzqZsw7rQqgIpAkayWprnnjTpXa
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="279651741"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="279651741"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 06:18:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="830416759"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jun 2022 06:18:31 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o16RD-000Lv3-8O;
        Tue, 14 Jun 2022 13:18:31 +0000
Date:   Tue, 14 Jun 2022 21:18:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [agd5f:drm-next 40/198]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_rq_dlg_calc_32.c:206:6:
 warning: stack frame size (1308) exceeds limit (1024) in
 'dml32_rq_dlg_get_dlg_reg'
Message-ID: <202206142153.JoIVCgy0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   a6eba20601a3c518f8c60af9da788f9559e0a03c
commit: dda4fb85e433f761eedaed0005a2bc20d705d504 [40/198] drm/amd/display: DML changes for DCN32/321
config: i386-buildonly-randconfig-r002-20220613 (https://download.01.org/0day-ci/archive/20220614/202206142153.JoIVCgy0-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c97436f8b6e2718286e8496faf53a2c800e281cf)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout dda4fb85e433f761eedaed0005a2bc20d705d504
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_rq_dlg_calc_32.c:206:6: warning: stack frame size (1308) exceeds limit (1024) in 'dml32_rq_dlg_get_dlg_reg' [-Wframe-larger-than]
   void dml32_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
        ^
   1 warning generated.


vim +/dml32_rq_dlg_get_dlg_reg +206 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_rq_dlg_calc_32.c

   205	
 > 206	void dml32_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
   207			display_dlg_regs_st *dlg_regs,
   208			display_ttu_regs_st *ttu_regs,
   209			display_e2e_pipe_params_st *e2e_pipe_param,
   210			const unsigned int num_pipes,
   211			const unsigned int pipe_idx)
   212	{
   213		const display_pipe_source_params_st *src = &e2e_pipe_param[pipe_idx].pipe.src;
   214		const display_pipe_dest_params_st *dst = &e2e_pipe_param[pipe_idx].pipe.dest;
   215		const display_clocks_and_cfg_st *clks = &e2e_pipe_param[pipe_idx].clks_cfg;
   216		double refcyc_per_req_delivery_pre_cur0 = 0.;
   217		double refcyc_per_req_delivery_cur0 = 0.;
   218		double refcyc_per_req_delivery_pre_c = 0.;
   219		double refcyc_per_req_delivery_c = 0.;
   220	    double refcyc_per_req_delivery_pre_l;
   221	    double refcyc_per_req_delivery_l;
   222		double refcyc_per_line_delivery_pre_c = 0.;
   223		double refcyc_per_line_delivery_c = 0.;
   224	    double refcyc_per_line_delivery_pre_l;
   225	    double refcyc_per_line_delivery_l;
   226	    double min_ttu_vblank;
   227	    double vratio_pre_l;
   228	    double vratio_pre_c;
   229	    unsigned int min_dst_y_next_start;
   230		unsigned int htotal = dst->htotal;
   231		unsigned int hblank_end = dst->hblank_end;
   232		unsigned int vblank_end = dst->vblank_end;
   233		bool interlaced = dst->interlaced;
   234		double pclk_freq_in_mhz = dst->pixel_rate_mhz;
   235	    unsigned int vready_after_vcount0;
   236		double refclk_freq_in_mhz = clks->refclk_mhz;
   237		double ref_freq_to_pix_freq = refclk_freq_in_mhz / pclk_freq_in_mhz;
   238		bool dual_plane = 0;
   239		unsigned int pipe_index_in_combine[DC__NUM_PIPES__MAX];
   240	    int unsigned dst_x_after_scaler;
   241	    int unsigned dst_y_after_scaler;
   242	    double dst_y_prefetch;
   243	    double dst_y_per_vm_vblank;
   244	    double dst_y_per_row_vblank;
   245	    double dst_y_per_vm_flip;
   246	    double dst_y_per_row_flip;
   247	    double max_dst_y_per_vm_vblank = 32.0;
   248	    double max_dst_y_per_row_vblank = 16.0;
   249	
   250	    double dst_y_per_pte_row_nom_l;
   251	    double dst_y_per_pte_row_nom_c;
   252	    double dst_y_per_meta_row_nom_l;
   253	    double dst_y_per_meta_row_nom_c;
   254	    double refcyc_per_pte_group_nom_l;
   255	    double refcyc_per_pte_group_nom_c;
   256	    double refcyc_per_pte_group_vblank_l;
   257	    double refcyc_per_pte_group_vblank_c;
   258	    double refcyc_per_pte_group_flip_l; 
   259	    double refcyc_per_pte_group_flip_c; 
   260	    double refcyc_per_meta_chunk_nom_l;
   261	    double refcyc_per_meta_chunk_nom_c;
   262	    double refcyc_per_meta_chunk_vblank_l;
   263	    double refcyc_per_meta_chunk_vblank_c;
   264	    double refcyc_per_meta_chunk_flip_l;
   265	    double refcyc_per_meta_chunk_flip_c;
   266	
   267		memset(dlg_regs, 0, sizeof(*dlg_regs));
   268		memset(ttu_regs, 0, sizeof(*ttu_regs));
   269		dml_print("DML_DLG::%s: Calculation for pipe[%d] starts, num_pipes=%d\n", __func__, pipe_idx, num_pipes);
   270		dml_print("DML_DLG: %s: refclk_freq_in_mhz     = %3.2f\n", __func__, refclk_freq_in_mhz);
   271		dml_print("DML_DLG: %s: pclk_freq_in_mhz = %3.2f\n", __func__, pclk_freq_in_mhz);
   272		dml_print("DML_DLG: %s: ref_freq_to_pix_freq   = %3.2f\n", __func__, ref_freq_to_pix_freq);
   273		dml_print("DML_DLG: %s: interlaced = %d\n", __func__, interlaced);
   274		ASSERT(ref_freq_to_pix_freq < 4.0);
   275	
   276		dlg_regs->ref_freq_to_pix_freq = (unsigned int) (ref_freq_to_pix_freq * dml_pow(2, 19));
   277		dlg_regs->refcyc_per_htotal = (unsigned int) (ref_freq_to_pix_freq * (double) htotal * dml_pow(2, 8));
   278		dlg_regs->dlg_vblank_end = interlaced ? (vblank_end / 2) : vblank_end; // 15 bits
   279	
   280		min_ttu_vblank = get_min_ttu_vblank_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx); // From VBA
   281		min_dst_y_next_start = get_min_dst_y_next_start(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);
   282	
   283		dml_print("DML_DLG: %s: min_ttu_vblank (us)    = %3.2f\n", __func__, min_ttu_vblank);
   284		dml_print("DML_DLG: %s: min_dst_y_next_start = %d\n", __func__, min_dst_y_next_start);
   285		dml_print("DML_DLG: %s: ref_freq_to_pix_freq   = %3.2f\n", __func__, ref_freq_to_pix_freq);
   286	
   287		dual_plane = is_dual_plane((enum source_format_class) (src->source_format));
   288	
   289		vready_after_vcount0 = get_vready_at_or_after_vsync(mode_lib, e2e_pipe_param, num_pipes,
   290				pipe_idx); // From VBA
   291		dlg_regs->vready_after_vcount0 = vready_after_vcount0;
   292	
   293		dml_print("DML_DLG: %s: vready_after_vcount0 = %d\n", __func__, dlg_regs->vready_after_vcount0);
   294	
   295		dst_x_after_scaler = get_dst_x_after_scaler(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);
   296		dst_y_after_scaler = get_dst_y_after_scaler(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);
   297	
   298		// do some adjustment on the dst_after scaler to account for odm combine mode
   299		dml_print("DML_DLG: %s: input dst_x_after_scaler   = %d\n", __func__, dst_x_after_scaler);
   300		dml_print("DML_DLG: %s: input dst_y_after_scaler   = %d\n", __func__, dst_y_after_scaler);
   301	
   302		// need to figure out which side of odm combine we're in
   303		if (dst->odm_combine == dm_odm_combine_mode_2to1 || dst->odm_combine == dm_odm_combine_mode_4to1) {
   304			// figure out which pipes go together
   305			bool visited[DC__NUM_PIPES__MAX];
   306			unsigned int i, j, k;
   307	
   308			for (k = 0; k < num_pipes; ++k) {
   309				visited[k] = false;
   310				pipe_index_in_combine[k] = 0;
   311			}
   312	
   313			for (i = 0; i < num_pipes; i++) {
   314				if (e2e_pipe_param[i].pipe.src.is_hsplit && !visited[i]) {
   315	
   316					unsigned int grp = e2e_pipe_param[i].pipe.src.hsplit_grp;
   317					unsigned int grp_idx = 0;
   318	
   319					for (j = i; j < num_pipes; j++) {
   320						if (e2e_pipe_param[j].pipe.src.hsplit_grp == grp
   321							&& e2e_pipe_param[j].pipe.src.is_hsplit && !visited[j]) {
   322							pipe_index_in_combine[j] = grp_idx;
   323							dml_print("DML_DLG: %s: pipe[%d] is in grp %d idx %d\n",
   324									__func__, j, grp, grp_idx);
   325							grp_idx++;
   326							visited[j] = true;
   327						}
   328					}
   329				}
   330			}
   331		}
   332	
   333		if (dst->odm_combine == dm_odm_combine_mode_disabled) {
   334			// FIXME how about ODM split??
   335			dlg_regs->refcyc_h_blank_end = (unsigned int) ((double) hblank_end * ref_freq_to_pix_freq);
   336		} else {
   337			if (dst->odm_combine == dm_odm_combine_mode_2to1 || dst->odm_combine == dm_odm_combine_mode_4to1) {
   338				// TODO: We should really check that 4to1 is supported before setting it to 4
   339				unsigned int odm_combine_factor = (dst->odm_combine == dm_odm_combine_mode_2to1 ? 2 : 4);
   340				unsigned int odm_pipe_index = pipe_index_in_combine[pipe_idx];
   341	
   342				dlg_regs->refcyc_h_blank_end = (unsigned int) (((double) hblank_end
   343					+ odm_pipe_index * (double) dst->hactive / odm_combine_factor) * ref_freq_to_pix_freq);
   344			}
   345		}
   346		ASSERT(dlg_regs->refcyc_h_blank_end < (unsigned int)dml_pow(2, 13));
   347	
   348		dml_print("DML_DLG: %s: htotal= %d\n", __func__, htotal);
   349		dml_print("DML_DLG: %s: dst_x_after_scaler[%d]= %d\n", __func__, pipe_idx, dst_x_after_scaler);
   350		dml_print("DML_DLG: %s: dst_y_after_scaler[%d] = %d\n", __func__, pipe_idx, dst_y_after_scaler);
   351	
   352		dst_y_prefetch = get_dst_y_prefetch(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);        // From VBA
   353		// From VBA
   354		dst_y_per_vm_vblank = get_dst_y_per_vm_vblank(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);
   355		// From VBA
   356		dst_y_per_row_vblank = get_dst_y_per_row_vblank(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);
   357		dst_y_per_vm_flip = get_dst_y_per_vm_flip(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);    // From VBA
   358		dst_y_per_row_flip = get_dst_y_per_row_flip(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);  // From VBA
   359	
   360		// magic!
   361		if (htotal <= 75) {
   362			max_dst_y_per_vm_vblank = 100.0;
   363			max_dst_y_per_row_vblank = 100.0;
   364		}
   365	
   366		dml_print("DML_DLG: %s: dst_y_prefetch (after rnd) = %3.2f\n", __func__, dst_y_prefetch);
   367		dml_print("DML_DLG: %s: dst_y_per_vm_flip    = %3.2f\n", __func__, dst_y_per_vm_flip);
   368		dml_print("DML_DLG: %s: dst_y_per_row_flip   = %3.2f\n", __func__, dst_y_per_row_flip);
   369		dml_print("DML_DLG: %s: dst_y_per_vm_vblank  = %3.2f\n", __func__, dst_y_per_vm_vblank);
   370		dml_print("DML_DLG: %s: dst_y_per_row_vblank = %3.2f\n", __func__, dst_y_per_row_vblank);
   371	
   372		ASSERT(dst_y_per_vm_vblank < max_dst_y_per_vm_vblank);
   373		ASSERT(dst_y_per_row_vblank < max_dst_y_per_row_vblank);
   374		ASSERT(dst_y_prefetch > (dst_y_per_vm_vblank + dst_y_per_row_vblank));
   375	
   376		vratio_pre_l = get_vratio_prefetch_l(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);    // From VBA
   377		vratio_pre_c = get_vratio_prefetch_c(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);    // From VBA
   378	
   379		dml_print("DML_DLG: %s: vratio_pre_l = %3.2f\n", __func__, vratio_pre_l);
   380		dml_print("DML_DLG: %s: vratio_pre_c = %3.2f\n", __func__, vratio_pre_c);
   381	
   382		// Active
   383		refcyc_per_line_delivery_pre_l = get_refcyc_per_line_delivery_pre_l_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;   // From VBA
   384		refcyc_per_line_delivery_l = get_refcyc_per_line_delivery_l_in_us(mode_lib, e2e_pipe_param, num_pipes,
   385				pipe_idx) * refclk_freq_in_mhz;       // From VBA
   386	
   387		dml_print("DML_DLG: %s: refcyc_per_line_delivery_pre_l = %3.2f\n", __func__, refcyc_per_line_delivery_pre_l);
   388		dml_print("DML_DLG: %s: refcyc_per_line_delivery_l     = %3.2f\n", __func__, refcyc_per_line_delivery_l);
   389	
   390		if (dual_plane) {
   391			refcyc_per_line_delivery_pre_c = get_refcyc_per_line_delivery_pre_c_in_us(mode_lib, e2e_pipe_param,
   392					num_pipes, pipe_idx) * refclk_freq_in_mhz;     // From VBA
   393			refcyc_per_line_delivery_c = get_refcyc_per_line_delivery_c_in_us(mode_lib, e2e_pipe_param, num_pipes,
   394					pipe_idx) * refclk_freq_in_mhz; // From VBA
   395	
   396			dml_print("DML_DLG: %s: refcyc_per_line_delivery_pre_c = %3.2f\n",
   397					__func__, refcyc_per_line_delivery_pre_c);
   398			dml_print("DML_DLG: %s: refcyc_per_line_delivery_c     = %3.2f\n",
   399					__func__, refcyc_per_line_delivery_c);
   400		}
   401	
   402		if (src->dynamic_metadata_enable && src->gpuvm)
   403			dlg_regs->refcyc_per_vm_dmdata = get_refcyc_per_vm_dmdata_in_us(mode_lib, e2e_pipe_param, num_pipes,
   404					pipe_idx) * refclk_freq_in_mhz; // From VBA
   405	
   406		dlg_regs->dmdata_dl_delta = get_dmdata_dl_delta_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx)
   407			* refclk_freq_in_mhz; // From VBA
   408	
   409		refcyc_per_req_delivery_pre_l = get_refcyc_per_req_delivery_pre_l_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz; // From VBA
   410		refcyc_per_req_delivery_l = get_refcyc_per_req_delivery_l_in_us(mode_lib, e2e_pipe_param, num_pipes,
   411				pipe_idx) * refclk_freq_in_mhz;     // From VBA
   412	
   413		dml_print("DML_DLG: %s: refcyc_per_req_delivery_pre_l = %3.2f\n", __func__, refcyc_per_req_delivery_pre_l);
   414		dml_print("DML_DLG: %s: refcyc_per_req_delivery_l     = %3.2f\n", __func__, refcyc_per_req_delivery_l);
   415	
   416		if (dual_plane) {
   417			refcyc_per_req_delivery_pre_c = get_refcyc_per_req_delivery_pre_c_in_us(mode_lib, e2e_pipe_param,
   418					num_pipes, pipe_idx) * refclk_freq_in_mhz;  // From VBA
   419			refcyc_per_req_delivery_c = get_refcyc_per_req_delivery_c_in_us(mode_lib, e2e_pipe_param, num_pipes,
   420					pipe_idx) * refclk_freq_in_mhz;      // From VBA
   421	
   422			dml_print("DML_DLG: %s: refcyc_per_req_delivery_pre_c = %3.2f\n",
   423					__func__, refcyc_per_req_delivery_pre_c);
   424			dml_print("DML_DLG: %s: refcyc_per_req_delivery_c     = %3.2f\n", __func__, refcyc_per_req_delivery_c);
   425		}
   426	
   427		// TTU - Cursor
   428		ASSERT(src->num_cursors <= 1);
   429		if (src->num_cursors > 0) {
   430			refcyc_per_req_delivery_pre_cur0 = get_refcyc_per_cursor_req_delivery_pre_in_us(mode_lib,
   431					e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;  // From VBA
   432			refcyc_per_req_delivery_cur0 = get_refcyc_per_cursor_req_delivery_in_us(mode_lib, e2e_pipe_param,
   433					num_pipes, pipe_idx) * refclk_freq_in_mhz;      // From VBA
   434	
   435			dml_print("DML_DLG: %s: refcyc_per_req_delivery_pre_cur0 = %3.2f\n",
   436					__func__, refcyc_per_req_delivery_pre_cur0);
   437			dml_print("DML_DLG: %s: refcyc_per_req_delivery_cur0     = %3.2f\n",
   438					__func__, refcyc_per_req_delivery_cur0);
   439		}
   440	
   441		// Assign to register structures
   442		dlg_regs->min_dst_y_next_start = min_dst_y_next_start * dml_pow(2, 2);
   443		ASSERT(dlg_regs->min_dst_y_next_start < (unsigned int)dml_pow(2, 18));
   444	
   445		dlg_regs->dst_y_after_scaler = dst_y_after_scaler; // in terms of line
   446		dlg_regs->refcyc_x_after_scaler = dst_x_after_scaler * ref_freq_to_pix_freq; // in terms of refclk
   447		dlg_regs->dst_y_prefetch = (unsigned int) (dst_y_prefetch * dml_pow(2, 2));
   448		dlg_regs->dst_y_per_vm_vblank = (unsigned int) (dst_y_per_vm_vblank * dml_pow(2, 2));
   449		dlg_regs->dst_y_per_row_vblank = (unsigned int) (dst_y_per_row_vblank * dml_pow(2, 2));
   450		dlg_regs->dst_y_per_vm_flip = (unsigned int) (dst_y_per_vm_flip * dml_pow(2, 2));
   451		dlg_regs->dst_y_per_row_flip = (unsigned int) (dst_y_per_row_flip * dml_pow(2, 2));
   452	
   453		dlg_regs->vratio_prefetch = (unsigned int) (vratio_pre_l * dml_pow(2, 19));
   454		dlg_regs->vratio_prefetch_c = (unsigned int) (vratio_pre_c * dml_pow(2, 19));
   455	
   456		dml_print("DML_DLG: %s: dlg_regs->dst_y_per_vm_vblank  = 0x%x\n", __func__, dlg_regs->dst_y_per_vm_vblank);
   457		dml_print("DML_DLG: %s: dlg_regs->dst_y_per_row_vblank = 0x%x\n", __func__, dlg_regs->dst_y_per_row_vblank);
   458		dml_print("DML_DLG: %s: dlg_regs->dst_y_per_vm_flip    = 0x%x\n", __func__, dlg_regs->dst_y_per_vm_flip);
   459		dml_print("DML_DLG: %s: dlg_regs->dst_y_per_row_flip   = 0x%x\n", __func__, dlg_regs->dst_y_per_row_flip);
   460	
   461		dlg_regs->refcyc_per_vm_group_vblank = get_refcyc_per_vm_group_vblank_in_us(mode_lib, e2e_pipe_param,
   462				num_pipes, pipe_idx) * refclk_freq_in_mhz;               // From VBA
   463		dlg_regs->refcyc_per_vm_group_flip = get_refcyc_per_vm_group_flip_in_us(mode_lib, e2e_pipe_param, num_pipes,
   464				pipe_idx) * refclk_freq_in_mhz;                 // From VBA
   465		dlg_regs->refcyc_per_vm_req_vblank = get_refcyc_per_vm_req_vblank_in_us(mode_lib, e2e_pipe_param, num_pipes,
   466				pipe_idx) * refclk_freq_in_mhz * dml_pow(2, 10);                 // From VBA
   467		dlg_regs->refcyc_per_vm_req_flip = get_refcyc_per_vm_req_flip_in_us(mode_lib, e2e_pipe_param, num_pipes,
   468				pipe_idx) * refclk_freq_in_mhz * dml_pow(2, 10);  // From VBA
   469	
   470		// From VBA
   471		dst_y_per_pte_row_nom_l = get_dst_y_per_pte_row_nom_l(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);
   472		// From VBA
   473		dst_y_per_pte_row_nom_c = get_dst_y_per_pte_row_nom_c(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);
   474		// From VBA
   475		dst_y_per_meta_row_nom_l = get_dst_y_per_meta_row_nom_l(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);
   476		// From VBA
   477		dst_y_per_meta_row_nom_c = get_dst_y_per_meta_row_nom_c(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);
   478	
   479		refcyc_per_pte_group_nom_l = get_refcyc_per_pte_group_nom_l_in_us(mode_lib, e2e_pipe_param, num_pipes,
   480				pipe_idx) * refclk_freq_in_mhz;         // From VBA
   481		refcyc_per_pte_group_nom_c = get_refcyc_per_pte_group_nom_c_in_us(mode_lib, e2e_pipe_param, num_pipes,
   482				pipe_idx) * refclk_freq_in_mhz;         // From VBA
   483		refcyc_per_pte_group_vblank_l = get_refcyc_per_pte_group_vblank_l_in_us(mode_lib, e2e_pipe_param,
   484				num_pipes, pipe_idx) * refclk_freq_in_mhz;      // From VBA
   485		refcyc_per_pte_group_vblank_c = get_refcyc_per_pte_group_vblank_c_in_us(mode_lib, e2e_pipe_param,
   486				num_pipes, pipe_idx) * refclk_freq_in_mhz;      // From VBA
   487		refcyc_per_pte_group_flip_l = get_refcyc_per_pte_group_flip_l_in_us(mode_lib, e2e_pipe_param, num_pipes,
   488				pipe_idx) * refclk_freq_in_mhz;        // From VBA
   489		refcyc_per_pte_group_flip_c = get_refcyc_per_pte_group_flip_c_in_us(mode_lib, e2e_pipe_param, num_pipes,
   490				pipe_idx) * refclk_freq_in_mhz;        // From VBA
   491	
   492		refcyc_per_meta_chunk_nom_l = get_refcyc_per_meta_chunk_nom_l_in_us(mode_lib, e2e_pipe_param, num_pipes,
   493				pipe_idx) * refclk_freq_in_mhz;        // From VBA
   494		refcyc_per_meta_chunk_nom_c = get_refcyc_per_meta_chunk_nom_c_in_us(mode_lib, e2e_pipe_param, num_pipes,
   495				pipe_idx) * refclk_freq_in_mhz;        // From VBA
   496		refcyc_per_meta_chunk_vblank_l = get_refcyc_per_meta_chunk_vblank_l_in_us(mode_lib, e2e_pipe_param,
   497				num_pipes, pipe_idx) * refclk_freq_in_mhz;     // From VBA
   498		refcyc_per_meta_chunk_vblank_c = get_refcyc_per_meta_chunk_vblank_c_in_us(mode_lib, e2e_pipe_param,
   499				num_pipes, pipe_idx) * refclk_freq_in_mhz;     // From VBA
   500		refcyc_per_meta_chunk_flip_l = get_refcyc_per_meta_chunk_flip_l_in_us(mode_lib, e2e_pipe_param,
   501				num_pipes, pipe_idx) * refclk_freq_in_mhz;       // From VBA
   502		refcyc_per_meta_chunk_flip_c = get_refcyc_per_meta_chunk_flip_c_in_us(mode_lib, e2e_pipe_param,
   503				num_pipes, pipe_idx) * refclk_freq_in_mhz;       // From VBA
   504	
   505		dlg_regs->dst_y_per_pte_row_nom_l = dst_y_per_pte_row_nom_l * dml_pow(2, 2);
   506		dlg_regs->dst_y_per_pte_row_nom_c = dst_y_per_pte_row_nom_c * dml_pow(2, 2);
   507		dlg_regs->dst_y_per_meta_row_nom_l = dst_y_per_meta_row_nom_l * dml_pow(2, 2);
   508		dlg_regs->dst_y_per_meta_row_nom_c = dst_y_per_meta_row_nom_c * dml_pow(2, 2);
   509		dlg_regs->refcyc_per_pte_group_nom_l = refcyc_per_pte_group_nom_l;
   510		dlg_regs->refcyc_per_pte_group_nom_c = refcyc_per_pte_group_nom_c;
   511		dlg_regs->refcyc_per_pte_group_vblank_l = refcyc_per_pte_group_vblank_l;
   512		dlg_regs->refcyc_per_pte_group_vblank_c = refcyc_per_pte_group_vblank_c;
   513		dlg_regs->refcyc_per_pte_group_flip_l = refcyc_per_pte_group_flip_l;
   514		dlg_regs->refcyc_per_pte_group_flip_c = refcyc_per_pte_group_flip_c;
   515		dlg_regs->refcyc_per_meta_chunk_nom_l = refcyc_per_meta_chunk_nom_l;
   516		dlg_regs->refcyc_per_meta_chunk_nom_c = refcyc_per_meta_chunk_nom_c;
   517		dlg_regs->refcyc_per_meta_chunk_vblank_l = refcyc_per_meta_chunk_vblank_l;
   518		dlg_regs->refcyc_per_meta_chunk_vblank_c = refcyc_per_meta_chunk_vblank_c;
   519		dlg_regs->refcyc_per_meta_chunk_flip_l = refcyc_per_meta_chunk_flip_l;
   520		dlg_regs->refcyc_per_meta_chunk_flip_c = refcyc_per_meta_chunk_flip_c;
   521		dlg_regs->refcyc_per_line_delivery_pre_l = (unsigned int) dml_floor(refcyc_per_line_delivery_pre_l, 1);
   522		dlg_regs->refcyc_per_line_delivery_l = (unsigned int) dml_floor(refcyc_per_line_delivery_l, 1);
   523		dlg_regs->refcyc_per_line_delivery_pre_c = (unsigned int) dml_floor(refcyc_per_line_delivery_pre_c, 1);
   524		dlg_regs->refcyc_per_line_delivery_c = (unsigned int) dml_floor(refcyc_per_line_delivery_c, 1);
   525	
   526		dlg_regs->chunk_hdl_adjust_cur0 = 3;
   527		dlg_regs->dst_y_offset_cur0 = 0;
   528		dlg_regs->chunk_hdl_adjust_cur1 = 3;
   529		dlg_regs->dst_y_offset_cur1 = 0;
   530	
   531		dlg_regs->dst_y_delta_drq_limit = 0x7fff; // off
   532	
   533		ttu_regs->refcyc_per_req_delivery_pre_l = (unsigned int) (refcyc_per_req_delivery_pre_l * dml_pow(2, 10));
   534		ttu_regs->refcyc_per_req_delivery_l = (unsigned int) (refcyc_per_req_delivery_l * dml_pow(2, 10));
   535		ttu_regs->refcyc_per_req_delivery_pre_c = (unsigned int) (refcyc_per_req_delivery_pre_c * dml_pow(2, 10));
   536		ttu_regs->refcyc_per_req_delivery_c = (unsigned int) (refcyc_per_req_delivery_c * dml_pow(2, 10));
   537		ttu_regs->refcyc_per_req_delivery_pre_cur0 =
   538				(unsigned int) (refcyc_per_req_delivery_pre_cur0 * dml_pow(2, 10));
   539		ttu_regs->refcyc_per_req_delivery_cur0 = (unsigned int) (refcyc_per_req_delivery_cur0 * dml_pow(2, 10));
   540		ttu_regs->refcyc_per_req_delivery_pre_cur1 = 0;
   541		ttu_regs->refcyc_per_req_delivery_cur1 = 0;
   542		ttu_regs->qos_level_low_wm = 0;
   543	
   544		ttu_regs->qos_level_high_wm = (unsigned int) (4.0 * (double) htotal * ref_freq_to_pix_freq);
   545	
   546		ttu_regs->qos_level_flip = 14;
   547		ttu_regs->qos_level_fixed_l = 8;
   548		ttu_regs->qos_level_fixed_c = 8;
   549		ttu_regs->qos_level_fixed_cur0 = 8;
   550		ttu_regs->qos_ramp_disable_l = 0;
   551		ttu_regs->qos_ramp_disable_c = 0;
   552		ttu_regs->qos_ramp_disable_cur0 = 0;
   553		ttu_regs->min_ttu_vblank = min_ttu_vblank * refclk_freq_in_mhz;
   554	
   555		// CHECK for HW registers' range, assert or clamp
   556		ASSERT(refcyc_per_req_delivery_pre_l < dml_pow(2, 13));
   557		ASSERT(refcyc_per_req_delivery_l < dml_pow(2, 13));
   558		ASSERT(refcyc_per_req_delivery_pre_c < dml_pow(2, 13));
   559		ASSERT(refcyc_per_req_delivery_c < dml_pow(2, 13));
   560		if (dlg_regs->refcyc_per_vm_group_vblank >= (unsigned int) dml_pow(2, 23))
   561			dlg_regs->refcyc_per_vm_group_vblank = dml_pow(2, 23) - 1;
   562	
   563		if (dlg_regs->refcyc_per_vm_group_flip >= (unsigned int) dml_pow(2, 23))
   564			dlg_regs->refcyc_per_vm_group_flip = dml_pow(2, 23) - 1;
   565	
   566		if (dlg_regs->refcyc_per_vm_req_vblank >= (unsigned int) dml_pow(2, 23))
   567			dlg_regs->refcyc_per_vm_req_vblank = dml_pow(2, 23) - 1;
   568	
   569		if (dlg_regs->refcyc_per_vm_req_flip >= (unsigned int) dml_pow(2, 23))
   570			dlg_regs->refcyc_per_vm_req_flip = dml_pow(2, 23) - 1;
   571	
   572		ASSERT(dlg_regs->dst_y_after_scaler < (unsigned int) 8);
   573		ASSERT(dlg_regs->refcyc_x_after_scaler < (unsigned int)dml_pow(2, 13));
   574		ASSERT(dlg_regs->dst_y_per_pte_row_nom_l < (unsigned int)dml_pow(2, 17));
   575		if (dual_plane) {
   576			if (dlg_regs->dst_y_per_pte_row_nom_c >= (unsigned int) dml_pow(2, 17)) {
   577				// FIXME what so special about chroma, can we just assert?
   578				dml_print("DML_DLG: %s: Warning dst_y_per_pte_row_nom_c %u > register max U15.2 %u\n",
   579						__func__, dlg_regs->dst_y_per_pte_row_nom_c, (unsigned int)dml_pow(2, 17) - 1);
   580			}
   581		}
   582		ASSERT(dlg_regs->dst_y_per_meta_row_nom_l < (unsigned int)dml_pow(2, 17));
   583		ASSERT(dlg_regs->dst_y_per_meta_row_nom_c < (unsigned int)dml_pow(2, 17));
   584	
   585		if (dlg_regs->refcyc_per_pte_group_nom_l >= (unsigned int) dml_pow(2, 23))
   586			dlg_regs->refcyc_per_pte_group_nom_l = dml_pow(2, 23) - 1;
   587		if (dual_plane) {
   588			if (dlg_regs->refcyc_per_pte_group_nom_c >= (unsigned int) dml_pow(2, 23))
   589				dlg_regs->refcyc_per_pte_group_nom_c = dml_pow(2, 23) - 1;
   590		}
   591		ASSERT(dlg_regs->refcyc_per_pte_group_vblank_l < (unsigned int)dml_pow(2, 13));
   592		if (dual_plane) {
   593			ASSERT(dlg_regs->refcyc_per_pte_group_vblank_c < (unsigned int)dml_pow(2, 13));
   594		}
   595	
   596		if (dlg_regs->refcyc_per_meta_chunk_nom_l >= (unsigned int) dml_pow(2, 23))
   597			dlg_regs->refcyc_per_meta_chunk_nom_l = dml_pow(2, 23) - 1;
   598		if (dual_plane) {
   599			if (dlg_regs->refcyc_per_meta_chunk_nom_c >= (unsigned int) dml_pow(2, 23))
   600				dlg_regs->refcyc_per_meta_chunk_nom_c = dml_pow(2, 23) - 1;
   601		}
   602		ASSERT(dlg_regs->refcyc_per_meta_chunk_vblank_l < (unsigned int)dml_pow(2, 13));
   603		ASSERT(dlg_regs->refcyc_per_meta_chunk_vblank_c < (unsigned int)dml_pow(2, 13));
   604		ASSERT(dlg_regs->refcyc_per_line_delivery_pre_l < (unsigned int)dml_pow(2, 13));
   605		ASSERT(dlg_regs->refcyc_per_line_delivery_l < (unsigned int)dml_pow(2, 13));
   606		ASSERT(dlg_regs->refcyc_per_line_delivery_pre_c < (unsigned int)dml_pow(2, 13));
   607		ASSERT(dlg_regs->refcyc_per_line_delivery_c < (unsigned int)dml_pow(2, 13));
   608		ASSERT(ttu_regs->qos_level_low_wm < dml_pow(2, 14));
   609		ASSERT(ttu_regs->qos_level_high_wm < dml_pow(2, 14));
   610		ASSERT(ttu_regs->min_ttu_vblank < dml_pow(2, 24));
   611	
   612		print__ttu_regs_st(mode_lib, ttu_regs);
   613		print__dlg_regs_st(mode_lib, dlg_regs);
   614		dml_print("DML_DLG::%s: Calculation for pipe[%d] done, num_pipes=%d\n", __func__, pipe_idx, num_pipes);
   615	}
   616	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

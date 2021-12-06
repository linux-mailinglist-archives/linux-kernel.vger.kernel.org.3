Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D68646AE50
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 00:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353748AbhLFXVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 18:21:55 -0500
Received: from mga06.intel.com ([134.134.136.31]:61518 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351294AbhLFXVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 18:21:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="298228812"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="298228812"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 15:18:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="502326842"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 06 Dec 2021 15:18:23 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muNFW-000Lr8-6S; Mon, 06 Dec 2021 23:18:22 +0000
Date:   Tue, 7 Dec 2021 07:17:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vladimir Stempen <vladimir.stempen@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:312:6:
 warning: no previous prototype for 'optc2_align_vblanks'
Message-ID: <202112070707.FwbdQm85-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f80ef9e49fdfbfbc4197711230098b90e6b05a7e
commit: 77a2b7265f20ee827e527eaa6f82b87e88388947 drm/amd/display: Synchronize displays with different timings
date:   10 months ago
config: i386-buildonly-randconfig-r002-20211205 (https://download.01.org/0day-ci/archive/20211207/202112070707.FwbdQm85-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=77a2b7265f20ee827e527eaa6f82b87e88388947
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 77a2b7265f20ee827e527eaa6f82b87e88388947
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:80:6: warning: no previous prototype for 'optc2_set_timing_db_mode' [-Wmissing-prototypes]
      80 | void optc2_set_timing_db_mode(struct timing_generator *optc, bool enable)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:114:6: warning: no previous prototype for 'optc2_use_gsl_as_master_update_lock' [-Wmissing-prototypes]
     114 | void optc2_use_gsl_as_master_update_lock(struct timing_generator *optc,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:124:6: warning: no previous prototype for 'optc2_set_gsl_window' [-Wmissing-prototypes]
     124 | void optc2_set_gsl_window(struct timing_generator *optc,
         |      ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:142:6: warning: no previous prototype for 'optc2_set_vupdate_keepout' [-Wmissing-prototypes]
     142 | void optc2_set_vupdate_keepout(struct timing_generator *optc,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:176:6: warning: no previous prototype for 'optc2_set_dsc_encoder_frame_start' [-Wmissing-prototypes]
     176 | void optc2_set_dsc_encoder_frame_start(struct timing_generator *optc,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:299:6: warning: no previous prototype for 'optc2_set_dwb_source' [-Wmissing-prototypes]
     299 | void optc2_set_dwb_source(struct timing_generator *optc,
         |      ^~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:312:6: warning: no previous prototype for 'optc2_align_vblanks' [-Wmissing-prototypes]
     312 | void optc2_align_vblanks(
         |      ^~~~~~~~~~~~~~~~~~~
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:74:6: warning: no previous prototype for 'print_microsec' [-Wmissing-prototypes]
      74 | void print_microsec(struct dc_context *dc_ctx,
         |      ^~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:129:6: warning: no previous prototype for 'dcn10_log_hubbub_state' [-Wmissing-prototypes]
     129 | void dcn10_log_hubbub_state(struct dc *dc, struct dc_log_buffer_ctx *log_ctx)
         |      ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1854:10: warning: no previous prototype for 'reduceSizeAndFraction' [-Wmissing-prototypes]
    1854 | uint64_t reduceSizeAndFraction(
         |          ^~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1900:6: warning: no previous prototype for 'is_low_refresh_rate' [-Wmissing-prototypes]
    1900 | bool is_low_refresh_rate(struct pipe_ctx *pipe)
         |      ^~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1909:9: warning: no previous prototype for 'get_clock_divider' [-Wmissing-prototypes]
    1909 | uint8_t get_clock_divider(struct pipe_ctx *pipe, bool account_low_refresh_rate)
         |         ^~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1929:5: warning: no previous prototype for 'dcn10_align_pixel_clocks' [-Wmissing-prototypes]
    1929 | int dcn10_align_pixel_clocks(
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: In function 'dcn10_align_pixel_clocks':
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1944:7: warning: variable 'clamshell_closed' set but not used [-Wunused-but-set-variable]
    1944 |  bool clamshell_closed = false;
         |       ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: At top level:
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2344:6: warning: no previous prototype for 'dcn10_program_pte_vm' [-Wmissing-prototypes]
    2344 | void dcn10_program_pte_vm(struct dce_hwseq *hws, struct hubp *hubp)
         |      ^~~~~~~~~~~~~~~~~~~~


vim +/optc2_align_vblanks +312 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c

   136	
   137	/**
   138	 * Vupdate keepout can be set to a window to block the update lock for that pipe from changing.
   139	 * Start offset begins with vstartup and goes for x number of clocks,
   140	 * end offset starts from end of vupdate to x number of clocks.
   141	 */
 > 142	void optc2_set_vupdate_keepout(struct timing_generator *optc,
   143			   const struct vupdate_keepout_params *params)
   144	{
   145		struct optc *optc1 = DCN10TG_FROM_TG(optc);
   146	
   147		REG_SET_3(OTG_VUPDATE_KEEPOUT, 0,
   148			MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET, params->start_offset,
   149			MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET, params->end_offset,
   150			OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN, params->enable);
   151	}
   152	
   153	void optc2_set_gsl_source_select(
   154			struct timing_generator *optc,
   155			int group_idx,
   156			uint32_t gsl_ready_signal)
   157	{
   158		struct optc *optc1 = DCN10TG_FROM_TG(optc);
   159	
   160		switch (group_idx) {
   161		case 1:
   162			REG_UPDATE(GSL_SOURCE_SELECT, GSL0_READY_SOURCE_SEL, gsl_ready_signal);
   163			break;
   164		case 2:
   165			REG_UPDATE(GSL_SOURCE_SELECT, GSL1_READY_SOURCE_SEL, gsl_ready_signal);
   166			break;
   167		case 3:
   168			REG_UPDATE(GSL_SOURCE_SELECT, GSL2_READY_SOURCE_SEL, gsl_ready_signal);
   169			break;
   170		default:
   171			break;
   172		}
   173	}
   174	
   175	/* DSC encoder frame start controls: x = h position, line_num = # of lines from vstartup */
   176	void optc2_set_dsc_encoder_frame_start(struct timing_generator *optc,
   177						int x_position,
   178						int line_num)
   179	{
   180		struct optc *optc1 = DCN10TG_FROM_TG(optc);
   181	
   182		REG_SET_2(OTG_DSC_START_POSITION, 0,
   183				OTG_DSC_START_POSITION_X, x_position,
   184				OTG_DSC_START_POSITION_LINE_NUM, line_num);
   185	}
   186	
   187	/* Set DSC-related configuration.
   188	 *   dsc_mode: 0 disables DSC, other values enable DSC in specified format
   189	 *   sc_bytes_per_pixel: Bytes per pixel in u3.28 format
   190	 *   dsc_slice_width: Slice width in pixels
   191	 */
   192	void optc2_set_dsc_config(struct timing_generator *optc,
   193						enum optc_dsc_mode dsc_mode,
   194						uint32_t dsc_bytes_per_pixel,
   195						uint32_t dsc_slice_width)
   196	{
   197		struct optc *optc1 = DCN10TG_FROM_TG(optc);
   198	
   199		REG_UPDATE(OPTC_DATA_FORMAT_CONTROL,
   200			OPTC_DSC_MODE, dsc_mode);
   201	
   202		REG_SET(OPTC_BYTES_PER_PIXEL, 0,
   203			OPTC_DSC_BYTES_PER_PIXEL, dsc_bytes_per_pixel);
   204	
   205		REG_UPDATE(OPTC_WIDTH_CONTROL,
   206			OPTC_DSC_SLICE_WIDTH, dsc_slice_width);
   207	}
   208	
   209	/*TEMP: Need to figure out inheritance model here.*/
   210	bool optc2_is_two_pixels_per_containter(const struct dc_crtc_timing *timing)
   211	{
   212		return optc1_is_two_pixels_per_containter(timing);
   213	}
   214	
   215	void optc2_set_odm_bypass(struct timing_generator *optc,
   216			const struct dc_crtc_timing *dc_crtc_timing)
   217	{
   218		struct optc *optc1 = DCN10TG_FROM_TG(optc);
   219		uint32_t h_div_2 = 0;
   220	
   221		REG_SET_3(OPTC_DATA_SOURCE_SELECT, 0,
   222				OPTC_NUM_OF_INPUT_SEGMENT, 0,
   223				OPTC_SEG0_SRC_SEL, optc->inst,
   224				OPTC_SEG1_SRC_SEL, 0xf);
   225		REG_WRITE(OTG_H_TIMING_CNTL, 0);
   226	
   227		h_div_2 = optc2_is_two_pixels_per_containter(dc_crtc_timing);
   228		REG_UPDATE(OTG_H_TIMING_CNTL,
   229				OTG_H_TIMING_DIV_BY2, h_div_2);
   230		REG_SET(OPTC_MEMORY_CONFIG, 0,
   231				OPTC_MEM_SEL, 0);
   232		optc1->opp_count = 1;
   233	}
   234	
   235	void optc2_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_cnt,
   236			struct dc_crtc_timing *timing)
   237	{
   238		struct optc *optc1 = DCN10TG_FROM_TG(optc);
   239		int mpcc_hactive = (timing->h_addressable + timing->h_border_left + timing->h_border_right)
   240				/ opp_cnt;
   241		uint32_t memory_mask;
   242	
   243		ASSERT(opp_cnt == 2);
   244	
   245		/* TODO: In pseudocode but does not affect maximus, delete comment if we dont need on asic
   246		 * REG_SET(OTG_GLOBAL_CONTROL2, 0, GLOBAL_UPDATE_LOCK_EN, 1);
   247		 * Program OTG register MASTER_UPDATE_LOCK_DB_X/Y to the position before DP frame start
   248		 * REG_SET_2(OTG_GLOBAL_CONTROL1, 0,
   249		 *		MASTER_UPDATE_LOCK_DB_X, 160,
   250		 *		MASTER_UPDATE_LOCK_DB_Y, 240);
   251		 */
   252	
   253		/* 2 pieces of memory required for up to 5120 displays, 4 for up to 8192,
   254		 * however, for ODM combine we can simplify by always using 4.
   255		 * To make sure there's no overlap, each instance "reserves" 2 memories and
   256		 * they are uniquely combined here.
   257		 */
   258		memory_mask = 0x3 << (opp_id[0] * 2) | 0x3 << (opp_id[1] * 2);
   259	
   260		if (REG(OPTC_MEMORY_CONFIG))
   261			REG_SET(OPTC_MEMORY_CONFIG, 0,
   262				OPTC_MEM_SEL, memory_mask);
   263	
   264		REG_SET_3(OPTC_DATA_SOURCE_SELECT, 0,
   265				OPTC_NUM_OF_INPUT_SEGMENT, 1,
   266				OPTC_SEG0_SRC_SEL, opp_id[0],
   267				OPTC_SEG1_SRC_SEL, opp_id[1]);
   268	
   269		REG_UPDATE(OPTC_WIDTH_CONTROL,
   270				OPTC_SEGMENT_WIDTH, mpcc_hactive);
   271	
   272		REG_SET(OTG_H_TIMING_CNTL, 0, OTG_H_TIMING_DIV_BY2, 1);
   273		optc1->opp_count = opp_cnt;
   274	}
   275	
   276	void optc2_get_optc_source(struct timing_generator *optc,
   277			uint32_t *num_of_src_opp,
   278			uint32_t *src_opp_id_0,
   279			uint32_t *src_opp_id_1)
   280	{
   281		uint32_t num_of_input_segments;
   282		struct optc *optc1 = DCN10TG_FROM_TG(optc);
   283	
   284		REG_GET_3(OPTC_DATA_SOURCE_SELECT,
   285				OPTC_NUM_OF_INPUT_SEGMENT, &num_of_input_segments,
   286				OPTC_SEG0_SRC_SEL, src_opp_id_0,
   287				OPTC_SEG1_SRC_SEL, src_opp_id_1);
   288	
   289		if (num_of_input_segments == 1)
   290			*num_of_src_opp = 2;
   291		else
   292			*num_of_src_opp = 1;
   293	
   294		/* Work around VBIOS not updating OPTC_NUM_OF_INPUT_SEGMENT */
   295		if (*src_opp_id_1 == 0xf)
   296			*num_of_src_opp = 1;
   297	}
   298	
   299	void optc2_set_dwb_source(struct timing_generator *optc,
   300			uint32_t dwb_pipe_inst)
   301	{
   302		struct optc *optc1 = DCN10TG_FROM_TG(optc);
   303	
   304		if (dwb_pipe_inst == 0)
   305			REG_UPDATE(DWB_SOURCE_SELECT,
   306					OPTC_DWB0_SOURCE_SELECT, optc->inst);
   307		else if (dwb_pipe_inst == 1)
   308			REG_UPDATE(DWB_SOURCE_SELECT,
   309					OPTC_DWB1_SOURCE_SELECT, optc->inst);
   310	}
   311	
 > 312	void optc2_align_vblanks(
   313		struct timing_generator *optc_master,
   314		struct timing_generator *optc_slave,
   315		uint32_t master_pixel_clock_100Hz,
   316		uint32_t slave_pixel_clock_100Hz,
   317		uint8_t master_clock_divider,
   318		uint8_t slave_clock_divider)
   319	{
   320		/* accessing slave OTG registers */
   321		struct optc *optc1 = DCN10TG_FROM_TG(optc_slave);
   322	
   323		uint32_t master_v_active = 0;
   324		uint32_t master_h_total = 0;
   325		uint32_t slave_h_total = 0;
   326		uint64_t L, XY, p = 10000;
   327		uint32_t X, Y;
   328		uint32_t master_update_lock;
   329	
   330		/* disable slave OTG */
   331		REG_UPDATE(OTG_CONTROL, OTG_MASTER_EN, 0);
   332		/* wait until disabled */
   333		REG_WAIT(OTG_CONTROL,
   334				 OTG_CURRENT_MASTER_EN_STATE,
   335				 0, 10, 5000);
   336	
   337		REG_GET(OTG_H_TOTAL, OTG_H_TOTAL, &slave_h_total);
   338	
   339		/* assign slave OTG to be controlled by master update lock */
   340		REG_SET(OTG_GLOBAL_CONTROL0, 0,
   341				OTG_MASTER_UPDATE_LOCK_SEL, optc_master->inst);
   342	
   343		/* accessing master OTG registers */
   344		optc1 = DCN10TG_FROM_TG(optc_master);
   345	
   346		/* saving update lock state, not sure if it's needed */
   347		REG_GET(OTG_MASTER_UPDATE_LOCK,
   348				OTG_MASTER_UPDATE_LOCK, &master_update_lock);
   349		/* unlocking master OTG */
   350		REG_SET(OTG_MASTER_UPDATE_LOCK, 0,
   351				OTG_MASTER_UPDATE_LOCK, 0);
   352	
   353		REG_GET(OTG_V_BLANK_START_END,
   354				OTG_V_BLANK_START, &master_v_active);
   355		REG_GET(OTG_H_TOTAL, OTG_H_TOTAL, &master_h_total);
   356	
   357		/* calculate when to enable slave OTG */
   358		L = p * slave_h_total * master_pixel_clock_100Hz /
   359			master_h_total / slave_pixel_clock_100Hz;
   360		XY = L / p;
   361		Y = master_v_active - XY - 1;
   362		X = ((XY + 1) * p - L) * master_h_total / master_clock_divider / p;
   363	
   364		/*
   365		 * set master OTG to unlock when V/H
   366		 * counters reach calculated values
   367		 */
   368		REG_UPDATE(OTG_GLOBAL_CONTROL1,
   369				   MASTER_UPDATE_LOCK_DB_EN, 1);
   370		REG_UPDATE_2(OTG_GLOBAL_CONTROL1,
   371					 MASTER_UPDATE_LOCK_DB_X,
   372					 X,
   373					 MASTER_UPDATE_LOCK_DB_Y,
   374					 Y);
   375	
   376		/* lock master OTG */
   377		REG_SET(OTG_MASTER_UPDATE_LOCK, 0,
   378				OTG_MASTER_UPDATE_LOCK, 1);
   379		REG_WAIT(OTG_MASTER_UPDATE_LOCK,
   380				 UPDATE_LOCK_STATUS, 1, 1, 10);
   381	
   382		/* accessing slave OTG registers */
   383		optc1 = DCN10TG_FROM_TG(optc_slave);
   384	
   385		/*
   386		 * enable slave OTG, the OTG is locked with
   387		 * master's update lock, so it will not run
   388		 */
   389		REG_UPDATE(OTG_CONTROL,
   390				   OTG_MASTER_EN, 1);
   391	
   392		/* accessing master OTG registers */
   393		optc1 = DCN10TG_FROM_TG(optc_master);
   394	
   395		/*
   396		 * unlock master OTG. When master H/V counters reach
   397		 * DB_XY point, slave OTG will start
   398		 */
   399		REG_SET(OTG_MASTER_UPDATE_LOCK, 0,
   400				OTG_MASTER_UPDATE_LOCK, 0);
   401	
   402		/* accessing slave OTG registers */
   403		optc1 = DCN10TG_FROM_TG(optc_slave);
   404	
   405		/* wait for slave OTG to start running*/
   406		REG_WAIT(OTG_CONTROL,
   407				 OTG_CURRENT_MASTER_EN_STATE,
   408				 1, 10, 5000);
   409	
   410		/* accessing master OTG registers */
   411		optc1 = DCN10TG_FROM_TG(optc_master);
   412	
   413		/* disable the XY point*/
   414		REG_UPDATE(OTG_GLOBAL_CONTROL1,
   415				   MASTER_UPDATE_LOCK_DB_EN, 0);
   416		REG_UPDATE_2(OTG_GLOBAL_CONTROL1,
   417					 MASTER_UPDATE_LOCK_DB_X,
   418					 0,
   419					 MASTER_UPDATE_LOCK_DB_Y,
   420					 0);
   421	
   422		/*restore master update lock*/
   423		REG_SET(OTG_MASTER_UPDATE_LOCK, 0,
   424				OTG_MASTER_UPDATE_LOCK, master_update_lock);
   425	
   426		/* accessing slave OTG registers */
   427		optc1 = DCN10TG_FROM_TG(optc_slave);
   428		/* restore slave to be controlled by it's own */
   429		REG_SET(OTG_GLOBAL_CONTROL0, 0,
   430				OTG_MASTER_UPDATE_LOCK_SEL, optc_slave->inst);
   431	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

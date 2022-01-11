Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F300448A4DD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 02:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346167AbiAKBSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 20:18:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:20990 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243319AbiAKBSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 20:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641863900; x=1673399900;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C5cHiGuW0bAg5BlNFMKHwoTsXilSzwzw7R4rBfqFS/8=;
  b=HzvotJU3zhgHbQoz0Wc2a3ZJHMDYn4h8mHGwK5pOsznkp9CLcDZ3BaYM
   M+qT0k5bftqtqE3cufoDWF3OfDhIpGnZvPDvZVFAfTAowERjCdb9inFJw
   EzmRFFVKu1cCQbOiU5xaaElpyOSzSRehUQspUQ705EWVZ6jWg7kIUnxJR
   DbJn/L+XP56+eKS/AarKkr/v7NzhN5mOBkOWRMH0kdoNaqLvEqHMKLUbZ
   A6S99v6lP2YZbi6JwvUsjEcDc96N1zQY3ixgqQ5SIToN5w/WSDQVGQx5p
   UFvcditirmG6T8SeyfFeVm7N+QhgBMGF40sbzLq58YoZlE7lgW4zv9Cjw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="223358264"
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="223358264"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 17:18:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="690795429"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Jan 2022 17:18:18 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n75nm-0004AL-2Z; Tue, 11 Jan 2022 01:18:18 +0000
Date:   Tue, 11 Jan 2022 09:17:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vladimir Stempen <vladimir.stempen@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:312:6:
 warning: no previous prototype for function 'optc2_align_vblanks'
Message-ID: <202201110905.3Bccc77f-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8d0749b4f83bf4768ceae45ee6a79e6e7eddfc2a
commit: 77a2b7265f20ee827e527eaa6f82b87e88388947 drm/amd/display: Synchronize displays with different timings
date:   11 months ago
config: i386-randconfig-a015-20210927 (https://download.01.org/0day-ci/archive/20220111/202201110905.3Bccc77f-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dc6e8dfdfe7efecfda318d43a06fae18b40eb498)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=77a2b7265f20ee827e527eaa6f82b87e88388947
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 77a2b7265f20ee827e527eaa6f82b87e88388947
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:80:6: warning: no previous prototype for function 'optc2_set_timing_db_mode' [-Wmissing-prototypes]
   void optc2_set_timing_db_mode(struct timing_generator *optc, bool enable)
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:80:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void optc2_set_timing_db_mode(struct timing_generator *optc, bool enable)
   ^
   static 
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:114:6: warning: no previous prototype for function 'optc2_use_gsl_as_master_update_lock' [-Wmissing-prototypes]
   void optc2_use_gsl_as_master_update_lock(struct timing_generator *optc,
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:114:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void optc2_use_gsl_as_master_update_lock(struct timing_generator *optc,
   ^
   static 
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:124:6: warning: no previous prototype for function 'optc2_set_gsl_window' [-Wmissing-prototypes]
   void optc2_set_gsl_window(struct timing_generator *optc,
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:124:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void optc2_set_gsl_window(struct timing_generator *optc,
   ^
   static 
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:142:6: warning: no previous prototype for function 'optc2_set_vupdate_keepout' [-Wmissing-prototypes]
   void optc2_set_vupdate_keepout(struct timing_generator *optc,
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:142:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void optc2_set_vupdate_keepout(struct timing_generator *optc,
   ^
   static 
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:176:6: warning: no previous prototype for function 'optc2_set_dsc_encoder_frame_start' [-Wmissing-prototypes]
   void optc2_set_dsc_encoder_frame_start(struct timing_generator *optc,
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:176:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void optc2_set_dsc_encoder_frame_start(struct timing_generator *optc,
   ^
   static 
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:299:6: warning: no previous prototype for function 'optc2_set_dwb_source' [-Wmissing-prototypes]
   void optc2_set_dwb_source(struct timing_generator *optc,
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:299:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void optc2_set_dwb_source(struct timing_generator *optc,
   ^
   static 
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:312:6: warning: no previous prototype for function 'optc2_align_vblanks' [-Wmissing-prototypes]
   void optc2_align_vblanks(
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:312:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void optc2_align_vblanks(
   ^
   static 
   7 warnings generated.
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:74:6: warning: no previous prototype for function 'print_microsec' [-Wmissing-prototypes]
   void print_microsec(struct dc_context *dc_ctx,
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:74:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void print_microsec(struct dc_context *dc_ctx,
   ^
   static 
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:129:6: warning: no previous prototype for function 'dcn10_log_hubbub_state' [-Wmissing-prototypes]
   void dcn10_log_hubbub_state(struct dc *dc, struct dc_log_buffer_ctx *log_ctx)
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:129:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void dcn10_log_hubbub_state(struct dc *dc, struct dc_log_buffer_ctx *log_ctx)
   ^
   static 
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1854:10: warning: no previous prototype for function 'reduceSizeAndFraction' [-Wmissing-prototypes]
   uint64_t reduceSizeAndFraction(
            ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1854:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   uint64_t reduceSizeAndFraction(
   ^
   static 
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1900:6: warning: no previous prototype for function 'is_low_refresh_rate' [-Wmissing-prototypes]
   bool is_low_refresh_rate(struct pipe_ctx *pipe)
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1900:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool is_low_refresh_rate(struct pipe_ctx *pipe)
   ^
   static 
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1909:9: warning: no previous prototype for function 'get_clock_divider' [-Wmissing-prototypes]
   uint8_t get_clock_divider(struct pipe_ctx *pipe, bool account_low_refresh_rate)
           ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1909:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   uint8_t get_clock_divider(struct pipe_ctx *pipe, bool account_low_refresh_rate)
   ^
   static 
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1944:7: warning: variable 'clamshell_closed' set but not used [-Wunused-but-set-variable]
           bool clamshell_closed = false;
                ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1929:5: warning: no previous prototype for function 'dcn10_align_pixel_clocks' [-Wmissing-prototypes]
   int dcn10_align_pixel_clocks(
       ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1929:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int dcn10_align_pixel_clocks(
   ^
   static 
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2344:6: warning: no previous prototype for function 'dcn10_program_pte_vm' [-Wmissing-prototypes]
   void dcn10_program_pte_vm(struct dce_hwseq *hws, struct hubp *hubp)
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2344:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void dcn10_program_pte_vm(struct dce_hwseq *hws, struct hubp *hubp)
   ^
   static 
   8 warnings generated.


vim +/optc2_align_vblanks +312 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c

   298	
 > 299	void optc2_set_dwb_source(struct timing_generator *optc,
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

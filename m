Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D615756B7AA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbiGHKsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237797AbiGHKst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:48:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9632E60694
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 03:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657277326; x=1688813326;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ggtEcwhHADhpXUqxV1M+XvDmWc7qViSugtw86h2y0iw=;
  b=VeT6wTPLAPWWU0PMtJjXo2McK7HXFwvjZUqChm+nfpaPx5CCdlwnB3PZ
   SAgz3pWRRzxtpHgJfb/Oim/djwB11OGvrh/C072E42YZ5TxBFucEKxCaL
   fXgqARmzXWo3LiIfSv5e1xRMulftInI9fPglZz97fUIMEGxPfgjOCkpSd
   l9fkr6F93KYfBFWXpBCloj7l0e3ApxaBBKivrb5HfqgkaKM93ZE8cEcgX
   ruVytBNbAOtyyX+cgNLGNoi1UHDB52in1Cf8dZW9imyqlBX9GcuTKvYYB
   v4FrXLKZK0+PJnjz2ix20i21OIqiM+QGF5naH+IJVORGKJQIAzDZCseST
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="285382013"
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="285382013"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 03:48:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="920957156"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jul 2022 03:48:44 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9lXP-000NMQ-KW;
        Fri, 08 Jul 2022 10:48:43 +0000
Date:   Fri, 8 Jul 2022 18:48:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [agd5f:drm-next 350/403]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:273:9: warning: no
 previous prototype for function 'dc_dmub_srv_get_pipes_for_stream'
Message-ID: <202207081827.vQ4rn2g8-lkp@intel.com>
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
head:   51d10e1a9912e950abf19b6314f3d6f95dd16af3
commit: 00fa7f031dd4b885175da390e24cb02f6a45977e [350/403] drm/amd/display: Add basic infrastructure for enabling FAMS
config: riscv-randconfig-r006-20220707 (https://download.01.org/0day-ci/archive/20220708/202207081827.vQ4rn2g8-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 562c3467a6738aa89203f72fc1d1343e5baadf3c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 00fa7f031dd4b885175da390e24cb02f6a45977e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:273:9: warning: no previous prototype for function 'dc_dmub_srv_get_pipes_for_stream' [-Wmissing-prototypes]
   uint8_t dc_dmub_srv_get_pipes_for_stream(struct dc *dc, struct dc_stream_state *stream)
           ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:273:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   uint8_t dc_dmub_srv_get_pipes_for_stream(struct dc *dc, struct dc_stream_state *stream)
   ^
   static 
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:287:5: warning: no previous prototype for function 'dc_dmub_srv_get_timing_generator_offset' [-Wmissing-prototypes]
   int dc_dmub_srv_get_timing_generator_offset(struct dc *dc, struct dc_stream_state *stream)
       ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:287:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int dc_dmub_srv_get_timing_generator_offset(struct dc *dc, struct dc_stream_state *stream)
   ^
   static 
   drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:636:6: warning: no previous prototype for function 'dc_dmub_setup_subvp_dmub_command' [-Wmissing-prototypes]
   void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:636:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
   ^
   static 
   3 warnings generated.


vim +/dc_dmub_srv_get_pipes_for_stream +273 drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c

   272	
 > 273	uint8_t dc_dmub_srv_get_pipes_for_stream(struct dc *dc, struct dc_stream_state *stream)
   274	{
   275		uint8_t pipes = 0;
   276		int i = 0;
   277	
   278		for (i = 0; i < MAX_PIPES; i++) {
   279			struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
   280	
   281			if (pipe->stream == stream && pipe->stream_res.tg)
   282				pipes = i;
   283		}
   284		return pipes;
   285	}
   286	
 > 287	int dc_dmub_srv_get_timing_generator_offset(struct dc *dc, struct dc_stream_state *stream)
   288	{
   289		int  tg_inst = 0;
   290		int i = 0;
   291	
   292		for (i = 0; i < MAX_PIPES; i++) {
   293			struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
   294	
   295			if (pipe->stream == stream && pipe->stream_res.tg) {
   296				tg_inst = pipe->stream_res.tg->inst;
   297				break;
   298			}
   299		}
   300		return tg_inst;
   301	}
   302	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

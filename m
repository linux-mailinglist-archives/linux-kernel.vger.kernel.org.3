Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E18B567BA5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 03:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiGFBpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 21:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGFBpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 21:45:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17999DFC2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 18:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657071909; x=1688607909;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aAaO1oTqtvjwZldxD1BmTgpYIX8x13Vm3tEzJAU3Ckc=;
  b=WM+3cmhpKMcNm364HTyqfoYwTSm9OVxHnBKNV6iBQP8nEEdGUQ+5dS2i
   VUxFntmd6xLmOBpSCOyefIYaUR+TFNR74TzImYShzsAZG2dvnXJ8ltpOW
   EoCnNqP4O6wZT1M2NlRFjAinWznWG9k7VNo8TYKFeGIGNM2pMwpKmpVbe
   gW61CMPcXEWk24YT4ME3iNqZnorJwYX8iCM6r0PiQP/rLW98O/4ed3Ajn
   agVL3v08mzI5xqdl9TYWfqrTlIQaqbffIm4TuuXI94z2dH49JQ08LPfqa
   hZjuNfHauM4JxfUlkVNUD3szAwX0TH2gik3CWZgF5uHLwQvrShLaevnUj
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="284730683"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="284730683"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 18:45:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="650431181"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jul 2022 18:45:06 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8u6D-000JoA-G5;
        Wed, 06 Jul 2022 01:45:05 +0000
Date:   Wed, 6 Jul 2022 09:44:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alvin Lee <Alvin.Lee2@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Jun Lei <Jun.Lei@amd.com>
Subject: [agd5f:drm-next 341/388]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hwseq.c:428:33:
 warning: variable 'old_pipe' set but not used
Message-ID: <202207060929.RfKy9h57-lkp@intel.com>
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
head:   fc25fd602b1e101a45650475a8d2f00d7bb8e971
commit: 85f4bc0c333ceed24cbc9f69a2a77fab1ae3d4d1 [341/388] drm/amd/display: Add SubVP required code
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220706/202207060929.RfKy9h57-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 85f4bc0c333ceed24cbc9f69a2a77fab1ae3d4d1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hwseq.c: In function 'dcn32_subvp_pipe_control_lock':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hwseq.c:428:33: warning: variable 'old_pipe' set but not used [-Wunused-but-set-variable]
     428 |         struct pipe_ctx *pipe, *old_pipe;
         |                                 ^~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hwseq.c:29:
   At top level:
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
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:47:6: warning: no previous prototype for 'dcn32_helper_populate_phantom_dlg_params' [-Wmissing-prototypes]
      47 | void dcn32_helper_populate_phantom_dlg_params(struct dc *dc,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:27:
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


vim +/old_pipe +428 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hwseq.c

   410	
   411	/* Sub-Viewport DMUB lock needs to be acquired by driver whenever SubVP is active and:
   412	 * 1. Any full update for any SubVP main pipe
   413	 * 2. Any immediate flip for any SubVP pipe
   414	 * 3. Any flip for DRR pipe
   415	 * 4. If SubVP was previously in use (i.e. in old context)
   416	 */
   417	void dcn32_subvp_pipe_control_lock(struct dc *dc,
   418			struct dc_state *context,
   419			bool lock,
   420			bool should_lock_all_pipes,
   421			struct pipe_ctx *top_pipe_to_program,
   422			bool subvp_prev_use)
   423	{
   424		unsigned int i = 0;
   425		bool subvp_immediate_flip = false;
   426		bool subvp_in_use = false;
   427		bool drr_pipe = false;
 > 428		struct pipe_ctx *pipe, *old_pipe;
   429	
   430		for (i = 0; i < dc->res_pool->pipe_count; i++) {
   431			pipe = &context->res_ctx.pipe_ctx[i];
   432			old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
   433	
   434			if (pipe->stream && pipe->plane_state && pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
   435				subvp_in_use = true;
   436				break;
   437			}
   438		}
   439	
   440		if (top_pipe_to_program && top_pipe_to_program->stream && top_pipe_to_program->plane_state) {
   441			if (top_pipe_to_program->stream->mall_stream_config.type == SUBVP_MAIN &&
   442					top_pipe_to_program->plane_state->flip_immediate)
   443				subvp_immediate_flip = true;
   444			else if (top_pipe_to_program->stream->mall_stream_config.type == SUBVP_NONE &&
   445					top_pipe_to_program->stream->ignore_msa_timing_param)
   446				drr_pipe = true;
   447		}
   448	
   449		if ((subvp_in_use && (should_lock_all_pipes || subvp_immediate_flip || drr_pipe)) || (!subvp_in_use && subvp_prev_use)) {
   450			union dmub_inbox0_cmd_lock_hw hw_lock_cmd = { 0 };
   451	
   452			if (!lock) {
   453				for (i = 0; i < dc->res_pool->pipe_count; i++) {
   454					pipe = &context->res_ctx.pipe_ctx[i];
   455					if (pipe->stream && pipe->plane_state && pipe->stream->mall_stream_config.type == SUBVP_MAIN &&
   456							should_lock_all_pipes)
   457						pipe->stream_res.tg->funcs->wait_for_state(pipe->stream_res.tg, CRTC_STATE_VBLANK);
   458				}
   459			}
   460	
   461			hw_lock_cmd.bits.command_code = DMUB_INBOX0_CMD__HW_LOCK;
   462			hw_lock_cmd.bits.hw_lock_client = HW_LOCK_CLIENT_DRIVER;
   463			hw_lock_cmd.bits.lock = lock;
   464			hw_lock_cmd.bits.should_release = !lock;
   465			dmub_hw_lock_mgr_inbox0_cmd(dc->ctx->dmub_srv, hw_lock_cmd);
   466		}
   467	}
   468	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44675523E91
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347589AbiEKUN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbiEKUNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:13:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9E85AECE
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652300000; x=1683836000;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=AOhFH6pgcjpEL9BTzlZIHkgfzq/lFtQxUWN7/SRaZKc=;
  b=W7+AR58tXbQF4WyA0xZhorx/pUYh6WpEUm2RFKZcPMJ/YTU8jh2sYZdh
   Cw3+LaqYE2Yb43ohZEm9XTdQbCIndk3iK4PYEeMQ0phFsSCqVRSNi/iwG
   jkuhG8f3E8SLZfPCc8JA/QCnAZ8+/u87/cjTwfypVjECCEeT6a8GSgGRy
   DPlzArzoP6cDc0ge8pT6tVBcB9g7uEe8io18+LyMarxlx4S18XSKrL6/v
   IYTLc9HQ8OAQEQL1t8hw0CerqC+z8VrPPTHjtdEWaZdVSzujz7hYU+Qmt
   Z9c7fuXM0RWzWEIVxAc+1aNCp3KKBKd6HVKEaR6WRSa3TSsFM+GX65xst
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="250332065"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="250332065"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 13:13:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="739371833"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 11 May 2022 13:13:18 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noshx-000JWm-Ds;
        Wed, 11 May 2022 20:13:17 +0000
Date:   Thu, 12 May 2022 04:12:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [drm-misc:drm-misc-next 1/1]
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9169:27:
 warning: variable 'abo' set but not used
Message-ID: <202205120444.5SGukZOQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
head:   aebeb02dfccb61d6930112aede2db3db5b8e974e
commit: 047de3f17a8321065c32ee3f6272a6dba16d6bcf [1/1] drm/amdgpu: switch DM to atomic fence helpers v2
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220512/202205120444.5SGukZOQ-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc drm-misc-next
        git checkout 047de3f17a8321065c32ee3f6272a6dba16d6bcf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function 'amdgpu_dm_commit_planes':
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9169:27: warning: variable 'abo' set but not used [-Wunused-but-set-variable]
    9169 |         struct amdgpu_bo *abo;
         |                           ^~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/link_enc_cfg.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:32:
   At top level:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:129:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     129 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:126:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     126 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:125:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     125 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/abo +9169 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c

8ad278062de4ea Nicholas Kazlauskas 2019-04-08  9149  
3be5262e353b8a Harry Wentland      2017-07-27  9150  static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
eb3dc8978596a0 Nicholas Kazlauskas 2018-11-22  9151  				    struct dc_state *dc_state,
e7b07ceef2a650 Harry Wentland      2017-08-10  9152  				    struct drm_device *dev,
e7b07ceef2a650 Harry Wentland      2017-08-10  9153  				    struct amdgpu_display_manager *dm,
e7b07ceef2a650 Harry Wentland      2017-08-10  9154  				    struct drm_crtc *pcrtc,
420cd472082697 David Francis       2019-03-01  9155  				    bool wait_for_vblank)
e7b07ceef2a650 Harry Wentland      2017-08-10  9156  {
efc8278eecfd5e Anson Jacob         2021-02-18  9157  	uint32_t i;
8a48b44cd00f10 David Francis       2018-12-11  9158  	uint64_t timestamp_ns;
e7b07ceef2a650 Harry Wentland      2017-08-10  9159  	struct drm_plane *plane;
0bc9706db3a35b Leo (Sunpeng  Li    2017-10-12  9160) 	struct drm_plane_state *old_plane_state, *new_plane_state;
e7b07ceef2a650 Harry Wentland      2017-08-10  9161  	struct amdgpu_crtc *acrtc_attach = to_amdgpu_crtc(pcrtc);
0bc9706db3a35b Leo (Sunpeng  Li    2017-10-12  9162) 	struct drm_crtc_state *new_pcrtc_state =
0bc9706db3a35b Leo (Sunpeng  Li    2017-10-12  9163) 			drm_atomic_get_new_crtc_state(state, pcrtc);
0bc9706db3a35b Leo (Sunpeng  Li    2017-10-12  9164) 	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(new_pcrtc_state);
44d09c6a577c8e Harry Wentland      2018-03-15  9165  	struct dm_crtc_state *dm_old_crtc_state =
44d09c6a577c8e Harry Wentland      2018-03-15  9166  			to_dm_crtc_state(drm_atomic_get_old_crtc_state(state, pcrtc));
74aa7bd4c6f774 David Francis       2019-03-01  9167  	int planes_count = 0, vpos, hpos;
e7b07ceef2a650 Harry Wentland      2017-08-10  9168  	unsigned long flags;
8a48b44cd00f10 David Francis       2018-12-11 @9169  	struct amdgpu_bo *abo;
fdd1fe57c00ef9 Mario Kleiner       2019-04-02  9170  	uint32_t target_vblank, last_flip_vblank;
fdd1fe57c00ef9 Mario Kleiner       2019-04-02  9171  	bool vrr_active = amdgpu_dm_vrr_active(acrtc_state);
74aa7bd4c6f774 David Francis       2019-03-01  9172  	bool pflip_present = false;
bc7f670ee04cd6 David Francis       2018-12-19  9173  	struct {
bc7f670ee04cd6 David Francis       2018-12-19  9174  		struct dc_surface_update surface_updates[MAX_SURFACES];
bc7f670ee04cd6 David Francis       2018-12-19  9175  		struct dc_plane_info plane_infos[MAX_SURFACES];
bc7f670ee04cd6 David Francis       2018-12-19  9176  		struct dc_scaling_info scaling_infos[MAX_SURFACES];
74aa7bd4c6f774 David Francis       2019-03-01  9177  		struct dc_flip_addrs flip_addrs[MAX_SURFACES];
bc7f670ee04cd6 David Francis       2018-12-19  9178  		struct dc_stream_update stream_update;
74aa7bd4c6f774 David Francis       2019-03-01  9179  	} *bundle;
bc7f670ee04cd6 David Francis       2018-12-19  9180  
74aa7bd4c6f774 David Francis       2019-03-01  9181  	bundle = kzalloc(sizeof(*bundle), GFP_KERNEL);
8a48b44cd00f10 David Francis       2018-12-11  9182  
74aa7bd4c6f774 David Francis       2019-03-01  9183  	if (!bundle) {
74aa7bd4c6f774 David Francis       2019-03-01  9184  		dm_error("Failed to allocate update bundle\n");
4b5105036afbd2 Nicholas Kazlauskas 2019-01-28  9185  		goto cleanup;
4b5105036afbd2 Nicholas Kazlauskas 2019-01-28  9186  	}
e7b07ceef2a650 Harry Wentland      2017-08-10  9187  
8ad278062de4ea Nicholas Kazlauskas 2019-04-08  9188  	/*
8ad278062de4ea Nicholas Kazlauskas 2019-04-08  9189  	 * Disable the cursor first if we're disabling all the planes.
8ad278062de4ea Nicholas Kazlauskas 2019-04-08  9190  	 * It'll remain on the screen after the planes are re-enabled
8ad278062de4ea Nicholas Kazlauskas 2019-04-08  9191  	 * if we don't.
8ad278062de4ea Nicholas Kazlauskas 2019-04-08  9192  	 */
8ad278062de4ea Nicholas Kazlauskas 2019-04-08  9193  	if (acrtc_state->active_planes == 0)
8ad278062de4ea Nicholas Kazlauskas 2019-04-08  9194  		amdgpu_dm_commit_cursors(state);
8ad278062de4ea Nicholas Kazlauskas 2019-04-08  9195  
e7b07ceef2a650 Harry Wentland      2017-08-10  9196  	/* update planes when needed */
efc8278eecfd5e Anson Jacob         2021-02-18  9197  	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
0bc9706db3a35b Leo (Sunpeng  Li    2017-10-12  9198) 		struct drm_crtc *crtc = new_plane_state->crtc;
f5ba60fefa00ca Drew Davenport      2017-10-27  9199  		struct drm_crtc_state *new_crtc_state;
0bc9706db3a35b Leo (Sunpeng  Li    2017-10-12  9200) 		struct drm_framebuffer *fb = new_plane_state->fb;
6eed95b00b45ca Bas Nieuwenhuizen   2020-09-02  9201  		struct amdgpu_framebuffer *afb = (struct amdgpu_framebuffer *)fb;
34bafd27e3429f David Francis       2019-02-06  9202  		bool plane_needs_flip;
c7af5f77aecdfe Nicholas Kazlauskas 2019-01-10  9203  		struct dc_plane_state *dc_plane;
54d76575246798 Leo (Sunpeng  Li    2017-10-12  9204) 		struct dm_plane_state *dm_new_plane_state = to_dm_plane_state(new_plane_state);
e7b07ceef2a650 Harry Wentland      2017-08-10  9205  
80c218d56e309d Nicholas Kazlauskas 2019-01-25  9206  		/* Cursor plane is handled after stream updates */
80c218d56e309d Nicholas Kazlauskas 2019-01-25  9207  		if (plane->type == DRM_PLANE_TYPE_CURSOR)
e7b07ceef2a650 Harry Wentland      2017-08-10  9208  			continue;
e7b07ceef2a650 Harry Wentland      2017-08-10  9209  
f5ba60fefa00ca Drew Davenport      2017-10-27  9210  		if (!fb || !crtc || pcrtc != crtc)
f5ba60fefa00ca Drew Davenport      2017-10-27  9211  			continue;
f5ba60fefa00ca Drew Davenport      2017-10-27  9212  
f5ba60fefa00ca Drew Davenport      2017-10-27  9213  		new_crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
f5ba60fefa00ca Drew Davenport      2017-10-27  9214  		if (!new_crtc_state->active)
e7b07ceef2a650 Harry Wentland      2017-08-10  9215  			continue;
e7b07ceef2a650 Harry Wentland      2017-08-10  9216  
bc7f670ee04cd6 David Francis       2018-12-19  9217  		dc_plane = dm_new_plane_state->dc_state;
e7b07ceef2a650 Harry Wentland      2017-08-10  9218  
f5031000603fc5 David Francis       2019-02-13  9219  		bundle->surface_updates[planes_count].surface = dc_plane;
f5031000603fc5 David Francis       2019-02-13  9220  		if (new_pcrtc_state->color_mgmt_changed) {
f5031000603fc5 David Francis       2019-02-13  9221  			bundle->surface_updates[planes_count].gamma = dc_plane->gamma_correction;
f5031000603fc5 David Francis       2019-02-13  9222  			bundle->surface_updates[planes_count].in_transfer_func = dc_plane->in_transfer_func;
44efb784108200 Stylon Wang         2020-03-26  9223  			bundle->surface_updates[planes_count].gamut_remap_matrix = &dc_plane->gamut_remap_matrix;
f5031000603fc5 David Francis       2019-02-13  9224  		}
f5031000603fc5 David Francis       2019-02-13  9225  
4375d6255d0534 Shirish S           2021-11-08  9226  		fill_dc_scaling_info(dm->adev, new_plane_state,
695af5f9a51914 Nicholas Kazlauskas 2019-03-28  9227  				     &bundle->scaling_infos[planes_count]);
f5031000603fc5 David Francis       2019-02-13  9228  
695af5f9a51914 Nicholas Kazlauskas 2019-03-28  9229  		bundle->surface_updates[planes_count].scaling_info =
695af5f9a51914 Nicholas Kazlauskas 2019-03-28  9230  			&bundle->scaling_infos[planes_count];
f5031000603fc5 David Francis       2019-02-13  9231  
34bafd27e3429f David Francis       2019-02-06  9232  		plane_needs_flip = old_plane_state->fb && new_plane_state->fb;
e7b07ceef2a650 Harry Wentland      2017-08-10  9233  
34bafd27e3429f David Francis       2019-02-06  9234  		pflip_present = pflip_present || plane_needs_flip;
e7b07ceef2a650 Harry Wentland      2017-08-10  9235  
f5031000603fc5 David Francis       2019-02-13  9236  		if (!plane_needs_flip) {
f5031000603fc5 David Francis       2019-02-13  9237  			planes_count += 1;
f5031000603fc5 David Francis       2019-02-13  9238  			continue;
f5031000603fc5 David Francis       2019-02-13  9239  		}
8a48b44cd00f10 David Francis       2018-12-11  9240  
2fac0f53fe5921 Christian König     2019-04-02  9241  		abo = gem_to_amdgpu_bo(fb->obj[0]);
695af5f9a51914 Nicholas Kazlauskas 2019-03-28  9242  		fill_dc_plane_info_and_addr(
8ce5d8425d39eb Nicholas Kazlauskas 2020-08-06  9243  			dm->adev, new_plane_state,
6eed95b00b45ca Bas Nieuwenhuizen   2020-09-02  9244  			afb->tiling_flags,
695af5f9a51914 Nicholas Kazlauskas 2019-03-28  9245  			&bundle->plane_infos[planes_count],
87b7ebc2e16c14 Rodrigo Siqueira    2020-04-22  9246  			&bundle->flip_addrs[planes_count].address,
6eed95b00b45ca Bas Nieuwenhuizen   2020-09-02  9247  			afb->tmz_surface, false);
87b7ebc2e16c14 Rodrigo Siqueira    2020-04-22  9248  
9f07550b3c8a79 Sean Paul           2022-03-25  9249  		drm_dbg_state(state->dev, "plane: id=%d dcc_en=%d\n",
87b7ebc2e16c14 Rodrigo Siqueira    2020-04-22  9250  				 new_plane_state->plane->index,
87b7ebc2e16c14 Rodrigo Siqueira    2020-04-22  9251  				 bundle->plane_infos[planes_count].dcc.enable);
695af5f9a51914 Nicholas Kazlauskas 2019-03-28  9252  
695af5f9a51914 Nicholas Kazlauskas 2019-03-28  9253  		bundle->surface_updates[planes_count].plane_info =
695af5f9a51914 Nicholas Kazlauskas 2019-03-28  9254  			&bundle->plane_infos[planes_count];
8a48b44cd00f10 David Francis       2018-12-11  9255  
caff0e6654377b Nicholas Kazlauskas 2019-08-02  9256  		/*
caff0e6654377b Nicholas Kazlauskas 2019-08-02  9257  		 * Only allow immediate flips for fast updates that don't
caff0e6654377b Nicholas Kazlauskas 2019-08-02  9258  		 * change FB pitch, DCC state, rotation or mirroing.
caff0e6654377b Nicholas Kazlauskas 2019-08-02  9259  		 */
74aa7bd4c6f774 David Francis       2019-03-01  9260  		bundle->flip_addrs[planes_count].flip_immediate =
4d85f45c73a22b Daniel Vetter       2019-09-03  9261  			crtc->state->async_flip &&
caff0e6654377b Nicholas Kazlauskas 2019-08-02  9262  			acrtc_state->update_type == UPDATE_TYPE_FAST;
8a48b44cd00f10 David Francis       2018-12-11  9263  
8a48b44cd00f10 David Francis       2018-12-11  9264  		timestamp_ns = ktime_get_ns();
74aa7bd4c6f774 David Francis       2019-03-01  9265  		bundle->flip_addrs[planes_count].flip_timestamp_in_us = div_u64(timestamp_ns, 1000);
74aa7bd4c6f774 David Francis       2019-03-01  9266  		bundle->surface_updates[planes_count].flip_addr = &bundle->flip_addrs[planes_count];
74aa7bd4c6f774 David Francis       2019-03-01  9267  		bundle->surface_updates[planes_count].surface = dc_plane;
8a48b44cd00f10 David Francis       2018-12-11  9268  
74aa7bd4c6f774 David Francis       2019-03-01  9269  		if (!bundle->surface_updates[planes_count].surface) {
8a48b44cd00f10 David Francis       2018-12-11  9270  			DRM_ERROR("No surface for CRTC: id=%d\n",
8a48b44cd00f10 David Francis       2018-12-11  9271  					acrtc_attach->crtc_id);
8a48b44cd00f10 David Francis       2018-12-11  9272  			continue;
8a48b44cd00f10 David Francis       2018-12-11  9273  		}
8a48b44cd00f10 David Francis       2018-12-11  9274  
c7af5f77aecdfe Nicholas Kazlauskas 2019-01-10  9275  		if (plane == pcrtc->primary)
8a48b44cd00f10 David Francis       2018-12-11  9276  			update_freesync_state_on_stream(
8a48b44cd00f10 David Francis       2018-12-11  9277  				dm,
8a48b44cd00f10 David Francis       2018-12-11  9278  				acrtc_state,
8a48b44cd00f10 David Francis       2018-12-11  9279  				acrtc_state->stream,
c7af5f77aecdfe Nicholas Kazlauskas 2019-01-10  9280  				dc_plane,
74aa7bd4c6f774 David Francis       2019-03-01  9281  				bundle->flip_addrs[planes_count].flip_timestamp_in_us);
8a48b44cd00f10 David Francis       2018-12-11  9282  
9f07550b3c8a79 Sean Paul           2022-03-25  9283  		drm_dbg_state(state->dev, "%s Flipping to hi: 0x%x, low: 0x%x\n",
8a48b44cd00f10 David Francis       2018-12-11  9284  				 __func__,
74aa7bd4c6f774 David Francis       2019-03-01  9285  				 bundle->flip_addrs[planes_count].address.grph.addr.high_part,
74aa7bd4c6f774 David Francis       2019-03-01  9286  				 bundle->flip_addrs[planes_count].address.grph.addr.low_part);
bc7f670ee04cd6 David Francis       2018-12-19  9287  
bc7f670ee04cd6 David Francis       2018-12-19  9288  		planes_count += 1;
bc7f670ee04cd6 David Francis       2018-12-19  9289  
bc7f670ee04cd6 David Francis       2018-12-19  9290  	}
bc7f670ee04cd6 David Francis       2018-12-19  9291  
74aa7bd4c6f774 David Francis       2019-03-01  9292  	if (pflip_present) {
634092b1b9f67b Mario Kleiner       2019-02-09  9293  		if (!vrr_active) {
634092b1b9f67b Mario Kleiner       2019-02-09  9294  			/* Use old throttling in non-vrr fixed refresh rate mode
634092b1b9f67b Mario Kleiner       2019-02-09  9295  			 * to keep flip scheduling based on target vblank counts
634092b1b9f67b Mario Kleiner       2019-02-09  9296  			 * working in a backwards compatible way, e.g., for
634092b1b9f67b Mario Kleiner       2019-02-09  9297  			 * clients using the GLX_OML_sync_control extension or
634092b1b9f67b Mario Kleiner       2019-02-09  9298  			 * DRI3/Present extension with defined target_msc.
634092b1b9f67b Mario Kleiner       2019-02-09  9299  			 */
e3eff4b5d91e0e Thomas Zimmermann   2020-01-23  9300  			last_flip_vblank = amdgpu_get_vblank_counter_kms(pcrtc);
634092b1b9f67b Mario Kleiner       2019-02-09  9301  		}
634092b1b9f67b Mario Kleiner       2019-02-09  9302  		else {
634092b1b9f67b Mario Kleiner       2019-02-09  9303  			/* For variable refresh rate mode only:
634092b1b9f67b Mario Kleiner       2019-02-09  9304  			 * Get vblank of last completed flip to avoid > 1 vrr
634092b1b9f67b Mario Kleiner       2019-02-09  9305  			 * flips per video frame by use of throttling, but allow
634092b1b9f67b Mario Kleiner       2019-02-09  9306  			 * flip programming anywhere in the possibly large
634092b1b9f67b Mario Kleiner       2019-02-09  9307  			 * variable vrr vblank interval for fine-grained flip
634092b1b9f67b Mario Kleiner       2019-02-09  9308  			 * timing control and more opportunity to avoid stutter
634092b1b9f67b Mario Kleiner       2019-02-09  9309  			 * on late submission of flips.
634092b1b9f67b Mario Kleiner       2019-02-09  9310  			 */
634092b1b9f67b Mario Kleiner       2019-02-09  9311  			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
5d1c59c47997e9 Aurabindo Pillai    2020-08-12  9312  			last_flip_vblank = acrtc_attach->dm_irq_params.last_flip_vblank;
634092b1b9f67b Mario Kleiner       2019-02-09  9313  			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
634092b1b9f67b Mario Kleiner       2019-02-09  9314  		}
634092b1b9f67b Mario Kleiner       2019-02-09  9315  
fdd1fe57c00ef9 Mario Kleiner       2019-04-02  9316  		target_vblank = last_flip_vblank + wait_for_vblank;
8a48b44cd00f10 David Francis       2018-12-11  9317  
8a48b44cd00f10 David Francis       2018-12-11  9318  		/*
8a48b44cd00f10 David Francis       2018-12-11  9319  		 * Wait until we're out of the vertical blank period before the one
8a48b44cd00f10 David Francis       2018-12-11  9320  		 * targeted by the flip
8a48b44cd00f10 David Francis       2018-12-11  9321  		 */
8a48b44cd00f10 David Francis       2018-12-11  9322  		while ((acrtc_attach->enabled &&
8a48b44cd00f10 David Francis       2018-12-11  9323  			(amdgpu_display_get_crtc_scanoutpos(dm->ddev, acrtc_attach->crtc_id,
8a48b44cd00f10 David Francis       2018-12-11  9324  							    0, &vpos, &hpos, NULL,
8a48b44cd00f10 David Francis       2018-12-11  9325  							    NULL, &pcrtc->hwmode)
8a48b44cd00f10 David Francis       2018-12-11  9326  			 & (DRM_SCANOUTPOS_VALID | DRM_SCANOUTPOS_IN_VBLANK)) ==
8a48b44cd00f10 David Francis       2018-12-11  9327  			(DRM_SCANOUTPOS_VALID | DRM_SCANOUTPOS_IN_VBLANK) &&
8a48b44cd00f10 David Francis       2018-12-11  9328  			(int)(target_vblank -
e3eff4b5d91e0e Thomas Zimmermann   2020-01-23  9329  			  amdgpu_get_vblank_counter_kms(pcrtc)) > 0)) {
8a48b44cd00f10 David Francis       2018-12-11  9330  			usleep_range(1000, 1100);
8a48b44cd00f10 David Francis       2018-12-11  9331  		}
8a48b44cd00f10 David Francis       2018-12-11  9332  
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9333  		/**
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9334  		 * Prepare the flip event for the pageflip interrupt to handle.
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9335  		 *
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9336  		 * This only works in the case where we've already turned on the
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9337  		 * appropriate hardware blocks (eg. HUBP) so in the transition case
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9338  		 * from 0 -> n planes we have to skip a hardware generated event
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9339  		 * and rely on sending it from software.
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9340  		 */
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9341  		if (acrtc_attach->base.state->event &&
035f54969bb2c1 Aurabindo Pillai    2021-08-13  9342  		    acrtc_state->active_planes > 0 &&
035f54969bb2c1 Aurabindo Pillai    2021-08-13  9343  		    !acrtc_state->force_dpms_off) {
8a48b44cd00f10 David Francis       2018-12-11  9344  			drm_crtc_vblank_get(pcrtc);
8a48b44cd00f10 David Francis       2018-12-11  9345  
8a48b44cd00f10 David Francis       2018-12-11  9346  			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
8a48b44cd00f10 David Francis       2018-12-11  9347  
8a48b44cd00f10 David Francis       2018-12-11  9348  			WARN_ON(acrtc_attach->pflip_status != AMDGPU_FLIP_NONE);
8a48b44cd00f10 David Francis       2018-12-11  9349  			prepare_flip_isr(acrtc_attach);
8a48b44cd00f10 David Francis       2018-12-11  9350  
8a48b44cd00f10 David Francis       2018-12-11  9351  			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
8a48b44cd00f10 David Francis       2018-12-11  9352  		}
8a48b44cd00f10 David Francis       2018-12-11  9353  
8a48b44cd00f10 David Francis       2018-12-11  9354  		if (acrtc_state->stream) {
8a48b44cd00f10 David Francis       2018-12-11  9355  			if (acrtc_state->freesync_vrr_info_changed)
74aa7bd4c6f774 David Francis       2019-03-01  9356  				bundle->stream_update.vrr_infopacket =
8a48b44cd00f10 David Francis       2018-12-11  9357  					&acrtc_state->stream->vrr_infopacket;
8a48b44cd00f10 David Francis       2018-12-11  9358  		}
e7b07ceef2a650 Harry Wentland      2017-08-10  9359  	}
e7b07ceef2a650 Harry Wentland      2017-08-10  9360  
bc92c06525e586 Nicholas Kazlauskas 2019-04-04  9361  	/* Update the planes if changed or disable if we don't have any. */
ed9656fbc8b5b1 Ernst Sjöstrand     2019-06-24  9362  	if ((planes_count || acrtc_state->active_planes == 0) &&
ed9656fbc8b5b1 Ernst Sjöstrand     2019-06-24  9363  		acrtc_state->stream) {
961606872a28f0 Nicholas Kazlauskas 2021-08-12  9364  #if defined(CONFIG_DRM_AMD_DC_DCN)
58aa1c50e5a231 Nicholas Kazlauskas 2021-08-03  9365  		/*
58aa1c50e5a231 Nicholas Kazlauskas 2021-08-03  9366  		 * If PSR or idle optimizations are enabled then flush out
58aa1c50e5a231 Nicholas Kazlauskas 2021-08-03  9367  		 * any pending work before hardware programming.
58aa1c50e5a231 Nicholas Kazlauskas 2021-08-03  9368  		 */
06dd1888ee58d2 Nicholas Kazlauskas 2021-09-07  9369  		if (dm->vblank_control_workqueue)
58aa1c50e5a231 Nicholas Kazlauskas 2021-08-03  9370  			flush_workqueue(dm->vblank_control_workqueue);
961606872a28f0 Nicholas Kazlauskas 2021-08-12  9371  #endif
58aa1c50e5a231 Nicholas Kazlauskas 2021-08-03  9372  
b6e881c947417e Dmytro Laktyushkin  2019-09-13  9373  		bundle->stream_update.stream = acrtc_state->stream;
bc7f670ee04cd6 David Francis       2018-12-19  9374  		if (new_pcrtc_state->mode_changed) {
74aa7bd4c6f774 David Francis       2019-03-01  9375  			bundle->stream_update.src = acrtc_state->stream->src;
74aa7bd4c6f774 David Francis       2019-03-01  9376  			bundle->stream_update.dst = acrtc_state->stream->dst;
e7b07ceef2a650 Harry Wentland      2017-08-10  9377  		}
e7b07ceef2a650 Harry Wentland      2017-08-10  9378  
cf020d49b3c4ef Nicholas Kazlauskas 2019-05-09  9379  		if (new_pcrtc_state->color_mgmt_changed) {
cf020d49b3c4ef Nicholas Kazlauskas 2019-05-09  9380  			/*
cf020d49b3c4ef Nicholas Kazlauskas 2019-05-09  9381  			 * TODO: This isn't fully correct since we've actually
cf020d49b3c4ef Nicholas Kazlauskas 2019-05-09  9382  			 * already modified the stream in place.
cf020d49b3c4ef Nicholas Kazlauskas 2019-05-09  9383  			 */
cf020d49b3c4ef Nicholas Kazlauskas 2019-05-09  9384  			bundle->stream_update.gamut_remap =
cf020d49b3c4ef Nicholas Kazlauskas 2019-05-09  9385  				&acrtc_state->stream->gamut_remap_matrix;
cf020d49b3c4ef Nicholas Kazlauskas 2019-05-09  9386  			bundle->stream_update.output_csc_transform =
cf020d49b3c4ef Nicholas Kazlauskas 2019-05-09  9387  				&acrtc_state->stream->csc_color_matrix;
cf020d49b3c4ef Nicholas Kazlauskas 2019-05-09  9388  			bundle->stream_update.out_transfer_func =
cf020d49b3c4ef Nicholas Kazlauskas 2019-05-09  9389  				acrtc_state->stream->out_transfer_func;
cf020d49b3c4ef Nicholas Kazlauskas 2019-05-09  9390  		}
bc7f670ee04cd6 David Francis       2018-12-19  9391  
8a48b44cd00f10 David Francis       2018-12-11  9392  		acrtc_state->stream->abm_level = acrtc_state->abm_level;
bc7f670ee04cd6 David Francis       2018-12-19  9393  		if (acrtc_state->abm_level != dm_old_crtc_state->abm_level)
74aa7bd4c6f774 David Francis       2019-03-01  9394  			bundle->stream_update.abm_level = &acrtc_state->abm_level;
44d09c6a577c8e Harry Wentland      2018-03-15  9395  
e63e2491ad9203 Eryk Brol           2019-04-23  9396  		/*
e63e2491ad9203 Eryk Brol           2019-04-23  9397  		 * If FreeSync state on the stream has changed then we need to
e63e2491ad9203 Eryk Brol           2019-04-23  9398  		 * re-adjust the min/max bounds now that DC doesn't handle this
e63e2491ad9203 Eryk Brol           2019-04-23  9399  		 * as part of commit.
e63e2491ad9203 Eryk Brol           2019-04-23  9400  		 */
a85ba00538cd4b Nikola Cornij       2021-03-15  9401  		if (is_dc_timing_adjust_needed(dm_old_crtc_state, acrtc_state)) {
e63e2491ad9203 Eryk Brol           2019-04-23  9402  			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
e63e2491ad9203 Eryk Brol           2019-04-23  9403  			dc_stream_adjust_vmin_vmax(
e63e2491ad9203 Eryk Brol           2019-04-23  9404  				dm->dc, acrtc_state->stream,
585d450c76d1d5 Aurabindo Pillai    2020-08-12  9405  				&acrtc_attach->dm_irq_params.vrr_params.adjust);
e63e2491ad9203 Eryk Brol           2019-04-23  9406  			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
e63e2491ad9203 Eryk Brol           2019-04-23  9407  		}
bc7f670ee04cd6 David Francis       2018-12-19  9408  		mutex_lock(&dm->dc_lock);
8c322309e48e9f Roman Li            2019-09-20  9409  		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) &&
d1ebfdd8d0fc30 Wyatt Wood          2020-03-31  9410  				acrtc_state->stream->link->psr_settings.psr_allow_active)
8c322309e48e9f Roman Li            2019-09-20  9411  			amdgpu_dm_psr_disable(acrtc_state->stream);
8c322309e48e9f Roman Li            2019-09-20  9412  
bc7f670ee04cd6 David Francis       2018-12-19  9413  		dc_commit_updates_for_stream(dm->dc,
74aa7bd4c6f774 David Francis       2019-03-01  9414  						     bundle->surface_updates,
e7b07ceef2a650 Harry Wentland      2017-08-10  9415  						     planes_count,
bc7f670ee04cd6 David Francis       2018-12-19  9416  						     acrtc_state->stream,
efc8278eecfd5e Anson Jacob         2021-02-18  9417  						     &bundle->stream_update,
efc8278eecfd5e Anson Jacob         2021-02-18  9418  						     dc_state);
8c322309e48e9f Roman Li            2019-09-20  9419  
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9420  		/**
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9421  		 * Enable or disable the interrupts on the backend.
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9422  		 *
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9423  		 * Most pipes are put into power gating when unused.
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9424  		 *
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9425  		 * When power gating is enabled on a pipe we lose the
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9426  		 * interrupt enablement state when power gating is disabled.
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9427  		 *
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9428  		 * So we need to update the IRQ control state in hardware
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9429  		 * whenever the pipe turns on (since it could be previously
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9430  		 * power gated) or off (since some pipes can't be power gated
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9431  		 * on some ASICs).
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9432  		 */
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9433  		if (dm_old_crtc_state->active_planes != acrtc_state->active_planes)
1348969ab68cb8 Luben Tuikov        2020-08-24  9434  			dm_update_pflip_irq_state(drm_to_adev(dev),
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9435  						  acrtc_attach);
8fe684e97c86e3 Nicholas Kazlauskas 2020-07-13  9436  
8c322309e48e9f Roman Li            2019-09-20  9437  		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) &&
1cfbbddead0abd Anthony Koo         2020-04-21  9438  				acrtc_state->stream->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED &&
d1ebfdd8d0fc30 Wyatt Wood          2020-03-31  9439  				!acrtc_state->stream->link->psr_settings.psr_feature_enabled)
8c322309e48e9f Roman Li            2019-09-20  9440  			amdgpu_dm_link_setup_psr(acrtc_state->stream);
58aa1c50e5a231 Nicholas Kazlauskas 2021-08-03  9441  
58aa1c50e5a231 Nicholas Kazlauskas 2021-08-03  9442  		/* Decrement skip count when PSR is enabled and we're doing fast updates. */
58aa1c50e5a231 Nicholas Kazlauskas 2021-08-03  9443  		if (acrtc_state->update_type == UPDATE_TYPE_FAST &&
58aa1c50e5a231 Nicholas Kazlauskas 2021-08-03  9444  		    acrtc_state->stream->link->psr_settings.psr_feature_enabled) {
58aa1c50e5a231 Nicholas Kazlauskas 2021-08-03  9445  			struct amdgpu_dm_connector *aconn =
58aa1c50e5a231 Nicholas Kazlauskas 2021-08-03  9446  				(struct amdgpu_dm_connector *)acrtc_state->stream->dm_stream_context;
1a365683d6df1b Roman Li            2021-06-08  9447  
1a365683d6df1b Roman Li            2021-06-08  9448  			if (aconn->psr_skip_count > 0)
1a365683d6df1b Roman Li            2021-06-08  9449  				aconn->psr_skip_count--;
58aa1c50e5a231 Nicholas Kazlauskas 2021-08-03  9450  
58aa1c50e5a231 Nicholas Kazlauskas 2021-08-03  9451  			/* Allow PSR when skip count is 0. */
58aa1c50e5a231 Nicholas Kazlauskas 2021-08-03  9452  			acrtc_attach->dm_irq_params.allow_psr_entry = !aconn->psr_skip_count;
58aa1c50e5a231 Nicholas Kazlauskas 2021-08-03  9453  		} else {
58aa1c50e5a231 Nicholas Kazlauskas 2021-08-03  9454  			acrtc_attach->dm_irq_params.allow_psr_entry = false;
8c322309e48e9f Roman Li            2019-09-20  9455  		}
8c322309e48e9f Roman Li            2019-09-20  9456  
bc7f670ee04cd6 David Francis       2018-12-19  9457  		mutex_unlock(&dm->dc_lock);
e7b07ceef2a650 Harry Wentland      2017-08-10  9458  	}
4b5105036afbd2 Nicholas Kazlauskas 2019-01-28  9459  
8ad278062de4ea Nicholas Kazlauskas 2019-04-08  9460  	/*
8ad278062de4ea Nicholas Kazlauskas 2019-04-08  9461  	 * Update cursor state *after* programming all the planes.
8ad278062de4ea Nicholas Kazlauskas 2019-04-08  9462  	 * This avoids redundant programming in the case where we're going
8ad278062de4ea Nicholas Kazlauskas 2019-04-08  9463  	 * to be disabling a single plane - those pipes are being disabled.
8ad278062de4ea Nicholas Kazlauskas 2019-04-08  9464  	 */
8ad278062de4ea Nicholas Kazlauskas 2019-04-08  9465  	if (acrtc_state->active_planes)
8ad278062de4ea Nicholas Kazlauskas 2019-04-08  9466  		amdgpu_dm_commit_cursors(state);
80c218d56e309d Nicholas Kazlauskas 2019-01-25  9467  
4b5105036afbd2 Nicholas Kazlauskas 2019-01-28  9468  cleanup:
74aa7bd4c6f774 David Francis       2019-03-01  9469  	kfree(bundle);
e7b07ceef2a650 Harry Wentland      2017-08-10  9470  }
e7b07ceef2a650 Harry Wentland      2017-08-10  9471  

:::::: The code at line 9169 was first introduced by commit
:::::: 8a48b44cd00f10e83f573b9028d11bd90a36de26 drm/amd/display: Call into DC once per multiplane flip

:::::: TO: David Francis <David.Francis@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

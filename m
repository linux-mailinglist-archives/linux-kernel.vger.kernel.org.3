Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560C058A3F7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 01:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240158AbiHDXkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 19:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiHDXkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 19:40:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F7E2B24B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 16:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659656440; x=1691192440;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FkYo3EAvcXJpJGMCLUfaIg09ol36CC85VLIFPrZICag=;
  b=D0FB8SBv9BremHckOOezoG51Yzclsfg6orbJpWdmbQX5yKEAHyZWyQ90
   fgIEljs6Q3X20p+nNxvHT9N11RPwIXGFtTM+qiqwkTvLlTDrOOreQw0Mw
   d1jDd2g0EyAZad9JrsXuC9+i/5S3UT0JVUEllafhVL/zE9Zl8GCtIb/gy
   GLDKa0wfOdTHhaTjR7UkaEHXWlJg9ZxoOYyr9+lDCK87tYKOJgUGpGsR/
   Vmsup4WEI+vIN2Tbys+1z+kKKrOkbQ8aB7uP1CBylFe56BAxLxpUEjHPD
   CNCvVBxe3Wf9Rfzh2B1sMMSQ4tGeegvEuKUK9tunaZPHHKQkUInqivB80
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="315965441"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="315965441"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 16:40:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="931022336"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Aug 2022 16:40:39 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJkSE-000Iwx-1I;
        Thu, 04 Aug 2022 23:40:38 +0000
Date:   Fri, 5 Aug 2022 07:40:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:83:31:
 warning: no previous prototype for 'amd_get_format_info'
Message-ID: <202208050756.BbOxHxYk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodrigo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c040862bfbd9c5f3cb64e1df1c623e20e38fe656
commit: 5d945cbcd4b16a29d6470a80dfb19738f9a4319f drm/amd/display: Create a file dedicated to planes
date:   2 weeks ago
config: alpha-randconfig-r025-20220804 (https://download.01.org/0day-ci/archive/20220805/202208050756.BbOxHxYk-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d945cbcd4b16a29d6470a80dfb19738f9a4319f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5d945cbcd4b16a29d6470a80dfb19738f9a4319f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/ drivers/gpu/drm/amd/display/amdgpu_dm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:83:31: warning: no previous prototype for 'amd_get_format_info' [-Wmissing-prototypes]
      83 | const struct drm_format_info *amd_get_format_info(const struct drm_mode_fb_cmd2 *cmd)
         |                               ^~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:88:6: warning: no previous prototype for 'fill_blending_from_plane_state' [-Wmissing-prototypes]
      88 | void fill_blending_from_plane_state(const struct drm_plane_state *plane_state,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:152:6: warning: no previous prototype for 'modifier_has_dcc' [-Wmissing-prototypes]
     152 | bool modifier_has_dcc(uint64_t modifier)
         |      ^~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:157:10: warning: no previous prototype for 'modifier_gfx9_swizzle_mode' [-Wmissing-prototypes]
     157 | unsigned modifier_gfx9_swizzle_mode(uint64_t modifier)
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:752:5: warning: no previous prototype for 'fill_plane_buffer_attributes' [-Wmissing-prototypes]
     752 | int fill_plane_buffer_attributes(struct amdgpu_device *adev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:992:5: warning: no previous prototype for 'dm_plane_helper_check_state' [-Wmissing-prototypes]
     992 | int dm_plane_helper_check_state(struct drm_plane_state *state,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:1046:5: warning: no previous prototype for 'fill_dc_scaling_info' [-Wmissing-prototypes]
    1046 | int fill_dc_scaling_info(struct amdgpu_device *adev,
         |     ^~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:1222:6: warning: no previous prototype for 'handle_cursor_update' [-Wmissing-prototypes]
    1222 | void handle_cursor_update(struct drm_plane *plane,
         |      ^~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:1575:5: warning: no previous prototype for 'amdgpu_dm_plane_init' [-Wmissing-prototypes]
    1575 | int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
         |     ^~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_trace.h:41,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:36:
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


vim +/amd_get_format_info +83 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c

    82	
  > 83	const struct drm_format_info *amd_get_format_info(const struct drm_mode_fb_cmd2 *cmd)
    84	{
    85		return amdgpu_lookup_format_info(cmd->pixel_format, cmd->modifier[0]);
    86	}
    87	
  > 88	void fill_blending_from_plane_state(const struct drm_plane_state *plane_state,
    89				       bool *per_pixel_alpha, bool *pre_multiplied_alpha,
    90				       bool *global_alpha, int *global_alpha_value)
    91	{
    92		*per_pixel_alpha = false;
    93		*pre_multiplied_alpha = true;
    94		*global_alpha = false;
    95		*global_alpha_value = 0xff;
    96	
    97		if (plane_state->plane->type != DRM_PLANE_TYPE_OVERLAY)
    98			return;
    99	
   100		if (plane_state->pixel_blend_mode == DRM_MODE_BLEND_PREMULTI ||
   101			plane_state->pixel_blend_mode == DRM_MODE_BLEND_COVERAGE) {
   102			static const uint32_t alpha_formats[] = {
   103				DRM_FORMAT_ARGB8888,
   104				DRM_FORMAT_RGBA8888,
   105				DRM_FORMAT_ABGR8888,
   106			};
   107			uint32_t format = plane_state->fb->format->format;
   108			unsigned int i;
   109	
   110			for (i = 0; i < ARRAY_SIZE(alpha_formats); ++i) {
   111				if (format == alpha_formats[i]) {
   112					*per_pixel_alpha = true;
   113					break;
   114				}
   115			}
   116	
   117			if (*per_pixel_alpha && plane_state->pixel_blend_mode == DRM_MODE_BLEND_COVERAGE)
   118				*pre_multiplied_alpha = false;
   119		}
   120	
   121		if (plane_state->alpha < 0xffff) {
   122			*global_alpha = true;
   123			*global_alpha_value = plane_state->alpha >> 8;
   124		}
   125	}
   126	
   127	static void add_modifier(uint64_t **mods, uint64_t *size, uint64_t *cap, uint64_t mod)
   128	{
   129		if (!*mods)
   130			return;
   131	
   132		if (*cap - *size < 1) {
   133			uint64_t new_cap = *cap * 2;
   134			uint64_t *new_mods = kmalloc(new_cap * sizeof(uint64_t), GFP_KERNEL);
   135	
   136			if (!new_mods) {
   137				kfree(*mods);
   138				*mods = NULL;
   139				return;
   140			}
   141	
   142			memcpy(new_mods, *mods, sizeof(uint64_t) * *size);
   143			kfree(*mods);
   144			*mods = new_mods;
   145			*cap = new_cap;
   146		}
   147	
   148		(*mods)[*size] = mod;
   149		*size += 1;
   150	}
   151	
 > 152	bool modifier_has_dcc(uint64_t modifier)
   153	{
   154		return IS_AMD_FMT_MOD(modifier) && AMD_FMT_MOD_GET(DCC, modifier);
   155	}
   156	
 > 157	unsigned modifier_gfx9_swizzle_mode(uint64_t modifier)
   158	{
   159		if (modifier == DRM_FORMAT_MOD_LINEAR)
   160			return 0;
   161	
   162		return AMD_FMT_MOD_GET(TILE, modifier);
   163	}
   164	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

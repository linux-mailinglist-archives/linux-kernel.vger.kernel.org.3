Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7960537166
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 16:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiE2Oot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 10:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiE2Oos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 10:44:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37298E190
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 07:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653835487; x=1685371487;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MixufXRvEwcNgvnEmlQ9DDLtV4e15ATVODNSDNCfh5I=;
  b=ON8+dW7U8rSBnKUpFpnBQ1XVVozcUse01lGd1P3aSQq6v2jaTS2ffWBc
   y8ywHedjJC0s+0Vcj5V/fIgtTwimMaWdN692Mt+T0GTHrK5fpnV4jthUH
   zPCHwEB/ZU7uOGukqvKvyo4qK6Rv7QVZndhv0WYRuMZ0KaPin7ws4mmY+
   c21K77Y3FbjU7/IGB/5M8bTvNM7fw2gBt7ccgoH1aMsz7oXnYBYuh4BjG
   g/SllFv+XnAUCI/t8WgyTIYqNQKGYWJo4dlZysAUTC91p4NdNqmZ3tA5G
   P6CReBFo4FNBQXyTkUfh74JSdrbN2MPx4th0N/gm+jmeUVqeZrCK3z37G
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10361"; a="300155979"
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="300155979"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 07:44:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="632299506"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 29 May 2022 07:44:45 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvK9s-00014m-Pv;
        Sun, 29 May 2022 14:44:44 +0000
Date:   Sun, 29 May 2022 22:44:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Schnelle <svens@stackframe.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Helge Deller <deller@gmx.de>
Subject: [deller-fbdev:hp-visualize-fx-drm 1/1]
 drivers/gpu/drm/visualizefx/visfx_drv.c:222:25: error: invalid use of
 undefined type 'const struct dma_buf_map'
Message-ID: <202205292236.7katQfFE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git hp-visualize-fx-drm
head:   c2d0f767c19314c3d3a1a2d304be3c871b729523
commit: c2d0f767c19314c3d3a1a2d304be3c871b729523 [1/1] drm: add HP Visualize FX driver
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220529/202205292236.7katQfFE-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git/commit/?id=c2d0f767c19314c3d3a1a2d304be3c871b729523
        git remote add deller-fbdev git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
        git fetch --no-tags deller-fbdev hp-visualize-fx-drm
        git checkout c2d0f767c19314c3d3a1a2d304be3c871b729523
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/visualizefx/visfx_drv.c:218:45: warning: 'struct dma_buf_map' declared inside parameter list will not be visible outside of this definition or declaration
     218 |                                const struct dma_buf_map *map,
         |                                             ^~~~~~~~~~~
   drivers/gpu/drm/visualizefx/visfx_drv.c: In function 'visfx_fb_blit_rect':
>> drivers/gpu/drm/visualizefx/visfx_drv.c:222:25: error: invalid use of undefined type 'const struct dma_buf_map'
     222 |         void *vmap = map->vaddr; /* TODO: Use mapping abstraction properly */
         |                         ^~
   drivers/gpu/drm/visualizefx/visfx_drv.c: At top level:
   drivers/gpu/drm/visualizefx/visfx_drv.c:236:78: warning: 'struct dma_buf_map' declared inside parameter list will not be visible outside of this definition or declaration
     236 | static int visfx_fb_blit_fullscreen(struct drm_framebuffer *fb, const struct dma_buf_map *map)
         |                                                                              ^~~~~~~~~~~
   drivers/gpu/drm/visualizefx/visfx_drv.c: In function 'visfx_fb_blit_fullscreen':
>> drivers/gpu/drm/visualizefx/visfx_drv.c:244:39: error: passing argument 2 of 'visfx_fb_blit_rect' from incompatible pointer type [-Werror=incompatible-pointer-types]
     244 |         return visfx_fb_blit_rect(fb, map, &fullscreen);
         |                                       ^~~
         |                                       |
         |                                       const struct dma_buf_map *
   drivers/gpu/drm/visualizefx/visfx_drv.c:218:58: note: expected 'const struct dma_buf_map *' but argument is of type 'const struct dma_buf_map *'
     218 |                                const struct dma_buf_map *map,
         |                                ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/gpu/drm/visualizefx/visfx_drv.c: In function 'visfx_pipe_enable':
>> drivers/gpu/drm/visualizefx/visfx_drv.c:281:51: error: passing argument 2 of 'visfx_fb_blit_fullscreen' from incompatible pointer type [-Werror=incompatible-pointer-types]
     281 |         visfx_fb_blit_fullscreen(plane_state->fb, &shadow_plane_state->data[0]);
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                   |
         |                                                   struct iosys_map *
   drivers/gpu/drm/visualizefx/visfx_drv.c:236:91: note: expected 'const struct dma_buf_map *' but argument is of type 'struct iosys_map *'
     236 | static int visfx_fb_blit_fullscreen(struct drm_framebuffer *fb, const struct dma_buf_map *map)
         |                                                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/gpu/drm/visualizefx/visfx_drv.c: In function 'visfx_pipe_update':
   drivers/gpu/drm/visualizefx/visfx_drv.c:321:47: error: passing argument 2 of 'visfx_fb_blit_rect' from incompatible pointer type [-Werror=incompatible-pointer-types]
     321 |                 visfx_fb_blit_rect(state->fb, &shadow_plane_state->data[0], &rect);
         |                                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                               |
         |                                               struct iosys_map *
   drivers/gpu/drm/visualizefx/visfx_drv.c:218:58: note: expected 'const struct dma_buf_map *' but argument is of type 'struct iosys_map *'
     218 |                                const struct dma_buf_map *map,
         |                                ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   cc1: some warnings being treated as errors


vim +222 drivers/gpu/drm/visualizefx/visfx_drv.c

   216	
   217	static int visfx_fb_blit_rect(struct drm_framebuffer *fb,
   218				       const struct dma_buf_map *map,
   219				       struct drm_rect *rect)
   220	{
   221		struct visfx_device *visfx = to_visfx(fb->dev);
 > 222		void *vmap = map->vaddr; /* TODO: Use mapping abstraction properly */
   223		uint8_t *dst;
   224		int idx;
   225	
   226		if (!drm_dev_enter(&visfx->dev, &idx))
   227			return -ENODEV;
   228		visfx_writel(visfx, VISFX_VRAM_WRITE_MODE, VISFX_VRAM_WRITE_MODE_BITMAP);
   229		dst = visfx->mmio + 0x01000000;
   230		dst += drm_fb_clip_offset(fb->pitches[0], fb->format, rect);
   231		drm_fb_memcpy_toio(dst, fb->pitches[0], vmap, fb, rect);
   232		drm_dev_exit(idx);
   233		return 0;
   234	}
   235	
   236	static int visfx_fb_blit_fullscreen(struct drm_framebuffer *fb, const struct dma_buf_map *map)
   237	{
   238		struct drm_rect fullscreen = {
   239			.x1 = 0,
   240			.x2 = fb->width,
   241			.y1 = 0,
   242			.y2 = fb->height,
   243		};
 > 244		return visfx_fb_blit_rect(fb, map, &fullscreen);
   245	}
   246	
   247	static int visfx_check_size(int width, int height, struct drm_framebuffer *fb)
   248	{
   249		if (width > 2048 || height > 2048)
   250			return -EINVAL;
   251		return 0;
   252	}
   253	
   254	static enum drm_mode_status visfx_pipe_mode_valid(struct drm_simple_display_pipe *pipe,
   255							   const struct drm_display_mode *mode)
   256	{
   257		if (visfx_check_size(mode->hdisplay, mode->vdisplay, NULL) < 0)
   258			return MODE_BAD;
   259		return MODE_OK;
   260	}
   261	
   262	static int visfx_pipe_check(struct drm_simple_display_pipe *pipe,
   263				     struct drm_plane_state *plane_state,
   264				     struct drm_crtc_state *crtc_state)
   265	{
   266		struct drm_framebuffer *fb = plane_state->fb;
   267	
   268		if (!fb)
   269			return 0;
   270		return visfx_check_size(fb->width, fb->height, fb);
   271	}
   272	
   273	static void visfx_pipe_enable(struct drm_simple_display_pipe *pipe,
   274				      struct drm_crtc_state *crtc_state,
   275				      struct drm_plane_state *plane_state)
   276	{
   277		struct visfx_device *visfx = to_visfx(pipe->crtc.dev);
   278		struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
   279	
   280		visfx_mode_set(visfx, &crtc_state->mode, plane_state->fb);
 > 281		visfx_fb_blit_fullscreen(plane_state->fb, &shadow_plane_state->data[0]);
   282	}
   283	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

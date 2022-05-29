Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5F7537111
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 15:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiE2NMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 09:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiE2NMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 09:12:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B0656C10
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 06:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653829964; x=1685365964;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=W7uDE1nH6I0F8tHPG+SKtwd2XkD1BMJpkEK4J4jTHCs=;
  b=dNxsrYOlanTq424IhiD4K5Ez8UZ+hN1/B/2k8LbR1tAmgtSKMY2WvJZ5
   fTRkRoQu8S6M3YDAYSgES4YADTWt/B7PsCi383dwj74kN76kpiC4YttB0
   //Sg1A/PjH2/NHj+qCQrBU1CML5F9T9DOjUPjh3ChRHNNQZQmS03vbHwY
   vjAgryF4mmLgafqJtJpMq7qeTbid2t6NAWzh5G3yDSDXADLQLpkqp8zty
   vY5t3GlHigJkUtqjI22Hkw6nPKth5auJr+koKWSIdVDvn0W7zkGLn1cMf
   9wkLjIReJfrn2yJBgvT6O+btj9ot5Bh7WDlP0O2zvSiClLv3qfr+AzJzY
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10361"; a="262413261"
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="262413261"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 06:12:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="632274977"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 29 May 2022 06:12:42 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvIin-00012K-Ff;
        Sun, 29 May 2022 13:12:41 +0000
Date:   Sun, 29 May 2022 21:12:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Schnelle <svens@stackframe.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Helge Deller <deller@gmx.de>
Subject: [deller-fbdev:hp-visualize-fx-drm 1/1]
 drivers/gpu/drm/visualizefx/visfx_drv.c:218:45: warning: 'struct
 dma_buf_map' declared inside parameter list will not be visible outside of
 this definition or declaration
Message-ID: <202205292129.uedWYGfX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220529/202205292129.uedWYGfX-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/gpu/drm/visualizefx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/visualizefx/visfx_drv.c:218:45: warning: 'struct dma_buf_map' declared inside parameter list will not be visible outside of this definition or declaration
     218 |                                const struct dma_buf_map *map,
         |                                             ^~~~~~~~~~~
   drivers/gpu/drm/visualizefx/visfx_drv.c: In function 'visfx_fb_blit_rect':
   drivers/gpu/drm/visualizefx/visfx_drv.c:222:25: error: invalid use of undefined type 'const struct dma_buf_map'
     222 |         void *vmap = map->vaddr; /* TODO: Use mapping abstraction properly */
         |                         ^~
   drivers/gpu/drm/visualizefx/visfx_drv.c: At top level:
   drivers/gpu/drm/visualizefx/visfx_drv.c:236:78: warning: 'struct dma_buf_map' declared inside parameter list will not be visible outside of this definition or declaration
     236 | static int visfx_fb_blit_fullscreen(struct drm_framebuffer *fb, const struct dma_buf_map *map)
         |                                                                              ^~~~~~~~~~~
   drivers/gpu/drm/visualizefx/visfx_drv.c: In function 'visfx_fb_blit_fullscreen':
   drivers/gpu/drm/visualizefx/visfx_drv.c:244:39: error: passing argument 2 of 'visfx_fb_blit_rect' from incompatible pointer type [-Werror=incompatible-pointer-types]
     244 |         return visfx_fb_blit_rect(fb, map, &fullscreen);
         |                                       ^~~
         |                                       |
         |                                       const struct dma_buf_map *
   drivers/gpu/drm/visualizefx/visfx_drv.c:218:58: note: expected 'const struct dma_buf_map *' but argument is of type 'const struct dma_buf_map *'
     218 |                                const struct dma_buf_map *map,
         |                                ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/gpu/drm/visualizefx/visfx_drv.c: In function 'visfx_pipe_enable':
   drivers/gpu/drm/visualizefx/visfx_drv.c:281:51: error: passing argument 2 of 'visfx_fb_blit_fullscreen' from incompatible pointer type [-Werror=incompatible-pointer-types]
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


vim +218 drivers/gpu/drm/visualizefx/visfx_drv.c

   216	
   217	static int visfx_fb_blit_rect(struct drm_framebuffer *fb,
 > 218				       const struct dma_buf_map *map,
   219				       struct drm_rect *rect)
   220	{
   221		struct visfx_device *visfx = to_visfx(fb->dev);
   222		void *vmap = map->vaddr; /* TODO: Use mapping abstraction properly */
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

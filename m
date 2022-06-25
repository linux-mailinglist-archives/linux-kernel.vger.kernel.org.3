Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7770955A968
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 13:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiFYL2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 07:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiFYL2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 07:28:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1B1658A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 04:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656156489; x=1687692489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PrgJ6QvW/87X3T3fMApy0DBKHWegSqU6hwl1ONZHxzY=;
  b=mlqYVSBGRgBU2PGIMoBk/XJWExe2O/MZdYYyBhXq7W10+09HLo4wImTs
   ZiBI0FtCIK9il0lRvTxCfCB4wLpWWeemlBqcxSM+GAkphd/B44BJ5eTL2
   2NDt3bYZeHO+v59kZPW7A25VYAGZnbQszn85xmgr9c83OmxBlE/ZfQGUK
   /fMZVaAizJStxLK6VTmLMsHZt6n0RPcZ57r7Um8F1GfvE3iPY09RCWRqM
   5BEqJC8ZTcTO1UuBXi7b8J8hbI/XKHCDFco2HPgzexETLiMsbfH2nVAgl
   yUpZy1Rkw1oKsn/yz9r2io2Ut6HPwjqWWScDMC07N8MlpmxQQNnjy0tAs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="278721410"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="278721410"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 04:28:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="564120566"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Jun 2022 04:28:05 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o53xM-0005hE-Sg;
        Sat, 25 Jun 2022 11:28:04 +0000
Date:   Sat, 25 Jun 2022 19:27:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chenyang Li <lichenyang@loongson.cn>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dan Carpenter <error27@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devel@linuxdriverproject.org
Cc:     kbuild-all@lists.01.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel@vger.kernel.org, Yi Li <liyi@loongson.cn>
Subject: Re: [PATCH v7 1/4] drm/loongson: Add DRM Driver for Loongson 7A1000
 bridge chip
Message-ID: <202206251930.GbwGAcFG-lkp@intel.com>
References: <20220625090715.3663-1-lichenyang@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625090715.3663-1-lichenyang@loongson.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chenyang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v5.19-rc3 next-20220624]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Chenyang-Li/drm-loongson-Add-DRM-Driver-for-Loongson-7A1000-bridge-chip/20220625-171037
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
config: powerpc-allmodconfig
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/438d0791edb6352903bf09dfe214453526081075
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chenyang-Li/drm-loongson-Add-DRM-Driver-for-Loongson-7A1000-bridge-chip/20220625-171037
        git checkout 438d0791edb6352903bf09dfe214453526081075
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/gpu/drm/loongson/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/gpu/drm/loongson/loongson_crtc.c: In function 'loongson_crtc_mode_set_nofb':
>> drivers/gpu/drm/loongson/loongson_crtc.c:128:42: error: invalid use of undefined type 'struct drm_framebuffer'
     128 |         format = crtc->primary->state->fb->format;
         |                                          ^~
--
   drivers/gpu/drm/loongson/loongson_device.c: In function 'loongson_gpu_offset':
>> drivers/gpu/drm/loongson/loongson_device.c:14:44: error: invalid use of undefined type 'struct drm_framebuffer'
      14 |         gbo = drm_gem_vram_of_gem(state->fb->obj[0]);
         |                                            ^~
--
   In file included from include/linux/device.h:15,
                    from include/linux/pci.h:37,
                    from drivers/gpu/drm/loongson/loongson_drv.c:14:
   drivers/gpu/drm/loongson/loongson_drv.c: In function 'loongson_device_init':
>> include/drm/drm_print.h:425:39: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
     425 |         dev_##level##type((drm)->dev, "[drm] " fmt, ##__VA_ARGS__)
         |                                       ^~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
     150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                          ^~~~~~~
   include/drm/drm_print.h:425:9: note: in expansion of macro 'dev_info'
     425 |         dev_##level##type((drm)->dev, "[drm] " fmt, ##__VA_ARGS__)
         |         ^~~~
   include/drm/drm_print.h:429:9: note: in expansion of macro '__drm_printk'
     429 |         __drm_printk((drm), info,, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~
   drivers/gpu/drm/loongson/loongson_drv.c:91:9: note: in expansion of macro 'drm_info'
      91 |         drm_info(dev, "DC mmio base 0x%llx size 0x%llx io 0x%llx\n",
         |         ^~~~~~~~
   include/drm/drm_print.h:425:39: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
     425 |         dev_##level##type((drm)->dev, "[drm] " fmt, ##__VA_ARGS__)
         |                                       ^~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
     150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                          ^~~~~~~
   include/drm/drm_print.h:425:9: note: in expansion of macro 'dev_info'
     425 |         dev_##level##type((drm)->dev, "[drm] " fmt, ##__VA_ARGS__)
         |         ^~~~
   include/drm/drm_print.h:429:9: note: in expansion of macro '__drm_printk'
     429 |         __drm_printk((drm), info,, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~
   drivers/gpu/drm/loongson/loongson_drv.c:91:9: note: in expansion of macro 'drm_info'
      91 |         drm_info(dev, "DC mmio base 0x%llx size 0x%llx io 0x%llx\n",
         |         ^~~~~~~~
   drivers/gpu/drm/loongson/loongson_drv.c: At top level:
   drivers/gpu/drm/loongson/loongson_drv.c:99:5: warning: no previous prototype for 'loongson_modeset_init' [-Wmissing-prototypes]
      99 | int loongson_modeset_init(struct loongson_device *ldev)
         |     ^~~~~~~~~~~~~~~~~~~~~
--
   drivers/gpu/drm/loongson/loongson_plane.c: In function 'loongson_plane_atomic_update':
>> drivers/gpu/drm/loongson/loongson_plane.c:27:27: error: invalid use of undefined type 'struct drm_framebuffer'
      27 |         pitch = lstate->fb->pitches[0];
         |                           ^~
   drivers/gpu/drm/loongson/loongson_plane.c:33:27: error: invalid use of undefined type 'struct drm_framebuffer'
      33 |         depth = lstate->fb->format->cpp[0] << 3;
         |                           ^~


vim +128 drivers/gpu/drm/loongson/loongson_crtc.c

   102	
   103	static void loongson_crtc_mode_set_nofb(struct drm_crtc *crtc)
   104	{
   105		struct drm_device *dev = crtc->dev;
   106		struct loongson_device *ldev = to_loongson_device(dev);
   107		struct loongson_crtc *lcrtc = to_loongson_crtc(crtc);
   108		struct drm_display_mode *mode = &crtc->state->adjusted_mode;
   109		const struct drm_format_info *format;
   110		struct pix_pll pll_cfg;
   111		u32 hr, hss, hse, hfl;
   112		u32 vr, vss, vse, vfl;
   113		u32 pix_freq;
   114		u32 reg_offset;
   115	
   116		hr = mode->hdisplay;
   117		hss = mode->hsync_start;
   118		hse = mode->hsync_end;
   119		hfl = mode->htotal;
   120	
   121		vr = mode->vdisplay;
   122		vss = mode->vsync_start;
   123		vse = mode->vsync_end;
   124		vfl = mode->vtotal;
   125	
   126		pix_freq = mode->clock;
   127		reg_offset = lcrtc->reg_offset;
 > 128		format = crtc->primary->state->fb->format;
   129	
   130		ls7a_mm_wreg(ldev, FB_DITCFG_REG + reg_offset, 0);
   131		ls7a_mm_wreg(ldev, FB_DITTAB_LO_REG + reg_offset, 0);
   132		ls7a_mm_wreg(ldev, FB_DITTAB_HI_REG + reg_offset, 0);
   133		ls7a_mm_wreg(ldev, FB_PANCFG_REG + reg_offset, FB_PANCFG_DEF);
   134		ls7a_mm_wreg(ldev, FB_PANTIM_REG + reg_offset, 0);
   135	
   136		ls7a_mm_wreg(ldev, FB_HDISPLAY_REG + reg_offset, (hfl << 16) | hr);
   137		ls7a_mm_wreg(ldev, FB_HSYNC_REG + reg_offset,
   138			     FB_HSYNC_PULSE | (hse << 16) | hss);
   139	
   140		ls7a_mm_wreg(ldev, FB_VDISPLAY_REG + reg_offset, (vfl << 16) | vr);
   141		ls7a_mm_wreg(ldev, FB_VSYNC_REG + reg_offset,
   142			     FB_VSYNC_PULSE | (vse << 16) | vss);
   143	
   144		switch (format->format) {
   145		case DRM_FORMAT_RGB565:
   146			lcrtc->cfg_reg |= 0x3;
   147			break;
   148		case DRM_FORMAT_RGB888:
   149		case DRM_FORMAT_XRGB8888:
   150		case DRM_FORMAT_ARGB8888:
   151		default:
   152			lcrtc->cfg_reg |= 0x4;
   153			break;
   154		}
   155	
   156		ls7a_mm_wreg(ldev, FB_CFG_REG + reg_offset, lcrtc->cfg_reg);
   157	
   158		cal_freq(pix_freq, &pll_cfg);
   159		config_pll(ldev, LS7A_PIX_PLL + reg_offset, &pll_cfg);
   160	}
   161	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

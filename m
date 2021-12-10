Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A83D46FD4C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbhLJJGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:06:38 -0500
Received: from mga09.intel.com ([134.134.136.24]:63460 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238982AbhLJJGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639126982; x=1670662982;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d9E005ceUrk8RQhWMp3JyKJiLMd+NWxUhNFDadchyig=;
  b=HBc9bqhSpzvHM6q0thYbUEPANTsf4gdev+nUpu/MzLSqcwLXl5IixFkQ
   GIyq841f4bWY7Q6ACvWBdw3rDrGRyHwxAn9nv7PppGC7QkurOz40YeXlC
   RghOWvlRaZK0X99U5IF1jkLW73PqZCQUyUJ0RgKVLC7mmLD1nkpr4Ouy8
   o0yFa9zSzD2wt1nJnPlaI6iNM/LsV4i42Vg8TQEVpxShIJrCPwtChMAc/
   cWdiixPd2xngsBSTV8A0T5uZQp+BsJBVkBSr4ndTzbI19d2QFu16wA8UD
   1I9fdoQNI0MR1/BNe9ik9scJ2Ww0fCf0pi6i5NdhL0gtTVr+NQULtMMUO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="238112156"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="238112156"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 01:03:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="612866881"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 10 Dec 2021 01:03:00 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvbnv-00030C-Ld; Fri, 10 Dec 2021 09:02:59 +0000
Date:   Fri, 10 Dec 2021 17:02:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [superna9999:amlogic/v5.17/g12-dsi 6/7]
 drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:58:16: error: use of undeclared
 identifier 'encoder_dsi'
Message-ID: <202112101635.GITAhfmQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/superna9999/linux amlogic/v5.17/g12-dsi
head:   cc44c3ce92a63f2c59a3f0ac03e6defd41542940
commit: 02c9727464cf0ef4cebca0197a0f7395be6371f7 [6/7] fixup! drm/meson: add support for MIPI-DSI transceiver
config: arm-randconfig-r034-20211210 (https://download.01.org/0day-ci/archive/20211210/202112101635.GITAhfmQ-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/superna9999/linux/commit/02c9727464cf0ef4cebca0197a0f7395be6371f7
        git remote add superna9999 https://github.com/superna9999/linux
        git fetch --no-tags superna9999 amlogic/v5.17/g12-dsi
        git checkout 02c9727464cf0ef4cebca0197a0f7395be6371f7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/meson/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:58:16: error: use of undeclared identifier 'encoder_dsi'
           phy_configure(encoder_dsi->phy, &mipi_dsi->phy_opts);
                         ^
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:68:2: error: implicit declaration of function 'meson_dw_mipi_dsi_hw_init' [-Werror,-Wimplicit-function-declaration]
           meson_dw_mipi_dsi_hw_init(mipi_dsi);
           ^
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:68:2: note: did you mean 'dw_mipi_dsi_phy_init'?
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:51:12: note: 'dw_mipi_dsi_phy_init' declared here
   static int dw_mipi_dsi_phy_init(void *priv_data)
              ^
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:72:21: error: use of undeclared identifier 'COLOR_24BIT'
                   dpi_data_format = COLOR_24BIT;
                                     ^
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:73:21: error: use of undeclared identifier 'MIPI_DSI_VENC_COLOR_24B'
                   venc_data_width = MIPI_DSI_VENC_COLOR_24B;
                                     ^
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:76:21: error: use of undeclared identifier 'COLOR_18BIT_CFG_2'
                   dpi_data_format = COLOR_18BIT_CFG_2;
                                     ^
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:77:21: error: use of undeclared identifier 'MIPI_DSI_VENC_COLOR_18B'
                   venc_data_width = MIPI_DSI_VENC_COLOR_18B;
                                     ^
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:70:10: warning: enumeration values 'MIPI_DSI_FMT_RGB666_PACKED' and 'MIPI_DSI_FMT_RGB565' not handled in switch [-Wswitch]
           switch (mipi_dsi->dsi_device->format) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:89:4: error: too many arguments provided to function-like macro invocation
                           mipi_dsi->base + MIPI_DSI_TOP_CNTL);
                           ^
   arch/arm/include/asm/io.h:300:9: note: macro 'writel_relaxed' defined here
   #define writel_relaxed(v,c)     __raw_writel((__force u32) cpu_to_le32(v),c)
           ^
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:82:2: error: use of undeclared identifier 'writel_relaxed'
           writel_relaxed((dpi_data_format  << BIT_DPI_COLOR_MODE)  |
           ^
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:111:17: error: assigning to 'struct drm_display_mode *' from 'const struct drm_display_mode *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           mipi_dsi->mode = mode;
                          ^ ~~~~
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:113:8: error: implicit declaration of function 'encoder_dsi_pixel_format_to_bpp' [-Werror,-Wimplicit-function-declaration]
           bpp = encoder_dsi_pixel_format_to_bpp(mipi_dsi->dsi_device->format);
                 ^
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:113:8: note: did you mean 'mipi_dsi_pixel_format_to_bpp'?
   include/drm/drm_mipi_dsi.h:209:19: note: 'mipi_dsi_pixel_format_to_bpp' declared here
   static inline int mipi_dsi_pixel_format_to_bpp(enum mipi_dsi_pixel_format fmt)
                     ^
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:116:12: error: use of undeclared identifier 'encoder_dsi'
                                            bpp, encoder_dsi->dsi_device->lanes,
                                                 ^
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:161:6: warning: unused variable 'ret' [-Wunused-variable]
           int ret;
               ^
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:160:22: warning: unused variable 'encoder' [-Wunused-variable]
           struct drm_encoder *encoder;
                               ^
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:176:13: error: static declaration of 'meson_dw_mipi_dsi_hw_init' follows non-static declaration
   static void meson_dw_mipi_dsi_hw_init(struct meson_dw_mipi_dsi *mipi_dsi)
               ^
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:68:2: note: previous implicit declaration is here
           meson_dw_mipi_dsi_hw_init(mipi_dsi);
           ^
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:200:2: error: implicit declaration of function 'witch' [-Werror,-Wimplicit-function-declaration]
           witch (device->format) {
           ^
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:200:24: error: expected ';' after expression
           witch (device->format) {
                                 ^
                                 ;
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:201:2: error: 'case' statement not in switch statement
           case MIPI_DSI_FMT_RGB888:
           ^
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:202:3: error: use of undeclared identifier 'dpi_data_format'
                   dpi_data_format = COLOR_24BIT;
                   ^
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:202:21: error: use of undeclared identifier 'COLOR_24BIT'
                   dpi_data_format = COLOR_24BIT;
                                     ^
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:203:3: error: use of undeclared identifier 'venc_data_width'
                   venc_data_width = MIPI_DSI_VENC_COLOR_24B;
                   ^
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:203:21: error: use of undeclared identifier 'MIPI_DSI_VENC_COLOR_24B'
                   venc_data_width = MIPI_DSI_VENC_COLOR_24B;
                                     ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   3 warnings and 20 errors generated.


vim +/encoder_dsi +58 drivers/gpu/drm/meson/meson_dw_mipi_dsi.c

    47	
    48	#define encoder_to_meson_dw_mipi_dsi(x) \
    49		container_of(x, struct meson_dw_mipi_dsi, encoder)
    50	
    51	static int dw_mipi_dsi_phy_init(void *priv_data)
    52	{
    53		struct meson_dw_mipi_dsi *mipi_dsi = priv_data;
    54		unsigned int dpi_data_format, venc_data_width;
    55		struct meson_drm *priv = mipi_dsi->priv;
    56		int ret;
    57	
  > 58		phy_configure(encoder_dsi->phy, &mipi_dsi->phy_opts);
    59	
    60		ret = clk_set_rate(mipi_dsi->px_clk, mipi_dsi->phy_opts.mipi_dphy.hs_clk_rate);
    61		if (ret) {
    62			pr_err("Failed to set DSI PLL rate %lu\n",
    63			       mipi_dsi->phy_opts.mipi_dphy.hs_clk_rate);
    64	
    65			return ret;
    66		}
    67	
  > 68		meson_dw_mipi_dsi_hw_init(mipi_dsi);
    69	
  > 70		switch (mipi_dsi->dsi_device->format) {
    71		case MIPI_DSI_FMT_RGB888:
  > 72			dpi_data_format = COLOR_24BIT;
  > 73			venc_data_width = MIPI_DSI_VENC_COLOR_24B;
    74			break;
    75		case MIPI_DSI_FMT_RGB666:
  > 76			dpi_data_format = COLOR_18BIT_CFG_2;
  > 77			venc_data_width = MIPI_DSI_VENC_COLOR_18B;
    78			break;
    79		};
    80	
    81		/* Configure color format for DPI register */
  > 82		writel_relaxed((dpi_data_format  << BIT_DPI_COLOR_MODE)  |
    83			       (venc_data_width  << BIT_IN_COLOR_MODE) |
    84				0 << BIT_COMP0_SEL |
    85				1 << BIT_COMP1_SEL |
    86				2 << BIT_COMP2_SEL,
    87				(mipi_dsi->mode->flags & DRM_MODE_FLAG_NHSYNC ? 0 : BIT(BIT_HSYNC_POL)) |
    88				(mipi_dsi->mode->flags & DRM_MODE_FLAG_NVSYNC ? 0 : BIT(BIT_VSYNC_POL)),
  > 89				mipi_dsi->base + MIPI_DSI_TOP_CNTL);
    90	
    91		phy_power_on(mipi_dsi->phy);
    92	
    93		return 0;
    94	}
    95	
    96	static void dw_mipi_dsi_phy_power_off(void *priv_data)
    97	{
    98		struct meson_dw_mipi_dsi *mipi_dsi = priv_data;
    99	
   100		phy_power_off(mipi_dsi->phy);
   101	}
   102	
   103	static int
   104	dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
   105				  unsigned long mode_flags, u32 lanes, u32 format,
   106				  unsigned int *lane_mbps)
   107	{
   108		struct meson_dw_mipi_dsi *mipi_dsi = priv_data;
   109		int bpp;
   110	
 > 111		mipi_dsi->mode = mode;
   112	
 > 113		bpp = encoder_dsi_pixel_format_to_bpp(mipi_dsi->dsi_device->format);
   114	
   115		phy_mipi_dphy_get_default_config(mode->clock * 1000,
   116						 bpp, encoder_dsi->dsi_device->lanes,
   117						 &mipi_dsi->phy_opts.mipi_dphy);
   118	
   119		*lane_mbps = mipi_dsi->phy_opts.mipi_dphy.hs_clk_rate / 1000000;
   120	
   121		return 0;
   122	}
   123	
   124	static int
   125	dw_mipi_dsi_phy_get_timing(void *priv_data, unsigned int lane_mbps,
   126				   struct dw_mipi_dsi_dphy_timing *timing)
   127	{
   128		/* TOFIX handle other cases */
   129	
   130		timing->clk_lp2hs = 37;
   131		timing->clk_hs2lp = 135;
   132		timing->data_lp2hs = 50;
   133		timing->data_hs2lp = 3;
   134	
   135		return 0;
   136	}
   137	
   138	static int
   139	dw_mipi_dsi_get_esc_clk_rate(void *priv_data, unsigned int *esc_clk_rate)
   140	{
   141		*esc_clk_rate = 4; /* Mhz */
   142	
   143		return 0;
   144	}
   145	
   146	static const struct dw_mipi_dsi_phy_ops meson_dw_mipi_dsi_phy_ops = {
   147		.init = dw_mipi_dsi_phy_init,
   148		.power_off = dw_mipi_dsi_phy_power_off,
   149		.get_lane_mbps = dw_mipi_dsi_get_lane_mbps,
   150		.get_timing = dw_mipi_dsi_phy_get_timing,
   151		.get_esc_clk_rate = dw_mipi_dsi_get_esc_clk_rate,
   152	};
   153	
   154	static int meson_dw_mipi_dsi_bind(struct device *dev, struct device *master,
   155					void *data)
   156	{
   157		struct meson_dw_mipi_dsi *mipi_dsi = dev_get_drvdata(dev);
   158		struct drm_device *drm = data;
   159		struct meson_drm *priv = drm->dev_private;
   160		struct drm_encoder *encoder;
   161		int ret;
   162	
   163		/* Check before if we are supposed to have a sub-device... */
   164		if (!mipi_dsi->dsi_device)
   165			return -EPROBE_DEFER;
   166	
   167		mipi_dsi->priv = priv;
   168	
   169		return 0;
   170	}
   171	
   172	static const struct component_ops meson_dw_mipi_dsi_ops = {
   173		.bind	= meson_dw_mipi_dsi_bind,
   174	};
   175	
 > 176	static void meson_dw_mipi_dsi_hw_init(struct meson_dw_mipi_dsi *mipi_dsi)
   177	{
   178		writel_relaxed((1 << 4) | (1 << 5) | (0 << 6),
   179				mipi_dsi->base + MIPI_DSI_TOP_CNTL);
   180	
   181		writel_bits_relaxed(0xf, 0xf,
   182				    mipi_dsi->base + MIPI_DSI_TOP_SW_RESET);
   183		writel_bits_relaxed(0xf, 0,
   184				    mipi_dsi->base + MIPI_DSI_TOP_SW_RESET);
   185	
   186		writel_bits_relaxed(0x3, 0x3,
   187				    mipi_dsi->base + MIPI_DSI_TOP_CLK_CNTL);
   188	
   189		writel_relaxed(0, mipi_dsi->base + MIPI_DSI_TOP_MEM_PD);
   190	}
   191	
   192	static int meson_dw_mipi_dsi_host_attach(void *priv_data,
   193						 struct mipi_dsi_device *device)
   194	{
   195		struct meson_dw_mipi_dsi *mipi_dsi = priv_data;
   196		u32 reg;
   197	
   198		mipi_dsi->dsi_device = device;
   199	
 > 200		witch (device->format) {
 > 201		case MIPI_DSI_FMT_RGB888:
 > 202			dpi_data_format = COLOR_24BIT;
 > 203			venc_data_width = MIPI_DSI_VENC_COLOR_24B;
   204			break;
   205		case MIPI_DSI_FMT_RGB666:
   206			dpi_data_format = COLOR_18BIT_CFG_2;
   207			venc_data_width = MIPI_DSI_VENC_COLOR_18B;
   208			break;
   209		case MIPI_DSI_FMT_RGB666_PACKED:
   210		case MIPI_DSI_FMT_RGB565:
   211			DRM_DEV_ERROR(mipi_dsi->dev, "invalid pixel format %d\n", device->format);
   212			return -EINVAL;
   213		};
   214	
   215		phy_init(mipi_dsi->phy);
   216	
   217		return 0;
   218	}
   219	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

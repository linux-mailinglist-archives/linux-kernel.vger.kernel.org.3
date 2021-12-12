Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8700347179D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 02:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhLLB37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 20:29:59 -0500
Received: from mga06.intel.com ([134.134.136.31]:14217 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhLLB36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 20:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639272598; x=1670808598;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M12f23IFJgzzgyMm0+ogo637sJ8FnXS3RDq4TzoEXDg=;
  b=TGDySSyzAe8qo4v+Ayf9+JBzboYz8QHPZGJSDOzbETj/XZYyJWEvIkch
   LegDUrYsj/7qQeYtDt8hvLy1DhUgHaPwqdF711DztjC/JGYCbpzUJktyT
   f/pQm46N135zxt+KGXjbb9rJZ990N0XNP1e6bG687UCvOkJ8SK5/nLdOU
   OcPguh8swRiQii0NvohAmcVm+McS2L7puK6jOhQbKMQJr0+QelQzSPgH4
   PVJW0O2tKhrjHwkfA+ViGy4tY6++P8YhCZQOBWOqghULD6g8dLICUxm6X
   TK4fWU5E9toOoKnydCmNEgrbuA1gJVmEnPPDYGJlBGWuTeSC2orm5nO02
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10195"; a="299356072"
X-IronPort-AV: E=Sophos;i="5.88,199,1635231600"; 
   d="scan'208";a="299356072"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 17:29:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,199,1635231600"; 
   d="scan'208";a="464196825"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Dec 2021 17:29:56 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwDgZ-0005FX-Cy; Sun, 12 Dec 2021 01:29:55 +0000
Date:   Sun, 12 Dec 2021 09:29:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [superna9999:amlogic/v5.17/g12-dsi 6/23]
 drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:58:23: error: 'encoder_dsi'
 undeclared
Message-ID: <202112120900.1gurSnwO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/superna9999/linux amlogic/v5.17/g12-dsi
head:   62dac9179f2937dc08bffe08d15c6846bc4aedb4
commit: 02c9727464cf0ef4cebca0197a0f7395be6371f7 [6/23] fixup! drm/meson: add support for MIPI-DSI transceiver
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20211212/202112120900.1gurSnwO-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/superna9999/linux/commit/02c9727464cf0ef4cebca0197a0f7395be6371f7
        git remote add superna9999 https://github.com/superna9999/linux
        git fetch --no-tags superna9999 amlogic/v5.17/g12-dsi
        git checkout 02c9727464cf0ef4cebca0197a0f7395be6371f7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the superna9999/amlogic/v5.17/g12-dsi HEAD 62dac9179f2937dc08bffe08d15c6846bc4aedb4 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c: In function 'dw_mipi_dsi_phy_init':
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:58:23: error: 'encoder_dsi' undeclared (first use in this function)
      58 |         phy_configure(encoder_dsi->phy, &mipi_dsi->phy_opts);
         |                       ^~~~~~~~~~~
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:58:23: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:68:9: error: implicit declaration of function 'meson_dw_mipi_dsi_hw_init'; did you mean 'dw_mipi_dsi_phy_init'? [-Werror=implicit-function-declaration]
      68 |         meson_dw_mipi_dsi_hw_init(mipi_dsi);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
         |         dw_mipi_dsi_phy_init
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:72:35: error: 'COLOR_24BIT' undeclared (first use in this function)
      72 |                 dpi_data_format = COLOR_24BIT;
         |                                   ^~~~~~~~~~~
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:73:35: error: 'MIPI_DSI_VENC_COLOR_24B' undeclared (first use in this function)
      73 |                 venc_data_width = MIPI_DSI_VENC_COLOR_24B;
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:76:35: error: 'COLOR_18BIT_CFG_2' undeclared (first use in this function)
      76 |                 dpi_data_format = COLOR_18BIT_CFG_2;
         |                                   ^~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:77:35: error: 'MIPI_DSI_VENC_COLOR_18B' undeclared (first use in this function)
      77 |                 venc_data_width = MIPI_DSI_VENC_COLOR_18B;
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:70:9: warning: enumeration value 'MIPI_DSI_FMT_RGB666_PACKED' not handled in switch [-Wswitch]
      70 |         switch (mipi_dsi->dsi_device->format) {
         |         ^~~~~~
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:70:9: warning: enumeration value 'MIPI_DSI_FMT_RGB565' not handled in switch [-Wswitch]
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:89:59: error: macro "writel_relaxed" passed 3 arguments, but takes just 2
      89 |                         mipi_dsi->base + MIPI_DSI_TOP_CNTL);
         |                                                           ^
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/arm64/include/asm/hardirq.h:17,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from include/linux/regulator/consumer.h:35,
                    from include/linux/phy/phy.h:17,
                    from drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:15:
   arch/arm64/include/asm/io.h:127: note: macro "writel_relaxed" defined here
     127 | #define writel_relaxed(v,c)     ((void)__raw_writel((__force u32)cpu_to_le32(v),(c)))
         | 
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:82:9: error: 'writel_relaxed' undeclared (first use in this function)
      82 |         writel_relaxed((dpi_data_format  << BIT_DPI_COLOR_MODE)  |
         |         ^~~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:55:27: warning: unused variable 'priv' [-Wunused-variable]
      55 |         struct meson_drm *priv = mipi_dsi->priv;
         |                           ^~~~
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:54:39: warning: variable 'venc_data_width' set but not used [-Wunused-but-set-variable]
      54 |         unsigned int dpi_data_format, venc_data_width;
         |                                       ^~~~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:54:22: warning: variable 'dpi_data_format' set but not used [-Wunused-but-set-variable]
      54 |         unsigned int dpi_data_format, venc_data_width;
         |                      ^~~~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c: In function 'dw_mipi_dsi_get_lane_mbps':
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:111:24: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     111 |         mipi_dsi->mode = mode;
         |                        ^
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:113:15: error: implicit declaration of function 'encoder_dsi_pixel_format_to_bpp'; did you mean 'mipi_dsi_pixel_format_to_bpp'? [-Werror=implicit-function-declaration]
     113 |         bpp = encoder_dsi_pixel_format_to_bpp(mipi_dsi->dsi_device->format);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               mipi_dsi_pixel_format_to_bpp
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:116:47: error: 'encoder_dsi' undeclared (first use in this function)
     116 |                                          bpp, encoder_dsi->dsi_device->lanes,
         |                                               ^~~~~~~~~~~
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c: In function 'meson_dw_mipi_dsi_bind':
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:161:13: warning: unused variable 'ret' [-Wunused-variable]
     161 |         int ret;
         |             ^~~
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:160:29: warning: unused variable 'encoder' [-Wunused-variable]
     160 |         struct drm_encoder *encoder;
         |                             ^~~~~~~
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c: At top level:
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:176:13: warning: conflicting types for 'meson_dw_mipi_dsi_hw_init'; have 'void(struct meson_dw_mipi_dsi *)'
     176 | static void meson_dw_mipi_dsi_hw_init(struct meson_dw_mipi_dsi *mipi_dsi)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:176:13: error: static declaration of 'meson_dw_mipi_dsi_hw_init' follows non-static declaration
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:68:9: note: previous implicit declaration of 'meson_dw_mipi_dsi_hw_init' with type 'void(struct meson_dw_mipi_dsi *)'
      68 |         meson_dw_mipi_dsi_hw_init(mipi_dsi);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c: In function 'meson_dw_mipi_dsi_host_attach':
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:200:9: error: implicit declaration of function 'witch' [-Werror=implicit-function-declaration]
     200 |         witch (device->format) {
         |         ^~~~~
>> drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:200:31: error: expected ';' before '{' token
     200 |         witch (device->format) {
         |                               ^~
         |                               ;
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:196:13: warning: unused variable 'reg' [-Wunused-variable]
     196 |         u32 reg;
         |             ^~~
   At top level:
   drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:176:13: warning: 'meson_dw_mipi_dsi_hw_init' defined but not used [-Wunused-function]
     176 | static void meson_dw_mipi_dsi_hw_init(struct meson_dw_mipi_dsi *mipi_dsi)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


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
    70		switch (mipi_dsi->dsi_device->format) {
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
   111		mipi_dsi->mode = mode;
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
   176	static void meson_dw_mipi_dsi_hw_init(struct meson_dw_mipi_dsi *mipi_dsi)
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
   201		case MIPI_DSI_FMT_RGB888:
   202			dpi_data_format = COLOR_24BIT;
   203			venc_data_width = MIPI_DSI_VENC_COLOR_24B;
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

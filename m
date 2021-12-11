Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DAF47132A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 10:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhLKJ3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 04:29:55 -0500
Received: from mga09.intel.com ([134.134.136.24]:13008 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229839AbhLKJ3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 04:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639214994; x=1670750994;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8So2HJC3/O01dXcqAE4GVTQbmiKbuatHSsW1B/UZers=;
  b=ngeqfSKY69WIEfqImmjPMMGyjYSJdfjFPZh5B3x/KQ+A3EBkZE8eRPz9
   eGYSGHxrhXWHx8rR4Bc21h4nCKxGU2s5h9U6bq8AG21/ckY+as+pQo5Ca
   HUjyzwKL+WKPfUgAunxaskp5zlrqefrUWy7t/TaOLYs7CEeyiWcYYPWDz
   kLaoK4EaK6swxRIose2UpqOLs/K4iL9UgwGqrOu1Q86mEDwmCPAINa38c
   /LufSv0VnX33ZqN2ohQzqhnEuKrDasbXBChp4mtYEyCWn6g174wAglASQ
   l/C9yItSkA9vQGQkJk+JtkFTjwswOnIR+32MOZkEDavvDgfja+PwVauWo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="238330518"
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="238330518"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 01:29:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,198,1635231600"; 
   d="scan'208";a="613206419"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Dec 2021 01:29:36 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvyhD-0004Pq-PR; Sat, 11 Dec 2021 09:29:35 +0000
Date:   Sat, 11 Dec 2021 17:28:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [superna9999:amlogic/v5.17/g12-dsi 3/23]
 drivers/gpu/drm/meson/meson_encoder_dsi.c:240:9: error: implicit declaration
 of function 'meson_venc_encoder_dsi_mode_set'; did you mean
 'meson_encoder_dsi_mode_set'?
Message-ID: <202112111720.SAqWZOsV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/superna9999/linux amlogic/v5.17/g12-dsi
head:   62dac9179f2937dc08bffe08d15c6846bc4aedb4
commit: 6b197be782e0410bb911b74fb152daefccce6a29 [3/23] WIP: drm/meson: add DSI encoder
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20211211/202112111720.SAqWZOsV-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/superna9999/linux/commit/6b197be782e0410bb911b74fb152daefccce6a29
        git remote add superna9999 https://github.com/superna9999/linux
        git fetch --no-tags superna9999 amlogic/v5.17/g12-dsi
        git checkout 6b197be782e0410bb911b74fb152daefccce6a29
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the superna9999/amlogic/v5.17/g12-dsi HEAD 62dac9179f2937dc08bffe08d15c6846bc4aedb4 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   include/linux/byteorder/generic.h:89:21: note: in expansion of macro '__le32_to_cpu'
      89 | #define le32_to_cpu __le32_to_cpu
         |                     ^~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_registers.h:15:25: note: in expansion of macro 'readl_relaxed'
      15 |         writel_relaxed((readl_relaxed(addr) & ~(mask)) | ((val) & (mask)), addr)
         |                         ^~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:198:9: note: in expansion of macro 'writel_bits_relaxed'
     198 |         writel_bits_relaxed(0x3, 0x3,
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:199:49: error: 'MIPI_DSI_TOP_CLK_CNTL' undeclared (first use in this function)
     199 |                             encoder_dsi->base + MIPI_DSI_TOP_CLK_CNTL);
         |                                                 ^~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/byteorder/little_endian.h:33:51: note: in definition of macro '__cpu_to_le32'
      33 | #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
         |                                                   ^
   drivers/gpu/drm/meson/meson_registers.h:15:9: note: in expansion of macro 'writel_relaxed'
      15 |         writel_relaxed((readl_relaxed(addr) & ~(mask)) | ((val) & (mask)), addr)
         |         ^~~~~~~~~~~~~~
   include/linux/byteorder/generic.h:89:21: note: in expansion of macro '__le32_to_cpu'
      89 | #define le32_to_cpu __le32_to_cpu
         |                     ^~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_registers.h:15:25: note: in expansion of macro 'readl_relaxed'
      15 |         writel_relaxed((readl_relaxed(addr) & ~(mask)) | ((val) & (mask)), addr)
         |                         ^~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:198:9: note: in expansion of macro 'writel_bits_relaxed'
     198 |         writel_bits_relaxed(0x3, 0x3,
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/io.h:13,
                    from include/acpi/acpi_io.h:5,
                    from include/linux/acpi.h:35,
                    from include/linux/i2c.h:13,
                    from include/drm/drm_crtc.h:28,
                    from include/drm/drm_atomic_helper.h:31,
                    from drivers/gpu/drm/meson/meson_encoder_dsi.c:13:
   drivers/gpu/drm/meson/meson_encoder_dsi.c:199:40: error: 'struct meson_encoder_dsi' has no member named 'base'
     199 |                             encoder_dsi->base + MIPI_DSI_TOP_CLK_CNTL);
         |                                        ^~
   arch/arm64/include/asm/io.h:127:82: note: in definition of macro 'writel_relaxed'
     127 | #define writel_relaxed(v,c)     ((void)__raw_writel((__force u32)cpu_to_le32(v),(c)))
         |                                                                                  ^
   drivers/gpu/drm/meson/meson_encoder_dsi.c:198:9: note: in expansion of macro 'writel_bits_relaxed'
     198 |         writel_bits_relaxed(0x3, 0x3,
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:201:38: error: 'struct meson_encoder_dsi' has no member named 'base'
     201 |         writel_relaxed(0, encoder_dsi->base + MIPI_DSI_TOP_MEM_PD);
         |                                      ^~
   arch/arm64/include/asm/io.h:127:82: note: in definition of macro 'writel_relaxed'
     127 | #define writel_relaxed(v,c)     ((void)__raw_writel((__force u32)cpu_to_le32(v),(c)))
         |                                                                                  ^
   drivers/gpu/drm/meson/meson_encoder_dsi.c:201:47: error: 'MIPI_DSI_TOP_MEM_PD' undeclared (first use in this function)
     201 |         writel_relaxed(0, encoder_dsi->base + MIPI_DSI_TOP_MEM_PD);
         |                                               ^~~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/io.h:127:82: note: in definition of macro 'writel_relaxed'
     127 | #define writel_relaxed(v,c)     ((void)__raw_writel((__force u32)cpu_to_le32(v),(c)))
         |                                                                                  ^
   drivers/gpu/drm/meson/meson_encoder_dsi.c: In function 'meson_encoder_dsi_mode_set':
   drivers/gpu/drm/meson/meson_encoder_dsi.c:214:20: error: 'struct meson_encoder_dsi' has no member named 'mode_flags'
     214 |         encoder_dsi->mode_flags = mode->flags;
         |                    ^~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:216:15: error: implicit declaration of function 'encoder_dsi_pixel_format_to_bpp' [-Werror=implicit-function-declaration]
     216 |         bpp = encoder_dsi_pixel_format_to_bpp(mipi_dsi->dsi_device->format);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:216:47: error: 'mipi_dsi' undeclared (first use in this function)
     216 |         bpp = encoder_dsi_pixel_format_to_bpp(mipi_dsi->dsi_device->format);
         |                                               ^~~~~~~~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:218:9: error: implicit declaration of function 'phy_mipi_dphy_get_default_config' [-Werror=implicit-function-declaration]
     218 |         phy_mipi_dphy_get_default_config(mode->clock * 1000,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:219:58: error: 'struct meson_encoder_dsi' has no member named 'dsi_device'
     219 |                                          bpp, encoder_dsi->dsi_device->lanes,
         |                                                          ^~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:220:54: error: 'struct meson_encoder_dsi' has no member named 'phy_opts'
     220 |                                          &encoder_dsi->phy_opts.mipi_dphy);
         |                                                      ^~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:222:9: error: implicit declaration of function 'phy_configure'; did you mean 'of_dma_configure'? [-Werror=implicit-function-declaration]
     222 |         phy_configure(encoder_dsi->phy, &mipi_dsi->phy_opts);
         |         ^~~~~~~~~~~~~
         |         of_dma_configure
   drivers/gpu/drm/meson/meson_encoder_dsi.c:222:34: error: 'struct meson_encoder_dsi' has no member named 'phy'
     222 |         phy_configure(encoder_dsi->phy, &mipi_dsi->phy_opts);
         |                                  ^~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:224:28: error: 'struct meson_encoder_dsi' has no member named 'dsi_device'
     224 |         switch (encoder_dsi->dsi_device->format) {
         |                            ^~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:225:14: error: 'MIPI_DSI_FMT_RGB888' undeclared (first use in this function)
     225 |         case MIPI_DSI_FMT_RGB888:
         |              ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:229:14: error: 'MIPI_DSI_FMT_RGB666' undeclared (first use in this function)
     229 |         case MIPI_DSI_FMT_RGB666:
         |              ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:233:14: error: 'MIPI_DSI_FMT_RGB666_PACKED' undeclared (first use in this function)
     233 |         case MIPI_DSI_FMT_RGB666_PACKED:
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:234:14: error: 'MIPI_DSI_FMT_RGB565' undeclared (first use in this function)
     234 |         case MIPI_DSI_FMT_RGB565:
         |              ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:239:9: error: implicit declaration of function 'dw_encoder_dsi_set_vclk'; did you mean 'dw_mipi_dsi_set_vclk'? [-Werror=implicit-function-declaration]
     239 |         dw_encoder_dsi_set_vclk(mipi_dsi, mode);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
         |         dw_mipi_dsi_set_vclk
>> drivers/gpu/drm/meson/meson_encoder_dsi.c:240:9: error: implicit declaration of function 'meson_venc_encoder_dsi_mode_set'; did you mean 'meson_encoder_dsi_mode_set'? [-Werror=implicit-function-declaration]
     240 |         meson_venc_encoder_dsi_mode_set(priv, mode);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         meson_encoder_dsi_mode_set
   In file included from include/linux/byteorder/little_endian.h:5,
                    from arch/arm64/include/uapi/asm/byteorder.h:23,
                    from include/asm-generic/bitops/le.h:7,
                    from arch/arm64/include/asm/bitops.h:29,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:13,
                    from drivers/gpu/drm/meson/meson_encoder_dsi.c:8:
   drivers/gpu/drm/meson/meson_encoder_dsi.c:249:40: error: 'struct meson_encoder_dsi' has no member named 'base'
     249 |         reg = readl_relaxed(encoder_dsi->base + MIPI_DSI_TOP_CNTL) &
         |                                        ^~
   include/uapi/linux/byteorder/little_endian.h:34:51: note: in definition of macro '__le32_to_cpu'
      34 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   drivers/gpu/drm/meson/meson_encoder_dsi.c:249:15: note: in expansion of macro 'readl_relaxed'
     249 |         reg = readl_relaxed(encoder_dsi->base + MIPI_DSI_TOP_CNTL) &
         |               ^~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:249:49: error: 'MIPI_DSI_TOP_CNTL' undeclared (first use in this function)
     249 |         reg = readl_relaxed(encoder_dsi->base + MIPI_DSI_TOP_CNTL) &
         |                                                 ^~~~~~~~~~~~~~~~~
   include/uapi/linux/byteorder/little_endian.h:34:51: note: in definition of macro '__le32_to_cpu'
      34 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   drivers/gpu/drm/meson/meson_encoder_dsi.c:249:15: note: in expansion of macro 'readl_relaxed'
     249 |         reg = readl_relaxed(encoder_dsi->base + MIPI_DSI_TOP_CNTL) &
         |               ^~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:260:29: error: 'struct meson_encoder_dsi' has no member named 'mode_flags'
     260 |                 (encoder_dsi->mode_flags & DRM_MODE_FLAG_NHSYNC ? 0 : BIT(BIT_HSYNC_POL)) |
         |                             ^~
   include/uapi/linux/byteorder/little_endian.h:33:51: note: in definition of macro '__cpu_to_le32'
      33 | #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
         |                                                   ^
   drivers/gpu/drm/meson/meson_encoder_dsi.c:254:9: note: in expansion of macro 'writel_relaxed'
     254 |         writel_relaxed(reg |
         |         ^~~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:261:29: error: 'struct meson_encoder_dsi' has no member named 'mode_flags'
     261 |                 (encoder_dsi->mode_flags & DRM_MODE_FLAG_NVSYNC ? 0 : BIT(BIT_VSYNC_POL)),
         |                             ^~
   include/uapi/linux/byteorder/little_endian.h:33:51: note: in definition of macro '__cpu_to_le32'
      33 | #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
         |                                                   ^
   drivers/gpu/drm/meson/meson_encoder_dsi.c:254:9: note: in expansion of macro 'writel_relaxed'
     254 |         writel_relaxed(reg |
         |         ^~~~~~~~~~~~~~
   In file included from include/linux/io.h:13,
                    from include/acpi/acpi_io.h:5,
                    from include/linux/acpi.h:35,
                    from include/linux/i2c.h:13,
                    from include/drm/drm_crtc.h:28,
                    from include/drm/drm_atomic_helper.h:31,
                    from drivers/gpu/drm/meson/meson_encoder_dsi.c:13:
   drivers/gpu/drm/meson/meson_encoder_dsi.c:262:28: error: 'struct meson_encoder_dsi' has no member named 'base'
     262 |                 encoder_dsi->base + MIPI_DSI_TOP_CNTL);
         |                            ^~
   arch/arm64/include/asm/io.h:127:82: note: in definition of macro 'writel_relaxed'
     127 | #define writel_relaxed(v,c)     ((void)__raw_writel((__force u32)cpu_to_le32(v),(c)))
         |                                                                                  ^
   At top level:
   drivers/gpu/drm/meson/meson_encoder_dsi.c:140:13: warning: 'dw_mipi_dsi_set_vclk' defined but not used [-Wunused-function]
     140 | static void dw_mipi_dsi_set_vclk(struct meson_encoder_dsi *mipi_dsi,
         |             ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +240 drivers/gpu/drm/meson/meson_encoder_dsi.c

   203	
   204	static void meson_encoder_dsi_mode_set(struct drm_bridge *bridge,
   205					       const struct drm_display_mode *mode,
   206					       const struct drm_display_mode *adjusted_mode)
   207	{
   208		struct meson_encoder_dsi *encoder_dsi = bridge_to_meson_encoder_dsi(bridge);
   209		unsigned int dpi_data_format, venc_data_width;
   210		struct meson_drm *priv = encoder_dsi->priv;
   211		int bpp;
   212		u32 reg;
   213	
   214		encoder_dsi->mode_flags = mode->flags;
   215	
   216		bpp = encoder_dsi_pixel_format_to_bpp(mipi_dsi->dsi_device->format);
   217	
   218		phy_mipi_dphy_get_default_config(mode->clock * 1000,
   219						 bpp, encoder_dsi->dsi_device->lanes,
   220						 &encoder_dsi->phy_opts.mipi_dphy);
   221	
   222		phy_configure(encoder_dsi->phy, &mipi_dsi->phy_opts);
   223	
   224		switch (encoder_dsi->dsi_device->format) {
   225		case MIPI_DSI_FMT_RGB888:
   226			dpi_data_format = COLOR_24BIT;
   227			venc_data_width = MIPI_DSI_VENC_COLOR_24B;
   228			break;
   229		case MIPI_DSI_FMT_RGB666:
   230			dpi_data_format = COLOR_18BIT_CFG_2;
   231			venc_data_width = MIPI_DSI_VENC_COLOR_18B;
   232			break;
   233		case MIPI_DSI_FMT_RGB666_PACKED:
   234		case MIPI_DSI_FMT_RGB565:
   235			/* invalid */
   236			break;
   237		};
   238	
   239		dw_encoder_dsi_set_vclk(mipi_dsi, mode);
 > 240		meson_venc_encoder_dsi_mode_set(priv, mode);
   241	
   242		meson_encl_load_gamma(priv);
   243	
   244		writel_relaxed(0, priv->io_base + _REG(ENCL_VIDEO_EN));
   245	
   246		meson_encoder_dsi_hw_init(encoder_dsi);
   247	
   248		/* Configure Set color format for DPI register */
   249		reg = readl_relaxed(encoder_dsi->base + MIPI_DSI_TOP_CNTL) &
   250			~(0xf<<BIT_DPI_COLOR_MODE) &
   251			~(0x7<<BIT_IN_COLOR_MODE) &
   252			~(0x3<<BIT_CHROMA_SUBSAMPLE);
   253	
   254		writel_relaxed(reg |
   255			(dpi_data_format  << BIT_DPI_COLOR_MODE)  |
   256			(venc_data_width  << BIT_IN_COLOR_MODE) |
   257			0 << BIT_COMP0_SEL |
   258			1 << BIT_COMP1_SEL |
   259			2 << BIT_COMP2_SEL |
   260			(encoder_dsi->mode_flags & DRM_MODE_FLAG_NHSYNC ? 0 : BIT(BIT_HSYNC_POL)) |
   261			(encoder_dsi->mode_flags & DRM_MODE_FLAG_NVSYNC ? 0 : BIT(BIT_VSYNC_POL)),
   262			encoder_dsi->base + MIPI_DSI_TOP_CNTL);
   263	}
   264	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

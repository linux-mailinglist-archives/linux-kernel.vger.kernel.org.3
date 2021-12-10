Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC10B470DD4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 23:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbhLJWcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:32:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:26410 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233286AbhLJWcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639175321; x=1670711321;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xmD3p3e9IKDdcXcoMD3Ox5Fo/cp5Ctii6s+UoveBXec=;
  b=g2rqBMlRfjzqwYVNMxTk7AQErIGzTH1CqYuEsrqEncAuIF7sZDgHM3YL
   ysNIb7OpkhhCAZ8P0Myq0FJXmR9HH7+Vtm3+bqLqZHxwTak4Gp1Ez5/VM
   zintFOPaZY2IDBOA6rNKTSQJFus8sJkHxSLzhxOgHmMa7KIdAebyAzQry
   QABlHNGiux7XxoEL3yxzUGfLiS8nUL9EuNE6Wx92o7U7qpGFRkFLm05ty
   aFi9uzOm4YCMmstQh8Z26LNCHNYgJevyATjaaSAZbcdjLfdgyhBHr0JTl
   jtXqMUhXDHkRxWfRPOSDqk/CKCplHFFp1OFOptgPEoA6sNKpkG7j/kDz9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="262567947"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="262567947"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 14:28:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="581811198"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 10 Dec 2021 14:28:20 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvoNH-0003kQ-H5; Fri, 10 Dec 2021 22:28:19 +0000
Date:   Sat, 11 Dec 2021 06:28:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [superna9999:amlogic/v5.17/g12-dsi 20/23]
 drivers/gpu/drm/meson/meson_encoder_dsi.c:59:44: warning: passing argument 2
 of 'meson_venc_mipi_dsi_mode_set' discards 'const' qualifier from pointer
 target type
Message-ID: <202112110612.0VVbVR6R-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/superna9999/linux amlogic/v5.17/g12-dsi
head:   62dac9179f2937dc08bffe08d15c6846bc4aedb4
commit: b186318175a12bdca613ee26b4b452964c795eb3 [20/23] fixup! WIP: drm/meson: add DSI encoder
config: arm-randconfig-r013-20211210 (https://download.01.org/0day-ci/archive/20211211/202112110612.0VVbVR6R-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/superna9999/linux/commit/b186318175a12bdca613ee26b4b452964c795eb3
        git remote add superna9999 https://github.com/superna9999/linux
        git fetch --no-tags superna9999 amlogic/v5.17/g12-dsi
        git checkout b186318175a12bdca613ee26b4b452964c795eb3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/meson/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/meson/meson_encoder_dsi.c: In function 'meson_encoder_dsi_mode_set':
>> drivers/gpu/drm/meson/meson_encoder_dsi.c:59:44: warning: passing argument 2 of 'meson_venc_mipi_dsi_mode_set' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      59 |         meson_venc_mipi_dsi_mode_set(priv, mode);
         |                                            ^~~~
   In file included from drivers/gpu/drm/meson/meson_encoder_dsi.c:24:
   drivers/gpu/drm/meson/meson_venc.h:71:60: note: expected 'struct drm_display_mode *' but argument is of type 'const struct drm_display_mode *'
      71 |                                   struct drm_display_mode *mode);
         |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~


vim +59 drivers/gpu/drm/meson/meson_encoder_dsi.c

6b197be782e0410 Neil Armstrong 2021-12-09  47  
b186318175a12bd Neil Armstrong 2021-12-10  48  static void meson_encoder_dsi_mode_set(struct drm_bridge *bridge,
b186318175a12bd Neil Armstrong 2021-12-10  49  					const struct drm_display_mode *mode,
b186318175a12bd Neil Armstrong 2021-12-10  50  					const struct drm_display_mode *adjusted_mode)
6b197be782e0410 Neil Armstrong 2021-12-09  51  {
6b197be782e0410 Neil Armstrong 2021-12-09  52  	struct meson_encoder_dsi *encoder_dsi = bridge_to_meson_encoder_dsi(bridge);
6b197be782e0410 Neil Armstrong 2021-12-09  53  	struct meson_drm *priv = encoder_dsi->priv;
6b197be782e0410 Neil Armstrong 2021-12-09  54  
b186318175a12bd Neil Armstrong 2021-12-10  55  	pr_err("%s:%d\n", __func__, __LINE__);
6b197be782e0410 Neil Armstrong 2021-12-09  56  
b186318175a12bd Neil Armstrong 2021-12-10  57  	meson_vclk_setup(priv, MESON_VCLK_TARGET_DSI, mode->clock, 0, 0, 0, false);
6b197be782e0410 Neil Armstrong 2021-12-09  58  
d521159dd8a9966 Neil Armstrong 2021-12-10 @59  	meson_venc_mipi_dsi_mode_set(priv, mode);
e1e87e576f5befb Neil Armstrong 2021-12-09  60  	meson_encl_load_gamma(priv);
6b197be782e0410 Neil Armstrong 2021-12-09  61  
b186318175a12bd Neil Armstrong 2021-12-10  62  	writel_relaxed(0, priv->io_base + _REG(ENCL_VIDEO_EN));
b186318175a12bd Neil Armstrong 2021-12-10  63  
e1e87e576f5befb Neil Armstrong 2021-12-09  64  	writel_bits_relaxed(BIT(3), BIT(3), priv->io_base + _REG(ENCL_VIDEO_MODE_ADV));
e1e87e576f5befb Neil Armstrong 2021-12-09  65  	writel_relaxed(0, priv->io_base + _REG(ENCL_TST_EN));
b186318175a12bd Neil Armstrong 2021-12-10  66  }
b186318175a12bd Neil Armstrong 2021-12-10  67  

:::::: The code at line 59 was first introduced by commit
:::::: d521159dd8a996678230b50e4ecafcdf50648c52 fixup! WIP: drm/meson: add DSI encoder

:::::: TO: Neil Armstrong <narmstrong@baylibre.com>
:::::: CC: Neil Armstrong <narmstrong@baylibre.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32704714F9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 18:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhLKRiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 12:38:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:41679 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhLKRiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 12:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639244330; x=1670780330;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9MNkMuYmAK445lv4ib50HWvZyNwJwXrpIY20jQOUPfw=;
  b=DGqaWEGcYNed++xxX9qvB4kvvGXoFMh2PvIogF31xvsNslA3PeVCN3O4
   Y7z/aGkJJjRGP+Qur/HuBIDBWsv62GI8qMbjItoBCUCMyU+3rsG/NvhbC
   cCToZoDlB4ceWUnJGY6nh0md4/8u/41EtWYqKiz9YPX9RboFuENZSmW0u
   7ilSUFtDTFHzLbm2rCat3MHsNxQpk1SKgygJTDw10aYkxHZz/HKIr5R9s
   XLvIvXHPqL2Lg4AlkZpO4gFl0dG/mBh5fMx4VucMnI+1I+iKRZRbA7TES
   FwX6wTIAnM1AiKDXmVpJm6++cGwgvlho5aetKBuDPgi1K2B7cttdFsP/F
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10195"; a="225822736"
X-IronPort-AV: E=Sophos;i="5.88,198,1635231600"; 
   d="scan'208";a="225822736"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 09:38:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,198,1635231600"; 
   d="scan'208";a="517769913"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 11 Dec 2021 09:38:48 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mw6Kd-0004sc-Bc; Sat, 11 Dec 2021 17:38:47 +0000
Date:   Sun, 12 Dec 2021 01:38:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [superna9999:amlogic/v5.17/g12-dsi 5/23]
 drivers/gpu/drm/meson/meson_encoder_dsi.c:72:9: error: implicit declaration
 of function 'meson_vclk_setup'
Message-ID: <202112120146.AUKDx0AX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/superna9999/linux amlogic/v5.17/g12-dsi
head:   62dac9179f2937dc08bffe08d15c6846bc4aedb4
commit: e1e87e576f5befbf752a2c7b9c019328f1742d71 [5/23] fixup! WIP: drm/meson: add DSI encoder
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20211212/202112120146.AUKDx0AX-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/superna9999/linux/commit/e1e87e576f5befbf752a2c7b9c019328f1742d71
        git remote add superna9999 https://github.com/superna9999/linux
        git fetch --no-tags superna9999 amlogic/v5.17/g12-dsi
        git checkout e1e87e576f5befbf752a2c7b9c019328f1742d71
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the superna9999/amlogic/v5.17/g12-dsi HEAD 62dac9179f2937dc08bffe08d15c6846bc4aedb4 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   drivers/gpu/drm/meson/meson_encoder_dsi.c: In function 'meson_encoder_dsi_atomic_enable':
>> drivers/gpu/drm/meson/meson_encoder_dsi.c:72:9: error: implicit declaration of function 'meson_vclk_setup' [-Werror=implicit-function-declaration]
      72 |         meson_vclk_setup(priv, MESON_VCLK_TARGET_DSI, mode->clock * 1000, 0, 0, 0, false);
         |         ^~~~~~~~~~~~~~~~
>> drivers/gpu/drm/meson/meson_encoder_dsi.c:72:32: error: 'MESON_VCLK_TARGET_DSI' undeclared (first use in this function)
      72 |         meson_vclk_setup(priv, MESON_VCLK_TARGET_DSI, mode->clock * 1000, 0, 0, 0, false);
         |                                ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:72:32: note: each undeclared identifier is reported only once for each function it appears in
   drivers/gpu/drm/meson/meson_encoder_dsi.c:74:9: error: implicit declaration of function 'meson_venc_encoder_dsi_mode_set'; did you mean 'meson_venc_mipi_dsi_mode_set'? [-Werror=implicit-function-declaration]
      74 |         meson_venc_encoder_dsi_mode_set(priv, mode);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         meson_venc_mipi_dsi_mode_set
   drivers/gpu/drm/meson/meson_encoder_dsi.c: At top level:
>> drivers/gpu/drm/meson/meson_encoder_dsi.c:96:27: error: 'meson_encoder_dsi_atomic_check' undeclared here (not in a function); did you mean 'meson_encoder_dsi_atomic_enable'?
      96 |         .atomic_check   = meson_encoder_dsi_atomic_check,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                           meson_encoder_dsi_atomic_enable
   drivers/gpu/drm/meson/meson_encoder_dsi.c:84:13: warning: 'meson_encoder_dsi_atomic_disable' defined but not used [-Wunused-function]
      84 | static void meson_encoder_dsi_atomic_disable(struct drm_bridge *bridge,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:45:13: warning: 'meson_encoder_dsi_atomic_enable' defined but not used [-Wunused-function]
      45 | static void meson_encoder_dsi_atomic_enable(struct drm_bridge *bridge,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/meson_vclk_setup +72 drivers/gpu/drm/meson/meson_encoder_dsi.c

    44	
    45	static void meson_encoder_dsi_atomic_enable(struct drm_bridge *bridge,
    46						     struct drm_bridge_state *bridge_state)
    47	{
    48		struct meson_encoder_dsi *encoder_dsi = bridge_to_meson_encoder_dsi(bridge);
    49		struct drm_atomic_state *state = bridge_state->base.state;
    50		struct meson_drm *priv = encoder_dsi->priv;
    51		struct drm_connector_state *conn_state;
    52		struct drm_crtc_state *crtc_state;
    53		struct drm_connector *connector;
    54		struct drm_display_mode *mode;
    55	
    56		connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
    57		if (WARN_ON(!connector))
    58			return;
    59	
    60		conn_state = drm_atomic_get_new_connector_state(state, connector);
    61		if (WARN_ON(!conn_state))
    62			return;
    63	
    64		crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
    65		if (WARN_ON(!crtc_state))
    66			return;
    67	
    68		mode = &crtc_state->adjusted_mode;
    69		if (WARN_ON(!mode))
    70			return;
    71	
  > 72		meson_vclk_setup(priv, MESON_VCLK_TARGET_DSI, mode->clock * 1000, 0, 0, 0, false);
    73	
    74		meson_venc_encoder_dsi_mode_set(priv, mode);
    75	
    76		meson_encl_load_gamma(priv);
    77	
    78		writel_bits_relaxed(BIT(3), BIT(3), priv->io_base + _REG(ENCL_VIDEO_MODE_ADV));
    79		writel_relaxed(0, priv->io_base + _REG(ENCL_TST_EN));
    80	
    81		writel_relaxed(1, priv->io_base + _REG(ENCL_VIDEO_EN));
    82	}
    83	
    84	static void meson_encoder_dsi_atomic_disable(struct drm_bridge *bridge,
    85						      struct drm_bridge_state *bridge_state)
    86	{
    87		struct meson_encoder_dsi *meson_encoder_dsi =
    88						bridge_to_meson_encoder_dsi(bridge);
    89		struct meson_drm *priv = meson_encoder_dsi->priv;
    90	
    91		writel_relaxed(0, priv->io_base + _REG(ENCL_VIDEO_EN));
    92	}
    93	
    94	static const struct drm_bridge_funcs meson_encoder_dsi_bridge_funcs = {
    95		.attach		= meson_encoder_dsi_attach,
  > 96		.atomic_check	= meson_encoder_dsi_atomic_check,
    97		.atomic_enable	= meson_encoder_dsi_atomic_check,
    98		.atomic_disable	= meson_encoder_dsi_atomic_check,
    99		.atomic_check = meson_encoder_dsi_atomic_check,
   100		.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
   101		.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
   102		.atomic_reset = drm_atomic_helper_bridge_reset,
   103	};
   104	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

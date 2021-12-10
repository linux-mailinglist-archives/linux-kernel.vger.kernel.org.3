Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2AE46FC69
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhLJIPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:15:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:4194 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230205AbhLJIPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639123921; x=1670659921;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZP84rRNV8kIAEoQp8NeSWuxxSG5ROIfE4yZl49EkSaM=;
  b=PiFnS2Q/OmAj7e6EUSWSKTlU2enPDElAGB+v6jrxFOh2+/PSYAzRNkv3
   twTYHN82rEfTEWmvtM/L5xvi5UBF0kHHUOEo3NrhsBWZocNfNDt3BpfTM
   4nh18nYzKnbp4aUmMeoGiarzhytCCNHn43X7eLpaR6dqm8LqS9/Am/+tx
   fUUnhhi1UIwwMK7hdRLCPfUhNsLLzBrW0bqx/oQkc0r6IGANfXKkmr18o
   5dzQ2E+xKmU2vjNuc1oW/fyPjOBCLI2Okgf+CzkTRbh0ioLaCPDhrBN3j
   kJEIORVCzshGHu2oM9nU99RMKgvbiC8KmG/vLEKvlLBRn9HCE6ctm3bE3
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="218323381"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="218323381"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 00:12:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="680666584"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Dec 2021 00:11:58 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvb0Y-0002xE-9p; Fri, 10 Dec 2021 08:11:58 +0000
Date:   Fri, 10 Dec 2021 16:11:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [superna9999:amlogic/v5.17/g12-dsi 5/7]
 drivers/gpu/drm/meson/meson_encoder_dsi.c:72:2: error: implicit declaration
 of function 'meson_vclk_setup'
Message-ID: <202112101636.y17bk2Zb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/superna9999/linux amlogic/v5.17/g12-dsi
head:   cc44c3ce92a63f2c59a3f0ac03e6defd41542940
commit: e1e87e576f5befbf752a2c7b9c019328f1742d71 [5/7] fixup! WIP: drm/meson: add DSI encoder
config: arm-randconfig-r034-20211210 (https://download.01.org/0day-ci/archive/20211210/202112101636.y17bk2Zb-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/superna9999/linux/commit/e1e87e576f5befbf752a2c7b9c019328f1742d71
        git remote add superna9999 https://github.com/superna9999/linux
        git fetch --no-tags superna9999 amlogic/v5.17/g12-dsi
        git checkout e1e87e576f5befbf752a2c7b9c019328f1742d71
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/meson/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/meson/meson_encoder_dsi.c:72:2: error: implicit declaration of function 'meson_vclk_setup' [-Werror,-Wimplicit-function-declaration]
           meson_vclk_setup(priv, MESON_VCLK_TARGET_DSI, mode->clock * 1000, 0, 0, 0, false);
           ^
>> drivers/gpu/drm/meson/meson_encoder_dsi.c:72:25: error: use of undeclared identifier 'MESON_VCLK_TARGET_DSI'
           meson_vclk_setup(priv, MESON_VCLK_TARGET_DSI, mode->clock * 1000, 0, 0, 0, false);
                                  ^
>> drivers/gpu/drm/meson/meson_encoder_dsi.c:74:2: error: implicit declaration of function 'meson_venc_encoder_dsi_mode_set' [-Werror,-Wimplicit-function-declaration]
           meson_venc_encoder_dsi_mode_set(priv, mode);
           ^
   drivers/gpu/drm/meson/meson_encoder_dsi.c:74:2: note: did you mean 'meson_venc_mipi_dsi_mode_set'?
   drivers/gpu/drm/meson/meson_venc.h:70:6: note: 'meson_venc_mipi_dsi_mode_set' declared here
   void meson_venc_mipi_dsi_mode_set(struct meson_drm *priv,
        ^
>> drivers/gpu/drm/meson/meson_encoder_dsi.c:96:18: error: use of undeclared identifier 'meson_encoder_dsi_atomic_check'; did you mean 'meson_encoder_dsi_atomic_enable'?
           .atomic_check   = meson_encoder_dsi_atomic_check,
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                             meson_encoder_dsi_atomic_enable
   drivers/gpu/drm/meson/meson_encoder_dsi.c:45:13: note: 'meson_encoder_dsi_atomic_enable' declared here
   static void meson_encoder_dsi_atomic_enable(struct drm_bridge *bridge,
               ^
   drivers/gpu/drm/meson/meson_encoder_dsi.c:97:19: error: use of undeclared identifier 'meson_encoder_dsi_atomic_check'; did you mean 'meson_encoder_dsi_atomic_enable'?
           .atomic_enable  = meson_encoder_dsi_atomic_check,
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                             meson_encoder_dsi_atomic_enable
   drivers/gpu/drm/meson/meson_encoder_dsi.c:45:13: note: 'meson_encoder_dsi_atomic_enable' declared here
   static void meson_encoder_dsi_atomic_enable(struct drm_bridge *bridge,
               ^
   drivers/gpu/drm/meson/meson_encoder_dsi.c:98:20: error: use of undeclared identifier 'meson_encoder_dsi_atomic_check'; did you mean 'meson_encoder_dsi_atomic_enable'?
           .atomic_disable = meson_encoder_dsi_atomic_check,
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                             meson_encoder_dsi_atomic_enable
   drivers/gpu/drm/meson/meson_encoder_dsi.c:45:13: note: 'meson_encoder_dsi_atomic_enable' declared here
   static void meson_encoder_dsi_atomic_enable(struct drm_bridge *bridge,
               ^
   drivers/gpu/drm/meson/meson_encoder_dsi.c:99:18: error: use of undeclared identifier 'meson_encoder_dsi_atomic_check'; did you mean 'meson_encoder_dsi_atomic_enable'?
           .atomic_check = meson_encoder_dsi_atomic_check,
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                           meson_encoder_dsi_atomic_enable
   drivers/gpu/drm/meson/meson_encoder_dsi.c:45:13: note: 'meson_encoder_dsi_atomic_enable' declared here
   static void meson_encoder_dsi_atomic_enable(struct drm_bridge *bridge,
               ^
>> drivers/gpu/drm/meson/meson_encoder_dsi.c:96:18: error: incompatible function pointer types initializing 'int (*)(struct drm_bridge *, struct drm_bridge_state *, struct drm_crtc_state *, struct drm_connector_state *)' with an expression of type 'void (struct drm_bridge *, struct drm_bridge_state *)' [-Werror,-Wincompatible-function-pointer-types]
           .atomic_check   = meson_encoder_dsi_atomic_check,
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:99:18: error: incompatible function pointer types initializing 'int (*)(struct drm_bridge *, struct drm_bridge_state *, struct drm_crtc_state *, struct drm_connector_state *)' with an expression of type 'void (struct drm_bridge *, struct drm_bridge_state *)' [-Werror,-Wincompatible-function-pointer-types]
           .atomic_check = meson_encoder_dsi_atomic_check,
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:99:18: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           .atomic_check = meson_encoder_dsi_atomic_check,
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/meson/meson_encoder_dsi.c:96:18: note: previous initialization is here
           .atomic_check   = meson_encoder_dsi_atomic_check,
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 9 errors generated.


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
  > 74		meson_venc_encoder_dsi_mode_set(priv, mode);
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
  > 99		.atomic_check = meson_encoder_dsi_atomic_check,
   100		.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
   101		.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
   102		.atomic_reset = drm_atomic_helper_bridge_reset,
   103	};
   104	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

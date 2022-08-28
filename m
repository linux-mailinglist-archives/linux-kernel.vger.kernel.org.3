Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455F95A3D68
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 13:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiH1Lv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 07:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiH1Lv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 07:51:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383C211A0D
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 04:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661687516; x=1693223516;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QK/jFmyPvCbmTTWCkm0uJvOI7SQREGdmJHxT01UAxgw=;
  b=WIHQKUlqWQtdrEQgj5C2DDxnNuqqlkeeJT4EjgvDaqipsRjM1dZU9kNl
   prDMMAoH40kLsTCU4FOXEvmhK9nr9OZaZJT5gyEkbORnu2f5BcPe7zJiU
   yy1qjNlwG7vefE0LXF91omD5flsePM0cRvuTjOG/Hn/p9ZIP3sBCeXCV2
   iuZ50lMC2qS+ZMhjXDNFuoM2uNuub9Jqfddyc84KMUzQdIRMqx6vAdsey
   hfF5hyTus8TA5IUQSWiawrkTN2zZhNdmAD/wqZYtfB/gQN3OkZkG0gESm
   VUcTzgygdgol7JPZQ6LdwPgRpn245yGhBPraa/WWol8caSsfVF4YF5Cgn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10452"; a="277748199"
X-IronPort-AV: E=Sophos;i="5.93,270,1654585200"; 
   d="scan'208";a="277748199"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 04:51:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,270,1654585200"; 
   d="scan'208";a="611010904"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Aug 2022 04:51:54 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSGpV-00013X-2a;
        Sun, 28 Aug 2022 11:51:53 +0000
Date:   Sun, 28 Aug 2022 19:51:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [lst:imx8mp-hdmi 5/11]
 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c:76:11: warning: variable
 'bus_flags' is used uninitialized whenever 'if' condition is false
Message-ID: <202208281910.qUZY1Xem-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.pengutronix.de/git/lst/linux imx8mp-hdmi
head:   7e80a6e2d0a4709e471ab951a64d323534a6776f
commit: b3d9e9dfedb64ed82e797a87259e6f7598f5b4d5 [5/11] drm/imx: add driver for HDMI TX Parallel Video Interface
config: riscv-randconfig-c006-20220828 (https://download.01.org/0day-ci/archive/20220828/202208281910.qUZY1Xem-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project a2100daf12fb980a29fd1a9c85ccf8eaaaf79730)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        git remote add lst https://git.pengutronix.de/git/lst/linux
        git fetch --no-tags lst imx8mp-hdmi
        git checkout b3d9e9dfedb64ed82e797a87259e6f7598f5b4d5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/drm/bridge/imx/ drivers/gpu/drm/rcar-du/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c:76:11: warning: variable 'bus_flags' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           else if (bridge_state)
                    ^~~~~~~~~~~~
   drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c:79:6: note: uninitialized use occurs here
           if (bus_flags & DRM_BUS_FLAG_DE_HIGH)
               ^~~~~~~~~
   drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c:76:7: note: remove the 'if' if its condition is always true
           else if (bridge_state)
                ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c:55:15: note: initialize the variable 'bus_flags' to silence this warning
           u32 bus_flags, val;
                        ^
                         = 0
   1 warning generated.


vim +76 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c

    45	
    46	static void imx_hdmi_pvi_bridge_enable(struct drm_bridge *bridge,
    47					       struct drm_bridge_state *bridge_state)
    48	{
    49		struct drm_atomic_state *state = bridge_state->base.state;
    50		struct imx_hdmi_pvi *pvi = to_imx_hdmi_pvi(bridge);
    51		struct drm_connector_state *conn_state;
    52		const struct drm_display_mode *mode;
    53		struct drm_crtc_state *crtc_state;
    54		struct drm_connector *connector;
    55		u32 bus_flags, val;
    56	
    57		connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
    58		conn_state = drm_atomic_get_new_connector_state(state, connector);
    59		crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
    60	
    61		if (WARN_ON(pm_runtime_resume_and_get(pvi->dev)))
    62			return;
    63	
    64		mode = &crtc_state->adjusted_mode;
    65	
    66		val = PVI_CTL_INPUT_LCDIF;
    67	
    68		if (mode->flags & DRM_MODE_FLAG_PVSYNC)
    69			val |= PVI_CTL_OP_VSYNC_POL | PVI_CTL_INP_VSYNC_POL;
    70	
    71		if (mode->flags & DRM_MODE_FLAG_PHSYNC)
    72			val |= PVI_CTL_OP_HSYNC_POL | PVI_CTL_INP_HSYNC_POL;
    73	
    74		if (pvi->next_bridge->timings)
    75			bus_flags = pvi->next_bridge->timings->input_bus_flags;
  > 76		else if (bridge_state)
    77			bus_flags = bridge_state->input_bus_cfg.flags;
    78	
    79		if (bus_flags & DRM_BUS_FLAG_DE_HIGH)
    80			val |= PVI_CTL_OP_DE_POL | PVI_CTL_INP_DE_POL;
    81	
    82		writel(val, pvi->regs + HTX_PVI_CTL);
    83		val |= PVI_CTL_EN;
    84		writel(val, pvi->regs + HTX_PVI_CTL);
    85	}
    86	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

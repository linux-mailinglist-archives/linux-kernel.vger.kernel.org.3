Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CAB5A7CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiHaMFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiHaMFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:05:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916CBBE36
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661947509; x=1693483509;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Op5UlvE87KQlkVBfbfPxtK4iG+euMcqZycNT21H5YCQ=;
  b=d4JPvquDCp7pp/wlGZnURBKnpYiOgvuRBhNqLuP8Itpyfb1Bisp4b+4o
   vcUfyD14GNgXEz1mzTw7nrdLhh1Jg7HiRDhcaeL4nwknfdsgb9i7Ak7cH
   Gb3LYJ4+4h+DYiTC7SW340guoJQ8WutMex2G53WXDssSC8OBmAdNd9uH9
   HPejA8jNTNufXjlogYVP/hDvHspvs8LoFpLSaI7MoWXK2PmjdF3IUX7Uv
   n5zVE1WWWcqeNHMBZ/xTl3EjI681S1z5lhuARRs+rTOPTJGxCVNq6OLC7
   3xlheTXU5v6QvIOZUH42BECgxQDkAE9Yq4bdksMIOSHql2/g1nDqaSx3q
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="294171259"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="294171259"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 05:05:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="589006240"
Received: from lkp-server02.sh.intel.com (HELO 811e2ceaf0e5) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 31 Aug 2022 05:05:07 -0700
Received: from kbuild by 811e2ceaf0e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTMSx-0000Fm-1A;
        Wed, 31 Aug 2022 12:05:07 +0000
Date:   Wed, 31 Aug 2022 20:04:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [lst:imx8mp-hdmi 5/11]
 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c:82:9: error: implicit
 declaration of function 'writel'
Message-ID: <202208312049.OpEghiNW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.pengutronix.de/git/lst/linux imx8mp-hdmi
head:   7e80a6e2d0a4709e471ab951a64d323534a6776f
commit: b3d9e9dfedb64ed82e797a87259e6f7598f5b4d5 [5/11] drm/imx: add driver for HDMI TX Parallel Video Interface
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20220831/202208312049.OpEghiNW-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add lst https://git.pengutronix.de/git/lst/linux
        git fetch --no-tags lst imx8mp-hdmi
        git checkout b3d9e9dfedb64ed82e797a87259e6f7598f5b4d5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c: In function 'imx_hdmi_pvi_bridge_enable':
>> drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c:82:9: error: implicit declaration of function 'writel' [-Werror=implicit-function-declaration]
      82 |         writel(val, pvi->regs + HTX_PVI_CTL);
         |         ^~~~~~
   cc1: some warnings being treated as errors


vim +/writel +82 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c

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
    76		else if (bridge_state)
    77			bus_flags = bridge_state->input_bus_cfg.flags;
    78	
    79		if (bus_flags & DRM_BUS_FLAG_DE_HIGH)
    80			val |= PVI_CTL_OP_DE_POL | PVI_CTL_INP_DE_POL;
    81	
  > 82		writel(val, pvi->regs + HTX_PVI_CTL);
    83		val |= PVI_CTL_EN;
    84		writel(val, pvi->regs + HTX_PVI_CTL);
    85	}
    86	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

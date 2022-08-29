Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884D55A46CA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiH2KJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2KI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:08:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB445FAD4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661767735; x=1693303735;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g3fWelCB9GlHqJ3QYBhk2+nJix61se1jmQC7NvJg4HU=;
  b=aDjgTUs5esTxiVR9ypqyR2a9UP6ojzNkZ5yM+X9U1N4o0J4aEKtEtGHd
   sfdkCzhv73AP5VhUBvE21HHmrX4Snv3NwFq5KxyjO3EcLulvOJ9ZjFNqO
   sKLzWbB0ycWe+GZEloVnOBfYC11mUqZ7J0eHUnjEYw99auxdYZuOhvxVo
   ch83cAJ/BDSOJisCdBf+bHa1bWI3FJywd1Rrapq9gEB/LzjGVqQsmbWht
   lQmllBt4l0jWUgmmuT0otoXLj4qaYm+83rvZaAnhwLSfRp9hiwKP6Ww5L
   NiC7x/J2fpyye+eetPThYg2Eb/+6CHLEVNeJlKGQ8mqdUNl5VY9llbEaZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="295636214"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="295636214"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 03:08:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="640882537"
Received: from lkp-server01.sh.intel.com (HELO b2bbdd52f619) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Aug 2022 03:08:44 -0700
Received: from kbuild by b2bbdd52f619 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSbhD-0000WY-2M;
        Mon, 29 Aug 2022 10:08:43 +0000
Date:   Mon, 29 Aug 2022 18:07:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [pinchartl-media:drm/du/next 13/14]
 drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:614:6: warning: no previous
 prototype for 'rcar_mipi_dsi_pclk_enable'
Message-ID: <202208291831.Xfw1ORoE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/pinchartl/media.git drm/du/next
head:   1a1ef49313becc3127e3bd2b6cdb27e5fc54f761
commit: 81c238208c6accde5592851b101986b8b91ec859 [13/14] drm: rcar-du: Fix DSI enable & disable sequence
config: arc-randconfig-r043-20220828 (https://download.01.org/0day-ci/archive/20220829/202208291831.Xfw1ORoE-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add pinchartl-media git://linuxtv.org/pinchartl/media.git
        git fetch --no-tags pinchartl-media drm/du/next
        git checkout 81c238208c6accde5592851b101986b8b91ec859
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/gpu/drm/rcar-du/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:614:6: warning: no previous prototype for 'rcar_mipi_dsi_pclk_enable' [-Wmissing-prototypes]
     614 | void rcar_mipi_dsi_pclk_enable(struct drm_bridge *bridge,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:653:6: warning: no previous prototype for 'rcar_mipi_dsi_pclk_disable' [-Wmissing-prototypes]
     653 | void rcar_mipi_dsi_pclk_disable(struct drm_bridge *bridge)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/rcar_mipi_dsi_pclk_enable +614 drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c

   613	
 > 614	void rcar_mipi_dsi_pclk_enable(struct drm_bridge *bridge,
   615				       struct drm_atomic_state *state)
   616	{
   617		struct rcar_mipi_dsi *dsi = bridge_to_rcar_mipi_dsi(bridge);
   618		const struct drm_display_mode *mode;
   619		struct drm_connector *connector;
   620		struct drm_crtc *crtc;
   621		int ret;
   622	
   623		connector = drm_atomic_get_new_connector_for_encoder(state,
   624								     bridge->encoder);
   625		crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
   626		mode = &drm_atomic_get_new_crtc_state(state, crtc)->adjusted_mode;
   627	
   628		ret = rcar_mipi_dsi_clk_enable(dsi);
   629		if (ret < 0) {
   630			dev_err(dsi->dev, "failed to enable DSI clocks\n");
   631			return;
   632		}
   633	
   634		ret = rcar_mipi_dsi_startup(dsi, mode);
   635		if (ret < 0)
   636			goto err_dsi_startup;
   637	
   638		rcar_mipi_dsi_set_display_timing(dsi, mode);
   639	
   640		ret = rcar_mipi_dsi_start_hs_clock(dsi);
   641		if (ret < 0)
   642			goto err_dsi_start_hs;
   643	
   644		return;
   645	
   646	err_dsi_start_hs:
   647		rcar_mipi_dsi_shutdown(dsi);
   648	err_dsi_startup:
   649		rcar_mipi_dsi_clk_disable(dsi);
   650	}
   651	EXPORT_SYMBOL_GPL(rcar_mipi_dsi_pclk_enable);
   652	
 > 653	void rcar_mipi_dsi_pclk_disable(struct drm_bridge *bridge)
   654	{
   655		struct rcar_mipi_dsi *dsi = bridge_to_rcar_mipi_dsi(bridge);
   656	
   657		rcar_mipi_dsi_shutdown(dsi);
   658		rcar_mipi_dsi_clk_disable(dsi);
   659	}
   660	EXPORT_SYMBOL_GPL(rcar_mipi_dsi_pclk_disable);
   661	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

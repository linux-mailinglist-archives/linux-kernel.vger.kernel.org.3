Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C95154A0DA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351016AbiFMVHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349148AbiFMVGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:06:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2A4B26
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655152983; x=1686688983;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Wxp5UrEGniWquPRir9qG4Wn/ZLM32hC17iMaC9mtEfU=;
  b=H+RETdYE5gY5tOZlq2a79GPD13lLW7Hy7O6Fm+DeE+LHo8OyYxbUlfSu
   CcArfcsMxaAUdpG2vzCL42sWdIBiY6Wrg6nqsawomMF4e/x5dDSJK7jAP
   N4SA11ozJ6AFTX5CEjNvGxBI44dQble77NOf0y+iHXnrCOLGkjMicD3Ak
   Po5atkahNNFsu9yjMDNCG9GG/Sgnb+NBW/fvWkcfkkscqdWj/+zPC5AuY
   6uJt86iO1WjJ0K8XHNtVVeD7DOYnRYl/ejJIkDxhw2B+NGlg8XOPJ6zTc
   KuIgd3y2u3XbW6RYF3lTw6TLK/z9Cuinq470KpsfCHtJySELQQg0zykQc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="267097802"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="267097802"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 13:43:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="910586588"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jun 2022 13:43:00 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0qtn-000L87-T5;
        Mon, 13 Jun 2022 20:42:59 +0000
Date:   Tue, 14 Jun 2022 04:42:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: [jsarha:topic/chromeos-4.19-s0ix 7737/9999]
 drivers/gpu/drm/bridge/parade-ps8640.c:399:5: warning: no previous prototype
 for function 'ps8640_bridge_attach'
Message-ID: <202206140423.YnAsdC2D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

FYI, the error/warning still remains.

tree:   https://github.com/jsarha/linux topic/chromeos-4.19-s0ix
head:   430bdaa0a8c38697780f45a148964d71951df11f
commit: e09a9439c5a794b24f73e6909d8eba778e3e3041 [7737/9999] FIXUP: FROMLIST: drm/bridge: Add I2C based driver for ps8640 bridge
config: x86_64-randconfig-a001-20220613 (https://download.01.org/0day-ci/archive/20220614/202206140423.YnAsdC2D-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d378268ead93c85803c270277f0243737b536ae7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/e09a9439c5a794b24f73e6909d8eba778e3e3041
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/chromeos-4.19-s0ix
        git checkout e09a9439c5a794b24f73e6909d8eba778e3e3041
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/bridge/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/bridge/parade-ps8640.c:399:5: warning: no previous prototype for function 'ps8640_bridge_attach' [-Wmissing-prototypes]
   int ps8640_bridge_attach(struct drm_bridge *bridge)
       ^
   drivers/gpu/drm/bridge/parade-ps8640.c:399:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int ps8640_bridge_attach(struct drm_bridge *bridge)
   ^
   static 
   1 warning generated.


vim +/ps8640_bridge_attach +399 drivers/gpu/drm/bridge/parade-ps8640.c

71e4156c5ec43f7 Jitao Shi    2016-11-14  398  
71e4156c5ec43f7 Jitao Shi    2016-11-14 @399  int ps8640_bridge_attach(struct drm_bridge *bridge)
71e4156c5ec43f7 Jitao Shi    2016-11-14  400  {
71e4156c5ec43f7 Jitao Shi    2016-11-14  401  	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
71e4156c5ec43f7 Jitao Shi    2016-11-14  402  	struct device *dev = &ps_bridge->page[0]->dev;
71e4156c5ec43f7 Jitao Shi    2016-11-14  403  	struct device_node *in_ep, *dsi_node = NULL;
71e4156c5ec43f7 Jitao Shi    2016-11-14  404  	struct mipi_dsi_device *dsi;
71e4156c5ec43f7 Jitao Shi    2016-11-14  405  	struct mipi_dsi_host *host = NULL;
71e4156c5ec43f7 Jitao Shi    2016-11-14  406  	int ret;
71e4156c5ec43f7 Jitao Shi    2016-11-14  407  	const struct mipi_dsi_device_info info = { .type = "ps8640",
71e4156c5ec43f7 Jitao Shi    2016-11-14  408  						   .channel = 0,
71e4156c5ec43f7 Jitao Shi    2016-11-14  409  						   .node = NULL,
71e4156c5ec43f7 Jitao Shi    2016-11-14  410  						 };
71e4156c5ec43f7 Jitao Shi    2016-11-14  411  
71e4156c5ec43f7 Jitao Shi    2016-11-14  412  	ret = drm_connector_init(bridge->dev, &ps_bridge->connector,
71e4156c5ec43f7 Jitao Shi    2016-11-14  413  				 &ps8640_connector_funcs,
71e4156c5ec43f7 Jitao Shi    2016-11-14  414  				 DRM_MODE_CONNECTOR_eDP);
71e4156c5ec43f7 Jitao Shi    2016-11-14  415  
71e4156c5ec43f7 Jitao Shi    2016-11-14  416  	if (ret) {
71e4156c5ec43f7 Jitao Shi    2016-11-14  417  		DRM_ERROR("Failed to initialize connector with drm: %d\n", ret);
71e4156c5ec43f7 Jitao Shi    2016-11-14  418  		return ret;
71e4156c5ec43f7 Jitao Shi    2016-11-14  419  	}
71e4156c5ec43f7 Jitao Shi    2016-11-14  420  
71e4156c5ec43f7 Jitao Shi    2016-11-14  421  	drm_connector_helper_add(&ps_bridge->connector,
71e4156c5ec43f7 Jitao Shi    2016-11-14  422  				 &ps8640_connector_helper_funcs);
71e4156c5ec43f7 Jitao Shi    2016-11-14  423  
71e4156c5ec43f7 Jitao Shi    2016-11-14  424  	ps_bridge->connector.dpms = DRM_MODE_DPMS_ON;
e09a9439c5a794b Hsin-Yi Wang 2019-07-18  425  	drm_connector_attach_encoder(&ps_bridge->connector,
71e4156c5ec43f7 Jitao Shi    2016-11-14  426  					  bridge->encoder);
71e4156c5ec43f7 Jitao Shi    2016-11-14  427  
71e4156c5ec43f7 Jitao Shi    2016-11-14  428  	if (ps_bridge->panel)
71e4156c5ec43f7 Jitao Shi    2016-11-14  429  		drm_panel_attach(ps_bridge->panel, &ps_bridge->connector);
71e4156c5ec43f7 Jitao Shi    2016-11-14  430  
71e4156c5ec43f7 Jitao Shi    2016-11-14  431  	/* port@0 is ps8640 dsi input port */
71e4156c5ec43f7 Jitao Shi    2016-11-14  432  	in_ep = of_graph_get_endpoint_by_regs(dev->of_node, 0, -1);
71e4156c5ec43f7 Jitao Shi    2016-11-14  433  	if (in_ep) {
71e4156c5ec43f7 Jitao Shi    2016-11-14  434  		dsi_node = of_graph_get_remote_port_parent(in_ep);
71e4156c5ec43f7 Jitao Shi    2016-11-14  435  		of_node_put(in_ep);
71e4156c5ec43f7 Jitao Shi    2016-11-14  436  	}
71e4156c5ec43f7 Jitao Shi    2016-11-14  437  
71e4156c5ec43f7 Jitao Shi    2016-11-14  438  	if (dsi_node) {
71e4156c5ec43f7 Jitao Shi    2016-11-14  439  		host = of_find_mipi_dsi_host_by_node(dsi_node);
71e4156c5ec43f7 Jitao Shi    2016-11-14  440  		of_node_put(dsi_node);
71e4156c5ec43f7 Jitao Shi    2016-11-14  441  		if (!host) {
71e4156c5ec43f7 Jitao Shi    2016-11-14  442  			ret = -ENODEV;
71e4156c5ec43f7 Jitao Shi    2016-11-14  443  			goto err;
71e4156c5ec43f7 Jitao Shi    2016-11-14  444  		}
71e4156c5ec43f7 Jitao Shi    2016-11-14  445  	}
71e4156c5ec43f7 Jitao Shi    2016-11-14  446  
71e4156c5ec43f7 Jitao Shi    2016-11-14  447  	dsi = mipi_dsi_device_register_full(host, &info);
71e4156c5ec43f7 Jitao Shi    2016-11-14  448  	if (IS_ERR(dsi)) {
71e4156c5ec43f7 Jitao Shi    2016-11-14  449  		dev_err(dev, "failed to create dsi device\n");
71e4156c5ec43f7 Jitao Shi    2016-11-14  450  		ret = PTR_ERR(dsi);
71e4156c5ec43f7 Jitao Shi    2016-11-14  451  		goto err;
71e4156c5ec43f7 Jitao Shi    2016-11-14  452  	}
71e4156c5ec43f7 Jitao Shi    2016-11-14  453  
71e4156c5ec43f7 Jitao Shi    2016-11-14  454  	ps_bridge->dsi = dsi;
71e4156c5ec43f7 Jitao Shi    2016-11-14  455  
71e4156c5ec43f7 Jitao Shi    2016-11-14  456  	dsi->host = host;
71e4156c5ec43f7 Jitao Shi    2016-11-14  457  	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
71e4156c5ec43f7 Jitao Shi    2016-11-14  458  				     MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
71e4156c5ec43f7 Jitao Shi    2016-11-14  459  	dsi->format = MIPI_DSI_FMT_RGB888;
71e4156c5ec43f7 Jitao Shi    2016-11-14  460  	dsi->lanes = 4;
71e4156c5ec43f7 Jitao Shi    2016-11-14  461  	ret = mipi_dsi_attach(dsi);
71e4156c5ec43f7 Jitao Shi    2016-11-14  462  	if (ret)
71e4156c5ec43f7 Jitao Shi    2016-11-14  463  		goto err_dsi_attach;
71e4156c5ec43f7 Jitao Shi    2016-11-14  464  
71e4156c5ec43f7 Jitao Shi    2016-11-14  465  	return 0;
71e4156c5ec43f7 Jitao Shi    2016-11-14  466  
71e4156c5ec43f7 Jitao Shi    2016-11-14  467  err_dsi_attach:
71e4156c5ec43f7 Jitao Shi    2016-11-14  468  	mipi_dsi_device_unregister(dsi);
71e4156c5ec43f7 Jitao Shi    2016-11-14  469  err:
71e4156c5ec43f7 Jitao Shi    2016-11-14  470  	if (ps_bridge->panel)
71e4156c5ec43f7 Jitao Shi    2016-11-14  471  		drm_panel_detach(ps_bridge->panel);
71e4156c5ec43f7 Jitao Shi    2016-11-14  472  	drm_connector_cleanup(&ps_bridge->connector);
71e4156c5ec43f7 Jitao Shi    2016-11-14  473  	return ret;
71e4156c5ec43f7 Jitao Shi    2016-11-14  474  }
71e4156c5ec43f7 Jitao Shi    2016-11-14  475  

:::::: The code at line 399 was first introduced by commit
:::::: 71e4156c5ec43f72077bb1f50882f588cfd71d71 FROMLIST: drm/bridge: Add I2C based driver for ps8640 bridge

:::::: TO: Jitao Shi <jitao.shi@mediatek.com>
:::::: CC: Commit Bot <commit-bot@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

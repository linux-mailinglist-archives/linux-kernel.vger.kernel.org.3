Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB2152B34A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiERHQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiERHQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:16:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C42F7CB34
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652858185; x=1684394185;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PcRevddGN/h5sqx6Ciz2gc2PYJvQVhE5R6wwNzzDbC0=;
  b=SHZutk/uC01wQDzLVJ4ygHPSCOmzjpjrfOglcwV0pFJWWp/pzfh5hB0o
   UcmDmZ5My8HohNDM3ksjc0a9+GB7B6Gf+lopjP7e2l4fB2yCMqxpNZYbl
   KcxsDdDPxKlOR1wzlNWF2pu8cVszJPts/DknWo6Q8gQn+4Eg8ZPVAW7ZM
   puQVkyoD/BfLgA2SO7u9nrPJy05pxt7gsKVun7N4FJwavRzK6zdQTpt4m
   Bn2dAj8Aef7cheB41XLnXnNbHB3n7y754gLdVlq6Qc81C5LUYm3Dx92G3
   LtHFVmZhEatK46YWnZ9NABMRDe0rs7syGvO+pSXhgjXa4vMoBVTnafLoV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="271653186"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="271653186"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 00:16:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="523383739"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 18 May 2022 00:16:22 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrDuw-0001v3-5N;
        Wed, 18 May 2022 07:16:22 +0000
Date:   Wed, 18 May 2022 15:16:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Robert Foss <robert.foss@linaro.org>
Subject: [drm-misc:drm-misc-next 2/2]
 drivers/gpu/drm/bridge/analogix/anx7625.c:1643:18: error: use of undeclared
 identifier 'V4L2_FWNODE_BUS_TYPE_DPI'
Message-ID: <202205181514.UVkvf0YL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
head:   315a8d00ac74c59a688a1a88c0ed97a7791d1c91
commit: a77c2af0994e24ee36c7ffb6dc852770bdf06fb1 [2/2] drm/bridge: anx7625: Use DPI bus type
config: arm-buildonly-randconfig-r001-20220518 (https://download.01.org/0day-ci/archive/20220518/202205181514.UVkvf0YL-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 853fa8ee225edf2d0de94b0dcbd31bea916e825e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc drm-misc-next
        git checkout a77c2af0994e24ee36c7ffb6dc852770bdf06fb1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/bridge/analogix/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/bridge/analogix/anx7625.c:1643:18: error: use of undeclared identifier 'V4L2_FWNODE_BUS_TYPE_DPI'
           if (bus_type == V4L2_FWNODE_BUS_TYPE_DPI) /* bus type is DPI */
                           ^
   1 error generated.


vim +/V4L2_FWNODE_BUS_TYPE_DPI +1643 drivers/gpu/drm/bridge/analogix/anx7625.c

  1617	
  1618	static int anx7625_parse_dt(struct device *dev,
  1619				    struct anx7625_platform_data *pdata)
  1620	{
  1621		struct device_node *np = dev->of_node, *ep0;
  1622		int bus_type, mipi_lanes;
  1623	
  1624		anx7625_get_swing_setting(dev, pdata);
  1625	
  1626		pdata->is_dpi = 0; /* default dsi mode */
  1627		pdata->mipi_host_node = of_graph_get_remote_node(np, 0, 0);
  1628		if (!pdata->mipi_host_node) {
  1629			DRM_DEV_ERROR(dev, "fail to get internal panel.\n");
  1630			return -ENODEV;
  1631		}
  1632	
  1633		bus_type = 0;
  1634		mipi_lanes = MAX_LANES_SUPPORT;
  1635		ep0 = of_graph_get_endpoint_by_regs(np, 0, 0);
  1636		if (ep0) {
  1637			if (of_property_read_u32(ep0, "bus-type", &bus_type))
  1638				bus_type = 0;
  1639	
  1640			mipi_lanes = of_property_count_u32_elems(ep0, "data-lanes");
  1641		}
  1642	
> 1643		if (bus_type == V4L2_FWNODE_BUS_TYPE_DPI) /* bus type is DPI */
  1644			pdata->is_dpi = 1;
  1645	
  1646		pdata->mipi_lanes = mipi_lanes;
  1647		if (pdata->mipi_lanes > MAX_LANES_SUPPORT || pdata->mipi_lanes <= 0)
  1648			pdata->mipi_lanes = MAX_LANES_SUPPORT;
  1649	
  1650		if (pdata->is_dpi)
  1651			DRM_DEV_DEBUG_DRIVER(dev, "found MIPI DPI host node.\n");
  1652		else
  1653			DRM_DEV_DEBUG_DRIVER(dev, "found MIPI DSI host node.\n");
  1654	
  1655		if (of_property_read_bool(np, "analogix,audio-enable"))
  1656			pdata->audio_en = 1;
  1657	
  1658		pdata->panel_bridge = devm_drm_of_get_bridge(dev, np, 1, 0);
  1659		if (IS_ERR(pdata->panel_bridge)) {
  1660			if (PTR_ERR(pdata->panel_bridge) == -ENODEV)
  1661				return 0;
  1662	
  1663			return PTR_ERR(pdata->panel_bridge);
  1664		}
  1665	
  1666		DRM_DEV_DEBUG_DRIVER(dev, "get panel node.\n");
  1667	
  1668		return 0;
  1669	}
  1670	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

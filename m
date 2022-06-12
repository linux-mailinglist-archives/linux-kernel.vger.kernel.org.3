Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB91D547A2C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 14:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbiFLMtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 08:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiFLMtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 08:49:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7D462A3D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 05:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655038149; x=1686574149;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1UfxJ/4PxtKCS1GyskBJ35N4/akDZ2e7tjGbpMByFm0=;
  b=Crrlfz6rLLvzo8DMgrMCjTb6U6RbYA8HtYWEn54CbChepieIpymbId00
   qwAJPHP/ozf+kIogbUvKCXuqoADyOs3unbCi1OB53wApwbKRn/zEyyvgS
   1z8+pkJuy1iEL0+fvQTJrvuZrB81Ah43H/YRrWxWRvTNnaZeXhSlF0B6B
   p9j7G/bEiUQVsI/ct4t5A6M6jGCPyGQYnwfKf799I2i+jNQM71TIB5tmK
   EcaE73m+rOaaeFuyVa7blV3hOXRlX0kGEWVZqpLoXYBFxSxbXWGmyWg6H
   Zz8kzr1i7VifdEXuVmCKVriR/Mw7/Rc1r36koHnWquaDMHdIODh2x4ffn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="342039400"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="342039400"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 05:49:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="829206875"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jun 2022 05:49:07 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0N1f-000JvJ-1m;
        Sun, 12 Jun 2022 12:49:07 +0000
Date:   Sun, 12 Jun 2022 20:48:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marek Vasut <marex@denx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>
Subject: [drm-misc:for-linux-next 10/10]
 drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:683:13: warning: unused variable
 'data_lanes'
Message-ID: <202206122009.urQLG05k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc for-linux-next
head:   d643daaf1694b7565fbe3982b630e1c7b95f1600
commit: d643daaf1694b7565fbe3982b630e1c7b95f1600 [10/10] drm/bridge: rcar: Convert to drm_of_get_data_lanes_count_ep
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220612/202206122009.urQLG05k-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc for-linux-next
        git checkout d643daaf1694b7565fbe3982b630e1c7b95f1600
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/rcar-du/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c: In function 'rcar_mipi_dsi_parse_dt':
>> drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:683:13: warning: unused variable 'data_lanes' [-Wunused-variable]
     683 |         u32 data_lanes[4];
         |             ^~~~~~~~~~
>> drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:682:29: warning: unused variable 'ep' [-Wunused-variable]
     682 |         struct device_node *ep;
         |                             ^~


vim +/data_lanes +683 drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c

155358310f013c LUU HOAI    2020-02-25  675  
155358310f013c LUU HOAI    2020-02-25  676  /* -----------------------------------------------------------------------------
155358310f013c LUU HOAI    2020-02-25  677   * Probe & Remove
155358310f013c LUU HOAI    2020-02-25  678   */
155358310f013c LUU HOAI    2020-02-25  679  
155358310f013c LUU HOAI    2020-02-25  680  static int rcar_mipi_dsi_parse_dt(struct rcar_mipi_dsi *dsi)
155358310f013c LUU HOAI    2020-02-25  681  {
155358310f013c LUU HOAI    2020-02-25 @682  	struct device_node *ep;
155358310f013c LUU HOAI    2020-02-25 @683  	u32 data_lanes[4];
155358310f013c LUU HOAI    2020-02-25  684  	int ret;
155358310f013c LUU HOAI    2020-02-25  685  
d643daaf1694b7 Marek Vasut 2022-05-24  686  	ret = drm_of_get_data_lanes_count_ep(dsi->dev->of_node, 1, 0, 1, 4);
155358310f013c LUU HOAI    2020-02-25  687  	if (ret < 0) {
155358310f013c LUU HOAI    2020-02-25  688  		dev_err(dsi->dev, "missing or invalid data-lanes property\n");
d643daaf1694b7 Marek Vasut 2022-05-24  689  		return ret;
155358310f013c LUU HOAI    2020-02-25  690  	}
155358310f013c LUU HOAI    2020-02-25  691  
155358310f013c LUU HOAI    2020-02-25  692  	dsi->num_data_lanes = ret;
155358310f013c LUU HOAI    2020-02-25  693  	return 0;
155358310f013c LUU HOAI    2020-02-25  694  }
155358310f013c LUU HOAI    2020-02-25  695  

:::::: The code at line 683 was first introduced by commit
:::::: 155358310f013c23c2e5533e007afc7310c9a964 drm: rcar-du: Add R-Car DSI driver

:::::: TO: LUU HOAI <hoai.luu.ub@renesas.com>
:::::: CC: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

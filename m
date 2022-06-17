Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE92D54FB7B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382150AbiFQQus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379637AbiFQQuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:50:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF3E5548A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 09:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655484579; x=1687020579;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=668uDU/sASSfAktCzQOI/YXPVgTX1rB+v9u1BzSgtFc=;
  b=VDp++cESgqycfEcCgsChPC47s6kpVGJw9TS1qZ2YweBPCgBAh2qg+N1A
   +zLr/dQST3Azf4EOmLx5S2IHJrxDP0RoJQcYBflAKi3fs3kNHXsLk4mq9
   eGpPrid8EuMwKuN63udIRpOlEk850dWMQrJLd01Vny2CV+606mr8NtCDe
   +GpnqhdmrGJbRacMaVBmFIE0BdBvSrzk7CEOvBmPYQ5L7gCg+GIVatjO5
   sduS/fTnDEdGVZo9GVspeTHtU2Avn9WIORKkmeVOlKgx+HsEmK5p3+zei
   EW1unTb5kNvgsmVhe33uPmNpSg84bPCtCzQVcPrDv1KKOi8hStKicx5yL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="277062079"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="277062079"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 09:26:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="832077675"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jun 2022 09:26:49 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2Eo4-000PbN-Ig;
        Fri, 17 Jun 2022 16:26:48 +0000
Date:   Sat, 18 Jun 2022 00:26:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [superna9999:amlogic/v5.20/g12-dsi-wip 9/12]
 drivers/gpu/drm/meson/meson_venc.c:1595:10: error: call to undeclared
 function 'FIELD_PREP'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202206180004.GHjxyBau-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/superna9999/linux amlogic/v5.20/g12-dsi-wip
head:   0e725ea0a5ab9f70fc54c2e76475b8d594b90c4e
commit: 927953782b0c6c12a73654c526a12678e348f817 [9/12] drm/meson: venc: add ENCL encoder setup for MIPI-DSI output
config: arm-randconfig-r014-20220617 (https://download.01.org/0day-ci/archive/20220618/202206180004.GHjxyBau-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d764aa7fc6b9cc3fbe960019018f5f9e941eb0a6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/superna9999/linux/commit/927953782b0c6c12a73654c526a12678e348f817
        git remote add superna9999 https://github.com/superna9999/linux
        git fetch --no-tags superna9999 amlogic/v5.20/g12-dsi-wip
        git checkout 927953782b0c6c12a73654c526a12678e348f817
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/meson/meson_venc.c:1595:10: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                          FIELD_PREP(L_GAMMA_ADDR_PORT_ADDR, 0),
                          ^
   1 error generated.


vim +/FIELD_PREP +1595 drivers/gpu/drm/meson/meson_venc.c

  1579	
  1580	static void meson_encl_set_gamma_table(struct meson_drm *priv, u16 *data,
  1581					       u32 rgb_mask)
  1582	{
  1583		int i, ret;
  1584		u32 reg;
  1585	
  1586		writel_bits_relaxed(L_GAMMA_CNTL_PORT_EN, 0,
  1587				    priv->io_base + _REG(L_GAMMA_CNTL_PORT));
  1588	
  1589		ret = readl_relaxed_poll_timeout(priv->io_base + _REG(L_GAMMA_CNTL_PORT),
  1590						 reg, reg & L_GAMMA_CNTL_PORT_ADR_RDY, 10, 10000);
  1591		if (ret)
  1592			pr_warn("%s: GAMMA ADR_RDY timeout\n", __func__);
  1593	
  1594		writel_relaxed(L_GAMMA_ADDR_PORT_AUTO_INC | rgb_mask |
> 1595			       FIELD_PREP(L_GAMMA_ADDR_PORT_ADDR, 0),
  1596			       priv->io_base + _REG(L_GAMMA_ADDR_PORT));
  1597	
  1598		for (i = 0; i < 256; i++) {
  1599			ret = readl_relaxed_poll_timeout(priv->io_base + _REG(L_GAMMA_CNTL_PORT),
  1600							 reg, reg & L_GAMMA_CNTL_PORT_WR_RDY,
  1601							 10, 10000);
  1602			if (ret)
  1603				pr_warn_once("%s: GAMMA WR_RDY timeout\n", __func__);
  1604	
  1605			writel_relaxed(data[i], priv->io_base + _REG(L_GAMMA_DATA_PORT));
  1606		}
  1607	
  1608		ret = readl_relaxed_poll_timeout(priv->io_base + _REG(L_GAMMA_CNTL_PORT),
  1609						 reg, reg & L_GAMMA_CNTL_PORT_ADR_RDY, 10, 10000);
  1610		if (ret)
  1611			pr_warn("%s: GAMMA ADR_RDY timeout\n", __func__);
  1612	
  1613		writel_relaxed(L_GAMMA_ADDR_PORT_AUTO_INC | rgb_mask |
  1614			       FIELD_PREP(L_GAMMA_ADDR_PORT_ADDR, 0x23),
  1615			       priv->io_base + _REG(L_GAMMA_ADDR_PORT));
  1616	}
  1617	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392B054FF73
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbiFQVnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 17:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiFQVm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 17:42:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB41C4ECD1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 14:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655502178; x=1687038178;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tsC1UYTW6tqwJqLZjBUGPm4JXqGrmAf6pIOJLQbo394=;
  b=JKZKx0yhtMjHSu4UWTHf7/J+Z0lMwiZEqDlkQdTMiP7qTUEsWvwzsb86
   SCNKluag/JEAIv4yxf8giwh7xvYNMx/UK3pEj6Gp5aPI47dDuzEeFb9ps
   CiDooFbVS17F/DdzqDg2OT87gwd8n0hH8RYFaF36U//KCshEaYCtoK8No
   0MtAxek7YpDaxVwJl/XSXK5MhBJIiAYqw5JqY55eUuTWZMV7/ip7q767d
   Kjbb5GahOjvXy2fCFq5ulndqmaSSEDqg5IvOXZYVm5N9DKZUKivnHNpa/
   1oP5sEvDdlsVKMImGNuYxSBud36kYZyW1njEjS+B3zOEiqQQG+QLZ5YXK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="341275751"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="341275751"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 14:42:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="590279401"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jun 2022 14:42:56 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2Jk0-000Pmt-8B;
        Fri, 17 Jun 2022 21:42:56 +0000
Date:   Sat, 18 Jun 2022 05:42:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [superna9999:amlogic/v5.20/g12-dsi-wip 9/12]
 drivers/gpu/drm/meson/meson_venc.c:1595:24: error: implicit declaration of
 function 'FIELD_PREP'
Message-ID: <202206180526.1HnD8Zji-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220618/202206180526.1HnD8Zji-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/superna9999/linux/commit/927953782b0c6c12a73654c526a12678e348f817
        git remote add superna9999 https://github.com/superna9999/linux
        git fetch --no-tags superna9999 amlogic/v5.20/g12-dsi-wip
        git checkout 927953782b0c6c12a73654c526a12678e348f817
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/meson/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/byteorder/little_endian.h:5,
                    from arch/arm/include/uapi/asm/byteorder.h:22,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/arm/include/asm/bitops.h:267,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from include/linux/iopoll.h:9,
                    from drivers/gpu/drm/meson/meson_venc.c:9:
   drivers/gpu/drm/meson/meson_venc.c: In function 'meson_encl_set_gamma_table':
>> drivers/gpu/drm/meson/meson_venc.c:1595:24: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
    1595 |                        FIELD_PREP(L_GAMMA_ADDR_PORT_ADDR, 0),
         |                        ^~~~~~~~~~
   include/uapi/linux/byteorder/little_endian.h:34:51: note: in definition of macro '__cpu_to_le32'
      34 | #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
         |                                                   ^
   drivers/gpu/drm/meson/meson_venc.c:1594:9: note: in expansion of macro 'writel_relaxed'
    1594 |         writel_relaxed(L_GAMMA_ADDR_PORT_AUTO_INC | rgb_mask |
         |         ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


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

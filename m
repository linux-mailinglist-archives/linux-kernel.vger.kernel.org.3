Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53FF4A3E09
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 08:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357840AbiAaHBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 02:01:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:6602 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237178AbiAaHBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 02:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643612476; x=1675148476;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bIIPSPk9j3893WY4BHn/uAWFa+5hVRenFO3kph0qOEc=;
  b=f9cS/pTg/pEkxEb7Df09bV7puuSIoAq9A6rW12Scmycc/411wK/l260K
   VTCUvfyVm2iieqQGMBiPMtWshCutPLRulBKTzkc2giSAc4oYw+1ymnjjb
   tRDJA8oB4UVoXdodS3hL/ZZPoorvC7y0PInaOrKcAoT9xB76QdcOaHG4o
   RJYqT5u1H2K2myoP8068OEjinrFY3ggfT1LwBoZ0Rek/F4ddEeBO8ARMy
   USZPUTaBqSUjZuXmSEjWeX6u2M5eHfztI6Ooe4Zfvoohv8mjx0JJTzh/1
   oGV8a6LMtk2YVFUosT+cWVFpcV0ZhMMwhWB5U6LmL5mwGKFdtoQ8b7FuC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="308140117"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="308140117"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 23:01:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="481649049"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 30 Jan 2022 23:01:13 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEQga-000RcP-O0; Mon, 31 Jan 2022 07:01:12 +0000
Date:   Mon, 31 Jan 2022 15:00:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [superna9999:amlogic/v5.18/g12-dsi-wip 11/14]
 drivers/gpu/drm/meson/meson_venc.c:1595:24: error: implicit declaration of
 function 'FIELD_PREP'
Message-ID: <202201311418.VbkoxAhu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/superna9999/linux amlogic/v5.18/g12-dsi-wip
head:   fbcc0a7f53880919dc415da44339313dd59768f0
commit: edf28ef6ab9df27f29b301443df825cf6a5ce233 [11/14] drm/meson: venc: add ENCL encoder setup for MIPI-DSI output
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220131/202201311418.VbkoxAhu-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/superna9999/linux/commit/edf28ef6ab9df27f29b301443df825cf6a5ce233
        git remote add superna9999 https://github.com/superna9999/linux
        git fetch --no-tags superna9999 amlogic/v5.18/g12-dsi-wip
        git checkout edf28ef6ab9df27f29b301443df825cf6a5ce233
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/swab.h:5,
                    from include/uapi/linux/byteorder/big_endian.h:13,
                    from include/linux/byteorder/big_endian.h:5,
                    from arch/arm/include/uapi/asm/byteorder.h:20,
                    from include/asm-generic/bitops/le.h:7,
                    from arch/arm/include/asm/bitops.h:268,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:13,
                    from include/linux/iopoll.h:9,
                    from drivers/gpu/drm/meson/meson_venc.c:9:
   drivers/gpu/drm/meson/meson_venc.c: In function 'meson_encl_set_gamma_table':
>> drivers/gpu/drm/meson/meson_venc.c:1595:24: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
    1595 |                        FIELD_PREP(L_GAMMA_ADDR_PORT_ADDR, 0),
         |                        ^~~~~~~~~~
   include/uapi/linux/swab.h:115:54: note: in definition of macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   include/linux/byteorder/generic.h:88:21: note: in expansion of macro '__cpu_to_le32'
      88 | #define cpu_to_le32 __cpu_to_le32
         |                     ^~~~~~~~~~~~~
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

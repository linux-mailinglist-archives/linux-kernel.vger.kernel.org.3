Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84B949A0FC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1848654AbiAXXXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:23:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:52617 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1588580AbiAXWd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643063603; x=1674599603;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tiOqC+YWUvtyr8cm/6FJsbU9NS5AZTGBWl4YTiFLuE8=;
  b=IjQ2k88tNlDdmWojeK1CZmda64IUJG+ElgukhIUz3erdDN/xPQMqgHqH
   7HpX2QlnrzStIBdqov3Ak+mLE3wPd75i0gqpTh7btL6k08aFRNW+3yMvT
   VjtXDQ4UGSt0AXuAcrt98vuoldZNEGleWQa+2yRGn3wKBZOS9ZZ1s3MEi
   3mCTxnP2BNivYdbzJnGxZ/DaoGVH6+kSp09lxjhyPWh+IFI4SoMbCzQeH
   VnME7XmAPQV+YgpR2RVSIceqjWx2e+/Bu0N1+PbQl+ROMm5qnYqpaeq2k
   P0LdXF5TbekcyUEtJuRiubpNLTGtIgz2wekhGEWntZUt7ujlL5kudsma6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="243760667"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="243760667"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 14:24:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="617403066"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jan 2022 14:24:10 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nC7kv-000IzK-Mt; Mon, 24 Jan 2022 22:24:09 +0000
Date:   Tue, 25 Jan 2022 06:23:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: dtbs_check: arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml:
 i2s@3830000: 'assigned-clock-rates' does not match any of the regexes:
 'pinctrl-[0-9]+'
Message-ID: <202201250436.5gEafGrM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
commit: 58dfff3e984dfb96dae98008e6ea0ab92248d003 dt-bindings: Drop unnecessary pinctrl properties
date:   4 days ago
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce: make ARCH=arm dtbs_check

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


dtcheck warnings: (new ones prefixed by >>)
   arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml:0:0: /soc/pinctrl@13400000/wakeup-interrupt-controller: failed to match any schema with compatible: ['samsung,exynos4210-wakeup-eint']
   arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml:0:0: /soc/pinctrl@13410000: failed to match any schema with compatible: ['samsung,exynos5420-pinctrl']
   arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml:0:0: /soc/pinctrl@14000000: failed to match any schema with compatible: ['samsung,exynos5420-pinctrl']
   arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml:0:0: /soc/pinctrl@14010000: failed to match any schema with compatible: ['samsung,exynos5420-pinctrl']
   arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml:0:0: /soc/pinctrl@3860000: failed to match any schema with compatible: ['samsung,exynos5420-pinctrl']
   arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml:0:0: /soc/adma@3880000: failed to match any schema with compatible: ['arm,pl330', 'arm,primecell']
   arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml:0:0: /soc/pdma@121a0000: failed to match any schema with compatible: ['arm,pl330', 'arm,primecell']
   arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml:0:0: /soc/pdma@121b0000: failed to match any schema with compatible: ['arm,pl330', 'arm,primecell']
   arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml:0:0: /soc/mdma@10800000: failed to match any schema with compatible: ['arm,pl330', 'arm,primecell']
   arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml:0:0: /soc/mdma@11c10000: failed to match any schema with compatible: ['arm,pl330', 'arm,primecell']
>> arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml: i2s@3830000: 'assigned-clock-rates' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/sound/samsung-i2s.yaml
   arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml:0:0: /soc/spi@12d20000: failed to match any schema with compatible: ['samsung,exynos4210-spi']
   arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml:0:0: /soc/spi@12d30000: failed to match any schema with compatible: ['samsung,exynos4210-spi']
   arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml:0:0: /soc/spi@12d40000: failed to match any schema with compatible: ['samsung,exynos4210-spi']
   arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml:0:0: /soc/dp-video-phy: failed to match any schema with compatible: ['samsung,exynos5420-dp-video-phy']
   arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml:0:0: /soc/mipi-video-phy: failed to match any schema with compatible: ['samsung,s5pv210-mipi-video-phy']
   arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml:0:0: /soc/dsi@14500000: failed to match any schema with compatible: ['samsung,exynos5410-mipi-dsi']
   arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml:0:0: /soc/i2c@12e00000: failed to match any schema with compatible: ['samsung,exynos5250-hsi2c']
   arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml:0:0: /soc/i2c@12e10000: failed to match any schema with compatible: ['samsung,exynos5250-hsi2c']
   arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml:0:0: /soc/i2c@12e20000: failed to match any schema with compatible: ['samsung,exynos5250-hsi2c']
--
   arch/arm/boot/dts/exynos5422-odroidxu3-lite.dt.yaml:0:0: /soc/pinctrl@13400000/wakeup-interrupt-controller: failed to match any schema with compatible: ['samsung,exynos4210-wakeup-eint']
   arch/arm/boot/dts/exynos5422-odroidxu3-lite.dt.yaml:0:0: /soc/pinctrl@13410000: failed to match any schema with compatible: ['samsung,exynos5420-pinctrl']
   arch/arm/boot/dts/exynos5422-odroidxu3-lite.dt.yaml:0:0: /soc/pinctrl@14000000: failed to match any schema with compatible: ['samsung,exynos5420-pinctrl']
   arch/arm/boot/dts/exynos5422-odroidxu3-lite.dt.yaml:0:0: /soc/pinctrl@14010000: failed to match any schema with compatible: ['samsung,exynos5420-pinctrl']
   arch/arm/boot/dts/exynos5422-odroidxu3-lite.dt.yaml:0:0: /soc/pinctrl@3860000: failed to match any schema with compatible: ['samsung,exynos5420-pinctrl']
   arch/arm/boot/dts/exynos5422-odroidxu3-lite.dt.yaml:0:0: /soc/adma@3880000: failed to match any schema with compatible: ['arm,pl330', 'arm,primecell']
   arch/arm/boot/dts/exynos5422-odroidxu3-lite.dt.yaml:0:0: /soc/pdma@121a0000: failed to match any schema with compatible: ['arm,pl330', 'arm,primecell']
   arch/arm/boot/dts/exynos5422-odroidxu3-lite.dt.yaml:0:0: /soc/pdma@121b0000: failed to match any schema with compatible: ['arm,pl330', 'arm,primecell']
   arch/arm/boot/dts/exynos5422-odroidxu3-lite.dt.yaml:0:0: /soc/mdma@10800000: failed to match any schema with compatible: ['arm,pl330', 'arm,primecell']
   arch/arm/boot/dts/exynos5422-odroidxu3-lite.dt.yaml:0:0: /soc/mdma@11c10000: failed to match any schema with compatible: ['arm,pl330', 'arm,primecell']
>> arch/arm/boot/dts/exynos5422-odroidxu3-lite.dt.yaml: i2s@3830000: 'assigned-clock-rates' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/sound/samsung-i2s.yaml
   arch/arm/boot/dts/exynos5422-odroidxu3-lite.dt.yaml:0:0: /soc/spi@12d20000: failed to match any schema with compatible: ['samsung,exynos4210-spi']
   arch/arm/boot/dts/exynos5422-odroidxu3-lite.dt.yaml:0:0: /soc/spi@12d30000: failed to match any schema with compatible: ['samsung,exynos4210-spi']
   arch/arm/boot/dts/exynos5422-odroidxu3-lite.dt.yaml:0:0: /soc/spi@12d40000: failed to match any schema with compatible: ['samsung,exynos4210-spi']
   arch/arm/boot/dts/exynos5422-odroidxu3-lite.dt.yaml:0:0: /soc/dp-video-phy: failed to match any schema with compatible: ['samsung,exynos5420-dp-video-phy']
   arch/arm/boot/dts/exynos5422-odroidxu3-lite.dt.yaml:0:0: /soc/mipi-video-phy: failed to match any schema with compatible: ['samsung,s5pv210-mipi-video-phy']
   arch/arm/boot/dts/exynos5422-odroidxu3-lite.dt.yaml:0:0: /soc/dsi@14500000: failed to match any schema with compatible: ['samsung,exynos5410-mipi-dsi']
   arch/arm/boot/dts/exynos5422-odroidxu3-lite.dt.yaml:0:0: /soc/i2c@12e00000: failed to match any schema with compatible: ['samsung,exynos5250-hsi2c']
   arch/arm/boot/dts/exynos5422-odroidxu3-lite.dt.yaml:0:0: /soc/i2c@12e10000: failed to match any schema with compatible: ['samsung,exynos5250-hsi2c']
   arch/arm/boot/dts/exynos5422-odroidxu3-lite.dt.yaml:0:0: /soc/i2c@12e20000: failed to match any schema with compatible: ['samsung,exynos5250-hsi2c']
--
   arch/arm/boot/dts/exynos5422-odroidxu4.dt.yaml:0:0: /soc/pinctrl@13400000/wakeup-interrupt-controller: failed to match any schema with compatible: ['samsung,exynos4210-wakeup-eint']
   arch/arm/boot/dts/exynos5422-odroidxu4.dt.yaml:0:0: /soc/pinctrl@13410000: failed to match any schema with compatible: ['samsung,exynos5420-pinctrl']
   arch/arm/boot/dts/exynos5422-odroidxu4.dt.yaml:0:0: /soc/pinctrl@14000000: failed to match any schema with compatible: ['samsung,exynos5420-pinctrl']
   arch/arm/boot/dts/exynos5422-odroidxu4.dt.yaml:0:0: /soc/pinctrl@14010000: failed to match any schema with compatible: ['samsung,exynos5420-pinctrl']
   arch/arm/boot/dts/exynos5422-odroidxu4.dt.yaml:0:0: /soc/pinctrl@3860000: failed to match any schema with compatible: ['samsung,exynos5420-pinctrl']
   arch/arm/boot/dts/exynos5422-odroidxu4.dt.yaml:0:0: /soc/adma@3880000: failed to match any schema with compatible: ['arm,pl330', 'arm,primecell']
   arch/arm/boot/dts/exynos5422-odroidxu4.dt.yaml:0:0: /soc/pdma@121a0000: failed to match any schema with compatible: ['arm,pl330', 'arm,primecell']
   arch/arm/boot/dts/exynos5422-odroidxu4.dt.yaml:0:0: /soc/pdma@121b0000: failed to match any schema with compatible: ['arm,pl330', 'arm,primecell']
   arch/arm/boot/dts/exynos5422-odroidxu4.dt.yaml:0:0: /soc/mdma@10800000: failed to match any schema with compatible: ['arm,pl330', 'arm,primecell']
   arch/arm/boot/dts/exynos5422-odroidxu4.dt.yaml:0:0: /soc/mdma@11c10000: failed to match any schema with compatible: ['arm,pl330', 'arm,primecell']
>> arch/arm/boot/dts/exynos5422-odroidxu4.dt.yaml: i2s@3830000: 'assigned-clock-rates' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/sound/samsung-i2s.yaml
   arch/arm/boot/dts/exynos5422-odroidxu4.dt.yaml:0:0: /soc/spi@12d20000: failed to match any schema with compatible: ['samsung,exynos4210-spi']
   arch/arm/boot/dts/exynos5422-odroidxu4.dt.yaml:0:0: /soc/spi@12d30000: failed to match any schema with compatible: ['samsung,exynos4210-spi']
   arch/arm/boot/dts/exynos5422-odroidxu4.dt.yaml:0:0: /soc/spi@12d40000: failed to match any schema with compatible: ['samsung,exynos4210-spi']
   arch/arm/boot/dts/exynos5422-odroidxu4.dt.yaml:0:0: /soc/dp-video-phy: failed to match any schema with compatible: ['samsung,exynos5420-dp-video-phy']
   arch/arm/boot/dts/exynos5422-odroidxu4.dt.yaml:0:0: /soc/mipi-video-phy: failed to match any schema with compatible: ['samsung,s5pv210-mipi-video-phy']
   arch/arm/boot/dts/exynos5422-odroidxu4.dt.yaml:0:0: /soc/dsi@14500000: failed to match any schema with compatible: ['samsung,exynos5410-mipi-dsi']
   arch/arm/boot/dts/exynos5422-odroidxu4.dt.yaml:0:0: /soc/i2c@12e00000: failed to match any schema with compatible: ['samsung,exynos5250-hsi2c']
   arch/arm/boot/dts/exynos5422-odroidxu4.dt.yaml:0:0: /soc/i2c@12e10000: failed to match any schema with compatible: ['samsung,exynos5250-hsi2c']
   arch/arm/boot/dts/exynos5422-odroidxu4.dt.yaml:0:0: /soc/i2c@12e20000: failed to match any schema with compatible: ['samsung,exynos5250-hsi2c']

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

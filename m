Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC214751DB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 06:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239829AbhLOFIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 00:08:47 -0500
Received: from mga06.intel.com ([134.134.136.31]:49490 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235625AbhLOFIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 00:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639544926; x=1671080926;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R0MG16N2Iy36Vowty/rzFrx/SkxhErKHd7+1TrU+yIE=;
  b=M/pqtrvBn1YNWOElF3T0yb7EHTHEXKtlIyZQx4aOgqSE1J3wiBKMLACj
   pmtg1W8aT5z3Wdk3rG1QZMa8LwcWunWq5cTWZLXbDf+9y0OipcWf04a9v
   Oxo/k9thr4V9nW8tJlIKxg4iihQAGaI0as3Kt/y9VQTOmTuqwke3PO3Yu
   SKUl3up4kcaKwasxPjY7xtS02fRgTuCTfiNFWKzkMc8upbkQX3uFlag4p
   8Zb/9+1GA9aHkGcU0SEJ59COg1Du8hiKtjPnu/E/4dt4eoLnr7b0V5enp
   Cny/t3+YNX/I1E7edUbRHTm4CwYQzEc6arLiMa5qBS9azmqBK59iHpbDG
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="299927428"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="299927428"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 21:08:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="505654249"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 14 Dec 2021 21:08:45 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxMWy-0001Ii-Mz; Wed, 15 Dec 2021 05:08:44 +0000
Date:   Wed, 15 Dec 2021 13:08:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [chenxing:msc313_mainlining 53/78]
 drivers/gpio/gpio-msc313.c:622:23: error: 'SSD20XD_TTL_OFFSET_TTL0'
 undeclared
Message-ID: <202112151308.N8OkCaa1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/linux-chenxing/linux.git msc313_mainlining
head:   04c62a6ed8b1b9034464e903809c8b6a9354bf6e
commit: a49bf8bf6981c5b4f5c0dbb89e216ed0537172dc [53/78] gpio: msc313: Add irq support for ssd20xd
config: arm-randconfig-r025-20211214 (https://download.01.org/0day-ci/archive/20211215/202112151308.N8OkCaa1-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/linux-chenxing/linux/commit/a49bf8bf6981c5b4f5c0dbb89e216ed0537172dc
        git remote add chenxing git://github.com/linux-chenxing/linux.git
        git fetch --no-tags chenxing msc313_mainlining
        git checkout a49bf8bf6981c5b4f5c0dbb89e216ed0537172dc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpio/gpio-msc313.c: In function 'ssd20xd_gpio_child_to_parent_hwirq':
>> drivers/gpio/gpio-msc313.c:622:23: error: 'SSD20XD_TTL_OFFSET_TTL0' undeclared (first use in this function)
     622 |         if (offset >= SSD20XD_TTL_OFFSET_TTL0 && offset <= SSD20XD_TTL_OFFSET_TTL27){
         |                       ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-msc313.c:622:23: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/gpio/gpio-msc313.c:622:60: error: 'SSD20XD_TTL_OFFSET_TTL27' undeclared (first use in this function)
     622 |         if (offset >= SSD20XD_TTL_OFFSET_TTL0 && offset <= SSD20XD_TTL_OFFSET_TTL27){
         |                                                            ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpio/gpio-msc313.c:626:28: error: 'SSD20XD_GPIO_OFF_GPIO0' undeclared (first use in this function); did you mean 'SSD20XD_GPIO_GPIO0'?
     626 |         else if (offset >= SSD20XD_GPIO_OFF_GPIO0 && offset <= SSD20XD_GPIO_OFF_GPIO14){
         |                            ^~~~~~~~~~~~~~~~~~~~~~
         |                            SSD20XD_GPIO_GPIO0
>> drivers/gpio/gpio-msc313.c:626:64: error: 'SSD20XD_GPIO_OFF_GPIO14' undeclared (first use in this function); did you mean 'SSD20XD_GPIO_GPIO14'?
     626 |         else if (offset >= SSD20XD_GPIO_OFF_GPIO0 && offset <= SSD20XD_GPIO_OFF_GPIO14){
         |                                                                ^~~~~~~~~~~~~~~~~~~~~~~
         |                                                                SSD20XD_GPIO_GPIO14
   At top level:
   drivers/gpio/gpio-msc313.c:607:12: warning: 'ssd20xd_gpio_child_to_parent_hwirq' defined but not used [-Wunused-function]
     607 | static int ssd20xd_gpio_child_to_parent_hwirq(struct gpio_chip *chip,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-msc313.c:584:12: warning: 'msc313e_gpio_child_to_parent_hwirq' defined but not used [-Wunused-function]
     584 | static int msc313e_gpio_child_to_parent_hwirq(struct gpio_chip *chip,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-msc313.c:565:14: warning: 'msc313_gpio_populate_parent_fwspec' defined but not used [-Wunused-function]
     565 | static void *msc313_gpio_populate_parent_fwspec(struct gpio_chip *gc,
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for TEGRA20_APB_DMA
   Depends on DMADEVICES && (ARCH_TEGRA || COMPILE_TEST
   Selected by
   - SOC_TEGRA_FUSE && ARCH_TEGRA && ARCH_TEGRA_2x_SOC


vim +/SSD20XD_TTL_OFFSET_TTL0 +622 drivers/gpio/gpio-msc313.c

   606	
   607	static int ssd20xd_gpio_child_to_parent_hwirq(struct gpio_chip *chip,
   608						     unsigned int child,
   609						     unsigned int child_type,
   610						     unsigned int *parent,
   611						     unsigned int *parent_type)
   612	{
   613		struct msc313_gpio *priv = gpiochip_get_data(chip);
   614		unsigned int offset = priv->gpio_data->offsets[child];
   615	
   616		*parent_type = child_type;
   617	
   618		/*
   619		 * On the ssd20xd chips a lot more pins are interrupt enabled but it
   620		 * still isn't a linear mapping and not all pins are wired up.
   621		 */
 > 622		if (offset >= SSD20XD_TTL_OFFSET_TTL0 && offset <= SSD20XD_TTL_OFFSET_TTL27){
   623			*parent = ((offset - SSD20XD_TTL_OFFSET_TTL0) >> 2) + 4;
   624			return 0;
   625		}
 > 626		else if (offset >= SSD20XD_GPIO_OFF_GPIO0 && offset <= SSD20XD_GPIO_OFF_GPIO14){
   627			*parent = ((offset - SSD20XD_GPIO_OFF_GPIO0) >> 2) + 45;
   628			return 0;
   629		}
   630		else if (offset >= OFF_FUART_RX && offset <= OFF_FUART_RTS){
   631			*parent = ((offset - OFF_FUART_RX) >> 2) + 60;
   632			return 0;
   633		}
   634	
   635		return -EINVAL;
   636	}
   637	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

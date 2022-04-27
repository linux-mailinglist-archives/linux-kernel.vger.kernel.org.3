Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59237511406
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbiD0JGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiD0JGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:06:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BB2203DEE
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 02:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651050164; x=1682586164;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eTKRV3FLLJi18VaM5IFq5+mRfzOJV8/U9LUE7CdXXSc=;
  b=WB9bhf/Xi/4u6keu6Qsupp1xUgLy3WC675wPDCO33yfLeQNCfrbLPSPP
   BbhjEbL5vzWC4XBMbUymINU8GGj6LxZWtG14RYpNGmgSNZHM536ZQALiP
   oH1fkR3E3psP8ZfLl3b4NSLA7KeFprwXEYiXStOWHbflIfREF8r8A6VOc
   4vy/daMhKQXzpkVkAFHB9wCEsfIfaIfH0/TlI8L7utUnd/KxjyfVq/evV
   c+M4/bWpAyJTvJXIZu/oKeDJaIAqOGQ9hv5hmwdrdksIcoDtJ8sNMLVX4
   b0wNNatB2heWxo+fM7IEWKUGj+D8ojktXIJDIS1D0UE6XDLy/EOv46uXR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="326358453"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="326358453"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 02:02:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="564992012"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Apr 2022 02:02:34 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njdZB-0004X9-WD;
        Wed, 27 Apr 2022 09:02:33 +0000
Date:   Wed, 27 Apr 2022 17:01:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thierry Reding <treding@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [thierryreding:for-5.19/work 141/141]
 drivers/gpio/gpio-tegra186.c:170:15: error: implicit declaration of function
 'pinctrl_gpio_direction_input'; did you mean
 'tegra186_gpio_direction_input'?
Message-ID: <202204271656.UqVmYgYg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/thierryreding/linux for-5.19/work
head:   a39ec325554470289e8384e30d06a22960d1dd7b
commit: a39ec325554470289e8384e30d06a22960d1dd7b [141/141] WIP
config: xtensa-randconfig-r004-20220425 (https://download.01.org/0day-ci/archive/20220427/202204271656.UqVmYgYg-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/thierryreding/linux/commit/a39ec325554470289e8384e30d06a22960d1dd7b
        git remote add thierryreding https://github.com/thierryreding/linux
        git fetch --no-tags thierryreding for-5.19/work
        git checkout a39ec325554470289e8384e30d06a22960d1dd7b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/gpio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpio/gpio-tegra186.c: In function 'tegra186_gpio_direction_input':
>> drivers/gpio/gpio-tegra186.c:170:15: error: implicit declaration of function 'pinctrl_gpio_direction_input'; did you mean 'tegra186_gpio_direction_input'? [-Werror=implicit-function-declaration]
     170 |         err = pinctrl_gpio_direction_input(chip->base + offset);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               tegra186_gpio_direction_input
   cc1: some warnings being treated as errors


vim +170 drivers/gpio/gpio-tegra186.c

   145	
   146	static int tegra186_gpio_direction_input(struct gpio_chip *chip,
   147						 unsigned int offset)
   148	{
   149		struct tegra_gpio *gpio = gpiochip_get_data(chip);
   150		void __iomem *base;
   151		u32 value;
   152		int err;
   153	
   154		dev_info(gpio->gpio.parent, "> %s(chip=%px, offset=%u)\n", __func__, chip, offset);
   155		dev_info(gpio->gpio.parent, "  GPIO: %s\n", gpio->gpio.names[offset]);
   156	
   157		base = tegra186_gpio_get_base(gpio, offset);
   158		if (WARN_ON(base == NULL))
   159			return -ENODEV;
   160	
   161		value = readl(base + TEGRA186_GPIO_OUTPUT_CONTROL);
   162		value |= TEGRA186_GPIO_OUTPUT_CONTROL_FLOATED;
   163		writel(value, base + TEGRA186_GPIO_OUTPUT_CONTROL);
   164	
   165		value = readl(base + TEGRA186_GPIO_ENABLE_CONFIG);
   166		value |= TEGRA186_GPIO_ENABLE_CONFIG_ENABLE;
   167		value &= ~TEGRA186_GPIO_ENABLE_CONFIG_OUT;
   168		writel(value, base + TEGRA186_GPIO_ENABLE_CONFIG);
   169	
 > 170		err = pinctrl_gpio_direction_input(chip->base + offset);
   171		if (err < 0)
   172			dev_err(gpio->gpio.parent, "failed to set pinctrl input direction of GPIO %u: %d\n",
   173				chip->base + offset, err);
   174	
   175		dev_info(gpio->gpio.parent, "< %s() = %d\n", __func__, err);
   176		return err;
   177	}
   178	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

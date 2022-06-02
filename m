Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6053E53B692
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 12:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiFBKGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 06:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiFBKGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 06:06:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF08C2ACB65;
        Thu,  2 Jun 2022 03:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654164389; x=1685700389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tpy1h6rxcXVO9xLL8s23Z2+kWlBjSZ7Dkplh6lZNrSI=;
  b=jxeztFlVDxqMPufxkg830hVNjbUK6n2pu2bCVpTW+4ZjnwTMGtuncTNf
   GhFhKdapMrTPcaykZbhqoPtFy6ifQaNxjAimvSscRk2IU2zHb/5LXNs8R
   KXGQUqjnEPPfwSAwSTzTruG0eWjGMWq7L/VDmlRPpYetsUJSi31N08r8t
   TCQhoM0SnwtF5Qn5EDXWZ2LPqjyL9VpPQzdpacTjypZru2W6NX/ko+F1R
   y4QutXyEscNSl0guHKcHPJIGj8RhBO+RMDaFdKXn8r+NmvEPkoIKwgxbL
   PDufiz0VANk7uuXTK2wSqzeLVLtEoV3ID+R/OZmbDc+XyXdCjm8W2fwDf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="338946096"
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="338946096"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 03:06:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="582020563"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 02 Jun 2022 03:06:21 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwhie-0004xf-QH;
        Thu, 02 Jun 2022 10:06:20 +0000
Date:   Thu, 2 Jun 2022 18:05:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     ChiaEn Wu <peterwu.pub@gmail.com>, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     kbuild-all@lists.01.org, cy_huang@richtek.com,
        alice_chen@richtek.com, chiaen_wu@richtek.com,
        peterwu.pub@gmail.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [RESEND 13/14] leds: flashlight: mt6370: Add Mediatek MT6370
 flashlight support
Message-ID: <202206021739.LZjU7zjg-lkp@intel.com>
References: <20220531111900.19422-14-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531111900.19422-14-peterwu.pub@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ChiaEn,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pavel-leds/for-next]
[also build test WARNING on lee-mfd/for-mfd-next lee-backlight/for-backlight-next v5.18 next-20220602]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/ChiaEn-Wu/Add-Mediatek-MT6370-PMIC-support/20220531-211432
base:   git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git for-next
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20220602/202206021739.LZjU7zjg-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/805a8af17c769562ec4b85e9b7d2669d004fe3a6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review ChiaEn-Wu/Add-Mediatek-MT6370-PMIC-support/20220531-211432
        git checkout 805a8af17c769562ec4b85e9b7d2669d004fe3a6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/gpu/drm/v3d/ drivers/leds/ sound/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/leds.h:12,
                    from include/linux/led-class-flash.h:11,
                    from drivers/leds/flash/leds-mt6370-flash.c:8:
   drivers/leds/flash/leds-mt6370-flash.c: In function 'mt6370_led_probe':
>> drivers/leds/flash/leds-mt6370-flash.c:591:17: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     591 |                 "No child node or node count over max led number %lu\n", count);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/leds/flash/leds-mt6370-flash.c:590:17: note: in expansion of macro 'dev_err'
     590 |                 dev_err(&pdev->dev,
         |                 ^~~~~~~
   drivers/leds/flash/leds-mt6370-flash.c:591:68: note: format string is defined here
     591 |                 "No child node or node count over max led number %lu\n", count);
         |                                                                  ~~^
         |                                                                    |
         |                                                                    long unsigned int
         |                                                                  %u


vim +591 drivers/leds/flash/leds-mt6370-flash.c

   580	
   581	static int mt6370_led_probe(struct platform_device *pdev)
   582	{
   583		struct mt6370_priv *priv;
   584		struct fwnode_handle *child;
   585		size_t count;
   586		int i = 0, ret;
   587	
   588		count = device_get_child_node_count(&pdev->dev);
   589		if (!count || count > MT6370_MAX_LEDS) {
   590			dev_err(&pdev->dev,
 > 591			"No child node or node count over max led number %lu\n", count);
   592			return -EINVAL;
   593		}
   594	
   595		priv = devm_kzalloc(&pdev->dev, struct_size(priv, leds, count),
   596				    GFP_KERNEL);
   597		if (!priv)
   598			return -ENOMEM;
   599	
   600		priv->leds_count = count;
   601		priv->dev = &pdev->dev;
   602		mutex_init(&priv->lock);
   603	
   604		priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
   605		if (!priv->regmap) {
   606			dev_err(&pdev->dev, "Failed to get parent regmap\n");
   607			return -ENODEV;
   608		}
   609	
   610		device_for_each_child_node(&pdev->dev, child) {
   611			struct mt6370_led *led = priv->leds + i;
   612			struct led_init_data init_data = { .fwnode = child, };
   613	
   614			led->priv = priv;
   615			ret = mt6370_init_common_properties(led, &init_data);
   616			if (ret)
   617				goto out_flash_release;
   618	
   619			ret = mt6370_init_flash_properties(led, &init_data);
   620	
   621			if (ret)
   622				goto out_flash_release;
   623	
   624			ret = mt6370_led_register(&pdev->dev, led, &init_data);
   625			if (ret)
   626				goto out_flash_release;
   627	
   628			i++;
   629		}
   630	
   631		platform_set_drvdata(pdev, priv);
   632		return 0;
   633	
   634	out_flash_release:
   635		mt6370_v4l2_flash_release(priv);
   636		return ret;
   637	}
   638	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

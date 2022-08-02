Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DCD587B9E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbiHBL3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236278AbiHBL3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:29:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3F84A831
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 04:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659439758; x=1690975758;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jAb+ZobO2mm6RjAKN0tvTeKgfkERuLfBmmNwht4Glp8=;
  b=WKIsU+2t66kWpdQCImlPzoCGItyHTm3AbWbSpvsZbVMTtrEtEh21R/Kz
   hztbU87hjtRxm5XwgSeJXJJuOo3jx8rCQhOzIrnupj1dKIsamYW2yiRB8
   fOq8ClyblWcxXOiIQ2E0NumUH7DXDODC2bSn+LPnM7X0MyHsyVlcIAUU8
   TNAfVeeyeRFKxVZ23lrgoJkHz2TEe1gnKCLHXwODJByqbmNiQ2DqMnmit
   iZjpoe1xSjxgAt9fUH7pkks+vrzMj/jIwB/FsUsoI91JO48EAXFg0mE12
   cQpaK0vv/+IlpbYMa+vG/CMB9AM/eb8mBlG90+IyHOX2+jXsy2Aqf4WHs
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="269765865"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="269765865"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 04:29:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="670412753"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 Aug 2022 04:29:16 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIq5M-000FzT-0N;
        Tue, 02 Aug 2022 11:29:16 +0000
Date:   Tue, 2 Aug 2022 19:29:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [thermal:thermal/linux-next 68/68]
 drivers/thermal/st/stm_thermal.c:575:9: error: implicit declaration of
 function 'thermal_zone_of_sensor_unregister'; did you mean
 'thermal_zone_device_unregister'?
Message-ID: <202208021912.T1Bq4vVd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git thermal/linux-next
head:   340682c9ef87a4e56051c5b20cf2d5f99dec4ce1
commit: 340682c9ef87a4e56051c5b20cf2d5f99dec4ce1 [68/68] thermal/of: Remove old OF code
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220802/202208021912.T1Bq4vVd-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/commit/?id=340682c9ef87a4e56051c5b20cf2d5f99dec4ce1
        git remote add thermal git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
        git fetch --no-tags thermal thermal/linux-next
        git checkout 340682c9ef87a4e56051c5b20cf2d5f99dec4ce1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/thermal/st/stm_thermal.c: In function 'stm_thermal_probe':
>> drivers/thermal/st/stm_thermal.c:575:9: error: implicit declaration of function 'thermal_zone_of_sensor_unregister'; did you mean 'thermal_zone_device_unregister'? [-Werror=implicit-function-declaration]
     575 |         thermal_zone_of_sensor_unregister(&pdev->dev, sensor->th_dev);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         thermal_zone_device_unregister
   cc1: some warnings being treated as errors


vim +575 drivers/thermal/st/stm_thermal.c

1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  487  
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  488  static int stm_thermal_probe(struct platform_device *pdev)
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  489  {
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  490  	struct stm_thermal_sensor *sensor;
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  491  	struct resource *res;
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  492  	void __iomem *base;
dd4c3919a83074 Pascal Paillet          2020-01-10  493  	int ret;
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  494  
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  495  	if (!pdev->dev.of_node) {
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  496  		dev_err(&pdev->dev, "%s: device tree node not found\n",
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  497  			__func__);
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  498  		return -EINVAL;
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  499  	}
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  500  
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  501  	sensor = devm_kzalloc(&pdev->dev, sizeof(*sensor), GFP_KERNEL);
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  502  	if (!sensor)
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  503  		return -ENOMEM;
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  504  
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  505  	platform_set_drvdata(pdev, sensor);
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  506  
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  507  	sensor->dev = &pdev->dev;
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  508  
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  509  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  510  	base = devm_ioremap_resource(&pdev->dev, res);
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  511  	if (IS_ERR(base))
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  512  		return PTR_ERR(base);
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  513  
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  514  	/* Populate sensor */
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  515  	sensor->base = base;
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  516  
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  517  	sensor->clk = devm_clk_get(&pdev->dev, "pclk");
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  518  	if (IS_ERR(sensor->clk)) {
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  519  		dev_err(&pdev->dev, "%s: failed to fetch PCLK clock\n",
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  520  			__func__);
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  521  		return PTR_ERR(sensor->clk);
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  522  	}
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  523  
1f64fa365148f0 Pascal Paillet          2020-01-10  524  	stm_disable_irq(sensor);
1f64fa365148f0 Pascal Paillet          2020-01-10  525  
1f64fa365148f0 Pascal Paillet          2020-01-10  526  	/* Clear irq flags */
1f64fa365148f0 Pascal Paillet          2020-01-10  527  	writel_relaxed(ICIFR_MASK, sensor->base + DTS_ICIFR_OFFSET);
1f64fa365148f0 Pascal Paillet          2020-01-10  528  
dd4c3919a83074 Pascal Paillet          2020-01-10  529  	/* Configure and enable HW sensor */
dd4c3919a83074 Pascal Paillet          2020-01-10  530  	ret = stm_thermal_prepare(sensor);
dd4c3919a83074 Pascal Paillet          2020-01-10  531  	if (ret) {
8c173d5e044d7e Colin Ian King          2020-01-30  532  		dev_err(&pdev->dev, "Error prepare sensor: %d\n", ret);
dd4c3919a83074 Pascal Paillet          2020-01-10  533  		return ret;
dd4c3919a83074 Pascal Paillet          2020-01-10  534  	}
dd4c3919a83074 Pascal Paillet          2020-01-10  535  
dd4c3919a83074 Pascal Paillet          2020-01-10  536  	ret = stm_sensor_power_on(sensor);
dd4c3919a83074 Pascal Paillet          2020-01-10  537  	if (ret) {
dd4c3919a83074 Pascal Paillet          2020-01-10  538  		dev_err(&pdev->dev, "Error power on sensor: %d\n", ret);
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  539  		return ret;
dd4c3919a83074 Pascal Paillet          2020-01-10  540  	}
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  541  
13404b121effa6 Daniel Lezcano          2022-08-01  542  	sensor->th_dev = devm_thermal_of_zone_register(&pdev->dev, 0,
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  543  						       sensor,
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  544  						       &stm_tz_ops);
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  545  
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  546  	if (IS_ERR(sensor->th_dev)) {
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  547  		dev_err(&pdev->dev, "%s: thermal zone sensor registering KO\n",
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  548  			__func__);
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  549  		ret = PTR_ERR(sensor->th_dev);
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  550  		return ret;
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  551  	}
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  552  
dd4c3919a83074 Pascal Paillet          2020-01-10  553  	/* Register IRQ into GIC */
dd4c3919a83074 Pascal Paillet          2020-01-10  554  	ret = stm_register_irq(sensor);
dd4c3919a83074 Pascal Paillet          2020-01-10  555  	if (ret)
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  556  		goto err_tz;
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  557  
dd4c3919a83074 Pascal Paillet          2020-01-10  558  	stm_enable_irq(sensor);
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  559  
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  560  	/*
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  561  	 * Thermal_zone doesn't enable hwmon as default,
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  562  	 * enable it here
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  563  	 */
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  564  	sensor->th_dev->tzp->no_hwmon = false;
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  565  	ret = thermal_add_hwmon_sysfs(sensor->th_dev);
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  566  	if (ret)
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  567  		goto err_tz;
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  568  
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  569  	dev_info(&pdev->dev, "%s: Driver initialized successfully\n",
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  570  		 __func__);
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  571  
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  572  	return 0;
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  573  
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  574  err_tz:
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05 @575  	thermal_zone_of_sensor_unregister(&pdev->dev, sensor->th_dev);
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  576  	return ret;
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  577  }
1d693155607329 David HERNANDEZ SANCHEZ 2018-10-05  578  

:::::: The code at line 575 was first introduced by commit
:::::: 1d693155607329adff57f5307d35a3a8320d4e7f thermal: add stm32 thermal driver

:::::: TO: David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>
:::::: CC: Eduardo Valentin <edubezval@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

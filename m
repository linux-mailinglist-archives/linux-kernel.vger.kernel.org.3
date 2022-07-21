Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F9157C286
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 05:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiGUDFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 23:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiGUDFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 23:05:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373DAD112;
        Wed, 20 Jul 2022 20:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658372733; x=1689908733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RPgPExIELG618Y4ubbGSYZCUWtilbteLR28Kg8HTOrI=;
  b=C3TMECXTgtbtyyJK6bJmgmJFSTW2JCswE3l+F4H5Cf6GpHG42rzbZJaD
   a965yQ5FhgUpZXJsL2zi/kZH74kZuM+iwABOeK6zmLo3mzczPGI7r9ajx
   qmZJhu+04iPsjd0ZSviUXr5mGUHXFuO1zyGnomCdqxOOC+DAwozCBXzZr
   46DeW09w7/hEizqVRrQ2GfFdYCJiH0lOd62UKCIjt58Xi5qX5AVNo9ivc
   FPuFogcUi5QtpsYk+JOCNe6A75wacBiOhxjFAMXLim/Xrz9eS3yAJunNB
   hH1rZPp8gF51EnW7VKOt1iUEmRQbfMVX7PhF2OkHTwFl/vt9M1fMvOioC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="348632253"
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="348632253"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 20:05:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="925481371"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Jul 2022 20:05:29 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oEMVF-0001Nh-2U;
        Thu, 21 Jul 2022 03:05:29 +0000
Date:   Thu, 21 Jul 2022 11:04:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li-hao Kuo <lhjeff911@gmail.com>, krzk@kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: Re: [PATCH v10 1/2] thermal: Add thermal driver for Sunplus
Message-ID: <202207211145.wLh7TKJt-lkp@intel.com>
References: <b114b6f8ea51054561a61dc4982715bb73633ec5.1654660009.git.lhjeff911@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b114b6f8ea51054561a61dc4982715bb73633ec5.1654660009.git.lhjeff911@gmail.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li-hao,

I love your patch! Yet something to improve:

[auto build test ERROR on rafael-pm/thermal]
[also build test ERROR on krzk-dt/for-next linus/master v5.19-rc7 next-20220720]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-hao-Kuo/Add-thermal-control-driver-for-Sunplus-SoC/20220712-153158
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
config: sh-randconfig-s042-20220715 (https://download.01.org/0day-ci/archive/20220721/202207211145.wLh7TKJt-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/328f3fe3eb3d1984a68c51c4a413821bd4b397b6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Li-hao-Kuo/Add-thermal-control-driver-for-Sunplus-SoC/20220712-153158
        git checkout 328f3fe3eb3d1984a68c51c4a413821bd4b397b6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash .// drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from drivers/thermal/sunplus_thermal.c:13:
   drivers/thermal/sunplus_thermal.c: In function 'sunplus_thermal_probe':
>> drivers/thermal/sunplus_thermal.c:106:25: error: 'dev' undeclared (first use in this function); did you mean 'pdev'?
     106 |                 dev_err(dev, "Failed to register tsensor: %d\n", ret);
         |                         ^~~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/thermal/sunplus_thermal.c:106:17: note: in expansion of macro 'dev_err'
     106 |                 dev_err(dev, "Failed to register tsensor: %d\n", ret);
         |                 ^~~~~~~
   drivers/thermal/sunplus_thermal.c:106:25: note: each undeclared identifier is reported only once for each function it appears in
     106 |                 dev_err(dev, "Failed to register tsensor: %d\n", ret);
         |                         ^~~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/thermal/sunplus_thermal.c:106:17: note: in expansion of macro 'dev_err'
     106 |                 dev_err(dev, "Failed to register tsensor: %d\n", ret);
         |                 ^~~~~~~


vim +106 drivers/thermal/sunplus_thermal.c

  > 13	#include <linux/platform_device.h>
    14	#include <linux/reset.h>
    15	#include <linux/thermal.h>
    16	
    17	#define ENABLE_THERMAL		BIT(31)
    18	#define SP_THERMAL_MASK		GENMASK(10, 0)
    19	
    20	#define TEMP_RATE		608
    21	#define TEMP_BASE		3500
    22	#define TEMP_OTP_BASE		1518
    23	
    24	#define SP_THERMAL_CTL0_REG	0x0000
    25	#define SP_THERMAL_STS0_REG	0x0030
    26	
    27	/* common data structures */
    28	struct sp_thermal_data {
    29		struct thermal_zone_device *pcb_tz;
    30		void __iomem *regs;
    31		int *otp_temp0;
    32	};
    33	
    34	static int sunplus_get_otp_temp_coef(struct sp_thermal_data *sp_data, struct device *dev)
    35	{
    36		struct nvmem_cell *cell;
    37		ssize_t otp_l;
    38	
    39		cell = nvmem_cell_get(dev, "calib");
    40		if (IS_ERR(cell))
    41			return PTR_ERR(cell);
    42	
    43		sp_data->otp_temp0 = nvmem_cell_read(cell, &otp_l);
    44		nvmem_cell_put(cell);
    45	
    46		if (*sp_data->otp_temp0 == 0)
    47			*sp_data->otp_temp0 = TEMP_OTP_BASE;
    48	
    49		return 0;
    50	}
    51	
    52	/*
    53	 * There is a thermal sensor instance for Sunplus Soc
    54	 * T_CODE is the ADC of the thermal sensor
    55	 * T_CODE : 11 digits in total
    56	 * When remanufacturing, the 35 degree T_CODE will be read and stored in nvcell.
    57	 * otp_temp0 is the 35 degree T_CODE obtained from nvcell
    58	 * The function will get 35 degree T_CODE for thermal calibration.
    59	 * TEMP_RATE is the Sunplus thermal temperature slope.
    60	 */
    61	
    62	static int sp_thermal_get_sensor_temp(void *data, int *temp)
    63	{
    64		struct sp_thermal_data *sp_data = data;
    65		int t_code;
    66	
    67		t_code = readl(sp_data->regs + SP_THERMAL_STS0_REG);
    68		t_code = FIELD_GET(SP_THERMAL_MASK, t_code);
    69		*temp = ((*sp_data->otp_temp0 - t_code) * 10000 / TEMP_RATE) + TEMP_BASE;
    70		*temp *= 10;
    71		return 0;
    72	}
    73	
    74	static const struct thermal_zone_of_device_ops sp_of_thermal_ops = {
    75		.get_temp = sp_thermal_get_sensor_temp,
    76	};
    77	
    78	static int sunplus_thermal_probe(struct platform_device *pdev)
    79	{
    80		struct sp_thermal_data *sp_data;
    81		int ret;
    82	
    83		sp_data = devm_kzalloc(&pdev->dev, sizeof(*sp_data), GFP_KERNEL);
    84		if (!sp_data)
    85			return -ENOMEM;
    86	
    87		sp_data->regs = devm_platform_ioremap_resource(pdev, 0);
    88		if (IS_ERR(sp_data->regs)) {
    89			dev_err(&pdev->dev, "resource get fail\n");
    90			return PTR_ERR(sp_data->regs);
    91		}
    92	
    93		writel(ENABLE_THERMAL, sp_data->regs + SP_THERMAL_CTL0_REG);
    94	
    95		platform_set_drvdata(pdev, sp_data);
    96		ret = sunplus_get_otp_temp_coef(sp_data, &pdev->dev);
    97		if (ret)
    98			return ret;
    99	
   100		sp_data->pcb_tz = devm_thermal_zone_of_sensor_register(&pdev->dev,
   101								    0,
   102								    sp_data, &sp_of_thermal_ops);
   103	
   104		if (IS_ERR(sp_data->pcb_tz)) {
   105			ret = PTR_ERR(sp_data->pcb_tz);
 > 106			dev_err(dev, "Failed to register tsensor: %d\n", ret);
   107			return ret;
   108		}
   109	
   110		return ret;
   111	}
   112	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

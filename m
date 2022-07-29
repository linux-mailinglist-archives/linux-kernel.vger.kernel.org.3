Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD7D584B66
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbiG2GKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiG2GK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:10:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81B319013
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659075027; x=1690611027;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dYT+TM7CjLgEL9hUqUFQ2eEBVux2I9/NJLMLAtMswgI=;
  b=fKGr556e2lTrGNVM7VVSEd7AUOpjKuz0l9B+g5QLYDFS+Hj2I07VTTAT
   eTNfZtAfwmN2iNdRdQ6y7JoiEGHsxmCtSGnYgxHFB8sbVamhXNzXx7LnY
   q8xgnhdukQwydvuJgfihhvTjtB7HRv5jHXr60gSNi5vy9HIkFCvQ63d/b
   RclGs5MHeSbNQ4gZ6ChSqfOOBYRIEloSWwb0CxweB9WGDiH+HICHyQ1n1
   DWplv0bSZYXx6EgiCBIAbDxTpvCyN8lVLg/F6/K6dkZ7/AmHHNX/VRatD
   uIobSCobydoQwycErzlBQpF2+UUrqV5zh3wYwwe59qbLhYL/gscXoZS0/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="275583776"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="275583776"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 23:10:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="928626312"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jul 2022 23:10:26 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHJCb-000BB4-1P;
        Fri, 29 Jul 2022 06:10:25 +0000
Date:   Fri, 29 Jul 2022 14:09:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [thermal:thermal/linux-next 46/68]
 drivers/thermal/broadcom/ns-thermal.c:19:34: sparse: sparse: incorrect type
 in initializer (different address spaces)
Message-ID: <202207291408.QOdXF9af-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git thermal/linux-next
head:   f0105ae57fe7c05fb82b7c0a6416a34051d29a34
commit: 472eb6fcc74450b922bd79ecd032e4ca2a3f4fe3 [46/68] thermal/drivers/broadcom: Switch to new of API
config: microblaze-randconfig-s032-20220728 (https://download.01.org/0day-ci/archive/20220729/202207291408.QOdXF9af-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/commit/?id=472eb6fcc74450b922bd79ecd032e4ca2a3f4fe3
        git remote add thermal git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
        git fetch --no-tags thermal thermal/linux-next
        git checkout 472eb6fcc74450b922bd79ecd032e4ca2a3f4fe3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/thermal/broadcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/thermal/broadcom/ns-thermal.c:19:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *pvtmon @@     got void *devdata @@
   drivers/thermal/broadcom/ns-thermal.c:19:34: sparse:     expected void [noderef] __iomem *pvtmon
   drivers/thermal/broadcom/ns-thermal.c:19:34: sparse:     got void *devdata
>> drivers/thermal/broadcom/ns-thermal.c:56:44: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *data @@     got void [noderef] __iomem *[assigned] pvtmon @@
   drivers/thermal/broadcom/ns-thermal.c:56:44: sparse:     expected void *data
   drivers/thermal/broadcom/ns-thermal.c:56:44: sparse:     got void [noderef] __iomem *[assigned] pvtmon
   drivers/thermal/broadcom/ns-thermal.c:63:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *data @@     got void [noderef] __iomem *[assigned] pvtmon @@
   drivers/thermal/broadcom/ns-thermal.c:63:36: sparse:     expected void *data
   drivers/thermal/broadcom/ns-thermal.c:63:36: sparse:     got void [noderef] __iomem *[assigned] pvtmon
>> drivers/thermal/broadcom/ns-thermal.c:70:52: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *pvtmon @@     got void * @@
   drivers/thermal/broadcom/ns-thermal.c:70:52: sparse:     expected void [noderef] __iomem *pvtmon
   drivers/thermal/broadcom/ns-thermal.c:70:52: sparse:     got void *

vim +19 drivers/thermal/broadcom/ns-thermal.c

    16	
    17	static int ns_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
    18	{
  > 19		void __iomem *pvtmon = tz->devdata;
    20		int offset = thermal_zone_get_offset(tz);
    21		int slope = thermal_zone_get_slope(tz);
    22		u32 val;
    23	
    24		val = readl(pvtmon + PVTMON_CONTROL0);
    25		if ((val & PVTMON_CONTROL0_SEL_MASK) != PVTMON_CONTROL0_SEL_TEMP_MONITOR) {
    26			/* Clear current mode selection */
    27			val &= ~PVTMON_CONTROL0_SEL_MASK;
    28	
    29			/* Set temp monitor mode (it's the default actually) */
    30			val |= PVTMON_CONTROL0_SEL_TEMP_MONITOR;
    31	
    32			writel(val, pvtmon + PVTMON_CONTROL0);
    33		}
    34	
    35		val = readl(pvtmon + PVTMON_STATUS);
    36		*temp = slope * val + offset;
    37	
    38		return 0;
    39	}
    40	
    41	static const struct thermal_zone_device_ops ns_thermal_ops = {
    42		.get_temp = ns_thermal_get_temp,
    43	};
    44	
    45	static int ns_thermal_probe(struct platform_device *pdev)
    46	{
    47		struct device *dev = &pdev->dev;
    48		struct thermal_zone_device *tz;
    49		void __iomem *pvtmon;
    50	
    51		pvtmon = of_iomap(dev_of_node(dev), 0);
    52		if (WARN_ON(!pvtmon))
    53			return -ENOENT;
    54	
    55		tz = devm_thermal_of_zone_register(dev, 0,
  > 56						   pvtmon,
    57						   &ns_thermal_ops);
    58		if (IS_ERR(tz)) {
    59			iounmap(pvtmon);
    60			return PTR_ERR(tz);
    61		}
    62	
    63		platform_set_drvdata(pdev, pvtmon);
    64	
    65		return 0;
    66	}
    67	
    68	static int ns_thermal_remove(struct platform_device *pdev)
    69	{
  > 70		void __iomem *pvtmon = platform_get_drvdata(pdev);
    71	
    72		iounmap(pvtmon);
    73	
    74		return 0;
    75	}
    76	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

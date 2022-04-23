Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC3250C9D4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 14:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbiDWMR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 08:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiDWMRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 08:17:55 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF031117B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 05:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650716097; x=1682252097;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x2JhaNUGEE1bYv058u4DhdJPR8UuSZ3lRm2m5MV7ljE=;
  b=ZKb1LNSTYtV104uk76oIBBQM95K1QUOg52ykcQj6u7WMwgxy7DXC2PWe
   ehcMw2NNECG6MpYbGrDcvgMXyduEwNj064c+68aEQyeAXq93U41QmFJxb
   zF2+T2CodqNLFPtiRXr+sQIsL+QPswXNnolL1MirOYLHe9cvqqD0CMGCE
   rjvny8E5iAcg/XjSaeU5x5F3YCmUvNhEY9tuW3w4sZVJ7A0vWiZPKKB5J
   TV4pUKSsWYLGDWFzGbsh2nRjPTMxzyJYVnvZ8VDBWli+nKqiTmt8/8TSe
   jZ6y5f1aMQ4Uq1kFUcskaGr41wuR9uDWhQ511m6r/+jry6u9dUC3D5boi
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="290017170"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="290017170"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 05:14:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="627356011"
Received: from lkp-server01.sh.intel.com (HELO dd58949a6e39) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 Apr 2022 05:14:56 -0700
Received: from kbuild by dd58949a6e39 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niEf9-0000GV-BC;
        Sat, 23 Apr 2022 12:14:55 +0000
Date:   Sat, 23 Apr 2022 20:14:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1926/2579]
 drivers/mfd/intel_soc_pmic_core.c:70:9: error: implicit declaration of
 function 'irq_domain_update_bus_token'
Message-ID: <202204232025.hMR56x14-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 762e2c31017f8004327c678d499aa24693a9d465 [1926/2579] headers/deps: ACPI: Optimize <linux/acpi.h> dependencies, remove <linux/irqdomain.h> inclusion
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220423/202204232025.hMR56x14-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=762e2c31017f8004327c678d499aa24693a9d465
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 762e2c31017f8004327c678d499aa24693a9d465
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/mfd/intel_soc_pmic_core.c: In function 'intel_soc_pmic_i2c_probe':
>> drivers/mfd/intel_soc_pmic_core.c:70:9: error: implicit declaration of function 'irq_domain_update_bus_token' [-Werror=implicit-function-declaration]
      70 |         irq_domain_update_bus_token(regmap_irq_get_domain(pmic->irq_chip_data),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mfd/intel_soc_pmic_core.c:71:37: error: 'DOMAIN_BUS_NEXUS' undeclared (first use in this function)
      71 |                                     DOMAIN_BUS_NEXUS);
         |                                     ^~~~~~~~~~~~~~~~
   drivers/mfd/intel_soc_pmic_core.c:71:37: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors


vim +/irq_domain_update_bus_token +70 drivers/mfd/intel_soc_pmic_core.c

a3aa9a93df9fc8 Shobhit Kumar   2015-06-26  29  
5165238460068e Zhu, Lejun      2014-06-03  30  static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c,
5165238460068e Zhu, Lejun      2014-06-03  31  				    const struct i2c_device_id *i2c_id)
5165238460068e Zhu, Lejun      2014-06-03  32  {
5165238460068e Zhu, Lejun      2014-06-03  33  	struct device *dev = &i2c->dev;
5165238460068e Zhu, Lejun      2014-06-03  34  	struct intel_soc_pmic_config *config;
5165238460068e Zhu, Lejun      2014-06-03  35  	struct intel_soc_pmic *pmic;
5165238460068e Zhu, Lejun      2014-06-03  36  	int ret;
5165238460068e Zhu, Lejun      2014-06-03  37  
5b78223f55a0f5 Hans de Goede   2021-12-06  38  	if (soc_intel_is_byt())
b01e9348e10654 Hans de Goede   2017-09-04  39  		config = &intel_soc_pmic_config_byt_crc;
5b78223f55a0f5 Hans de Goede   2021-12-06  40  	else
b01e9348e10654 Hans de Goede   2017-09-04  41  		config = &intel_soc_pmic_config_cht_crc;
5165238460068e Zhu, Lejun      2014-06-03  42  
5165238460068e Zhu, Lejun      2014-06-03  43  	pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
0a65fbf64dad89 Kiran Padwal    2015-02-11  44  	if (!pmic)
0a65fbf64dad89 Kiran Padwal    2015-02-11  45  		return -ENOMEM;
0a65fbf64dad89 Kiran Padwal    2015-02-11  46  
5165238460068e Zhu, Lejun      2014-06-03  47  	dev_set_drvdata(dev, pmic);
5165238460068e Zhu, Lejun      2014-06-03  48  
5165238460068e Zhu, Lejun      2014-06-03  49  	pmic->regmap = devm_regmap_init_i2c(i2c, config->regmap_config);
db43b8d04d7a9f Pan Bian        2017-04-23  50  	if (IS_ERR(pmic->regmap))
db43b8d04d7a9f Pan Bian        2017-04-23  51  		return PTR_ERR(pmic->regmap);
db43b8d04d7a9f Pan Bian        2017-04-23  52  
159ee7578a7453 Andy Shevchenko 2017-02-21  53  	pmic->irq = i2c->irq;
5165238460068e Zhu, Lejun      2014-06-03  54  
5165238460068e Zhu, Lejun      2014-06-03  55  	ret = regmap_add_irq_chip(pmic->regmap, pmic->irq,
5165238460068e Zhu, Lejun      2014-06-03  56  				  config->irq_flags | IRQF_ONESHOT,
5165238460068e Zhu, Lejun      2014-06-03  57  				  0, config->irq_chip,
5165238460068e Zhu, Lejun      2014-06-03  58  				  &pmic->irq_chip_data);
5165238460068e Zhu, Lejun      2014-06-03  59  	if (ret)
5165238460068e Zhu, Lejun      2014-06-03  60  		return ret;
5165238460068e Zhu, Lejun      2014-06-03  61  
5165238460068e Zhu, Lejun      2014-06-03  62  	ret = enable_irq_wake(pmic->irq);
5165238460068e Zhu, Lejun      2014-06-03  63  	if (ret)
5165238460068e Zhu, Lejun      2014-06-03  64  		dev_warn(dev, "Can't enable IRQ as wake source: %d\n", ret);
5165238460068e Zhu, Lejun      2014-06-03  65  
a3aa9a93df9fc8 Shobhit Kumar   2015-06-26  66  	/* Add lookup table for crc-pwm */
a3aa9a93df9fc8 Shobhit Kumar   2015-06-26  67  	pwm_add_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
a3aa9a93df9fc8 Shobhit Kumar   2015-06-26  68  
f49f43371b8a68 Hans de Goede   2021-12-25  69  	/* To distuingish this domain from the GPIO/charger's irqchip domains */
f49f43371b8a68 Hans de Goede   2021-12-25 @70  	irq_domain_update_bus_token(regmap_irq_get_domain(pmic->irq_chip_data),
f49f43371b8a68 Hans de Goede   2021-12-25 @71  				    DOMAIN_BUS_NEXUS);
f49f43371b8a68 Hans de Goede   2021-12-25  72  
5165238460068e Zhu, Lejun      2014-06-03  73  	ret = mfd_add_devices(dev, -1, config->cell_dev,
5165238460068e Zhu, Lejun      2014-06-03  74  			      config->n_cell_devs, NULL, 0,
5165238460068e Zhu, Lejun      2014-06-03  75  			      regmap_irq_get_domain(pmic->irq_chip_data));
5165238460068e Zhu, Lejun      2014-06-03  76  	if (ret)
5165238460068e Zhu, Lejun      2014-06-03  77  		goto err_del_irq_chip;
5165238460068e Zhu, Lejun      2014-06-03  78  
5165238460068e Zhu, Lejun      2014-06-03  79  	return 0;
5165238460068e Zhu, Lejun      2014-06-03  80  
5165238460068e Zhu, Lejun      2014-06-03  81  err_del_irq_chip:
5165238460068e Zhu, Lejun      2014-06-03  82  	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
5165238460068e Zhu, Lejun      2014-06-03  83  	return ret;
5165238460068e Zhu, Lejun      2014-06-03  84  }
5165238460068e Zhu, Lejun      2014-06-03  85  

:::::: The code at line 70 was first introduced by commit
:::::: f49f43371b8a680c5972d052598d7c120f1a05d3 mfd: intel_soc_pmic_crc: Set main IRQ domain bus token to DOMAIN_BUS_NEXUS

:::::: TO: Hans de Goede <hdegoede@redhat.com>
:::::: CC: Lee Jones <lee.jones@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

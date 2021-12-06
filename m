Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CDF46AE97
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 00:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377525AbhLFXv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 18:51:57 -0500
Received: from mga06.intel.com ([134.134.136.31]:63765 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377492AbhLFXv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 18:51:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="298234314"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="298234314"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 15:48:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="611435632"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 06 Dec 2021 15:48:23 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muNiZ-000LsT-28; Mon, 06 Dec 2021 23:48:23 +0000
Date:   Tue, 7 Dec 2021 07:47:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alistair Francis <alistair@alistair23.me>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     kbuild-all@lists.01.org, robh+dt@kernel.org, andreas@kemnade.info,
        alistair23@gmail.com, dmitry.torokhov@gmail.com,
        linus.walleij@linaro.org, rydberg@bitmath.org
Subject: Re: [PATCH v3 1/4] Input: Add driver for Cypress Generation 5
 touchscreen
Message-ID: <202112070710.hut43Md3-lkp@intel.com>
References: <20211202122021.43124-2-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202122021.43124-2-alistair@alistair23.me>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alistair,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on robh/for-next linus/master v5.16-rc4 next-20211206]
[cannot apply to dtor-input/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Alistair-Francis/Add-support-for-the-Cypress-cyttsp5/20211202-202300
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 136057256686de39cc3a07c2e39ef6bc43003ff6
config: microblaze-randconfig-m031-20211207 (https://download.01.org/0day-ci/archive/20211207/202112070710.hut43Md3-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/737a89fa2dc4a337dea6a131b8b94fcc49fdcec5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Alistair-Francis/Add-support-for-the-Cypress-cyttsp5/20211202-202300
        git checkout 737a89fa2dc4a337dea6a131b8b94fcc49fdcec5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/input/touchscreen/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/input/touchscreen/cyttsp5.c: In function 'cyttsp5_probe':
>> drivers/input/touchscreen/cyttsp5.c:931:26: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_regulator_get_optional'? [-Werror=implicit-function-declaration]
     931 |         ts->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~
         |                          devm_regulator_get_optional
>> drivers/input/touchscreen/cyttsp5.c:931:64: error: 'GPIOD_OUT_HIGH' undeclared (first use in this function); did you mean 'GPIOF_INIT_HIGH'?
     931 |         ts->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
         |                                                                ^~~~~~~~~~~~~~
         |                                                                GPIOF_INIT_HIGH
   drivers/input/touchscreen/cyttsp5.c:931:64: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/input/touchscreen/cyttsp5.c:937:9: error: implicit declaration of function 'gpiod_set_value'; did you mean 'gpio_set_value'? [-Werror=implicit-function-declaration]
     937 |         gpiod_set_value(ts->reset_gpio, 0);
         |         ^~~~~~~~~~~~~~~
         |         gpio_set_value
   cc1: some warnings being treated as errors


vim +931 drivers/input/touchscreen/cyttsp5.c

   881	
   882	static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
   883				 const char *name)
   884	{
   885		struct cyttsp5 *ts;
   886		struct cyttsp5_sysinfo *si;
   887		int error, i;
   888	
   889		ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
   890		if (!ts)
   891			return -ENOMEM;
   892	
   893		/* Initialize device info */
   894		ts->regmap = regmap;
   895		ts->dev = dev;
   896		si = &ts->sysinfo;
   897		dev_set_drvdata(dev, ts);
   898	
   899		/* Initialize wait queue */
   900		init_waitqueue_head(&ts->wait_q);
   901	
   902		/* Power up the device */
   903		ts->vdd = regulator_get(dev, "vdd");
   904		if (IS_ERR(ts->vdd)) {
   905			error = PTR_ERR(ts->vdd);
   906			dev_set_drvdata(dev, NULL);
   907			kfree(ts);
   908			return error;
   909		}
   910	
   911		error = regulator_enable(ts->vdd);
   912		if (error) {
   913			regulator_put(ts->vdd);
   914			dev_set_drvdata(dev, NULL);
   915			kfree(ts);
   916			return error;
   917		}
   918	
   919		ts->input = devm_input_allocate_device(dev);
   920		if (!ts->input) {
   921			dev_err(dev, "Error, failed to allocate input device\n");
   922			return -ENODEV;
   923		}
   924	
   925		ts->input->name = "cyttsp5";
   926		scnprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(dev));
   927		ts->input->phys = ts->phys;
   928		input_set_drvdata(ts->input, ts);
   929	
   930		/* Reset the gpio to be in a reset state */
 > 931		ts->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
   932		if (IS_ERR(ts->reset_gpio)) {
   933			error = PTR_ERR(ts->reset_gpio);
   934			dev_err(dev, "Failed to request reset gpio, error %d\n", error);
   935			return error;
   936		}
 > 937		gpiod_set_value(ts->reset_gpio, 0);
   938	
   939		/* Need a delay to have device up */
   940		msleep(20);
   941	
   942		error = devm_request_threaded_irq(dev, irq, NULL, cyttsp5_handle_irq,
   943					       IRQF_ONESHOT, name, ts);
   944		if (error) {
   945			dev_err(dev, "unable to request IRQ\n");
   946			return error;
   947		}
   948	
   949		error = cyttsp5_startup(ts);
   950		if (error) {
   951			dev_err(ts->dev, "Fail initial startup r=%d\n", error);
   952			return error;
   953		}
   954	
   955		error = cyttsp5_parse_dt_key_code(dev);
   956		if (error < 0) {
   957			dev_err(ts->dev, "Error while parsing dts %d\n", error);
   958			return error;
   959		}
   960	
   961		touchscreen_parse_properties(ts->input, true, &ts->prop);
   962	
   963		__set_bit(EV_KEY, ts->input->evbit);
   964		for (i = 0; i < si->num_btns; i++)
   965			__set_bit(si->key_code[i], ts->input->keybit);
   966	
   967		return cyttsp5_setup_input_device(dev);
   968	}
   969	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46F7509858
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346885AbiDUGsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385408AbiDUGrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:47:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DBD62CA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523495; x=1682059495;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SQWhxscqE35ux1O7ngRCdoW+bgjeGh5j+bEI2zqbiAA=;
  b=ZNzh3dP4Sga3Byid10TO/mLVqZp5zNKTRTquuWB5Asth19b7Rriiu9Ck
   5FaX3y+nYTLxgdORFuWUmVg2f+rfhzcDCTfKnTok5WKR4Whh/IFlbSR0d
   IRcvdJdQ+1ZaASWyxs0AixlsKiuiqnaJkQCf4ShXw2Mdy/tIap0f2Vwi/
   6wxSxxZsuonQKsIEB9yUiLszoyrakyafUceQAPqF736+fNfxCEZeD3zMG
   PFSfQMOKA6PASzsH5VHyaU0kZUBhIa73mV6r77Bsa2SRpF5qctKliD8W/
   M7ffUVe4/R3DlhZ5wbMfS1yb/QOOw/nFCmFU2VplSnmXULUEsqxxBZwuL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="244190280"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="244190280"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="510918951"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Apr 2022 23:44:52 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQYd-000822-Gz;
        Thu, 21 Apr 2022 06:44:51 +0000
Date:   Thu, 21 Apr 2022 14:43:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: drivers/leds/leds-pca955x.c:500:15: warning: cast to smaller integer
 type 'enum pca955x_type' from 'const void *'
Message-ID: <202204210933.kF7wJs8r-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b253435746d9a4a701b5f09211b9c14d3370d0da
commit: 239f32b4f161c1584cd4b386d6ab8766432a6ede leds: pca955x: Switch to i2c probe_new
date:   8 months ago
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220421/202204210933.kF7wJs8r-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=239f32b4f161c1584cd4b386d6ab8766432a6ede
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 239f32b4f161c1584cd4b386d6ab8766432a6ede
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/leds/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/leds/leds-pca955x.c:500:15: warning: cast to smaller integer type 'enum pca955x_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
                   chip_type = (enum pca955x_type)md;
                               ^~~~~~~~~~~~~~~~~~~~~
   drivers/leds/leds-pca955x.c:492:6: warning: variable 'ngpios' set but not used [-Wunused-but-set-variable]
           int ngpios = 0;
               ^
   drivers/leds/leds-pca955x.c:147:19: warning: unused function 'pca95xx_num_led_regs' [-Wunused-function]
   static inline int pca95xx_num_led_regs(int bits)
                     ^
   3 warnings generated.


vim +500 drivers/leds/leds-pca955x.c

   481	
   482	static int pca955x_probe(struct i2c_client *client)
   483	{
   484		struct pca955x *pca955x;
   485		struct pca955x_led *pca955x_led;
   486		struct pca955x_chipdef *chip;
   487		struct led_classdev *led;
   488		struct led_init_data init_data;
   489		struct i2c_adapter *adapter;
   490		int i, err;
   491		struct pca955x_platform_data *pdata;
   492		int ngpios = 0;
   493		bool set_default_label = false;
   494		bool keep_pwm = false;
   495		char default_label[8];
   496		enum pca955x_type chip_type;
   497		const void *md = device_get_match_data(&client->dev);
   498	
   499		if (md) {
 > 500			chip_type = (enum pca955x_type)md;
   501		} else {
   502			const struct i2c_device_id *id = i2c_match_id(pca955x_id,
   503								      client);
   504	
   505			if (id) {
   506				chip_type = (enum pca955x_type)id->driver_data;
   507			} else {
   508				dev_err(&client->dev, "unknown chip\n");
   509				return -ENODEV;
   510			}
   511		}
   512	
   513		chip = &pca955x_chipdefs[chip_type];
   514		adapter = client->adapter;
   515		pdata = dev_get_platdata(&client->dev);
   516		if (!pdata) {
   517			pdata =	pca955x_get_pdata(client, chip);
   518			if (IS_ERR(pdata))
   519				return PTR_ERR(pdata);
   520		}
   521	
   522		/* Make sure the slave address / chip type combo given is possible */
   523		if ((client->addr & ~((1 << chip->slv_addr_shift) - 1)) !=
   524		    chip->slv_addr) {
   525			dev_err(&client->dev, "invalid slave address %02x\n",
   526				client->addr);
   527			return -ENODEV;
   528		}
   529	
   530		dev_info(&client->dev, "leds-pca955x: Using %s %d-bit LED driver at "
   531			 "slave address 0x%02x\n", client->name, chip->bits,
   532			 client->addr);
   533	
   534		if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
   535			return -EIO;
   536	
   537		if (pdata->num_leds != chip->bits) {
   538			dev_err(&client->dev,
   539				"board info claims %d LEDs on a %d-bit chip\n",
   540				pdata->num_leds, chip->bits);
   541			return -ENODEV;
   542		}
   543	
   544		pca955x = devm_kzalloc(&client->dev, sizeof(*pca955x), GFP_KERNEL);
   545		if (!pca955x)
   546			return -ENOMEM;
   547	
   548		pca955x->leds = devm_kcalloc(&client->dev, chip->bits,
   549					     sizeof(*pca955x_led), GFP_KERNEL);
   550		if (!pca955x->leds)
   551			return -ENOMEM;
   552	
   553		i2c_set_clientdata(client, pca955x);
   554	
   555		mutex_init(&pca955x->lock);
   556		pca955x->client = client;
   557		pca955x->chipdef = chip;
   558	
   559		init_data.devname_mandatory = false;
   560		init_data.devicename = "pca955x";
   561	
   562		for (i = 0; i < chip->bits; i++) {
   563			pca955x_led = &pca955x->leds[i];
   564			pca955x_led->led_num = i;
   565			pca955x_led->pca955x = pca955x;
   566			pca955x_led->type = pdata->leds[i].type;
   567	
   568			switch (pca955x_led->type) {
   569			case PCA955X_TYPE_NONE:
   570				break;
   571			case PCA955X_TYPE_GPIO:
   572				ngpios++;
   573				break;
   574			case PCA955X_TYPE_LED:
   575				led = &pca955x_led->led_cdev;
   576				led->brightness_set_blocking = pca955x_led_set;
   577				led->brightness_get = pca955x_led_get;
   578	
   579				if (pdata->leds[i].default_state ==
   580				    LEDS_GPIO_DEFSTATE_OFF) {
   581					err = pca955x_led_set(led, LED_OFF);
   582					if (err)
   583						return err;
   584				} else if (pdata->leds[i].default_state ==
   585					   LEDS_GPIO_DEFSTATE_ON) {
   586					err = pca955x_led_set(led, LED_FULL);
   587					if (err)
   588						return err;
   589				}
   590	
   591				init_data.fwnode = pdata->leds[i].fwnode;
   592	
   593				if (is_of_node(init_data.fwnode)) {
   594					if (to_of_node(init_data.fwnode)->name[0] ==
   595					    '\0')
   596						set_default_label = true;
   597					else
   598						set_default_label = false;
   599				} else {
   600					set_default_label = true;
   601				}
   602	
   603				if (set_default_label) {
   604					snprintf(default_label, sizeof(default_label),
   605						 "%d", i);
   606					init_data.default_label = default_label;
   607				} else {
   608					init_data.default_label = NULL;
   609				}
   610	
   611				err = devm_led_classdev_register_ext(&client->dev, led,
   612								     &init_data);
   613				if (err)
   614					return err;
   615	
   616				/*
   617				 * For default-state == "keep", let the core update the
   618				 * brightness from the hardware, then check the
   619				 * brightness to see if it's using PWM1. If so, PWM1
   620				 * should not be written below.
   621				 */
   622				if (pdata->leds[i].default_state ==
   623				    LEDS_GPIO_DEFSTATE_KEEP) {
   624					if (led->brightness != LED_FULL &&
   625					    led->brightness != LED_OFF &&
   626					    led->brightness != LED_HALF)
   627						keep_pwm = true;
   628				}
   629			}
   630		}
   631	
   632		/* PWM0 is used for half brightness or 50% duty cycle */
   633		err = pca955x_write_pwm(client, 0, 255 - LED_HALF);
   634		if (err)
   635			return err;
   636	
   637		if (!keep_pwm) {
   638			/* PWM1 is used for variable brightness, default to OFF */
   639			err = pca955x_write_pwm(client, 1, 0);
   640			if (err)
   641				return err;
   642		}
   643	
   644		/* Set to fast frequency so we do not see flashing */
   645		err = pca955x_write_psc(client, 0, 0);
   646		if (err)
   647			return err;
   648		err = pca955x_write_psc(client, 1, 0);
   649		if (err)
   650			return err;
   651	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

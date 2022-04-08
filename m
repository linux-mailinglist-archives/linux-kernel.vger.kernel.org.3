Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B884F9709
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbiDHNlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiDHNle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:41:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B81531F2A0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 06:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649425168; x=1680961168;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aVWJ9fXEzuztrv1mLqunrlyCPorl2wNv6i+Y14FIbIo=;
  b=H2cV3fCKDGL8QwpG07kDJbRYG1+JnekJHyIxb7why4tVzJ0EWdHEBaur
   By/YD5NaOsSSGE2ikGv0RHrfJSO79j5KcA6fu1WWFotSwuxvuAjz5UJS2
   Wq/G/woJlPp+Qf2nX0P6A3O1aVtCjdEk3/1R/Y0EvvLVbnpI10x+kxqch
   Pk3MrAAzi4luHGUmxru5AdtbAzJn6CSW0U6pLbEjIlseK/XTQNOqOe0TI
   T64cWxNApGVfnI/8T2BIeCw2qg1usqqvZj14xkVPChgPeWbDRAYFjg19R
   Vn2rRtj1/gxGNNhVM3oYt0otUIDFxb8UD4A5s/9H/gDndeDQYHhDN+XC5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="286583358"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="286583358"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 06:39:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="609757343"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 08 Apr 2022 06:39:26 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncopi-0000JS-0C;
        Fri, 08 Apr 2022 13:39:26 +0000
Date:   Fri, 8 Apr 2022 21:38:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Dom Cobley <popcornmix@gmail.com>
Subject: [l1k:smsc95xx_5.17 423/887]
 drivers/regulator/rpi-panel-attiny-regulator.c:357:12: error: no member
 named 'of_node' in 'struct gpio_chip'; did you mean 'fwnode'?
Message-ID: <202204082122.onPg5boL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   05d68ced287b30f62f18f95b5476135ef669804a
commit: ac3d51b0c8cae7b7dacbf817eb7e6b96c1a1ccf2 [423/887] regulator: rpi-panel: Add GPIO control for panel and touch resets
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220408/202204082122.onPg5boL-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c29a51b3a257908aebc01cd7c4655665db317d66)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/ac3d51b0c8cae7b7dacbf817eb7e6b96c1a1ccf2
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout ac3d51b0c8cae7b7dacbf817eb7e6b96c1a1ccf2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/regulator/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/regulator/rpi-panel-attiny-regulator.c:357:12: error: no member named 'of_node' in 'struct gpio_chip'; did you mean 'fwnode'?
           state->gc.of_node = i2c->dev.of_node;
                     ^~~~~~~
                     fwnode
   include/linux/gpio/driver.h:381:24: note: 'fwnode' declared here
           struct fwnode_handle    *fwnode;
                                    ^
   1 error generated.


vim +357 drivers/regulator/rpi-panel-attiny-regulator.c

   275	
   276	/*
   277	 * I2C driver interface functions
   278	 */
   279	static int attiny_i2c_probe(struct i2c_client *i2c,
   280			const struct i2c_device_id *id)
   281	{
   282		struct backlight_properties props = { };
   283		struct regulator_config config = { };
   284		struct backlight_device *bl;
   285		struct regulator_dev *rdev;
   286		struct attiny_lcd *state;
   287		struct regmap *regmap;
   288		unsigned int data;
   289		int ret;
   290	
   291		state = devm_kzalloc(&i2c->dev, sizeof(*state), GFP_KERNEL);
   292		if (!state)
   293			return -ENOMEM;
   294	
   295		mutex_init(&state->lock);
   296		i2c_set_clientdata(i2c, state);
   297	
   298		regmap = devm_regmap_init_i2c(i2c, &attiny_regmap_config);
   299		if (IS_ERR(regmap)) {
   300			ret = PTR_ERR(regmap);
   301			dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
   302				ret);
   303			goto error;
   304		}
   305	
   306		ret = regmap_read(regmap, REG_ID, &data);
   307		if (ret < 0) {
   308			dev_err(&i2c->dev, "Failed to read REG_ID reg: %d\n", ret);
   309			goto error;
   310		}
   311	
   312		switch (data) {
   313		case 0xde: /* ver 1 */
   314		case 0xc3: /* ver 2 */
   315			break;
   316		default:
   317			dev_err(&i2c->dev, "Unknown Atmel firmware revision: 0x%02x\n", data);
   318			ret = -ENODEV;
   319			goto error;
   320		}
   321	
   322		regmap_write(regmap, REG_POWERON, 0);
   323		msleep(30);
   324		regmap_write(regmap, REG_PWM, 0);
   325	
   326		config.dev = &i2c->dev;
   327		config.regmap = regmap;
   328		config.of_node = i2c->dev.of_node;
   329		config.init_data = &attiny_regulator_default;
   330		config.driver_data = state;
   331	
   332		rdev = devm_regulator_register(&i2c->dev, &attiny_regulator, &config);
   333		if (IS_ERR(rdev)) {
   334			dev_err(&i2c->dev, "Failed to register ATTINY regulator\n");
   335			ret = PTR_ERR(rdev);
   336			goto error;
   337		}
   338	
   339		props.type = BACKLIGHT_RAW;
   340		props.max_brightness = 0xff;
   341	
   342		state->regmap = regmap;
   343	
   344		bl = devm_backlight_device_register(&i2c->dev, dev_name(&i2c->dev),
   345						    &i2c->dev, state, &attiny_bl,
   346						    &props);
   347		if (IS_ERR(bl)) {
   348			ret = PTR_ERR(bl);
   349			goto error;
   350		}
   351	
   352		bl->props.brightness = 0xff;
   353	
   354		state->gc.parent = &i2c->dev;
   355		state->gc.label = i2c->name;
   356		state->gc.owner = THIS_MODULE;
 > 357		state->gc.of_node = i2c->dev.of_node;
   358		state->gc.base = -1;
   359		state->gc.ngpio = NUM_GPIO;
   360	
   361		state->gc.set = attiny_gpio_set;
   362		state->gc.get_direction = attiny_gpio_get_direction;
   363		state->gc.can_sleep = true;
   364	
   365		ret = devm_gpiochip_add_data(&i2c->dev, &state->gc, state);
   366		if (ret) {
   367			dev_err(&i2c->dev, "Failed to create gpiochip: %d\n", ret);
   368			goto error;
   369		}
   370	
   371		return 0;
   372	
   373	error:
   374		mutex_destroy(&state->lock);
   375	
   376		return ret;
   377	}
   378	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

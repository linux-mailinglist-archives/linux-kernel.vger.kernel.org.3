Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0EC50605C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 01:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbiDRXwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 19:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235856AbiDRXws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 19:52:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE412496F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650325807; x=1681861807;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6RxZzSIjsW4RweQfrvtr93HGHfTde4zYCBJbBjvFDtQ=;
  b=PsAtvUi6AxKQR9F5u/++6pJUQ0R7P3pOgJU1KLM+RF5y9+6FpYxttSqB
   fmZcTcMvsT3y27OPFIHwKR8SA4XAyme1w1V/nkRPJr9HJM/5ErF0Y7RzE
   soxw1/9rD92/XsHM/u5KUvpwI0OT/qUiV5nRnXJUIRg0MA9d4zAlxyT31
   o3N+ppZCkMsPEO8qJzjdiqS3fqnpvOpB/3ytka6u/G7rzaRC1BKU/kttx
   wK6nv26MwMLXjzu8s9iu9k4Lu0P3Yjxlf++v7HA/2Sks0/AZEW7iPHonu
   ATWWQL2l1aP1eeLZ/3VmQEkKxTUq9bjDU3H5ufUZHHb0dRZ6tLXz0ch3G
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="326535356"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="326535356"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 16:50:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="665580717"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Apr 2022 16:50:06 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngb89-000562-Gl;
        Mon, 18 Apr 2022 23:50:05 +0000
Date:   Tue, 19 Apr 2022 07:49:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1541/2356]
 drivers/hwmon/pmbus/pli1209bc.c:60:14: warning: incompatible integer to
 pointer conversion initializing 'const char *' with an expression of type
 'int'
Message-ID: <202204190731.vTjUPdxY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: 63245bf3e0db1d416f39a3ccb1311f94f37697f5 [1541/2356] headers/deps: i2c: Optimize <linux/i2c.h> header dependencies
config: i386-randconfig-a012-20220418 (https://download.01.org/0day-ci/archive/20220419/202204190731.vTjUPdxY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=63245bf3e0db1d416f39a3ccb1311f94f37697f5
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 63245bf3e0db1d416f39a3ccb1311f94f37697f5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/panel/ drivers/hwmon/ drivers/iio/afe/ drivers/iio/proximity/ drivers/input/touchscreen/ drivers/mtd/nand/ drivers/phy/cadence/ drivers/pinctrl/ drivers/platform/chrome/ mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/hwmon/pmbus/pli1209bc.c:60:14: error: implicit declaration of function 'of_match_ptr' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           .of_match = of_match_ptr("vout2"),
                       ^
>> drivers/hwmon/pmbus/pli1209bc.c:60:14: warning: incompatible integer to pointer conversion initializing 'const char *' with an expression of type 'int' [-Wint-conversion]
           .of_match = of_match_ptr("vout2"),
                       ^~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/pmbus/pli1209bc.c:61:21: warning: incompatible integer to pointer conversion initializing 'const char *' with an expression of type 'int' [-Wint-conversion]
           .regulators_node = of_match_ptr("regulators"),
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/pmbus/pli1209bc.c:60:14: error: initializer element is not a compile-time constant
           .of_match = of_match_ptr("vout2"),
                       ^~~~~~~~~~~~~~~~~~~~~
>> drivers/hwmon/pmbus/pli1209bc.c:135:24: warning: incompatible integer to pointer conversion initializing 'const struct of_device_id *' with an expression of type 'int' [-Wint-conversion]
                      .of_match_table = of_match_ptr(pli1209bc_of_match),
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/pmbus/pli1209bc.c:135:24: error: initializer element is not a compile-time constant
                      .of_match_table = of_match_ptr(pli1209bc_of_match),
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   3 warnings and 3 errors generated.


vim +60 drivers/hwmon/pmbus/pli1209bc.c

d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   55  
ba1d263af1c034 Marcello Sylvester Bauer 2022-02-21   56  #if IS_ENABLED(CONFIG_SENSORS_PLI1209BC_REGULATOR)
ba1d263af1c034 Marcello Sylvester Bauer 2022-02-21   57  static const struct regulator_desc pli1209bc_reg_desc = {
ba1d263af1c034 Marcello Sylvester Bauer 2022-02-21   58  	.name = "vout2",
ba1d263af1c034 Marcello Sylvester Bauer 2022-02-21   59  	.id = 1,
ba1d263af1c034 Marcello Sylvester Bauer 2022-02-21  @60  	.of_match = of_match_ptr("vout2"),
ba1d263af1c034 Marcello Sylvester Bauer 2022-02-21   61  	.regulators_node = of_match_ptr("regulators"),
ba1d263af1c034 Marcello Sylvester Bauer 2022-02-21   62  	.ops = &pmbus_regulator_ops,
ba1d263af1c034 Marcello Sylvester Bauer 2022-02-21   63  	.type = REGULATOR_VOLTAGE,
ba1d263af1c034 Marcello Sylvester Bauer 2022-02-21   64  	.owner = THIS_MODULE,
ba1d263af1c034 Marcello Sylvester Bauer 2022-02-21   65  };
ba1d263af1c034 Marcello Sylvester Bauer 2022-02-21   66  #endif
ba1d263af1c034 Marcello Sylvester Bauer 2022-02-21   67  
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   68  static struct pmbus_driver_info pli1209bc_info = {
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   69  	.pages = 2,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   70  	.format[PSC_VOLTAGE_IN] = direct,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   71  	.format[PSC_VOLTAGE_OUT] = direct,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   72  	.format[PSC_CURRENT_IN] = direct,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   73  	.format[PSC_CURRENT_OUT] = direct,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   74  	.format[PSC_POWER] = direct,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   75  	.format[PSC_TEMPERATURE] = direct,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   76  	.m[PSC_VOLTAGE_IN] = 1,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   77  	.b[PSC_VOLTAGE_IN] = 0,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   78  	.R[PSC_VOLTAGE_IN] = 1,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   79  	.m[PSC_VOLTAGE_OUT] = 1,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   80  	.b[PSC_VOLTAGE_OUT] = 0,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   81  	.R[PSC_VOLTAGE_OUT] = 1,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   82  	.m[PSC_CURRENT_IN] = 1,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   83  	.b[PSC_CURRENT_IN] = 0,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   84  	.R[PSC_CURRENT_IN] = 3,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   85  	.m[PSC_CURRENT_OUT] = 1,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   86  	.b[PSC_CURRENT_OUT] = 0,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   87  	.R[PSC_CURRENT_OUT] = 2,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   88  	.m[PSC_POWER] = 1,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   89  	.b[PSC_POWER] = 0,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   90  	.R[PSC_POWER] = 1,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   91  	.m[PSC_TEMPERATURE] = 1,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   92  	.b[PSC_TEMPERATURE] = 0,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   93  	.R[PSC_TEMPERATURE] = 0,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   94  	/*
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   95  	 * Page 0 sums up all attributes except voltage readings.
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   96  	 * The pli1209 digital supervisor only contains a single BCM, making
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   97  	 * page 0 redundant.
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   98  	 */
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21   99  	.func[1] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  100  	    | PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  101  	    | PMBUS_HAVE_PIN | PMBUS_HAVE_POUT
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  102  	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  103  	    | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  104  	.read_word_data = pli1209bc_read_word_data,
ba1d263af1c034 Marcello Sylvester Bauer 2022-02-21  105  #if IS_ENABLED(CONFIG_SENSORS_PLI1209BC_REGULATOR)
ba1d263af1c034 Marcello Sylvester Bauer 2022-02-21  106  	.num_regulators = 1,
ba1d263af1c034 Marcello Sylvester Bauer 2022-02-21  107  	.reg_desc = &pli1209bc_reg_desc,
ba1d263af1c034 Marcello Sylvester Bauer 2022-02-21  108  #endif
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  109  };
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  110  
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  111  static int pli1209bc_probe(struct i2c_client *client)
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  112  {
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  113  	client->dev.platform_data = &pli1209bc_plat_data;
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  114  	return pmbus_do_probe(client, &pli1209bc_info);
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  115  }
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  116  
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  117  static const struct i2c_device_id pli1209bc_id[] = {
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  118  	{"pli1209bc", 0},
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  119  	{}
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  120  };
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  121  
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  122  MODULE_DEVICE_TABLE(i2c, pli1209bc_id);
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  123  
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  124  #ifdef CONFIG_OF
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  125  static const struct of_device_id pli1209bc_of_match[] = {
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  126  	{ .compatible = "vicor,pli1209bc" },
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  127  	{ },
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  128  };
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  129  MODULE_DEVICE_TABLE(of, pli1209bc_of_match);
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  130  #endif
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  131  
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  132  static struct i2c_driver pli1209bc_driver = {
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  133  	.driver = {
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  134  		   .name = "pli1209bc",
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21 @135  		   .of_match_table = of_match_ptr(pli1209bc_of_match),
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  136  		   },
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  137  	.probe_new = pli1209bc_probe,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  138  	.id_table = pli1209bc_id,
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  139  };
d0cd978513f2e3 Marcello Sylvester Bauer 2022-02-21  140  

:::::: The code at line 60 was first introduced by commit
:::::: ba1d263af1c034baf479bca14d6f715b713214b1 hwmon: (pmbus/pli1209bc) Add regulator support

:::::: TO: Marcello Sylvester Bauer <sylv@sylv.io>
:::::: CC: Guenter Roeck <linux@roeck-us.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

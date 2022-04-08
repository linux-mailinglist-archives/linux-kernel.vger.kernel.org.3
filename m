Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482DE4F8E9C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbiDHFRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 01:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbiDHFR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:17:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86F934AD21
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 22:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649394923; x=1680930923;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=n//T5sApcHAHuO4ZvmNnVqGGk4Y+vMjz5KWRBFbmk/k=;
  b=hCATyb38O4WqR3ae2LOSjtbfhyf0PHSB8lysgrLzzFa3gGdWMIj/atPT
   iqTanLM9vfH90APSoc6yusduL4mp4cwdcuiY9mZY794ylxqHsERS5OVR2
   qRYrJmgWx4Z//fI5JakkWO3ARnL00qmRZuIy5+JI5a2diAlGY0IDUNpmq
   ZcZ1ml4s78X01aK83nodR6AylXFlHy7yExsR1JNG5m+ecDxmPqkrNrrTQ
   Mn1uaIfL5AtByy9dqyLFHAxWdZJ+cdP1O1trIIjAZWHeTZAD+GwbtsoGS
   9MRUAwTWlHdPKK/3H6yHU77EtTEqwFuVNPot6X4kglYdHGSltUaq8cB+Z
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261505526"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="261505526"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 22:15:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="524654767"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 07 Apr 2022 22:15:21 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncgxs-000657-UB;
        Fri, 08 Apr 2022 05:15:20 +0000
Date:   Fri, 8 Apr 2022 13:15:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: drivers/pinctrl/bcm/pinctrl-bcm4908.c:524:8: warning: Local variable
 'pins' shadows outer variable [shadowVariable]
Message-ID: <202204081339.tfzma3ai-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   42e7a03d3badebd4e70aea5362d6914dfc7c220b
commit: f7e322d99f1180270fb4a3e1ae992b3116cfcf34 pinctrl: bcm: add driver for BCM4908 pinmux
date:   2 months ago
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout f7e322d99f1180270fb4a3e1ae992b3116cfcf34
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
>> drivers/pinctrl/bcm/pinctrl-bcm4908.c:524:8: warning: Local variable 'pins' shadows outer variable [shadowVariable]
     int *pins;
          ^
   drivers/pinctrl/bcm/pinctrl-bcm4908.c:475:27: note: Shadowed declaration
    struct pinctrl_pin_desc *pins;
                             ^
   drivers/pinctrl/bcm/pinctrl-bcm4908.c:524:8: note: Shadow variable
     int *pins;
          ^
--

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/pinctrl/renesas/pfc-r8a7791.c:5486:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("GPSR0", 0xE6060004, 32, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-r8a7791.c:5520:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("GPSR1", 0xE6060008, 32, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-r8a7791.c:5554:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("GPSR2", 0xE606000C, 32, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-r8a7791.c:5588:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("GPSR3", 0xE6060010, 32, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-r8a7791.c:5622:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("GPSR4", 0xE6060014, 32, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-r8a7791.c:5656:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("GPSR5", 0xE6060018, 32, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-r8a7791.c:5690:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("GPSR6", 0xE606001C, 32, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-r8a7791.c:5724:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("GPSR7", 0xE6060074, 32, 1, GROUP(
      ^
>> drivers/pinctrl/renesas/pfc-r8a7791.c:1737:2: warning: Shifting signed 32-bit value by 31 bits is implementation-defined behaviour [shiftTooManyBitsSigned]
    PINMUX_NOGP_ALL(),
    ^
>> drivers/pinctrl/renesas/pfc-r8a7791.c:1737:2: warning: Signed integer overflow for expression '1<<31'. [integerOverflow]
    PINMUX_NOGP_ALL(),
    ^
--
>> drivers/pinctrl/renesas/pfc-r8a77951.c:213:0: warning: failed to expand 'PINMUX_GPSR', Wrong number of parameters for macro 'F_'. [preprocessorErrorDirective]
   #define GPSR6_31 F_(USB2_CH3_OVC, IP18_7_4)
   ^
--
>> drivers/pinctrl/renesas/pfc-sh7269.c:1970:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("PAIOR0", 0xfffe3812, 16, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-sh7269.c:2062:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("PBIOR1", 0xfffe3830, 16, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-sh7269.c:2074:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("PBIOR0", 0xfffe3832, 16, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-sh7269.c:2134:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("PCIOR0", 0xfffe3852, 16, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-sh7269.c:2200:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("PDIOR0", 0xfffe3872, 16, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-sh7269.c:2248:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("PEIOR0", 0xfffe3892, 16, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-sh7269.c:2373:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("PFIOR1", 0xfffe38b0, 16, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-sh7269.c:2385:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("PFIOR0", 0xfffe38b2, 16, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-sh7269.c:2515:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("PGIOR1", 0xfffe38d0, 16, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-sh7269.c:2530:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("PGIOR0", 0xfffe38d2, 16, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-sh7269.c:2713:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("PJIOR1", 0xfffe3910, 16, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-sh7269.c:2731:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("PJIOR0", 0xfffe3912, 16, 1, GROUP(
      ^
--
>> drivers/pinctrl/renesas/pfc-r8a7790.c:5032:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("GPSR0", 0xE6060004, 32, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-r8a7790.c:5066:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("GPSR1", 0xE6060008, 32, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-r8a7790.c:5100:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("GPSR2", 0xE606000C, 32, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-r8a7790.c:5134:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("GPSR3", 0xE6060010, 32, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-r8a7790.c:5168:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("GPSR4", 0xE6060014, 32, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-r8a7790.c:5202:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("GPSR5", 0xE6060018, 32, 1, GROUP(
      ^
>> drivers/pinctrl/renesas/pfc-r8a7790.c:1751:2: warning: Shifting signed 32-bit value by 31 bits is implementation-defined behaviour [shiftTooManyBitsSigned]
    PINMUX_NOGP_ALL(),
    ^
>> drivers/pinctrl/renesas/pfc-r8a7790.c:1751:2: warning: Signed integer overflow for expression '1<<31'. [integerOverflow]
    PINMUX_NOGP_ALL(),
    ^
--
>> drivers/pinctrl/renesas/pfc-sh7722.c:1470:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("PSELA", 0xa405014e, 16, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-sh7722.c:1488:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("PSELB", 0xa4050150, 16, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-sh7722.c:1506:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("PSELC", 0xa4050152, 16, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-sh7722.c:1524:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("PSELD", 0xa4050154, 16, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-sh7722.c:1542:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("PSELE", 0xa4050156, 16, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-sh7722.c:1560:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("HIZCRA", 0xa4050158, 16, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-sh7722.c:1578:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("HIZCRB", 0xa405015a, 16, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-sh7722.c:1596:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("HIZCRC", 0xa405015c, 16, 1, GROUP(
      ^
   drivers/pinctrl/renesas/pfc-sh7722.c:1614:4: warning: Modulo of one is always equal to zero [moduloofone]
    { PINMUX_CFG_REG("MSELCRB", 0xa4050182, 16, 1, GROUP(
      ^
--
>> drivers/pinctrl/renesas/core.c:444:40: warning: Shifting signed 32-bit value by 31 bits is implementation-defined behaviour [shiftTooManyBitsSigned]
     if (!(pfc->info->pins[i-1].configs & SH_PFC_PIN_CFG_NO_GPIO))
                                          ^
   drivers/pinctrl/renesas/core.c:452:39: warning: Shifting signed 32-bit value by 31 bits is implementation-defined behaviour [shiftTooManyBitsSigned]
    if (!(pfc->info->pins[i-1].configs & SH_PFC_PIN_CFG_NO_GPIO))
                                         ^
>> drivers/pinctrl/renesas/core.c:444:40: warning: Signed integer overflow for expression '1<<31'. [integerOverflow]
     if (!(pfc->info->pins[i-1].configs & SH_PFC_PIN_CFG_NO_GPIO))
                                          ^
   drivers/pinctrl/renesas/core.c:452:39: warning: Signed integer overflow for expression '1<<31'. [integerOverflow]
    if (!(pfc->info->pins[i-1].configs & SH_PFC_PIN_CFG_NO_GPIO))
                                         ^
>> drivers/rtc/rtc-armada38x.c:132:10: warning: Signed integer overflow for expression '0xFFFF<<16'. [integerOverflow]
    reg &= ~RTC_8K_WRCLK_SETUP_MASK;
            ^
--
>> drivers/pinctrl/samsung/pinctrl-samsung.c:79:45: warning: Parameter 'num_maps' can be declared with const [constParameter]
            unsigned *reserved_maps, unsigned *num_maps,
                                               ^
>> drivers/pinctrl/samsung/pinctrl-samsung.c:101:60: warning: Parameter 'reserved_maps' can be declared with const [constParameter]
   static int add_map_mux(struct pinctrl_map **map, unsigned *reserved_maps,
                                                              ^
   drivers/pinctrl/samsung/pinctrl-samsung.c:117:17: warning: Parameter 'reserved_maps' can be declared with const [constParameter]
         unsigned *reserved_maps, unsigned *num_maps,
                   ^
>> drivers/pinctrl/mediatek/pinctrl-paris.c:364:17: warning: Parameter 'reserved_maps' can be declared with const [constParameter]
         unsigned *reserved_maps,
                   ^

vim +/pins +524 drivers/pinctrl/bcm/pinctrl-bcm4908.c

   469	
   470	static int bcm4908_pinctrl_probe(struct platform_device *pdev)
   471	{
   472		struct device *dev = &pdev->dev;
   473		struct bcm4908_pinctrl *bcm4908_pinctrl;
   474		struct pinctrl_desc *pctldesc;
   475		struct pinctrl_pin_desc *pins;
   476		char **pin_names;
   477		int i;
   478	
   479		bcm4908_pinctrl = devm_kzalloc(dev, sizeof(*bcm4908_pinctrl), GFP_KERNEL);
   480		if (!bcm4908_pinctrl)
   481			return -ENOMEM;
   482		pctldesc = &bcm4908_pinctrl->pctldesc;
   483		platform_set_drvdata(pdev, bcm4908_pinctrl);
   484	
   485		/* Set basic properties */
   486	
   487		bcm4908_pinctrl->dev = dev;
   488	
   489		bcm4908_pinctrl->base = devm_platform_ioremap_resource(pdev, 0);
   490		if (IS_ERR(bcm4908_pinctrl->base))
   491			return PTR_ERR(bcm4908_pinctrl->base);
   492	
   493		mutex_init(&bcm4908_pinctrl->mutex);
   494	
   495		memcpy(pctldesc, &bcm4908_pinctrl_desc, sizeof(*pctldesc));
   496	
   497		/* Set pinctrl properties */
   498	
   499		pin_names = devm_kasprintf_strarray(dev, "pin", BCM4908_NUM_PINS);
   500		if (IS_ERR(pin_names))
   501			return PTR_ERR(pin_names);
   502	
   503		pins = devm_kcalloc(dev, BCM4908_NUM_PINS, sizeof(*pins), GFP_KERNEL);
   504		if (!pins)
   505			return -ENOMEM;
   506		for (i = 0; i < BCM4908_NUM_PINS; i++) {
   507			pins[i].number = i;
   508			pins[i].name = pin_names[i];
   509		}
   510		pctldesc->pins = pins;
   511		pctldesc->npins = BCM4908_NUM_PINS;
   512	
   513		/* Register */
   514	
   515		bcm4908_pinctrl->pctldev = devm_pinctrl_register(dev, pctldesc, bcm4908_pinctrl);
   516		if (IS_ERR(bcm4908_pinctrl->pctldev))
   517			return dev_err_probe(dev, PTR_ERR(bcm4908_pinctrl->pctldev),
   518					     "Failed to register pinctrl\n");
   519	
   520		/* Groups */
   521	
   522		for (i = 0; i < ARRAY_SIZE(bcm4908_pinctrl_grps); i++) {
   523			const struct bcm4908_pinctrl_grp *group = &bcm4908_pinctrl_grps[i];
 > 524			int *pins;
   525			int j;
   526	
   527			pins = devm_kcalloc(dev, group->num_pins, sizeof(*pins), GFP_KERNEL);
   528			if (!pins)
   529				return -ENOMEM;
   530			for (j = 0; j < group->num_pins; j++)
   531				pins[j] = group->pins[j].number;
   532	
   533			pinctrl_generic_add_group(bcm4908_pinctrl->pctldev, group->name,
   534						  pins, group->num_pins, (void *)group);
   535		}
   536	
   537		/* Functions */
   538	
   539		for (i = 0; i < ARRAY_SIZE(bcm4908_pinctrl_functions); i++) {
   540			const struct bcm4908_pinctrl_function *function = &bcm4908_pinctrl_functions[i];
   541	
   542			pinmux_generic_add_function(bcm4908_pinctrl->pctldev,
   543						    function->name,
   544						    function->groups,
   545						    function->num_groups, NULL);
   546		}
   547	
   548		return 0;
   549	}
   550	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FEE532719
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 12:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbiEXKI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiEXKIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:08:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A94779834
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 03:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653386903; x=1684922903;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d/a2bdtMEfJLJm4/sbv0OBeBqTGWXn245KlMgMEhULk=;
  b=K1vrjyejM2LYyovt+Zr1VzI3fHmuA7S/sdhFahT2W2e37Qr9J0xu1tXp
   Yc6hd9p7374mfMcfSZWYYIwcAzeBdIt0SCXxh12+/+2bApLE+cHsliJnp
   GfqZMoN9/h0QMT+2Bzy3HCrI5jXk/6YExd4dDtcBXjN8auljluW+55GxG
   3EiBZpY4y8GAeGZPdpX0qmj5CG6HucSaeYPMPsswLTd6tIkDZYsNSr/oJ
   v/DR1Ie8GFwawhrLnpdJQB0fqnJfeNaTg6wtvVFkqiC55x6/Hbq4l4G/6
   3U5iGzC+KjiC81FCCJKOJnKLriRpfqP9gTt2VgK9sIP4EJl4BkOmi/6Pi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="298805645"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="298805645"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 03:08:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="703407301"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 May 2022 03:08:20 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntRSd-0001ws-IE;
        Tue, 24 May 2022 10:08:19 +0000
Date:   Tue, 24 May 2022 18:07:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: drivers/pinctrl/cirrus/pinctrl-lochnagar.c:200:1: error: call to
 undeclared function 'LOCHNAGAR1_'; ISO C99 and later do not support implicit
 function declarations
Message-ID: <202205241805.y0qqNBIf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   143a6252e1b8ab424b4b293512a97cca7295c182
commit: e8c07082a810fbb9db303a2b66b66b8d7e588b53 Kbuild: move to -std=gnu11
date:   2 months ago
config: mips-randconfig-c004-20220524 (https://download.01.org/0day-ci/archive/20220524/202205241805.y0qqNBIf-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 10c9ecce9f6096e18222a331c5e7d085bd813f75)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e8c07082a810fbb9db303a2b66b66b8d7e588b53
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e8c07082a810fbb9db303a2b66b66b8d7e588b53
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:200:1: error: pasting formed 'LOCHNAGAR1_(', an invalid preprocessing token
   LN1_PIN_GPIO(CDC_RESET,    "codec-reset",    RST,      CDC_RESET,    1);
   ^
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:2: note: expanded from macro 'LN1_PIN_GPIO'
           LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
           ^
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:63: note: expanded from macro 'LN_PIN_GPIO'
           .name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
                                                                        ^
>> drivers/pinctrl/cirrus/pinctrl-lochnagar.c:200:1: error: call to undeclared function 'LOCHNAGAR1_'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:2: note: expanded from macro 'LN1_PIN_GPIO'
           LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
           ^
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:46: note: expanded from macro 'LN_PIN_GPIO'
           .name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
                                                       ^
   <scratch space>:171:1: note: expanded from here
   LOCHNAGAR1_
   ^
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:200:1: error: initializer element is not a compile-time constant
   LN1_PIN_GPIO(CDC_RESET,    "codec-reset",    RST,      CDC_RESET,    1);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:2: note: expanded from macro 'LN1_PIN_GPIO'
           LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:46: note: expanded from macro 'LN_PIN_GPIO'
           .name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
                                                       ^~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:171:1: note: expanded from here
   LOCHNAGAR1_
   ^
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:201:1: error: pasting formed 'LOCHNAGAR1_(', an invalid preprocessing token
   LN1_PIN_GPIO(DSP_RESET,    "dsp-reset",      RST,      DSP_RESET,    1);
   ^
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:2: note: expanded from macro 'LN1_PIN_GPIO'
           LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
           ^
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:63: note: expanded from macro 'LN_PIN_GPIO'
           .name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
                                                                        ^
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:201:1: error: initializer element is not a compile-time constant
   LN1_PIN_GPIO(DSP_RESET,    "dsp-reset",      RST,      DSP_RESET,    1);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:2: note: expanded from macro 'LN1_PIN_GPIO'
           LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:46: note: expanded from macro 'LN_PIN_GPIO'
           .name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
                                                       ^~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:182:1: note: expanded from here
   LOCHNAGAR1_
   ^
   5 errors generated.


vim +/LOCHNAGAR1_ +200 drivers/pinctrl/cirrus/pinctrl-lochnagar.c

0548448b719ac7 Charles Keepax 2019-03-19  199  
0548448b719ac7 Charles Keepax 2019-03-19 @200  LN1_PIN_GPIO(CDC_RESET,    "codec-reset",    RST,      CDC_RESET,    1);
0548448b719ac7 Charles Keepax 2019-03-19  201  LN1_PIN_GPIO(DSP_RESET,    "dsp-reset",      RST,      DSP_RESET,    1);
0548448b719ac7 Charles Keepax 2019-03-19  202  LN1_PIN_GPIO(CDC_CIF1MODE, "codec-cif1mode", I2C_CTRL, CDC_CIF_MODE, 0);
0548448b719ac7 Charles Keepax 2019-03-19  203  LN1_PIN_MUX(GF_GPIO2,      "gf-gpio2");
0548448b719ac7 Charles Keepax 2019-03-19  204  LN1_PIN_MUX(GF_GPIO3,      "gf-gpio3");
0548448b719ac7 Charles Keepax 2019-03-19  205  LN1_PIN_MUX(GF_GPIO7,      "gf-gpio7");
0548448b719ac7 Charles Keepax 2019-03-19  206  LN1_PIN_MUX(LED1,          "led1");
0548448b719ac7 Charles Keepax 2019-03-19  207  LN1_PIN_MUX(LED2,          "led2");
0548448b719ac7 Charles Keepax 2019-03-19  208  LN1_PIN_AIF(CDC_AIF1);
0548448b719ac7 Charles Keepax 2019-03-19  209  LN1_PIN_AIF(CDC_AIF2);
0548448b719ac7 Charles Keepax 2019-03-19  210  LN1_PIN_AIF(CDC_AIF3);
0548448b719ac7 Charles Keepax 2019-03-19  211  LN1_PIN_AIF(DSP_AIF1);
0548448b719ac7 Charles Keepax 2019-03-19  212  LN1_PIN_AIF(DSP_AIF2);
0548448b719ac7 Charles Keepax 2019-03-19  213  LN1_PIN_AIF(PSIA1);
0548448b719ac7 Charles Keepax 2019-03-19  214  LN1_PIN_AIF(PSIA2);
0548448b719ac7 Charles Keepax 2019-03-19  215  LN1_PIN_AIF(SPDIF_AIF);
0548448b719ac7 Charles Keepax 2019-03-19  216  LN1_PIN_AIF(GF_AIF1);
0548448b719ac7 Charles Keepax 2019-03-19  217  LN1_PIN_AIF(GF_AIF2);
0548448b719ac7 Charles Keepax 2019-03-19  218  LN1_PIN_AIF(GF_AIF3);
0548448b719ac7 Charles Keepax 2019-03-19  219  LN1_PIN_AIF(GF_AIF4);
0548448b719ac7 Charles Keepax 2019-03-19  220  

:::::: The code at line 200 was first introduced by commit
:::::: 0548448b719ac78fa18fdbcd03856952ba6cc7dc pinctrl: lochnagar: Add support for the Cirrus Logic Lochnagar

:::::: TO: Charles Keepax <ckeepax@opensource.cirrus.com>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

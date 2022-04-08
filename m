Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC694F927D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbiDHKFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbiDHKFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:05:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2F5AA02C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649412197; x=1680948197;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GRCicwVJ9E/PIvI/zwT9A7wRg4Kq29TDt1Isy9VJqPE=;
  b=KPBdofNEscCqdzOL5baHXiMrmihaB7Q7UxCUYHjUR25YF5p3vqy0Mw/1
   cpjIW7T8/7Zb378wsKOnFi/432r8di5IA4uHH+rg+hSUSj+gTVKzso6aO
   9kMA+0hWyBQEhu24juZqw0t6aONa9tHIDMg/ZI838Md+czviMzKG5XNDy
   SAHUGCah8nWUY9H1BxWuobgTQmWmq8D1lC591W0/+XehIYfLEiMjBWPFw
   /W4m8KsLoCT0v2aLpEgxP86enBrdzR0wHDyIfr9sGMQADBvb9gXGGQ5dU
   qOkdh1teFTTgEIPRLegXD+TLzHuAU1Qk4RU+pw+bQEvTfAhfEk+Ax+QRS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="241491625"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="241491625"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 03:03:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="698131338"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2022 03:03:14 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nclST-00009J-Ov;
        Fri, 08 Apr 2022 10:03:13 +0000
Date:   Fri, 8 Apr 2022 18:02:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: drivers/pinctrl/cirrus/pinctrl-lochnagar.c:200:1: error: implicit
 declaration of function 'LOCHNAGAR1_' is invalid in C99
Message-ID: <202204081729.f4cgbHob-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   42e7a03d3badebd4e70aea5362d6914dfc7c220b
commit: e8c07082a810fbb9db303a2b66b66b8d7e588b53 Kbuild: move to -std=gnu11
date:   4 weeks ago
config: mips-randconfig-r023-20220408 (https://download.01.org/0day-ci/archive/20220408/202204081729.f4cgbHob-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b306233f78876a1d197ed6e1f05785505de7c63)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e8c07082a810fbb9db303a2b66b66b8d7e588b53
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e8c07082a810fbb9db303a2b66b66b8d7e588b53
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
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
>> drivers/pinctrl/cirrus/pinctrl-lochnagar.c:200:1: error: implicit declaration of function 'LOCHNAGAR1_' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:2: note: expanded from macro 'LN1_PIN_GPIO'
           LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
           ^
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:46: note: expanded from macro 'LN_PIN_GPIO'
           .name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
                                                       ^
   <scratch space>:188:1: note: expanded from here
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
   <scratch space>:188:1: note: expanded from here
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
   <scratch space>:199:1: note: expanded from here
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

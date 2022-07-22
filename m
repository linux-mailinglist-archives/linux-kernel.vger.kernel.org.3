Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEDE57D7CD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 02:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiGVAfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 20:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVAe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 20:34:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E8E83F0C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 17:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658450097; x=1689986097;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VWuyis1h/ygbEL7LBJugLV8CcufWInm5I2naly9MB38=;
  b=dlYQXEWJQKFKM4Ul6ukO/K0vsoEMgDDOy8b7sD69Kasx3Bd5eIp/CfT+
   QDH0DUb1xuPZsODefUFDhY7+S1Jr5SnvUwsK4xMIcLJ6x4VKG6TdqBGq4
   Zkh2ukJkOo8rf/E+WuSPMAkk2EPtcRGUqSKF4mDsl67q3cxFMBne5Q8f1
   ctf/FP65gHy2ifpJ7MhdBIb7NjW3nMX0VxendeMltMIoBGQyasP2vftym
   /XjOaP/1KGFa1l3HnlcqWhlYG/7TeR5d1xDE6nBPYPYp/HJPZa89gbAIT
   Bv0tNJbu3qmeMAEwTWEYsv9HJno++GxXSbnk2Q/reKgimumPJUT37ahHk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="312924976"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="312924976"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 17:33:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="925865632"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jul 2022 17:33:05 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEgbI-0000m8-38;
        Fri, 22 Jul 2022 00:33:04 +0000
Date:   Fri, 22 Jul 2022 08:32:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: drivers/pinctrl/cirrus/pinctrl-lochnagar.c:200:1: error: pasting
 formed 'LOCHNAGAR1_(', an invalid preprocessing token
Message-ID: <202207220837.jtvQ0HOC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   68e77ffbfd06ae3ef8f2abf1c3b971383c866983
commit: c434b9f80b0923e6460031b0fd964f8b0bf3c6a6 MIPS: Kconfig: add MIPS_GENERIC_KERNEL symbol
date:   1 year, 10 months ago
config: mips-randconfig-r016-20220722 (https://download.01.org/0day-ci/archive/20220722/202207220837.jtvQ0HOC-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0c1b32717bcffcf8edf95294e98933bd4c1e76ed)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c434b9f80b0923e6460031b0fd964f8b0bf3c6a6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c434b9f80b0923e6460031b0fd964f8b0bf3c6a6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/pinctrl/cirrus/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/pinctrl/cirrus/pinctrl-lochnagar.c:200:1: error: pasting formed 'LOCHNAGAR1_(', an invalid preprocessing token
   LN1_PIN_GPIO(CDC_RESET,    "codec-reset",    RST,      CDC_RESET,    1);
   ^
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:2: note: expanded from macro 'LN1_PIN_GPIO'
           LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
           ^
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:63: note: expanded from macro 'LN_PIN_GPIO'
           .name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
                                                                        ^
>> drivers/pinctrl/cirrus/pinctrl-lochnagar.c:200:1: error: implicit declaration of function 'LOCHNAGAR1_' [-Werror,-Wimplicit-function-declaration]
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:2: note: expanded from macro 'LN1_PIN_GPIO'
           LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
           ^
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:46: note: expanded from macro 'LN_PIN_GPIO'
           .name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
                                                       ^
   <scratch space>:15:1: note: expanded from here
   LOCHNAGAR1_
   ^
>> drivers/pinctrl/cirrus/pinctrl-lochnagar.c:200:1: error: initializer element is not a compile-time constant
   LN1_PIN_GPIO(CDC_RESET,    "codec-reset",    RST,      CDC_RESET,    1);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:2: note: expanded from macro 'LN1_PIN_GPIO'
           LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:46: note: expanded from macro 'LN_PIN_GPIO'
           .name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
                                                       ^~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:15:1: note: expanded from here
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
   <scratch space>:26:1: note: expanded from here
   LOCHNAGAR1_
   ^
   5 errors generated.


vim +200 drivers/pinctrl/cirrus/pinctrl-lochnagar.c

0548448b719ac78 Charles Keepax 2019-03-19   55  
0548448b719ac78 Charles Keepax 2019-03-19   56  #define LN_PIN_SAIF(REV, ID, NAME) \
0548448b719ac78 Charles Keepax 2019-03-19   57  static const struct lochnagar_pin lochnagar##REV##_##ID##_pin = \
0548448b719ac78 Charles Keepax 2019-03-19   58  	{ .name = NAME, .type = LN_PTYPE_AIF, }
0548448b719ac78 Charles Keepax 2019-03-19   59  
0548448b719ac78 Charles Keepax 2019-03-19   60  #define LN_PIN_AIF(REV, ID) \
0548448b719ac78 Charles Keepax 2019-03-19   61  	LN_PIN_SAIF(REV, ID##_BCLK,  LN_##ID##_STR"-bclk"); \
0548448b719ac78 Charles Keepax 2019-03-19   62  	LN_PIN_SAIF(REV, ID##_LRCLK, LN_##ID##_STR"-lrclk"); \
0548448b719ac78 Charles Keepax 2019-03-19   63  	LN_PIN_SAIF(REV, ID##_RXDAT, LN_##ID##_STR"-rxdat"); \
0548448b719ac78 Charles Keepax 2019-03-19   64  	LN_PIN_SAIF(REV, ID##_TXDAT, LN_##ID##_STR"-txdat")
0548448b719ac78 Charles Keepax 2019-03-19   65  
0548448b719ac78 Charles Keepax 2019-03-19   66  #define LN1_PIN_GPIO(ID, NAME, REG, SHIFT, INVERT) \
0548448b719ac78 Charles Keepax 2019-03-19  @67  	LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
0548448b719ac78 Charles Keepax 2019-03-19   68  
0548448b719ac78 Charles Keepax 2019-03-19   69  #define LN1_PIN_MUX(ID, NAME) \
0548448b719ac78 Charles Keepax 2019-03-19   70  static const struct lochnagar_pin lochnagar1_##ID##_pin = \
0548448b719ac78 Charles Keepax 2019-03-19   71  	{ .name = NAME, .type = LN_PTYPE_MUX, .reg = LOCHNAGAR1_##ID, }
0548448b719ac78 Charles Keepax 2019-03-19   72  
0548448b719ac78 Charles Keepax 2019-03-19   73  #define LN1_PIN_AIF(ID) LN_PIN_AIF(1, ID)
0548448b719ac78 Charles Keepax 2019-03-19   74  
0548448b719ac78 Charles Keepax 2019-03-19   75  #define LN2_PIN_GPIO(ID, NAME, REG, SHIFT, INVERT) \
0548448b719ac78 Charles Keepax 2019-03-19   76  	LN_PIN_GPIO(2, ID, NAME, REG, SHIFT, INVERT)
0548448b719ac78 Charles Keepax 2019-03-19   77  
0548448b719ac78 Charles Keepax 2019-03-19   78  #define LN2_PIN_MUX(ID, NAME) \
0548448b719ac78 Charles Keepax 2019-03-19   79  static const struct lochnagar_pin lochnagar2_##ID##_pin = \
0548448b719ac78 Charles Keepax 2019-03-19   80  	{ .name = NAME, .type = LN_PTYPE_MUX, .reg = LOCHNAGAR2_GPIO_##ID, }
0548448b719ac78 Charles Keepax 2019-03-19   81  
0548448b719ac78 Charles Keepax 2019-03-19   82  #define LN2_PIN_AIF(ID) LN_PIN_AIF(2, ID)
0548448b719ac78 Charles Keepax 2019-03-19   83  
0548448b719ac78 Charles Keepax 2019-03-19   84  #define LN2_PIN_GAI(ID) \
0548448b719ac78 Charles Keepax 2019-03-19   85  	LN2_PIN_MUX(ID##_BCLK,  LN_##ID##_STR"-bclk"); \
0548448b719ac78 Charles Keepax 2019-03-19   86  	LN2_PIN_MUX(ID##_LRCLK, LN_##ID##_STR"-lrclk"); \
0548448b719ac78 Charles Keepax 2019-03-19   87  	LN2_PIN_MUX(ID##_RXDAT, LN_##ID##_STR"-rxdat"); \
0548448b719ac78 Charles Keepax 2019-03-19   88  	LN2_PIN_MUX(ID##_TXDAT, LN_##ID##_STR"-txdat")
0548448b719ac78 Charles Keepax 2019-03-19   89  
0548448b719ac78 Charles Keepax 2019-03-19   90  #define LN_PIN(REV, ID) [LOCHNAGAR##REV##_PIN_##ID] = { \
0548448b719ac78 Charles Keepax 2019-03-19   91  	.number = LOCHNAGAR##REV##_PIN_##ID, \
0548448b719ac78 Charles Keepax 2019-03-19   92  	.name = lochnagar##REV##_##ID##_pin.name, \
0548448b719ac78 Charles Keepax 2019-03-19   93  	.drv_data = (void *)&lochnagar##REV##_##ID##_pin, \
0548448b719ac78 Charles Keepax 2019-03-19   94  }
0548448b719ac78 Charles Keepax 2019-03-19   95  
0548448b719ac78 Charles Keepax 2019-03-19   96  #define LN1_PIN(ID) LN_PIN(1, ID)
0548448b719ac78 Charles Keepax 2019-03-19   97  #define LN2_PIN(ID) LN_PIN(2, ID)
0548448b719ac78 Charles Keepax 2019-03-19   98  
0548448b719ac78 Charles Keepax 2019-03-19   99  #define LN_PINS(REV, ID) \
0548448b719ac78 Charles Keepax 2019-03-19  100  	LN_PIN(REV, ID##_BCLK), LN_PIN(REV, ID##_LRCLK), \
0548448b719ac78 Charles Keepax 2019-03-19  101  	LN_PIN(REV, ID##_RXDAT), LN_PIN(REV, ID##_TXDAT)
0548448b719ac78 Charles Keepax 2019-03-19  102  
0548448b719ac78 Charles Keepax 2019-03-19  103  #define LN1_PINS(ID) LN_PINS(1, ID)
0548448b719ac78 Charles Keepax 2019-03-19  104  #define LN2_PINS(ID) LN_PINS(2, ID)
0548448b719ac78 Charles Keepax 2019-03-19  105  
0548448b719ac78 Charles Keepax 2019-03-19  106  enum {
0548448b719ac78 Charles Keepax 2019-03-19  107  	LOCHNAGAR1_PIN_GF_GPIO2 = LOCHNAGAR1_PIN_NUM_GPIOS,
0548448b719ac78 Charles Keepax 2019-03-19  108  	LOCHNAGAR1_PIN_GF_GPIO3,
0548448b719ac78 Charles Keepax 2019-03-19  109  	LOCHNAGAR1_PIN_GF_GPIO7,
0548448b719ac78 Charles Keepax 2019-03-19  110  	LOCHNAGAR1_PIN_LED1,
0548448b719ac78 Charles Keepax 2019-03-19  111  	LOCHNAGAR1_PIN_LED2,
0548448b719ac78 Charles Keepax 2019-03-19  112  	LOCHNAGAR1_PIN_CDC_AIF1_BCLK,
0548448b719ac78 Charles Keepax 2019-03-19  113  	LOCHNAGAR1_PIN_CDC_AIF1_LRCLK,
0548448b719ac78 Charles Keepax 2019-03-19  114  	LOCHNAGAR1_PIN_CDC_AIF1_RXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  115  	LOCHNAGAR1_PIN_CDC_AIF1_TXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  116  	LOCHNAGAR1_PIN_CDC_AIF2_BCLK,
0548448b719ac78 Charles Keepax 2019-03-19  117  	LOCHNAGAR1_PIN_CDC_AIF2_LRCLK,
0548448b719ac78 Charles Keepax 2019-03-19  118  	LOCHNAGAR1_PIN_CDC_AIF2_RXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  119  	LOCHNAGAR1_PIN_CDC_AIF2_TXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  120  	LOCHNAGAR1_PIN_CDC_AIF3_BCLK,
0548448b719ac78 Charles Keepax 2019-03-19  121  	LOCHNAGAR1_PIN_CDC_AIF3_LRCLK,
0548448b719ac78 Charles Keepax 2019-03-19  122  	LOCHNAGAR1_PIN_CDC_AIF3_RXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  123  	LOCHNAGAR1_PIN_CDC_AIF3_TXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  124  	LOCHNAGAR1_PIN_DSP_AIF1_BCLK,
0548448b719ac78 Charles Keepax 2019-03-19  125  	LOCHNAGAR1_PIN_DSP_AIF1_LRCLK,
0548448b719ac78 Charles Keepax 2019-03-19  126  	LOCHNAGAR1_PIN_DSP_AIF1_RXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  127  	LOCHNAGAR1_PIN_DSP_AIF1_TXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  128  	LOCHNAGAR1_PIN_DSP_AIF2_BCLK,
0548448b719ac78 Charles Keepax 2019-03-19  129  	LOCHNAGAR1_PIN_DSP_AIF2_LRCLK,
0548448b719ac78 Charles Keepax 2019-03-19  130  	LOCHNAGAR1_PIN_DSP_AIF2_RXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  131  	LOCHNAGAR1_PIN_DSP_AIF2_TXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  132  	LOCHNAGAR1_PIN_PSIA1_BCLK,
0548448b719ac78 Charles Keepax 2019-03-19  133  	LOCHNAGAR1_PIN_PSIA1_LRCLK,
0548448b719ac78 Charles Keepax 2019-03-19  134  	LOCHNAGAR1_PIN_PSIA1_RXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  135  	LOCHNAGAR1_PIN_PSIA1_TXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  136  	LOCHNAGAR1_PIN_PSIA2_BCLK,
0548448b719ac78 Charles Keepax 2019-03-19  137  	LOCHNAGAR1_PIN_PSIA2_LRCLK,
0548448b719ac78 Charles Keepax 2019-03-19  138  	LOCHNAGAR1_PIN_PSIA2_RXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  139  	LOCHNAGAR1_PIN_PSIA2_TXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  140  	LOCHNAGAR1_PIN_SPDIF_AIF_BCLK,
0548448b719ac78 Charles Keepax 2019-03-19  141  	LOCHNAGAR1_PIN_SPDIF_AIF_LRCLK,
0548448b719ac78 Charles Keepax 2019-03-19  142  	LOCHNAGAR1_PIN_SPDIF_AIF_RXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  143  	LOCHNAGAR1_PIN_SPDIF_AIF_TXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  144  	LOCHNAGAR1_PIN_GF_AIF3_BCLK,
0548448b719ac78 Charles Keepax 2019-03-19  145  	LOCHNAGAR1_PIN_GF_AIF3_RXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  146  	LOCHNAGAR1_PIN_GF_AIF3_LRCLK,
0548448b719ac78 Charles Keepax 2019-03-19  147  	LOCHNAGAR1_PIN_GF_AIF3_TXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  148  	LOCHNAGAR1_PIN_GF_AIF4_BCLK,
0548448b719ac78 Charles Keepax 2019-03-19  149  	LOCHNAGAR1_PIN_GF_AIF4_RXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  150  	LOCHNAGAR1_PIN_GF_AIF4_LRCLK,
0548448b719ac78 Charles Keepax 2019-03-19  151  	LOCHNAGAR1_PIN_GF_AIF4_TXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  152  	LOCHNAGAR1_PIN_GF_AIF1_BCLK,
0548448b719ac78 Charles Keepax 2019-03-19  153  	LOCHNAGAR1_PIN_GF_AIF1_RXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  154  	LOCHNAGAR1_PIN_GF_AIF1_LRCLK,
0548448b719ac78 Charles Keepax 2019-03-19  155  	LOCHNAGAR1_PIN_GF_AIF1_TXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  156  	LOCHNAGAR1_PIN_GF_AIF2_BCLK,
0548448b719ac78 Charles Keepax 2019-03-19  157  	LOCHNAGAR1_PIN_GF_AIF2_RXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  158  	LOCHNAGAR1_PIN_GF_AIF2_LRCLK,
0548448b719ac78 Charles Keepax 2019-03-19  159  	LOCHNAGAR1_PIN_GF_AIF2_TXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  160  
0548448b719ac78 Charles Keepax 2019-03-19  161  	LOCHNAGAR2_PIN_SPDIF_AIF_BCLK = LOCHNAGAR2_PIN_NUM_GPIOS,
0548448b719ac78 Charles Keepax 2019-03-19  162  	LOCHNAGAR2_PIN_SPDIF_AIF_LRCLK,
0548448b719ac78 Charles Keepax 2019-03-19  163  	LOCHNAGAR2_PIN_SPDIF_AIF_RXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  164  	LOCHNAGAR2_PIN_SPDIF_AIF_TXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  165  	LOCHNAGAR2_PIN_USB_AIF1_BCLK,
0548448b719ac78 Charles Keepax 2019-03-19  166  	LOCHNAGAR2_PIN_USB_AIF1_LRCLK,
0548448b719ac78 Charles Keepax 2019-03-19  167  	LOCHNAGAR2_PIN_USB_AIF1_RXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  168  	LOCHNAGAR2_PIN_USB_AIF1_TXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  169  	LOCHNAGAR2_PIN_USB_AIF2_BCLK,
0548448b719ac78 Charles Keepax 2019-03-19  170  	LOCHNAGAR2_PIN_USB_AIF2_LRCLK,
0548448b719ac78 Charles Keepax 2019-03-19  171  	LOCHNAGAR2_PIN_USB_AIF2_RXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  172  	LOCHNAGAR2_PIN_USB_AIF2_TXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  173  	LOCHNAGAR2_PIN_ADAT_AIF_BCLK,
0548448b719ac78 Charles Keepax 2019-03-19  174  	LOCHNAGAR2_PIN_ADAT_AIF_LRCLK,
0548448b719ac78 Charles Keepax 2019-03-19  175  	LOCHNAGAR2_PIN_ADAT_AIF_RXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  176  	LOCHNAGAR2_PIN_ADAT_AIF_TXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  177  	LOCHNAGAR2_PIN_SOUNDCARD_AIF_BCLK,
0548448b719ac78 Charles Keepax 2019-03-19  178  	LOCHNAGAR2_PIN_SOUNDCARD_AIF_LRCLK,
0548448b719ac78 Charles Keepax 2019-03-19  179  	LOCHNAGAR2_PIN_SOUNDCARD_AIF_RXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  180  	LOCHNAGAR2_PIN_SOUNDCARD_AIF_TXDAT,
0548448b719ac78 Charles Keepax 2019-03-19  181  };
0548448b719ac78 Charles Keepax 2019-03-19  182  
0548448b719ac78 Charles Keepax 2019-03-19  183  enum lochnagar_pin_type {
0548448b719ac78 Charles Keepax 2019-03-19  184  	LN_PTYPE_GPIO,
0548448b719ac78 Charles Keepax 2019-03-19  185  	LN_PTYPE_MUX,
0548448b719ac78 Charles Keepax 2019-03-19  186  	LN_PTYPE_AIF,
0548448b719ac78 Charles Keepax 2019-03-19  187  	LN_PTYPE_COUNT,
0548448b719ac78 Charles Keepax 2019-03-19  188  };
0548448b719ac78 Charles Keepax 2019-03-19  189  
0548448b719ac78 Charles Keepax 2019-03-19  190  struct lochnagar_pin {
0548448b719ac78 Charles Keepax 2019-03-19  191  	const char name[20];
0548448b719ac78 Charles Keepax 2019-03-19  192  
0548448b719ac78 Charles Keepax 2019-03-19  193  	enum lochnagar_pin_type type;
0548448b719ac78 Charles Keepax 2019-03-19  194  
0548448b719ac78 Charles Keepax 2019-03-19  195  	unsigned int reg;
0548448b719ac78 Charles Keepax 2019-03-19  196  	int shift;
0548448b719ac78 Charles Keepax 2019-03-19  197  	bool invert;
0548448b719ac78 Charles Keepax 2019-03-19  198  };
0548448b719ac78 Charles Keepax 2019-03-19  199  
0548448b719ac78 Charles Keepax 2019-03-19 @200  LN1_PIN_GPIO(CDC_RESET,    "codec-reset",    RST,      CDC_RESET,    1);
0548448b719ac78 Charles Keepax 2019-03-19  201  LN1_PIN_GPIO(DSP_RESET,    "dsp-reset",      RST,      DSP_RESET,    1);
0548448b719ac78 Charles Keepax 2019-03-19  202  LN1_PIN_GPIO(CDC_CIF1MODE, "codec-cif1mode", I2C_CTRL, CDC_CIF_MODE, 0);
0548448b719ac78 Charles Keepax 2019-03-19  203  LN1_PIN_MUX(GF_GPIO2,      "gf-gpio2");
0548448b719ac78 Charles Keepax 2019-03-19  204  LN1_PIN_MUX(GF_GPIO3,      "gf-gpio3");
0548448b719ac78 Charles Keepax 2019-03-19  205  LN1_PIN_MUX(GF_GPIO7,      "gf-gpio7");
0548448b719ac78 Charles Keepax 2019-03-19  206  LN1_PIN_MUX(LED1,          "led1");
0548448b719ac78 Charles Keepax 2019-03-19  207  LN1_PIN_MUX(LED2,          "led2");
0548448b719ac78 Charles Keepax 2019-03-19  208  LN1_PIN_AIF(CDC_AIF1);
0548448b719ac78 Charles Keepax 2019-03-19  209  LN1_PIN_AIF(CDC_AIF2);
0548448b719ac78 Charles Keepax 2019-03-19  210  LN1_PIN_AIF(CDC_AIF3);
0548448b719ac78 Charles Keepax 2019-03-19  211  LN1_PIN_AIF(DSP_AIF1);
0548448b719ac78 Charles Keepax 2019-03-19  212  LN1_PIN_AIF(DSP_AIF2);
0548448b719ac78 Charles Keepax 2019-03-19  213  LN1_PIN_AIF(PSIA1);
0548448b719ac78 Charles Keepax 2019-03-19  214  LN1_PIN_AIF(PSIA2);
0548448b719ac78 Charles Keepax 2019-03-19  215  LN1_PIN_AIF(SPDIF_AIF);
0548448b719ac78 Charles Keepax 2019-03-19  216  LN1_PIN_AIF(GF_AIF1);
0548448b719ac78 Charles Keepax 2019-03-19  217  LN1_PIN_AIF(GF_AIF2);
0548448b719ac78 Charles Keepax 2019-03-19  218  LN1_PIN_AIF(GF_AIF3);
0548448b719ac78 Charles Keepax 2019-03-19  219  LN1_PIN_AIF(GF_AIF4);
0548448b719ac78 Charles Keepax 2019-03-19  220  

:::::: The code at line 200 was first introduced by commit
:::::: 0548448b719ac78fa18fdbcd03856952ba6cc7dc pinctrl: lochnagar: Add support for the Cirrus Logic Lochnagar

:::::: TO: Charles Keepax <ckeepax@opensource.cirrus.com>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

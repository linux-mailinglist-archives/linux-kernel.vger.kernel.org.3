Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F970489AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiAJNzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:55:07 -0500
Received: from mga17.intel.com ([192.55.52.151]:14998 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233954AbiAJNzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641822902; x=1673358902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cicLgHiEPGQOrIjOfgQxMbxQzmM/uxWwtuhfal7Bd1E=;
  b=RV9w3h5YLKb0fQsezk6H+TVgvtg2POfb2gE3tTh9DeWqPfeyEV3150Ew
   ug29tEtAQhcmFfFucYEGRS/zn9KNuJ5JrVcuA+M7K2/tPxAZvPIpP29RV
   Uc3ni8H7Uhpg0x+iPtQwEerXTo7HooTCHfcIllet1PeDFIqVFR0TEa4QE
   HuVe1JMMRdbAWbE4rnZ+gM+38nN98+wIKMapR5btpvHB0gIbyYnej75KJ
   0pM6LH4LMQ5CfQdGy3t5eO1dfEfElvjD7nXtQRYtjGlsq/VA2TA7JnSiD
   fHHLKu++CpYsAkRWPJBjuEvCVqmdLg93ZXqBd55LZdZel/39k/XGBcDZa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="223921295"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="223921295"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 05:55:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="764520088"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jan 2022 05:54:59 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6v8U-0003ZZ-I4; Mon, 10 Jan 2022 13:54:58 +0000
Date:   Mon, 10 Jan 2022 21:54:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>
Subject: Re: [PATCH v4 5/9] pinctrl: nuvoton: Add driver for WPCM450
Message-ID: <202201102127.3Rm7ZYyP-lkp@intel.com>
References: <20220109173000.1242703-6-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220109173000.1242703-6-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Jonathan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v5.16 next-20220110]
[cannot apply to linusw-pinctrl/devel]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jonathan-Neusch-fer/Nuvoton-WPCM450-pinctrl-and-GPIO-driver/20220110-013733
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-randconfig-r014-20220109 (https://download.01.org/0day-ci/archive/20220110/202201102127.3Rm7ZYyP-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f3a344d2125fa37e59bae1b0874442c650a19607)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/e62ece12931654ffea372713cc39fd64779c8b4a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jonathan-Neusch-fer/Nuvoton-WPCM450-pinctrl-and-GPIO-driver/20220110-013733
        git checkout e62ece12931654ffea372713cc39fd64779c8b4a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/pinctrl/nuvoton/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c:1564:41: warning: format specifies type 'int' but the argument has type 'unsigned long' [-Wformat]
           dev_dbg(npcm->dev, "group size: %d\n", ARRAY_SIZE(npcm7xx_groups));
                                           ~~     ^~~~~~~~~~~~~~~~~~~~~~~~~~
                                           %lu
   include/linux/dev_printk.h:163:47: note: expanded from macro 'dev_dbg'
                   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                                       ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:129:34: note: expanded from macro 'dev_printk'
                   _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
                                           ~~~    ^~~~~~~~~~~
   include/linux/kernel.h:46:25: note: expanded from macro 'ARRAY_SIZE'
   #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +1564 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c

3b588e43ee5c7a Tomer Maimon 2018-08-08  1559  
3b588e43ee5c7a Tomer Maimon 2018-08-08  1560  static int npcm7xx_get_groups_count(struct pinctrl_dev *pctldev)
3b588e43ee5c7a Tomer Maimon 2018-08-08  1561  {
3b588e43ee5c7a Tomer Maimon 2018-08-08  1562  	struct npcm7xx_pinctrl *npcm = pinctrl_dev_get_drvdata(pctldev);
3b588e43ee5c7a Tomer Maimon 2018-08-08  1563  
3b588e43ee5c7a Tomer Maimon 2018-08-08 @1564  	dev_dbg(npcm->dev, "group size: %d\n", ARRAY_SIZE(npcm7xx_groups));
3b588e43ee5c7a Tomer Maimon 2018-08-08  1565  	return ARRAY_SIZE(npcm7xx_groups);
3b588e43ee5c7a Tomer Maimon 2018-08-08  1566  }
3b588e43ee5c7a Tomer Maimon 2018-08-08  1567  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

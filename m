Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0916546CAEB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 03:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbhLHCiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 21:38:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:10832 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233825AbhLHCiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 21:38:00 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="323997486"
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="323997486"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 18:34:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="563914899"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 07 Dec 2021 18:34:27 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mummj-000NHB-CB; Wed, 08 Dec 2021 02:34:21 +0000
Date:   Wed, 8 Dec 2021 10:34:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH v2 5/8] pinctrl: nuvoton: Add driver for WPCM450
Message-ID: <202112081056.4i0VFldF-lkp@intel.com>
References: <20211207210823.1975632-6-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207210823.1975632-6-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Jonathan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on robh/for-next linus/master v5.16-rc4 next-20211207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jonathan-Neusch-fer/Nuvoton-WPCM450-pinctrl-and-GPIO-driver/20211208-051101
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
config: arm64-randconfig-r014-20211207 (https://download.01.org/0day-ci/archive/20211208/202112081056.4i0VFldF-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/c08fb0aafb60234854aa86433da809fe5112f55e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jonathan-Neusch-fer/Nuvoton-WPCM450-pinctrl-and-GPIO-driver/20211208-051101
        git checkout c08fb0aafb60234854aa86433da809fe5112f55e
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

3b588e43ee5c7ad Tomer Maimon 2018-08-08  1559  
3b588e43ee5c7ad Tomer Maimon 2018-08-08  1560  static int npcm7xx_get_groups_count(struct pinctrl_dev *pctldev)
3b588e43ee5c7ad Tomer Maimon 2018-08-08  1561  {
3b588e43ee5c7ad Tomer Maimon 2018-08-08  1562  	struct npcm7xx_pinctrl *npcm = pinctrl_dev_get_drvdata(pctldev);
3b588e43ee5c7ad Tomer Maimon 2018-08-08  1563  
3b588e43ee5c7ad Tomer Maimon 2018-08-08 @1564  	dev_dbg(npcm->dev, "group size: %d\n", ARRAY_SIZE(npcm7xx_groups));
3b588e43ee5c7ad Tomer Maimon 2018-08-08  1565  	return ARRAY_SIZE(npcm7xx_groups);
3b588e43ee5c7ad Tomer Maimon 2018-08-08  1566  }
3b588e43ee5c7ad Tomer Maimon 2018-08-08  1567  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

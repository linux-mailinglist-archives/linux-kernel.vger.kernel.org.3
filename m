Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512EB4FB1F4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 04:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244408AbiDKCr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 22:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiDKCry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 22:47:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C93241F9E
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 19:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649645141; x=1681181141;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/guYAOhzY3kg2U+LMYXxoqg+HRlp+Twuas2ezl+bAcA=;
  b=jDaUrPGq0iPAHa34jx193cOh8iPLtD7mGZpzOm9idCP9K3FihzzWCcto
   a/xkxew4gWTbpDEhgJCXUi4ga0u7JtbJ2rQ9qNTNY6eiNV6aQ0pRhUFOx
   mjTwyGAMjflZo3iq1rcl+NKik/yp5pymy2Ro8faNmYeFXlQkMg9KVBMam
   XX36Fc8RZ/DBLf/4TLW352QGj4bVt3Dl5/ZmA67bvtQmL3sDeASlDrtoO
   b8YUP6Q/nFe9nAcv5w9RN8tQn8zS/Ehb9aHuNnXq2HptIUJjQLWM7bDLJ
   Oq0OKjvdN7KU6MBq3qhCACkSTPaoueKs/jrSrkXtQiND40Pu0pS61F2Of
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="322462406"
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="322462406"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 19:45:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="525785070"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 10 Apr 2022 19:45:26 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndk3R-0001Lf-Jc;
        Mon, 11 Apr 2022 02:45:25 +0000
Date:   Mon, 11 Apr 2022 10:44:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     popcornmix <popcornmix@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [l1k:smsc95xx_5.17 79/888] drivers/gpio/gpio-bcm-virt.c:34:31:
 warning: variable 'gpio' set but not used
Message-ID: <202204110940.lcDSN1kZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   240f56c27361c195cd502d95aba51c6b8e5b808c
commit: caa59900dd53b8b063c04d41c7c0b1450f296b52 [79/888] bcm2835-virtgpio: Virtual GPIO driver
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220411/202204110940.lcDSN1kZ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/caa59900dd53b8b063c04d41c7c0b1450f296b52
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout caa59900dd53b8b063c04d41c7c0b1450f296b52
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/char/broadcom/ drivers/gpio/ drivers/perf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpio/gpio-bcm-virt.c: In function 'brcmvirt_gpio_dir_in':
>> drivers/gpio/gpio-bcm-virt.c:34:31: warning: variable 'gpio' set but not used [-Wunused-but-set-variable]
      34 |         struct brcmvirt_gpio *gpio;
         |                               ^~~~
   drivers/gpio/gpio-bcm-virt.c: In function 'brcmvirt_gpio_dir_out':
   drivers/gpio/gpio-bcm-virt.c:41:31: warning: variable 'gpio' set but not used [-Wunused-but-set-variable]
      41 |         struct brcmvirt_gpio *gpio;
         |                               ^~~~


vim +/gpio +34 drivers/gpio/gpio-bcm-virt.c

    31	
    32	static int brcmvirt_gpio_dir_in(struct gpio_chip *gc, unsigned off)
    33	{
  > 34		struct brcmvirt_gpio *gpio;
    35		gpio = container_of(gc, struct brcmvirt_gpio, gc);
    36		return -EINVAL;
    37	}
    38	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131DE48462B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbiADQrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:47:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:28915 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230369AbiADQrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641314824; x=1672850824;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Xw6d11zyA032hxyNek04PzgstU6QQ78asDn4FrZ1lkI=;
  b=X76lM61f7+aRNAotkp87FmwC0m0DOSLHYDFHFgmelWPwIGX6TJZnz9nz
   cMj8wh0oavP4buf3+KmzRLNXojCLQHaBH6MNJL//dHso1Yj4MUCFVsOKr
   EMLlteYCTs62l36QahZ80T0CpxAflfHGjts2Ds8kdL3Xj840U4/aVLIKM
   GU3hHhNY+LkuKsdQ6XzzDljdL9rqEiARMAn82ZUynr7vh9pLzqUqiSCrN
   n7zr7qwXzcon32fBQggsHO2KgBUCMphP0BmouBvHwwJfk/JYAr4j9CXgT
   Xc0KHakQ1hvu9atbqFMPw/lDZkSM2mZ2MOcNTvMKZOOAxV3cDgXd9ZRUP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="328598746"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="328598746"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 08:47:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="470220816"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Jan 2022 08:47:01 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4mxh-000FeW-8l; Tue, 04 Jan 2022 16:47:01 +0000
Date:   Wed, 5 Jan 2022 00:46:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [linux-stable-rc:queue/5.10 2766/9999] xillybus_of.c:undefined
 reference to `devm_platform_ioremap_resource'
Message-ID: <202201050034.Jg48FZlD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.10
head:   d6246530b6944329cf73012833f4debf8f24767d
commit: ba02635769f18a9231aba6e032d65f1fa6c537b4 [2766/9999] init/Kconfig: make COMPILE_TEST depend on !S390
config: s390-buildonly-randconfig-r003-20220104 (https://download.01.org/0day-ci/archive/20220105/202201050034.Jg48FZlD-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=ba02635769f18a9231aba6e032d65f1fa6c537b4
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.10
        git checkout ba02635769f18a9231aba6e032d65f1fa6c537b4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: kernel/dma/coherent.o: in function `dma_init_coherent_memory':
   coherent.c:(.text+0x1080): undefined reference to `memremap'
   s390-linux-ld: coherent.c:(.text+0x12e0): undefined reference to `memunmap'
   s390-linux-ld: kernel/dma/coherent.o: in function `dma_declare_coherent_memory':
   coherent.c:(.text+0x17c8): undefined reference to `memunmap'
   s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
   irq-al-fic.c:(.init.text+0xa8): undefined reference to `of_iomap'
   s390-linux-ld: irq-al-fic.c:(.init.text+0x272): undefined reference to `iounmap'
   s390-linux-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
>> xillybus_of.c:(.text+0x402): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
   cistpl.c:(.text+0x22dc): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x2360): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0x2630): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0x26a2): undefined reference to `iounmap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
   cistpl.c:(.text+0x486c): undefined reference to `iounmap'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

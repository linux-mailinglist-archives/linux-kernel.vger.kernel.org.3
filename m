Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390EB4826D1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 08:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiAAHBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 02:01:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:1115 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbiAAHBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 02:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641020492; x=1672556492;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=D1gmADyMPTB+TL1vwJsD/SAIMCt+j+2fIslS4esB5IA=;
  b=hGDK7CdL6utSBsQwRwAOMC+MyUHuvthwvtZKe1TFSwEk9E7MC9P8hgzf
   u0YbZzprkc/7uayA50KGJuKd3OB2DjnqydKMHmo7aD5fDnlPi4wwYzS4J
   4wcOtYs/i3dP7l6/WF5FrRfTf52NubgzbHMBfprQn7pxfZyyU7T1XB8oU
   LFKFIiK9nXAPFwvI/Cs+z+GGvqiir+wIiC5MkKDdMdAeJIo7p3vUxOZR6
   HqV6w1FORwa9Lix8pgYq89Ykfi89HviuNa+SAY3Pg7YsFwZLHLmFuZ+f8
   gxvt3lOkkng8BK6kvgGU1oyq55CuXxwsvcRJPA9SCqk5LmcNG+iOSqN6y
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="266128746"
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="266128746"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 23:01:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="619803107"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 31 Dec 2021 23:01:30 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3YOQ-000C8v-04; Sat, 01 Jan 2022 07:01:30 +0000
Date:   Sat, 1 Jan 2022 15:01:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: include/asm-generic/io.h:291:22: sparse: sparse: incorrect type in
 argument 1 (different base types)
Message-ID: <202201011509.UfnDepRD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8008293888188c3923f5bd8a69370dae25ed14e5
commit: 6e1e90ec027509a7e8d4efbd77a65b32b5a8b3ec regmap: mmio: add config option to allow relaxed MMIO accesses
date:   1 year, 2 months ago
config: h8300-randconfig-s031-20211117 (https://download.01.org/0day-ci/archive/20220101/202201011509.UfnDepRD-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e1e90ec027509a7e8d4efbd77a65b32b5a8b3ec
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6e1e90ec027509a7e8d4efbd77a65b32b5a8b3ec
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=h8300 SHELL=/bin/bash drivers/base/regmap/ lib/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/base/regmap/regmap-mmio.c: note: in included file (through include/linux/io.h):
   arch/h8300/include/asm/io.h:32:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:32:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:38:11: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/base/regmap/regmap-mmio.c: note: in included file (through arch/h8300/include/asm/io.h, include/linux/io.h):
>> include/asm-generic/io.h:291:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] b @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:291:22: sparse:     expected unsigned short [usertype] b
   include/asm-generic/io.h:291:22: sparse:     got restricted __le16 [usertype]
   drivers/base/regmap/regmap-mmio.c: note: in included file (through include/linux/io.h):
   arch/h8300/include/asm/io.h:38:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:38:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/base/regmap/regmap-mmio.c: note: in included file (through arch/h8300/include/asm/io.h, include/linux/io.h):
   include/asm-generic/io.h:299:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] b @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:22: sparse:     expected unsigned int [usertype] b
   include/asm-generic/io.h:299:22: sparse:     got restricted __le32 [usertype]
   drivers/base/regmap/regmap-mmio.c: note: in included file (through include/linux/io.h):
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:14:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:14:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:20:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:20:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/base/regmap/regmap-mmio.c: note: in included file (through arch/h8300/include/asm/io.h, include/linux/io.h):
   include/asm-generic/io.h:259:16: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:259:16: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:259:16: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:259:16: sparse: sparse: cast to restricted __le16
   drivers/base/regmap/regmap-mmio.c: note: in included file (through include/linux/io.h):
   arch/h8300/include/asm/io.h:20:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:20:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:20:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:20:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:20:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:20:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/base/regmap/regmap-mmio.c: note: in included file (through arch/h8300/include/asm/io.h, include/linux/io.h):
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   drivers/base/regmap/regmap-mmio.c: note: in included file (through include/linux/io.h):
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression

vim +291 include/asm-generic/io.h

9439eb3ab9d1ec Will Deacon 2013-09-03  286  
9439eb3ab9d1ec Will Deacon 2013-09-03  287  #ifndef writew_relaxed
a71e7c44ffb7ba Sinan Kaya  2018-04-06  288  #define writew_relaxed writew_relaxed
a71e7c44ffb7ba Sinan Kaya  2018-04-06  289  static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
a71e7c44ffb7ba Sinan Kaya  2018-04-06  290  {
a71e7c44ffb7ba Sinan Kaya  2018-04-06 @291  	__raw_writew(cpu_to_le16(value), addr);
a71e7c44ffb7ba Sinan Kaya  2018-04-06  292  }
9439eb3ab9d1ec Will Deacon 2013-09-03  293  #endif
9439eb3ab9d1ec Will Deacon 2013-09-03  294  

:::::: The code at line 291 was first introduced by commit
:::::: a71e7c44ffb7baea0c0795824afc34cc0bc1a301 io: change writeX_relaxed() to remove barriers

:::::: TO: Sinan Kaya <okaya@codeaurora.org>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

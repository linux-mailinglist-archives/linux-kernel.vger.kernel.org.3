Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDFCB48F947
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 21:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiAOUdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 15:33:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:25339 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231473AbiAOUde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 15:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642278814; x=1673814814;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cNGJphuE7HVOa8CkmE5+ouzbY85/PVX1gycgYU3UPk8=;
  b=UCFasyKwFQ/9/cAoKMOF19bbClH+s5LsJ+AAfHJfRG58gMqzoUBSA4yV
   Kwfphy+LSsRlIULubbz2UwF6EbA9Jj/PbfqY8TwBh+IIFnrOtxoWxtV9s
   Dpm7ehZFoKcmcKFtD4HGSg+aSoleIUERcUqobKx2EqoowPvB4LMf562+/
   /0p808dn+UeA11yYFrlNJ4F5094+vrZsDHztOdyD87UQEmFX1dP34gP4K
   jX++ZtbijKeeytm+tlShPl+EhgfuNu26DU48UG3u9x4jy1X/8Bsx5FtQX
   oKxiMjnrEuEBbSyHzA7QIkw/hwAWueaAQ+8KElW+jz2Cugfy1T3Bg+RUt
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="244233043"
X-IronPort-AV: E=Sophos;i="5.88,292,1635231600"; 
   d="scan'208";a="244233043"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 12:33:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,292,1635231600"; 
   d="scan'208";a="692627326"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Jan 2022 12:33:33 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8pjw-000AHO-Ej; Sat, 15 Jan 2022 20:33:32 +0000
Date:   Sun, 16 Jan 2022 04:32:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-ixp4xx/common-pci.c:143:5: warning: no previous
 prototype for 'ixp4xx_pci_write'
Message-ID: <202201160420.v9oG29Pi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a33f5c380c4bd3fa5278d690421b72052456d9fe
commit: d5d9f7ac58ea1041375a028f143ca5784693ea86 ARM/ixp4xx: Make NEED_MACH_IO_H optional
date:   7 months ago
config: arm-randconfig-r002-20220115 (https://download.01.org/0day-ci/archive/20220116/202201160420.v9oG29Pi-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5d9f7ac58ea1041375a028f143ca5784693ea86
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d5d9f7ac58ea1041375a028f143ca5784693ea86
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm/mach-ixp4xx/common-pci.c:94:5: warning: no previous prototype for 'ixp4xx_pci_read_errata' [-Wmissing-prototypes]
      94 | int ixp4xx_pci_read_errata(u32 addr, u32 cmd, u32* data)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-ixp4xx/common-pci.c:121:5: warning: no previous prototype for 'ixp4xx_pci_read_no_errata' [-Wmissing-prototypes]
     121 | int ixp4xx_pci_read_no_errata(u32 addr, u32 cmd, u32* data)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm/mach-ixp4xx/common-pci.c:143:5: warning: no previous prototype for 'ixp4xx_pci_write' [-Wmissing-prototypes]
     143 | int ixp4xx_pci_write(u32 addr, u32 cmd, u32 data)
         |     ^~~~~~~~~~~~~~~~


vim +/ixp4xx_pci_write +143 arch/arm/mach-ixp4xx/common-pci.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  142  
^1da177e4c3f41 Linus Torvalds  2005-04-16 @143  int ixp4xx_pci_write(u32 addr, u32 cmd, u32 data)
^1da177e4c3f41 Linus Torvalds  2005-04-16  144  {    
^1da177e4c3f41 Linus Torvalds  2005-04-16  145  	unsigned long flags;
^1da177e4c3f41 Linus Torvalds  2005-04-16  146  	int retval = 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  147  
bd31b85960a7fc Thomas Gleixner 2009-07-03  148  	raw_spin_lock_irqsave(&ixp4xx_pci_lock, flags);
^1da177e4c3f41 Linus Torvalds  2005-04-16  149  
^1da177e4c3f41 Linus Torvalds  2005-04-16  150  	*PCI_NP_AD = addr;
^1da177e4c3f41 Linus Torvalds  2005-04-16  151  
^1da177e4c3f41 Linus Torvalds  2005-04-16  152  	/* set up the write */
^1da177e4c3f41 Linus Torvalds  2005-04-16  153  	*PCI_NP_CBE = cmd;
^1da177e4c3f41 Linus Torvalds  2005-04-16  154  
^1da177e4c3f41 Linus Torvalds  2005-04-16  155  	/* execute the write by writing to NP_WDATA */
^1da177e4c3f41 Linus Torvalds  2005-04-16  156  	*PCI_NP_WDATA = data;
^1da177e4c3f41 Linus Torvalds  2005-04-16  157  
^1da177e4c3f41 Linus Torvalds  2005-04-16  158  	if(check_master_abort())
^1da177e4c3f41 Linus Torvalds  2005-04-16  159  		retval = 1;
^1da177e4c3f41 Linus Torvalds  2005-04-16  160  
bd31b85960a7fc Thomas Gleixner 2009-07-03  161  	raw_spin_unlock_irqrestore(&ixp4xx_pci_lock, flags);
^1da177e4c3f41 Linus Torvalds  2005-04-16  162  	return retval;
^1da177e4c3f41 Linus Torvalds  2005-04-16  163  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  164  

:::::: The code at line 143 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B78048C947
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 18:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350006AbiALRX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 12:23:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:45290 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350009AbiALRX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642008207; x=1673544207;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9XhBsTlbflZR5cFj2Ctv0MUAiEdS3gEqY5TeMTTEcbo=;
  b=EoJ/kW5vRzLz6Odk9jLcsreDtRKcdGQpgCuMoHR3lBKpfrrlW0ESwM1r
   w93QS5rcBZkxkUzPg/dk8Ef3TVapUn9+kianOK2fb2AhHctx4GDX9SD1i
   hLxWJE+ARhww9WrKwwrcV7DRj1WCXUe2FP2k4ciDJWZbxDe9UEXpw6HgL
   hw6tWwIsKNOU3/L5B0vgN1N6Q0FCsPu6L0dZ036R3PADQmKaRuCLiWbQn
   Owo6OfbqESi7fIwFTNZk6C66Zl+2x4nIecJJe5nIy4bofyzV+D/5ioPrX
   HsMYZw2SzqrA9GQ8G6G9z/eQttSmOwn0mBhsADvAZDlqmxEcU6iZWDXdD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="242607556"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="242607556"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 09:21:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="515570153"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 12 Jan 2022 09:21:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7hJ1-00069q-RU; Wed, 12 Jan 2022 17:21:03 +0000
Date:   Thu, 13 Jan 2022 01:20:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: arch/arm/mach-ixp4xx/common-pci.c:143:5: warning: no previous
 prototype for function 'ixp4xx_pci_write'
Message-ID: <202201130136.7675O5xx-lkp@intel.com>
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
head:   daadb3bd0e8d3e317e36bc2c1542e86c528665e5
commit: d5d9f7ac58ea1041375a028f143ca5784693ea86 ARM/ixp4xx: Make NEED_MACH_IO_H optional
date:   7 months ago
config: arm-ixp4xx_defconfig (https://download.01.org/0day-ci/archive/20220113/202201130136.7675O5xx-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 244dd2913a43a200f5a6544d424cdc37b771028b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5d9f7ac58ea1041375a028f143ca5784693ea86
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d5d9f7ac58ea1041375a028f143ca5784693ea86
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm/mach-ixp4xx/common-pci.c:94:5: warning: no previous prototype for function 'ixp4xx_pci_read_errata' [-Wmissing-prototypes]
   int ixp4xx_pci_read_errata(u32 addr, u32 cmd, u32* data)
       ^
   arch/arm/mach-ixp4xx/common-pci.c:94:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int ixp4xx_pci_read_errata(u32 addr, u32 cmd, u32* data)
   ^
   static 
   arch/arm/mach-ixp4xx/common-pci.c:121:5: warning: no previous prototype for function 'ixp4xx_pci_read_no_errata' [-Wmissing-prototypes]
   int ixp4xx_pci_read_no_errata(u32 addr, u32 cmd, u32* data)
       ^
   arch/arm/mach-ixp4xx/common-pci.c:121:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int ixp4xx_pci_read_no_errata(u32 addr, u32 cmd, u32* data)
   ^
   static 
>> arch/arm/mach-ixp4xx/common-pci.c:143:5: warning: no previous prototype for function 'ixp4xx_pci_write' [-Wmissing-prototypes]
   int ixp4xx_pci_write(u32 addr, u32 cmd, u32 data)
       ^
   arch/arm/mach-ixp4xx/common-pci.c:143:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int ixp4xx_pci_write(u32 addr, u32 cmd, u32 data)
   ^
   static 
   3 warnings generated.


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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745C7488394
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 13:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiAHMZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 07:25:58 -0500
Received: from mga05.intel.com ([192.55.52.43]:27776 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231898AbiAHMZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 07:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641644755; x=1673180755;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VGMzg5+M4xfhiFINNgM/zm2VfzrVZcV7YDKH4AHdMDw=;
  b=jeDe2YIPsx1Tzusr7N8BJlP3Bk3DBAZAs9TOxxShLUK7Z8WR2r/TJfa/
   usAE6fxByUvDayWymwFPr3n9qDQ8N4c28QmSnZZEmyTslx3sjamL/Oc9y
   U7sXm9SGiQ1oXjIh+ofQoj2hs1Ank7Ha0wTmu9a/QBHqjF0YRbF4iQ7XM
   69dhmNdQH6z14ILoNXSB2DCZ7RudQfA++IiUiUD1VYEW4VOdagF2YJkfM
   42QckePHcAapOiCMh6nSOSSMhPNasq4MtUGR02Lo+2jRzKK/gOAJY38Pf
   pqVzvkrxZNgPYAlyzjieHAgJYMnt/x4aoou63gH5cgpYoNvoZGgIpXFXp
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="329352902"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="329352902"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 04:25:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="489567466"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 08 Jan 2022 04:25:53 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6AnB-0000cC-4J; Sat, 08 Jan 2022 12:25:53 +0000
Date:   Sat, 8 Jan 2022 20:25:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alistair Delva <adelva@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.10-m2107
 1249/8698] arch/mips/include/asm/page.h:12:10: fatal error: spaces.h: No
 such file or directory
Message-ID: <202201082026.uKMX15sB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sami,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.10-m2107
head:   6b5101a5720784d91a53168bfbc90c940ee6817f
commit: 08f67ef189ecce0f8330e53e5b78157f1b5afa19 [1249/8698] ANDROID: module: cfi: ensure __cfi_check alignment
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220108/202201082026.uKMX15sB-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/08f67ef189ecce0f8330e53e5b78157f1b5afa19
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.10-m2107
        git checkout 08f67ef189ecce0f8330e53e5b78157f1b5afa19
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips modules_prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from scripts/module.lds.S:6:
>> arch/mips/include/asm/page.h:12:10: fatal error: spaces.h: No such file or directory
      12 | #include <spaces.h>
         |          ^~~~~~~~~~
   compilation terminated.
   make[2]: *** [scripts/Makefile.build:367: scripts/module.lds] Error 1
   make[1]: *** [Makefile:1469: modules_prepare] Error 2
   make: *** [Makefile:185: __sub-make] Error 2
   make: Target 'modules_prepare' not remade because of errors.


vim +12 arch/mips/include/asm/page.h

^1da177e4c3f41 include/asm-mips/page.h      Linus Torvalds  2005-04-16  11  
^1da177e4c3f41 include/asm-mips/page.h      Linus Torvalds  2005-04-16 @12  #include <spaces.h>
99502d94c3649c arch/mips/include/asm/page.h Nelson Elhage   2009-07-31  13  #include <linux/const.h>
75b5b5e0a26279 arch/mips/include/asm/page.h Leonid Yegoshin 2013-11-14  14  #include <linux/kernel.h>
75b5b5e0a26279 arch/mips/include/asm/page.h Leonid Yegoshin 2013-11-14  15  #include <asm/mipsregs.h>
^1da177e4c3f41 include/asm-mips/page.h      Linus Torvalds  2005-04-16  16  

:::::: The code at line 12 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

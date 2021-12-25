Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93EC47F414
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 18:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhLYR3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 12:29:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:12521 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhLYR3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 12:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640453385; x=1671989385;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RXnKKps3s7gdA3XpCWp5O615YkZeZisBOJcqDEMda3k=;
  b=F7fiR/gNNb0A0cTsV9VE1uHvQmdhE0sZuZHL6WoWoGaZMJ1Sx6B9hu5f
   ilci+E9zwgptlXwcFGmpUlRZG6IlFGopbJfGLg1H+5SW5V8QR7eBAki8S
   8WI1CcJKi0DAS7oXzoUujUXCwWutc++wBSU8sWTJ6s+f6J1GJdoCaSlkR
   W06W+SaGPFpwobXJMjQ+oWTjJQfuZcsm8mPj2e+2BtdPmKOwGSpDQVkad
   p0srA1rdP7JAU1wL0SA1NMnfOXH7Jr9Wb7JNX9ftWixJfWVgRUsGumT1v
   67JeSEUK0wMYUwbSCtzoXdd9gBUxDRyxYCOuRpTTkDJkwECMby/4ImGnB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="304425144"
X-IronPort-AV: E=Sophos;i="5.88,235,1635231600"; 
   d="scan'208";a="304425144"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2021 09:29:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,235,1635231600"; 
   d="scan'208";a="469322545"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Dec 2021 09:29:43 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1ArX-0004Ur-0w; Sat, 25 Dec 2021 17:29:43 +0000
Date:   Sun, 26 Dec 2021 01:29:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: drivers/media/common/saa7146/saa7146_hlp.c:648:5: warning: stack
 frame size (1072) exceeds limit (1024) in 'saa7146_enable_overlay'
Message-ID: <202112260105.aWgXZDC6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b927dfc67d05a72167ab980c375ed98b2ee9c2c6
commit: 8341dcfbd8dda98a3b2836a421016f7d88e35b1c riscv: Enable Undefined Behavior Sanitizer UBSAN
date:   4 months ago
config: riscv-randconfig-c006-20211225 (https://download.01.org/0day-ci/archive/20211226/202112260105.aWgXZDC6-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project a9e8b1ee7fd44b53c555a7823ae8fd1a8209c520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8341dcfbd8dda98a3b2836a421016f7d88e35b1c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8341dcfbd8dda98a3b2836a421016f7d88e35b1c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/media/common/saa7146/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/common/saa7146/saa7146_hlp.c:648:5: warning: stack frame size (1072) exceeds limit (1024) in 'saa7146_enable_overlay' [-Wframe-larger-than]
   int saa7146_enable_overlay(struct saa7146_fh *fh)
       ^
   1 warning generated.


vim +/saa7146_enable_overlay +648 drivers/media/common/saa7146/saa7146_hlp.c

^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  647  
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16 @648  int saa7146_enable_overlay(struct saa7146_fh *fh)
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  649  {
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  650  	struct saa7146_dev *dev = fh->dev;
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  651  	struct saa7146_vv *vv = dev->vv_data;
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  652  
5da545ad08a3c6 drivers/media/common/saa7146_hlp.c Hans Verkuil   2012-05-01  653  	saa7146_set_window(dev, vv->ov.win.w.width, vv->ov.win.w.height, vv->ov.win.field);
5da545ad08a3c6 drivers/media/common/saa7146_hlp.c Hans Verkuil   2012-05-01  654  	saa7146_set_position(dev, vv->ov.win.w.left, vv->ov.win.w.top, vv->ov.win.w.height, vv->ov.win.field, vv->ov_fmt->pixelformat);
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  655  	saa7146_set_output_format(dev, vv->ov_fmt->trans);
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  656  	saa7146_set_clipping_rect(fh);
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  657  
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  658  	/* enable video dma1 */
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  659  	saa7146_write(dev, MC1, (MASK_06 | MASK_22));
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  660  	return 0;
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  661  }
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  662  

:::::: The code at line 648 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

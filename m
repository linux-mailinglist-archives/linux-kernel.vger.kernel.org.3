Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8D0466190
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 11:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357030AbhLBKk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 05:40:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:59437 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345449AbhLBKkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:40:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="260676034"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="260676034"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 02:37:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="677616544"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 02 Dec 2021 02:37:28 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msjSx-000GC3-Qj; Thu, 02 Dec 2021 10:37:27 +0000
Date:   Thu, 2 Dec 2021 18:36:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: arch/mips/sibyte/common/sb_tbprof.c:515:23: sparse: sparse:
 incorrect type in initializer (different address spaces)
Message-ID: <202112021828.HbLk4k4J-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   58e1100fdc5990b0cc0d4beaf2562a92e621ac7d
commit: ddb002d6d6af12c45dd9d565cadf0f40b36b7c25 MIPS: uaccess: Reduce number of nested macros
date:   8 months ago
config: mips-randconfig-s031-20211202 (https://download.01.org/0day-ci/archive/20211202/202112021828.HbLk4k4J-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ddb002d6d6af12c45dd9d565cadf0f40b36b7c25
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ddb002d6d6af12c45dd9d565cadf0f40b36b7c25
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/sibyte/common/ drivers/clk/ drivers/gpio/ drivers/watchdog/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   arch/mips/sibyte/common/sb_tbprof.c:449:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user *p @@     got char *buf @@
   arch/mips/sibyte/common/sb_tbprof.c:449:14: sparse:     expected void const [noderef] __user *p
   arch/mips/sibyte/common/sb_tbprof.c:449:14: sparse:     got char *buf
   arch/mips/sibyte/common/sb_tbprof.c:464:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got char *dest @@
   arch/mips/sibyte/common/sb_tbprof.c:464:38: sparse:     expected void [noderef] __user *to
   arch/mips/sibyte/common/sb_tbprof.c:464:38: sparse:     got char *dest
>> arch/mips/sibyte/common/sb_tbprof.c:515:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__p @@     got int * @@
   arch/mips/sibyte/common/sb_tbprof.c:515:23: sparse:     expected int [noderef] __user *__p
   arch/mips/sibyte/common/sb_tbprof.c:515:23: sparse:     got int *
   arch/mips/sibyte/common/sb_tbprof.c:531:27: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected long ( *read )( ... ) @@     got long ( * )( ... ) @@
   arch/mips/sibyte/common/sb_tbprof.c:531:27: sparse:     expected long ( *read )( ... )
   arch/mips/sibyte/common/sb_tbprof.c:531:27: sparse:     got long ( * )( ... )

vim +515 arch/mips/sibyte/common/sb_tbprof.c

^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  490  
d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  491  static long sbprof_tb_ioctl(struct file *filp,
d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  492  			    unsigned int command,
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  493  			    unsigned long arg)
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  494  {
d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  495  	int err = 0;
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  496  
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  497  	switch (command) {
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  498  	case SBPROF_ZBSTART:
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  499  		mutex_lock(&sbp.lock);
d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  500  		err = sbprof_zbprof_start(filp);
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  501  		mutex_unlock(&sbp.lock);
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  502  		break;
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  503  
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  504  	case SBPROF_ZBSTOP:
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  505  		mutex_lock(&sbp.lock);
d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  506  		err = sbprof_zbprof_stop();
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  507  		mutex_unlock(&sbp.lock);
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  508  		break;
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  509  
d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  510  	case SBPROF_ZBWAITFULL: {
d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  511  		err = wait_event_interruptible(sbp.tb_read, TB_FULL);
d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  512  		if (err)
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  513  			break;
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  514  
d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29 @515  		err = put_user(TB_FULL, (int *) arg);
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  516  		break;
d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  517  	}
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  518  
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  519  	default:
d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  520  		err = -EINVAL;
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  521  		break;
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  522  	}
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  523  
d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  524  	return err;
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  525  }
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  526  

:::::: The code at line 515 was first introduced by commit
:::::: d619f38fdacb5cec0c841798bbadeaf903868852 [MIPS] Add bcm1480 ZBus trace support, fix wait related bugs

:::::: TO: Mark Mason <mmason@upwardaccess.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

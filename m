Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C808476EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbhLPKT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:19:59 -0500
Received: from mga03.intel.com ([134.134.136.65]:64842 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233185AbhLPKT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639649998; x=1671185998;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iNpaazcAYWpIBIrWKysNYOsUaEGLj0witBLWWpP0qzw=;
  b=ThHgyxeyoDjodVXy0hiUwvhG3vD5oUyZj0/Cwl1hGHPBY5z3qRaMPosy
   oBoKXrGGkrgELVTAxXQzBKWmYUuF2sonRsqB9D77h5si7tFLUqfWB5oT2
   UUoMuYxpcoeeHuAv8wNa8w7Wi/LZ6WWNqfX7zO6n5E/A/d9rHhub2DgOu
   /+SuCpA4W1tToorG6Vh+shkCtR3i3cChK3jCprZFk/yRxaiHaN0ENb4pK
   g6x0Q7X45aRm11ZAWF1Gvn1JnQjHQZtsTaeeiC/GNoPcp7xsFDKHZXhKo
   1hDMV8u4oe5f4eovb+2JwZRIf14i6n/9wH4r691ByVuE9OhyEaYslO7BF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="239406880"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="239406880"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 02:19:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="682886888"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Dec 2021 02:19:56 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxnrf-000315-Qt; Thu, 16 Dec 2021 10:19:55 +0000
Date:   Thu, 16 Dec 2021 18:19:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: arch/mips/sibyte/common/sb_tbprof.c:515:23: sparse: sparse:
 incorrect type in initializer (different address spaces)
Message-ID: <202112161836.SB5KUxha-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2b14864acbaaf03d9c01982e243a84632524c3ac
commit: ddb002d6d6af12c45dd9d565cadf0f40b36b7c25 MIPS: uaccess: Reduce number of nested macros
date:   8 months ago
config: mips-randconfig-s031-20211216 (https://download.01.org/0day-ci/archive/20211216/202112161836.SB5KUxha-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 11.2.0
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/sibyte/common/ kernel/

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

^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  490  
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  491  static long sbprof_tb_ioctl(struct file *filp,
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  492  			    unsigned int command,
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  493  			    unsigned long arg)
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  494  {
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  495  	int err = 0;
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  496  
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  497  	switch (command) {
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  498  	case SBPROF_ZBSTART:
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  499  		mutex_lock(&sbp.lock);
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  500  		err = sbprof_zbprof_start(filp);
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  501  		mutex_unlock(&sbp.lock);
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  502  		break;
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  503  
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  504  	case SBPROF_ZBSTOP:
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  505  		mutex_lock(&sbp.lock);
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  506  		err = sbprof_zbprof_stop();
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  507  		mutex_unlock(&sbp.lock);
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  508  		break;
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  509  
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  510  	case SBPROF_ZBWAITFULL: {
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  511  		err = wait_event_interruptible(sbp.tb_read, TB_FULL);
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  512  		if (err)
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  513  			break;
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  514  
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29 @515  		err = put_user(TB_FULL, (int *) arg);
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  516  		break;
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  517  	}
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  518  
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  519  	default:
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  520  		err = -EINVAL;
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  521  		break;
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  522  	}
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  523  
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  524  	return err;
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  525  }
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  526  

:::::: The code at line 515 was first introduced by commit
:::::: d619f38fdacb5cec0c841798bbadeaf903868852 [MIPS] Add bcm1480 ZBus trace support, fix wait related bugs

:::::: TO: Mark Mason <mmason@upwardaccess.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

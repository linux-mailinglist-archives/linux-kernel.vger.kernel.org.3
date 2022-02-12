Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D95F4B3823
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 22:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbiBLVB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 16:01:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiBLVBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 16:01:25 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F53213CDE
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 13:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644699680; x=1676235680;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ysFUFUMKVcCGR9XQnGkviRLBn/BiAIjQl9VTVvNnbRU=;
  b=lVN6jUEMSkduEIurl1wHPpkQfBkeXbS7bsBFjXdHMIJ+YgczsSJtyY/r
   gmMRbG/G1lYB4dUQl48a1H5DhwOcJmrhlx0x4OCKHUz9oVv5Kc3N3XIhR
   XoXlIgyFXhsVOFb7NXjWBPqHHXszx4lm8n4jfQEwDgwbVn12j/a/JytXi
   Y9FVxgu1ki4qA1Wy6NYm5CjVGXTmvUki+BMTErT9Bb/uzCdd7/1J+oNGN
   jfih3VcRzMkrsj5varP10waU+Y7YqIFgQdvz9FUnsAdaa4WCw7H6NX0Yx
   2t9tpnTC1pEdTve03VQSDoE3nY3HmkLdlmq7EsKOImVAhL/Bw30GwObpt
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="247497436"
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="247497436"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 13:01:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="501122593"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 12 Feb 2022 13:01:18 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIzW9-0006e8-V8; Sat, 12 Feb 2022 21:01:17 +0000
Date:   Sun, 13 Feb 2022 05:00:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: arch/mips/sibyte/common/sb_tbprof.c:515:23: sparse: sparse:
 incorrect type in initializer (different address spaces)
Message-ID: <202202130432.4tPqXRgn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   83e396641110663d3c7bb25b9bc0c6a750359ecf
commit: ddb002d6d6af12c45dd9d565cadf0f40b36b7c25 MIPS: uaccess: Reduce number of nested macros
date:   10 months ago
config: mips-randconfig-s032-20220213 (https://download.01.org/0day-ci/archive/20220213/202202130432.4tPqXRgn-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/sibyte/common/

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E2F4B76A8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243664AbiBOTZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:25:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243672AbiBOTZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:25:16 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8A889CF1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644953105; x=1676489105;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bzxN+JXfARX0iLuZPQmKWFNdlx1ZM24GNHMulr1Dihc=;
  b=cuVNXvK210JaudCrAAxN//QtgFY0DVfmklOuz/acU8Ke8LSzFi+WhAZg
   734GPx54Dfd8dqEeuRebRkVu2yJXOctrD3ttQowYBmxZ/bTCmevFuOOvX
   9uDtDMpbpyOSlsoguH7E7XZRG5K7ZieR7AafeFArvTFFCqKNeRPwJfNT2
   zYG1Bjf8FP9Mo+uuYMFGfBGYLEZCh0d+YCd9roJ3IGUgyZrniQPAwHjRA
   Ks83OwB7gy1vXufazAnoIGWjI8aO5KSReebRJ8ISVwi/f8rA0+uflHv96
   s/swuAUD1pwAo2AbElEtL4gvHoPrV5YzHTapyya2rifQ2e3BGTSwV5nVB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="231063976"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="231063976"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 11:25:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="570971078"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 Feb 2022 11:25:03 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nK3Rf-0009y5-68; Tue, 15 Feb 2022 19:25:03 +0000
Date:   Wed, 16 Feb 2022 03:24:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [arnd-playground:set_fs 8/14]
 arch/mips/sibyte/common/sb_tbprof.c:449:14: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202202160307.mgIyyenx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git set_fs
head:   de161bb7b9111bef5b76a5736cc611eb9c908586
commit: 350a8879499d07c361d5a2cd1a22c1c44cbdeb20 [8/14] uaccess: generalize access_ok()
config: mips-randconfig-s031-20220214 (https://download.01.org/0day-ci/archive/20220216/202202160307.mgIyyenx-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?id=350a8879499d07c361d5a2cd1a22c1c44cbdeb20
        git remote add arnd-playground https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
        git fetch --no-tags arnd-playground set_fs
        git checkout 350a8879499d07c361d5a2cd1a22c1c44cbdeb20
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
>> arch/mips/sibyte/common/sb_tbprof.c:449:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got char *buf @@
   arch/mips/sibyte/common/sb_tbprof.c:449:14: sparse:     expected void const [noderef] __user *ptr
   arch/mips/sibyte/common/sb_tbprof.c:449:14: sparse:     got char *buf
   arch/mips/sibyte/common/sb_tbprof.c:464:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got char *dest @@
   arch/mips/sibyte/common/sb_tbprof.c:464:38: sparse:     expected void [noderef] __user *to
   arch/mips/sibyte/common/sb_tbprof.c:464:38: sparse:     got char *dest
   arch/mips/sibyte/common/sb_tbprof.c:515:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__p @@     got int * @@
   arch/mips/sibyte/common/sb_tbprof.c:515:23: sparse:     expected int [noderef] __user *__p
   arch/mips/sibyte/common/sb_tbprof.c:515:23: sparse:     got int *
   arch/mips/sibyte/common/sb_tbprof.c:531:27: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected long ( *read )( ... ) @@     got long ( * )( ... ) @@
   arch/mips/sibyte/common/sb_tbprof.c:531:27: sparse:     expected long ( *read )( ... )
   arch/mips/sibyte/common/sb_tbprof.c:531:27: sparse:     got long ( * )( ... )

vim +449 arch/mips/sibyte/common/sb_tbprof.c

^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  439  
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  440  static ssize_t sbprof_tb_read(struct file *filp, char *buf,
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  441  			      size_t size, loff_t *offp)
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  442  {
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  443  	int cur_sample, sample_off, cur_count, sample_left;
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  444  	char *src;
d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  445  	int   count   =	 0;
d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  446  	char *dest    =	 buf;
d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  447  	long  cur_off = *offp;
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  448  
96d4f267e40f950 arch/mips/sibyte/common/sb_tbprof.c      Linus Torvalds 2019-01-03 @449  	if (!access_ok(buf, size))
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  450  		return -EFAULT;
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  451  
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  452  	mutex_lock(&sbp.lock);
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  453  
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  454  	count = 0;
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  455  	cur_sample = cur_off / TB_SAMPLE_SIZE;
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  456  	sample_off = cur_off % TB_SAMPLE_SIZE;
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  457  	sample_left = TB_SAMPLE_SIZE - sample_off;
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  458  
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  459  	while (size && (cur_sample < sbp.next_tb_sample)) {
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  460  		int err;
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  461  
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  462  		cur_count = size < sample_left ? size : sample_left;
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  463  		src = (char *)(((long)sbp.sbprof_tbbuf[cur_sample])+sample_off);
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  464  		err = __copy_to_user(dest, src, cur_count);
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  465  		if (err) {
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  466  			*offp = cur_off + cur_count - err;
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  467  			mutex_unlock(&sbp.lock);
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  468  			return err;
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  469  		}
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  470  		pr_debug(DEVNAME ": read from sample %d, %d bytes\n",
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  471  			 cur_sample, cur_count);
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  472  		size -= cur_count;
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  473  		sample_left -= cur_count;
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  474  		if (!sample_left) {
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  475  			cur_sample++;
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  476  			sample_off = 0;
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  477  			sample_left = TB_SAMPLE_SIZE;
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  478  		} else {
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  479  			sample_off += cur_count;
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  480  		}
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  481  		cur_off += cur_count;
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  482  		dest += cur_count;
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  483  		count += cur_count;
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  484  	}
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  485  	*offp = cur_off;
bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  486  	mutex_unlock(&sbp.lock);
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  487  
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  488  	return count;
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  489  }
^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  490  

:::::: The code at line 449 was first introduced by commit
:::::: 96d4f267e40f9509e8a66e2b39e8b95655617693 Remove 'type' argument from access_ok() function

:::::: TO: Linus Torvalds <torvalds@linux-foundation.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

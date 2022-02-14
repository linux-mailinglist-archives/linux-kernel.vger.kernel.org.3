Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34454B4334
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241551AbiBNIEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:04:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiBNIEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:04:40 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EFD5B3D5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:04:32 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7914D68AA6; Mon, 14 Feb 2022 09:04:29 +0100 (CET)
Date:   Mon, 14 Feb 2022 09:04:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: arch/mips/sibyte/common/sb_tbprof.c:515:23: sparse: sparse:
 incorrect type in initializer (different address spaces)
Message-ID: <20220214080429.GA18136@lst.de>
References: <202202130432.4tPqXRgn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202130432.4tPqXRgn-lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas, can you find someone who cares about the sibyte support to
fix up the address space annotations in this code?

On Sun, Feb 13, 2022 at 05:00:29AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   83e396641110663d3c7bb25b9bc0c6a750359ecf
> commit: ddb002d6d6af12c45dd9d565cadf0f40b36b7c25 MIPS: uaccess: Reduce number of nested macros
> date:   10 months ago
> config: mips-randconfig-s032-20220213 (https://download.01.org/0day-ci/archive/20220213/202202130432.4tPqXRgn-lkp@intel.com/config)
> compiler: mips64el-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ddb002d6d6af12c45dd9d565cadf0f40b36b7c25
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout ddb002d6d6af12c45dd9d565cadf0f40b36b7c25
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/sibyte/common/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
>    command-line: note: in included file:
>    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
>    builtin:0:0: sparse: this was the original definition
>    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
>    builtin:0:0: sparse: this was the original definition
>    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
>    builtin:0:0: sparse: this was the original definition
>    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
>    builtin:0:0: sparse: this was the original definition
>    arch/mips/sibyte/common/sb_tbprof.c:449:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user *p @@     got char *buf @@
>    arch/mips/sibyte/common/sb_tbprof.c:449:14: sparse:     expected void const [noderef] __user *p
>    arch/mips/sibyte/common/sb_tbprof.c:449:14: sparse:     got char *buf
>    arch/mips/sibyte/common/sb_tbprof.c:464:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got char *dest @@
>    arch/mips/sibyte/common/sb_tbprof.c:464:38: sparse:     expected void [noderef] __user *to
>    arch/mips/sibyte/common/sb_tbprof.c:464:38: sparse:     got char *dest
> >> arch/mips/sibyte/common/sb_tbprof.c:515:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__p @@     got int * @@
>    arch/mips/sibyte/common/sb_tbprof.c:515:23: sparse:     expected int [noderef] __user *__p
>    arch/mips/sibyte/common/sb_tbprof.c:515:23: sparse:     got int *
>    arch/mips/sibyte/common/sb_tbprof.c:531:27: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected long ( *read )( ... ) @@     got long ( * )( ... ) @@
>    arch/mips/sibyte/common/sb_tbprof.c:531:27: sparse:     expected long ( *read )( ... )
>    arch/mips/sibyte/common/sb_tbprof.c:531:27: sparse:     got long ( * )( ... )
> 
> vim +515 arch/mips/sibyte/common/sb_tbprof.c
> 
> ^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  490  
> d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  491  static long sbprof_tb_ioctl(struct file *filp,
> d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  492  			    unsigned int command,
> ^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  493  			    unsigned long arg)
> ^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  494  {
> d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  495  	int err = 0;
> ^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  496  
> ^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  497  	switch (command) {
> ^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  498  	case SBPROF_ZBSTART:
> bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  499  		mutex_lock(&sbp.lock);
> d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  500  		err = sbprof_zbprof_start(filp);
> bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  501  		mutex_unlock(&sbp.lock);
> ^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  502  		break;
> bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  503  
> ^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  504  	case SBPROF_ZBSTOP:
> bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  505  		mutex_lock(&sbp.lock);
> d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  506  		err = sbprof_zbprof_stop();
> bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  507  		mutex_unlock(&sbp.lock);
> ^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  508  		break;
> bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  509  
> d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  510  	case SBPROF_ZBWAITFULL: {
> d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  511  		err = wait_event_interruptible(sbp.tb_read, TB_FULL);
> d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  512  		if (err)
> bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  513  			break;
> bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  514  
> d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29 @515  		err = put_user(TB_FULL, (int *) arg);
> bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  516  		break;
> d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  517  	}
> bb9b813bb665cdb arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  518  
> ^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  519  	default:
> d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  520  		err = -EINVAL;
> ^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  521  		break;
> ^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  522  	}
> ^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  523  
> d619f38fdacb5ce arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  524  	return err;
> ^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  525  }
> ^1da177e4c3f415 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  526  
> 
> :::::: The code at line 515 was first introduced by commit
> :::::: d619f38fdacb5cec0c841798bbadeaf903868852 [MIPS] Add bcm1480 ZBus trace support, fix wait related bugs
> 
> :::::: TO: Mark Mason <mmason@upwardaccess.com>
> :::::: CC: Ralf Baechle <ralf@linux-mips.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
---end quoted text---

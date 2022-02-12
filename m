Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B414B37D3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 21:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiBLUUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 15:20:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiBLUUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 15:20:23 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA6D606E0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 12:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644697219; x=1676233219;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2ohVjYfzpM0a3BPHBYGfp3zgj+JQrF6BNxgsQ3kyo9w=;
  b=ZzitBXrc2RjVt1jAbp8g3z2bh3qu3tvnmU99Ejz5mM5+VOXCS45OzC/O
   CXFZohAwjgAyx+gkZl/bUQPZJ8eTDjjprsq5pm9K21ENFzxoUPlS8fT4v
   vMcgrInFCCYGQyFAB6hmlLGGRO64Nd1cegokLW4iasaDJYEJaScBPCXj2
   iMM8x+kZmaLai8I186ReO1aG+FLF5S0wsGODfCKdowdvmxQ9Y9Ry5tSww
   s12yV6xzUaJfq4kqL16zTor1R1TC6cUxrBsZ8u6RuDAa0EUIdylVcWzwi
   PhFvhV9i/3NRZU+l7uaMlTsCpROK+/pt0in+c89psjwA9iqipbjUm+Te6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="249650094"
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="249650094"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 12:20:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="527346235"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 12 Feb 2022 12:20:17 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIysT-0006c8-2w; Sat, 12 Feb 2022 20:20:17 +0000
Date:   Sun, 13 Feb 2022 04:19:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arnd-playground:set_fs 6/11]
 arch/riscv/kernel/perf_callchain.c:22:14: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202202130419.oJqXwirc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git set_fs
head:   0a081326831928b0d739bce68b8c0f9138b9c8ba
commit: a954036380ae20dbfa0c203bf6cafb21d1f3cedd [6/11] uaccess: generalize access_ok()
config: riscv-randconfig-s032-20220213 (https://download.01.org/0day-ci/archive/20220213/202202130419.oJqXwirc-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?id=a954036380ae20dbfa0c203bf6cafb21d1f3cedd
        git remote add arnd-playground https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
        git fetch --no-tags arnd-playground set_fs
        git checkout a954036380ae20dbfa0c203bf6cafb21d1f3cedd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/riscv/kernel/perf_callchain.c:22:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned long *user_frame_tail @@
   arch/riscv/kernel/perf_callchain.c:22:14: sparse:     expected void const [noderef] __user *ptr
   arch/riscv/kernel/perf_callchain.c:22:14: sparse:     got unsigned long *user_frame_tail
   arch/riscv/kernel/perf_callchain.c:24:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned long *user_frame_tail @@
   arch/riscv/kernel/perf_callchain.c:24:49: sparse:     expected void const [noderef] __user *from
   arch/riscv/kernel/perf_callchain.c:24:49: sparse:     got unsigned long *user_frame_tail

vim +22 arch/riscv/kernel/perf_callchain.c

dbeb90b0c1eb86 Mao Han 2019-08-29   8  
dbeb90b0c1eb86 Mao Han 2019-08-29   9  /*
dbeb90b0c1eb86 Mao Han 2019-08-29  10   * Get the return address for a single stackframe and return a pointer to the
dbeb90b0c1eb86 Mao Han 2019-08-29  11   * next frame tail.
dbeb90b0c1eb86 Mao Han 2019-08-29  12   */
dbeb90b0c1eb86 Mao Han 2019-08-29  13  static unsigned long user_backtrace(struct perf_callchain_entry_ctx *entry,
dbeb90b0c1eb86 Mao Han 2019-08-29  14  				    unsigned long fp, unsigned long reg_ra)
dbeb90b0c1eb86 Mao Han 2019-08-29  15  {
dbeb90b0c1eb86 Mao Han 2019-08-29  16  	struct stackframe buftail;
dbeb90b0c1eb86 Mao Han 2019-08-29  17  	unsigned long ra = 0;
dbeb90b0c1eb86 Mao Han 2019-08-29  18  	unsigned long *user_frame_tail =
dbeb90b0c1eb86 Mao Han 2019-08-29  19  			(unsigned long *)(fp - sizeof(struct stackframe));
dbeb90b0c1eb86 Mao Han 2019-08-29  20  
dbeb90b0c1eb86 Mao Han 2019-08-29  21  	/* Check accessibility of one struct frame_tail beyond */
dbeb90b0c1eb86 Mao Han 2019-08-29 @22  	if (!access_ok(user_frame_tail, sizeof(buftail)))
dbeb90b0c1eb86 Mao Han 2019-08-29  23  		return 0;
dbeb90b0c1eb86 Mao Han 2019-08-29  24  	if (__copy_from_user_inatomic(&buftail, user_frame_tail,
dbeb90b0c1eb86 Mao Han 2019-08-29  25  				      sizeof(buftail)))
dbeb90b0c1eb86 Mao Han 2019-08-29  26  		return 0;
dbeb90b0c1eb86 Mao Han 2019-08-29  27  
dbeb90b0c1eb86 Mao Han 2019-08-29  28  	if (reg_ra != 0)
dbeb90b0c1eb86 Mao Han 2019-08-29  29  		ra = reg_ra;
dbeb90b0c1eb86 Mao Han 2019-08-29  30  	else
dbeb90b0c1eb86 Mao Han 2019-08-29  31  		ra = buftail.ra;
dbeb90b0c1eb86 Mao Han 2019-08-29  32  
dbeb90b0c1eb86 Mao Han 2019-08-29  33  	fp = buftail.fp;
dbeb90b0c1eb86 Mao Han 2019-08-29  34  	if (ra != 0)
dbeb90b0c1eb86 Mao Han 2019-08-29  35  		perf_callchain_store(entry, ra);
dbeb90b0c1eb86 Mao Han 2019-08-29  36  	else
dbeb90b0c1eb86 Mao Han 2019-08-29  37  		return 0;
dbeb90b0c1eb86 Mao Han 2019-08-29  38  
dbeb90b0c1eb86 Mao Han 2019-08-29  39  	return fp;
dbeb90b0c1eb86 Mao Han 2019-08-29  40  }
dbeb90b0c1eb86 Mao Han 2019-08-29  41  

:::::: The code at line 22 was first introduced by commit
:::::: dbeb90b0c1eb86a9b963b929d3c937afb7dadfa3 riscv: Add perf callchain support

:::::: TO: Mao Han <han_mao@c-sky.com>
:::::: CC: Paul Walmsley <paul.walmsley@sifive.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

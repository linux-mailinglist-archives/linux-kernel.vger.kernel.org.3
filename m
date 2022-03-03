Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457164CC33E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbiCCQwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbiCCQwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:52:03 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBF219D774
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646326276; x=1677862276;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ig7CAzwnxiQ8JnTDPcOjhgPbL0HDnifuY/ihUCjFXnk=;
  b=Worhz9HwHdikAXCruUpK4eeW5ki5Kps8l6y7jspNawc39tzLsZlL7rnp
   boicWCaKM5kIYYmB+BCvCR+e8yKpgB84PTyITUQdLOyQ9nGQCh+IfPPmP
   0hL/m5QCUVg7rG44s2+ZiIt41bk3MCjoEduDwowXvgXiaAu4swtdy1mmZ
   29THs1A3vGvdJ6Kd/Iye34Og9NDvX1YWKw4xflzhVcC7Ae2vELTaYeKKq
   B3WqrKNaXhNsPRFSLKF8mfPP3pK75aVqrGqONnNRx/qiFGk+2RBjDpraI
   rwERa0M9UXDecX5UjT7rJ5ujoD2mFlYHh94n12M7vTfVZCtlUc5+qd1P4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="234338702"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="234338702"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 08:50:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="511502661"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Mar 2022 08:50:00 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPoeN-0000jy-Hy; Thu, 03 Mar 2022 16:49:59 +0000
Date:   Fri, 4 Mar 2022 00:49:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lauri Kasanen <cand@gmx.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/boot/compressed/decompress.c:110:57: sparse: sparse: Using
 plain integer as NULL pointer
Message-ID: <202203040006.YLgfJuuJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5859a2b1991101d6b978f3feb5325dad39421f29
commit: baec970aa5ba11099ad7a91773350c91fb2113f0 mips: Add N64 machine type
date:   1 year, 1 month ago
config: mips-randconfig-s032-20220303 (https://download.01.org/0day-ci/archive/20220304/202203040006.YLgfJuuJ-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=baec970aa5ba11099ad7a91773350c91fb2113f0
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout baec970aa5ba11099ad7a91773350c91fb2113f0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash

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
>> arch/mips/boot/compressed/decompress.c:110:57: sparse: sparse: Using plain integer as NULL pointer
   arch/mips/boot/compressed/decompress.c:110:60: sparse: sparse: Using plain integer as NULL pointer
   arch/mips/boot/compressed/decompress.c:111:57: sparse: sparse: Using plain integer as NULL pointer

vim +110 arch/mips/boot/compressed/decompress.c

3b628cac65fa57f Ben Chan    2014-06-24   85  
1b93b3c3e94be26 Wu Zhangjin 2009-10-14   86  void decompress_kernel(unsigned long boot_heap_start)
1b93b3c3e94be26 Wu Zhangjin 2009-10-14   87  {
1e1a77d6984a001 Wu Zhangjin 2010-06-16   88  	unsigned long zimage_start, zimage_size;
1b93b3c3e94be26 Wu Zhangjin 2009-10-14   89  
1e1a77d6984a001 Wu Zhangjin 2010-06-16   90  	zimage_start = (unsigned long)(&__image_begin);
1b93b3c3e94be26 Wu Zhangjin 2009-10-14   91  	zimage_size = (unsigned long)(&__image_end) -
1b93b3c3e94be26 Wu Zhangjin 2009-10-14   92  	    (unsigned long)(&__image_begin);
1b93b3c3e94be26 Wu Zhangjin 2009-10-14   93  
1b93b3c3e94be26 Wu Zhangjin 2009-10-14   94  	puts("zimage at:     ");
1e1a77d6984a001 Wu Zhangjin 2010-06-16   95  	puthex(zimage_start);
1b93b3c3e94be26 Wu Zhangjin 2009-10-14   96  	puts(" ");
1e1a77d6984a001 Wu Zhangjin 2010-06-16   97  	puthex(zimage_size + zimage_start);
1b93b3c3e94be26 Wu Zhangjin 2009-10-14   98  	puts("\n");
1b93b3c3e94be26 Wu Zhangjin 2009-10-14   99  
1e1a77d6984a001 Wu Zhangjin 2010-06-16  100  	/* This area are prepared for mallocing when decompressing */
1b93b3c3e94be26 Wu Zhangjin 2009-10-14  101  	free_mem_ptr = boot_heap_start;
1b93b3c3e94be26 Wu Zhangjin 2009-10-14  102  	free_mem_end_ptr = boot_heap_start + BOOT_HEAP_SIZE;
1b93b3c3e94be26 Wu Zhangjin 2009-10-14  103  
1e1a77d6984a001 Wu Zhangjin 2010-06-16  104  	/* Display standard Linux/MIPS boot prompt */
1b93b3c3e94be26 Wu Zhangjin 2009-10-14  105  	puts("Uncompressing Linux at load address ");
1b93b3c3e94be26 Wu Zhangjin 2009-10-14  106  	puthex(VMLINUX_LOAD_ADDRESS_ULL);
1b93b3c3e94be26 Wu Zhangjin 2009-10-14  107  	puts("\n");
1e1a77d6984a001 Wu Zhangjin 2010-06-16  108  
1b93b3c3e94be26 Wu Zhangjin 2009-10-14  109  	/* Decompress the kernel with according algorithm */
2d3862d26e67a59 Yinghai Lu  2015-09-09 @110  	__decompress((char *)zimage_start, zimage_size, 0, 0,

:::::: The code at line 110 was first introduced by commit
:::::: 2d3862d26e67a59340ba1cf1748196c76c5787de lib/decompressors: use real out buf size for gunzip with kernel

:::::: TO: Yinghai Lu <yinghai@kernel.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

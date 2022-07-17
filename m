Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F23577740
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 18:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiGQQN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 12:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGQQN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 12:13:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3B5B1FB
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 09:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658074436; x=1689610436;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nKTpSnVuNhRW6iSsg3roH5SH3rig3wvD00KSYp+esZo=;
  b=XdX81L4UY24yRBBgKqdRic5pLH8yA/Gk2bzMz7j8go5tG1Nr1Qd0Nr6t
   ggIIq+LlmCEvZLabf8dEC5/ouJuGJAWaje55ZDUX9aY1kemoJ2IEI47gg
   /W598vFfLP7GZetC9MgxuZ3gstEhwCzPZU6+4gWd4lFdIkBMkGDAfHtSD
   dSOXXsmtx5VLkIYl1uHC6hSlSvpac9SsSk00sXOLGs/UQ2BDJk/bm1jCq
   PWybvXI3Ez8kanGes9V9ajRMaueP/Or2N0Rq79dCUhYTzNw2TXucEim5I
   nJ6vqeUOGkQZ86fRk0g1vbafDE2xEuioPn6G+LlT9Mbihhj5vp0SNpMSr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="372383745"
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="372383745"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 09:13:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="664745473"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jul 2022 09:13:55 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oD6u2-0003SF-Go;
        Sun, 17 Jul 2022 16:13:54 +0000
Date:   Mon, 18 Jul 2022 00:13:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     YunQiang Su <yunqiang.su@cipunited.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/boot/compressed/decompress.c:114:57: sparse: sparse: Using
 plain integer as NULL pointer
Message-ID: <202207180026.akNaiHTy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2eccaca7b62b2836260c6fb22156a44e3d99a74a
commit: 31b2f3dc851c65fee288612432c4fc956f1a264e MIPS: enable both vmlinux.gz.itb and vmlinuz for generic
date:   7 months ago
config: mips-randconfig-s042-20220717 (https://download.01.org/0day-ci/archive/20220718/202207180026.akNaiHTy-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=31b2f3dc851c65fee288612432c4fc956f1a264e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 31b2f3dc851c65fee288612432c4fc956f1a264e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/mips/boot/compressed/decompress.c:114:57: sparse: sparse: Using plain integer as NULL pointer
   arch/mips/boot/compressed/decompress.c:114:60: sparse: sparse: Using plain integer as NULL pointer
   arch/mips/boot/compressed/decompress.c:115:57: sparse: sparse: Using plain integer as NULL pointer

vim +114 arch/mips/boot/compressed/decompress.c

3b628cac65fa57 Ben Chan    2014-06-24   89  
1b93b3c3e94be2 Wu Zhangjin 2009-10-14   90  void decompress_kernel(unsigned long boot_heap_start)
1b93b3c3e94be2 Wu Zhangjin 2009-10-14   91  {
1e1a77d6984a00 Wu Zhangjin 2010-06-16   92  	unsigned long zimage_start, zimage_size;
1b93b3c3e94be2 Wu Zhangjin 2009-10-14   93  
1e1a77d6984a00 Wu Zhangjin 2010-06-16   94  	zimage_start = (unsigned long)(&__image_begin);
1b93b3c3e94be2 Wu Zhangjin 2009-10-14   95  	zimage_size = (unsigned long)(&__image_end) -
1b93b3c3e94be2 Wu Zhangjin 2009-10-14   96  	    (unsigned long)(&__image_begin);
1b93b3c3e94be2 Wu Zhangjin 2009-10-14   97  
1b93b3c3e94be2 Wu Zhangjin 2009-10-14   98  	puts("zimage at:     ");
1e1a77d6984a00 Wu Zhangjin 2010-06-16   99  	puthex(zimage_start);
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  100  	puts(" ");
1e1a77d6984a00 Wu Zhangjin 2010-06-16  101  	puthex(zimage_size + zimage_start);
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  102  	puts("\n");
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  103  
1e1a77d6984a00 Wu Zhangjin 2010-06-16  104  	/* This area are prepared for mallocing when decompressing */
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  105  	free_mem_ptr = boot_heap_start;
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  106  	free_mem_end_ptr = boot_heap_start + BOOT_HEAP_SIZE;
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  107  
1e1a77d6984a00 Wu Zhangjin 2010-06-16  108  	/* Display standard Linux/MIPS boot prompt */
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  109  	puts("Uncompressing Linux at load address ");
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  110  	puthex(VMLINUX_LOAD_ADDRESS_ULL);
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  111  	puts("\n");
1e1a77d6984a00 Wu Zhangjin 2010-06-16  112  
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  113  	/* Decompress the kernel with according algorithm */
2d3862d26e67a5 Yinghai Lu  2015-09-09 @114  	__decompress((char *)zimage_start, zimage_size, 0, 0,

:::::: The code at line 114 was first introduced by commit
:::::: 2d3862d26e67a59340ba1cf1748196c76c5787de lib/decompressors: use real out buf size for gunzip with kernel

:::::: TO: Yinghai Lu <yinghai@kernel.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

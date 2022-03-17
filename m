Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3329C4DC827
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbiCQOBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbiCQOBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:01:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002CD1E31AF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647525613; x=1679061613;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Yag4Wbg3AkBF1RlL0Qe1W+A1ItO02/NfQCOf/E+Z5SQ=;
  b=AWreVPVWSw9aO32Mg/NXn+w4il2dDr48hmLbfqM7BTEh5wQm6OPMnvtR
   6XNQ1LdO1s2ZGAu5Z6yCcampROFklI2smWIA1jMx4DwLFvI+4COJAx+Mg
   QiVkvFppBe/aFcXwAgtHo6nC3w318zqeXjCrexchD4WRdXYknHoY5G7fT
   0rHMOEEryD3o3IcTucviNXdeE0vf08lenqIC5gI8RpZtRQMlFCIkVszNo
   /fMOwGOISTxNXgkA2fcBAdIqwzy3TjlCjE6Z+TZkPyqJ17djTA5qK8QE8
   XKFCwLBMy0JCgaEXirCx2uCN3Lmp+bpQ+WsV61bRFqLBOa4Zo/tRVoJRG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="343306709"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="343306709"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 07:00:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="614003435"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2022 07:00:12 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUqfj-000Djq-J8; Thu, 17 Mar 2022 14:00:11 +0000
Date:   Thu, 17 Mar 2022 21:59:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1458/2308]
 arch/mips/boot/compressed/decompress.c:127:16: error: implicit declaration
 of function 'ALIGN'
Message-ID: <202203172105.tknyOIoD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   ef90a8d1de7ff54bfd0fcfe6371c20f544b14d6d
commit: 9b6346a2912e347c5bc76e9a5f0cdd804b65b381 [1458/2308] headers/deps: Optimize <linux/kernel.h>
config: mips-qi_lb60_defconfig (https://download.01.org/0day-ci/archive/20220317/202203172105.tknyOIoD-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=9b6346a2912e347c5bc76e9a5f0cdd804b65b381
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 9b6346a2912e347c5bc76e9a5f0cdd804b65b381
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/mips/boot/compressed/decompress.c:42:6: warning: no previous prototype for function 'error' [-Wmissing-prototypes]
   void error(char *x)
        ^
   arch/mips/boot/compressed/decompress.c:42:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void error(char *x)
   ^
   static 
   arch/mips/boot/compressed/decompress.c:85:6: warning: no previous prototype for function '__stack_chk_fail' [-Wmissing-prototypes]
   void __stack_chk_fail(void)
        ^
   arch/mips/boot/compressed/decompress.c:85:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __stack_chk_fail(void)
   ^
   static 
>> arch/mips/boot/compressed/decompress.c:127:16: error: implicit declaration of function 'ALIGN' [-Werror,-Wimplicit-function-declaration]
                   image_size = ALIGN(image_size, STRUCT_ALIGNMENT);
                                ^
   arch/mips/boot/compressed/decompress.c:90:6: warning: no previous prototype for function 'decompress_kernel' [-Wmissing-prototypes]
   void decompress_kernel(unsigned long boot_heap_start)
        ^
   arch/mips/boot/compressed/decompress.c:90:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void decompress_kernel(unsigned long boot_heap_start)
   ^
   static 
   3 warnings and 1 error generated.


vim +/ALIGN +127 arch/mips/boot/compressed/decompress.c

3b628cac65fa57 Ben Chan      2014-06-24   84  
3b628cac65fa57 Ben Chan      2014-06-24  @85  void __stack_chk_fail(void)
3b628cac65fa57 Ben Chan      2014-06-24   86  {
3b628cac65fa57 Ben Chan      2014-06-24   87  	error("stack-protector: Kernel stack is corrupted\n");
3b628cac65fa57 Ben Chan      2014-06-24   88  }
3b628cac65fa57 Ben Chan      2014-06-24   89  
1b93b3c3e94be2 Wu Zhangjin   2009-10-14   90  void decompress_kernel(unsigned long boot_heap_start)
1b93b3c3e94be2 Wu Zhangjin   2009-10-14   91  {
1e1a77d6984a00 Wu Zhangjin   2010-06-16   92  	unsigned long zimage_start, zimage_size;
1b93b3c3e94be2 Wu Zhangjin   2009-10-14   93  
1e1a77d6984a00 Wu Zhangjin   2010-06-16   94  	zimage_start = (unsigned long)(&__image_begin);
1b93b3c3e94be2 Wu Zhangjin   2009-10-14   95  	zimage_size = (unsigned long)(&__image_end) -
1b93b3c3e94be2 Wu Zhangjin   2009-10-14   96  	    (unsigned long)(&__image_begin);
1b93b3c3e94be2 Wu Zhangjin   2009-10-14   97  
1b93b3c3e94be2 Wu Zhangjin   2009-10-14   98  	puts("zimage at:     ");
1e1a77d6984a00 Wu Zhangjin   2010-06-16   99  	puthex(zimage_start);
1b93b3c3e94be2 Wu Zhangjin   2009-10-14  100  	puts(" ");
1e1a77d6984a00 Wu Zhangjin   2010-06-16  101  	puthex(zimage_size + zimage_start);
1b93b3c3e94be2 Wu Zhangjin   2009-10-14  102  	puts("\n");
1b93b3c3e94be2 Wu Zhangjin   2009-10-14  103  
1e1a77d6984a00 Wu Zhangjin   2010-06-16  104  	/* This area are prepared for mallocing when decompressing */
1b93b3c3e94be2 Wu Zhangjin   2009-10-14  105  	free_mem_ptr = boot_heap_start;
1b93b3c3e94be2 Wu Zhangjin   2009-10-14  106  	free_mem_end_ptr = boot_heap_start + BOOT_HEAP_SIZE;
1b93b3c3e94be2 Wu Zhangjin   2009-10-14  107  
1e1a77d6984a00 Wu Zhangjin   2010-06-16  108  	/* Display standard Linux/MIPS boot prompt */
1b93b3c3e94be2 Wu Zhangjin   2009-10-14  109  	puts("Uncompressing Linux at load address ");
1b93b3c3e94be2 Wu Zhangjin   2009-10-14  110  	puthex(VMLINUX_LOAD_ADDRESS_ULL);
1b93b3c3e94be2 Wu Zhangjin   2009-10-14  111  	puts("\n");
1e1a77d6984a00 Wu Zhangjin   2010-06-16  112  
1b93b3c3e94be2 Wu Zhangjin   2009-10-14  113  	/* Decompress the kernel with according algorithm */
2d3862d26e67a5 Yinghai Lu    2015-09-09  114  	__decompress((char *)zimage_start, zimage_size, 0, 0,
2d3862d26e67a5 Yinghai Lu    2015-09-09  115  		   (void *)VMLINUX_LOAD_ADDRESS_ULL, 0, 0, error);
1e1a77d6984a00 Wu Zhangjin   2010-06-16  116  
b8f54f2cde7886 Jonas Gorski  2016-06-20  117  	if (IS_ENABLED(CONFIG_MIPS_RAW_APPENDED_DTB) &&
b8f54f2cde7886 Jonas Gorski  2016-06-20  118  	    fdt_magic((void *)&__appended_dtb) == FDT_MAGIC) {
b8f54f2cde7886 Jonas Gorski  2016-06-20  119  		unsigned int image_size, dtb_size;
b8f54f2cde7886 Jonas Gorski  2016-06-20  120  
b8f54f2cde7886 Jonas Gorski  2016-06-20  121  		dtb_size = fdt_totalsize((void *)&__appended_dtb);
b8f54f2cde7886 Jonas Gorski  2016-06-20  122  
b8f54f2cde7886 Jonas Gorski  2016-06-20  123  		/* last four bytes is always image size in little endian */
4d4f9c1a17a348 Paul Cercueil 2020-12-16  124  		image_size = get_unaligned_le32((void *)&__image_end - 4);
b8f54f2cde7886 Jonas Gorski  2016-06-20  125  
7a05293af39fc7 Paul Cercueil 2021-03-03  126  		/* The device tree's address must be properly aligned  */
7a05293af39fc7 Paul Cercueil 2021-03-03 @127  		image_size = ALIGN(image_size, STRUCT_ALIGNMENT);

:::::: The code at line 127 was first introduced by commit
:::::: 7a05293af39fc716d0f51c0164cbb727302396a2 MIPS: boot/compressed: Copy DTB to aligned address

:::::: TO: Paul Cercueil <paul@crapouillou.net>
:::::: CC: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

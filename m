Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C46E5916B1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 23:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiHLVYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 17:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiHLVYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 17:24:00 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C95B275C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 14:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660339439; x=1691875439;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E5wH/HDtGvZxjOWsBANoq8k/TU0gaAbz6fHXCwRwwN0=;
  b=IMOn0/I1jpCHYtbXJFIjw/szdvS7o7kGbm/rQmmbDGsQQZ7QHFTpxuwX
   mMNLX3dZlCxvgSPcmsL+PCgHIttOIRgwhXi+0LA9yQ/psXHFwcAN8YO/c
   /90bdhHvfXdWFt3zNtLY2M/tp4A9v+4B7Thi57Ckva80EUQEZzvCDtqy2
   d6QemRMqzoClg6NTrUTIYPSf/Q29qCTAYk+tHqXTxC5/5Kbi6sDAM1AoI
   9/tKekeUrT4YfmtroANLtGC5MIvD1Vsq2zhU0epMfQciERBNbvcC5hVWX
   QjbXu96qytm7MaqqbMjohqyfp293aiLa4eLkDJmmz/i4M5UGBbZ/FDeJA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292486296"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="292486296"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 14:23:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="606049905"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 12 Aug 2022 14:23:57 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMc8K-0000xT-1g;
        Fri, 12 Aug 2022 21:23:56 +0000
Date:   Sat, 13 Aug 2022 05:23:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Justin M. Forbes" <jforbes@fedoraproject.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <zx2c4@kernel.org>
Subject: [stable:linux-5.15.y 6874/9027] arch/arm/include/asm/xor.h:60:3:
 error: write to reserved register 'R7'
Message-ID: <202208130550.28NTRtkj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
head:   7217df81279835a7aee62a07aabb7b8fb8c766f2
commit: e16cc79b0f916069de223bdb567fa0bc2ccd18a5 [6874/9027] lib/crypto: add prompts back to crypto libraries
config: arm-randconfig-r021-20220812 (https://download.01.org/0day-ci/archive/20220813/202208130550.28NTRtkj-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=e16cc79b0f916069de223bdb567fa0bc2ccd18a5
        git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
        git fetch --no-tags stable linux-5.15.y
        git checkout e16cc79b0f916069de223bdb567fa0bc2ccd18a5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from crypto/xor.c:17:
>> arch/arm/include/asm/xor.h:60:3: error: write to reserved register 'R7'
                   GET_BLOCK_4(p1);
                   ^
   arch/arm/include/asm/xor.h:20:10: note: expanded from macro 'GET_BLOCK_4'
           __asm__("ldmia  %0, {%1, %2, %3, %4}" \
                   ^
   arch/arm/include/asm/xor.h:62:3: error: write to reserved register 'R7'
                   PUT_BLOCK_4(p1);
                   ^
   arch/arm/include/asm/xor.h:42:23: note: expanded from macro 'PUT_BLOCK_4'
           __asm__ __volatile__("stmia     %0!, {%2, %3, %4, %5}" \
                                ^
   arch/arm/include/asm/xor.h:81:3: error: write to reserved register 'R7'
                   GET_BLOCK_4(p1);
                   ^
   arch/arm/include/asm/xor.h:20:10: note: expanded from macro 'GET_BLOCK_4'
           __asm__("ldmia  %0, {%1, %2, %3, %4}" \
                   ^
   arch/arm/include/asm/xor.h:84:3: error: write to reserved register 'R7'
                   PUT_BLOCK_4(p1);
                   ^
   arch/arm/include/asm/xor.h:42:23: note: expanded from macro 'PUT_BLOCK_4'
           __asm__ __volatile__("stmia     %0!, {%2, %3, %4, %5}" \
                                ^
   4 errors generated.


vim +/R7 +60 arch/arm/include/asm/xor.h

^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  13  
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  14  #define GET_BLOCK_2(dst) \
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  15  	__asm__("ldmia	%0, {%1, %2}" \
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  16  		: "=r" (dst), "=r" (a1), "=r" (a2) \
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  17  		: "0" (dst))
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  18  
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  19  #define GET_BLOCK_4(dst) \
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  20  	__asm__("ldmia	%0, {%1, %2, %3, %4}" \
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  21  		: "=r" (dst), "=r" (a1), "=r" (a2), "=r" (a3), "=r" (a4) \
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  22  		: "0" (dst))
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  23  
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  24  #define XOR_BLOCK_2(src) \
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  25  	__asm__("ldmia	%0!, {%1, %2}" \
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  26  		: "=r" (src), "=r" (b1), "=r" (b2) \
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  27  		: "0" (src)); \
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  28  	__XOR(a1, b1); __XOR(a2, b2);
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  29  
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  30  #define XOR_BLOCK_4(src) \
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  31  	__asm__("ldmia	%0!, {%1, %2, %3, %4}" \
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  32  		: "=r" (src), "=r" (b1), "=r" (b2), "=r" (b3), "=r" (b4) \
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  33  		: "0" (src)); \
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  34  	__XOR(a1, b1); __XOR(a2, b2); __XOR(a3, b3); __XOR(a4, b4)
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  35  
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  36  #define PUT_BLOCK_2(dst) \
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  37  	__asm__ __volatile__("stmia	%0!, {%2, %3}" \
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  38  		: "=r" (dst) \
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  39  		: "0" (dst), "r" (a1), "r" (a2))
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  40  
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  41  #define PUT_BLOCK_4(dst) \
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  42  	__asm__ __volatile__("stmia	%0!, {%2, %3, %4, %5}" \
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  43  		: "=r" (dst) \
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  44  		: "0" (dst), "r" (a1), "r" (a2), "r" (a3), "r" (a4))
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  45  
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  46  static void
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  47  xor_arm4regs_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  48  {
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  49  	unsigned int lines = bytes / sizeof(unsigned long) / 4;
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  50  	register unsigned int a1 __asm__("r4");
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  51  	register unsigned int a2 __asm__("r5");
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  52  	register unsigned int a3 __asm__("r6");
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  53  	register unsigned int a4 __asm__("r7");
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  54  	register unsigned int b1 __asm__("r8");
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  55  	register unsigned int b2 __asm__("r9");
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  56  	register unsigned int b3 __asm__("ip");
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  57  	register unsigned int b4 __asm__("lr");
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  58  
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  59  	do {
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16 @60  		GET_BLOCK_4(p1);
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  61  		XOR_BLOCK_4(p2);
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  62  		PUT_BLOCK_4(p1);
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  63  	} while (--lines);
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  64  }
^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  65  

:::::: The code at line 60 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

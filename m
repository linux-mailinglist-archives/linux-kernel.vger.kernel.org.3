Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6964C4DAB8E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240875AbiCPHK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbiCPHKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:10:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1889C24F0A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647414551; x=1678950551;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LouiWGDFHGRlNiTQXVxortXoLK+VtqxbnrnyktLsAUI=;
  b=WaVleVwC8BBNag/tL4x2uhiNOZgrmypiqILusizG1V1NgUv5hLR18Vyl
   nMrNXgGOIoBT5CsG+gtZzKHGeySTt8nmA5sC51s+tp+MQybcsCJgsTXWF
   p16PCP/NPgbPHQTXhU86FMd4npzlB7EG58c3lrQa0NnKpopU73BeOn8yN
   /rk3Q08GmjIZTvBoWQYh2KX/51DcmLxprHBIDhGlWTuGSX0PlSi2QTsL8
   9aRLF6EO7uQUqmvtq7ac0Oy1+wH6lxoPeLYd/D/XzsVkRNqkD1wyG1fNI
   JG6j7keqySqFoXiFF1G429eFOl3GdpOWjurzw8xuFaYp9dUMllTiN0C99
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="236455808"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="236455808"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 00:09:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="714484284"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Mar 2022 00:09:08 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUNmN-000C6Q-I8; Wed, 16 Mar 2022 07:09:07 +0000
Date:   Wed, 16 Mar 2022 15:08:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.10
 8455/9999] arch/arm/mach-ep93xx/crunch-bits.S:94:2: error: invalid
 instruction
Message-ID: <202203161410.zozX61pm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.10
head:   19507e098be2c5f9b07ed086c94697c694473906
commit: ffff118fe157b534c3244f8b300e655231dbd95c [8455/9999] BACKPORT: scripts/Makefile.clang: default to LLVM_IAS=1
config: arm-ep93xx_defconfig (https://download.01.org/0day-ci/archive/20220316/202203161410.zozX61pm-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/ammarfaizi2/linux-block/commit/ffff118fe157b534c3244f8b300e655231dbd95c
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.10
        git checkout ffff118fe157b534c3244f8b300e655231dbd95c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm/mach-ep93xx/crunch-bits.S:94:2: error: invalid instruction
    cfstr64 mvdx0, [r1, #0] @ save 64b registers
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:95:2: error: invalid instruction
    cfstr64 mvdx1, [r1, #8]
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:96:2: error: invalid instruction
    cfstr64 mvdx2, [r1, #16]
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:97:2: error: invalid instruction
    cfstr64 mvdx3, [r1, #24]
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:98:2: error: invalid instruction
    cfstr64 mvdx4, [r1, #32]
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:99:2: error: invalid instruction
    cfstr64 mvdx5, [r1, #40]
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:100:2: error: invalid instruction
    cfstr64 mvdx6, [r1, #48]
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:101:2: error: invalid instruction
    cfstr64 mvdx7, [r1, #56]
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:102:2: error: invalid instruction
    cfstr64 mvdx8, [r1, #64]
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:103:2: error: invalid instruction
    cfstr64 mvdx9, [r1, #72]
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:104:2: error: invalid instruction
    cfstr64 mvdx10, [r1, #80]
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:105:2: error: invalid instruction
    cfstr64 mvdx11, [r1, #88]
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:106:2: error: invalid instruction
    cfstr64 mvdx12, [r1, #96]
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:107:2: error: invalid instruction
    cfstr64 mvdx13, [r1, #104]
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:108:2: error: invalid instruction
    cfstr64 mvdx14, [r1, #112]
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:109:2: error: invalid instruction
    cfstr64 mvdx15, [r1, #120]
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:115:2: error: invalid instruction
    cfmv32al mvfx0, mvax0 @ save 72b accumulators
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:116:2: error: invalid instruction
    cfstr32 mvfx0, [r1, #128]
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:117:2: error: invalid instruction
    cfmv32am mvfx0, mvax0
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:118:2: error: invalid instruction
    cfstr32 mvfx0, [r1, #132]
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:119:2: error: invalid instruction
    cfmv32ah mvfx0, mvax0
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:120:2: error: invalid instruction
    cfstr32 mvfx0, [r1, #136]
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:121:2: error: invalid instruction
    cfmv32al mvfx0, mvax1
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:122:2: error: invalid instruction
    cfstr32 mvfx0, [r1, #140]
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:123:2: error: invalid instruction
    cfmv32am mvfx0, mvax1
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:124:2: error: invalid instruction
    cfstr32 mvfx0, [r1, #144]
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:125:2: error: invalid instruction
    cfmv32ah mvfx0, mvax1
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:126:2: error: invalid instruction
    cfstr32 mvfx0, [r1, #148]
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:127:2: error: invalid instruction
    cfmv32al mvfx0, mvax2
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:128:2: error: invalid instruction
    cfstr32 mvfx0, [r1, #152]
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:129:2: error: invalid instruction
    cfmv32am mvfx0, mvax2
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:130:2: error: invalid instruction
    cfstr32 mvfx0, [r1, #156]
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:131:2: error: invalid instruction
    cfmv32ah mvfx0, mvax2
    ^
   arch/arm/mach-ep93xx/crunch-bits.S:132:2: error: invalid instruction
    cfstr32 mvfx0, [r1, #160]


vim +94 arch/arm/mach-ep93xx/crunch-bits.S

c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   53  
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   54  	.text
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   55  
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   56  /*
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   57   * Lazy switching of crunch coprocessor context
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   58   *
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   59   * r10 = struct thread_info pointer
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   60   * r9  = ret_from_exception
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   61   * lr  = undefined instr exit
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   62   *
1417a6b8dc4db7 arch/arm/mach-ep93xx/crunch-bits.S Catalin Marinas   2014-04-22   63   * called from prefetch exception handler with interrupts enabled
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   64   */
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   65  ENTRY(crunch_task_enable)
bc94081c6ac823 arch/arm/mach-ep93xx/crunch-bits.S Catalin Marinas   2014-04-22   66  	inc_preempt_count r10, r3
bc94081c6ac823 arch/arm/mach-ep93xx/crunch-bits.S Catalin Marinas   2014-04-22   67  
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   68  	ldr	r8, =(EP93XX_APB_VIRT_BASE + 0x00130000)	@ syscon addr
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   69  
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   70  	ldr	r1, [r8, #0x80]
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   71  	tst	r1, #0x00800000			@ access to crunch enabled?
bc94081c6ac823 arch/arm/mach-ep93xx/crunch-bits.S Catalin Marinas   2014-04-22   72  	bne	2f				@ if so no business here
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   73  	mov	r3, #0xaa			@ unlock syscon swlock
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   74  	str	r3, [r8, #0xc0]
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   75  	orr	r1, r1, #0x00800000		@ enable access to crunch
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   76  	str	r1, [r8, #0x80]
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   77  
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   78  	ldr	r3, =crunch_owner
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   79  	add	r0, r10, #TI_CRUNCH_STATE	@ get task crunch save area
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   80  	ldr	r2, [sp, #60]			@ current task pc value
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   81  	ldr	r1, [r3]			@ get current crunch owner
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   82  	str	r0, [r3]			@ this task now owns crunch
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   83  	sub	r2, r2, #4			@ adjust pc back
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   84  	str	r2, [sp, #60]
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   85  
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   86  	ldr	r2, [r8, #0x80]
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   87  	mov	r2, r2				@ flush out enable (@@@)
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   88  
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   89  	teq	r1, #0				@ test for last ownership
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   90  	mov	lr, r9				@ normal exit from exception
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   91  	beq	crunch_load			@ no owner, skip save
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   92  
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   93  crunch_save:
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27  @94  	cfstr64		mvdx0, [r1, #CRUNCH_MVDX0]	@ save 64b registers
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   95  	cfstr64		mvdx1, [r1, #CRUNCH_MVDX1]
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   96  	cfstr64		mvdx2, [r1, #CRUNCH_MVDX2]
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   97  	cfstr64		mvdx3, [r1, #CRUNCH_MVDX3]
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   98  	cfstr64		mvdx4, [r1, #CRUNCH_MVDX4]
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27   99  	cfstr64		mvdx5, [r1, #CRUNCH_MVDX5]
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27  100  	cfstr64		mvdx6, [r1, #CRUNCH_MVDX6]
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27  101  	cfstr64		mvdx7, [r1, #CRUNCH_MVDX7]
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27  102  	cfstr64		mvdx8, [r1, #CRUNCH_MVDX8]
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27  103  	cfstr64		mvdx9, [r1, #CRUNCH_MVDX9]
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27  104  	cfstr64		mvdx10, [r1, #CRUNCH_MVDX10]
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27  105  	cfstr64		mvdx11, [r1, #CRUNCH_MVDX11]
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27  106  	cfstr64		mvdx12, [r1, #CRUNCH_MVDX12]
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27  107  	cfstr64		mvdx13, [r1, #CRUNCH_MVDX13]
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27  108  	cfstr64		mvdx14, [r1, #CRUNCH_MVDX14]
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27  109  	cfstr64		mvdx15, [r1, #CRUNCH_MVDX15]
c17fad11f3105c arch/arm/kernel/crunch-bits.S      Lennert Buytenhek 2006-06-27  110  

:::::: The code at line 94 was first introduced by commit
:::::: c17fad11f3105ca4d5bbb2686725aad208f5ead4 [ARM] 3370/2: ep93xx: add crunch support

:::::: TO: Lennert Buytenhek <buytenh@wantstofly.org>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

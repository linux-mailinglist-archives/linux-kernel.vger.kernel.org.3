Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BF9591F37
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 11:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiHNJLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 05:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiHNJLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 05:11:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174FE30F65
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 02:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660468311; x=1692004311;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ceqCM9Qfl+nRYfHUft7vCq3f91tI3GJGF+Bio+Decpk=;
  b=jZYExb6+NXtzFfYhg5K0er4yHJrrMemhlDMjL5TyxQ8GD3XoWSR6XioA
   +x1T8pQ4ecoGCnMFuZwyu7RfLIgpPXcpcG2uVNfLqurNfMfIrWsfIyei/
   Vm+jrDUKmCOVbUAVoJdm+ej2r2oeGylTBYGuszjpx2ZUK7fGpscVOAbLT
   q+V62HT3Z+2RO1GMlywXUvk5ww/8ksb28IUC90ZqHtS0llMyYe4eWDgel
   s94RapOYDzltn0fXy05ANSafbduaTPRvLUbXtxit4rKocGr42F/yUCitY
   39Ue1uaQf7sAuwU+l0RRhau0k5sXv0y2NG4larcb5rtKHbcEZcqSeczYT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="289379612"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="289379612"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 02:11:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="556972928"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 14 Aug 2022 02:11:48 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oN9et-0002gn-1m;
        Sun, 14 Aug 2022 09:11:47 +0000
Date:   Sun, 14 Aug 2022 17:10:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dao Lu <daolu@rivosinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: arch/riscv/include/asm/jump_label.h:42:3: error: invalid operand for
 inline asm constraint 'i'
Message-ID: <202208141746.ABdEd5xo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea23e7c464bfdec04b52cf61edb62030e9e0d0a
commit: 8eb060e10185cfc97ef0200d197ec246ba0f9f8c arch/riscv: add Zihintpause support
date:   3 days ago
config: riscv-randconfig-r005-20220814 (https://download.01.org/0day-ci/archive/20220814/202208141746.ABdEd5xo-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 3329cec2f79185bafd678f310fafadba2a8c76d2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8eb060e10185cfc97ef0200d197ec246ba0f9f8c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8eb060e10185cfc97ef0200d197ec246ba0f9f8c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:4:
   In file included from lib/vdso/gettimeofday.c:5:
   In file included from include/vdso/datapage.h:17:
   In file included from include/vdso/processor.h:10:
   In file included from arch/riscv/include/asm/vdso/processor.h:7:
   In file included from include/linux/jump_label.h:112:
>> arch/riscv/include/asm/jump_label.h:42:3: error: invalid operand for inline asm constraint 'i'
                   "       .option push                            \n\t"
                   ^
   1 error generated.
   make[2]: *** [scripts/Makefile.build:249: arch/riscv/kernel/vdso/vgettimeofday.o] Error 1
   make[2]: Target 'include/generated/vdso-offsets.h' not remade because of errors.
   make[1]: *** [arch/riscv/Makefile:128: vdso_prepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/i +42 arch/riscv/include/asm/jump_label.h

ebc00dde8a975a Emil Renner Berthing 2020-07-14  37  
ebc00dde8a975a Emil Renner Berthing 2020-07-14  38  static __always_inline bool arch_static_branch_jump(struct static_key *key,
ebc00dde8a975a Emil Renner Berthing 2020-07-14  39  						    bool branch)
ebc00dde8a975a Emil Renner Berthing 2020-07-14  40  {
ebc00dde8a975a Emil Renner Berthing 2020-07-14  41  	asm_volatile_goto(
ebc00dde8a975a Emil Renner Berthing 2020-07-14 @42  		"	.option push				\n\t"
ebc00dde8a975a Emil Renner Berthing 2020-07-14  43  		"	.option norelax				\n\t"
ebc00dde8a975a Emil Renner Berthing 2020-07-14  44  		"	.option norvc				\n\t"
ebc00dde8a975a Emil Renner Berthing 2020-07-14  45  		"1:	jal		zero, %l[label]		\n\t"
ebc00dde8a975a Emil Renner Berthing 2020-07-14  46  		"	.option pop				\n\t"
ebc00dde8a975a Emil Renner Berthing 2020-07-14  47  		"	.pushsection	__jump_table, \"aw\"	\n\t"
ebc00dde8a975a Emil Renner Berthing 2020-07-14  48  		"	.align		" RISCV_LGPTR "		\n\t"
ebc00dde8a975a Emil Renner Berthing 2020-07-14  49  		"	.long		1b - ., %l[label] - .	\n\t"
ebc00dde8a975a Emil Renner Berthing 2020-07-14  50  		"	" RISCV_PTR "	%0 - .			\n\t"
ebc00dde8a975a Emil Renner Berthing 2020-07-14  51  		"	.popsection				\n\t"
ebc00dde8a975a Emil Renner Berthing 2020-07-14  52  		:  :  "i"(&((char *)key)[branch]) :  : label);
ebc00dde8a975a Emil Renner Berthing 2020-07-14  53  
ebc00dde8a975a Emil Renner Berthing 2020-07-14  54  	return false;
ebc00dde8a975a Emil Renner Berthing 2020-07-14  55  label:
ebc00dde8a975a Emil Renner Berthing 2020-07-14  56  	return true;
ebc00dde8a975a Emil Renner Berthing 2020-07-14  57  }
ebc00dde8a975a Emil Renner Berthing 2020-07-14  58  

:::::: The code at line 42 was first introduced by commit
:::::: ebc00dde8a975a543f5e1a7cdac93fef89fefe58 riscv: Add jump-label implementation

:::::: TO: Emil Renner Berthing <kernel@esmil.dk>
:::::: CC: Palmer Dabbelt <palmerdabbelt@google.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170E6504EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 12:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiDRKsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 06:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiDRKsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 06:48:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C855E165A6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650278723; x=1681814723;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=744tLKIExCR72Ev5c6z5jZdyZeGFpl/1RFTBjyh3hTg=;
  b=RuD0mkr4rNl0xDrCI79OcjKsjrAUiNg8x8HEZB3xaYhgoASOJWW26CiC
   TjvHiFsRNmuYFcY325/HS0Daz+qp0ZTrC7fEZ4pr7IYjC3FMyOyGjWccK
   va7ENwcLjiam4Hu39kGDaTubjjYH3LNPbZnttlf94he7fF42dLTXrd+Vs
   mFB4MVt4Nwwbo0StLM2E2XLMSTnOpFkpLBxXjtpkFcsVN0opkPOHtU8cG
   /j2gJ2qH8G2NzUnYSVTviPdF8mkbrOBT9dCbGm141JkLp9zAlmJUtd6Ss
   WKvTpjxYU85n/W8lqabR/xrcViuixe0Ta4x/ZvFtp+ylYZewCJzAYq6Zl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="323938258"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="323938258"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 03:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="726599788"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 18 Apr 2022 03:45:22 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngOsj-0004YZ-Fw;
        Mon, 18 Apr 2022 10:45:21 +0000
Date:   Mon, 18 Apr 2022 18:44:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [norov:bitmap 45/47] include/linux/bitmap.h:615:32: warning:
 incompatible integer to pointer conversion passing 'u64' (aka 'unsigned long
 long') to parameter of type 'const u64 *' (aka 'const unsigned long long
 *'); take the address with &
Message-ID: <202204181828.5E4IAlMk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap
head:   45a9e3feb171ccf077979b7ff6a0c6a732cfc17b
commit: 1a21df17d726b4f3c19a148e10d09ec632603f1c [45/47] lib: add bitmap_{from,to}_arr64
config: powerpc-mvme5100_defconfig (https://download.01.org/0day-ci/archive/20220418/202204181828.5E4IAlMk-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/norov/linux/commit/1a21df17d726b4f3c19a148e10d09ec632603f1c
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap
        git checkout 1a21df17d726b4f3c19a148e10d09ec632603f1c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:14:
   In file included from include/linux/sem.h:5:
   In file included from include/uapi/linux/sem.h:5:
   In file included from include/linux/ipc.h:5:
   In file included from include/linux/spinlock.h:62:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:13:
   In file included from include/linux/cpumask.h:12:
>> include/linux/bitmap.h:615:32: warning: incompatible integer to pointer conversion passing 'u64' (aka 'unsigned long long') to parameter of type 'const u64 *' (aka 'const unsigned long long *'); take the address with & [-Wint-conversion]
           return bitmap_from_arr64(dst, mask, 64);
                                         ^~~~
                                         &
   include/linux/bitmap.h:300:58: note: passing argument to parameter 'buf' here
   void bitmap_from_arr64(unsigned long *bitmap, const u64 *buf, unsigned int nbits);
                                                            ^
   1 warning generated.
   /usr/bin/ld: unrecognised emulation mode: elf32ppclinux
   Supported emulations: elf_x86_64 elf32_x86_64 elf_i386 elf_iamcu elf_l1om elf_k1om i386pep i386pe
   clang-15: error: linker command failed with exit code 1 (use -v to see invocation)
   make[2]: *** [arch/powerpc/kernel/vdso/Makefile:65: arch/powerpc/kernel/vdso/vdso32.so.dbg] Error 1
   make[2]: Target 'include/generated/vdso32-offsets.h' not remade because of errors.
   make[1]: *** [arch/powerpc/Makefile:423: vdso_prepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +615 include/linux/bitmap.h

   602	
   603	/**
   604	 * bitmap_from_u64 - Check and swap words within u64.
   605	 *  @mask: source bitmap
   606	 *  @dst:  destination bitmap
   607	 *
   608	 * In 32-bit Big Endian kernel, when using ``(u32 *)(&val)[*]``
   609	 * to read u64 mask, we will get the wrong word.
   610	 * That is ``(u32 *)(&val)[0]`` gets the upper 32 bits,
   611	 * but we expect the lower 32-bits of u64.
   612	 */
   613	static inline void bitmap_from_u64(unsigned long *dst, u64 mask)
   614	{
 > 615		return bitmap_from_arr64(dst, mask, 64);
   616	}
   617	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

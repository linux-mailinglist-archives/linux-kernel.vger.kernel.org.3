Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8E246233F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhK2V3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:29:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:12255 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhK2V1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:27:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="234806232"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="234806232"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 13:24:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="458591298"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 29 Nov 2021 13:24:20 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mro8J-000CLv-Qp; Mon, 29 Nov 2021 21:24:19 +0000
Date:   Tue, 30 Nov 2021 05:23:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [norov:bitmap_tmp 12/12] include/linux/bitmap.h:419:29: error:
 expected identifier or '('
Message-ID: <202111300515.ZhTwh0ao-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap_tmp
head:   985b0047eb9f4a5916eeb4f85e9e173d220d8fc7
commit: 985b0047eb9f4a5916eeb4f85e9e173d220d8fc7 [12/12] aaa
config: hexagon-randconfig-r045-20211129 (https://download.01.org/0day-ci/archive/20211130/202111300515.ZhTwh0ao-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project df08b2fe8b35cb63dfb3b49738a3494b9b4e6f8e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/985b0047eb9f4a5916eeb4f85e9e173d220d8fc7
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap_tmp
        git checkout 985b0047eb9f4a5916eeb4f85e9e173d220d8fc7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:14:
   In file included from include/linux/sem.h:5:
   In file included from include/uapi/linux/sem.h:5:
   In file included from include/linux/ipc.h:5:
   In file included from include/linux/spinlock.h:62:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:13:
   In file included from include/linux/cpumask.h:12:
>> include/linux/bitmap.h:419:29: error: expected identifier or '('
   static __always_inline bool bitmap_weight_le(const unsigned long *src,
                               ^
   include/linux/bitmap.h:417:41: note: expanded from macro 'bitmap_weight_le'
   #define bitmap_weight_le(src, nbits, n) !bitmap_weight_gt((src), (nbits), (n))
                                           ^
   1 error generated.
   make[2]: *** [scripts/Makefile.build:122: arch/hexagon/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1284: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:226: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +419 include/linux/bitmap.h

985b0047eb9f4a Yury Norov 2021-11-29  418  
899f6b60178855 Yury Norov 2021-11-23 @419  static __always_inline bool bitmap_weight_le(const unsigned long *src,
899f6b60178855 Yury Norov 2021-11-23  420  			unsigned int nbits, unsigned int num)
899f6b60178855 Yury Norov 2021-11-23  421  {
899f6b60178855 Yury Norov 2021-11-23  422  	if (small_const_nbits(nbits))
899f6b60178855 Yury Norov 2021-11-23  423  		return hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits)) < num;
899f6b60178855 Yury Norov 2021-11-23  424  
899f6b60178855 Yury Norov 2021-11-23  425  	return __bitmap_weight_le(src, nbits, num);
899f6b60178855 Yury Norov 2021-11-23  426  }
899f6b60178855 Yury Norov 2021-11-23  427  

:::::: The code at line 419 was first introduced by commit
:::::: 899f6b60178855d893aef0cb83aa1d9320216121 lib/bitmap: add bitmap_weight_{eq,gt,le}

:::::: TO: Yury Norov <yury.norov@gmail.com>
:::::: CC: Yury Norov <yury.norov@gmail.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

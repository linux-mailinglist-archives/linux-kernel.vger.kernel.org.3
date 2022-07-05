Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA44E5676D3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiGEStz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiGESty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:49:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F4C17051
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657046993; x=1688582993;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sc6i1tz+Lv3Uv79rQqFCwzyZJZl9FjQkvggjc4hufoY=;
  b=ClxUR27hpxBLgQCi1LZvUk/JbDfuLn+rbNyCQo1z3xUQKzGg1LeNIgLc
   MVr6k97Cw2V59FtBvv5A1CdZm/Rbk5M7Rl318Nb6jYxpM6vy4oXQW/qUq
   Iihgy7rzNjlxtTWxjHyhZX72gO/rtC0eong7gaZa0IWETSBOPgDm84WBQ
   wIkYV6l3BzV04yK9EviasdVqbW3s57rntvsdppem5tdCrujcmXUq9gsTZ
   9rJxJz7Z0OWKKv9NRnxr6grJBdjpdguHyqYaTrQnu8rG4JwbR6v3gltZD
   J4O1Bw26UVgDpcZPLiPEz1obDkpr1kOyPnth2LGy5kHxdnaRV9keiZmtO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="284560958"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="284560958"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 11:49:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="919836329"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jul 2022 11:49:51 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8ncN-000JUL-0b;
        Tue, 05 Jul 2022 18:49:51 +0000
Date:   Wed, 6 Jul 2022 02:48:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Coly Li <colyli@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [colyli-bcache:nvdimm-meta 16/16]
 arch/alpha/include/asm/string.h:37:32: warning: argument 1 null where
 non-null expected
Message-ID: <202207060229.nZBDhhNX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/colyli/linux-bcache.git nvdimm-meta
head:   5c8259ab2129816fc49fd6d060206ba61b0594d1
commit: 5c8259ab2129816fc49fd6d060206ba61b0594d1 [16/16] bcache: support storing bcache btree nodes into NVDIMM meta device
config: alpha-randconfig-r013-20220703 (https://download.01.org/0day-ci/archive/20220706/202207060229.nZBDhhNX-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/colyli/linux-bcache.git/commit/?id=5c8259ab2129816fc49fd6d060206ba61b0594d1
        git remote add colyli-bcache https://git.kernel.org/pub/scm/linux/kernel/git/colyli/linux-bcache.git
        git fetch --no-tags colyli-bcache nvdimm-meta
        git checkout 5c8259ab2129816fc49fd6d060206ba61b0594d1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/md/bcache/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/md/bcache/nvmpg.h:8,
                    from drivers/md/bcache/alloc.c:66:
   drivers/md/bcache/nvmpg_format.h:132:19: warning: 'bch_nvmpg_recs_magic' defined but not used [-Wunused-const-variable=]
     132 | static const __u8 bch_nvmpg_recs_magic[] = {
         |                   ^~~~~~~~~~~~~~~~~~~~
   drivers/md/bcache/nvmpg_format.h:129:19: warning: 'bch_nvmpg_magic' defined but not used [-Wunused-const-variable=]
     129 | static const __u8 bch_nvmpg_magic[] = {
         |                   ^~~~~~~~~~~~~~~
   In file included from include/linux/string.h:20,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/wait.h:9,
                    from include/linux/mempool.h:8,
                    from include/linux/bio.h:8,
                    from drivers/md/bcache/bcache.h:181,
                    from drivers/md/bcache/alloc.c:64:
   In function '__memset',
       inlined from '__bch_nvmpg_bucket_free' at drivers/md/bcache/alloc.c:488:2,
       inlined from 'bch_bucket_free' at drivers/md/bcache/alloc.c:497:3:
>> arch/alpha/include/asm/string.h:37:32: warning: argument 1 null where non-null expected [-Wnonnull]
      37 |                         return __builtin_memset(s, c, n);
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/md/bcache/alloc.c: In function 'bch_bucket_free':
   arch/alpha/include/asm/string.h:37:32: note: in a call to built-in function '__builtin_memset'


vim +37 arch/alpha/include/asm/string.h

^1da177e4c3f41 include/asm-alpha/string.h      Linus Torvalds    2005-04-16  29  
a47e5bb5764f02 arch/alpha/include/asm/string.h Richard Henderson 2013-07-11  30  /* For gcc 3.x, we cannot have the inline function named "memset" because
a47e5bb5764f02 arch/alpha/include/asm/string.h Richard Henderson 2013-07-11  31     the __builtin_memset will attempt to resolve to the inline as well,
a47e5bb5764f02 arch/alpha/include/asm/string.h Richard Henderson 2013-07-11  32     leading to a "sorry" about unimplemented recursive inlining.  */
a47e5bb5764f02 arch/alpha/include/asm/string.h Richard Henderson 2013-07-11  33  extern inline void *__memset(void *s, int c, size_t n)
a47e5bb5764f02 arch/alpha/include/asm/string.h Richard Henderson 2013-07-11  34  {
a47e5bb5764f02 arch/alpha/include/asm/string.h Richard Henderson 2013-07-11  35  	if (__builtin_constant_p(c)) {
a47e5bb5764f02 arch/alpha/include/asm/string.h Richard Henderson 2013-07-11  36  		if (__builtin_constant_p(n)) {
a47e5bb5764f02 arch/alpha/include/asm/string.h Richard Henderson 2013-07-11 @37  			return __builtin_memset(s, c, n);
a47e5bb5764f02 arch/alpha/include/asm/string.h Richard Henderson 2013-07-11  38  		} else {
a47e5bb5764f02 arch/alpha/include/asm/string.h Richard Henderson 2013-07-11  39  			unsigned long c8 = (c & 0xff) * 0x0101010101010101UL;
a47e5bb5764f02 arch/alpha/include/asm/string.h Richard Henderson 2013-07-11  40  			return __constant_c_memset(s, c8, n);
a47e5bb5764f02 arch/alpha/include/asm/string.h Richard Henderson 2013-07-11  41  		}
a47e5bb5764f02 arch/alpha/include/asm/string.h Richard Henderson 2013-07-11  42  	}
a47e5bb5764f02 arch/alpha/include/asm/string.h Richard Henderson 2013-07-11  43  	return ___memset(s, c, n);
a47e5bb5764f02 arch/alpha/include/asm/string.h Richard Henderson 2013-07-11  44  }
a47e5bb5764f02 arch/alpha/include/asm/string.h Richard Henderson 2013-07-11  45  

:::::: The code at line 37 was first introduced by commit
:::::: a47e5bb5764f029f989a182b0dd2d4cce69f8b14 alpha: Eliminate compiler warning from memset macro

:::::: TO: Richard Henderson <rth@twiddle.net>
:::::: CC: Matt Turner <mattst88@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

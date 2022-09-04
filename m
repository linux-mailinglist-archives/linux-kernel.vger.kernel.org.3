Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CD15AC450
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 14:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbiIDMqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 08:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIDMp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 08:45:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5B432063
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 05:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662295556; x=1693831556;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zyDO9Kg2hUr/SwaRqtrMHX6s+VQDPstk18Xzu72PjI0=;
  b=hsIfaHP6vBidhTiUAQrM03LVZEwLMLvtXFG2fAWOJRvbX0XVaZ/eSA65
   j8klA4lcf7566AfzZwAkyFpUAZK5OMATJVghyndePxb13ytg4hWt2Ox4i
   knwkE0uGgAbS25/ObvqyAHp5ozDOCxEl36PfJZSisSQwloI6UJwMuRtxJ
   sHTctTFiNWahD0OPX/8qNQVaBHjWPkhg89mWFsITO/1+XpYJ4GSQDhIXR
   /OZmNoXxgBjnFvV/tqfVLiIQeLNO4IYfKqxxRxl5w/tB1xRz2GUpGb9Tl
   KXmE6NcUaUmvJ0vy5YlUqsU9Y9mzaKW1756VgZ2yG6DKoQj2yP1r4vTyo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="296241632"
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="296241632"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 05:45:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="941803675"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 04 Sep 2022 05:45:54 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUp0b-00033H-25;
        Sun, 04 Sep 2022 12:45:53 +0000
Date:   Sun, 4 Sep 2022 20:45:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: arch/x86/include/asm/checksum_32.h:149:6: error: inline assembly
 requires more registers than available
Message-ID: <202209042007.sjb2ZKIv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7726d4c3e60bfe206738894267414a5f10510f1a
commit: 69d0db01e210e07fe915e5da91b54a867cda040f ubsan: remove CONFIG_UBSAN_OBJECT_SIZE
date:   8 months ago
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220904/202209042007.sjb2ZKIv-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=69d0db01e210e07fe915e5da91b54a867cda040f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 69d0db01e210e07fe915e5da91b54a867cda040f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from net/netfilter/nf_synproxy_core.c:7:
   In file included from include/linux/skbuff.h:28:
   In file included from include/net/checksum.h:22:
   In file included from arch/x86/include/asm/checksum.h:6:
>> arch/x86/include/asm/checksum_32.h:149:6: error: inline assembly requires more registers than available
           asm("addl 0(%1), %0     ;\n"
               ^
   1 error generated.


vim +149 arch/x86/include/asm/checksum_32.h

^1da177e4c3f41 include/asm-i386/checksum.h        Linus Torvalds  2005-04-16  143  
^1da177e4c3f41 include/asm-i386/checksum.h        Linus Torvalds  2005-04-16  144  #define _HAVE_ARCH_IPV6_CSUM
0883e91ae209f4 include/asm-x86/checksum_32.h      Joe Perches     2008-03-23  145  static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
72685fcd286e94 include/asm-i386/checksum.h        Al Viro         2006-11-14  146  				      const struct in6_addr *daddr,
1e94082963747b arch/x86/include/asm/checksum_32.h Alexander Duyck 2016-03-11  147  				      __u32 len, __u8 proto, __wsum sum)
^1da177e4c3f41 include/asm-i386/checksum.h        Linus Torvalds  2005-04-16  148  {
0883e91ae209f4 include/asm-x86/checksum_32.h      Joe Perches     2008-03-23 @149  	asm("addl 0(%1), %0	;\n"
^1da177e4c3f41 include/asm-i386/checksum.h        Linus Torvalds  2005-04-16  150  	    "adcl 4(%1), %0	;\n"
^1da177e4c3f41 include/asm-i386/checksum.h        Linus Torvalds  2005-04-16  151  	    "adcl 8(%1), %0	;\n"
^1da177e4c3f41 include/asm-i386/checksum.h        Linus Torvalds  2005-04-16  152  	    "adcl 12(%1), %0	;\n"
^1da177e4c3f41 include/asm-i386/checksum.h        Linus Torvalds  2005-04-16  153  	    "adcl 0(%2), %0	;\n"
^1da177e4c3f41 include/asm-i386/checksum.h        Linus Torvalds  2005-04-16  154  	    "adcl 4(%2), %0	;\n"
^1da177e4c3f41 include/asm-i386/checksum.h        Linus Torvalds  2005-04-16  155  	    "adcl 8(%2), %0	;\n"
^1da177e4c3f41 include/asm-i386/checksum.h        Linus Torvalds  2005-04-16  156  	    "adcl 12(%2), %0	;\n"
^1da177e4c3f41 include/asm-i386/checksum.h        Linus Torvalds  2005-04-16  157  	    "adcl %3, %0	;\n"
^1da177e4c3f41 include/asm-i386/checksum.h        Linus Torvalds  2005-04-16  158  	    "adcl %4, %0	;\n"
^1da177e4c3f41 include/asm-i386/checksum.h        Linus Torvalds  2005-04-16  159  	    "adcl $0, %0	;\n"
^1da177e4c3f41 include/asm-i386/checksum.h        Linus Torvalds  2005-04-16  160  	    : "=&r" (sum)
^1da177e4c3f41 include/asm-i386/checksum.h        Linus Torvalds  2005-04-16  161  	    : "r" (saddr), "r" (daddr),
392d814daf460a arch/x86/include/asm/checksum_32.h Samuel Thibault 2009-10-01  162  	      "r" (htonl(len)), "r" (htonl(proto)), "0" (sum)
392d814daf460a arch/x86/include/asm/checksum_32.h Samuel Thibault 2009-10-01  163  	    : "memory");
^1da177e4c3f41 include/asm-i386/checksum.h        Linus Torvalds  2005-04-16  164  
^1da177e4c3f41 include/asm-i386/checksum.h        Linus Torvalds  2005-04-16  165  	return csum_fold(sum);
^1da177e4c3f41 include/asm-i386/checksum.h        Linus Torvalds  2005-04-16  166  }
^1da177e4c3f41 include/asm-i386/checksum.h        Linus Torvalds  2005-04-16  167  

:::::: The code at line 149 was first introduced by commit
:::::: 0883e91ae209f4ada4db9b383026df77351c1320 include/asm-x86/checksum_32.h: checkpatch cleanups - formatting only

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

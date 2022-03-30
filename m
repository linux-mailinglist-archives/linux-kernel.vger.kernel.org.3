Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287F84EB970
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 06:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242497AbiC3EVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 00:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiC3EV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 00:21:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9C16167
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 21:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648613982; x=1680149982;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MdRY4MREK9rEg7cHiwCQFH1xZpqdXv/q/z3x73+BigE=;
  b=V35xkH4OcwlD896erNkDyY5EO16z1WsG++pBPyjSCAl8W+yvKb/uQnU4
   azvC5FdCNpog2vMDEUkniOrmSYNIFc+6uPSO/DG+0uB8xj6o5+l4LVdfA
   6s3blZN5zly9FnUF0h7hfqyeKGZvJbWb+GhOd22FCxXiGRE4LxJpgoa1C
   rBA3jfN1fgcVTuBmrEO3AJW3FZQeEDy0zlkupDxyT+IdVDUxfvYoWcpCu
   JS7TyBLL5b6gdIaU074FBezSBq1213sJbo4VMlb4XN0kCm9GHDzgfnNZ5
   EpQz5O7S4vTWCLd3e6tNB7jTWSbHDZ7mKhCdkGpFJU3DKitKZgbMXgfnk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="284347577"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="284347577"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 21:19:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="521729658"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Mar 2022 21:19:40 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZPo3-0000z1-Ky; Wed, 30 Mar 2022 04:19:39 +0000
Date:   Wed, 30 Mar 2022 12:18:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/kspp-stringop-overflow 7/7]
 include/linux/fortify-string.h:41:33: warning: '__builtin_memcpy' writing 6
 bytes into a region of size 0 overflows the destination
Message-ID: <202203301249.XsFY2ove-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/kspp-stringop-overflow
head:   3801f720ebf09ec3589982fba4138e83b4177fe1
commit: 3801f720ebf09ec3589982fba4138e83b4177fe1 [7/7] Makefile: Enable -Wstringop-overflow globally
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20220330/202203301249.XsFY2ove-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=3801f720ebf09ec3589982fba4138e83b4177fe1
        git remote add gustavoars https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars testing/kspp-stringop-overflow
        git checkout 3801f720ebf09ec3589982fba4138e83b4177fe1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/wireless/atmel/ drivers/staging/r8188eu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:253,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/rcupdate.h:29,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from drivers/staging/r8188eu/core/../include/osdep_service.h:7,
                    from drivers/staging/r8188eu/core/rtw_recv.c:6:
   In function 'memcpy',
       inlined from 'wlanhdr_to_ethhdr' at drivers/staging/r8188eu/core/rtw_recv.c:1233:2:
>> include/linux/fortify-string.h:41:33: warning: '__builtin_memcpy' writing 6 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
      41 | #define __underlying_memcpy     __builtin_memcpy
         |                                 ^
   include/linux/fortify-string.h:225:16: note: in expansion of macro '__underlying_memcpy'
     225 |         return __underlying_memcpy(p, q, size);
         |                ^~~~~~~~~~~~~~~~~~~
>> include/linux/fortify-string.h:41:33: warning: '__builtin_memcpy' writing 6 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
      41 | #define __underlying_memcpy     __builtin_memcpy
         |                                 ^
   include/linux/fortify-string.h:225:16: note: in expansion of macro '__underlying_memcpy'
     225 |         return __underlying_memcpy(p, q, size);
         |                ^~~~~~~~~~~~~~~~~~~
--
   drivers/net/wireless/atmel/atmel.c: In function 'send_association_request':
>> cc1: warning: writing 4 bytes into a region of size between 18446744073709551613 and 2 [-Wstringop-overflow=]
   drivers/net/wireless/atmel/atmel.c:2883:20: note: at offset [4, 6] into destination object 'ap' of size 6
    2883 |                 u8 ap[ETH_ALEN]; /* nothing after here directly accessible */
         |                    ^~
   drivers/net/wireless/atmel/atmel.c:2884:20: note: at offset [4, 6] into destination object 'ssid_el_id' of size 1
    2884 |                 u8 ssid_el_id;
         |                    ^~~~~~~~~~


vim +/__builtin_memcpy +41 include/linux/fortify-string.h

3009f891bb9f32 Kees Cook      2021-08-02  26  
a28a6e860c6cf2 Francis Laniel 2021-02-25  27  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
a28a6e860c6cf2 Francis Laniel 2021-02-25  28  extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
a28a6e860c6cf2 Francis Laniel 2021-02-25  29  extern int __underlying_memcmp(const void *p, const void *q, __kernel_size_t size) __RENAME(memcmp);
a28a6e860c6cf2 Francis Laniel 2021-02-25  30  extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(memcpy);
a28a6e860c6cf2 Francis Laniel 2021-02-25  31  extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(memmove);
a28a6e860c6cf2 Francis Laniel 2021-02-25  32  extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(memset);
a28a6e860c6cf2 Francis Laniel 2021-02-25  33  extern char *__underlying_strcat(char *p, const char *q) __RENAME(strcat);
a28a6e860c6cf2 Francis Laniel 2021-02-25  34  extern char *__underlying_strcpy(char *p, const char *q) __RENAME(strcpy);
a28a6e860c6cf2 Francis Laniel 2021-02-25  35  extern __kernel_size_t __underlying_strlen(const char *p) __RENAME(strlen);
a28a6e860c6cf2 Francis Laniel 2021-02-25  36  extern char *__underlying_strncat(char *p, const char *q, __kernel_size_t count) __RENAME(strncat);
a28a6e860c6cf2 Francis Laniel 2021-02-25  37  extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size) __RENAME(strncpy);
a28a6e860c6cf2 Francis Laniel 2021-02-25  38  #else
a28a6e860c6cf2 Francis Laniel 2021-02-25  39  #define __underlying_memchr	__builtin_memchr
a28a6e860c6cf2 Francis Laniel 2021-02-25  40  #define __underlying_memcmp	__builtin_memcmp
a28a6e860c6cf2 Francis Laniel 2021-02-25 @41  #define __underlying_memcpy	__builtin_memcpy
a28a6e860c6cf2 Francis Laniel 2021-02-25  42  #define __underlying_memmove	__builtin_memmove
a28a6e860c6cf2 Francis Laniel 2021-02-25  43  #define __underlying_memset	__builtin_memset
a28a6e860c6cf2 Francis Laniel 2021-02-25  44  #define __underlying_strcat	__builtin_strcat
a28a6e860c6cf2 Francis Laniel 2021-02-25  45  #define __underlying_strcpy	__builtin_strcpy
a28a6e860c6cf2 Francis Laniel 2021-02-25  46  #define __underlying_strlen	__builtin_strlen
a28a6e860c6cf2 Francis Laniel 2021-02-25  47  #define __underlying_strncat	__builtin_strncat
a28a6e860c6cf2 Francis Laniel 2021-02-25  48  #define __underlying_strncpy	__builtin_strncpy
a28a6e860c6cf2 Francis Laniel 2021-02-25  49  #endif
a28a6e860c6cf2 Francis Laniel 2021-02-25  50  

:::::: The code at line 41 was first introduced by commit
:::::: a28a6e860c6cf231cf3c5171c75c342adcd00406 string.h: move fortified functions definitions in a dedicated header.

:::::: TO: Francis Laniel <laniel_francis@privacyrequired.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

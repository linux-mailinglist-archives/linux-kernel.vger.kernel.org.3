Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8E25882CD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiHBTtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiHBTth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:49:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5134652FE4
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 12:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659469773; x=1691005773;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zmPtAOPVbSDxbUqsp3XrcnHHC7daC7WFB7HOchrngtM=;
  b=EcdwCt4hr/BziIIho4MnOLToYqJVVE0jMBSz4e1pmz1lnN4WTCSbxqun
   l5IGTa8kVNsqnv6DSspbXVFqTr7xg/M5bXryXkIVHsQdf8jLiPlMbgoNg
   CYGyWi1LAAt9eUOxKSSfEOZ7GCLSx+LNAyIMD62BFPM0qQjxfcXi9QX4O
   P//tJtkg2UgG160nvrjfDdOB45rxn6ENvYwdaUZHTbVGVZc3sbrPcHEm1
   TuI1c2OFJ9T9cK8el+AV8qzCpw590Yk74XIMYuOAjV9pyxij7xFydeoRf
   LuFzf76/pwAELv243mOgHFBwGKnBTtVMUlR3C49FwdgSmHX/21pzKD5Va
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="269886261"
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="269886261"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 12:49:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="691976360"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Aug 2022 12:49:31 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIxtS-000GNI-2f;
        Tue, 02 Aug 2022 19:49:30 +0000
Date:   Wed, 3 Aug 2022 03:49:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/getrandom-batch 9/9]
 include/linux/fortify-string.h:47:33: warning: '__builtin_memset' pointer
 overflow between offset [0, 255] and size [2147483648, 4294967295]
Message-ID: <202208030326.kgXt6SdF-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/getrandom-batch
head:   99a314f603c9cd173e6db2e3776eb76477283e1a
commit: 99a314f603c9cd173e6db2e3776eb76477283e1a [9/9] random: batch getrandom() output per-task
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220803/202208030326.kgXt6SdF-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/99a314f603c9cd173e6db2e3776eb76477283e1a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/getrandom-batch
        git checkout 99a314f603c9cd173e6db2e3776eb76477283e1a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/char/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:253,
                    from arch/x86/include/asm/page_32.h:22,
                    from arch/x86/include/asm/page.h:14,
                    from arch/x86/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/utsname.h:6,
                    from drivers/char/random.c:28:
   drivers/char/random.c: In function 'get_random_bytes_user':
>> include/linux/fortify-string.h:47:33: warning: '__builtin_memset' pointer overflow between offset [0, 255] and size [2147483648, 4294967295] [-Warray-bounds]
      47 | #define __underlying_memset     __builtin_memset
         |                                 ^
   include/linux/fortify-string.h:281:9: note: in expansion of macro '__underlying_memset'
     281 |         __underlying_memset(p, c, __fortify_size);                      \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:288:25: note: in expansion of macro '__fortify_memset_chk'
     288 | #define memset(p, c, s) __fortify_memset_chk(p, c, s,                   \
         |                         ^~~~~~~~~~~~~~~~~~~~
   drivers/char/random.c:425:17: note: in expansion of macro 'memset'
     425 |                 memset(current->rng_batch.buf + current->rng_batch.position, 0, batch_len);
         |                 ^~~~~~


vim +/__builtin_memset +47 include/linux/fortify-string.h

3009f891bb9f32 Kees Cook      2021-08-02  30  
a28a6e860c6cf2 Francis Laniel 2021-02-25  31  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
a28a6e860c6cf2 Francis Laniel 2021-02-25  32  extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
a28a6e860c6cf2 Francis Laniel 2021-02-25  33  extern int __underlying_memcmp(const void *p, const void *q, __kernel_size_t size) __RENAME(memcmp);
a28a6e860c6cf2 Francis Laniel 2021-02-25  34  extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(memcpy);
a28a6e860c6cf2 Francis Laniel 2021-02-25  35  extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(memmove);
a28a6e860c6cf2 Francis Laniel 2021-02-25  36  extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(memset);
a28a6e860c6cf2 Francis Laniel 2021-02-25  37  extern char *__underlying_strcat(char *p, const char *q) __RENAME(strcat);
a28a6e860c6cf2 Francis Laniel 2021-02-25  38  extern char *__underlying_strcpy(char *p, const char *q) __RENAME(strcpy);
a28a6e860c6cf2 Francis Laniel 2021-02-25  39  extern __kernel_size_t __underlying_strlen(const char *p) __RENAME(strlen);
a28a6e860c6cf2 Francis Laniel 2021-02-25  40  extern char *__underlying_strncat(char *p, const char *q, __kernel_size_t count) __RENAME(strncat);
a28a6e860c6cf2 Francis Laniel 2021-02-25  41  extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size) __RENAME(strncpy);
a28a6e860c6cf2 Francis Laniel 2021-02-25  42  #else
a28a6e860c6cf2 Francis Laniel 2021-02-25  43  #define __underlying_memchr	__builtin_memchr
a28a6e860c6cf2 Francis Laniel 2021-02-25  44  #define __underlying_memcmp	__builtin_memcmp
a28a6e860c6cf2 Francis Laniel 2021-02-25  45  #define __underlying_memcpy	__builtin_memcpy
a28a6e860c6cf2 Francis Laniel 2021-02-25  46  #define __underlying_memmove	__builtin_memmove
a28a6e860c6cf2 Francis Laniel 2021-02-25 @47  #define __underlying_memset	__builtin_memset
a28a6e860c6cf2 Francis Laniel 2021-02-25  48  #define __underlying_strcat	__builtin_strcat
a28a6e860c6cf2 Francis Laniel 2021-02-25  49  #define __underlying_strcpy	__builtin_strcpy
a28a6e860c6cf2 Francis Laniel 2021-02-25  50  #define __underlying_strlen	__builtin_strlen
a28a6e860c6cf2 Francis Laniel 2021-02-25  51  #define __underlying_strncat	__builtin_strncat
a28a6e860c6cf2 Francis Laniel 2021-02-25  52  #define __underlying_strncpy	__builtin_strncpy
a28a6e860c6cf2 Francis Laniel 2021-02-25  53  #endif
a28a6e860c6cf2 Francis Laniel 2021-02-25  54  

:::::: The code at line 47 was first introduced by commit
:::::: a28a6e860c6cf231cf3c5171c75c342adcd00406 string.h: move fortified functions definitions in a dedicated header.

:::::: TO: Francis Laniel <laniel_francis@privacyrequired.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

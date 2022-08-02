Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0A658820F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiHBSsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiHBSsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:48:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9DA37F9D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 11:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659466111; x=1691002111;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rDxt5yR2huu+Qyi28A0GyNkyNc6STWWfO0yXeq2dFv8=;
  b=Te5F2AKt3KTYuxm7Da+ycrAkNQEUV8eFlmQetjdZtPFN1rDKhfrvz2c5
   noz9eKDGhdxr6xp8OsjP7XS1LWtXv5pzyhNgn2ztBgmdEUz4fPWlhwoyl
   rIdmocR5uPwzx+U4x83tRFsPEsXdWPGhBW3iu5I2UXnhaqB9ZuC3gYu8O
   hH3oSfvFRibE7qBv9kg4eNvJ+Ak1Kkb4GeFe4GIWs5++gmrVz7xFgevVM
   74It3wRbb6wR86JTwL7wrWg+2NF/T+L8KbRUIRItNOaxcmYoUEtPi1Ftr
   zTudzWAKVVJzEeI2DGW/IXWPMpYPFPGEnl4g9hN4I75SaQurX7mzcpqP/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="288250814"
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="288250814"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 11:48:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="553026276"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Aug 2022 11:48:29 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIwwO-000GJD-1f;
        Tue, 02 Aug 2022 18:48:28 +0000
Date:   Wed, 3 Aug 2022 02:48:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/getrandom-batch 9/9]
 arch/x86/include/asm/string_32.h:195:29: warning: '__builtin_memset' pointer
 overflow between offset [0, 255] and size [2147483648, 4294967295]
Message-ID: <202208030247.gT8Fic5N-lkp@intel.com>
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
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220803/202208030247.gT8Fic5N-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/99a314f603c9cd173e6db2e3776eb76477283e1a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/getrandom-batch
        git checkout 99a314f603c9cd173e6db2e3776eb76477283e1a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/string.h:3,
                    from include/linux/string.h:20,
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
   drivers/char/random.c: In function 'get_random_bytes_user.part.0':
>> arch/x86/include/asm/string_32.h:195:29: warning: '__builtin_memset' pointer overflow between offset [0, 255] and size [2147483648, 4294967295] [-Warray-bounds]
     195 | #define memset(s, c, count) __builtin_memset(s, c, count)
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/char/random.c:425:17: note: in expansion of macro 'memset'
     425 |                 memset(current->rng_batch.buf + current->rng_batch.position, 0, batch_len);
         |                 ^~~~~~


vim +/__builtin_memset +195 arch/x86/include/asm/string_32.h

^1da177e4c3f41 include/asm-i386/string.h        Linus Torvalds   2005-04-16  186  
^1da177e4c3f41 include/asm-i386/string.h        Linus Torvalds   2005-04-16  187  #define __memset(s, c, count)				\
78d64fc21d2aa4 include/asm-x86/string_32.h      Joe Perches      2008-05-12  188  	(__builtin_constant_p(count)			\
78d64fc21d2aa4 include/asm-x86/string_32.h      Joe Perches      2008-05-12  189  	 ? __constant_count_memset((s), (c), (count))	\
78d64fc21d2aa4 include/asm-x86/string_32.h      Joe Perches      2008-05-12  190  	 : __memset_generic((s), (c), (count)))
^1da177e4c3f41 include/asm-i386/string.h        Linus Torvalds   2005-04-16  191  
^1da177e4c3f41 include/asm-i386/string.h        Linus Torvalds   2005-04-16  192  #define __HAVE_ARCH_MEMSET
6974f0c4555e28 arch/x86/include/asm/string_32.h Daniel Micay     2017-07-12  193  extern void *memset(void *, int, size_t);
6974f0c4555e28 arch/x86/include/asm/string_32.h Daniel Micay     2017-07-12  194  #ifndef CONFIG_FORTIFY_SOURCE
ff60fab71bb3b4 arch/x86/include/asm/string_32.h Arjan van de Ven 2009-09-28 @195  #define memset(s, c, count) __builtin_memset(s, c, count)
6974f0c4555e28 arch/x86/include/asm/string_32.h Daniel Micay     2017-07-12  196  #endif /* !CONFIG_FORTIFY_SOURCE */
^1da177e4c3f41 include/asm-i386/string.h        Linus Torvalds   2005-04-16  197  

:::::: The code at line 195 was first introduced by commit
:::::: ff60fab71bb3b4fdbf8caf57ff3739ffd0887396 x86: Use __builtin_memset and __builtin_memcpy for memset/memcpy

:::::: TO: Arjan van de Ven <arjan@infradead.org>
:::::: CC: H. Peter Anvin <hpa@zytor.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

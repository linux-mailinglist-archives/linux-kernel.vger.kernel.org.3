Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B89750CFAA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 06:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238174AbiDXEyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 00:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiDXEys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 00:54:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C4E15374B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 21:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650775907; x=1682311907;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=60VhRC8RnmXogkoVRB0aewMX6J9bqnrLnRAUUP0+vuM=;
  b=L/LN8/p5UHUsVMkTuwpBfcXiPIKm89OxklC/URenLKqH/9bjU57f9nsB
   9qkO6UZGX4++H6BBb2SxsFCwWxVhmKbHKcdyBSOKGAqsl+Hi9BGvIXU1o
   eASgsxC+CuzrFxWxAotyz8Dsv8aWHTg9xFRa9q5dIbG6l5ff+z6izfRda
   WakYhhqlr3DpLRBvGFBx5gshzZU+UvfgRE9CIjALwnwsxtoEHQeeFU1lL
   rR4ogHuC9WDHNw0m8NHpjBG8LOq+P0DQAgHlH4qMPo1+j+Txn6VwM5LVN
   VDp1/4BO9B1uIciPCiDYIgLnu3Eqd2yeglBLkz3LIDghpDhClhLrNFiey
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="244923473"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="244923473"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 21:51:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="536028177"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 23 Apr 2022 21:51:45 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niUDo-00012B-MP;
        Sun, 24 Apr 2022 04:51:44 +0000
Date:   Sun, 24 Apr 2022 12:51:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [esmil:visionfive 55/56] mm/kasan/shadow.c:69:16: error: implicit
 declaration of function '__memcpy'; did you mean 'memcpy'?
Message-ID: <202204241255.IvPnAd0Y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   0729a282564fe3940277937536b1e67f98885c49
commit: 5e9aafc7c7b6e7aef5f6285688311fdea914a385 [55/56] riscv: Fix no previous prototype warning
config: riscv-randconfig-m031-20220424 (https://download.01.org/0day-ci/archive/20220424/202204241255.IvPnAd0Y-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/5e9aafc7c7b6e7aef5f6285688311fdea914a385
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 5e9aafc7c7b6e7aef5f6285688311fdea914a385
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash mm/kasan/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   mm/kasan/common.c: In function '__kasan_init_slab_obj':
>> mm/kasan/common.c:319:25: error: implicit declaration of function '__memset'; did you mean 'memset'? [-Werror=implicit-function-declaration]
     319 |                         __memset(alloc_meta, 0, sizeof(*alloc_meta));
         |                         ^~~~~~~~
         |                         memset
   cc1: some warnings being treated as errors
--
   mm/kasan/generic.c: In function '__asan_set_shadow_00':
>> mm/kasan/generic.c:320:17: error: implicit declaration of function '__memset'; did you mean 'memset'? [-Werror=implicit-function-declaration]
     320 |                 __memset((void *)addr, 0x##byte, size);                 \
         |                 ^~~~~~~~
   mm/kasan/generic.c:324:1: note: in expansion of macro 'DEFINE_ASAN_SET_SHADOW'
     324 | DEFINE_ASAN_SET_SHADOW(00);
         | ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   mm/kasan/shadow.c: In function 'memset':
>> mm/kasan/shadow.c:47:16: error: implicit declaration of function '__memset'; did you mean 'memset'? [-Werror=implicit-function-declaration]
      47 |         return __memset(addr, c, len);
         |                ^~~~~~~~
         |                memset
>> mm/kasan/shadow.c:47:16: warning: returning 'int' from a function with return type 'void *' makes pointer from integer without a cast [-Wint-conversion]
      47 |         return __memset(addr, c, len);
         |                ^~~~~~~~~~~~~~~~~~~~~~
   mm/kasan/shadow.c: In function 'memcpy':
>> mm/kasan/shadow.c:69:16: error: implicit declaration of function '__memcpy'; did you mean 'memcpy'? [-Werror=implicit-function-declaration]
      69 |         return __memcpy(dest, src, len);
         |                ^~~~~~~~
         |                memcpy
   mm/kasan/shadow.c:69:16: warning: returning 'int' from a function with return type 'void *' makes pointer from integer without a cast [-Wint-conversion]
      69 |         return __memcpy(dest, src, len);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +69 mm/kasan/shadow.c

bb359dbcb70085 Andrey Konovalov 2020-12-22  40  
bb359dbcb70085 Andrey Konovalov 2020-12-22  41  #undef memset
bb359dbcb70085 Andrey Konovalov 2020-12-22  42  void *memset(void *addr, int c, size_t len)
bb359dbcb70085 Andrey Konovalov 2020-12-22  43  {
f00748bfa0246c Andrey Konovalov 2021-02-24  44  	if (!kasan_check_range((unsigned long)addr, len, true, _RET_IP_))
bb359dbcb70085 Andrey Konovalov 2020-12-22  45  		return NULL;
bb359dbcb70085 Andrey Konovalov 2020-12-22  46  
bb359dbcb70085 Andrey Konovalov 2020-12-22 @47  	return __memset(addr, c, len);
bb359dbcb70085 Andrey Konovalov 2020-12-22  48  }
bb359dbcb70085 Andrey Konovalov 2020-12-22  49  
bb359dbcb70085 Andrey Konovalov 2020-12-22  50  #ifdef __HAVE_ARCH_MEMMOVE
bb359dbcb70085 Andrey Konovalov 2020-12-22  51  #undef memmove
bb359dbcb70085 Andrey Konovalov 2020-12-22  52  void *memmove(void *dest, const void *src, size_t len)
bb359dbcb70085 Andrey Konovalov 2020-12-22  53  {
f00748bfa0246c Andrey Konovalov 2021-02-24  54  	if (!kasan_check_range((unsigned long)src, len, false, _RET_IP_) ||
f00748bfa0246c Andrey Konovalov 2021-02-24  55  	    !kasan_check_range((unsigned long)dest, len, true, _RET_IP_))
bb359dbcb70085 Andrey Konovalov 2020-12-22  56  		return NULL;
bb359dbcb70085 Andrey Konovalov 2020-12-22  57  
bb359dbcb70085 Andrey Konovalov 2020-12-22  58  	return __memmove(dest, src, len);
bb359dbcb70085 Andrey Konovalov 2020-12-22  59  }
bb359dbcb70085 Andrey Konovalov 2020-12-22  60  #endif
bb359dbcb70085 Andrey Konovalov 2020-12-22  61  
bb359dbcb70085 Andrey Konovalov 2020-12-22  62  #undef memcpy
bb359dbcb70085 Andrey Konovalov 2020-12-22  63  void *memcpy(void *dest, const void *src, size_t len)
bb359dbcb70085 Andrey Konovalov 2020-12-22  64  {
f00748bfa0246c Andrey Konovalov 2021-02-24  65  	if (!kasan_check_range((unsigned long)src, len, false, _RET_IP_) ||
f00748bfa0246c Andrey Konovalov 2021-02-24  66  	    !kasan_check_range((unsigned long)dest, len, true, _RET_IP_))
bb359dbcb70085 Andrey Konovalov 2020-12-22  67  		return NULL;
bb359dbcb70085 Andrey Konovalov 2020-12-22  68  
bb359dbcb70085 Andrey Konovalov 2020-12-22 @69  	return __memcpy(dest, src, len);
bb359dbcb70085 Andrey Konovalov 2020-12-22  70  }
bb359dbcb70085 Andrey Konovalov 2020-12-22  71  

:::::: The code at line 69 was first introduced by commit
:::::: bb359dbcb70085a63e8bdbf14837a900750f0cf7 kasan: split out shadow.c from common.c

:::::: TO: Andrey Konovalov <andreyknvl@google.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

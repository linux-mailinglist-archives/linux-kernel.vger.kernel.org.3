Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6D04BD189
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244957AbiBTUlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:41:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244949AbiBTUlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:41:16 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2094504B
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645389654; x=1676925654;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dw+FKqxKKLVA8GxwhFDvPtwMA03m7I0f85QrVyvUwYQ=;
  b=JckaZ6n7B3Do7ouGbzGkajENdCiJj8i8DIzpVk7XkhEpvGdIUURX6XqT
   75o9wdMG9C0b4vCE/9UZEEDDhZtxVLfR+qWEKo6TG3nXdFK8EvaU9P9UU
   sweFUIVNwGQ1pna1IwxIN23Xx7V1nT4PuQjLQlgt0N6cjERK5c8UTzy3E
   SpD8AJzMn+PtGDC44Va9q1MeArpmU53GQ4dwXa0mv3OsqfZpGnStySExX
   9KWu0HZs/bL1v9pGbgv3iw3gcSqfYLqon/6BawYF1FFmchcfV5m6dB0Jt
   9Yufl76HaJm08uMgviSKqbTG9W54HvBSDZZ1+eYdm9ZVlklTaN7vE9dhe
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="337833104"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="337833104"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 12:40:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="504630116"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Feb 2022 12:40:51 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLt0k-0000jR-D1; Sun, 20 Feb 2022 20:40:50 +0000
Date:   Mon, 21 Feb 2022 04:40:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Alistair Delva <adelva@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-gs-raviole-5.10-android12-qpr1-d
 1559/8858] arch/s390/include/asm/kasan.h:20:31: error: unknown type name
 'pgd_t'; did you mean 'pid_t'?
Message-ID: <202202210428.m74LAo9b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-gs-raviole-5.10-android12-qpr1-d
head:   9771767708df4fcf51cd1642e041c804a86e740c
commit: f4fb11566b5eb19aa91f674123a365854ab1470f [1559/8858] UPSTREAM: kasan: shadow declarations only for software modes
config: s390-randconfig-r044-20220220 (https://download.01.org/0day-ci/archive/20220221/202202210428.m74LAo9b-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/f4fb11566b5eb19aa91f674123a365854ab1470f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-gs-raviole-5.10-android12-qpr1-d
        git checkout f4fb11566b5eb19aa91f674123a365854ab1470f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash arch/s390/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/kasan.h:15,
                    from arch/s390/mm/kasan_init.c:2:
>> arch/s390/include/asm/kasan.h:20:31: error: unknown type name 'pgd_t'; did you mean 'pid_t'?
      20 | extern void kasan_copy_shadow(pgd_t *dst);
         |                               ^~~~~
         |                               pid_t
>> arch/s390/mm/kasan_init.c:419:13: warning: no previous prototype for 'kasan_copy_shadow' [-Wmissing-prototypes]
     419 | void __init kasan_copy_shadow(pgd_t *pg_dir)
         |             ^~~~~~~~~~~~~~~~~


vim +20 arch/s390/include/asm/kasan.h

42db5ed86090d8 Vasily Gorbik 2017-11-17  18  
42db5ed86090d8 Vasily Gorbik 2017-11-17  19  extern void kasan_early_init(void);
42db5ed86090d8 Vasily Gorbik 2017-11-17 @20  extern void kasan_copy_shadow(pgd_t *dst);
135ff163939294 Vasily Gorbik 2017-11-20  21  extern void kasan_free_early_identity(void);
c360c9a238d175 Vasily Gorbik 2020-09-11  22  extern unsigned long kasan_vmax;
42db5ed86090d8 Vasily Gorbik 2017-11-17  23  #else
42db5ed86090d8 Vasily Gorbik 2017-11-17  24  static inline void kasan_early_init(void) { }
42db5ed86090d8 Vasily Gorbik 2017-11-17  25  static inline void kasan_copy_shadow(pgd_t *dst) { }
135ff163939294 Vasily Gorbik 2017-11-20  26  static inline void kasan_free_early_identity(void) { }
42db5ed86090d8 Vasily Gorbik 2017-11-17  27  #endif
42db5ed86090d8 Vasily Gorbik 2017-11-17  28  

:::::: The code at line 20 was first introduced by commit
:::::: 42db5ed86090d8e57ca08bfd162a10be6320cc49 s390/kasan: add initialization code and enable it

:::::: TO: Vasily Gorbik <gor@linux.ibm.com>
:::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

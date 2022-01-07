Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EF1487D7C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 21:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiAGUJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 15:09:14 -0500
Received: from mga09.intel.com ([134.134.136.24]:11372 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232029AbiAGUJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 15:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641586153; x=1673122153;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QXccbiN5+Xw7pfSnvnZQMwTiQmFWajGRuofmMiDau1Y=;
  b=WjiqQmm7E8ki+I3G7TWpDeOcqtp8H254SMdIq06dwu5oPfCQwnHaByGU
   5R+Jy0/0effWXDNCNvfzwLiO6c1/SUv6734Hw68qETvsJHC1Cn5IJRHqH
   5zpFANffNxw+JPRX6rqHr7Qb8Spc5ClZE9nbJjxgg5ULqHVoysBQSIJMe
   pZie9/V6279sz9kng6jInTF5Bzj/JT8DXXkKGnfd2OKGRQdgNdHqlpgpm
   aJyW8PBh+MWW5UyZusD0Kc3f78dQkVhrGNorRCNKiZQ+O/58564UMnq6a
   BnmXuOX9kaqQhKl1PR2j5TguKWJJK0lMc8oqF1ihmkpL8XyicnuS4kvFX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="242733726"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="242733726"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 12:09:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="471413072"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Jan 2022 12:09:10 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5vXx-000Izm-Eq; Fri, 07 Jan 2022 20:09:09 +0000
Date:   Sat, 8 Jan 2022 04:08:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alistair Delva <adelva@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.10-m2107
 1559/8698] arch/s390/mm/kasan_init.c:419:13: warning: no previous prototype
 for 'kasan_copy_shadow'
Message-ID: <202201080319.dgPwSoQr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.10-m2107
head:   6b5101a5720784d91a53168bfbc90c940ee6817f
commit: f4fb11566b5eb19aa91f674123a365854ab1470f [1559/8698] UPSTREAM: kasan: shadow declarations only for software modes
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20220108/202201080319.dgPwSoQr-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/f4fb11566b5eb19aa91f674123a365854ab1470f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.10-m2107
        git checkout f4fb11566b5eb19aa91f674123a365854ab1470f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash arch/s390/mm/ lib/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kasan.h:15,
                    from arch/s390/mm/kasan_init.c:2:
   arch/s390/include/asm/kasan.h:20:31: error: unknown type name 'pgd_t'; did you mean 'pid_t'?
      20 | extern void kasan_copy_shadow(pgd_t *dst);
         |                               ^~~~~
         |                               pid_t
>> arch/s390/mm/kasan_init.c:419:13: warning: no previous prototype for 'kasan_copy_shadow' [-Wmissing-prototypes]
     419 | void __init kasan_copy_shadow(pgd_t *pg_dir)
         |             ^~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for WIRELESS_EXT
   Depends on NET && WIRELESS
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG
   WARNING: unmet direct dependencies detected for WEXT_CORE
   Depends on NET && WIRELESS && (CFG80211_WEXT || WIRELESS_EXT
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG
   WARNING: unmet direct dependencies detected for WEXT_PROC
   Depends on NET && WIRELESS && PROC_FS && WEXT_CORE
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG
   WARNING: unmet direct dependencies detected for WEXT_PRIV
   Depends on NET && WIRELESS
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG
   WARNING: unmet direct dependencies detected for WEXT_SPY
   Depends on NET && WIRELESS
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG


vim +/kasan_copy_shadow +419 arch/s390/mm/kasan_init.c

42db5ed86090d8 Vasily Gorbik 2017-11-17  418  
42db5ed86090d8 Vasily Gorbik 2017-11-17 @419  void __init kasan_copy_shadow(pgd_t *pg_dir)
42db5ed86090d8 Vasily Gorbik 2017-11-17  420  {
42db5ed86090d8 Vasily Gorbik 2017-11-17  421  	/*
42db5ed86090d8 Vasily Gorbik 2017-11-17  422  	 * At this point we are still running on early pages setup early_pg_dir,
42db5ed86090d8 Vasily Gorbik 2017-11-17  423  	 * while swapper_pg_dir has just been initialized with identity mapping.
42db5ed86090d8 Vasily Gorbik 2017-11-17  424  	 * Carry over shadow memory region from early_pg_dir to swapper_pg_dir.
42db5ed86090d8 Vasily Gorbik 2017-11-17  425  	 */
42db5ed86090d8 Vasily Gorbik 2017-11-17  426  
42db5ed86090d8 Vasily Gorbik 2017-11-17  427  	pgd_t *pg_dir_src;
42db5ed86090d8 Vasily Gorbik 2017-11-17  428  	pgd_t *pg_dir_dst;
42db5ed86090d8 Vasily Gorbik 2017-11-17  429  	p4d_t *p4_dir_src;
42db5ed86090d8 Vasily Gorbik 2017-11-17  430  	p4d_t *p4_dir_dst;
42db5ed86090d8 Vasily Gorbik 2017-11-17  431  	pud_t *pu_dir_src;
42db5ed86090d8 Vasily Gorbik 2017-11-17  432  	pud_t *pu_dir_dst;
42db5ed86090d8 Vasily Gorbik 2017-11-17  433  
42db5ed86090d8 Vasily Gorbik 2017-11-17  434  	pg_dir_src = pgd_offset_raw(early_pg_dir, KASAN_SHADOW_START);
42db5ed86090d8 Vasily Gorbik 2017-11-17  435  	pg_dir_dst = pgd_offset_raw(pg_dir, KASAN_SHADOW_START);
42db5ed86090d8 Vasily Gorbik 2017-11-17  436  	p4_dir_src = p4d_offset(pg_dir_src, KASAN_SHADOW_START);
42db5ed86090d8 Vasily Gorbik 2017-11-17  437  	p4_dir_dst = p4d_offset(pg_dir_dst, KASAN_SHADOW_START);
42db5ed86090d8 Vasily Gorbik 2017-11-17  438  	if (!p4d_folded(*p4_dir_src)) {
42db5ed86090d8 Vasily Gorbik 2017-11-17  439  		/* 4 level paging */
42db5ed86090d8 Vasily Gorbik 2017-11-17  440  		memcpy(p4_dir_dst, p4_dir_src,
42db5ed86090d8 Vasily Gorbik 2017-11-17  441  		       (KASAN_SHADOW_SIZE >> P4D_SHIFT) * sizeof(p4d_t));
42db5ed86090d8 Vasily Gorbik 2017-11-17  442  		return;
42db5ed86090d8 Vasily Gorbik 2017-11-17  443  	}
42db5ed86090d8 Vasily Gorbik 2017-11-17  444  	/* 3 level paging */
42db5ed86090d8 Vasily Gorbik 2017-11-17  445  	pu_dir_src = pud_offset(p4_dir_src, KASAN_SHADOW_START);
42db5ed86090d8 Vasily Gorbik 2017-11-17  446  	pu_dir_dst = pud_offset(p4_dir_dst, KASAN_SHADOW_START);
42db5ed86090d8 Vasily Gorbik 2017-11-17  447  	memcpy(pu_dir_dst, pu_dir_src,
42db5ed86090d8 Vasily Gorbik 2017-11-17  448  	       (KASAN_SHADOW_SIZE >> PUD_SHIFT) * sizeof(pud_t));
42db5ed86090d8 Vasily Gorbik 2017-11-17  449  }
135ff163939294 Vasily Gorbik 2017-11-20  450  

:::::: The code at line 419 was first introduced by commit
:::::: 42db5ed86090d8e57ca08bfd162a10be6320cc49 s390/kasan: add initialization code and enable it

:::::: TO: Vasily Gorbik <gor@linux.ibm.com>
:::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

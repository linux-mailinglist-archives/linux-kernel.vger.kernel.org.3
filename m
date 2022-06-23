Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E151B5572A9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 07:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiFWFrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 01:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiFWFrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 01:47:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD073B3D2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 22:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655963239; x=1687499239;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=D86zfG7Y+3gPvTsx+RNeeF6KBRxTR9XzKV+SxY6/CvQ=;
  b=lCrPPvc9fikJRUeDCQusvqAod6ww6x+s0SjkAB+EEXfhn5JDPuFtVtWV
   AR+9o4PvQnypNl58H1cjkvclYjYLw0WRcvWiF3nAROGs7khE9lhrlFXsf
   iVr6EzsOFoPa4MVQwakqKmGipOu0n39vNUaYpRUb5+GT+C2UlRu/kjRAf
   51zZLFwDWGjPVmaYFXfI4IUJDKIclMe/RW+ny56xQC8o8S+2aExSYOSoc
   t6WJ31khaFqEdLUz2s6Nxz+w2s7mz9reOCQpuUTPYxpMETrIaYzKRkYOU
   FwZ2bYyeMIJkc7fe8DqB2sEoMY8oRCkcUKTOOeUCfnlSp/9J73lF2hETj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="260449544"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="260449544"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 22:47:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="834476038"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2022 22:47:18 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4FgT-0000lp-Cy;
        Thu, 23 Jun 2022 05:47:17 +0000
Date:   Thu, 23 Jun 2022 13:46:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [akpm-mm:mm-nonmm-unstable 11/39] include/linux/mmzone.h:1434:
 undefined reference to `machine_kexec_prepare'
Message-ID: <202206231338.a6Jz3qZ3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
head:   4b3b67ef8001c6f44317c6920022ffc6bd4b2b4b
commit: f4da7afe07523ff8930c4466b09a15db18508cd4 [11/39] kexec_file: increase maximum file size to 4G
config: riscv-randconfig-c024-20220622 (https://download.01.org/0day-ci/archive/20220623/202206231338.a6Jz3qZ3-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=f4da7afe07523ff8930c4466b09a15db18508cd4
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch --no-tags akpm-mm mm-nonmm-unstable
        git checkout f4da7afe07523ff8930c4466b09a15db18508cd4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: kernel/kexec_core.o: in function `kimage_crash_copy_vmcoreinfo':
   kernel/kexec_core.c:502: undefined reference to `machine_kexec_cleanup'
   riscv64-linux-ld: kernel/kexec_core.o: in function `kimage_free_pages':
   kernel/kexec_core.c:336: undefined reference to `machine_crash_shutdown'
   riscv64-linux-ld: kernel/kexec_core.c:337: undefined reference to `machine_kexec'
   riscv64-linux-ld: kernel/kexec_core.o: in function `kimage_free':
   kernel/kexec_core.c:651: undefined reference to `riscv_crash_save_regs'
   riscv64-linux-ld: kernel/kexec_core.o: in function `__nr_to_section':
   include/linux/mmzone.h:1403: undefined reference to `machine_shutdown'
   riscv64-linux-ld: include/linux/mmzone.h:1403: undefined reference to `machine_kexec'
   riscv64-linux-ld: kernel/kexec_file.o: in function `__section_mem_map_addr':
>> include/linux/mmzone.h:1434: undefined reference to `machine_kexec_prepare'


vim +1434 include/linux/mmzone.h

f1eca35a0dc7cb Dan Williams       2019-07-18  1394  
29751f6991e845 Andy Whitcroft     2005-06-23  1395  static inline struct mem_section *__nr_to_section(unsigned long nr)
29751f6991e845 Andy Whitcroft     2005-06-23  1396  {
a431dbbc540532 Waiman Long        2022-04-08  1397  	unsigned long root = SECTION_NR_TO_ROOT(nr);
a431dbbc540532 Waiman Long        2022-04-08  1398  
a431dbbc540532 Waiman Long        2022-04-08  1399  	if (unlikely(root >= NR_SECTION_ROOTS))
a431dbbc540532 Waiman Long        2022-04-08  1400  		return NULL;
a431dbbc540532 Waiman Long        2022-04-08  1401  
83e3c48729d9eb Kirill A. Shutemov 2017-09-29  1402  #ifdef CONFIG_SPARSEMEM_EXTREME
a431dbbc540532 Waiman Long        2022-04-08 @1403  	if (!mem_section || !mem_section[root])
83e3c48729d9eb Kirill A. Shutemov 2017-09-29  1404  		return NULL;
83e3c48729d9eb Kirill A. Shutemov 2017-09-29  1405  #endif
a431dbbc540532 Waiman Long        2022-04-08  1406  	return &mem_section[root][nr & SECTION_ROOT_MASK];
29751f6991e845 Andy Whitcroft     2005-06-23  1407  }
f1eca35a0dc7cb Dan Williams       2019-07-18  1408  extern size_t mem_section_usage_size(void);
29751f6991e845 Andy Whitcroft     2005-06-23  1409  
29751f6991e845 Andy Whitcroft     2005-06-23  1410  /*
29751f6991e845 Andy Whitcroft     2005-06-23  1411   * We use the lower bits of the mem_map pointer to store
def9b71ee651a6 Petr Tesarik       2018-01-31  1412   * a little bit of information.  The pointer is calculated
def9b71ee651a6 Petr Tesarik       2018-01-31  1413   * as mem_map - section_nr_to_pfn(pnum).  The result is
def9b71ee651a6 Petr Tesarik       2018-01-31  1414   * aligned to the minimum alignment of the two values:
def9b71ee651a6 Petr Tesarik       2018-01-31  1415   *   1. All mem_map arrays are page-aligned.
def9b71ee651a6 Petr Tesarik       2018-01-31  1416   *   2. section_nr_to_pfn() always clears PFN_SECTION_SHIFT
def9b71ee651a6 Petr Tesarik       2018-01-31  1417   *      lowest bits.  PFN_SECTION_SHIFT is arch-specific
def9b71ee651a6 Petr Tesarik       2018-01-31  1418   *      (equal SECTION_SIZE_BITS - PAGE_SHIFT), and the
def9b71ee651a6 Petr Tesarik       2018-01-31  1419   *      worst combination is powerpc with 256k pages,
def9b71ee651a6 Petr Tesarik       2018-01-31  1420   *      which results in PFN_SECTION_SHIFT equal 6.
def9b71ee651a6 Petr Tesarik       2018-01-31  1421   * To sum it up, at least 6 bits are available.
29751f6991e845 Andy Whitcroft     2005-06-23  1422   */
29751f6991e845 Andy Whitcroft     2005-06-23  1423  #define SECTION_MARKED_PRESENT		(1UL<<0)
29751f6991e845 Andy Whitcroft     2005-06-23  1424  #define SECTION_HAS_MEM_MAP		(1UL<<1)
2d070eab2e8270 Michal Hocko       2017-07-06  1425  #define SECTION_IS_ONLINE		(1UL<<2)
326e1b8f83a431 Dan Williams       2019-07-18  1426  #define SECTION_IS_EARLY		(1UL<<3)
1f90a3477df3ff Dan Williams       2021-02-25  1427  #define SECTION_TAINT_ZONE_DEVICE	(1UL<<4)
1f90a3477df3ff Dan Williams       2021-02-25  1428  #define SECTION_MAP_LAST_BIT		(1UL<<5)
29751f6991e845 Andy Whitcroft     2005-06-23  1429  #define SECTION_MAP_MASK		(~(SECTION_MAP_LAST_BIT-1))
01c8d337d195ed Naoya Horiguchi    2021-09-02  1430  #define SECTION_NID_SHIFT		6
29751f6991e845 Andy Whitcroft     2005-06-23  1431  
29751f6991e845 Andy Whitcroft     2005-06-23  1432  static inline struct page *__section_mem_map_addr(struct mem_section *section)
29751f6991e845 Andy Whitcroft     2005-06-23  1433  {
29751f6991e845 Andy Whitcroft     2005-06-23 @1434  	unsigned long map = section->section_mem_map;
29751f6991e845 Andy Whitcroft     2005-06-23  1435  	map &= SECTION_MAP_MASK;
29751f6991e845 Andy Whitcroft     2005-06-23  1436  	return (struct page *)map;
29751f6991e845 Andy Whitcroft     2005-06-23  1437  }
29751f6991e845 Andy Whitcroft     2005-06-23  1438  

:::::: The code at line 1434 was first introduced by commit
:::::: 29751f6991e845f7d002a6ae520bf996b38c8dcd [PATCH] sparsemem hotplug base

:::::: TO: Andy Whitcroft <apw@shadowen.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

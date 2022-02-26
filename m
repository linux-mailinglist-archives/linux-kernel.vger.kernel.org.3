Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BAD4C5352
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 03:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiBZCKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 21:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiBZCJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 21:09:54 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D008240D03
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 18:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645841316; x=1677377316;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BfE+FG3nuDgZ72L1iaXCeROnX8858ppGTsWOilPn6/w=;
  b=WJ3irj4LRYEhOeAQSyiI9C6AkayWin0YBLyUtFo1k/xoN88lqewCOLWm
   f2wio09s+8m3y7e3rLtG9jAJ2D6HF6ApP1bLt+SnthsDL4/MhssxyZEL2
   zNyrX4a8DcjejXf33z5HIPVzDz/CPCOF68IYR5tYCq9X73QQnFu9KkOa4
   bE1+dlFjp6U3oo1gwhjwRfWyFbvuanavdQmVH1Tiif7/I1eHqAS00HFOD
   rUvApVuXFa2Q2oEL3LNnY4RjWpAj7iktM7U3KdqIU8mVk0O4djS7L88n4
   /cV+NglDBSsdLgifCYBsz2MJKPYdju3UjRe05HwyBQy+vnsqiYPhhNLLJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="240024439"
X-IronPort-AV: E=Sophos;i="5.90,138,1643702400"; 
   d="scan'208";a="240024439"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 18:02:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,138,1643702400"; 
   d="scan'208";a="509464227"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Feb 2022 18:02:32 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNmPn-0004wo-Uq; Sat, 26 Feb 2022 02:02:31 +0000
Date:   Sat, 26 Feb 2022 10:02:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [dinguyen:set_fs-2 1/1] mm/mmap.c:105:9: error: '__P000' undeclared
 here (not in a function)
Message-ID: <202202260955.oz8w72wD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git set_fs-2
head:   18dc1399170788b241181d48da03cf70a4139d5f
commit: 18dc1399170788b241181d48da03cf70a4139d5f [1/1] nios2/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
config: nios2-buildonly-randconfig-r001-20220226 (https://download.01.org/0day-ci/archive/20220226/202202260955.oz8w72wD-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/commit/?id=18dc1399170788b241181d48da03cf70a4139d5f
        git remote add dinguyen https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git
        git fetch --no-tags dinguyen set_fs-2
        git checkout 18dc1399170788b241181d48da03cf70a4139d5f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/mmap.c:105:9: error: '__P000' undeclared here (not in a function)
     105 |         __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
         |         ^~~~~~
>> mm/mmap.c:105:17: error: '__P001' undeclared here (not in a function)
     105 |         __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
         |                 ^~~~~~
>> mm/mmap.c:105:25: error: '__P010' undeclared here (not in a function)
     105 |         __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
         |                         ^~~~~~
>> mm/mmap.c:105:33: error: '__P011' undeclared here (not in a function)
     105 |         __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
         |                                 ^~~~~~
>> mm/mmap.c:105:41: error: '__P100' undeclared here (not in a function)
     105 |         __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
         |                                         ^~~~~~
>> mm/mmap.c:105:49: error: '__P101' undeclared here (not in a function)
     105 |         __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
         |                                                 ^~~~~~
>> mm/mmap.c:105:57: error: '__P110' undeclared here (not in a function)
     105 |         __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
         |                                                         ^~~~~~
>> mm/mmap.c:105:65: error: '__P111' undeclared here (not in a function)
     105 |         __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
         |                                                                 ^~~~~~
>> mm/mmap.c:106:9: error: '__S000' undeclared here (not in a function)
     106 |         __S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
         |         ^~~~~~
>> mm/mmap.c:106:17: error: '__S001' undeclared here (not in a function)
     106 |         __S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
         |                 ^~~~~~
>> mm/mmap.c:106:25: error: '__S010' undeclared here (not in a function)
     106 |         __S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
         |                         ^~~~~~
>> mm/mmap.c:106:33: error: '__S011' undeclared here (not in a function)
     106 |         __S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
         |                                 ^~~~~~
>> mm/mmap.c:106:41: error: '__S100' undeclared here (not in a function)
     106 |         __S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
         |                                         ^~~~~~
>> mm/mmap.c:106:49: error: '__S101' undeclared here (not in a function)
     106 |         __S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
         |                                                 ^~~~~~
>> mm/mmap.c:106:57: error: '__S110' undeclared here (not in a function)
     106 |         __S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
         |                                                         ^~~~~~
>> mm/mmap.c:106:65: error: '__S111' undeclared here (not in a function)
     106 |         __S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
         |                                                                 ^~~~~~


vim +/__P000 +105 mm/mmap.c

d07e22597d1d35 Daniel Cashman  2016-01-14   79  
e0da382c92626a Hugh Dickins    2005-04-19   80  static void unmap_region(struct mm_struct *mm,
e0da382c92626a Hugh Dickins    2005-04-19   81  		struct vm_area_struct *vma, struct vm_area_struct *prev,
e0da382c92626a Hugh Dickins    2005-04-19   82  		unsigned long start, unsigned long end);
e0da382c92626a Hugh Dickins    2005-04-19   83  
^1da177e4c3f41 Linus Torvalds  2005-04-16   84  /* description of effects of mapping type and prot in current implementation.
^1da177e4c3f41 Linus Torvalds  2005-04-16   85   * this is due to the limited x86 page protection hardware.  The expected
^1da177e4c3f41 Linus Torvalds  2005-04-16   86   * behavior is in parens:
^1da177e4c3f41 Linus Torvalds  2005-04-16   87   *
^1da177e4c3f41 Linus Torvalds  2005-04-16   88   * map_type	prot
^1da177e4c3f41 Linus Torvalds  2005-04-16   89   *		PROT_NONE	PROT_READ	PROT_WRITE	PROT_EXEC
^1da177e4c3f41 Linus Torvalds  2005-04-16   90   * MAP_SHARED	r: (no) no	r: (yes) yes	r: (no) yes	r: (no) yes
^1da177e4c3f41 Linus Torvalds  2005-04-16   91   *		w: (no) no	w: (no) no	w: (yes) yes	w: (no) no
^1da177e4c3f41 Linus Torvalds  2005-04-16   92   *		x: (no) no	x: (no) yes	x: (no) yes	x: (yes) yes
^1da177e4c3f41 Linus Torvalds  2005-04-16   93   *
^1da177e4c3f41 Linus Torvalds  2005-04-16   94   * MAP_PRIVATE	r: (no) no	r: (yes) yes	r: (no) yes	r: (no) yes
^1da177e4c3f41 Linus Torvalds  2005-04-16   95   *		w: (no) no	w: (no) no	w: (copy) copy	w: (no) no
^1da177e4c3f41 Linus Torvalds  2005-04-16   96   *		x: (no) no	x: (no) yes	x: (no) yes	x: (yes) yes
18107f8a2df6bf Vladimir Murzin 2021-03-12   97   *
18107f8a2df6bf Vladimir Murzin 2021-03-12   98   * On arm64, PROT_EXEC has the following behaviour for both MAP_SHARED and
18107f8a2df6bf Vladimir Murzin 2021-03-12   99   * MAP_PRIVATE (with Enhanced PAN supported):
18107f8a2df6bf Vladimir Murzin 2021-03-12  100   *								r: (no) no
18107f8a2df6bf Vladimir Murzin 2021-03-12  101   *								w: (no) no
18107f8a2df6bf Vladimir Murzin 2021-03-12  102   *								x: (yes) yes
^1da177e4c3f41 Linus Torvalds  2005-04-16  103   */
ac34ceaf1cdb34 Daniel Micay    2017-07-06  104  pgprot_t protection_map[16] __ro_after_init = {
^1da177e4c3f41 Linus Torvalds  2005-04-16 @105  	__P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
^1da177e4c3f41 Linus Torvalds  2005-04-16 @106  	__S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
^1da177e4c3f41 Linus Torvalds  2005-04-16  107  };
^1da177e4c3f41 Linus Torvalds  2005-04-16  108  

:::::: The code at line 105 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

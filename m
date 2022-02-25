Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9EA4C44DE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbiBYMsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236429AbiBYMsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:48:43 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18486661F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645793289; x=1677329289;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=umfJw1Vn3KetQwrc3cEyNhi8dPbFFjFhw2v8oia89Hw=;
  b=d5a4ycFShE9MvN3w9fv4AKmvJID5PeYad8SeyPq7ZvSMHwMlUc+1xLy2
   n3PNldPSk8xzzUbx8L/k8+H16wfNPqlN/yOvfRTAj7BED8fuhqezT8p7v
   TiJJry6j9855zHwB0TOKvQ3OomsjmiMBTpAfkcU3Wp2iddviewQLODXip
   mGXvoZFyleXab71u0f/W9V70HEuYST2jhZmMUjC52DbYU5hZAaO/qp3mU
   uL/kS3WRq34b4M8c6ro/T4S4a2jnZxBWuff+IoPXyWEfroR4lfecwiI8q
   9NrsMlc0gj5VND/J/Y4zUbm1rbkskT3onHfuEN7wpGLlCVVQN2xr2QW3S
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="233113004"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="233113004"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 04:48:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="640103630"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 Feb 2022 04:48:07 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNa11-0004JK-6o; Fri, 25 Feb 2022 12:48:07 +0000
Date:   Fri, 25 Feb 2022 20:47:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [dinguyen:nios2_for_v5.18_4 1/1] mm/mmap.c:105:9: error: '__P000'
 undeclared here (not in a function)
Message-ID: <202202252005.Ql6JvCzE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git nios2_for_v5.18_4
head:   1d8048ad8cff3e11dd5ed1860cd6b0cf198c9a5d
commit: 1d8048ad8cff3e11dd5ed1860cd6b0cf198c9a5d [1/1] nios2/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20220225/202202252005.Ql6JvCzE-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/commit/?id=1d8048ad8cff3e11dd5ed1860cd6b0cf198c9a5d
        git remote add dinguyen https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git
        git fetch --no-tags dinguyen nios2_for_v5.18_4
        git checkout 1d8048ad8cff3e11dd5ed1860cd6b0cf198c9a5d
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

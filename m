Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52B449ADBA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446549AbiAYHkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:40:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:25343 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1446368AbiAYHiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643096298; x=1674632298;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ep4/XqUV8vhm4pdYEqymEwLzwqZhsycvsNNppeGeCVo=;
  b=K2Q+K4qQj5KlTm4m9sCSZ2c4XzpYcE8TGbi8HhQoy61Qg0AxBaoddqzy
   7SY4SJeh8oXuBwdo7esP2g7mBS46bmJ1Yye2nWIyHj5W94NhEc0qsxtEl
   R4aHQDvjFwjVlufMjy4KjhAqeifQOvrPBBGKuTnGNzpIdmNB4kO//Z3ka
   3xEFmWy4QdZDX78oVvxthq0qQzOzm+8ciLbMwgrI5Km5d2zkZ11Y3LbNw
   a8aOyrGDUGlw/jTLHrM1403rXyctMKImjl2p/n+FGhLM53LQ2LsTDxXT3
   /mhaYu+6/RxzXnGiG7l2AKKALwy9Z05CWv6KmpmIaF1Jkv2zK6glqZ/qb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="233612032"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="233612032"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 23:36:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="477011130"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2022 23:36:30 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCGNR-000JW8-DD; Tue, 25 Jan 2022 07:36:29 +0000
Date:   Tue, 25 Jan 2022 15:35:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [kees:for-next/array-bounds 9/10] arch/sh/kernel/machvec.c:105:33:
 warning: array subscript 'struct sh_machine_vector[0]' is partly outside
 array bounds of 'long int[1]'
Message-ID: <202201251510.55XdBprq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/array-bounds
head:   3ccac0d2ba34a8e6f722975136f06c30fb586ca0
commit: 4ba545781e20f49cf1175e11d9f606e621040acf [9/10] Makefile: Enable -Warray-bounds
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220125/202201251510.55XdBprq-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=4ba545781e20f49cf1175e11d9f606e621040acf
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees for-next/array-bounds
        git checkout 4ba545781e20f49cf1175e11d9f606e621040acf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash arch/sh/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/sh/kernel/machvec.c: In function 'early_parse_mv':
   arch/sh/kernel/machvec.c:44:15: warning: variable 'mv_comma' set but not used [-Wunused-but-set-variable]
      44 |         char *mv_comma;
         |               ^~~~~~~~
   arch/sh/kernel/machvec.c: In function 'sh_mv_setup':
>> arch/sh/kernel/machvec.c:105:33: warning: array subscript 'struct sh_machine_vector[0]' is partly outside array bounds of 'long int[1]' [-Warray-bounds]
     105 |                         sh_mv = *(struct sh_machine_vector *)&__machvec_start;
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/sh/kernel/machvec.c:13:
   arch/sh/include/asm/sections.h:7:13: note: while referencing '__machvec_start'
       7 | extern long __machvec_start, __machvec_end;
         |             ^~~~~~~~~~~~~~~


vim +105 arch/sh/kernel/machvec.c

9655ad03af2d23 Paul Mundt 2007-05-14   80  
9655ad03af2d23 Paul Mundt 2007-05-14   81  void __init sh_mv_setup(void)
9655ad03af2d23 Paul Mundt 2007-05-14   82  {
82f81f4784479d Paul Mundt 2007-05-15   83  	/*
82f81f4784479d Paul Mundt 2007-05-15   84  	 * Only overload the machvec if one hasn't been selected on
82f81f4784479d Paul Mundt 2007-05-15   85  	 * the command line with sh_mv=
82f81f4784479d Paul Mundt 2007-05-15   86  	 */
fd8f20e8e2f8f1 Paul Mundt 2007-05-15   87  	if (!machvec_selected) {
82f81f4784479d Paul Mundt 2007-05-15   88  		unsigned long machvec_size;
82f81f4784479d Paul Mundt 2007-05-15   89  
82f81f4784479d Paul Mundt 2007-05-15   90  		machvec_size = ((unsigned long)&__machvec_end -
82f81f4784479d Paul Mundt 2007-05-15   91  				(unsigned long)&__machvec_start);
82f81f4784479d Paul Mundt 2007-05-15   92  
5556410e220387 Paul Mundt 2007-08-07   93  		/*
5556410e220387 Paul Mundt 2007-08-07   94  		 * Sanity check for machvec section alignment. Ensure
5556410e220387 Paul Mundt 2007-08-07   95  		 * __initmv hasn't been misused.
5556410e220387 Paul Mundt 2007-08-07   96  		 */
5556410e220387 Paul Mundt 2007-08-07   97  		if (machvec_size % sizeof(struct sh_machine_vector))
5556410e220387 Paul Mundt 2007-08-07   98  			panic("machvec misaligned, invalid __initmv use?");
5556410e220387 Paul Mundt 2007-08-07   99  
82f81f4784479d Paul Mundt 2007-05-15  100  		/*
82f81f4784479d Paul Mundt 2007-05-15  101  		 * If the machvec hasn't been preselected, use the first
82f81f4784479d Paul Mundt 2007-05-15  102  		 * vector (usually the only one) from .machvec.init.
82f81f4784479d Paul Mundt 2007-05-15  103  		 */
82f81f4784479d Paul Mundt 2007-05-15  104  		if (machvec_size >= sizeof(struct sh_machine_vector))
82f81f4784479d Paul Mundt 2007-05-15 @105  			sh_mv = *(struct sh_machine_vector *)&__machvec_start;

:::::: The code at line 105 was first introduced by commit
:::::: 82f81f4784479df17a80caff4a7156da0a2f7dea sh: Kill off machvec aliases.

:::::: TO: Paul Mundt <lethal@linux-sh.org>
:::::: CC: Paul Mundt <lethal@hera.kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

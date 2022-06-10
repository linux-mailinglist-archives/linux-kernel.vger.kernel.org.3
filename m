Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EBA545DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346731AbiFJHjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242965AbiFJHjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:39:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0647F132A01
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654846746; x=1686382746;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tz2RL+HS4r32xIaJ/73nLWxu3dUh85wzrLbWf1YJ8Yw=;
  b=CxkIfv1yZqCDKuX0WyyS9aFp3LHIyo8JBfyrhjhtYUe9E0EYrA54GdJe
   TIuO1KSqlN6LNMxM2uhE6fy8Z8hPE93kmtsv+T+j+MVPRBIZbquEi7MWG
   7OfeG+X95EJoIm0LYIxViEr6LsYNT0+zVa78SlawEjRz/Eq4H2eQJKLoM
   bdSsFVga5URLjiINfTpiBQn9BAfbDGv3cdtJ+4g4rZC3aslNhD+GB8t22
   WZI6047sYqVUnyIoUGSRJt/zWUXMuaOfMRlSY6jqyjrwGLZv37q7Qd5Z5
   HWYO5xg/UhT6Mr8H7u8wpgo0E7QATpw2VJcL4v+5Zxf6JKTnPKIREydvl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="341611362"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="341611362"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 00:39:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="649690457"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jun 2022 00:39:05 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzZEW-000GnF-Ev;
        Fri, 10 Jun 2022 07:39:04 +0000
Date:   Fri, 10 Jun 2022 15:38:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [norov:fns 8/8] include/linux/export.h:57:43: error: redefinition of
 '__ksymtab__find_first_bit'
Message-ID: <202206101537.a5KuHQgw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux fns
head:   785e34f40a6ad867ddc1fccf032a54bb41563865
commit: 785e34f40a6ad867ddc1fccf032a54bb41563865 [8/8] fns
config: arc-randconfig-r043-20220609 (https://download.01.org/0day-ci/archive/20220610/202206101537.a5KuHQgw-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/785e34f40a6ad867ddc1fccf032a54bb41563865
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov fns
        git checkout 785e34f40a6ad867ddc1fccf032a54bb41563865
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from lib/find_bit.c:17:
>> include/linux/export.h:57:43: error: redefinition of '__ksymtab__find_first_bit'
      57 |         static const struct kernel_symbol __ksymtab_##sym               \
         |                                           ^~~~~~~~~~
   include/linux/export.h:96:9: note: in expansion of macro '__KSYMTAB_ENTRY'
      96 |         __KSYMTAB_ENTRY(sym, sec)
         |         ^~~~~~~~~~~~~~~
   include/linux/export.h:140:41: note: in expansion of macro '___EXPORT_SYMBOL'
     140 | #define __EXPORT_SYMBOL(sym, sec, ns)   ___EXPORT_SYMBOL(sym, sec, ns)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/export.h:147:41: note: in expansion of macro '__EXPORT_SYMBOL'
     147 | #define _EXPORT_SYMBOL(sym, sec)        __EXPORT_SYMBOL(sym, sec, "")
         |                                         ^~~~~~~~~~~~~~~
   include/linux/export.h:150:41: note: in expansion of macro '_EXPORT_SYMBOL'
     150 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   lib/find_bit.c:105:1: note: in expansion of macro 'EXPORT_SYMBOL'
     105 | EXPORT_SYMBOL(_find_first_bit);
         | ^~~~~~~~~~~~~
   include/linux/export.h:57:43: note: previous definition of '__ksymtab__find_first_bit' with type 'const struct kernel_symbol'
      57 |         static const struct kernel_symbol __ksymtab_##sym               \
         |                                           ^~~~~~~~~~
   include/linux/export.h:96:9: note: in expansion of macro '__KSYMTAB_ENTRY'
      96 |         __KSYMTAB_ENTRY(sym, sec)
         |         ^~~~~~~~~~~~~~~
   include/linux/export.h:140:41: note: in expansion of macro '___EXPORT_SYMBOL'
     140 | #define __EXPORT_SYMBOL(sym, sec, ns)   ___EXPORT_SYMBOL(sym, sec, ns)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/export.h:147:41: note: in expansion of macro '__EXPORT_SYMBOL'
     147 | #define _EXPORT_SYMBOL(sym, sec)        __EXPORT_SYMBOL(sym, sec, "")
         |                                         ^~~~~~~~~~~~~~~
   include/linux/export.h:150:41: note: in expansion of macro '_EXPORT_SYMBOL'
     150 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   lib/find_bit.c:89:1: note: in expansion of macro 'EXPORT_SYMBOL'
      89 | EXPORT_SYMBOL(_find_first_bit);
         | ^~~~~~~~~~~~~


vim +/__ksymtab__find_first_bit +57 include/linux/export.h

f50169324df4ad Paul Gortmaker    2011-05-23  31  
7290d58095712a Ard Biesheuvel    2018-08-21  32  #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
7290d58095712a Ard Biesheuvel    2018-08-21  33  #include <linux/compiler.h>
7290d58095712a Ard Biesheuvel    2018-08-21  34  /*
7290d58095712a Ard Biesheuvel    2018-08-21  35   * Emit the ksymtab entry as a pair of relative references: this reduces
7290d58095712a Ard Biesheuvel    2018-08-21  36   * the size by half on 64-bit architectures, and eliminates the need for
7290d58095712a Ard Biesheuvel    2018-08-21  37   * absolute relocations that require runtime processing on relocatable
7290d58095712a Ard Biesheuvel    2018-08-21  38   * kernels.
7290d58095712a Ard Biesheuvel    2018-08-21  39   */
7290d58095712a Ard Biesheuvel    2018-08-21  40  #define __KSYMTAB_ENTRY(sym, sec)					\
7290d58095712a Ard Biesheuvel    2018-08-21  41  	__ADDRESSABLE(sym)						\
7290d58095712a Ard Biesheuvel    2018-08-21  42  	asm("	.section \"___ksymtab" sec "+" #sym "\", \"a\"	\n"	\
ed13fc33f76303 Matthias Maennich 2019-09-06  43  	    "	.balign	4					\n"	\
7290d58095712a Ard Biesheuvel    2018-08-21  44  	    "__ksymtab_" #sym ":				\n"	\
7290d58095712a Ard Biesheuvel    2018-08-21  45  	    "	.long	" #sym "- .				\n"	\
7290d58095712a Ard Biesheuvel    2018-08-21  46  	    "	.long	__kstrtab_" #sym "- .			\n"	\
c3a6cf19e695c8 Masahiro Yamada   2019-10-18  47  	    "	.long	__kstrtabns_" #sym "- .			\n"	\
7290d58095712a Ard Biesheuvel    2018-08-21  48  	    "	.previous					\n")
7290d58095712a Ard Biesheuvel    2018-08-21  49  
7290d58095712a Ard Biesheuvel    2018-08-21  50  struct kernel_symbol {
7290d58095712a Ard Biesheuvel    2018-08-21  51  	int value_offset;
7290d58095712a Ard Biesheuvel    2018-08-21  52  	int name_offset;
8651ec01daedad Matthias Maennich 2019-09-06  53  	int namespace_offset;
7290d58095712a Ard Biesheuvel    2018-08-21  54  };
7290d58095712a Ard Biesheuvel    2018-08-21  55  #else
7290d58095712a Ard Biesheuvel    2018-08-21  56  #define __KSYMTAB_ENTRY(sym, sec)					\
7290d58095712a Ard Biesheuvel    2018-08-21 @57  	static const struct kernel_symbol __ksymtab_##sym		\
7290d58095712a Ard Biesheuvel    2018-08-21  58  	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
ed13fc33f76303 Matthias Maennich 2019-09-06  59  	__aligned(sizeof(void *))					\
c3a6cf19e695c8 Masahiro Yamada   2019-10-18  60  	= { (unsigned long)&sym, __kstrtab_##sym, __kstrtabns_##sym }
7290d58095712a Ard Biesheuvel    2018-08-21  61  

:::::: The code at line 57 was first introduced by commit
:::::: 7290d58095712a89f845e1bca05334796dd49ed2 module: use relative references for __ksymtab entries

:::::: TO: Ard Biesheuvel <ard.biesheuvel@linaro.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

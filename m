Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BCC4AA418
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377950AbiBDXP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:15:58 -0500
Received: from mga07.intel.com ([134.134.136.100]:6598 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377934AbiBDXP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644016558; x=1675552558;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iXO/rN2KwMjsbXkqzVwFAfE9MlIWX4gO/FItcy/mkWY=;
  b=fzrb3xDvXW4oQu0qF/woUaDUY805oREoa01FYN9zAkS3biOLjjI+Oe/D
   QDmlItke6B7DPGvSyQA9WtWo5jplu44ifo6aC0M6UStSCq2DLHpDi4CPZ
   OIA+ZoD1wKqmezkrNdh3ETpUbrImYpvUrULWIkSskr0g/TBHXg/4fKltZ
   Wigp0oj0ovD7+snDFEqPU000rBSj4gQmJpwNOX7jy3yzCdpNuek+Smil6
   ZH+vJWV/DGG3BTgxiTftEk6bCi8KF/VcFnYBRuJM5/XC1pLlp+i1ac6BP
   xO/UX9vKpr4HQCKZaufEw9iRGdSFob4Iy6+d0nP99VZqc6O7KtZq9vzqj
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="311759897"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="311759897"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 15:15:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="631845319"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 Feb 2022 15:15:56 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nG7o3-000YHy-Qa; Fri, 04 Feb 2022 23:15:55 +0000
Date:   Sat, 5 Feb 2022 07:14:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kris Van Hees <kris.van.hees@oracle.com>
Subject: [oracle-dtrace:v2/5.17-rc2 6/10] kernel/kallsyms.c:775:17: error:
 expected expression before 'unsigned'
Message-ID: <202202050735.guXoa1xq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/oracle/dtrace-linux-kernel v2/5.17-rc2
head:   47946e7b2e2319f39cbb7f8aaa294298c2dec5b4
commit: ea16e4ce65d8342913051086a89eac87dc54aced [6/10] kallsyms: add /proc/kallmodsyms
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20220205/202202050735.guXoa1xq-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/oracle/dtrace-linux-kernel/commit/ea16e4ce65d8342913051086a89eac87dc54aced
        git remote add oracle-dtrace https://github.com/oracle/dtrace-linux-kernel
        git fetch --no-tags oracle-dtrace v2/5.17-rc2
        git checkout ea16e4ce65d8342913051086a89eac87dc54aced
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   kernel/kallsyms.c:666:12: warning: no previous prototype for 'arch_get_kallsym' [-Wmissing-prototypes]
     666 | int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
         |            ^~~~~~~~~~~~~~~~
   kernel/kallsyms.c: In function 'get_ksymbol_core':
>> kernel/kallsyms.c:775:17: error: expected expression before 'unsigned'
     775 |                 unsigned long mod_idx = (unsigned long) -1;
         |                 ^~~~~~~~
   In file included from arch/powerpc/include/asm/cmpxchg.h:6,
                    from arch/powerpc/include/asm/atomic.h:11,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/kallsyms.h:10,
                    from kernel/kallsyms.c:15:
>> kernel/kallsyms.c:806:42: warning: comparison between pointer and integer
     806 |                   if (likely(iter->value != &_etext))
         |                                          ^~
   include/linux/compiler.h:77:45: note: in definition of macro 'likely'
      77 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   kernel/kallsyms.c:804:31: warning: unused variable 'endstr' [-Wunused-variable]
     804 |                   const char *endstr;
         |                               ^~~~~~


vim +/unsigned +775 kernel/kallsyms.c

   755	
   756	/* Returns space to next name. */
   757	static unsigned long get_ksymbol_core(struct kallsym_iter *iter, int kallmodsyms)
   758	{
   759		unsigned off = iter->nameoff;
   760	
   761		iter->exported = 0;
   762		iter->value = kallsyms_sym_address(iter->pos);
   763	
   764		iter->type = kallsyms_get_symbol_type(off);
   765	
   766		iter->module_name[0] = '\0';
   767		iter->builtin_module_names = NULL;
   768	
   769		off = kallsyms_expand_symbol(off, iter->name, ARRAY_SIZE(iter->name));
   770	#ifdef CONFIG_KALLMODSYMS
   771		if (kallmodsyms) {
   772			unsigned long mod_idx = (unsigned long) -1;
   773	
   774			if (kallsyms_module_offsets)
 > 775			unsigned long mod_idx = (unsigned long) -1;
   776	
   777			if (kallsyms_module_offsets)
   778				mod_idx =
   779				  get_builtin_module_idx(iter->value,
   780							 iter->hint_builtin_module_idx);
   781	
   782			/*
   783			 * This is a built-in module iff the tables of built-in modules
   784			 * (address->module name mappings) and module names are known,
   785			 * and if the address was found there, and if the corresponding
   786			 * module index is nonzero, and iff this is a text (or weak)
   787			 * symbol.  All other cases mean off the end of the binary or in
   788			 * a non-modular range in between one or more modules.  (Also
   789			 * guard against a corrupt kallsyms_objfiles array pointing off
   790			 * the end of kallsyms_modules.)
   791			 */
   792			if (kallsyms_modules != NULL && kallsyms_module_names != NULL &&
   793			    (iter->type == 't' || iter->type == 'T' ||
   794			     iter->type == 'w' || iter->type == 'W') &&
   795			    mod_idx != (unsigned long) -1 &&
   796			    kallsyms_modules[mod_idx] != 0 &&
   797			    kallsyms_modules[mod_idx] < kallsyms_module_names_len) {
   798			  /*
   799			   * Rule out (rare) section start/end symbols which might
   800			   * overlap the last symbol in .text.  (Will also hit at most
   801			   * one symbol which really is in a built-in module, but only
   802			   * if that symbol is zero-length.)
   803			   */
   804			  const char *endstr;
   805	
 > 806			  if (likely(iter->value != &_etext))
   807			    iter->builtin_module_names =
   808			      &kallsyms_module_names[kallsyms_modules[mod_idx]];
   809			}
   810			iter->hint_builtin_module_idx = mod_idx;
   811		}
   812	#endif
   813		return off - iter->nameoff;
   814	}
   815	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F7048DD9E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbiAMSZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:25:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:2904 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230329AbiAMSZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:25:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642098318; x=1673634318;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IGrTbcmhXoLA+UxYUlRJGOMkwvHc3LyXd5ONO1maOjY=;
  b=GfeuXA3CM/5RMTBmWMQvuLbPPbaCwferx4UpXIecumCJ9kSHiUYuV8Y8
   YTntMkwQTF+Pa8iuUcxDrYdUJgXhGG76dbzL992PZOk8bLqO2slfKXVoB
   gwMPmaRxo9+2EMjmEgxucdqzBBosDRQ0tyk2aguE5WTDoaTq9YkSyNDeV
   HoxQ/HCxlhhgNt7RsQdJK5af+5ko0Zu0OxcICE/q9ewZ+8nDyDe47Z5wt
   Qo1SAjHM4LBxP5YL6JAHO1LK8GCo09NV6fp/3ExlMg7qqPVR2ginomoqL
   146XJf1Cw8e7O8KtrNCU5jAp29YA7YE+RUu3i7PPw7KYC7TGb354qWy0O
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="243880429"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="243880429"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 10:25:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="475444201"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 13 Jan 2022 10:24:59 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n84mR-0007XC-2f; Thu, 13 Jan 2022 18:24:59 +0000
Date:   Fri, 14 Jan 2022 02:24:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 583/2382] kernel/kallsyms.c:895:81: error: invalid
 application of 'sizeof' to an incomplete type 'struct kallsyms_entry'
Message-ID: <202201140216.czBUwf1E-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   1a880941a087613ed42f77001229edfcf75ea8a5
commit: 4357bf918816f743b593665e792f78913f0da47b [583/2382] kallsyms/objtool: Process entries
config: x86_64-randconfig-a015-20220109 (https://download.01.org/0day-ci/archive/20220114/202201140216.czBUwf1E-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 244dd2913a43a200f5a6544d424cdc37b771028b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=4357bf918816f743b593665e792f78913f0da47b
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 4357bf918816f743b593665e792f78913f0da47b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the mingo-tip/master HEAD 1a880941a087613ed42f77001229edfcf75ea8a5 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   kernel/kallsyms.c:586:12: warning: no previous prototype for function 'arch_get_kallsym' [-Wmissing-prototypes]
   int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
              ^
   kernel/kallsyms.c:586:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
   ^
   static 
>> kernel/kallsyms.c:895:81: error: invalid application of 'sizeof' to an incomplete type 'struct kallsyms_entry'
           nr_entries = ((long)&__kallsyms_offsets_end - (long)&__kallsyms_offsets_begin)/sizeof(struct kallsyms_entry);
                                                                                          ^     ~~~~~~~~~~~~~~~~~~~~~~~
   kernel/kallsyms.c:889:9: note: forward declaration of 'struct kallsyms_entry'
           struct kallsyms_entry *entries;
                  ^
   kernel/kallsyms.c:905:85: error: subscript of pointer to incomplete type 'struct kallsyms_entry'
                   printk("# kallsyms entry %6ld/%6ld: [%016Lx]: {%s}\n", i, nr_entries, (u64)entries[i].offset, str);
                                                                                              ~~~~~~~^
   include/linux/printk.h:450:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                              ^~~~~~~~~~~
   include/linux/printk.h:422:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                                   ^~~~~~~~~~~
   kernel/kallsyms.c:889:9: note: forward declaration of 'struct kallsyms_entry'
           struct kallsyms_entry *entries;
                  ^
   1 warning and 2 errors generated.


vim +895 kernel/kallsyms.c

   886	
   887	static void __init kallsyms_objtool_init(void)
   888	{
   889		struct kallsyms_entry *entries;
   890		long nr_entries, i;
   891		char *str;
   892	
   893		printk("# kallsyms_objtool_init()\n");
   894	
 > 895		nr_entries = ((long)&__kallsyms_offsets_end - (long)&__kallsyms_offsets_begin)/sizeof(struct kallsyms_entry);
   896	
   897		printk("# kallsyms: %ld entries.\n", nr_entries);
   898	
   899		BUG_ON(nr_entries <= 0);
   900	
   901		str = &__kallsyms_strs_begin;
   902		entries = (void *) &__kallsyms_offsets_begin;
   903	
   904		for (i = 0; i < nr_entries; i++) {
   905			printk("# kallsyms entry %6ld/%6ld: [%016Lx]: {%s}\n", i, nr_entries, (u64)entries[i].offset, str);
   906	
   907			str += strlen(str) + 1;
   908	
   909		}
   910		printk("# kallsyms, last str:             %p\n", str);
   911		printk("# kallsyms, &__kallsyms_strs_end: %p\n", &__kallsyms_strs_end);
   912	
   913		BUG_ON(str != &__kallsyms_strs_end);
   914	}
   915	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

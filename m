Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FF24DDFD2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 18:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbiCRR2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 13:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238339AbiCRR2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 13:28:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E571D7609
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 10:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647624408; x=1679160408;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kkAQ6qPSpuMWPWmTe3y+cH8O037hfpbGVM+AlCWo/qM=;
  b=KirKYd/8YgiS9n1b+tzeY18ktQsvGe4FRB6kjVZVjhBORmuxzfNfGhBI
   KqtUaWwUDHbMIQMv1G5iiAXSf56H/Iu+w6uPLxZ59+UV2HHMT859u1c1D
   PRaE8lDQ7NY0ghZfN+kSzZk2+tqmWGau+EKGnZl36n3/fsJiTqtA4JcOT
   lT51txFIaH3xqsiisB75LaoIUsTwJIeWFFF6pE62vjnrnv9nMzX7nDrnH
   duKcSV7+W10nVuZPXYthGgBfei6pM4bjzgFa5sJCDnSxoGdcqp3Rt9zZQ
   xiL6bVKhlOqoB+S4nHWzRrGUcFBJbNzihR8iRgCx2tervq4PsGvL61fI8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="343619581"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="343619581"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 10:26:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="517319912"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 18 Mar 2022 10:26:45 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVGNA-000F16-VI; Fri, 18 Mar 2022 17:26:44 +0000
Date:   Sat, 19 Mar 2022 01:25:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [ammarfaizi2-block:palmer/linux/riscv-d1-merge 13/20]
 arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time
 absolute expression
Message-ID: <202203190105.wexJ9bbL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-d1-merge
head:   93a6d3583d613a2ff1c6d28060c78af8631e0d21
commit: 83ff7850cc5b31c512f0a30437e2999ec5505712 [13/20] riscv: prevent compressed instructions in alternatives
config: riscv-randconfig-r042-20220318 (https://download.01.org/0day-ci/archive/20220319/202203190105.wexJ9bbL-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6e70e4056dff962ec634c5bd4f2f4105a0bef71)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/83ff7850cc5b31c512f0a30437e2999ec5505712
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-d1-merge
        git checkout 83ff7850cc5b31c512f0a30437e2999ec5505712
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/mm/init.c:724:13: warning: no previous prototype for function 'pt_ops_set_early' [-Wmissing-prototypes]
   void __init pt_ops_set_early(void)
               ^
   arch/riscv/mm/init.c:724:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init pt_ops_set_early(void)
   ^
   static 
   arch/riscv/mm/init.c:744:13: warning: no previous prototype for function 'pt_ops_set_fixmap' [-Wmissing-prototypes]
   void __init pt_ops_set_fixmap(void)
               ^
   arch/riscv/mm/init.c:744:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init pt_ops_set_fixmap(void)
   ^
   static 
   arch/riscv/mm/init.c:760:13: warning: no previous prototype for function 'pt_ops_set_late' [-Wmissing-prototypes]
   void __init pt_ops_set_late(void)
               ^
   arch/riscv/mm/init.c:760:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init pt_ops_set_late(void)
   ^
   static 
   In file included from arch/riscv/mm/init.c:10:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:107:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:136:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:102:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:99:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:88:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:23:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from arch/riscv/mm/init.c:10:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:107:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:136:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:102:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:99:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:89:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
            ^
   <inline asm>:24:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from arch/riscv/mm/init.c:10:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:107:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:136:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:102:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:99:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:88:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:23:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from arch/riscv/mm/init.c:10:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:107:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:136:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:102:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:99:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:89:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
            ^
   <inline asm>:24:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from arch/riscv/mm/init.c:10:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:107:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:136:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:102:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:99:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:88:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:23:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from arch/riscv/mm/init.c:10:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:107:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:136:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:102:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:99:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:89:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
            ^
   <inline asm>:24:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from arch/riscv/mm/init.c:10:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:107:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:136:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:102:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:99:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:88:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:23:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from arch/riscv/mm/init.c:10:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:107:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:136:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:102:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:99:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:89:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
            ^
   <inline asm>:24:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from arch/riscv/mm/init.c:10:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:107:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:136:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:102:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:99:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:88:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:23:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from arch/riscv/mm/init.c:10:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:107:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:136:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:102:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:99:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:89:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
            ^
   <inline asm>:24:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from arch/riscv/mm/init.c:10:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:107:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:136:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:102:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:99:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:88:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:23:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from arch/riscv/mm/init.c:10:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:107:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:136:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:102:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:99:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:89:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
            ^
   <inline asm>:24:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from arch/riscv/mm/init.c:10:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:107:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:136:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:102:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:99:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:88:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:23:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from arch/riscv/mm/init.c:10:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:107:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:136:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:102:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:99:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:89:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
            ^
   <inline asm>:24:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from arch/riscv/mm/init.c:10:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:107:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:136:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:102:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:99:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:88:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:23:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from arch/riscv/mm/init.c:10:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:107:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:136:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:102:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:99:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:89:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
            ^
   <inline asm>:24:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from arch/riscv/mm/init.c:10:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:107:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:136:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:102:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:99:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:88:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:23:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from arch/riscv/mm/init.c:10:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:107:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:136:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:102:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:99:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:89:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
            ^
   <inline asm>:24:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from arch/riscv/mm/init.c:10:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:107:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:136:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:102:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:99:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:88:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:23:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   3 warnings and 20 errors generated.
..


vim +23 arch/riscv/include/asm/tlbflush.h

fab957c11efe2f4 Palmer Dabbelt    2017-07-10  19  
fab957c11efe2f4 Palmer Dabbelt    2017-07-10  20  /* Flush one page from local TLB */
fab957c11efe2f4 Palmer Dabbelt    2017-07-10  21  static inline void local_flush_tlb_page(unsigned long addr)
fab957c11efe2f4 Palmer Dabbelt    2017-07-10  22  {
bff3ff525460b49 Vincent Chen      2021-03-22 @23  	ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
fab957c11efe2f4 Palmer Dabbelt    2017-07-10  24  }
6bd33e1ece528f6 Christoph Hellwig 2019-10-28  25  #else /* CONFIG_MMU */
6bd33e1ece528f6 Christoph Hellwig 2019-10-28  26  #define local_flush_tlb_all()			do { } while (0)
6bd33e1ece528f6 Christoph Hellwig 2019-10-28  27  #define local_flush_tlb_page(addr)		do { } while (0)
6bd33e1ece528f6 Christoph Hellwig 2019-10-28  28  #endif /* CONFIG_MMU */
fab957c11efe2f4 Palmer Dabbelt    2017-07-10  29  

:::::: The code at line 23 was first introduced by commit
:::::: bff3ff525460b492dca1d1665e821d2b5816ebdb riscv: sifive: Apply errata "cip-1200" patch

:::::: TO: Vincent Chen <vincent.chen@sifive.com>
:::::: CC: Palmer Dabbelt <palmerdabbelt@google.com>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

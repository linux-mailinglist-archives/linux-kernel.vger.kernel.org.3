Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C254EDF76
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiCaRSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiCaRRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:17:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10117DF5D
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 10:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648746962; x=1680282962;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J9J6CKu3v/HzBzaULcyq4s0dv8N0ucEqoB5pI+k+KxQ=;
  b=Kawco1duvajC83iycFakZOV221mNIMaTJUuKeIYJ2EXo8H+TZFQB1/vw
   A9cGnx8j4quWrcsm2M92savfxWbkV2fcvPKp0Wmq/oksxrTZUlz8Q0yAI
   lPcv2FChwGz+6etYfJnqnAw0MQX+XlGHTJaqizapFNWfsVTDBjceHA0yA
   WPWB/L+wgriHyK0jPbnrtglRjsQ13HrSvtr8rjC8LfkP7SmVXCEvNI82S
   K3ubafKHIr0DUwXEvvxWsHNEOl1+jocKmoAyWHXyDtOfkT1gejkB6N/7c
   /A11tCaLsOKQrt3PIbEV2vxCqV+bFEIMydsPJ1UpqXsBnPb5Pib7tDdNZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="247400537"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="247400537"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 10:16:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="720543722"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 31 Mar 2022 10:15:59 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZyOs-0000TP-M8;
        Thu, 31 Mar 2022 17:15:58 +0000
Date:   Fri, 1 Apr 2022 01:15:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [palmer:riscv-d1 7/14] arch/riscv/include/asm/tlbflush.h:23:2:
 error: expected assembly-time absolute expression
Message-ID: <202204010144.HDTt8y5n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git riscv-d1
head:   f705a2550d38971a0ad596ebe02c083ec163722f
commit: 59cf8769c28e188d7590449072c4a0a6f4ddf00a [7/14] riscv: prevent compressed instructions in alternatives
config: riscv-randconfig-r042-20220331 (https://download.01.org/0day-ci/archive/20220401/202204010144.HDTt8y5n-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 22a95dd3e6c911c2854dd75f42ba32d34840a61a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/commit/?id=59cf8769c28e188d7590449072c4a0a6f4ddf00a
        git remote add palmer https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git
        git fetch --no-tags palmer riscv-d1
        git checkout 59cf8769c28e188d7590449072c4a0a6f4ddf00a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:108:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:173:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:109:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:106:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:94:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:25:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:108:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:173:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:109:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:106:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:95:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
            ^
   <inline asm>:26:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:108:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:173:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:109:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:106:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:94:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:25:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:108:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:173:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:109:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:106:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:95:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
            ^
   <inline asm>:26:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:108:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:173:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:109:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:106:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:94:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:25:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:108:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:173:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:109:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:106:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:95:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
            ^
   <inline asm>:26:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:108:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:173:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:109:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:106:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:94:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:25:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:108:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:173:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:109:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:106:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:95:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
            ^
   <inline asm>:26:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:108:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:173:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:109:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:106:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:94:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:25:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:108:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:173:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:109:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:106:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:95:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
            ^
   <inline asm>:26:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:108:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:173:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:109:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:106:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:94:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:25:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:108:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:173:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:109:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:106:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:95:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
            ^
   <inline asm>:26:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:108:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:173:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:109:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:106:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:94:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:25:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:108:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:173:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:109:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:106:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:95:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
            ^
   <inline asm>:26:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:108:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:173:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:109:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:106:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:94:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:25:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:108:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:173:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:109:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:106:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:95:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
            ^
   <inline asm>:26:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:108:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:173:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:109:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:106:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:94:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:25:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:108:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:173:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:109:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:106:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:95:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
            ^
   <inline asm>:26:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from mm/memory.c:42:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:108:
>> arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
           ^
   arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
       ^
   arch/riscv/include/asm/alternative-macros.h:173:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:109:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:106:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:94:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:25:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.
..


vim +23 arch/riscv/include/asm/tlbflush.h

fab957c11efe2f Palmer Dabbelt    2017-07-10  19  
fab957c11efe2f Palmer Dabbelt    2017-07-10  20  /* Flush one page from local TLB */
fab957c11efe2f Palmer Dabbelt    2017-07-10  21  static inline void local_flush_tlb_page(unsigned long addr)
fab957c11efe2f Palmer Dabbelt    2017-07-10  22  {
bff3ff525460b4 Vincent Chen      2021-03-22 @23  	ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
fab957c11efe2f Palmer Dabbelt    2017-07-10  24  }
6bd33e1ece528f Christoph Hellwig 2019-10-28  25  #else /* CONFIG_MMU */
6bd33e1ece528f Christoph Hellwig 2019-10-28  26  #define local_flush_tlb_all()			do { } while (0)
6bd33e1ece528f Christoph Hellwig 2019-10-28  27  #define local_flush_tlb_page(addr)		do { } while (0)
6bd33e1ece528f Christoph Hellwig 2019-10-28  28  #endif /* CONFIG_MMU */
fab957c11efe2f Palmer Dabbelt    2017-07-10  29  

:::::: The code at line 23 was first introduced by commit
:::::: bff3ff525460b492dca1d1665e821d2b5816ebdb riscv: sifive: Apply errata "cip-1200" patch

:::::: TO: Vincent Chen <vincent.chen@sifive.com>
:::::: CC: Palmer Dabbelt <palmerdabbelt@google.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FF54EE03A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbiCaSS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiCaSS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:18:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3C31E5335
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648750630; x=1680286630;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1SE7jLV0+FdCsMsMBLhWyxNQxzqrHc7fO3VKKkTB9jw=;
  b=mQEHTbZXJbB1rzLhUAvrvHs9Yjg9dfZtTcKQZZ2m9sy7IzQw7OAZ2sO0
   YzcW0TNORLpj5IPEgPKhlzlLi9V7RLqV6X4UrdZjKEsqNdK8fwcagj6U7
   LxpoqGylawfmEFOzBvTBX7qzLURyOipQmTyjSqV64GChk7rZISOiUvbHn
   smbbwItAUeT3maZ1jLwfLxl+YV+ZBP/CQlQ09bxhmgCcZ2vRm4Tt2cMM1
   baYQS4zGImZkvwY47wzqQN2OYG2tNQE/ztWsC3Uw8Vl8UUtDc30+O/P9S
   MvhK2burQ5e/LnWv8vuECrhnJG8ZrgUiPjrnbHeZ5fNs/1pIBi6IrB+eD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="247414549"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="247414549"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 11:17:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="606227574"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 31 Mar 2022 11:17:07 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZzM2-0000XV-Ku;
        Thu, 31 Mar 2022 18:17:06 +0000
Date:   Fri, 1 Apr 2022 02:16:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wei Fu <wefu@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Liu Shaohua <liush@allwinnertech.com>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Subject: [palmer:riscv-d1 11/14] arch/riscv/include/asm/pgtable-64.h:109:2:
 error: expected assembly-time absolute expression
Message-ID: <202204010256.mroJYOIf-lkp@intel.com>
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
commit: 0d3244d2ebd54130bb80c0e27394f57d30e7364f [11/14] riscv: add RISC-V Svpbmt extension support
config: riscv-randconfig-r042-20220331 (https://download.01.org/0day-ci/archive/20220401/202204010256.mroJYOIf-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 22a95dd3e6c911c2854dd75f42ba32d34840a61a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/commit/?id=0d3244d2ebd54130bb80c0e27394f57d30e7364f
        git remote add palmer https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git
        git fetch --no-tags palmer riscv-d1
        git checkout 0d3244d2ebd54130bb80c0e27394f57d30e7364f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/staging/sm750fb/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/staging/sm750fb/sm750_hw.c:6:
   In file included from include/linux/mm.h:29:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:112:
>> arch/riscv/include/asm/pgtable-64.h:109:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_IO);
           ^
   arch/riscv/include/asm/errata_list.h:46:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,     \
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
   <inline asm>:27:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from drivers/staging/sm750fb/sm750_hw.c:6:
   In file included from include/linux/mm.h:29:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:112:
>> arch/riscv/include/asm/pgtable-64.h:109:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_IO);
           ^
   arch/riscv/include/asm/errata_list.h:46:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,     \
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
   <inline asm>:28:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from drivers/staging/sm750fb/sm750_hw.c:6:
   In file included from include/linux/mm.h:29:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:112:
>> arch/riscv/include/asm/pgtable-64.h:109:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_IO);
           ^
   arch/riscv/include/asm/errata_list.h:46:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,     \
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
   <inline asm>:27:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from drivers/staging/sm750fb/sm750_hw.c:6:
   In file included from include/linux/mm.h:29:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:112:
>> arch/riscv/include/asm/pgtable-64.h:109:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_IO);
           ^
   arch/riscv/include/asm/errata_list.h:46:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,     \
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
   <inline asm>:28:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   4 errors generated.


vim +109 arch/riscv/include/asm/pgtable-64.h

   104	
   105	static inline u64 riscv_page_io(void)
   106	{
   107		u64 val;
   108	
 > 109		ALT_SVPBMT(val, _PAGE_IO);
   110		return val;
   111	}
   112	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

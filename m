Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C2E4DE123
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 19:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbiCRSjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 14:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239341AbiCRSjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:39:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57C91BBE09
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647628669; x=1679164669;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DhhdJGjd4r9GQBkrHmE+4nHlFwq/k81vexNmL4L2f6c=;
  b=PA8Hh1TAX/+/Nx+QO3E8hqVCSj50eGiOqD5f7htKBiYO9fF52u4Ceugs
   jiZFpBwAAcPRraxOXBeXq/qBN3bO9WVHBUrrC0LiYitqOsG2BIhDUlS1H
   PRVUD/aHVmbjwQ+K36yUZXGCZ0zJUmhSdTEh6WQ1YOsR027WhC3UrrOaN
   gRv/3W2DN1P1qNclqoS5AHxiFwOsdSaLGf91CVCzmwsH0LuzYn0IPB/fA
   9qOTzKgamvEIgyEMtUVxgBknuyCeIfPHHLJmEnVaRsOeyYryc/uWU7IZh
   OgQ6HHD0OWmjINe91wHafYcYDx4Sj2LPtjeyLeHxXkvfPbmN7lVEI9XN2
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="256023946"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="256023946"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="599609129"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 18 Mar 2022 11:37:46 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVHTt-000F3Q-UR; Fri, 18 Mar 2022 18:37:45 +0000
Date:   Sat, 19 Mar 2022 02:36:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wei Fu <wefu@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Liu Shaohua <liush@allwinnertech.com>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Subject: [ammarfaizi2-block:palmer/linux/riscv-d1-merge 17/20]
 arch/riscv/include/asm/pgtable-64.h:92:2: error: expected assembly-time
 absolute expression
Message-ID: <202203190244.24G89cJ9-lkp@intel.com>
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
commit: de8950b38c5be22611acbba781e7f0d298bc292b [17/20] riscv: add RISC-V Svpbmt extension support
config: riscv-randconfig-r042-20220318 (https://download.01.org/0day-ci/archive/20220319/202203190244.24G89cJ9-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6e70e4056dff962ec634c5bd4f2f4105a0bef71)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/de8950b38c5be22611acbba781e7f0d298bc292b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-d1-merge
        git checkout de8950b38c5be22611acbba781e7f0d298bc292b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/drm/msm/ drivers/iio/adc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/iio/adc/men_z188_adc.c:12:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:111:
>> arch/riscv/include/asm/pgtable-64.h:92:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_IO);
           ^
   arch/riscv/include/asm/errata_list.h:46:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,     \
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
   <inline asm>:25:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from drivers/iio/adc/men_z188_adc.c:12:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:111:
>> arch/riscv/include/asm/pgtable-64.h:92:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_IO);
           ^
   arch/riscv/include/asm/errata_list.h:46:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,     \
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
   <inline asm>:26:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from drivers/iio/adc/men_z188_adc.c:12:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:111:
>> arch/riscv/include/asm/pgtable-64.h:92:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_IO);
           ^
   arch/riscv/include/asm/errata_list.h:46:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,     \
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
   <inline asm>:25:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from drivers/iio/adc/men_z188_adc.c:12:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:111:
>> arch/riscv/include/asm/pgtable-64.h:92:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_IO);
           ^
   arch/riscv/include/asm/errata_list.h:46:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,     \
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
   <inline asm>:26:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   4 errors generated.
--
>> <inline asm>:25:6: error: expected assembly-time absolute expression
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   <inline asm>:26:6: error: expected assembly-time absolute expression
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from drivers/gpu/drm/msm/adreno/a6xx_gmu.c:9:
   In file included from include/drm/drm_gem.h:40:
   In file included from include/drm/drm_vma_manager.h:26:
   In file included from include/drm/drm_mm.h:51:
   In file included from include/drm/drm_print.h:31:
   In file included from include/linux/seq_file.h:12:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
   In file included from include/linux/uaccess.h:11:
   In file included from arch/riscv/include/asm/uaccess.h:12:
   In file included from arch/riscv/include/asm/pgtable.h:111:
   arch/riscv/include/asm/pgtable-64.h:76:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_MTMASK);
           ^
   arch/riscv/include/asm/errata_list.h:46:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,     \
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
   <inline asm>:25:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from drivers/gpu/drm/msm/adreno/a6xx_gmu.c:9:
   In file included from include/drm/drm_gem.h:40:
   In file included from include/drm/drm_vma_manager.h:26:
   In file included from include/drm/drm_mm.h:51:
   In file included from include/drm/drm_print.h:31:
   In file included from include/linux/seq_file.h:12:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
   In file included from include/linux/uaccess.h:11:
   In file included from arch/riscv/include/asm/uaccess.h:12:
   In file included from arch/riscv/include/asm/pgtable.h:111:
   arch/riscv/include/asm/pgtable-64.h:76:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_MTMASK);
           ^
   arch/riscv/include/asm/errata_list.h:46:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,     \
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
   <inline asm>:26:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from drivers/gpu/drm/msm/adreno/a6xx_gmu.c:9:
   In file included from include/drm/drm_gem.h:40:
   In file included from include/drm/drm_vma_manager.h:26:
   In file included from include/drm/drm_mm.h:51:
   In file included from include/drm/drm_print.h:31:
   In file included from include/linux/seq_file.h:12:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
   In file included from include/linux/uaccess.h:11:
   In file included from arch/riscv/include/asm/uaccess.h:12:
   In file included from arch/riscv/include/asm/pgtable.h:111:
>> arch/riscv/include/asm/pgtable-64.h:92:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_IO);
           ^
   arch/riscv/include/asm/errata_list.h:46:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,     \
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
   <inline asm>:25:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from drivers/gpu/drm/msm/adreno/a6xx_gmu.c:9:
   In file included from include/drm/drm_gem.h:40:
   In file included from include/drm/drm_vma_manager.h:26:
   In file included from include/drm/drm_mm.h:51:
   In file included from include/drm/drm_print.h:31:
   In file included from include/linux/seq_file.h:12:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
   In file included from include/linux/uaccess.h:11:
   In file included from arch/riscv/include/asm/uaccess.h:12:
   In file included from arch/riscv/include/asm/pgtable.h:111:
>> arch/riscv/include/asm/pgtable-64.h:92:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_IO);
           ^
   arch/riscv/include/asm/errata_list.h:46:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,     \
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
   <inline asm>:26:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
>> <inline asm>:25:6: error: expected assembly-time absolute expression
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   <inline asm>:26:6: error: expected assembly-time absolute expression
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from drivers/gpu/drm/msm/adreno/a6xx_gmu.c:9:
   In file included from include/drm/drm_gem.h:40:
   In file included from include/drm/drm_vma_manager.h:26:
   In file included from include/drm/drm_mm.h:51:
   In file included from include/drm/drm_print.h:31:
   In file included from include/linux/seq_file.h:12:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
   In file included from include/linux/uaccess.h:11:
   In file included from arch/riscv/include/asm/uaccess.h:12:
   In file included from arch/riscv/include/asm/pgtable.h:111:
   arch/riscv/include/asm/pgtable-64.h:76:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_MTMASK);
           ^
   arch/riscv/include/asm/errata_list.h:46:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,     \
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
   <inline asm>:25:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from drivers/gpu/drm/msm/adreno/a6xx_gmu.c:9:
   In file included from include/drm/drm_gem.h:40:
   In file included from include/drm/drm_vma_manager.h:26:
   In file included from include/drm/drm_mm.h:51:
   In file included from include/drm/drm_print.h:31:
   In file included from include/linux/seq_file.h:12:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
   In file included from include/linux/uaccess.h:11:
   In file included from arch/riscv/include/asm/uaccess.h:12:
   In file included from arch/riscv/include/asm/pgtable.h:111:
   arch/riscv/include/asm/pgtable-64.h:76:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_MTMASK);
           ^
   arch/riscv/include/asm/errata_list.h:46:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,     \
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
   <inline asm>:26:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from drivers/gpu/drm/msm/adreno/a6xx_gmu.c:9:
   In file included from include/drm/drm_gem.h:40:
   In file included from include/drm/drm_vma_manager.h:26:
   In file included from include/drm/drm_mm.h:51:
   In file included from include/drm/drm_print.h:31:
   In file included from include/linux/seq_file.h:12:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
   In file included from include/linux/uaccess.h:11:
   In file included from arch/riscv/include/asm/uaccess.h:12:
   In file included from arch/riscv/include/asm/pgtable.h:111:
>> arch/riscv/include/asm/pgtable-64.h:92:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_IO);
           ^
   arch/riscv/include/asm/errata_list.h:46:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,     \
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
   <inline asm>:25:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from drivers/gpu/drm/msm/adreno/a6xx_gmu.c:9:
   In file included from include/drm/drm_gem.h:40:
   In file included from include/drm/drm_vma_manager.h:26:
   In file included from include/drm/drm_mm.h:51:
   In file included from include/drm/drm_print.h:31:
   In file included from include/linux/seq_file.h:12:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
   In file included from include/linux/uaccess.h:11:
   In file included from arch/riscv/include/asm/uaccess.h:12:
   In file included from arch/riscv/include/asm/pgtable.h:111:
>> arch/riscv/include/asm/pgtable-64.h:92:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_IO);
           ^
   arch/riscv/include/asm/errata_list.h:46:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,     \
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
   <inline asm>:26:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   12 errors generated.


vim +92 arch/riscv/include/asm/pgtable-64.h

    87	
    88	static inline u64 riscv_page_io(void)
    89	{
    90		u64 val;
    91	
  > 92		ALT_SVPBMT(val, _PAGE_IO);
    93		return val;
    94	}
    95	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

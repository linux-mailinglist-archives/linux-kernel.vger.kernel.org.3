Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9C74ED253
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 06:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiCaETH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 00:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiCaES2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:18:28 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A5C27D568
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 21:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648699505; x=1680235505;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=za5ObnTOXo3sPWIYPG+Cvv2nAxKJ/yEy1XuyjsicTxI=;
  b=gC+GdutVX1/UoVbSWQpHgWmmOvTwb2Yc5FPRgIRffZJxK7Lu4gKuPDjx
   fQMmadXduIW6Zw6QclXUbejk5JgOyad3WW0EBleNA6mzpdKQjsKETCdaN
   PayzR0HBbVH9WLa0BIX+IthdlHwxtvYpK3nN0IDsrE/wtn0S2f+rXH2Y4
   4vF2BNZN/u5rH+l1Dv5uVabyN7+iYN98b1Q9sUg5ALXCeQ0bnmRTLuS+D
   Or5AWj1QMRfs349/Px/cPEYoihGFJhKgGoar+/ONqVvdRnDZ5AGshdUkJ
   TPKn80CKdSpMFtW013dOm+/wvvZkBSHNfa8YHdlH2j0wHytmlAkPg0wyw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="320406694"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="320406694"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 20:34:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="547123723"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 30 Mar 2022 20:34:53 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZlaG-0000oc-RB;
        Thu, 31 Mar 2022 03:34:52 +0000
Date:   Thu, 31 Mar 2022 11:34:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/kspp-stringop-overflow] BUILD SUCCESS WITH
 WARNING 3801f720ebf09ec3589982fba4138e83b4177fe1
Message-ID: <62452145.Nub6yx/W7/CoVUTo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/kspp-stringop-overflow
branch HEAD: 3801f720ebf09ec3589982fba4138e83b4177fe1  Makefile: Enable -Wstringop-overflow globally

Warning reports:

https://lore.kernel.org/lkml/202203301238.Yblbl2iM-lkp@intel.com
https://lore.kernel.org/lkml/202203301249.XsFY2ove-lkp@intel.com

Warning: (recently discovered and may have been fixed)

arch/m68k/amiga/config.c:453:56: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' writing 6 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
arch/m68k/q40/q40ints.c:137:26: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
cc1: warning: writing 4 bytes into a region of size between 18446744073709551613 and 2 [-Wstringop-overflow=]
include/linux/fortify-string.h:41:33: warning: '__builtin_memcpy' writing 512 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
include/linux/fortify-string.h:41:33: warning: '__builtin_memcpy' writing 6 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
sound/oss/dmasound/dmasound_q40.c:395:29: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]

Unverified Warning (likely false positive, please contact us if interested):

arch/s390/kernel/machine_kexec.c:57:9: warning: 'memcpy' writing 512 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
arch/sparc/include/asm/string.h:15:25: warning: '__builtin_memcpy' writing 6 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
arch/x86/mm/pgtable.c:442 pgd_alloc() error: uninitialized symbol 'pmds'.
arch/x86/mm/pgtable.c:442:27: warning: variable 'pmds' is uninitialized when used here [-Wuninitialized]
arch/x86/mm/pgtable.c:445 pgd_alloc() error: uninitialized symbol 'u_pmds'.
arch/x86/mm/pgtable.c:445:27: warning: variable 'u_pmds' is uninitialized when used here [-Wuninitialized]
arch/x86/mm/pgtable.c:459:31: warning: variable 'pmds' is uninitialized when used here [-Wuninitialized]
arch/x86/mm/pgtable.c:460:36: warning: variable 'u_pmds' is uninitialized when used here [-Wuninitialized]
cc1: warning: writing 16 bytes into a region of size 0 [-Wstringop-overflow=]
drivers/char/xillybus/xillybus_core.c:1059:50: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
drivers/infiniband/hw/mlx4/main.c:297:33: warning: writing 16 bytes into a region of size 0 [-Wstringop-overflow=]
drivers/mtd/nand/raw/nand_bbt.c:584:32: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
drivers/staging/r8188eu/core/rtw_recv.c:1233:9: warning: 'memcpy' writing 6 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
drivers/staging/rtl8723bs/core/rtw_recv.c:1559:9: warning: 'memcpy' writing 6 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
lib/test_kasan.c:274:49: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-randconfig-r043-20220328
|   |-- drivers-char-xillybus-xillybus_core.c:warning:writing-byte-into-a-region-of-size
|   `-- drivers-mtd-nand-raw-nand_bbt.c:warning:writing-byte-into-a-region-of-size
|-- arm64-randconfig-r023-20220329
|   `-- cc1:warning:writing-bytes-into-a-region-of-size
|-- i386-randconfig-m021-20220328
|   |-- arch-x86-mm-pgtable.c-pgd_alloc()-error:uninitialized-symbol-pmds-.
|   `-- arch-x86-mm-pgtable.c-pgd_alloc()-error:uninitialized-symbol-u_pmds-.
|-- m68k-allyesconfig
|   |-- arch-m68k-amiga-config.c:warning:writing-byte-into-a-region-of-size
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-writing-bytes-into-a-region-of-size-overflows-the-destination
|   |-- arch-m68k-q40-q40ints.c:warning:writing-byte-into-a-region-of-size
|   `-- sound-oss-dmasound-dmasound_q40.c:warning:writing-byte-into-a-region-of-size
|-- parisc-allyesconfig
|   `-- drivers-staging-rtl8723bs-core-rtw_recv.c:warning:memcpy-writing-bytes-into-a-region-of-size-overflows-the-destination
|-- parisc-randconfig-r011-20220327
|   `-- drivers-staging-r8188eu-core-rtw_recv.c:warning:memcpy-writing-bytes-into-a-region-of-size-overflows-the-destination
|-- powerpc-allyesconfig
|   |-- cc1:warning:writing-bytes-into-a-region-of-size-between-and
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-writing-bytes-into-a-region-of-size-overflows-the-destination
|-- s390-defconfig
|   |-- arch-s390-kernel-machine_kexec.c:warning:memcpy-writing-bytes-into-a-region-of-size-overflows-the-destination
|   `-- drivers-infiniband-hw-mlx4-main.c:warning:writing-bytes-into-a-region-of-size
|-- s390-randconfig-r044-20220327
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-writing-bytes-into-a-region-of-size-overflows-the-destination
|-- sparc-allyesconfig
|   `-- arch-sparc-include-asm-string.h:warning:__builtin_memcpy-writing-bytes-into-a-region-of-size-overflows-the-destination
|-- x86_64-randconfig-m001-20220328
|   |-- arch-x86-mm-pgtable.c-pgd_alloc()-error:uninitialized-symbol-pmds-.
|   `-- arch-x86-mm-pgtable.c-pgd_alloc()-error:uninitialized-symbol-u_pmds-.
`-- xtensa-allyesconfig
    `-- lib-test_kasan.c:warning:writing-byte-into-a-region-of-size

clang_recent_errors
|-- i386-allyesconfig
|   |-- arch-x86-mm-pgtable.c:warning:variable-pmds-is-uninitialized-when-used-here
|   `-- arch-x86-mm-pgtable.c:warning:variable-u_pmds-is-uninitialized-when-used-here
|-- i386-randconfig-a011-20220328
|   |-- arch-x86-mm-pgtable.c:warning:variable-pmds-is-uninitialized-when-used-here
|   `-- arch-x86-mm-pgtable.c:warning:variable-u_pmds-is-uninitialized-when-used-here
|-- i386-randconfig-a012-20220328
|   |-- arch-x86-mm-pgtable.c:warning:variable-pmds-is-uninitialized-when-used-here
|   `-- arch-x86-mm-pgtable.c:warning:variable-u_pmds-is-uninitialized-when-used-here
|-- i386-randconfig-a013-20220328
|   |-- arch-x86-mm-pgtable.c:warning:variable-pmds-is-uninitialized-when-used-here
|   `-- arch-x86-mm-pgtable.c:warning:variable-u_pmds-is-uninitialized-when-used-here
|-- i386-randconfig-a015-20220328
|   |-- arch-x86-mm-pgtable.c:warning:variable-pmds-is-uninitialized-when-used-here
|   `-- arch-x86-mm-pgtable.c:warning:variable-u_pmds-is-uninitialized-when-used-here
|-- i386-randconfig-a016-20220328
|   |-- arch-x86-mm-pgtable.c:warning:variable-pmds-is-uninitialized-when-used-here
|   `-- arch-x86-mm-pgtable.c:warning:variable-u_pmds-is-uninitialized-when-used-here
|-- x86_64-randconfig-a011-20220328
|   |-- arch-x86-mm-pgtable.c:warning:variable-pmds-is-uninitialized-when-used-here
|   `-- arch-x86-mm-pgtable.c:warning:variable-u_pmds-is-uninitialized-when-used-here
|-- x86_64-randconfig-a012-20220328
|   |-- arch-x86-mm-pgtable.c:warning:variable-pmds-is-uninitialized-when-used-here
|   `-- arch-x86-mm-pgtable.c:warning:variable-u_pmds-is-uninitialized-when-used-here
|-- x86_64-randconfig-a013-20220328
|   |-- arch-x86-mm-pgtable.c:warning:variable-pmds-is-uninitialized-when-used-here
|   `-- arch-x86-mm-pgtable.c:warning:variable-u_pmds-is-uninitialized-when-used-here
|-- x86_64-randconfig-a014-20220328
|   |-- arch-x86-mm-pgtable.c:warning:variable-pmds-is-uninitialized-when-used-here
|   `-- arch-x86-mm-pgtable.c:warning:variable-u_pmds-is-uninitialized-when-used-here
|-- x86_64-randconfig-a015-20220328
|   |-- arch-x86-mm-pgtable.c:warning:variable-pmds-is-uninitialized-when-used-here
|   `-- arch-x86-mm-pgtable.c:warning:variable-u_pmds-is-uninitialized-when-used-here
`-- x86_64-randconfig-a016-20220328
    |-- arch-x86-mm-pgtable.c:warning:variable-pmds-is-uninitialized-when-used-here
    `-- arch-x86-mm-pgtable.c:warning:variable-u_pmds-is-uninitialized-when-used-here

elapsed time: 1586m

configs tested: 108
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220330
m68k                            q40_defconfig
sh                         microdev_defconfig
nios2                         10m50_defconfig
mips                      fuloong2e_defconfig
arm                         nhk8815_defconfig
arc                        nsim_700_defconfig
arc                          axs101_defconfig
sparc                       sparc32_defconfig
mips                         tb0226_defconfig
sh                          rsk7269_defconfig
powerpc                      tqm8xx_defconfig
arm                            pleb_defconfig
mips                        vocore2_defconfig
arm                         s3c6400_defconfig
arm                  randconfig-c002-20220329
arm                  randconfig-c002-20220327
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a004-20220328
i386                 randconfig-a002-20220328
i386                 randconfig-a003-20220328
i386                 randconfig-a001-20220328
i386                 randconfig-a006-20220328
i386                 randconfig-a005-20220328
x86_64               randconfig-a001-20220328
x86_64               randconfig-a003-20220328
x86_64               randconfig-a002-20220328
x86_64               randconfig-a005-20220328
x86_64               randconfig-a004-20220328
x86_64               randconfig-a006-20220328
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
mips                       lemote2f_defconfig
arm                       imx_v4_v5_defconfig
mips                     loongson1c_defconfig
arm                       spear13xx_defconfig
i386                             allyesconfig
riscv                            alldefconfig
x86_64               randconfig-a011-20220328
x86_64               randconfig-a013-20220328
x86_64               randconfig-a012-20220328
x86_64               randconfig-a014-20220328
x86_64               randconfig-a016-20220328
x86_64               randconfig-a015-20220328
i386                 randconfig-a012-20220328
i386                 randconfig-a011-20220328
i386                 randconfig-a015-20220328
i386                 randconfig-a016-20220328
i386                 randconfig-a014-20220328
i386                 randconfig-a013-20220328
riscv                randconfig-r042-20220328
hexagon              randconfig-r045-20220329
hexagon              randconfig-r045-20220328
hexagon              randconfig-r045-20220327
hexagon              randconfig-r041-20220327
hexagon              randconfig-r041-20220329
hexagon              randconfig-r041-20220328

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B3753594A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245359AbiE0G0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245234AbiE0G0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:26:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF323136F
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653632780; x=1685168780;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VYrISHMpZxLFPHAMp7gbsDiWLPJ6vxJu+9WjbDLqvbk=;
  b=EiDhmRJFvGB2xJlswFiiXPkmLNn+C7yfprZUGDkzXVtqw1r31n0e2uid
   l1gpJv2HwN9fQJqLLBR42mwXbVscIrPMc//pXoGpRpgU5Rw1q8Jgw4Cs8
   ei+NENl4ZDWyCtQvL5aTHVOQegMRmcc/J0t7B7k0UKoaDrNM/z6suuAVA
   h281QBCcoYLd3P5+EWM5Yrb9FfkphgAmNvmB+Dtw2dB8DD5uApyvmJXdx
   W0cxok8oVuRbqoF+2oi009HoCRfjIB9llFaM0fBXCyBC9j+VaqZKHk55N
   6C7THjWNJT5fFXgbgztXA34eE1TSuFCrwBogbc+n+w9lVIbQxJGkS1k8j
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274496197"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="274496197"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 23:26:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="603693238"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 May 2022 23:26:17 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuTQP-0004UL-72;
        Fri, 27 May 2022 06:26:17 +0000
Date:   Fri, 27 May 2022 14:25:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.05.23b] BUILD REGRESSION
 29fe03d9190c37a93b96078e34ddd95344ef8b0f
Message-ID: <62906edd.lp8wycKWE9fbrvKY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.05.23b
branch HEAD: 29fe03d9190c37a93b96078e34ddd95344ef8b0f  Revert "rcu-tasks: Remove rcu_tasks_trace_postgp() wait for counter"

Error/Warning reports:

https://lore.kernel.org/lkml/202205270440.Slefdogz-lkp@intel.com
https://lore.kernel.org/lkml/202205270626.brEm5KpN-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/powerpc/include/asm/cmpxchg.h:474:6: error: cast to union type from type not present in union
arch/s390/include/asm/cmpxchg.h:160:17: error: cast to union type from type not present in union
include/asm-generic/cmpxchg.h:92:10: error: cast to union type from type not present in union

Unverified Error/Warning (likely false positive, please contact us if interested):

arch/arm/include/asm/cmpxchg.h:138:9: error: cast to union type from type not present in union
arch/arm/include/asm/cmpxchg.h:211:9: error: cast to union type from type not present in union
arch/arm64/include/asm/cmpxchg.h:182:17: error: cast to union type from type not present in union
arch/openrisc/include/asm/cmpxchg.h:137:17: error: cast to union type from type not present in union
arch/sparc/include/asm/cmpxchg_32.h:62:9: error: cast to union type from type not present in union
arch/sparc/include/asm/cmpxchg_64.h:175:6: error: cast to union type from type not present in union
kernel/rcu/tasks.h:1243:6: error: assigning to 'union rcu_special' from incompatible type 'void'
kernel/rcu/tasks.h:1243:8: error: initializing 'typeof (*(__ai_ptr))' (aka 'union rcu_special') with an expression of incompatible type 'int'
kernel/rcu/tasks.h:1243:8: error: operand of type 'typeof (*((__ai_ptr)))' (aka 'union rcu_special') where arithmetic or pointer type is required
kernel/rcu/tasks.h:1243:8: error: operand of type 'union rcu_special' where arithmetic or pointer type is required
kernel/rcu/tasks.h:1243:8: error: variable has incomplete type 'typeof (({
kernel/rcu/tasks.h:1243:9: error: aggregate value used where an integer was expected

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allmodconfig
|   `-- arch-arm-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|-- arm-allyesconfig
|   `-- arch-arm-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|-- arm-randconfig-r006-20220524
|   `-- arch-arm-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|-- arm64-defconfig
|   `-- kernel-rcu-tasks.h:error:aggregate-value-used-where-an-integer-was-expected
|-- arm64-randconfig-r022-20220524
|   `-- arch-arm64-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|-- h8300-randconfig-r006-20220524
|   |-- include-asm-generic-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|   `-- kernel-rcu-tasks.h:error:aggregate-value-used-where-an-integer-was-expected
|-- ia64-allmodconfig
|   `-- kernel-rcu-tasks.h:error:aggregate-value-used-where-an-integer-was-expected
|-- ia64-allyesconfig
|   `-- kernel-rcu-tasks.h:error:aggregate-value-used-where-an-integer-was-expected
|-- m68k-buildonly-randconfig-r001-20220524
|   `-- include-asm-generic-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|-- m68k-buildonly-randconfig-r006-20220524
|   `-- include-asm-generic-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|-- microblaze-buildonly-randconfig-r001-20220524
|   `-- include-asm-generic-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|-- nios2-allyesconfig
|   `-- include-asm-generic-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|-- nios2-randconfig-r001-20220524
|   `-- include-asm-generic-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|-- openrisc-randconfig-r025-20220524
|   `-- arch-openrisc-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|-- powerpc-allyesconfig
|   `-- arch-powerpc-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|-- riscv-allmodconfig
|   `-- kernel-rcu-tasks.h:error:aggregate-value-used-where-an-integer-was-expected
|-- riscv-defconfig
|   `-- kernel-rcu-tasks.h:error:aggregate-value-used-where-an-integer-was-expected
|-- riscv-rv32_defconfig
|   `-- kernel-rcu-tasks.h:error:aggregate-value-used-where-an-integer-was-expected
|-- s390-allmodconfig
|   `-- arch-s390-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|-- s390-allyesconfig
|   |-- arch-s390-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|   `-- kernel-rcu-tasks.h:error:aggregate-value-used-where-an-integer-was-expected
|-- s390-defconfig
|   `-- arch-s390-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|-- s390-randconfig-r044-20220524
|   `-- arch-s390-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|-- sparc-allyesconfig
|   |-- arch-sparc-include-asm-cmpxchg_64.h:error:cast-to-union-type-from-type-not-present-in-union
|   `-- kernel-rcu-tasks.h:error:aggregate-value-used-where-an-integer-was-expected
|-- sparc-randconfig-r021-20220524
|   `-- arch-sparc-include-asm-cmpxchg_32.h:error:cast-to-union-type-from-type-not-present-in-union
`-- sparc64-randconfig-r006-20220524
    `-- arch-sparc-include-asm-cmpxchg_64.h:error:cast-to-union-type-from-type-not-present-in-union

clang_recent_errors
|-- arm-buildonly-randconfig-r004-20220524
|   `-- kernel-rcu-tasks.h:error:assigning-to-union-rcu_special-from-incompatible-type-void
|-- arm-randconfig-r035-20220525
|   |-- kernel-rcu-tasks.h:error:operand-of-type-union-rcu_special-where-arithmetic-or-pointer-type-is-required
|   `-- kernel-rcu-tasks.h:error:variable-has-incomplete-type-typeof-((
|-- hexagon-randconfig-r002-20220524
|   `-- kernel-rcu-tasks.h:error:initializing-typeof-(-(__ai_ptr))-(aka-union-rcu_special-)-with-an-expression-of-incompatible-type-int
|-- hexagon-randconfig-r003-20220524
|   `-- kernel-rcu-tasks.h:error:initializing-typeof-(-(__ai_ptr))-(aka-union-rcu_special-)-with-an-expression-of-incompatible-type-int
|-- hexagon-randconfig-r045-20220524
|   `-- kernel-rcu-tasks.h:error:initializing-typeof-(-(__ai_ptr))-(aka-union-rcu_special-)-with-an-expression-of-incompatible-type-int
|-- mips-randconfig-r022-20220524
|   `-- kernel-rcu-tasks.h:error:operand-of-type-typeof-(-((__ai_ptr)))-(aka-union-rcu_special-)-where-arithmetic-or-pointer-type-is-required
|-- riscv-randconfig-r003-20220524
|   `-- kernel-rcu-tasks.h:error:operand-of-type-typeof-(-((__ai_ptr)))-(aka-union-rcu_special-)-where-arithmetic-or-pointer-type-is-required
`-- s390-randconfig-r002-20220524
    `-- kernel-rcu-tasks.h:error:operand-of-type-union-rcu_special-where-arithmetic-or-pointer-type-is-required

elapsed time: 723m

configs tested: 104
configs skipped: 3

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
arm                            mps2_defconfig
arm                         assabet_defconfig
sh                          polaris_defconfig
powerpc                      pcm030_defconfig
mips                         db1xxx_defconfig
m68k                       m5249evb_defconfig
powerpc                 linkstation_defconfig
riscv                    nommu_k210_defconfig
mips                 decstation_r4k_defconfig
sh                            hp6xx_defconfig
arm                        trizeps4_defconfig
s390                       zfcpdump_defconfig
ia64                                defconfig
ia64                             allmodconfig
m68k                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220526
arc                  randconfig-r043-20220524
riscv                randconfig-r042-20220524
s390                 randconfig-r044-20220524
riscv                randconfig-r042-20220526
s390                 randconfig-r044-20220526
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                  mpc885_ads_defconfig
powerpc                      walnut_defconfig
mips                       rbtx49xx_defconfig
mips                         tb0287_defconfig
powerpc                      obs600_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r045-20220524
hexagon              randconfig-r045-20220526
hexagon              randconfig-r041-20220526
hexagon              randconfig-r041-20220524

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0450A53B45F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiFBHde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 03:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiFBHd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:33:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41B43982A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 00:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654155207; x=1685691207;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dIZjgV+stC2Xb3Ta2CqapMLYo4xfU6Ojq3iNkLI3uvw=;
  b=KRDKqPN+YSuJR4EM7/Fil1n0oskpTj3ND0W+lzjA9aF1Jb/yW+qa8akf
   TCkBaM5NOa32/IDxEkStRTkL/fLhNkzFS8j+ox57gmEVtxxj5oRL8pDCE
   t45xk27VDUeD/RHK8ZSw9rMcTfDjAwNdLzbfFpNebCXTkfKIHyx23YSa7
   4RA+X8hfe+qpeCDsS8En5kbB5bT7Wu38iXxDhjxGCMFH/Z8BuHltVS35s
   CwA6axclYzUeFf04Dz9g3+REkA5FfdGF1HUHt6U4ljxop+yynU+AtqzS2
   /ZhrkOJ48iIIhoCjAb+7bropeJyv3BVuVt0pBiCsUDEUyO9NOkcPjZM9S
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="362232837"
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="362232837"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 00:33:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="612701083"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 02 Jun 2022 00:33:15 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwfKU-0004qD-NQ;
        Thu, 02 Jun 2022 07:33:14 +0000
Date:   Thu, 02 Jun 2022 15:32:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.05.26a] BUILD REGRESSION
 2ba9ea99370a332f696257f3e4ab417d883f1aa4
Message-ID: <629867a8.4CyAPoTD53JAwVmA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.05.26a
branch HEAD: 2ba9ea99370a332f696257f3e4ab417d883f1aa4  fixup! rcu-tasks: Handle idle tasks for recently offlined CPUs

Unverified Error/Warning (likely false positive, please contact us if interested):

ERROR: modpost: "rcu_trc_cmpxchg_need_qs" [kernel/rcu/rcuscale.ko] undefined!
ERROR: modpost: "rcu_trc_cmpxchg_need_qs" [kernel/torture.ko] undefined!
arch/alpha/include/asm/cmpxchg.h:62:17: error: cast to union type from type not present in union
arch/arm/include/asm/cmpxchg.h:211:9: error: cast to union type from type not present in union
arch/arm64/include/asm/cmpxchg.h:182:17: error: cast to union type from type not present in union
arch/m68k/include/asm/cmpxchg.h:121:11: error: cast to union type from type not present in union
arch/parisc/include/asm/cmpxchg.h:85:9: error: cast to union type from type not present in union
arch/powerpc/include/asm/cmpxchg.h:474:6: error: cast to union type from type not present in union
arch/s390/include/asm/cmpxchg.h:160:17: error: cast to union type from type not present in union
arch/sparc/include/asm/cmpxchg_64.h:175:6: error: cast to union type from type not present in union
include/asm-generic/cmpxchg.h:92:10: error: cast to union type from type not present in union
include/linux/atomic/atomic-instrumented.h:1912:1: error: incompatible types when assigning to type 'union rcu_special' from type 'int'
kernel/rcu/tasks.h:1243:8: error: initializing 'typeof (*(__ai_ptr))' (aka 'union rcu_special') with an expression of incompatible type 'int'
kernel/rcu/tasks.h:1243:8: error: operand of type 'union rcu_special' where arithmetic or pointer type is required
kernel/rcu/tasks.h:1243:9: error: aggregate value used where an integer was expected

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- arch-alpha-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|-- arm-randconfig-r005-20220531
|   |-- arch-arm-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|   `-- include-linux-atomic-atomic-instrumented.h:error:incompatible-types-when-assigning-to-type-union-rcu_special-from-type-int
|-- arm64-randconfig-r013-20220531
|   `-- arch-arm64-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|-- i386-randconfig-a003
|   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-rcu-rcuscale.ko-undefined
|   `-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-torture.ko-undefined
|-- m68k-allmodconfig
|   `-- arch-m68k-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|-- m68k-defconfig
|   |-- include-asm-generic-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|   `-- kernel-rcu-tasks.h:error:aggregate-value-used-where-an-integer-was-expected
|-- parisc-allyesconfig
|   `-- arch-parisc-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|-- powerpc-allyesconfig
|   `-- arch-powerpc-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|-- s390-randconfig-r044-20220531
|   `-- arch-s390-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
|-- sparc-allyesconfig
|   `-- arch-sparc-include-asm-cmpxchg_64.h:error:cast-to-union-type-from-type-not-present-in-union
`-- x86_64-randconfig-a004
    |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-rcu-rcuscale.ko-undefined
    `-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-torture.ko-undefined

clang_recent_errors
|-- arm64-buildonly-randconfig-r002-20220531
|   `-- kernel-rcu-tasks.h:error:operand-of-type-union-rcu_special-where-arithmetic-or-pointer-type-is-required
`-- hexagon-randconfig-r033-20220531
    `-- kernel-rcu-tasks.h:error:initializing-typeof-(-(__ai_ptr))-(aka-union-rcu_special-)-with-an-expression-of-incompatible-type-int

elapsed time: 741m

configs tested: 84
configs skipped: 3

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm64                               defconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
arc                                 defconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
parisc64                            defconfig
nios2                               defconfig
arc                              allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220531
riscv                randconfig-r042-20220531
s390                 randconfig-r044-20220531
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220531
hexagon              randconfig-r045-20220531

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

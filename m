Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE626506834
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 12:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348472AbiDSKEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 06:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiDSKEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:04:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4462012A88
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 03:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650362508; x=1681898508;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uKDBpVTAENxOBNzmr+R5zbaHJC/AWRj7MvcfFxcLDIE=;
  b=NU9U/78sJcQaqyVutPPjOZ3PdjKDdoo4+W0JlSAPo5qu0DRKGgrw0L8m
   n828SqhlZroUL0lAo5SO8xic6jW9BKoYoBJwtHMYGBXTXKMWc0ngQV1jN
   RXRU9mVkrdiUpdT+IK0/rO8EFAFfr/qD+sQPHGxQpZV9UhhHwD+Ep+KKh
   yUDeitRZg5OXW4nrwCnyDuors12nN2J+lGKIV6ObXNECMfqYmvKievsOV
   FNof5CXGdWeaZQK+otzAioMtFdNMPWx5xOoNCNRv2Pb6dAWV52uQXVUT7
   WWvkntSe9PlMdsrfrfzswqQB85/rPua06h78yhR3IxdjI8xOQ8LfscA83
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="326626616"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="326626616"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 03:01:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="510083204"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Apr 2022 03:01:45 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngkg5-0005cs-2w;
        Tue, 19 Apr 2022 10:01:45 +0000
Date:   Tue, 19 Apr 2022 18:00:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.04.16a] BUILD REGRESSION
 21b595e4233e6885bdea2819c206a470cc207ea5
Message-ID: <625e8854.9Z61O5qYHrqU2x7p%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.04.16a
branch HEAD: 21b595e4233e6885bdea2819c206a470cc207ea5  rcu/nocb: Add an option to offload all CPUs on boot

Error/Warning reports:

https://lore.kernel.org/lkml/202204191137.9uki6akh-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

kernel/rcu/tree_nocb.h:1162:14: error: 'rcu_nocb_is_setup' undeclared (first use in this function); did you mean 'rcu_nocb_setup'?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- alpha-allyesconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- arc-allyesconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- arm-allmodconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- arm-allyesconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- arm64-allyesconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- i386-allyesconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- ia64-allmodconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- ia64-allyesconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- mips-allmodconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- mips-allyesconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- parisc-allyesconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- riscv-allmodconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- riscv-allyesconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- s390-allmodconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- s390-allyesconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
|-- sparc-allyesconfig
|   `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)
`-- x86_64-allyesconfig
    `-- kernel-rcu-tree_nocb.h:error:rcu_nocb_is_setup-undeclared-(first-use-in-this-function)

elapsed time: 872m

configs tested: 134
configs skipped: 3

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20220418
sparc                       sparc32_defconfig
xtensa                  cadence_csp_defconfig
mips                            ar7_defconfig
powerpc                     pq2fads_defconfig
powerpc                 mpc834x_mds_defconfig
sparc                       sparc64_defconfig
powerpc                 mpc8540_ads_defconfig
sh                     magicpanelr2_defconfig
nios2                               defconfig
sh                          landisk_defconfig
arm                        shmobile_defconfig
sparc64                          alldefconfig
microblaze                      mmu_defconfig
parisc                           alldefconfig
xtensa                  nommu_kc705_defconfig
m68k                          hp300_defconfig
sh                            hp6xx_defconfig
mips                         cobalt_defconfig
powerpc                      pasemi_defconfig
s390                       zfcpdump_defconfig
powerpc64                        alldefconfig
sh                        edosk7760_defconfig
sh                        apsh4ad0a_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                       bmips_be_defconfig
sh                          urquell_defconfig
arm                  randconfig-c002-20220418
x86_64               randconfig-c001-20220418
arm                  randconfig-c002-20220417
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
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
x86_64               randconfig-a003-20220418
x86_64               randconfig-a004-20220418
x86_64               randconfig-a006-20220418
x86_64               randconfig-a001-20220418
x86_64               randconfig-a002-20220418
x86_64               randconfig-a005-20220418
i386                 randconfig-a004-20220418
i386                 randconfig-a001-20220418
i386                 randconfig-a003-20220418
i386                 randconfig-a005-20220418
i386                 randconfig-a006-20220418
i386                 randconfig-a002-20220418
arc                  randconfig-r043-20220418
arc                  randconfig-r043-20220417
riscv                randconfig-r042-20220417
s390                 randconfig-r044-20220417
arc                  randconfig-r043-20220419
s390                 randconfig-r044-20220419
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
mips                     cu1000-neo_defconfig
arm                            dove_defconfig
mips                         tb0219_defconfig
powerpc                    mvme5100_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     pseries_defconfig
mips                   sb1250_swarm_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     kmeter1_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a016-20220418
x86_64               randconfig-a012-20220418
x86_64               randconfig-a013-20220418
x86_64               randconfig-a014-20220418
x86_64               randconfig-a015-20220418
x86_64               randconfig-a011-20220418
i386                 randconfig-a011-20220418
i386                 randconfig-a015-20220418
i386                 randconfig-a016-20220418
i386                 randconfig-a012-20220418
i386                 randconfig-a013-20220418
i386                 randconfig-a014-20220418
hexagon              randconfig-r041-20220417
hexagon              randconfig-r041-20220418
hexagon              randconfig-r045-20220417
s390                 randconfig-r044-20220418
riscv                randconfig-r042-20220418
hexagon              randconfig-r045-20220418

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

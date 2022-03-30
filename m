Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC564EC550
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbiC3NPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344304AbiC3NPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:15:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD0D110F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648646008; x=1680182008;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=md34CbOmrYvcdZqOoeqVQTjr9uRxMUd+WE/OgzKyhHc=;
  b=DGPZloWtg3N7TPR77Vluhte4QiEnwBLBsY8LIvJCRxeXz/GRFbtnOS/u
   /WYpi1UvmP+bcgL0fazEBw9r7BvB5PdE7vl82W7QnmePCJxAiGTF1hT2Y
   pT6XTxR3SzVE2/S8HxHASXM267fkM0mlkTpiKTX1xLbSuPhYTH41wgVq+
   kyJVGrV63TdJ34mrESNNlS22MnnFEnP4edODCqSjVLU81BWeyq+uec/p1
   6qdCcBVLoSOzIcvw6dfVJzQsghiZFT98hokaY7NIled8LPCByiU2F/S18
   h+uEnXRhLzm5fK8LxXfWDIntOkYJNuw/Tt4oAK5dut5EHSmqHKiGxqjwl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="247037861"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="247037861"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 06:13:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="519671175"
Received: from lkp-server02.sh.intel.com (HELO 1905232cd9fb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 30 Mar 2022 06:13:26 -0700
Received: from kbuild by 1905232cd9fb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZY8c-00003N-5W;
        Wed, 30 Mar 2022 13:13:26 +0000
Date:   Wed, 30 Mar 2022 21:13:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.03.24a] BUILD SUCCESS
 b89e06a95c05009bcf31949814c42bc420f414a6
Message-ID: <62445761.3X5YPVhQWldhfog1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.03.24a
branch HEAD: b89e06a95c05009bcf31949814c42bc420f414a6  rcu_sync: Fix comment to properly reflect rcu_sync_exit() behavior

elapsed time: 725m

configs tested: 151
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220330
sh                          landisk_defconfig
sh                        edosk7760_defconfig
powerpc                     rainier_defconfig
um                             i386_defconfig
xtensa                    smp_lx200_defconfig
arm                        mini2440_defconfig
sh                           se7619_defconfig
sh                          lboxre2_defconfig
powerpc                    klondike_defconfig
sparc                       sparc64_defconfig
sh                          rsk7201_defconfig
arm                        clps711x_defconfig
arm                            xcep_defconfig
arm                          badge4_defconfig
powerpc                    sam440ep_defconfig
mips                            ar7_defconfig
arm                            hisi_defconfig
ia64                            zx1_defconfig
sh                         ecovec24_defconfig
arm                             pxa_defconfig
arc                                 defconfig
i386                                defconfig
mips                           xway_defconfig
xtensa                       common_defconfig
sh                            hp6xx_defconfig
arc                          axs101_defconfig
sparc                       sparc32_defconfig
openrisc                            defconfig
sh                            titan_defconfig
powerpc                     tqm8548_defconfig
arm                      integrator_defconfig
sh                          urquell_defconfig
sh                          kfr2r09_defconfig
mips                           ip32_defconfig
sh                            migor_defconfig
arm                            pleb_defconfig
arm                         s3c6400_defconfig
mips                        vocore2_defconfig
sh                   sh7724_generic_defconfig
mips                         bigsur_defconfig
sh                        sh7757lcr_defconfig
arm                  randconfig-c002-20220329
arm                  randconfig-c002-20220327
arm                  randconfig-c002-20220330
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a001-20220328
i386                 randconfig-a003-20220328
i386                 randconfig-a006-20220328
i386                 randconfig-a005-20220328
i386                 randconfig-a004-20220328
i386                 randconfig-a002-20220328
x86_64               randconfig-a001-20220328
x86_64               randconfig-a003-20220328
x86_64               randconfig-a002-20220328
x86_64               randconfig-a005-20220328
x86_64               randconfig-a004-20220328
x86_64               randconfig-a006-20220328
riscv                randconfig-r042-20220330
s390                 randconfig-r044-20220330
arc                  randconfig-r043-20220330
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
powerpc                     mpc5200_defconfig
arm                     am200epdkit_defconfig
mips                   sb1250_swarm_defconfig
powerpc                   lite5200b_defconfig
powerpc                     kilauea_defconfig
riscv                            alldefconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a016-20220328
x86_64               randconfig-a012-20220328
x86_64               randconfig-a011-20220328
x86_64               randconfig-a014-20220328
x86_64               randconfig-a013-20220328
x86_64               randconfig-a015-20220328
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                 randconfig-a015-20220328
i386                 randconfig-a016-20220328
i386                 randconfig-a011-20220328
i386                 randconfig-a012-20220328
i386                 randconfig-a014-20220328
i386                 randconfig-a013-20220328
riscv                randconfig-r042-20220328
hexagon              randconfig-r045-20220329
hexagon              randconfig-r045-20220328
hexagon              randconfig-r045-20220327
hexagon              randconfig-r041-20220327
hexagon              randconfig-r045-20220330
hexagon              randconfig-r041-20220329
hexagon              randconfig-r041-20220328
hexagon              randconfig-r041-20220330

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA714ECC40
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350476AbiC3S3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350466AbiC3S3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:29:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97461DA5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648664787; x=1680200787;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GNwwe4gVp3OpPaPwuCW93ogK22+vVK5mATybqyOWT5c=;
  b=ESHvs9T54Rs8znewnRDOqsShWHAzYlY8A0dqKHO8h1m33bmDffHZIEwa
   zLcZlduShKFvy7pezx7dOZz21dhLReJ+wKRjvxUDwehhTO7Mg4SD8NSxl
   9XxcgiEIlwMzTT329fd/QVN5B3KlHNV5x2EuLCM+K3oz1f2A1BszZpHOX
   yaryOxnlNS9bmOGooqaZnWXm+6PLmipeavVVZLi5zinuE5wFCagWp8iQ0
   bSa7EScTxStg4NbE3PLkJmWdFGYb/i4sj/iaJvMATejxnUG1uHSkLtcA/
   s5O6+6O9LOuocGc6oRJJ7G/w9h44Kq4UtM/kR35gTwPu8a0qu7V4JUN7x
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="322796626"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="322796626"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 11:26:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="639821962"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Mar 2022 11:26:24 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZd1U-0000Hl-3n;
        Wed, 30 Mar 2022 18:26:24 +0000
Date:   Thu, 31 Mar 2022 02:22:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.03.29a] BUILD SUCCESS
 72ee6272c2a01687f3774f445574708452738302
Message-ID: <6244a000.SmzmYoSnnquca2IG%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.03.29a
branch HEAD: 72ee6272c2a01687f3774f445574708452738302  rcu_sync: Fix comment to properly reflect rcu_sync_exit() behavior

elapsed time: 998m

configs tested: 160
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
powerpc                    klondike_defconfig
sparc                       sparc64_defconfig
sh                          rsk7201_defconfig
arm                        clps711x_defconfig
arm                            xcep_defconfig
arm                          badge4_defconfig
m68k                       m5208evb_defconfig
arc                 nsimosci_hs_smp_defconfig
xtensa                          iss_defconfig
arm                           tegra_defconfig
powerpc                    sam440ep_defconfig
mips                            ar7_defconfig
arm                            hisi_defconfig
ia64                            zx1_defconfig
sh                         ecovec24_defconfig
mips                  maltasmvp_eva_defconfig
ia64                        generic_defconfig
sh                           se7619_defconfig
powerpc64                        alldefconfig
arm                             pxa_defconfig
arc                                 defconfig
i386                                defconfig
mips                           xway_defconfig
xtensa                       common_defconfig
sh                            hp6xx_defconfig
h8300                       h8s-sim_defconfig
parisc                           alldefconfig
sh                     magicpanelr2_defconfig
m68k                            q40_defconfig
arm                        shmobile_defconfig
powerpc                     sequoia_defconfig
arm                      integrator_defconfig
sh                          urquell_defconfig
sh                          kfr2r09_defconfig
mips                           ip32_defconfig
sh                            migor_defconfig
m68k                          hp300_defconfig
arm                         axm55xx_defconfig
sh                ecovec24-romimage_defconfig
sh                   sh7724_generic_defconfig
mips                         bigsur_defconfig
sh                        sh7757lcr_defconfig
arm                  randconfig-c002-20220330
arm                  randconfig-c002-20220327
arm                  randconfig-c002-20220329
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
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
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
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                 randconfig-a001-20220328
i386                 randconfig-a003-20220328
i386                 randconfig-a006-20220328
i386                 randconfig-a005-20220328
i386                 randconfig-a004-20220328
i386                 randconfig-a002-20220328
x86_64               randconfig-a001-20220328
x86_64               randconfig-a003-20220328
x86_64               randconfig-a004-20220328
x86_64               randconfig-a002-20220328
x86_64               randconfig-a005-20220328
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
mips                 randconfig-c004-20220330
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220330
riscv                randconfig-c006-20220330
i386                          randconfig-c001
arm                  randconfig-c002-20220330
powerpc                      obs600_defconfig
hexagon                          alldefconfig
arm                         s5pv210_defconfig
arm                     am200epdkit_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                     loongson2k_defconfig
mips                     loongson1c_defconfig
powerpc                     mpc5200_defconfig
mips                   sb1250_swarm_defconfig
powerpc                   lite5200b_defconfig
powerpc                     kilauea_defconfig
mips                         tb0219_defconfig
mips                      bmips_stb_defconfig
mips                       lemote2f_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB2B4D721A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 02:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbiCMBa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 20:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiCMBaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 20:30:55 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C4D58E5E
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 17:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647134988; x=1678670988;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=eJve1ALW93KfVL0AvbexGTNXfe28gG3mtwA2c4RG9s8=;
  b=lu0TnU8PM3BkI5r56UkU4xLL5vFd7SCXL8musZ/XD0C9bzN8X9nJjMe6
   3nHU+8guRpqq5MU1/JPcvPIzBXKqFLSaPGHxHMhrC/JwZsqlIlOGe4PeI
   U2lNNJWvydGfcqnopDQ8G5TD/eSi9L28un3fBw4ou9SUkG4NOHYZxoYMs
   9ONozFHgOk0ht2sWPYPqgFQEoQZskvANaDENpkB6oIdKmNdGZ3RJN6h9N
   mqjyWEgRQ9ZTLyfCK7nFRtk3emXkzKFMcELpGaknBONN5J2W0zTqIwCO3
   NDxB/QjBkT2EGr2MrljtBeVKeIERRHgmuDy5w7nrcz/R8naLZa9pWz9vB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="255783398"
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="255783398"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 17:29:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="713299439"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Mar 2022 17:29:46 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTD3J-0008Sl-CM; Sun, 13 Mar 2022 01:29:45 +0000
Date:   Sun, 13 Mar 2022 09:28:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 f2aa197e4794bf4c2c0c9570684f86e6fa103e8b
Message-ID: <622d48d2.NAITR0haa/YPeTyR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: f2aa197e4794bf4c2c0c9570684f86e6fa103e8b  cgroup: Fix suspicious rcu_dereference_check() usage warning

elapsed time: 723m

configs tested: 160
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
m68k                          sun3x_defconfig
nds32                            alldefconfig
sh                          rsk7201_defconfig
powerpc                 mpc837x_rdb_defconfig
m68k                       bvme6000_defconfig
sh                   sh7724_generic_defconfig
x86_64                           alldefconfig
powerpc                      mgcoge_defconfig
m68k                        mvme16x_defconfig
arm                        trizeps4_defconfig
arm                          lpd270_defconfig
sh                ecovec24-romimage_defconfig
sh                        edosk7760_defconfig
mips                         tb0226_defconfig
sh                            hp6xx_defconfig
m68k                           sun3_defconfig
arm                           corgi_defconfig
mips                       capcella_defconfig
mips                     loongson1b_defconfig
xtensa                         virt_defconfig
m68k                             alldefconfig
arc                      axs103_smp_defconfig
arm                         s3c6400_defconfig
arm                          exynos_defconfig
arm                      footbridge_defconfig
h8300                     edosk2674_defconfig
openrisc                 simple_smp_defconfig
sh                         microdev_defconfig
sh                 kfr2r09-romimage_defconfig
arm                             rpc_defconfig
mips                        bcm47xx_defconfig
powerpc                      arches_defconfig
sh                   secureedge5410_defconfig
arm                       omap2plus_defconfig
powerpc                        cell_defconfig
arm                  randconfig-c002-20220310
arm                  randconfig-c002-20220312
arm                  randconfig-c002-20220313
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
arc                  randconfig-r043-20220313
riscv                randconfig-r042-20220313
s390                 randconfig-r044-20220313
arc                  randconfig-r043-20220312
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
mips                 randconfig-c004-20220313
powerpc              randconfig-c003-20220313
arm                  randconfig-c002-20220313
s390                 randconfig-c005-20220313
riscv                randconfig-c006-20220313
arm                  randconfig-c002-20220310
arm                  randconfig-c002-20220312
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220310
powerpc              randconfig-c003-20220312
riscv                randconfig-c006-20220310
riscv                randconfig-c006-20220312
mips                 randconfig-c004-20220310
mips                 randconfig-c004-20220312
i386                          randconfig-c001
s390                 randconfig-c005-20220310
mips                      bmips_stb_defconfig
mips                         tb0219_defconfig
arm                      tct_hammer_defconfig
arm                         lpc32xx_defconfig
arm                   milbeaut_m10v_defconfig
mips                       lemote2f_defconfig
arm                         shannon_defconfig
powerpc                     akebono_defconfig
arm                    vt8500_v6_v7_defconfig
arm                            dove_defconfig
arm                          pxa168_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                          pcm027_defconfig
arm                           spitz_defconfig
powerpc                      pmac32_defconfig
mips                           ip28_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r041-20220313
hexagon              randconfig-r045-20220313
hexagon              randconfig-r041-20220312
s390                 randconfig-r044-20220312
hexagon              randconfig-r045-20220312
riscv                randconfig-r042-20220312
hexagon              randconfig-r045-20220310
hexagon              randconfig-r041-20220310
riscv                randconfig-r042-20220310

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

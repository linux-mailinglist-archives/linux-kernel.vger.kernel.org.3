Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5257C4983DE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243205AbiAXPx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:53:57 -0500
Received: from mga05.intel.com ([192.55.52.43]:23801 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235395AbiAXPx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643039635; x=1674575635;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cqKL1H60Ygg1SimwGCNvBBB96ntTcKsVKOM9MlF1IWI=;
  b=iA4cv4TLyC9cWc7lApkiH8TsaFZK8G5bt7+AicalyzHGxppVmIltdkT2
   RNAszcqUhI9i0LvOfE+uSor63ZXGf7EnXV0opeuEc8rTd3rEGilWZayEU
   luuC7G5FAqbG6v4vY54BDP5IlWhJuha6xn43WzXAuusew2dp38/VCPdJy
   EihZoTFM6l1c66q1zgFWZy1jueMrfgKskr3CdMxdGVzEbH7xDFRD+qbH4
   L/oqhLMEmEW+EewWDTMtFlBsEYp02rq0f2UThzMhPg7Ib7LuOrOgrfBmv
   sABRUZGVRpWj+s7zBV61NO98vwIXQwR9D7qFDHbHuhWlJyKeIaf43xcy3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="332427851"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="332427851"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:53:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="479121852"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 24 Jan 2022 07:53:53 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nC1fF-000IZG-89; Mon, 24 Jan 2022 15:53:53 +0000
Date:   Mon, 24 Jan 2022 23:53:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 cf2fbcfc6b38b48b1fc1c18189442a576149b4fe
Message-ID: <61eecb78.nT9Tf6sqAS9TQIuT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: cf2fbcfc6b38b48b1fc1c18189442a576149b4fe  srcu: Dynamically allocate srcu_node array

elapsed time: 1068m

configs tested: 153
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
arc                 nsimosci_hs_smp_defconfig
arm                       imx_v6_v7_defconfig
i386                                defconfig
xtensa                       common_defconfig
m68k                          multi_defconfig
sh                          urquell_defconfig
arm                       aspeed_g5_defconfig
powerpc64                        alldefconfig
openrisc                 simple_smp_defconfig
arm                         cm_x300_defconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc837x_mds_defconfig
sh                          rsk7269_defconfig
arm                         vf610m4_defconfig
sh                            shmin_defconfig
parisc                           alldefconfig
powerpc                 mpc85xx_cds_defconfig
sparc                       sparc32_defconfig
h8300                       h8s-sim_defconfig
alpha                               defconfig
ia64                            zx1_defconfig
xtensa                              defconfig
nds32                            alldefconfig
powerpc                     taishan_defconfig
xtensa                  audio_kc705_defconfig
powerpc                      ppc40x_defconfig
sh                           se7619_defconfig
ia64                        generic_defconfig
mips                         cobalt_defconfig
arm                           sunxi_defconfig
sh                         ap325rxa_defconfig
arc                         haps_hs_defconfig
powerpc                     mpc83xx_defconfig
h8300                            alldefconfig
powerpc                     tqm8541_defconfig
sh                          sdk7780_defconfig
mips                            gpr_defconfig
microblaze                      mmu_defconfig
arc                     haps_hs_smp_defconfig
parisc                generic-32bit_defconfig
powerpc                      arches_defconfig
sh                   sh7770_generic_defconfig
powerpc                        cell_defconfig
sh                               alldefconfig
arm                  randconfig-c002-20220123
arm                  randconfig-c002-20220124
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
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
x86_64               randconfig-a002-20220124
x86_64               randconfig-a003-20220124
x86_64               randconfig-a001-20220124
x86_64               randconfig-a004-20220124
x86_64               randconfig-a005-20220124
x86_64               randconfig-a006-20220124
i386                 randconfig-a002-20220124
i386                 randconfig-a005-20220124
i386                 randconfig-a003-20220124
i386                 randconfig-a004-20220124
i386                 randconfig-a001-20220124
i386                 randconfig-a006-20220124
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220123
arm                  randconfig-c002-20220124
riscv                randconfig-c006-20220124
riscv                randconfig-c006-20220123
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220123
powerpc              randconfig-c003-20220124
mips                 randconfig-c004-20220123
mips                 randconfig-c004-20220124
x86_64               randconfig-c007-20220124
s390                 randconfig-c005-20220124
s390                 randconfig-c005-20220123
powerpc                       ebony_defconfig
mips                       rbtx49xx_defconfig
arm                        spear3xx_defconfig
arm                                 defconfig
arm                     am200epdkit_defconfig
mips                          ath79_defconfig
mips                     loongson2k_defconfig
arm                             mxs_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                     mpc512x_defconfig
mips                           ip22_defconfig
mips                   sb1250_swarm_defconfig
mips                         tb0287_defconfig
arm                        vexpress_defconfig
mips                            e55_defconfig
x86_64               randconfig-a011-20220124
x86_64               randconfig-a013-20220124
x86_64               randconfig-a015-20220124
x86_64               randconfig-a016-20220124
x86_64               randconfig-a014-20220124
x86_64               randconfig-a012-20220124
i386                 randconfig-a011-20220124
i386                 randconfig-a016-20220124
i386                 randconfig-a013-20220124
i386                 randconfig-a014-20220124
i386                 randconfig-a015-20220124
i386                 randconfig-a012-20220124
riscv                randconfig-r042-20220124
hexagon              randconfig-r045-20220124
hexagon              randconfig-r041-20220124
hexagon              randconfig-r045-20220123
hexagon              randconfig-r041-20220123

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

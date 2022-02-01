Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3080B4A5FA5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240091AbiBAPKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:10:03 -0500
Received: from mga05.intel.com ([192.55.52.43]:47709 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239827AbiBAPKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643728201; x=1675264201;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vAkrHvHH1fteeoNBiypCwdq17oKvAHoIjnynBHmA+90=;
  b=ht/vQdGg7CuYrhMtzBImX/8VHI7nqNqSdnO3Q2DzUEr60SPD/ZCaTBix
   UFoprXhCKfkGAbB7URrJcAwsybnqP5X/9uf0rBqCeUbN4EavX4Hthz8UE
   3jv9Sy3PaGx+OF7X0/u98Pr0JV5n7IWpcDdEUA0EYnVPPeyNqkK0kTM88
   prBNqg93nJTTR6X9EM1IlC2StTgJwm68PaWk2WHr3A/3Fe0cdRW6r6ySF
   9kQJvDcQUotbwh/Mmi/UpCHj9L5cy+ZbjBw85vIdacGlxk0L/muQFzYSK
   +5SH8YnjaKRRV7UMUXPGZ3QaGYLrubczkIVkFIJCXHmUVFO+/8KXPHX6c
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="334066157"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="334066157"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 07:07:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="534545771"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 01 Feb 2022 07:07:50 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEul3-000TO7-Il; Tue, 01 Feb 2022 15:07:49 +0000
Date:   Tue, 01 Feb 2022 23:07:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 42a3d5cc6367cd2e9f697fd0b09fd24ba3e79f01
Message-ID: <61f94c9c.Jbc6UDFXa3tipqtu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 42a3d5cc6367cd2e9f697fd0b09fd24ba3e79f01  rcutorture: Test SRCU size transitions

elapsed time: 720m

configs tested: 158
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220131
powerpc              randconfig-c003-20220131
i386                          randconfig-c001
sh                          rsk7203_defconfig
mips                           xway_defconfig
um                               alldefconfig
powerpc                 mpc834x_mds_defconfig
sh                          urquell_defconfig
arm                       imx_v6_v7_defconfig
arc                            hsdk_defconfig
powerpc                     taishan_defconfig
mips                             allmodconfig
sh                            titan_defconfig
m68k                           sun3_defconfig
xtensa                       common_defconfig
arc                        nsimosci_defconfig
sh                          rsk7269_defconfig
powerpc                    klondike_defconfig
powerpc                      ppc40x_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     sequoia_defconfig
arm                       multi_v4t_defconfig
arc                          axs103_defconfig
powerpc                    sam440ep_defconfig
mips                      fuloong2e_defconfig
arm                       aspeed_g5_defconfig
mips                         tb0226_defconfig
parisc                           alldefconfig
m68k                       m5208evb_defconfig
powerpc                      arches_defconfig
riscv                    nommu_k210_defconfig
arm                           stm32_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                     asp8347_defconfig
arm                      footbridge_defconfig
sh                          kfr2r09_defconfig
sh                           se7724_defconfig
ia64                        generic_defconfig
sh                           se7343_defconfig
sh                             shx3_defconfig
sh                     sh7710voipgw_defconfig
h8300                            allyesconfig
arm                          gemini_defconfig
um                             i386_defconfig
csky                             alldefconfig
powerpc                       eiger_defconfig
powerpc                        cell_defconfig
microblaze                      mmu_defconfig
sh                               alldefconfig
m68k                          sun3x_defconfig
mips                      maltasmvp_defconfig
arc                                 defconfig
powerpc                      bamboo_defconfig
mips                        jmr3927_defconfig
openrisc                         alldefconfig
mips                         db1xxx_defconfig
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
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
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20220131
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a006-20220131
x86_64               randconfig-a005-20220131
x86_64               randconfig-a002-20220131
i386                 randconfig-a006-20220131
i386                 randconfig-a005-20220131
i386                 randconfig-a003-20220131
i386                 randconfig-a002-20220131
i386                 randconfig-a001-20220131
i386                 randconfig-a004-20220131
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
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
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220130
x86_64                        randconfig-c007
arm                  randconfig-c002-20220130
powerpc              randconfig-c003-20220130
mips                 randconfig-c004-20220130
i386                          randconfig-c001
riscv                randconfig-c006-20220201
powerpc              randconfig-c003-20220201
mips                 randconfig-c004-20220201
arm                  randconfig-c002-20220201
powerpc                          allyesconfig
arm                             mxs_defconfig
arm                        spear3xx_defconfig
arm                           sama7_defconfig
powerpc                     kilauea_defconfig
mips                           ip22_defconfig
arm                       versatile_defconfig
arm                         orion5x_defconfig
mips                   sb1250_swarm_defconfig
powerpc                 mpc8560_ads_defconfig
arm                        vexpress_defconfig
mips                       lemote2f_defconfig
x86_64               randconfig-a013-20220131
x86_64               randconfig-a015-20220131
x86_64               randconfig-a014-20220131
x86_64               randconfig-a016-20220131
x86_64               randconfig-a011-20220131
x86_64               randconfig-a012-20220131
i386                 randconfig-a011-20220131
i386                 randconfig-a013-20220131
i386                 randconfig-a014-20220131
i386                 randconfig-a012-20220131
i386                 randconfig-a015-20220131
i386                 randconfig-a016-20220131
riscv                randconfig-r042-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

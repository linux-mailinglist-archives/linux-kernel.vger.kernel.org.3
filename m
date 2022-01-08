Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB1B488707
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 00:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbiAHX6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 18:58:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:35802 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229974AbiAHX6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 18:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641686295; x=1673222295;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6SIFxPLHg8u52PV+2otWD6z9k5aoa0US/gD3kWfCNzM=;
  b=G7lFa+LLfwDPsU/4h6tLh8HmZwkNCnfJqK4pKA51oE/IMSRey+6AHV5Z
   YzfqsnQ/078c3hySU7fmR9xEXCiTMVG2t1ryfJYOehS8+Ps7LkFnw4EGk
   BXjHTc2yN286Y7nxHjgef7hNxy+gxy+Rm1D+c+PQJeGK+TQl+hrs6yY1+
   FBDi5LylC9WFpJzini8zxS1QrajrBH48PMD5NF9yOk14Fw8+s8g6bJVJC
   5eYil/jkmtlJ0juy64uWF9tkJBftJrDgps1mbLVKdgrO9s8cCgRyatD0s
   oqtpf8MpZMsHIYeuXdmwW4zpYyhd4rZzjwqnd/QZwZCdkgyytMWDOFKCU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="306406272"
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="306406272"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 15:58:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="690180615"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Jan 2022 15:58:13 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6LbB-0001Bt-3v; Sat, 08 Jan 2022 23:58:13 +0000
Date:   Sun, 09 Jan 2022 07:57:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 0422fe2666aea4c0986f4c89dc107731aa6a7a81
Message-ID: <61da24e4.IAXDg4KJ8YgGoBRs%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 0422fe2666aea4c0986f4c89dc107731aa6a7a81  Merge branch 'linus' into irq/core, to fix conflict

elapsed time: 723m

configs tested: 116
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220108
arm                         cm_x300_defconfig
arm                         lpc18xx_defconfig
sh                          landisk_defconfig
sparc                               defconfig
sh                            shmin_defconfig
sh                           se7750_defconfig
arm                          iop32x_defconfig
powerpc                 canyonlands_defconfig
sh                        edosk7760_defconfig
powerpc                     mpc83xx_defconfig
ia64                         bigsur_defconfig
powerpc                    sam440ep_defconfig
um                           x86_64_defconfig
arm64                            alldefconfig
mips                  maltasmvp_eva_defconfig
mips                           jazz_defconfig
arm                       aspeed_g5_defconfig
parisc                generic-64bit_defconfig
powerpc                 mpc837x_mds_defconfig
arm                  randconfig-c002-20220109
arm                  randconfig-c002-20220108
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
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a015-20220108
x86_64               randconfig-a012-20220108
x86_64               randconfig-a014-20220108
x86_64               randconfig-a013-20220108
x86_64               randconfig-a011-20220108
x86_64               randconfig-a016-20220108
i386                 randconfig-a012-20220108
i386                 randconfig-a016-20220108
i386                 randconfig-a015-20220108
i386                 randconfig-a014-20220108
i386                 randconfig-a011-20220108
i386                 randconfig-a013-20220108
s390                 randconfig-r044-20220108
arc                  randconfig-r043-20220108
riscv                randconfig-r042-20220108
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220108
mips                 randconfig-c004-20220108
i386                 randconfig-c001-20220108
riscv                randconfig-c006-20220108
powerpc              randconfig-c003-20220108
x86_64               randconfig-c007-20220108
s390                 randconfig-c005-20220108
mips                 randconfig-c004-20220107
arm                  randconfig-c002-20220107
i386                 randconfig-c001-20220107
riscv                randconfig-c006-20220107
powerpc              randconfig-c003-20220107
x86_64               randconfig-c007-20220107
arm                        mvebu_v5_defconfig
powerpc                     tqm8560_defconfig
powerpc                     skiroot_defconfig
powerpc                          allyesconfig
powerpc                     ksi8560_defconfig
i386                 randconfig-a003-20220108
i386                 randconfig-a005-20220108
i386                 randconfig-a006-20220108
i386                 randconfig-a004-20220108
i386                 randconfig-a001-20220108
i386                 randconfig-a002-20220108
x86_64               randconfig-a005-20220108
x86_64               randconfig-a001-20220108
x86_64               randconfig-a004-20220108
x86_64               randconfig-a006-20220108
x86_64               randconfig-a003-20220108
x86_64               randconfig-a002-20220108

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D1C4717BC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 03:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhLLB76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 20:59:58 -0500
Received: from mga05.intel.com ([192.55.52.43]:63740 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230381AbhLLB76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 20:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639274398; x=1670810398;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XjlzkKGju663s/Tca+vELIg8dvE2zGWAwyzRPvd3+lA=;
  b=F3+7pgctalLup8lTnU7ADy/sp6niE9TbaeG3pbBJT1AsnagDHgcfkE1/
   Yemtfhb5r+JK+K2BYXaDt/8xyerGSqYmv5qsDEi/mfggsTZqBJ9BEiBxO
   3yo/5E9/4qVXMU27/1Yj6tYirbRVv9wd7Kv+2Yu+OAKKHIdNhy+cGTRho
   XqtHLp/EDr3EyInKuDOCPHpuxmy/bpbI3YirwlbplHYxqd0ZTUQY6txWC
   /7inVcE8z6ooz/gSq0Eem4NnZY8JG98ycZd0+ppqjMpri4vHFdV3uruUK
   Ezlu90T3tNjJY/JBIKJWCZFBqx4QbQDb/S33d6gjUgaxiMf/Z8+4Eheha
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10195"; a="324835424"
X-IronPort-AV: E=Sophos;i="5.88,199,1635231600"; 
   d="scan'208";a="324835424"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 17:59:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,199,1635231600"; 
   d="scan'208";a="681212207"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 11 Dec 2021 17:59:56 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwE9b-0005Gn-UX; Sun, 12 Dec 2021 01:59:55 +0000
Date:   Sun, 12 Dec 2021 09:59:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 aa073d8b2a6308832de3cac18e7901ac60748e26
Message-ID: <61b55792.mGsvO/XBK3T1ZUcV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: aa073d8b2a6308832de3cac18e7901ac60748e26  Merge tag 'timers-v5.16-rc4' of https://git.linaro.org/people/daniel.lezcano/linux into timers/urgent

elapsed time: 723m

configs tested: 112
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211210
arm                        mini2440_defconfig
arm                         assabet_defconfig
powerpc                     tqm8548_defconfig
powerpc64                        alldefconfig
arc                          axs101_defconfig
mips                           mtx1_defconfig
powerpc                     pseries_defconfig
mips                       lemote2f_defconfig
powerpc                     ppa8548_defconfig
nios2                         3c120_defconfig
arm                       multi_v4t_defconfig
sh                           se7619_defconfig
arm                      integrator_defconfig
arm                     eseries_pxa_defconfig
powerpc                          g5_defconfig
mips                        bcm47xx_defconfig
openrisc                         alldefconfig
powerpc                 mpc8540_ads_defconfig
m68k                       bvme6000_defconfig
powerpc                      ppc40x_defconfig
s390                          debug_defconfig
arm                        mvebu_v7_defconfig
arm                          pxa168_defconfig
arm                  randconfig-c002-20211210
arm                  randconfig-c002-20211212
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
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20211210
i386                 randconfig-a002-20211210
i386                 randconfig-a005-20211210
i386                 randconfig-a003-20211210
i386                 randconfig-a006-20211210
i386                 randconfig-a004-20211210
i386                 randconfig-a013-20211211
i386                 randconfig-a011-20211211
i386                 randconfig-a016-20211211
i386                 randconfig-a014-20211211
i386                 randconfig-a015-20211211
i386                 randconfig-a012-20211211
x86_64               randconfig-a006-20211210
x86_64               randconfig-a005-20211210
x86_64               randconfig-a001-20211210
x86_64               randconfig-a002-20211210
x86_64               randconfig-a003-20211210
x86_64               randconfig-a004-20211210
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
x86_64               randconfig-a011-20211212
x86_64               randconfig-a012-20211212
x86_64               randconfig-a014-20211212
x86_64               randconfig-a013-20211212
x86_64               randconfig-a016-20211212
x86_64               randconfig-a015-20211212
hexagon              randconfig-r045-20211212
riscv                randconfig-r042-20211212
s390                 randconfig-r044-20211212
hexagon              randconfig-r041-20211212
hexagon              randconfig-r045-20211210
riscv                randconfig-r042-20211210
s390                 randconfig-r044-20211210
hexagon              randconfig-r041-20211210

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

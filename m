Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1377451669B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 19:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349969AbiEARZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 13:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiEARZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 13:25:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9446922529
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651425711; x=1682961711;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=90XDb9APUpsd/tVLgGGgKMBJ9e3qI+pRHTCZNvO/udg=;
  b=NQkfPjfpd5YePhbRhP5+VcdRYQhl8S4JycFKbXV8CR1mc3gXOOrAdn3X
   C7EdysZaqLaYu+2KJb8EVJUU987ua2DtZIlmWimCXA2dM38P0Z5UDOmgb
   trMft/CVSI+R2Xj2Ft6QByFl2bxusFDLWESCegGTTpOL4bWMmeVcJtFHO
   YUGD+eqDzrGNHVwKLCSRv7avkQpmtFDkBJbPMlKzGW4CuqiYLNMETdE2e
   AFP4XJz1Q91O788YjgB9X8MmrEmffzCpOBRXLyxYk/izPO3fyZnTz86R9
   ip39X+XYDfPUcBHMSMa0hHyE6Up0BFhwRichKcXT/e2V2VuWp4pIB75kS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="264625316"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="264625316"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 10:21:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="619553167"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 May 2022 10:21:50 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlDGX-0008vj-JB;
        Sun, 01 May 2022 17:21:49 +0000
Date:   Mon, 02 May 2022 01:21:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.04.20a] BUILD SUCCESS
 ef41303096e59a9ca8d2668f06358bba11ee02c1
Message-ID: <626ec17c.C4C47FtqsrQZKnYP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.04.20a
branch HEAD: ef41303096e59a9ca8d2668f06358bba11ee02c1  rcu: Avoid tracing a few functions executed in stop machine

elapsed time: 7194m

configs tested: 143
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                 randconfig-c001-20220425
i386                          randconfig-c001
sh                           se7750_defconfig
powerpc                      pcm030_defconfig
xtensa                          iss_defconfig
arm                            zeus_defconfig
sparc64                          alldefconfig
arc                     haps_hs_smp_defconfig
parisc                           alldefconfig
sh                         microdev_defconfig
sh                            shmin_defconfig
microblaze                      mmu_defconfig
arm                         lpc18xx_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                            mps2_defconfig
arc                                 defconfig
arm                          pxa3xx_defconfig
csky                             alldefconfig
sh                          rsk7264_defconfig
powerpc                     mpc83xx_defconfig
sh                      rts7751r2d1_defconfig
arm                             ezx_defconfig
powerpc                      cm5200_defconfig
sh                   rts7751r2dplus_defconfig
sparc                               defconfig
alpha                            allyesconfig
arm                        mini2440_defconfig
arm                      footbridge_defconfig
ia64                             alldefconfig
m68k                       m5208evb_defconfig
sh                           se7751_defconfig
powerpc                 linkstation_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220427
arm                  randconfig-c002-20220425
x86_64               randconfig-c001-20220425
arm                  randconfig-c002-20220426
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
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
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64               randconfig-a015-20220425
x86_64               randconfig-a014-20220425
x86_64               randconfig-a011-20220425
x86_64               randconfig-a013-20220425
x86_64               randconfig-a012-20220425
x86_64               randconfig-a016-20220425
i386                 randconfig-a014-20220425
i386                 randconfig-a012-20220425
i386                 randconfig-a011-20220425
i386                 randconfig-a015-20220425
i386                 randconfig-a013-20220425
i386                 randconfig-a016-20220425
s390                 randconfig-r044-20220425
arc                  randconfig-r043-20220425
riscv                randconfig-r042-20220425
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz

clang tested configs:
riscv                randconfig-c006-20220428
mips                 randconfig-c004-20220428
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220428
powerpc              randconfig-c003-20220428
s390                 randconfig-c005-20220428
mips                          malta_defconfig
powerpc                     kmeter1_defconfig
arm                          moxart_defconfig
arm                          pxa168_defconfig
arm                            dove_defconfig
arm                     davinci_all_defconfig
powerpc                    socrates_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                       ebony_defconfig
powerpc                  mpc885_ads_defconfig
arm                        neponset_defconfig
arm                         hackkit_defconfig
mips                           mtx1_defconfig
mips                         tb0287_defconfig
powerpc                        fsp2_defconfig
arm                      pxa255-idp_defconfig
x86_64               randconfig-a002-20220425
x86_64               randconfig-a004-20220425
x86_64               randconfig-a003-20220425
x86_64               randconfig-a001-20220425
x86_64               randconfig-a005-20220425
x86_64               randconfig-a006-20220425
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
hexagon              randconfig-r045-20220425
hexagon              randconfig-r041-20220425

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

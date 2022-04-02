Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1D04F0487
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 17:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355349AbiDBPps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 11:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347004AbiDBPpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 11:45:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB67031DFB
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 08:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648914233; x=1680450233;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3V8NF1Yz9ipyzWlxhX3OlsxtkuzyL/JLvO3yhhbuDf0=;
  b=jjVAR6sZ4fNnvx6JpTBNwb8SKa1egi0Ihpx9JkrsPqvFwtpDRTJ1x0IE
   idVyR4Nen76GaIm/ZzSNkOdUnmXsHEVp0FEgaZ32SmTf/wGLNlRm8fY1m
   Qn5Y0wohe2ZhgcFiT/Qcx0AVJIdzu94uk03Y4QW3JR3tf8Bb6RIMWhBuX
   moSrb0giPx3kzPePKaARABlkjpJXjDHSEJl90rtOaa/Ike98WeH2ddMkT
   vrgUUlp5fGFh+1706gz+1N/XY/Up89EBbiC0fYff3bybh8s3ffMFSL/uW
   ieqCcGuKQgsmfKbHO2Pmr43HDphQdD2DR7IyNMo0RXsmSF63lzWTV37W+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10305"; a="242451439"
X-IronPort-AV: E=Sophos;i="5.90,230,1643702400"; 
   d="scan'208";a="242451439"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 08:43:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,230,1643702400"; 
   d="scan'208";a="523103365"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 02 Apr 2022 08:43:52 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nafup-0000EP-DE;
        Sat, 02 Apr 2022 15:43:51 +0000
Date:   Sat, 02 Apr 2022 23:43:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:fastexp.2022.04.01a] BUILD REGRESSION
 d9f3e7d671416fdf5b61f094765754269b652db0
Message-ID: <62486f05.ithFB6YqfjaeQiXK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git fastexp.2022.04.01a
branch HEAD: d9f3e7d671416fdf5b61f094765754269b652db0  EXP rcu: Move expedited grace period (GP) work to RT kthread_worker

Error/Warning reports:

https://lore.kernel.org/lkml/202204021454.WDwBbwVL-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/powerpc/include/asm/book3s/64/pgtable-64k.h:60:1: error: no return statement in function returning non-void

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- powerpc64-randconfig-c003-20220402
    `-- arch-powerpc-include-asm-book3s-pgtable-64k.h:error:no-return-statement-in-function-returning-non-void

elapsed time: 819m

configs tested: 124
configs skipped: 3

gcc tested configs:
arm64                               defconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-c001
xtensa                  audio_kc705_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                      ppc6xx_defconfig
arm                        cerfcube_defconfig
arm                        realview_defconfig
arm                      jornada720_defconfig
arm                          exynos_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc64                           defconfig
m68k                       m5208evb_defconfig
powerpc                      makalu_defconfig
sh                           se7721_defconfig
powerpc                           allnoconfig
arm                       aspeed_g5_defconfig
mips                      loongson3_defconfig
riscv                            allmodconfig
alpha                               defconfig
arm                         vf610m4_defconfig
powerpc                         wii_defconfig
sh                        dreamcast_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                 canyonlands_defconfig
mips                  maltasmvp_eva_defconfig
s390                       zfcpdump_defconfig
mips                         cobalt_defconfig
sh                           se7712_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220402
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220402
s390                 randconfig-r044-20220402
riscv                randconfig-r042-20220402
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220402
riscv                randconfig-c006-20220402
mips                 randconfig-c004-20220402
arm                  randconfig-c002-20220402
powerpc                      obs600_defconfig
arm                        neponset_defconfig
powerpc                     mpc512x_defconfig
arm                           spitz_defconfig
arm                       spear13xx_defconfig
mips                      bmips_stb_defconfig
powerpc                     mpc5200_defconfig
mips                           mtx1_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                    ge_imp3a_defconfig
mips                           ip28_defconfig
arm                         bcm2835_defconfig
powerpc                   microwatt_defconfig
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220402
hexagon              randconfig-r045-20220402

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

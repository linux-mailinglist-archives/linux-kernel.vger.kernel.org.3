Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B87252627C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380504AbiEMNAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380503AbiEMNAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:00:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CE92DDF
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652446845; x=1683982845;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+c7b2PIICIJu5UWVN1qBZ+SsAt27DJtZvj6/0UMiiig=;
  b=DMkZNOl8tONO0HhdoHYVZEkVebrgbQjH9QSaiAUQdfxhH67BGJyNsVbl
   d1Wq/lrEC/KItJtPPVsGuSQiqLYn4uE8kGCFavbe45Aw3FwTODmrvJbH1
   M+kkIHVw34MgDx6Y5C5JJ4ZmHR1h2IcGoq7KCi38ABg/VhjO8oXNBHGqq
   T564pcDijFygtTCapNGkDiQy1jELq2up8k4Cq5YsQaOX2mcurCjh11Xif
   PSF2xmY9FghCLEVMb3zAi7O6R2X3HTYEqO2S6KeT3/lEb+vOdV13nC9X3
   Gi3CnGAo/cGlgsxuHWSXXpV20q74ErBrgLdweSe2MN1LYnnAXW5L7T+da
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="250197845"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="250197845"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 06:00:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="698477160"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 May 2022 06:00:43 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npUuQ-000Lls-H9;
        Fri, 13 May 2022 13:00:42 +0000
Date:   Fri, 13 May 2022 21:00:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:context-tracking.2022.05.03a] BUILD REGRESSION
 9527c561aed6424e77fd2a8827c37f1103c89177
Message-ID: <627e565c.pdEDbqVrzEta7Scf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git context-tracking.2022.05.03a
branch HEAD: 9527c561aed6424e77fd2a8827c37f1103c89177  rcu/context_tracking: Merge dynticks counter and context tracking states

Error/Warning reports:

https://lore.kernel.org/llvm/202205060346.y3d1cOFv-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

kernel/context_tracking.c:360:4: error: call to undeclared function 'rcu_irq_work_resched'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
kernel/context_tracking.c:91:4: error: call to undeclared function 'rcu_irq_work_resched'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

Error/Warning ids grouped by kconfigs:

clang_recent_errors
|-- arm-randconfig-r013-20220505
|   `-- kernel-context_tracking.c:error:call-to-undeclared-function-rcu_irq_work_resched-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- riscv-randconfig-c006-20220505
|   `-- kernel-context_tracking.c:error:call-to-undeclared-function-rcu_irq_work_resched-ISO-C99-and-later-do-not-support-implicit-function-declarations
`-- x86_64-randconfig-a001
    `-- kernel-context_tracking.c:error:call-to-undeclared-function-rcu_irq_work_resched-ISO-C99-and-later-do-not-support-implicit-function-declarations

elapsed time: 14089m

configs tested: 211
configs skipped: 3

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
m68k                       m5475evb_defconfig
arm                           corgi_defconfig
powerpc                     ep8248e_defconfig
nios2                            allyesconfig
arm                      footbridge_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     pq2fads_defconfig
mips                         cobalt_defconfig
powerpc                 canyonlands_defconfig
m68k                        m5272c3_defconfig
mips                         bigsur_defconfig
arm                            pleb_defconfig
powerpc                   currituck_defconfig
openrisc                 simple_smp_defconfig
arc                        nsimosci_defconfig
m68k                        mvme147_defconfig
powerpc                     tqm8555_defconfig
sh                               allmodconfig
ia64                         bigsur_defconfig
powerpc                     asp8347_defconfig
arm                      integrator_defconfig
microblaze                          defconfig
arm                         lpc18xx_defconfig
parisc64                            defconfig
powerpc                    klondike_defconfig
sh                         ap325rxa_defconfig
sparc64                             defconfig
arm                           sunxi_defconfig
powerpc                       maple_defconfig
m68k                       m5249evb_defconfig
mips                           ip32_defconfig
i386                                defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                      cm5200_defconfig
arm                         nhk8815_defconfig
i386                             alldefconfig
mips                  maltasmvp_eva_defconfig
sh                         microdev_defconfig
arc                          axs101_defconfig
nios2                         3c120_defconfig
arm                         vf610m4_defconfig
m68k                        stmark2_defconfig
powerpc                      pcm030_defconfig
powerpc                        cell_defconfig
arc                     haps_hs_smp_defconfig
sh                          rsk7269_defconfig
xtensa                    xip_kc705_defconfig
sh                        apsh4ad0a_defconfig
powerpc                     sequoia_defconfig
powerpc                     mpc83xx_defconfig
mips                         rt305x_defconfig
m68k                         apollo_defconfig
mips                           jazz_defconfig
m68k                             alldefconfig
parisc                generic-32bit_defconfig
xtensa                  audio_kc705_defconfig
m68k                            q40_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                            xcep_defconfig
arm                        oxnas_v6_defconfig
arm64                            alldefconfig
powerpc                 linkstation_defconfig
m68k                            mac_defconfig
arm                            lart_defconfig
powerpc                      ppc40x_defconfig
powerpc                      arches_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                                  defconfig
powerpc                mpc7448_hpc2_defconfig
arm                         at91_dt_defconfig
sh                   secureedge5410_defconfig
um                                  defconfig
xtensa                    smp_lx200_defconfig
um                             i386_defconfig
sh                          polaris_defconfig
arm                        mini2440_defconfig
m68k                             allyesconfig
microblaze                      mmu_defconfig
arc                            hsdk_defconfig
sh                             sh03_defconfig
powerpc64                           defconfig
sh                               j2_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220501
arm                  randconfig-c002-20220505
arm                  randconfig-c002-20220506
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a004-20220502
i386                 randconfig-a006-20220502
i386                 randconfig-a002-20220502
i386                 randconfig-a003-20220502
i386                 randconfig-a001-20220502
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                 randconfig-a005-20220502
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
riscv                randconfig-r042-20220501
arc                  randconfig-r043-20220502
arc                  randconfig-r043-20220501
s390                 randconfig-r044-20220501
arc                  randconfig-r043-20220505
s390                 randconfig-r044-20220505
riscv                randconfig-r042-20220505
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220501
riscv                randconfig-c006-20220501
mips                 randconfig-c004-20220501
arm                  randconfig-c002-20220501
powerpc              randconfig-c003-20220505
riscv                randconfig-c006-20220505
arm                  randconfig-c002-20220505
powerpc                      katmai_defconfig
powerpc                          g5_defconfig
arm                          ep93xx_defconfig
mips                      maltaaprp_defconfig
arm                           sama7_defconfig
hexagon                          alldefconfig
arm                         s3c2410_defconfig
mips                        workpad_defconfig
mips                           rs90_defconfig
arm                       mainstone_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                         s5pv210_defconfig
mips                malta_qemu_32r6_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64               randconfig-a011-20220502
x86_64               randconfig-a012-20220502
x86_64               randconfig-a013-20220502
x86_64               randconfig-a016-20220502
x86_64               randconfig-a014-20220502
x86_64               randconfig-a015-20220502
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                 randconfig-a011-20220502
i386                 randconfig-a013-20220502
i386                 randconfig-a016-20220502
i386                 randconfig-a015-20220502
i386                 randconfig-a014-20220502
i386                 randconfig-a012-20220502
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
hexagon              randconfig-r045-20220502
hexagon              randconfig-r045-20220501
hexagon              randconfig-r041-20220501
s390                 randconfig-r044-20220502
riscv                randconfig-r042-20220502
hexagon              randconfig-r041-20220502

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

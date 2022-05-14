Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A84527094
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 12:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiENKJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 06:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiENKJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 06:09:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3E3F18
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 03:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652522976; x=1684058976;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=NEpEoapS6PG0Tm0p8wmuZg9PbxNNATQDMG6ZfJsnhJY=;
  b=WD9cqHfU9OWpiECpLv9nZbvWThjAnh25xiHhMbNcfv5zQV5JwYldK8g5
   klBTkGxQ0eWRZSIAdXm6MnscuwQvDylBJStKid+fji61ptDEzTdisp2hc
   kc2h2JqV6qVlCEGZM7upN1qv31Be+83Yc81pHkpvPd9Ac6PjDhqSL43Q1
   +6Ee/hIbsKHEPlb9jQenHB+QMNrOk0b0b7goO911xqjiU6HSUDg7uujbV
   NzhU3tt8m4zIgorcZ7AnbBX7iuffNXX5CdLgf6iLIV1fVwXLgIg13or4z
   +9cubUyITRbiQcwGdInn5xF1lkw9a6LOil/9dFPFl18Te0mAAkjcU4rIF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="270624871"
X-IronPort-AV: E=Sophos;i="5.91,225,1647327600"; 
   d="scan'208";a="270624871"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 03:09:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,225,1647327600"; 
   d="scan'208";a="554552921"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 May 2022 03:09:33 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npoiK-0000Su-Ca;
        Sat, 14 May 2022 10:09:32 +0000
Date:   Sat, 14 May 2022 18:09:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 1ef64b1e89e6d4018da46e08ffc32779a31160c7
Message-ID: <627f7fcb.+a4eaRqZtpkkOcN6%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/misc
branch HEAD: 1ef64b1e89e6d4018da46e08ffc32779a31160c7  x86/mm: Cleanup the control_va_addr_alignment() __setup handler

elapsed time: 14016m

configs tested: 345
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220505
arm                        clps711x_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                         tb0226_defconfig
m68k                             allmodconfig
xtensa                       common_defconfig
arm                      jornada720_defconfig
powerpc                      pcm030_defconfig
powerpc                     ep8248e_defconfig
nios2                            allyesconfig
sh                ecovec24-romimage_defconfig
arm                           sunxi_defconfig
ia64                             alldefconfig
arm                          exynos_defconfig
h8300                    h8300h-sim_defconfig
arm                        multi_v7_defconfig
powerpc                      mgcoge_defconfig
xtensa                    smp_lx200_defconfig
ia64                      gensparse_defconfig
riscv                               defconfig
powerpc                     sequoia_defconfig
arc                          axs103_defconfig
ia64                         bigsur_defconfig
powerpc                     redwood_defconfig
mips                  decstation_64_defconfig
h8300                       h8s-sim_defconfig
sh                          kfr2r09_defconfig
sh                           se7712_defconfig
sh                           se7705_defconfig
mips                       bmips_be_defconfig
powerpc                     taishan_defconfig
m68k                           sun3_defconfig
parisc                           allyesconfig
arm                     eseries_pxa_defconfig
sh                           se7780_defconfig
powerpc                     pq2fads_defconfig
s390                       zfcpdump_defconfig
sh                        dreamcast_defconfig
mips                 decstation_r4k_defconfig
powerpc64                        alldefconfig
arc                        nsimosci_defconfig
um                           x86_64_defconfig
arm                        spear6xx_defconfig
powerpc                      cm5200_defconfig
sh                         ap325rxa_defconfig
x86_64                              defconfig
mips                      loongson3_defconfig
sparc                            alldefconfig
powerpc                 mpc837x_rdb_defconfig
m68k                          hp300_defconfig
ia64                          tiger_defconfig
m68k                          atari_defconfig
powerpc                           allnoconfig
powerpc                     tqm8555_defconfig
arm                        mini2440_defconfig
sh                   sh7724_generic_defconfig
xtensa                              defconfig
arm                           sama5_defconfig
mips                        bcm47xx_defconfig
sh                        apsh4ad0a_defconfig
arm                        keystone_defconfig
i386                                defconfig
mips                         rt305x_defconfig
alpha                            alldefconfig
sh                         microdev_defconfig
arm                            pleb_defconfig
powerpc                      tqm8xx_defconfig
xtensa                  cadence_csp_defconfig
m68k                          multi_defconfig
arm                         lpc18xx_defconfig
parisc64                            defconfig
powerpc                    klondike_defconfig
mips                           jazz_defconfig
um                               alldefconfig
openrisc                    or1ksim_defconfig
sparc                       sparc64_defconfig
sh                          polaris_defconfig
sh                        sh7763rdp_defconfig
powerpc                         wii_defconfig
arm                           viper_defconfig
h8300                            allyesconfig
powerpc                     rainier_defconfig
sparc                               defconfig
sh                           se7750_defconfig
sh                                  defconfig
m68k                       m5249evb_defconfig
mips                           ip32_defconfig
powerpc                     asp8347_defconfig
powerpc                  storcenter_defconfig
sh                               allmodconfig
arm                         lubbock_defconfig
sh                           se7343_defconfig
parisc                generic-32bit_defconfig
alpha                               defconfig
powerpc                      pasemi_defconfig
mips                           ci20_defconfig
mips                         bigsur_defconfig
sh                   rts7751r2dplus_defconfig
arc                           tb10x_defconfig
ia64                        generic_defconfig
sh                 kfr2r09-romimage_defconfig
arm                         nhk8815_defconfig
powerpc                      ep88xc_defconfig
sh                          rsk7269_defconfig
m68k                        m5307c3_defconfig
arm                            zeus_defconfig
powerpc                       holly_defconfig
csky                                defconfig
sh                           se7721_defconfig
alpha                            allyesconfig
arm                          lpd270_defconfig
mips                        vocore2_defconfig
arm                             pxa_defconfig
arm                        cerfcube_defconfig
sparc                            allyesconfig
m68k                          sun3x_defconfig
powerpc                      chrp32_defconfig
powerpc                        cell_defconfig
arc                     haps_hs_smp_defconfig
arm                       multi_v4t_defconfig
sh                          lboxre2_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                         cobalt_defconfig
openrisc                  or1klitex_defconfig
xtensa                    xip_kc705_defconfig
sh                          sdk7786_defconfig
arm                         s3c6400_defconfig
arm                           stm32_defconfig
arm                       aspeed_g5_defconfig
m68k                        stmark2_defconfig
parisc                              defconfig
sh                        sh7757lcr_defconfig
sh                             sh03_defconfig
arm                         cm_x300_defconfig
xtensa                  audio_kc705_defconfig
m68k                            q40_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                            xcep_defconfig
arm                        oxnas_v6_defconfig
sh                        edosk7760_defconfig
arm                            lart_defconfig
arm                       imx_v6_v7_defconfig
openrisc                 simple_smp_defconfig
powerpc                       eiger_defconfig
arc                              alldefconfig
arm                        shmobile_defconfig
m68k                         amcore_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                          amiga_defconfig
parisc                generic-64bit_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                         at91_dt_defconfig
sh                          sdk7780_defconfig
arm                           imxrt_defconfig
m68k                             alldefconfig
arm                            qcom_defconfig
xtensa                           allyesconfig
sh                               j2_defconfig
riscv                    nommu_k210_defconfig
microblaze                          defconfig
um                             i386_defconfig
mips                            ar7_defconfig
arc                    vdk_hs38_smp_defconfig
arm                       omap2plus_defconfig
powerpc                      arches_defconfig
powerpc                    adder875_defconfig
ia64                            zx1_defconfig
m68k                             allyesconfig
microblaze                      mmu_defconfig
arc                            hsdk_defconfig
arc                                 defconfig
powerpc64                           defconfig
m68k                       m5475evb_defconfig
h8300                               defconfig
powerpc                    sam440ep_defconfig
sh                           se7722_defconfig
arm                          iop32x_defconfig
openrisc                            defconfig
arm                            mps2_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220501
arm                  randconfig-c002-20220505
arm                  randconfig-c002-20220506
arm                  randconfig-c002-20220508
arm                  randconfig-c002-20220507
ia64                                defconfig
ia64                             allyesconfig
ia64                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
i386                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a006-20220502
x86_64               randconfig-a002-20220502
x86_64               randconfig-a001-20220502
x86_64               randconfig-a004-20220502
x86_64               randconfig-a005-20220502
x86_64               randconfig-a003-20220502
i386                 randconfig-a004-20220502
i386                 randconfig-a006-20220502
i386                 randconfig-a002-20220502
i386                 randconfig-a003-20220502
i386                 randconfig-a001-20220502
i386                 randconfig-a005-20220502
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220505
s390                 randconfig-r044-20220505
riscv                randconfig-r042-20220505
arc                  randconfig-r043-20220507
s390                 randconfig-r044-20220507
riscv                randconfig-r042-20220507
arc                  randconfig-r043-20220501
s390                 randconfig-r044-20220501
riscv                randconfig-r042-20220501
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220501
riscv                randconfig-c006-20220501
mips                 randconfig-c004-20220501
arm                  randconfig-c002-20220501
s390                 randconfig-c005-20220506
powerpc              randconfig-c003-20220506
riscv                randconfig-c006-20220506
mips                 randconfig-c004-20220506
arm                  randconfig-c002-20220506
powerpc              randconfig-c003-20220507
riscv                randconfig-c006-20220507
mips                 randconfig-c004-20220507
arm                  randconfig-c002-20220507
powerpc              randconfig-c003-20220508
riscv                randconfig-c006-20220508
mips                 randconfig-c004-20220508
arm                  randconfig-c002-20220508
powerpc              randconfig-c003-20220505
riscv                randconfig-c006-20220505
arm                  randconfig-c002-20220505
arm                           omap1_defconfig
arm                          moxart_defconfig
arm                          collie_defconfig
mips                         tb0219_defconfig
powerpc                     mpc5200_defconfig
arm                       cns3420vb_defconfig
powerpc                    socrates_defconfig
mips                     cu1830-neo_defconfig
mips                      pic32mzda_defconfig
powerpc                      katmai_defconfig
powerpc                          g5_defconfig
arm                          ep93xx_defconfig
mips                      maltaaprp_defconfig
i386                             allyesconfig
powerpc                     ksi8560_defconfig
mips                          ath25_defconfig
mips                           rs90_defconfig
arm                           sama7_defconfig
hexagon                          alldefconfig
arm                         s3c2410_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     skiroot_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                       mainstone_defconfig
powerpc                 mpc832x_rdb_defconfig
hexagon                             defconfig
powerpc               mpc834x_itxgp_defconfig
arm                            dove_defconfig
arm                            mmp2_defconfig
arm                     davinci_all_defconfig
arm                         lpc32xx_defconfig
arm                          ixp4xx_defconfig
powerpc                    ge_imp3a_defconfig
mips                   sb1250_swarm_defconfig
arm                           spitz_defconfig
arm                      pxa255-idp_defconfig
mips                     cu1000-neo_defconfig
mips                malta_qemu_32r6_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a004-20220509
i386                 randconfig-a006-20220509
i386                 randconfig-a002-20220509
i386                 randconfig-a003-20220509
i386                 randconfig-a001-20220509
i386                 randconfig-a005-20220509
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a015-20220502
x86_64               randconfig-a012-20220502
x86_64               randconfig-a016-20220502
x86_64               randconfig-a014-20220502
x86_64               randconfig-a013-20220502
x86_64               randconfig-a011-20220502
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                 randconfig-a011-20220502
i386                 randconfig-a013-20220502
i386                 randconfig-a016-20220502
i386                 randconfig-a015-20220502
i386                 randconfig-a014-20220502
i386                 randconfig-a012-20220502
hexagon              randconfig-r045-20220506
riscv                randconfig-r042-20220506
hexagon              randconfig-r041-20220506
hexagon              randconfig-r045-20220501
hexagon              randconfig-r041-20220501
hexagon              randconfig-r045-20220502
riscv                randconfig-r042-20220502
hexagon              randconfig-r041-20220502
hexagon              randconfig-r045-20220509
hexagon              randconfig-r045-20220508
riscv                randconfig-r042-20220508
hexagon              randconfig-r041-20220509
hexagon              randconfig-r041-20220508

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

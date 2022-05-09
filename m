Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B313751F503
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbiEIHGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbiEIHAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:00:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0F913128D
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 23:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652079390; x=1683615390;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZHtSE3GxkhnMkrOJm7ZcS7pfV2t9FXX2jTJhOsTqW+k=;
  b=V8/Dzlutyr8o6CIzMcRhND+HuGW1lb88zipqTRM7I5hfyqvFGC4gBWBy
   LwdkyRqyfJB87DZdsWO9F21qm1nMh2jJoUbH5+Xqe7RSEKzwtZlwcsZWX
   MqeiGQTdaPrQE3arzhwIZwvyeXTv3OlWP8xneGnvu3N/I/PH7pxbS+13a
   8pleonUdjo4s9pIpQmJuwyN3hnb+execZuqTPcY/E9lmiUGzW/PSpzfPw
   GZNdA2AuGGaV8dI+JsIzLfnhe95JhqTjMiK6vKN3NGlaVSNJGI7lqGPNd
   T9Ja+tWR9o5i8iQNLWsxbwKuN/0VzVBu4JKiTd3vrBt1vebfQqx6HumDY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="294182613"
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="294182613"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 23:56:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="570024789"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 08 May 2022 23:56:19 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnxJa-000GGY-N4;
        Mon, 09 May 2022 06:56:18 +0000
Date:   Mon, 09 May 2022 14:56:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 ce4818957fdc5bca57fc2c92b0dfe109d26bcc47
Message-ID: <6278bb0f.Vc8rUxDiWWNBZpjB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: ce4818957fdc5bca57fc2c92b0dfe109d26bcc47  genirq: Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync()

elapsed time: 9696m

configs tested: 393
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                         tb0226_defconfig
powerpc                      cm5200_defconfig
powerpc                       holly_defconfig
arm                        clps711x_defconfig
arc                 nsimosci_hs_smp_defconfig
m68k                             allmodconfig
xtensa                       common_defconfig
arm                      jornada720_defconfig
powerpc                         ps3_defconfig
arc                     haps_hs_smp_defconfig
arc                            hsdk_defconfig
arm                         vf610m4_defconfig
xtensa                           allyesconfig
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
s390                       zfcpdump_defconfig
arm                        realview_defconfig
arm                       multi_v4t_defconfig
xtensa                  nommu_kc705_defconfig
sparc64                          alldefconfig
riscv                               defconfig
powerpc                     sequoia_defconfig
arc                          axs103_defconfig
parisc                              defconfig
sh                         microdev_defconfig
ia64                         bigsur_defconfig
powerpc                     redwood_defconfig
mips                  decstation_64_defconfig
h8300                       h8s-sim_defconfig
sh                          kfr2r09_defconfig
sh                           se7712_defconfig
arm                      footbridge_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     pq2fads_defconfig
mips                         cobalt_defconfig
powerpc                 canyonlands_defconfig
sh                           se7705_defconfig
mips                       bmips_be_defconfig
powerpc                     taishan_defconfig
m68k                           sun3_defconfig
powerpc                      pcm030_defconfig
parisc                           allyesconfig
arm                     eseries_pxa_defconfig
sh                           se7780_defconfig
sh                        dreamcast_defconfig
mips                 decstation_r4k_defconfig
powerpc64                        alldefconfig
arc                        nsimosci_defconfig
um                           x86_64_defconfig
arm                        spear6xx_defconfig
sh                               j2_defconfig
sh                        apsh4ad0a_defconfig
mips                             allyesconfig
powerpc                mpc7448_hpc2_defconfig
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
h8300                               defconfig
sh                          rsk7264_defconfig
sh                           se7619_defconfig
arm                      integrator_defconfig
microblaze                          defconfig
mips                        bcm47xx_defconfig
arm                        keystone_defconfig
i386                                defconfig
mips                         rt305x_defconfig
alpha                            alldefconfig
powerpc                      ep88xc_defconfig
arm                           imxrt_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                    klondike_defconfig
arm                         lpc18xx_defconfig
parisc64                            defconfig
mips                           jazz_defconfig
um                               alldefconfig
openrisc                    or1ksim_defconfig
m68k                       m5275evb_defconfig
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
parisc                generic-64bit_defconfig
sh                          lboxre2_defconfig
sparc64                             defconfig
powerpc                       maple_defconfig
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
sh                            shmin_defconfig
arc                     nsimosci_hs_defconfig
arc                           tb10x_defconfig
ia64                        generic_defconfig
sh                 kfr2r09-romimage_defconfig
arm                         nhk8815_defconfig
sh                          rsk7269_defconfig
m68k                        m5307c3_defconfig
arm                            zeus_defconfig
csky                                defconfig
sh                           se7721_defconfig
alpha                            allyesconfig
arm                          lpd270_defconfig
mips                        vocore2_defconfig
arm                             pxa_defconfig
arm                        cerfcube_defconfig
sparc                            allyesconfig
arm                       omap2plus_defconfig
mips                      fuloong2e_defconfig
nios2                         3c120_defconfig
m68k                        stmark2_defconfig
m68k                          sun3x_defconfig
powerpc                      chrp32_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
s390                          debug_defconfig
sh                      rts7751r2d1_defconfig
sh                        sh7785lcr_defconfig
powerpc                        cell_defconfig
arc                         haps_hs_defconfig
riscv             nommu_k210_sdcard_defconfig
openrisc                  or1klitex_defconfig
xtensa                    xip_kc705_defconfig
sh                          sdk7786_defconfig
arm                         s3c6400_defconfig
arm                           stm32_defconfig
arm                       aspeed_g5_defconfig
sh                        sh7757lcr_defconfig
sh                             sh03_defconfig
mips                     decstation_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     mpc83xx_defconfig
arm                         cm_x300_defconfig
powerpc                    amigaone_defconfig
mips                      maltasmvp_defconfig
xtensa                  audio_kc705_defconfig
m68k                            q40_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                            xcep_defconfig
arm                        oxnas_v6_defconfig
arm                            lart_defconfig
arm                       imx_v6_v7_defconfig
openrisc                 simple_smp_defconfig
powerpc                       eiger_defconfig
m68k                          multi_defconfig
arc                              alldefconfig
arm                        shmobile_defconfig
sh                             espt_defconfig
openrisc                            defconfig
sh                          urquell_defconfig
powerpc                      ppc40x_defconfig
powerpc                      arches_defconfig
m68k                         amcore_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                          amiga_defconfig
arm                         at91_dt_defconfig
sh                          sdk7780_defconfig
sh                           sh2007_defconfig
m68k                             alldefconfig
arm                            qcom_defconfig
riscv                    nommu_k210_defconfig
um                             i386_defconfig
mips                            ar7_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                    adder875_defconfig
ia64                            zx1_defconfig
m68k                             allyesconfig
microblaze                      mmu_defconfig
arc                                 defconfig
m68k                       m5475evb_defconfig
powerpc                    sam440ep_defconfig
sh                           se7722_defconfig
arm                          iop32x_defconfig
arm                            mps2_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220501
arm                  randconfig-c002-20220506
arm                  randconfig-c002-20220508
arm                  randconfig-c002-20220505
arm                  randconfig-c002-20220507
x86_64               randconfig-c001-20220502
i386                 randconfig-c001-20220502
arm                  randconfig-c002-20220502
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
i386                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a006-20220502
x86_64               randconfig-a001-20220502
x86_64               randconfig-a003-20220502
x86_64               randconfig-a002-20220502
x86_64               randconfig-a004-20220502
x86_64               randconfig-a005-20220502
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
arc                  randconfig-r043-20220501
s390                 randconfig-r044-20220501
riscv                randconfig-r042-20220501
arc                  randconfig-r043-20220502
arc                  randconfig-r043-20220505
s390                 randconfig-r044-20220505
riscv                randconfig-r042-20220505
arc                  randconfig-r043-20220507
s390                 randconfig-r044-20220507
riscv                randconfig-r042-20220507
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
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
mips                     loongson2k_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                    ge_imp3a_defconfig
arm                           omap1_defconfig
arm                          moxart_defconfig
arm                          collie_defconfig
mips                         tb0219_defconfig
powerpc                     mpc5200_defconfig
arm                       cns3420vb_defconfig
powerpc                    socrates_defconfig
mips                     cu1830-neo_defconfig
mips                      pic32mzda_defconfig
riscv                    nommu_virt_defconfig
powerpc                  mpc866_ads_defconfig
mips                  cavium_octeon_defconfig
arm                          ep93xx_defconfig
arm                        neponset_defconfig
powerpc                      katmai_defconfig
powerpc                          g5_defconfig
mips                      maltaaprp_defconfig
i386                             allyesconfig
powerpc                     ksi8560_defconfig
mips                          ath25_defconfig
mips                           rs90_defconfig
arm                           sama7_defconfig
hexagon                          alldefconfig
arm                         s3c2410_defconfig
arm                  colibri_pxa270_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      ppc44x_defconfig
powerpc                  mpc885_ads_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     skiroot_defconfig
powerpc                        fsp2_defconfig
powerpc                   microwatt_defconfig
mips                       lemote2f_defconfig
arm                         bcm2835_defconfig
mips                        workpad_defconfig
arm                       mainstone_defconfig
powerpc                 mpc832x_rdb_defconfig
hexagon                             defconfig
powerpc               mpc834x_itxgp_defconfig
arm                            dove_defconfig
powerpc                      pmac32_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                     tqm8540_defconfig
arm                            mmp2_defconfig
arm                     davinci_all_defconfig
arm                         lpc32xx_defconfig
arm                          ixp4xx_defconfig
mips                   sb1250_swarm_defconfig
arm                           spitz_defconfig
riscv                          rv32_defconfig
arm                        multi_v5_defconfig
powerpc                     kmeter1_defconfig
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
hexagon              randconfig-r045-20220502
riscv                randconfig-r042-20220502
hexagon              randconfig-r041-20220502
hexagon              randconfig-r045-20220501
hexagon              randconfig-r041-20220501
hexagon              randconfig-r045-20220509
hexagon              randconfig-r045-20220508
riscv                randconfig-r042-20220508
hexagon              randconfig-r041-20220509
hexagon              randconfig-r041-20220508

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

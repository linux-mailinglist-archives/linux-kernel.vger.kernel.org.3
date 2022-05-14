Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB9252703F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 11:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiENJ0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 05:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiENJ0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 05:26:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63FFA4
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 02:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652520393; x=1684056393;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=msbng25WvcKcKZBNZTNyxMRy/A6OGwJxnX7ebxFCKnY=;
  b=Vw3bJSwHbFsvU0tPFuvikF0wNMIASsr419c46YacklPEM50vWwCiivRX
   wbaQYdvKopxQ+Xs6TTRdqwXbgY+7FYKALfEiQZF03HB8kXxlK9dt2Kbzr
   /XuOr5ZZtdJpn3LyoN/H5h22GxobE/ojaX60WB6oQ6VwZx0/oNn6FMamB
   Tdu17aBBDr9eYtGEYKs7sZEqBIdQX+VqOw2p/xfV+ew19nrivHbaBaa2E
   hvrJhoNoKfr4MyqFcQq5UWB4OAU7TiTOlPs8t+ykQpZCtvlhUTSpllpvX
   U80KtIB1YC4wmK+CtEapby23QCf7sk5bt9LUj6bBzAw2pTXGks1GRF/Wc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="251015545"
X-IronPort-AV: E=Sophos;i="5.91,225,1647327600"; 
   d="scan'208";a="251015545"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 02:26:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,225,1647327600"; 
   d="scan'208";a="698822451"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 14 May 2022 02:26:30 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npo2g-0000QV-97;
        Sat, 14 May 2022 09:26:30 +0000
Date:   Sat, 14 May 2022 17:25:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp-stringop-overflow] BUILD SUCCESS
 336feb502a715909a8136eb6a62a83d7268a353b
Message-ID: <627f7591.fkxD/2UZSPf6Tpa0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp-stringop-overflow
branch HEAD: 336feb502a715909a8136eb6a62a83d7268a353b  drm/i915: Fix -Wstringop-overflow warning in call to intel_read_wm_latency()

elapsed time: 13757m

configs tested: 440
configs skipped: 4

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
i386                 randconfig-c001-20220509
arm                         lpc18xx_defconfig
sh                          rsk7269_defconfig
mips                          rb532_defconfig
powerpc                 mpc834x_mds_defconfig
s390                                defconfig
powerpc                  storcenter_defconfig
arm                         nhk8815_defconfig
arm                           stm32_defconfig
csky                                defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     tqm8555_defconfig
powerpc                     ep8248e_defconfig
nios2                            allyesconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
arc                          axs101_defconfig
h8300                       h8s-sim_defconfig
xtensa                generic_kc705_defconfig
powerpc                      arches_defconfig
mips                           ip32_defconfig
arm                          simpad_defconfig
arm                        cerfcube_defconfig
sh                          r7785rp_defconfig
sh                          urquell_defconfig
xtensa                         virt_defconfig
um                                  defconfig
m68k                       m5249evb_defconfig
ia64                         bigsur_defconfig
arm                            pleb_defconfig
xtensa                          iss_defconfig
xtensa                  audio_kc705_defconfig
xtensa                           alldefconfig
m68k                       m5275evb_defconfig
ia64                      gensparse_defconfig
xtensa                    xip_kc705_defconfig
h8300                     edosk2674_defconfig
arm                            hisi_defconfig
mips                        bcm47xx_defconfig
sh                              ul2_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7712_defconfig
powerpc                       eiger_defconfig
mips                           xway_defconfig
arm                        mini2440_defconfig
arm                        multi_v7_defconfig
m68k                        m5272c3_defconfig
sh                          rsk7201_defconfig
arm                         at91_dt_defconfig
arc                        nsim_700_defconfig
powerpc                 linkstation_defconfig
mips                             allyesconfig
mips                         tb0226_defconfig
arm                       omap2plus_defconfig
arm                        spear6xx_defconfig
ia64                             alldefconfig
sh                          rsk7203_defconfig
arm                          iop32x_defconfig
arm                         cm_x300_defconfig
arm                           h3600_defconfig
um                               alldefconfig
xtensa                  cadence_csp_defconfig
sh                        sh7763rdp_defconfig
arm                         axm55xx_defconfig
powerpc                     sequoia_defconfig
powerpc                 mpc8540_ads_defconfig
parisc64                         alldefconfig
m68k                            mac_defconfig
powerpc                        warp_defconfig
powerpc                     taishan_defconfig
sh                                  defconfig
sparc                       sparc64_defconfig
arm                       aspeed_g5_defconfig
ia64                        generic_defconfig
xtensa                  nommu_kc705_defconfig
mips                           ci20_defconfig
sh                           se7721_defconfig
arm                     eseries_pxa_defconfig
sh                           se7780_defconfig
powerpc                     pq2fads_defconfig
powerpc                    sam440ep_defconfig
sh                           se7619_defconfig
powerpc                      pasemi_defconfig
sparc64                             defconfig
arm                            zeus_defconfig
nios2                            alldefconfig
sh                           sh2007_defconfig
i386                                defconfig
sparc                       sparc32_defconfig
powerpc                      mgcoge_defconfig
arm                        clps711x_defconfig
powerpc                    adder875_defconfig
microblaze                      mmu_defconfig
sh                          polaris_defconfig
sh                            hp6xx_defconfig
sparc                            alldefconfig
arc                         haps_hs_defconfig
m68k                            q40_defconfig
arm                        keystone_defconfig
powerpc                 mpc85xx_cds_defconfig
parisc                generic-64bit_defconfig
sh                   secureedge5410_defconfig
m68k                          hp300_defconfig
ia64                          tiger_defconfig
m68k                          atari_defconfig
powerpc                           allnoconfig
arm                       imx_v6_v7_defconfig
m68k                           sun3_defconfig
openrisc                            defconfig
sh                        apsh4ad0a_defconfig
mips                         rt305x_defconfig
alpha                            alldefconfig
arm                        realview_defconfig
arm                         vf610m4_defconfig
sh                        sh7785lcr_defconfig
openrisc                    or1ksim_defconfig
m68k                          multi_defconfig
parisc64                            defconfig
powerpc                    klondike_defconfig
h8300                    h8300h-sim_defconfig
sh                   sh7724_generic_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                          sdk7780_defconfig
s390                             allyesconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
sh                         ecovec24_defconfig
mips                  maltasmvp_eva_defconfig
mips                            ar7_defconfig
powerpc                       holly_defconfig
arm                        trizeps4_defconfig
sparc                               defconfig
sh                           se7750_defconfig
arm                          exynos_defconfig
powerpc                     stx_gp3_defconfig
arm64                            alldefconfig
m68k                          sun3x_defconfig
arm                         lubbock_defconfig
s390                       zfcpdump_defconfig
arc                          axs103_defconfig
sh                         ap325rxa_defconfig
riscv                               defconfig
arc                     haps_hs_smp_defconfig
m68k                        mvme16x_defconfig
sh                           se7751_defconfig
parisc                           alldefconfig
arc                      axs103_smp_defconfig
arm                           h5000_defconfig
powerpc64                        alldefconfig
mips                      loongson3_defconfig
m68k                       bvme6000_defconfig
sh                        dreamcast_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                      cm5200_defconfig
arc                    vdk_hs38_smp_defconfig
sh                   rts7751r2dplus_defconfig
m68k                                defconfig
mips                             allmodconfig
nios2                         3c120_defconfig
xtensa                    smp_lx200_defconfig
sh                         microdev_defconfig
powerpc                      bamboo_defconfig
i386                             alldefconfig
m68k                        mvme147_defconfig
powerpc                      tqm8xx_defconfig
mips                           gcw0_defconfig
nios2                               defconfig
xtensa                       common_defconfig
m68k                             allmodconfig
powerpc                 mpc837x_mds_defconfig
arm                             ezx_defconfig
sh                          lboxre2_defconfig
sh                          kfr2r09_defconfig
sh                            migor_defconfig
sh                           se7206_defconfig
sh                             shx3_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                            mps2_defconfig
powerpc                      pcm030_defconfig
parisc                generic-32bit_defconfig
alpha                            allyesconfig
arm                        shmobile_defconfig
sh                               alldefconfig
arm                            qcom_defconfig
powerpc                        cell_defconfig
ia64                                defconfig
m68k                         amcore_defconfig
sh                            titan_defconfig
parisc                              defconfig
sh                        sh7757lcr_defconfig
powerpc                      ppc6xx_defconfig
m68k                          amiga_defconfig
m68k                             alldefconfig
parisc                           allyesconfig
arm                           tegra_defconfig
sh                           se7722_defconfig
openrisc                  or1klitex_defconfig
arm                        oxnas_v6_defconfig
sh                          r7780mp_defconfig
m68k                        stmark2_defconfig
powerpc                      chrp32_defconfig
sh                            shmin_defconfig
sh                     sh7710voipgw_defconfig
arm                          pxa910_defconfig
m68k                       m5208evb_defconfig
arc                     nsimosci_hs_defconfig
microblaze                          defconfig
powerpc                      ep88xc_defconfig
powerpc                   currituck_defconfig
sh                         apsh4a3a_defconfig
arm                           corgi_defconfig
powerpc                    amigaone_defconfig
sh                          landisk_defconfig
powerpc                       ppc64_defconfig
powerpc                         ps3_defconfig
arm                          lpd270_defconfig
arc                           tb10x_defconfig
arc                            hsdk_defconfig
mips                            gpr_defconfig
sh                           se7343_defconfig
powerpc                  iss476-smp_defconfig
powerpc                 mpc834x_itx_defconfig
arm                             rpc_defconfig
powerpc                         wii_defconfig
arc                        nsimosci_defconfig
arm                         s3c6400_defconfig
mips                         mpc30x_defconfig
m68k                       m5475evb_defconfig
mips                     loongson1b_defconfig
sh                             sh03_defconfig
sh                               j2_defconfig
riscv                    nommu_k210_defconfig
sh                           se7724_defconfig
powerpc                     tqm8548_defconfig
openrisc                         alldefconfig
sh                          sdk7786_defconfig
sh                          rsk7264_defconfig
powerpc                     tqm8541_defconfig
powerpc                       maple_defconfig
mips                       bmips_be_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220501
arm                  randconfig-c002-20220505
x86_64               randconfig-c001-20220509
arm                  randconfig-c002-20220509
arm                  randconfig-c002-20220512
arm                  randconfig-c002-20220506
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
arc                              allyesconfig
alpha                               defconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a004-20220502
i386                 randconfig-a006-20220502
i386                 randconfig-a002-20220502
i386                 randconfig-a003-20220502
i386                 randconfig-a001-20220502
i386                 randconfig-a005-20220502
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64               randconfig-a015-20220509
x86_64               randconfig-a012-20220509
x86_64               randconfig-a016-20220509
x86_64               randconfig-a014-20220509
x86_64               randconfig-a013-20220509
x86_64               randconfig-a011-20220509
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                 randconfig-a011-20220509
i386                 randconfig-a013-20220509
i386                 randconfig-a016-20220509
i386                 randconfig-a015-20220509
i386                 randconfig-a014-20220509
i386                 randconfig-a012-20220509
arc                  randconfig-r043-20220509
s390                 randconfig-r044-20220509
riscv                randconfig-r042-20220509
s390                 randconfig-r044-20220512
riscv                randconfig-r042-20220512
arc                  randconfig-r043-20220512
arc                  randconfig-r043-20220505
s390                 randconfig-r044-20220505
riscv                randconfig-r042-20220505
arc                  randconfig-r043-20220513
s390                 randconfig-r044-20220510
riscv                randconfig-r042-20220510
arc                  randconfig-r043-20220510
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64               randconfig-c007-20220509
s390                 randconfig-c005-20220509
i386                 randconfig-c001-20220509
powerpc              randconfig-c003-20220509
riscv                randconfig-c006-20220509
mips                 randconfig-c004-20220509
arm                  randconfig-c002-20220509
s390                 randconfig-c005-20220512
powerpc              randconfig-c003-20220512
x86_64                        randconfig-c007
riscv                randconfig-c006-20220512
mips                 randconfig-c004-20220512
i386                          randconfig-c001
arm                  randconfig-c002-20220512
powerpc              randconfig-c003-20220510
riscv                randconfig-c006-20220510
mips                 randconfig-c004-20220510
arm                  randconfig-c002-20220510
powerpc              randconfig-c003-20220505
riscv                randconfig-c006-20220505
arm                  randconfig-c002-20220505
mips                        bcm63xx_defconfig
powerpc                          allyesconfig
powerpc                     tqm5200_defconfig
arm                           omap1_defconfig
mips                     cu1830-neo_defconfig
powerpc                      acadia_defconfig
arm                  colibri_pxa300_defconfig
arm                          pcm027_defconfig
arm                         palmz72_defconfig
powerpc                    mvme5100_defconfig
arm                                 defconfig
powerpc                     ppa8548_defconfig
powerpc                      ppc64e_defconfig
x86_64                           allyesconfig
arm                         orion5x_defconfig
powerpc                          g5_defconfig
arm                          ep93xx_defconfig
mips                      maltaaprp_defconfig
arm                         socfpga_defconfig
powerpc                     akebono_defconfig
powerpc                     powernv_defconfig
powerpc                          allmodconfig
mips                       rbtx49xx_defconfig
mips                        maltaup_defconfig
arm                      pxa255-idp_defconfig
arm                  colibri_pxa270_defconfig
arm                        magician_defconfig
mips                  cavium_octeon_defconfig
mips                        omega2p_defconfig
arm                       netwinder_defconfig
riscv                    nommu_virt_defconfig
arm                           spitz_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                     pseries_defconfig
powerpc                     tqm8540_defconfig
riscv                             allnoconfig
arm                       mainstone_defconfig
mips                           mtx1_defconfig
powerpc                     tqm8560_defconfig
hexagon                             defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                            dove_defconfig
mips                          ath79_defconfig
powerpc                     skiroot_defconfig
arm                          ixp4xx_defconfig
arm                          collie_defconfig
arm                       versatile_defconfig
mips                        workpad_defconfig
arm                        mvebu_v5_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                          moxart_defconfig
powerpc                   lite5200b_defconfig
mips                     cu1000-neo_defconfig
mips                   sb1250_swarm_defconfig
powerpc                      ppc44x_defconfig
arm                         shannon_defconfig
arm                       aspeed_g4_defconfig
powerpc                       ebony_defconfig
arm                          pxa168_defconfig
powerpc                   bluestone_defconfig
x86_64               randconfig-a006-20220509
x86_64               randconfig-a002-20220509
x86_64               randconfig-a001-20220509
x86_64               randconfig-a004-20220509
x86_64               randconfig-a005-20220509
x86_64               randconfig-a003-20220509
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
x86_64               randconfig-a011-20220502
x86_64               randconfig-a012-20220502
x86_64               randconfig-a013-20220502
x86_64               randconfig-a016-20220502
x86_64               randconfig-a015-20220502
x86_64               randconfig-a014-20220502
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220509
hexagon              randconfig-r041-20220509
hexagon              randconfig-r045-20220512
hexagon              randconfig-r041-20220512
hexagon              randconfig-r045-20220501
hexagon              randconfig-r041-20220501
hexagon              randconfig-r045-20220502
riscv                randconfig-r042-20220502
hexagon              randconfig-r041-20220502

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

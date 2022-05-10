Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3CD520F47
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbiEJICf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237652AbiEJIC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:02:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439131E655E
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 00:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652169510; x=1683705510;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Jdgk2FVBxn81HU9EmVJToM5xbgQ0CfvgIiL86ffOkA0=;
  b=c1LRQNj3fpik1NK0TyCRDv0Dv+2nDkGdwKCbIYicwBEpxgRwpMYqjbRB
   OjMdxit3kjY4/CXUsOic2Qpfd3QfvaJRBmerQbBI+E/p5x6Yb09pjvr1+
   k0ydDXsd1MIG19XPavX6TuLj4xNeqEtH0BRVQaiy/N4ASloWe2z0qeOyP
   nA2vF+pRlGyT63MD8yJuFMX0mEjSJ/hsemQLVbjoWp7RC1QBm7atE7Cep
   RvpIpYnWUEDOfvUoMakgt+yKD1dGzRTJr/WDOJQr0ieVryNP9k4tqGFOU
   laj5baeiqwYRwcIKjlNq7U/IRA0DdzPCs5+f7J1pJYP82L2A7LyEpB+Gh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="269434963"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="269434963"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 00:58:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="602349956"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 10 May 2022 00:58:17 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noKl6-000HWU-MA;
        Tue, 10 May 2022 07:58:16 +0000
Date:   Tue, 10 May 2022 15:57:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 bfba784d68464a8e4a5c1e8a25bc0ce4fd7c78b0
Message-ID: <627a1ade.C83P8cC7LsUa0CqC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: bfba784d68464a8e4a5c1e8a25bc0ce4fd7c78b0  rcu: Add rnp->cbovldmask check in rcutree_migrate_callbacks()

elapsed time: 5889m

configs tested: 368
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
i386                 randconfig-c001-20220509
arm                        clps711x_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                         tb0226_defconfig
m68k                             allmodconfig
xtensa                       common_defconfig
arm                      jornada720_defconfig
arm                           h5000_defconfig
m68k                          hp300_defconfig
alpha                            alldefconfig
arm                         nhk8815_defconfig
sh                ecovec24-romimage_defconfig
arm                           sunxi_defconfig
ia64                             alldefconfig
arm                          exynos_defconfig
h8300                    h8300h-sim_defconfig
arm                        multi_v7_defconfig
powerpc                      mgcoge_defconfig
xtensa                    smp_lx200_defconfig
ia64                      gensparse_defconfig
sh                              ul2_defconfig
mips                           ci20_defconfig
sparc                       sparc64_defconfig
nios2                         3c120_defconfig
sh                           se7619_defconfig
m68k                       m5249evb_defconfig
m68k                       m5475evb_defconfig
arm                            pleb_defconfig
mips                          rb532_defconfig
riscv                               defconfig
powerpc                     sequoia_defconfig
arc                          axs103_defconfig
powerpc                      makalu_defconfig
arm                         axm55xx_defconfig
powerpc                 linkstation_defconfig
sh                             sh03_defconfig
sh                   sh7724_generic_defconfig
m68k                          atari_defconfig
powerpc                      cm5200_defconfig
powerpc                       eiger_defconfig
ia64                         bigsur_defconfig
powerpc                     redwood_defconfig
mips                  decstation_64_defconfig
h8300                       h8s-sim_defconfig
sh                          kfr2r09_defconfig
sh                           se7712_defconfig
arm                       omap2plus_defconfig
csky                                defconfig
xtensa                  cadence_csp_defconfig
ia64                        generic_defconfig
arm                            qcom_defconfig
arc                     nsimosci_hs_defconfig
arm                        spear6xx_defconfig
x86_64                           alldefconfig
powerpc                     tqm8548_defconfig
m68k                       bvme6000_defconfig
sh                           se7705_defconfig
mips                       bmips_be_defconfig
arm                         lubbock_defconfig
parisc                           alldefconfig
sh                          urquell_defconfig
sh                          landisk_defconfig
xtensa                  nommu_kc705_defconfig
arm                             rpc_defconfig
mips                         cobalt_defconfig
s390                       zfcpdump_defconfig
m68k                           sun3_defconfig
sh                          sdk7780_defconfig
arc                        nsim_700_defconfig
sh                         ecovec24_defconfig
sh                               allmodconfig
sh                        dreamcast_defconfig
mips                 decstation_r4k_defconfig
powerpc64                        alldefconfig
arc                        nsimosci_defconfig
um                           x86_64_defconfig
arc                              alldefconfig
mips                           jazz_defconfig
sh                     magicpanelr2_defconfig
powerpc                     tqm8555_defconfig
sh                         ap325rxa_defconfig
x86_64                              defconfig
mips                      loongson3_defconfig
sparc                            alldefconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     ep8248e_defconfig
sh                             espt_defconfig
arm                       multi_v4t_defconfig
arm                             ezx_defconfig
arm                        mini2440_defconfig
xtensa                              defconfig
arm                           sama5_defconfig
mips                    maltaup_xpa_defconfig
powerpc64                           defconfig
arc                        vdk_hs38_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                         microdev_defconfig
sh                               j2_defconfig
powerpc                       holly_defconfig
mips                        vocore2_defconfig
powerpc                     stx_gp3_defconfig
um                               alldefconfig
openrisc                    or1ksim_defconfig
sh                          polaris_defconfig
sh                        sh7763rdp_defconfig
powerpc                         wii_defconfig
arm                           viper_defconfig
mips                             allmodconfig
powerpc                    klondike_defconfig
arm                        realview_defconfig
h8300                            allyesconfig
powerpc                     rainier_defconfig
sparc                               defconfig
sh                           se7750_defconfig
sh                                  defconfig
xtensa                  audio_kc705_defconfig
mips                         mpc30x_defconfig
arm                            zeus_defconfig
arm                     eseries_pxa_defconfig
powerpc                  storcenter_defconfig
sh                           se7343_defconfig
parisc                generic-32bit_defconfig
alpha                               defconfig
powerpc                      pasemi_defconfig
mips                         bigsur_defconfig
sh                   rts7751r2dplus_defconfig
arm                      footbridge_defconfig
m68k                       m5208evb_defconfig
mips                      fuloong2e_defconfig
powerpc                      ep88xc_defconfig
sh                          rsk7269_defconfig
m68k                        m5307c3_defconfig
arm                      integrator_defconfig
nios2                         10m50_defconfig
arm                          gemini_defconfig
powerpc                      pcm030_defconfig
sh                           se7721_defconfig
alpha                            allyesconfig
arm                          lpd270_defconfig
sh                           sh2007_defconfig
arm                         at91_dt_defconfig
xtensa                           allyesconfig
arm                          badge4_defconfig
arc                           tb10x_defconfig
microblaze                          defconfig
mips                         db1xxx_defconfig
powerpc                   currituck_defconfig
mips                      maltasmvp_defconfig
m68k                          sun3x_defconfig
powerpc                      chrp32_defconfig
powerpc                    adder875_defconfig
sparc64                             defconfig
nios2                            allyesconfig
sh                        apsh4ad0a_defconfig
sh                          lboxre2_defconfig
powerpc                     taishan_defconfig
powerpc                      ppc6xx_defconfig
sh                          sdk7786_defconfig
arm                         lpc18xx_defconfig
arm                         s3c6400_defconfig
arm                           stm32_defconfig
arm                       aspeed_g5_defconfig
m68k                        stmark2_defconfig
arm                          pxa3xx_defconfig
m68k                        m5272c3_defconfig
arm                         cm_x300_defconfig
nios2                            alldefconfig
arm                            lart_defconfig
powerpc                     pq2fads_defconfig
sh                 kfr2r09-romimage_defconfig
arm                       imx_v6_v7_defconfig
openrisc                 simple_smp_defconfig
mips                        bcm47xx_defconfig
arm                        cerfcube_defconfig
m68k                          multi_defconfig
arm                        shmobile_defconfig
sh                           se7724_defconfig
sh                           se7780_defconfig
sh                        edosk7705_defconfig
m68k                         amcore_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                          amiga_defconfig
parisc                generic-64bit_defconfig
i386                                defconfig
powerpc                      ppc40x_defconfig
arm                        mvebu_v7_defconfig
powerpc                      tqm8xx_defconfig
sh                         apsh4a3a_defconfig
arm                           corgi_defconfig
mips                            ar7_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                      arches_defconfig
ia64                            zx1_defconfig
s390                                defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     asp8347_defconfig
h8300                               defconfig
powerpc                    sam440ep_defconfig
sh                           se7722_defconfig
arm                          iop32x_defconfig
openrisc                            defconfig
arm                            hisi_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                  maltasmvp_eva_defconfig
um                                  defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220506
arm                  randconfig-c002-20220508
x86_64               randconfig-c001-20220509
arm                  randconfig-c002-20220509
arm                  randconfig-c002-20220507
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
arc                                 defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
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
arc                  randconfig-r043-20220507
s390                 randconfig-r044-20220507
riscv                randconfig-r042-20220507
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220506
riscv                randconfig-c006-20220506
mips                 randconfig-c004-20220506
arm                  randconfig-c002-20220506
s390                 randconfig-c005-20220506
powerpc              randconfig-c003-20220507
riscv                randconfig-c006-20220507
mips                 randconfig-c004-20220507
arm                  randconfig-c002-20220507
powerpc              randconfig-c003-20220508
riscv                randconfig-c006-20220508
mips                 randconfig-c004-20220508
arm                  randconfig-c002-20220508
x86_64               randconfig-c007-20220509
i386                 randconfig-c001-20220509
powerpc              randconfig-c003-20220509
riscv                randconfig-c006-20220509
arm                  randconfig-c002-20220509
mips                 randconfig-c004-20220509
mips                         tb0219_defconfig
powerpc                     mpc5200_defconfig
arm                       cns3420vb_defconfig
arm                          collie_defconfig
powerpc                     tqm5200_defconfig
arm                                 defconfig
mips                      pic32mzda_defconfig
i386                             allyesconfig
powerpc                     ksi8560_defconfig
mips                          ath25_defconfig
mips                           rs90_defconfig
mips                          ath79_defconfig
powerpc                      ppc64e_defconfig
mips                        workpad_defconfig
arm                          pcm027_defconfig
arm                      pxa255-idp_defconfig
hexagon                             defconfig
arm                        vexpress_defconfig
arm                     davinci_all_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     skiroot_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                      walnut_defconfig
arm                     am200epdkit_defconfig
mips                            e55_defconfig
mips                      malta_kvm_defconfig
mips                       lemote2f_defconfig
arm                       aspeed_g4_defconfig
arm                       versatile_defconfig
arm                         s3c2410_defconfig
arm                            mmp2_defconfig
arm                            dove_defconfig
arm                         lpc32xx_defconfig
arm                          ixp4xx_defconfig
powerpc                     tqm8560_defconfig
mips                   sb1250_swarm_defconfig
arm                           spitz_defconfig
mips                     loongson1c_defconfig
mips                     cu1830-neo_defconfig
mips                     cu1000-neo_defconfig
arm                        neponset_defconfig
powerpc                   lite5200b_defconfig
arm                         s5pv210_defconfig
mips                malta_qemu_32r6_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64               randconfig-a006-20220509
x86_64               randconfig-a002-20220509
x86_64               randconfig-a001-20220509
x86_64               randconfig-a004-20220509
x86_64               randconfig-a005-20220509
x86_64               randconfig-a003-20220509
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
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220506
riscv                randconfig-r042-20220506
hexagon              randconfig-r041-20220506
hexagon              randconfig-r045-20220509
hexagon              randconfig-r041-20220509
hexagon              randconfig-r045-20220508
riscv                randconfig-r042-20220508
hexagon              randconfig-r041-20220508

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

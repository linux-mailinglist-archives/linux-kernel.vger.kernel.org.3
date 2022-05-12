Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0B7524F24
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354875AbiELOAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354887AbiELOAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:00:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193E925AFBA
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652364029; x=1683900029;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=MnBBuPlzlcmYGLUURRcUQR/B+Xu86mdNzBeu/09swZY=;
  b=dyJXTjOAb57ExbJz8yIVH5sP8nqh13W3mfUs39cL4zaicFBJ6Ln7jyTo
   1yoVK0Rt9ND+0xII+rKfyBGsZQhtIZc5B2Dc8v7TbL+zqpcnPo18l9y6i
   6gKgMWMvioRifIw8cXMPns3fw+rDMLGRupNcKPJ3wgks3qNUPGm0azuMy
   xhRl7JYnmtmVuZHkRG8q203PRs6OE+xsSvOQMZ9mQA9PgDGOl1Y93aBac
   XlQnLvFu0vSzTgZzjrYQbo5IPpggmW1U5YEvcA0EcEQ6yayGiatsKSN+7
   Q9KIeBCN7JNvmgVm2wnh+xsGgubcordK4wZbm9vI2SELKXHEh/G7HVcym
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="330610872"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="330610872"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 07:00:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="572534828"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 12 May 2022 07:00:26 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1np9Mf-000KVd-9s;
        Thu, 12 May 2022 14:00:25 +0000
Date:   Thu, 12 May 2022 21:59:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 792ea6a074ae7ea5ab6f1b8b31f76bb0297de66c
Message-ID: <627d12d3.iJyEzJSNEqq43nQ6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,TRACKER_ID,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: 792ea6a074ae7ea5ab6f1b8b31f76bb0297de66c  genirq: Remove WARN_ON_ONCE() in generic_handle_domain_irq()

elapsed time: 2215m

configs tested: 313
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
arm64                               defconfig
i386                 randconfig-c001-20220509
i386                          randconfig-c001
sh                               j2_defconfig
sh                         ap325rxa_defconfig
sh                      rts7751r2d1_defconfig
arm                       imx_v6_v7_defconfig
powerpc                       ppc64_defconfig
xtensa                  cadence_csp_defconfig
sh                           se7705_defconfig
ia64                            zx1_defconfig
arm                         lpc18xx_defconfig
sh                          rsk7269_defconfig
mips                          rb532_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
arc                          axs101_defconfig
h8300                       h8s-sim_defconfig
xtensa                generic_kc705_defconfig
mips                       capcella_defconfig
xtensa                         virt_defconfig
um                                  defconfig
m68k                       m5249evb_defconfig
sh                          urquell_defconfig
ia64                         bigsur_defconfig
arm                            pleb_defconfig
xtensa                          iss_defconfig
powerpc                       eiger_defconfig
mips                           xway_defconfig
powerpc                      pasemi_defconfig
arm                        mini2440_defconfig
arm                        multi_v7_defconfig
m68k                        m5272c3_defconfig
sh                          rsk7201_defconfig
arm                         at91_dt_defconfig
arc                        nsim_700_defconfig
powerpc                 linkstation_defconfig
arm                       omap2plus_defconfig
ia64                             alldefconfig
sh                          rsk7203_defconfig
arm                        spear6xx_defconfig
h8300                            allyesconfig
arm                           h3600_defconfig
arm                          iop32x_defconfig
arm                         cm_x300_defconfig
um                               alldefconfig
parisc64                         alldefconfig
m68k                            mac_defconfig
powerpc                        warp_defconfig
powerpc                     taishan_defconfig
sh                          r7785rp_defconfig
sh                                  defconfig
powerpc                  storcenter_defconfig
sparc                       sparc64_defconfig
arm                       aspeed_g5_defconfig
ia64                        generic_defconfig
xtensa                  nommu_kc705_defconfig
arm                           stm32_defconfig
powerpc                    sam440ep_defconfig
sh                           se7619_defconfig
sparc64                             defconfig
arm                            zeus_defconfig
nios2                            alldefconfig
sh                           se7721_defconfig
sh                           sh2007_defconfig
i386                                defconfig
m68k                             allmodconfig
powerpc                     sequoia_defconfig
sh                          polaris_defconfig
sh                            hp6xx_defconfig
sparc                            alldefconfig
arc                         haps_hs_defconfig
arm                        keystone_defconfig
openrisc                            defconfig
arm                          pxa910_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                        sh7763rdp_defconfig
sh                   sh7724_generic_defconfig
powerpc                mpc7448_hpc2_defconfig
h8300                    h8300h-sim_defconfig
nios2                            allyesconfig
m68k                          multi_defconfig
sh                          sdk7780_defconfig
s390                             allyesconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
sh                         ecovec24_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                 mpc8540_ads_defconfig
sparc                       sparc32_defconfig
sh                           se7750_defconfig
arm                          exynos_defconfig
s390                                defconfig
arm                         lubbock_defconfig
csky                                defconfig
s390                       zfcpdump_defconfig
arc                          axs103_defconfig
sh                           se7751_defconfig
parisc                           alldefconfig
arc                      axs103_smp_defconfig
m68k                       m5208evb_defconfig
powerpc                      pcm030_defconfig
arc                    vdk_hs38_smp_defconfig
arm                           sunxi_defconfig
sh                         apsh4a3a_defconfig
xtensa                    xip_kc705_defconfig
mips                         tb0226_defconfig
powerpc                 canyonlands_defconfig
mips                            ar7_defconfig
xtensa                    smp_lx200_defconfig
sh                         microdev_defconfig
nios2                               defconfig
powerpc                      tqm8xx_defconfig
mips                           gcw0_defconfig
arm                          simpad_defconfig
xtensa                       common_defconfig
powerpc                 mpc837x_mds_defconfig
sh                          kfr2r09_defconfig
sh                            migor_defconfig
powerpc                     tqm8555_defconfig
powerpc                      cm5200_defconfig
arm                            mps2_defconfig
parisc                generic-32bit_defconfig
alpha                            allyesconfig
m68k                        mvme147_defconfig
powerpc                        cell_defconfig
ia64                                defconfig
powerpc                      ppc6xx_defconfig
m68k                          amiga_defconfig
m68k                             alldefconfig
sh                          lboxre2_defconfig
mips                        bcm47xx_defconfig
arm                         axm55xx_defconfig
arm                           tegra_defconfig
sh                        sh7757lcr_defconfig
sh                           se7722_defconfig
openrisc                  or1klitex_defconfig
m68k                        m5407c3_defconfig
riscv                               defconfig
xtensa                           alldefconfig
powerpc                   currituck_defconfig
sh                     sh7710voipgw_defconfig
sh                          r7780mp_defconfig
m68k                        stmark2_defconfig
m68k                       bvme6000_defconfig
sh                           se7206_defconfig
sh                            shmin_defconfig
ia64                          tiger_defconfig
sh                        apsh4ad0a_defconfig
arm                         assabet_defconfig
mips                            gpr_defconfig
microblaze                          defconfig
powerpc                      ep88xc_defconfig
powerpc                    adder875_defconfig
powerpc                         ps3_defconfig
ia64                      gensparse_defconfig
arm                          lpd270_defconfig
arc                           tb10x_defconfig
arc                            hsdk_defconfig
powerpc                  iss476-smp_defconfig
powerpc                 mpc834x_itx_defconfig
arm                             rpc_defconfig
riscv                    nommu_k210_defconfig
sh                           se7724_defconfig
powerpc                     tqm8548_defconfig
openrisc                         alldefconfig
powerpc                     tqm8541_defconfig
powerpc                       maple_defconfig
sh                           se7712_defconfig
x86_64               randconfig-c001-20220509
arm                  randconfig-c002-20220509
x86_64                        randconfig-c001
arm                  randconfig-c002-20220512
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                                defconfig
arc                              allyesconfig
alpha                               defconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
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
x86_64               randconfig-a015-20220509
x86_64               randconfig-a012-20220509
x86_64               randconfig-a016-20220509
x86_64               randconfig-a014-20220509
x86_64               randconfig-a013-20220509
x86_64               randconfig-a011-20220509
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                 randconfig-a011-20220509
i386                 randconfig-a013-20220509
i386                 randconfig-a016-20220509
i386                 randconfig-a015-20220509
i386                 randconfig-a014-20220509
i386                 randconfig-a012-20220509
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220509
s390                 randconfig-r044-20220509
riscv                randconfig-r042-20220509
s390                 randconfig-r044-20220512
riscv                randconfig-r042-20220512
arc                  randconfig-r043-20220512
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
i386                 randconfig-c001-20220509
powerpc              randconfig-c003-20220509
riscv                randconfig-c006-20220509
mips                 randconfig-c004-20220509
arm                  randconfig-c002-20220509
s390                 randconfig-c005-20220509
powerpc              randconfig-c003-20220510
x86_64                        randconfig-c007
riscv                randconfig-c006-20220510
mips                 randconfig-c004-20220510
i386                          randconfig-c001
arm                  randconfig-c002-20220510
s390                 randconfig-c005-20220510
s390                 randconfig-c005-20220512
powerpc              randconfig-c003-20220512
riscv                randconfig-c006-20220512
mips                 randconfig-c004-20220512
arm                  randconfig-c002-20220512
mips                        bcm63xx_defconfig
arm                           omap1_defconfig
mips                     cu1830-neo_defconfig
powerpc                      acadia_defconfig
powerpc                    mvme5100_defconfig
arm                                 defconfig
arm                       imx_v4_v5_defconfig
powerpc                     ppa8548_defconfig
powerpc                 mpc836x_mds_defconfig
arm                         socfpga_defconfig
powerpc                     akebono_defconfig
powerpc                     powernv_defconfig
powerpc                          allmodconfig
mips                       rbtx49xx_defconfig
mips                        maltaup_defconfig
mips                      maltaaprp_defconfig
mips                        omega2p_defconfig
arm                       netwinder_defconfig
powerpc                          g5_defconfig
powerpc                     tqm8560_defconfig
hexagon                             defconfig
powerpc                 xes_mpc85xx_defconfig
mips                          ath79_defconfig
powerpc                     skiroot_defconfig
arm                          ixp4xx_defconfig
arm                  colibri_pxa300_defconfig
arm                       versatile_defconfig
arm                         shannon_defconfig
arm                       aspeed_g4_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                          collie_defconfig
arm                          pxa168_defconfig
x86_64               randconfig-a006-20220509
x86_64               randconfig-a002-20220509
x86_64               randconfig-a001-20220509
x86_64               randconfig-a004-20220509
x86_64               randconfig-a005-20220509
x86_64               randconfig-a003-20220509
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                 randconfig-a004-20220509
i386                 randconfig-a006-20220509
i386                 randconfig-a002-20220509
i386                 randconfig-a003-20220509
i386                 randconfig-a001-20220509
i386                 randconfig-a005-20220509
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220509
hexagon              randconfig-r041-20220509
hexagon              randconfig-r045-20220512
hexagon              randconfig-r041-20220512

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

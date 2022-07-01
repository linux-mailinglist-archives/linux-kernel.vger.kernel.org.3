Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DD5562B1B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 07:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbiGAFyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 01:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbiGAFyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 01:54:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CE348831
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 22:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656654871; x=1688190871;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VGxnXhoXPT+JlOfq+CHOfRADeAb0C3EHj6fWRepCg90=;
  b=Z+HX71S+LOtLhUOKJ64HaKuOKOcgq/7H53yTMPsTZ5n08syH7m5wW3d2
   DsZ2gBtXfkVXyykTkA6bGS3g0ywFDtc8iqcy66Ox8um2xFwQSRUp4yYLP
   oBwfhcvtWmC6+S6WGaHC247ILrSM0NJgkQhVpqj5Xw4lbtC3DTAxpL58q
   vkvS653A46pLVH0HWj20WvkhCvLZtucjJWqPisCdxKO5mMIHJrk3SAQlO
   nGfR4hx8mYBbJl12plxaleYFoRH2joheJ3MEOWR+7A20LxcfK4hv5s5S7
   UfoHOloxSW5B9YSmdNrwAJ9Of6xbSAxpdc/18bR/w7czoD391fzpCtfR3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="265591564"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="265591564"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 22:54:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="918345199"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jun 2022 22:54:29 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o79bo-000Dcf-MJ;
        Fri, 01 Jul 2022 05:54:28 +0000
Date:   Fri, 01 Jul 2022 13:54:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.06.21a] BUILD SUCCESS
 5ddf65777c8d0f60ff9137eef3b23dd4c77e6108
Message-ID: <62be8bf9.TR+ACKd06uv/UHhl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.06.21a
branch HEAD: 5ddf65777c8d0f60ff9137eef3b23dd4c77e6108  rcu: Update rcu_preempt_deferred_qs() comments for !PREEMPT kernels

elapsed time: 4737m

configs tested: 195
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                 randconfig-c001-20220627
i386                          randconfig-c001
sh                   sh7724_generic_defconfig
powerpc                 mpc85xx_cds_defconfig
riscv                               defconfig
mips                           gcw0_defconfig
openrisc                            defconfig
sh                          urquell_defconfig
mips                      maltasmvp_defconfig
xtensa                  audio_kc705_defconfig
sh                              ul2_defconfig
sh                               j2_defconfig
sh                           se7343_defconfig
parisc64                         alldefconfig
powerpc                      ppc40x_defconfig
arm                        realview_defconfig
arm                            pleb_defconfig
parisc64                            defconfig
arm                          pxa910_defconfig
m68k                       m5208evb_defconfig
powerpc                      ppc6xx_defconfig
m68k                       bvme6000_defconfig
mips                        bcm47xx_defconfig
sh                          rsk7203_defconfig
sparc64                          alldefconfig
i386                             alldefconfig
powerpc                         ps3_defconfig
m68k                        stmark2_defconfig
arm                            mps2_defconfig
arm                          simpad_defconfig
sh                ecovec24-romimage_defconfig
arm                            hisi_defconfig
arm                      integrator_defconfig
arc                              alldefconfig
arc                     nsimosci_hs_defconfig
m68k                         amcore_defconfig
sh                          landisk_defconfig
m68k                       m5475evb_defconfig
sh                               alldefconfig
mips                        vocore2_defconfig
arm                        cerfcube_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                 mpc837x_mds_defconfig
sh                           se7712_defconfig
arm                      jornada720_defconfig
sh                           se7721_defconfig
m68k                             allmodconfig
sh                  sh7785lcr_32bit_defconfig
arm                             ezx_defconfig
powerpc                       holly_defconfig
arm                           stm32_defconfig
arm                         axm55xx_defconfig
mips                           ip32_defconfig
powerpc                     tqm8548_defconfig
sh                         apsh4a3a_defconfig
parisc                generic-64bit_defconfig
mips                     loongson1b_defconfig
ia64                         bigsur_defconfig
arm                       aspeed_g5_defconfig
sh                   sh7770_generic_defconfig
arc                            hsdk_defconfig
arm                         cm_x300_defconfig
riscv                            allyesconfig
arc                           tb10x_defconfig
sh                          r7785rp_defconfig
powerpc                 mpc834x_itx_defconfig
sh                         microdev_defconfig
mips                          rb532_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
powerpc                          allyesconfig
riscv                            allmodconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc                           allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
riscv                    nommu_k210_defconfig
x86_64               randconfig-c001-20220627
arm                  randconfig-c002-20220627
x86_64                        randconfig-c001
arm                  randconfig-c002-20220629
ia64                             allmodconfig
x86_64               randconfig-k001-20220627
m68k                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a013-20220627
x86_64               randconfig-a012-20220627
x86_64               randconfig-a016-20220627
x86_64               randconfig-a015-20220627
x86_64               randconfig-a011-20220627
x86_64               randconfig-a014-20220627
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                 randconfig-a014-20220627
i386                 randconfig-a011-20220627
i386                 randconfig-a012-20220627
i386                 randconfig-a015-20220627
i386                 randconfig-a016-20220627
i386                 randconfig-a013-20220627
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220627
s390                 randconfig-r044-20220627
riscv                randconfig-r042-20220627
riscv                randconfig-r042-20220629
arc                  randconfig-r043-20220629
s390                 randconfig-r044-20220629
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                  cavium_octeon_defconfig
powerpc                 mpc836x_mds_defconfig
mips                        maltaup_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                      ppc44x_defconfig
arm                         orion5x_defconfig
arm                         mv78xx0_defconfig
arm                         s5pv210_defconfig
arm                            mmp2_defconfig
powerpc                      ppc64e_defconfig
arm                       imx_v4_v5_defconfig
arm                         palmz72_defconfig
powerpc                          allmodconfig
arm                      pxa255-idp_defconfig
arm                            dove_defconfig
mips                       lemote2f_defconfig
arm                         lpc32xx_defconfig
arm                       netwinder_defconfig
arm                        neponset_defconfig
mips                       rbtx49xx_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                     mpc512x_defconfig
powerpc                        fsp2_defconfig
x86_64                        randconfig-k001
x86_64               randconfig-a002-20220627
x86_64               randconfig-a003-20220627
x86_64               randconfig-a001-20220627
x86_64               randconfig-a005-20220627
x86_64               randconfig-a004-20220627
x86_64               randconfig-a006-20220627
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a001-20220627
i386                 randconfig-a002-20220627
i386                 randconfig-a004-20220627
i386                 randconfig-a006-20220627
i386                 randconfig-a003-20220627
i386                 randconfig-a005-20220627
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220629
hexagon              randconfig-r045-20220629
hexagon              randconfig-r041-20220627
hexagon              randconfig-r045-20220627

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

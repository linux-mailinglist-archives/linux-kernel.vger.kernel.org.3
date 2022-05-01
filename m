Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E658951638A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 12:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241910AbiEAKMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 06:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236183AbiEAKL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 06:11:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D91A5C840
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 03:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651399714; x=1682935714;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Ao8ObVO4AL0MsV6xJYW+b+xG1LwqAROXlIcBbwxjnHA=;
  b=GodcD2g3Trf7MmaJ6Xj9ePJYoHr9Ya54sVEqenoIEvXRcCz1fabS8cLz
   Ux3hemTozZZvi/yJqwfW3GGFuGf2XM8eqMNI2n8gR+dtzJKsQkAoCm0XN
   TImelHafT/g99n5c1JMcCKzqmXfXnu9fUPoP2Gx1hU8t56GthtKdtGnOz
   wkrBbEA5VlEb5CYDYoxuYmKwp/aqNNOL6F2mUGUGiFF1vgbtL4/pIL6jK
   gGTRSVb+exHgJmYgzlNfrgMrtDM6YMTtsH7NYfxTPCBWdUlkxvQEsjUU7
   yGrOv0YzezSD0jLmu0CpFw+QS+od6IBd1FUvZnk2TkqdFMlZ4Col7fH5b
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="264582332"
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="264582332"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 03:08:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="545033784"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 01 May 2022 03:08:32 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nl6VD-0008fr-PG;
        Sun, 01 May 2022 10:08:31 +0000
Date:   Sun, 01 May 2022 18:07:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 62c1256d544747b38e77ca9b5bfe3a26f9592576
Message-ID: <626e5beb.JnxOVZm97dbT2M4H%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git timers/core
branch HEAD: 62c1256d544747b38e77ca9b5bfe3a26f9592576  timers/nohz: Switch to ONESHOT_STOPPED in the low-res handler when the tick is stopped

elapsed time: 8427m

configs tested: 268
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
mips                 randconfig-c004-20220425
i386                 randconfig-c001-20220425
powerpc              randconfig-c003-20220428
i386                          randconfig-c001
ia64                          tiger_defconfig
sh                            shmin_defconfig
mips                           ip32_defconfig
mips                     decstation_defconfig
m68k                            q40_defconfig
arm                           corgi_defconfig
sh                           se7724_defconfig
parisc                generic-32bit_defconfig
powerpc                    amigaone_defconfig
powerpc                       ppc64_defconfig
um                               alldefconfig
powerpc                      makalu_defconfig
sh                        sh7785lcr_defconfig
sh                               j2_defconfig
arm                        cerfcube_defconfig
sh                           se7751_defconfig
arm                         assabet_defconfig
arm                      integrator_defconfig
arc                              alldefconfig
arm                           sunxi_defconfig
arm                         lubbock_defconfig
m68k                                defconfig
sh                          sdk7780_defconfig
powerpc                     tqm8555_defconfig
powerpc                     ep8248e_defconfig
s390                                defconfig
mips                         tb0226_defconfig
sh                        edosk7760_defconfig
powerpc                 mpc834x_mds_defconfig
arc                            hsdk_defconfig
mips                          rb532_defconfig
mips                        vocore2_defconfig
powerpc                      ppc6xx_defconfig
arm                       multi_v4t_defconfig
arm                      jornada720_defconfig
sh                           se7619_defconfig
mips                  maltasmvp_eva_defconfig
sh                     magicpanelr2_defconfig
nios2                               defconfig
powerpc                     taishan_defconfig
sparc                       sparc64_defconfig
ia64                         bigsur_defconfig
m68k                          sun3x_defconfig
arm                         nhk8815_defconfig
powerpc                        cell_defconfig
xtensa                generic_kc705_defconfig
openrisc                  or1klitex_defconfig
m68k                       bvme6000_defconfig
xtensa                           allyesconfig
powerpc                     tqm8541_defconfig
powerpc                       holly_defconfig
mips                            gpr_defconfig
m68k                       m5249evb_defconfig
arm                          iop32x_defconfig
xtensa                              defconfig
sparc                               defconfig
arm                        mini2440_defconfig
sh                ecovec24-romimage_defconfig
m68k                        m5272c3_defconfig
sh                             shx3_defconfig
sh                           se7780_defconfig
mips                      maltasmvp_defconfig
arc                     nsimosci_hs_defconfig
xtensa                           alldefconfig
arm                          gemini_defconfig
sh                          landisk_defconfig
arm                         lpc18xx_defconfig
arc                         haps_hs_defconfig
m68k                       m5208evb_defconfig
xtensa                  cadence_csp_defconfig
parisc                              defconfig
powerpc                     tqm8548_defconfig
sh                         ecovec24_defconfig
arm                            qcom_defconfig
sh                   sh7724_generic_defconfig
mips                     loongson1b_defconfig
m68k                        m5307c3_defconfig
powerpc                    adder875_defconfig
mips                            ar7_defconfig
arm                          lpd270_defconfig
ia64                            zx1_defconfig
arm                          simpad_defconfig
sh                           se7206_defconfig
nios2                            allyesconfig
sh                        edosk7705_defconfig
arm                        multi_v7_defconfig
microblaze                          defconfig
powerpc                     pq2fads_defconfig
m68k                        mvme147_defconfig
xtensa                          iss_defconfig
h8300                       h8s-sim_defconfig
sh                             sh03_defconfig
sparc64                          alldefconfig
sh                           se7750_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                       aspeed_g5_defconfig
arm                         cm_x300_defconfig
sh                      rts7751r2d1_defconfig
sparc64                             defconfig
powerpc                  storcenter_defconfig
arc                      axs103_smp_defconfig
i386                             alldefconfig
m68k                        mvme16x_defconfig
i386                                defconfig
mips                           jazz_defconfig
powerpc                      chrp32_defconfig
mips                       capcella_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                         ap325rxa_defconfig
arc                     haps_hs_smp_defconfig
arm                           h3600_defconfig
xtensa                  nommu_kc705_defconfig
arc                                 defconfig
powerpc                      arches_defconfig
arm                        keystone_defconfig
powerpc                      mgcoge_defconfig
x86_64                           alldefconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220428
x86_64               randconfig-c001-20220425
arm                  randconfig-c002-20220425
arm                  randconfig-c002-20220429
arm                  randconfig-c002-20220501
arm                  randconfig-c002-20220426
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
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
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a014
arc                  randconfig-r043-20220425
s390                 randconfig-r044-20220425
riscv                randconfig-r042-20220425
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
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
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
riscv                randconfig-c006-20220425
mips                 randconfig-c004-20220425
x86_64               randconfig-c007-20220425
arm                  randconfig-c002-20220425
i386                 randconfig-c001-20220425
powerpc              randconfig-c003-20220425
riscv                randconfig-c006-20220428
mips                 randconfig-c004-20220428
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220428
powerpc              randconfig-c003-20220428
powerpc              randconfig-c003-20220501
riscv                randconfig-c006-20220501
mips                 randconfig-c004-20220501
arm                  randconfig-c002-20220501
riscv                randconfig-c006-20220429
mips                 randconfig-c004-20220429
arm                  randconfig-c002-20220429
powerpc              randconfig-c003-20220429
arm                       spear13xx_defconfig
mips                   sb1250_swarm_defconfig
arm                         shannon_defconfig
mips                     loongson2k_defconfig
arm                        vexpress_defconfig
arm                         palmz72_defconfig
arm                       cns3420vb_defconfig
arm                          pxa168_defconfig
powerpc                    socrates_defconfig
arm                            dove_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                     cu1830-neo_defconfig
arm                            mmp2_defconfig
powerpc                      katmai_defconfig
arm                      pxa255-idp_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      walnut_defconfig
arm                              alldefconfig
mips                            e55_defconfig
arm                          moxart_defconfig
mips                           mtx1_defconfig
arm                         bcm2835_defconfig
powerpc                     tqm5200_defconfig
mips                           ip22_defconfig
arm                       imx_v4_v5_defconfig
x86_64                           allyesconfig
mips                           ip28_defconfig
mips                      maltaaprp_defconfig
powerpc                        fsp2_defconfig
mips                      malta_kvm_defconfig
mips                           ip27_defconfig
mips                       rbtx49xx_defconfig
powerpc                          allmodconfig
powerpc                 mpc8560_ads_defconfig
riscv                          rv32_defconfig
mips                     cu1000-neo_defconfig
arm                             mxs_defconfig
powerpc                     skiroot_defconfig
arm                       versatile_defconfig
arm                     davinci_all_defconfig
x86_64               randconfig-a002-20220425
x86_64               randconfig-a004-20220425
x86_64               randconfig-a003-20220425
x86_64               randconfig-a001-20220425
x86_64               randconfig-a005-20220425
x86_64               randconfig-a006-20220425
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a006-20220425
i386                 randconfig-a002-20220425
i386                 randconfig-a005-20220425
i386                 randconfig-a003-20220425
i386                 randconfig-a001-20220425
i386                 randconfig-a004-20220425
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220428
riscv                randconfig-r042-20220428
hexagon              randconfig-r045-20220428

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7D65994A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 07:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346502AbiHSFip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 01:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241985AbiHSFim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 01:38:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD8953D36
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 22:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660887519; x=1692423519;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+H1ispqy0GjIeWC661zDU8mG2PJlI0w8rIrQi7c0ovU=;
  b=aiFxuf60ljBti4YkgOH+oYoBGaVQJ/j20ImBq5ChvqjxZNc/vPj6js5N
   1Th40TxhiZK/kbAqOnN/5RBn2OY7aS8BZr0isDVLYp2h4EPnJOo2e6ggT
   PMs8QKIXPQ6be4D8RakmAtGbo4Cds5xZ4fA5E3TXixv4921X9CYtcJjrP
   ShSYLtq1heE+qv/27A6CqD+m2cwJjDIOCObLBK5OWUnOVuhK5Hvn/Z+tl
   UOiA64tAOciPt4xRr2+KhUxnZaa+bwk0d9Y+Ldxy3jJi94HQ8xo5+o4Sh
   Qti6celOmSZxWG6YVPMTmN/D93beA33Wl+87UPqufFtLzBnf0MPuLlrDb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="318967209"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="318967209"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 22:38:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="637137323"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2022 22:38:36 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOuiK-00017L-0e;
        Fri, 19 Aug 2022 05:38:36 +0000
Date:   Fri, 19 Aug 2022 13:38:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 ee56a283988d739c25d2d00ffb22707cb487ab47
Message-ID: <62ff21c8.xeI5+QYJU7SbKo13%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/sgx
branch HEAD: ee56a283988d739c25d2d00ffb22707cb487ab47  x86/sgx: Improve comments for sgx_encl_lookup/alloc_backing()

elapsed time: 5499m

configs tested: 273
configs skipped: 75

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                             allyesconfig
i386                                defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                 randconfig-a001-20220815
i386                 randconfig-a005-20220815
i386                 randconfig-a004-20220815
i386                 randconfig-a006-20220815
i386                 randconfig-a003-20220815
i386                 randconfig-a002-20220815
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
mips                     decstation_defconfig
arm                     eseries_pxa_defconfig
xtensa                  cadence_csp_defconfig
parisc                generic-32bit_defconfig
arm                          iop32x_defconfig
ia64                             allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-c001
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
sh                   secureedge5410_defconfig
arm                           h5000_defconfig
um                               alldefconfig
sh                          polaris_defconfig
sh                           se7705_defconfig
x86_64               randconfig-a006-20220815
x86_64               randconfig-a003-20220815
x86_64               randconfig-a005-20220815
x86_64               randconfig-a004-20220815
x86_64               randconfig-a001-20220815
x86_64               randconfig-a002-20220815
i386                 randconfig-c001-20220815
powerpc                         wii_defconfig
powerpc                      ppc6xx_defconfig
sh                          rsk7203_defconfig
sh                         microdev_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
arm                      integrator_defconfig
sh                            shmin_defconfig
xtensa                              defconfig
arm                         at91_dt_defconfig
m68k                        m5307c3_defconfig
xtensa                  nommu_kc705_defconfig
riscv                    nommu_k210_defconfig
arm                      footbridge_defconfig
powerpc                     stx_gp3_defconfig
nios2                               defconfig
arm                         vf610m4_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
m68k                        m5272c3_defconfig
mips                          rb532_defconfig
xtensa                generic_kc705_defconfig
s390                       zfcpdump_defconfig
powerpc                 mpc8540_ads_defconfig
mips                         bigsur_defconfig
powerpc                      chrp32_defconfig
arm                           h3600_defconfig
m68k                       m5208evb_defconfig
m68k                         amcore_defconfig
arc                           tb10x_defconfig
sh                              ul2_defconfig
arm                        keystone_defconfig
nios2                            allyesconfig
loongarch                 loongson3_defconfig
powerpc                     redwood_defconfig
powerpc                     sequoia_defconfig
ia64                      gensparse_defconfig
arm                           corgi_defconfig
sh                        sh7785lcr_defconfig
sh                            hp6xx_defconfig
powerpc                   currituck_defconfig
powerpc              randconfig-c003-20220815
s390                                defconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm                  randconfig-c002-20220815
x86_64               randconfig-c001-20220815
s390                             allmodconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
m68k                            q40_defconfig
arm                         s3c6400_defconfig
powerpc                      makalu_defconfig
arc                            hsdk_defconfig
powerpc                    klondike_defconfig
xtensa                         virt_defconfig
powerpc                       eiger_defconfig
arm                          simpad_defconfig
sh                          r7780mp_defconfig
arm                             ezx_defconfig
openrisc                 simple_smp_defconfig
openrisc                  or1klitex_defconfig
arc                        nsimosci_defconfig
m68k                          atari_defconfig
sh                        dreamcast_defconfig
sh                            migor_defconfig
sh                           se7343_defconfig
m68k                                defconfig
powerpc                 mpc837x_rdb_defconfig
arm                         lubbock_defconfig
powerpc                      cm5200_defconfig
ia64                            zx1_defconfig
xtensa                  audio_kc705_defconfig
um                                  defconfig
mips                  maltasmvp_eva_defconfig
sh                        sh7757lcr_defconfig
mips                            gpr_defconfig
m68k                        m5407c3_defconfig
sparc                       sparc32_defconfig
m68k                       m5275evb_defconfig
sh                   sh7770_generic_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
sh                          landisk_defconfig
parisc64                         alldefconfig
ia64                         bigsur_defconfig
ia64                        generic_defconfig
xtensa                    smp_lx200_defconfig
powerpc                     mpc83xx_defconfig
arm                          pxa910_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220817
sh                                  defconfig
ia64                                defconfig
arm                        cerfcube_defconfig
arc                     haps_hs_smp_defconfig
nios2                         3c120_defconfig
m68k                        stmark2_defconfig
powerpc                     ep8248e_defconfig
powerpc                  iss476-smp_defconfig
mips                         cobalt_defconfig
m68k                            mac_defconfig
xtensa                    xip_kc705_defconfig
xtensa                          iss_defconfig
arm                            zeus_defconfig
sh                           se7712_defconfig
arm                  randconfig-c002-20220818
m68k                       m5475evb_defconfig
sh                         ecovec24_defconfig
sh                        edosk7705_defconfig
riscv                randconfig-r042-20220818
s390                 randconfig-r044-20220818
arc                  randconfig-r043-20220818
sh                               j2_defconfig
ia64                             alldefconfig
arm                            mps2_defconfig
sh                   rts7751r2dplus_defconfig
sh                               alldefconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
sparc                       sparc64_defconfig
sparc                             allnoconfig
arm                           sama5_defconfig
arm                        clps711x_defconfig
arm                            qcom_defconfig
m68k                           sun3_defconfig
sh                           sh2007_defconfig
arm                          gemini_defconfig
mips                         db1xxx_defconfig
mips                       bmips_be_defconfig
arm                           sunxi_defconfig
loongarch                        alldefconfig
arm64                               defconfig
m68k                          hp300_defconfig
openrisc                       virt_defconfig
arm                        realview_defconfig
sh                        apsh4ad0a_defconfig
parisc                generic-64bit_defconfig
sh                          rsk7201_defconfig
arm                         cm_x300_defconfig

clang tested configs:
x86_64               randconfig-a011-20220815
x86_64               randconfig-a016-20220815
x86_64               randconfig-a013-20220815
x86_64               randconfig-a015-20220815
x86_64               randconfig-a014-20220815
x86_64               randconfig-a012-20220815
i386                 randconfig-a011-20220815
i386                 randconfig-a012-20220815
i386                 randconfig-a014-20220815
i386                 randconfig-a016-20220815
i386                 randconfig-a015-20220815
i386                 randconfig-a013-20220815
mips                        bcm63xx_defconfig
arm                         socfpga_defconfig
arm                      pxa255-idp_defconfig
mips                       lemote2f_defconfig
powerpc                      ppc44x_defconfig
riscv                randconfig-r042-20220815
s390                 randconfig-r044-20220815
hexagon              randconfig-r045-20220815
hexagon              randconfig-r041-20220815
arm                       mainstone_defconfig
arm                       aspeed_g4_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                        multi_v5_defconfig
x86_64               randconfig-k001-20220815
arm                          collie_defconfig
powerpc                          g5_defconfig
powerpc                          allmodconfig
powerpc                 mpc836x_mds_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
arm                       versatile_defconfig
powerpc                      ppc64e_defconfig
powerpc                 mpc832x_mds_defconfig
arm                       imx_v4_v5_defconfig
mips                           mtx1_defconfig
powerpc                     kilauea_defconfig
s390                             alldefconfig
mips                          ath79_defconfig
arm                    vt8500_v6_v7_defconfig
arm64                            allyesconfig
powerpc                      pmac32_defconfig
x86_64                        randconfig-k001
powerpc                     ksi8560_defconfig
mips                      pic32mzda_defconfig
riscv                    nommu_virt_defconfig
mips                        qi_lb60_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
mips                          ath25_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
mips                        omega2p_defconfig
arm                             mxs_defconfig
riscv                randconfig-r042-20220819
s390                 randconfig-r044-20220819
hexagon              randconfig-r045-20220819
hexagon              randconfig-r045-20220818
hexagon              randconfig-r041-20220819
hexagon              randconfig-r041-20220818
arm                         s5pv210_defconfig
arm                         shannon_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

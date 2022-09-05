Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FD95AC84A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 02:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiIEAlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 20:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIEAlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 20:41:01 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77204237C1
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 17:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662338460; x=1693874460;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2ZLPvcvmei48+SWdvAxsyRIQp5ocK4KJdT9ZXP613/I=;
  b=OX6OeHnfi8wAGIFtvCKSHD/CwsNPvRb6c45xNCkVNP3b486HKQ6NKs/3
   40ZJgnw/iaQ7RaC0ZOCY++Hlqouop3NzaIAtktDI3agSyOu7x2m+EL3+U
   tlBlxnk/sowVIL+b2xxvfMBMTYeFfofIgZpFYfrRA5zl/M9GZhoYwtJMX
   HF25WtqDMB9yP9TnMu8H+lNpm8gtls+2MgbS8rpyMoA6scNxfEshQPyIN
   Aw5RhZgF6IxwCGpvaw8zHEUmlQFdtCVbIrJXzB7YUDHYZHPuFgf4/eML9
   BDgXadK3MtTsHPSs/McdUkjQ4Y8DsgGC/1G6UNs3eJN++RLA0AWMnr0gy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="357996526"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="357996526"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 17:40:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="941919886"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 04 Sep 2022 17:40:58 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oV0Ac-0003aL-00;
        Mon, 05 Sep 2022 00:40:58 +0000
Date:   Mon, 05 Sep 2022 08:40:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 a1aba31a71dc4f6bb487200b577de15cda3998e1
Message-ID: <63154572.utzAdO5u8VxYn8uR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: a1aba31a71dc4f6bb487200b577de15cda3998e1  Merge branch into tip/master: 'sched/core'

elapsed time: 720m

configs tested: 148
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a013
x86_64                              defconfig
x86_64                        randconfig-a011
i386                                defconfig
arc                  randconfig-r043-20220904
i386                          randconfig-a001
x86_64                               rhel-8.3
x86_64                        randconfig-a004
i386                          randconfig-a003
alpha                             allnoconfig
x86_64                        randconfig-a015
arm                                 defconfig
riscv                             allnoconfig
ia64                                defconfig
arm                         assabet_defconfig
x86_64                           allyesconfig
x86_64                        randconfig-a002
csky                              allnoconfig
i386                          randconfig-a005
mips                       bmips_be_defconfig
m68k                             allmodconfig
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
x86_64                           rhel-8.3-syz
riscv                randconfig-r042-20220904
arc                               allnoconfig
s390                 randconfig-r044-20220904
x86_64                          rhel-8.3-func
arc                              allyesconfig
powerpc                          allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a006
x86_64                           rhel-8.3-kvm
alpha                            allyesconfig
i386                          randconfig-a014
arm                              allyesconfig
mips                             allyesconfig
m68k                             allyesconfig
arm64                            allyesconfig
i386                          randconfig-a012
i386                             allyesconfig
i386                          randconfig-a016
arm                          gemini_defconfig
sh                               allmodconfig
mips                          rb532_defconfig
ia64                             allmodconfig
m68k                          multi_defconfig
arm                         axm55xx_defconfig
sh                          rsk7269_defconfig
sparc                               defconfig
microblaze                      mmu_defconfig
arm                         lpc18xx_defconfig
sh                           se7712_defconfig
i386                          randconfig-c001
loongarch                           defconfig
loongarch                         allnoconfig
i386                             alldefconfig
ia64                          tiger_defconfig
sh                         apsh4a3a_defconfig
m68k                             alldefconfig
sh                          sdk7780_defconfig
mips                      fuloong2e_defconfig
sh                   secureedge5410_defconfig
powerpc                  iss476-smp_defconfig
mips                         db1xxx_defconfig
xtensa                    xip_kc705_defconfig
arc                     nsimosci_hs_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                           jazz_defconfig
arm                        realview_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                  maltasmvp_eva_defconfig
arc                          axs101_defconfig
arm                           viper_defconfig
arm                            hisi_defconfig
arm                     eseries_pxa_defconfig
sh                           se7750_defconfig
sh                          landisk_defconfig
powerpc                      pasemi_defconfig
powerpc                         ps3_defconfig
arm                         nhk8815_defconfig
sh                           se7780_defconfig
powerpc                      makalu_defconfig
sh                          sdk7786_defconfig
sh                         microdev_defconfig
openrisc                       virt_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220904
sh                          r7780mp_defconfig
m68k                          sun3x_defconfig
powerpc                      mgcoge_defconfig
sh                           se7751_defconfig
nios2                            allyesconfig
arm                           corgi_defconfig
arm                       aspeed_g5_defconfig
arm                          iop32x_defconfig
powerpc                     asp8347_defconfig
riscv                            allyesconfig
powerpc                      ppc40x_defconfig
arm                          pxa3xx_defconfig
arm                             ezx_defconfig
powerpc              randconfig-c003-20220904
m68k                            q40_defconfig
sparc64                             defconfig
powerpc                 mpc837x_mds_defconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig

clang tested configs:
x86_64                        randconfig-a012
arm                          collie_defconfig
i386                          randconfig-a002
x86_64                        randconfig-a014
hexagon              randconfig-r045-20220904
i386                          randconfig-a013
hexagon              randconfig-r041-20220904
i386                          randconfig-a004
powerpc                          g5_defconfig
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a006
i386                          randconfig-a015
mips                          rm200_defconfig
x86_64                        randconfig-a003
i386                          randconfig-a011
arm                           sama7_defconfig
arm                          moxart_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                         palmz72_defconfig
powerpc                  mpc866_ads_defconfig
arm                        multi_v5_defconfig
x86_64                        randconfig-k001
arm                   milbeaut_m10v_defconfig
arm                      pxa255-idp_defconfig
powerpc                     tqm8560_defconfig
powerpc                 mpc8272_ads_defconfig
mips                           ip27_defconfig
mips                      malta_kvm_defconfig
powerpc                     akebono_defconfig
mips                malta_qemu_32r6_defconfig
arm                         socfpga_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

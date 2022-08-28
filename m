Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856FA5A3B44
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 05:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiH1D7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 23:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiH1D7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 23:59:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DF72E9F4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 20:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661659175; x=1693195175;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=w+DTDjf9tkRDq/98j2mGYwsBmcsfKAZsDEeiBP3WdJ4=;
  b=OxFBUt3mdb8S2m1AHP+KYyKxlSKQZXADH1MOjqaLOEhmJIwyA5i/fcTn
   pGY7wIzTGogmWaGtO1XrEiqk6KDGBXiYJDqm5rCeLsOD2MGBkyelTxj01
   CuhvmTurK8yvF7AwUYyPt2rPdKXNmvG5H76ozLR1lPCHekzAfo4QV+9JT
   bXMPmBslzquTbtdofQ0uR5p1i0FL/v3QmDcsZyOzXiDSVkkzaFx+svnbv
   njvIW/iVlNlI1x/Hc+0JNg2XtjAyZRdxKDddLIuBjlMYjnkQGG1dc2c9p
   pyh/uqQsdZpDuUWYqcz3w3adrECy4NIeJRtyHsS+K2Z3bI/94BNNpVtn0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10452"; a="295484410"
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="295484410"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 20:59:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="640528963"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 Aug 2022 20:59:33 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oS9SP-0000lv-0P;
        Sun, 28 Aug 2022 03:59:33 +0000
Date:   Sun, 28 Aug 2022 11:58:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 5b7ff2d0076438d1417738da38d1dc38595b130a
Message-ID: <630ae7f7.KeqMRY0y+mFh7Ij1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 5b7ff2d0076438d1417738da38d1dc38595b130a  Merge branch into tip/master: 'x86/timers'

elapsed time: 720m

configs tested: 124
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
loongarch                         allnoconfig
alpha                            allyesconfig
arc                                 defconfig
um                             i386_defconfig
s390                             allmodconfig
s390                 randconfig-r044-20220828
alpha                               defconfig
um                           x86_64_defconfig
x86_64                              defconfig
s390                             allyesconfig
s390                                defconfig
arc                               allnoconfig
alpha                             allnoconfig
csky                              allnoconfig
i386                                defconfig
loongarch                           defconfig
riscv                             allnoconfig
csky                                defconfig
x86_64                        randconfig-a004
x86_64                               rhel-8.3
sparc                               defconfig
riscv                randconfig-r042-20220828
x86_64                           alldefconfig
x86_64                        randconfig-a002
powerpc                         wii_defconfig
powerpc                           allnoconfig
ia64                            zx1_defconfig
x86_64                                  kexec
riscv                    nommu_virt_defconfig
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                              allmodconfig
x86_64                           allyesconfig
i386                          debian-10.3-kvm
m68k                       m5475evb_defconfig
arc                  randconfig-r043-20220828
i386                          randconfig-a014
riscv                            allmodconfig
arm64                               defconfig
arc                 nsimosci_hs_smp_defconfig
arm                         s3c6400_defconfig
x86_64                        randconfig-a015
x86_64                          rhel-8.3-func
x86_64                        randconfig-a006
arm                      footbridge_defconfig
powerpc                          allmodconfig
riscv                          rv32_defconfig
m68k                                defconfig
arc                              allyesconfig
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
m68k                             allyesconfig
sh                               allmodconfig
arm                         axm55xx_defconfig
ia64                                defconfig
i386                   debian-10.3-kselftests
parisc                              defconfig
x86_64                    rhel-8.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
m68k                             allmodconfig
arm                                 defconfig
nios2                               defconfig
xtensa                           allyesconfig
x86_64                           rhel-8.3-syz
powerpc                          allyesconfig
sh                        edosk7705_defconfig
sh                ecovec24-romimage_defconfig
nios2                            allyesconfig
i386                          randconfig-a012
x86_64                           rhel-8.3-kvm
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
powerpc                         ps3_defconfig
i386                          randconfig-a016
parisc                           allyesconfig
riscv                               defconfig
parisc64                            defconfig
sparc                            allyesconfig
i386                          randconfig-a001
sh                           se7750_defconfig
mips                    maltaup_xpa_defconfig
i386                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
powerpc                      ep88xc_defconfig
powerpc                    adder875_defconfig
xtensa                              defconfig
i386                          randconfig-c001
ia64                             allyesconfig
mips                             allmodconfig
sh                        sh7763rdp_defconfig
ia64                          tiger_defconfig
arm                        shmobile_defconfig
powerpc                        warp_defconfig
arm                         lpc18xx_defconfig
mips                         cobalt_defconfig
mips                     loongson1b_defconfig
arm                           h5000_defconfig
sh                          sdk7786_defconfig
sh                      rts7751r2d1_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220828

clang tested configs:
hexagon              randconfig-r041-20220828
hexagon              randconfig-r045-20220828
powerpc                      acadia_defconfig
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a001
powerpc                 mpc8272_ads_defconfig
arm                           sama7_defconfig
x86_64                        randconfig-a016
x86_64                        randconfig-a003
i386                          randconfig-a011
arm                     am200epdkit_defconfig
arm                          ep93xx_defconfig
arm                       netwinder_defconfig
mips                        qi_lb60_defconfig
powerpc                    ge_imp3a_defconfig
arm                  colibri_pxa270_defconfig
arm                          sp7021_defconfig
x86_64                        randconfig-k001
powerpc                  mpc885_ads_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

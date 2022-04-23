Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BBF50CDC8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 23:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbiDWVpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 17:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiDWVp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 17:45:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8E125EB1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 14:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650750151; x=1682286151;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/SiKj9lxba+tH5b99WjcnpQ2d+082ttSeW+BcGmtMFY=;
  b=CPqUfH1fj4POfgDvvi2EAufrUgzwF3SoOcyF8Vi/PaH14EQAfRDB/u4E
   nulwjq/+bOMbU0gpFOXo6m77zP7T5A1Y/WVFSwI381gfqkcxoFxEZgtfI
   S0xETJ0SeedaZ8phMqDtJmp/61lrMTx5yjoOJeLpzcHd0mS6LALBj/BC0
   eAh2yIqwYAmLGphRyrfy1JMuozAbExI/VTHEY4CeThuaMWbUDtCTJhWMl
   C0RB9jmtQvTEg+udTmXH23p6QUp1M3rvq6n/d4sdBAAK46RrQaW9QbwYL
   5THWmkkEk+9jVS+6k4IrjLD0ypE7BfIN3UPk+Y8RVnlWzUQHcPGJ/JB5J
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="252299324"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="252299324"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 14:42:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="869857889"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Apr 2022 14:42:29 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niNWP-0000Vd-53;
        Sat, 23 Apr 2022 21:42:29 +0000
Date:   Sun, 24 Apr 2022 05:41:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:objtool/core] BUILD SUCCESS
 a8e35fece49b16b20de000aab687ca075e4463af
Message-ID: <62647297.tU5ka8VySHNrFi8k%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/core
branch HEAD: a8e35fece49b16b20de000aab687ca075e4463af  objtool: Update documentation

elapsed time: 2038m

configs tested: 133
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sparc                               defconfig
arm                       aspeed_g5_defconfig
sh                          rsk7201_defconfig
m68k                         apollo_defconfig
ia64                             allyesconfig
nios2                         10m50_defconfig
openrisc                  or1klitex_defconfig
m68k                        m5407c3_defconfig
um                                  defconfig
arm                          simpad_defconfig
powerpc                      pcm030_defconfig
powerpc                   currituck_defconfig
arm                        shmobile_defconfig
powerpc                       holly_defconfig
mips                        bcm47xx_defconfig
sparc64                             defconfig
um                               alldefconfig
ia64                        generic_defconfig
arm                           viper_defconfig
m68k                             allyesconfig
ia64                         bigsur_defconfig
sh                        apsh4ad0a_defconfig
arm                           sama5_defconfig
sh                           se7705_defconfig
m68k                       m5475evb_defconfig
powerpc                 canyonlands_defconfig
arm                           u8500_defconfig
mips                 decstation_r4k_defconfig
arc                     nsimosci_hs_defconfig
arm                           imxrt_defconfig
arc                              alldefconfig
sh                        dreamcast_defconfig
arm                        trizeps4_defconfig
sh                           se7751_defconfig
arc                          axs103_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220422
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
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
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220422
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
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
riscv                randconfig-c006-20220422
mips                 randconfig-c004-20220422
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220422
powerpc              randconfig-c003-20220422
powerpc                      acadia_defconfig
mips                           ip27_defconfig
riscv                            alldefconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     ksi8560_defconfig
mips                          ath25_defconfig
powerpc                     tqm8540_defconfig
arm                         orion5x_defconfig
mips                     cu1830-neo_defconfig
riscv                    nommu_virt_defconfig
powerpc                      walnut_defconfig
mips                         tb0219_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220422
s390                 randconfig-r044-20220422
riscv                randconfig-r042-20220422
hexagon              randconfig-r045-20220422

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271B05A1F55
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 05:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244763AbiHZDMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 23:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244709AbiHZDLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 23:11:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AC68036A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 20:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661483509; x=1693019509;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZlaFkCgZK/j1AlPUeUngOIZHFttEAfOOW77I293ELvA=;
  b=Wm/K37mwMs/f4CpOzmWbuPJDOC6zddczJcyewR2JuO9f3KmsSXpYXvSX
   BXQIB5TTyrhrb4jRN5nUgtHR9gQBPeTgYO9KWsO4oiYjFqvCgKZdBBUdi
   WTd335HKUQSyTXacFVwdB4tSQQ/V/aQV7sn6iqOo9g1+vOoviJrmjDLmK
   a73yYWj+VBU86UpXNn36+4dSHP7pm3Qlx3mv2UbRkDMFdllSDTjCdDUlE
   RzRLbj95QwKM0U7c1hhyj9H3LSb93MYTUo7x71HossGuIXimxBpyQLSBO
   t91d+N8zOZ6/lOb11ro17o3sxwqg+RAIAuA8J88OWPvPD2uGCUN6pgm4v
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="281381482"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="281381482"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 20:11:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="643505439"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 25 Aug 2022 20:11:47 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRPl4-0003I6-1h;
        Fri, 26 Aug 2022 03:11:46 +0000
Date:   Fri, 26 Aug 2022 11:10:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 00da0cb385d05a89226e150a102eb49d8abb0359
Message-ID: <630839c1.t2ppY/Jv6Na7AwUH%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 00da0cb385d05a89226e150a102eb49d8abb0359  Documentation/ABI: Mention retbleed vulnerability info file for sysfs

elapsed time: 770m

configs tested: 130
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
loongarch                         allnoconfig
loongarch                           defconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                          allmodconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
mips                             allyesconfig
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
i386                                defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm                                 defconfig
i386                          randconfig-a014
i386                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
m68k                        m5272c3_defconfig
arm                          iop32x_defconfig
arm                          gemini_defconfig
powerpc                     tqm8548_defconfig
riscv                randconfig-r042-20220824
s390                 randconfig-r044-20220824
arc                  randconfig-r043-20220824
arc                  randconfig-r043-20220825
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
sh                            hp6xx_defconfig
m68k                           virt_defconfig
arm                            qcom_defconfig
m68k                       bvme6000_defconfig
sparc                       sparc32_defconfig
sh                           se7750_defconfig
sh                         microdev_defconfig
arc                     nsimosci_hs_defconfig
i386                          randconfig-c001
arm                       imx_v6_v7_defconfig
ia64                             alldefconfig
powerpc                 mpc8540_ads_defconfig
mips                           gcw0_defconfig
sh                            shmin_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                      fuloong2e_defconfig
arm64                               defconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
arc                        nsim_700_defconfig
arm                      integrator_defconfig
powerpc                     taishan_defconfig
arm                        realview_defconfig
arm                             rpc_defconfig
m68k                        m5407c3_defconfig
arm                        mvebu_v7_defconfig
powerpc                     mpc83xx_defconfig
alpha                            alldefconfig
arm                          pxa910_defconfig
ia64                             allmodconfig
xtensa                         virt_defconfig
ia64                        generic_defconfig
arm                        spear6xx_defconfig
mips                            gpr_defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-k001
hexagon              randconfig-r045-20220825
hexagon              randconfig-r045-20220823
riscv                randconfig-r042-20220823
riscv                randconfig-r042-20220825
hexagon              randconfig-r041-20220823
hexagon              randconfig-r041-20220825
s390                 randconfig-r044-20220825
s390                 randconfig-r044-20220823
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

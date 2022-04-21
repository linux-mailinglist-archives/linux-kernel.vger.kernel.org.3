Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A180A50A7A0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391154AbiDUSBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391152AbiDUSB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:01:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAE44B40D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650563914; x=1682099914;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=EiJrpObUFh20LOT5nrmOYLiEoVE9LosThQ1DYPD1x30=;
  b=SyrsoPSf3sU0TAV0ShqxrBPmhEsYEh04ZgFHB1wx4UOUiGreXNmFBKDx
   7lKk7SOp94+jvkFmICKq87fQ5MsRdnDufHg8Kv1GpbHkUldbqG9cyU/WG
   c0kDqY0NRC24BFXzPx4kfJG/MMJOvZzOTO30EcSHihzgDo10gfmeyZT0A
   zUazyOqVtMDHg8lG/itTZVbjE0yTjTuvMosajH8x6Li/+c+MsQJBq4HHC
   90NNTkycpL1LnfrdlBjQ1Tu93UwIja9TUMY7iUpGiX21MXKAIVwOca7U9
   qVAmj/yN1aO+FlgEBM2Hw3BPLe/DqrevODHORBOG69y+IzwdaeMkJ3KKf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="350875474"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="350875474"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 10:58:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="671155815"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Apr 2022 10:58:30 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhb4X-0008dd-D1;
        Thu, 21 Apr 2022 17:58:29 +0000
Date:   Fri, 22 Apr 2022 01:57:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.04.19a] BUILD SUCCESS
 7e8b5f16a9577ed3b7c2b9b06686de578b98032b
Message-ID: <62619b17.L0re67OuKL9mi6C7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.04.19a
branch HEAD: 7e8b5f16a9577ed3b7c2b9b06686de578b98032b  doc: Document the rcutree.rcu_divisor kernel boot parameter

elapsed time: 1066m

configs tested: 136
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
sh                   secureedge5410_defconfig
arm                             ezx_defconfig
sh                          r7780mp_defconfig
powerpc                        cell_defconfig
powerpc                     mpc83xx_defconfig
arm                         nhk8815_defconfig
powerpc                      makalu_defconfig
arm                        mvebu_v7_defconfig
sparc                            allyesconfig
parisc64                            defconfig
arm                        cerfcube_defconfig
mips                           ip32_defconfig
sh                         ecovec24_defconfig
arm                        mini2440_defconfig
parisc                generic-32bit_defconfig
m68k                        mvme16x_defconfig
mips                         cobalt_defconfig
ia64                          tiger_defconfig
arm                        keystone_defconfig
sh                           se7619_defconfig
arm                          pxa3xx_defconfig
sparc                       sparc32_defconfig
sh                          sdk7780_defconfig
m68k                          amiga_defconfig
alpha                            alldefconfig
powerpc                 canyonlands_defconfig
arm                     eseries_pxa_defconfig
arm                           sunxi_defconfig
powerpc                    sam440ep_defconfig
powerpc                 mpc834x_mds_defconfig
sh                        edosk7705_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220421
arm                  randconfig-c002-20220420
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
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
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
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
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220420
arc                  randconfig-r043-20220421
s390                 randconfig-r044-20220421
riscv                randconfig-r042-20220421
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
riscv                randconfig-c006-20220420
mips                 randconfig-c004-20220420
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220420
powerpc              randconfig-c003-20220420
mips                        bcm63xx_defconfig
arm                         orion5x_defconfig
arm                          pxa168_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                           omap1_defconfig
powerpc                      ppc44x_defconfig
powerpc                     pseries_defconfig
s390                       zfcpdump_defconfig
arm                          pxa910_defconfig
powerpc                    gamecube_defconfig
arm                          pcm027_defconfig
x86_64                           allyesconfig
powerpc                     tqm5200_defconfig
mips                malta_qemu_32r6_defconfig
mips                      bmips_stb_defconfig
hexagon                          alldefconfig
arm                     davinci_all_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220420
riscv                randconfig-r042-20220420
hexagon              randconfig-r045-20220420
s390                 randconfig-r044-20220420

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E50A4D2FE4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbiCIN2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiCIN2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:28:09 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959361795F5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646832430; x=1678368430;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kn2+yCaRDqgsXSvpfjyoc6odkkG8BBG76gB9eZTpdlw=;
  b=dBAwYmjD39ZQ1ExUZpWwqVufcICIA5gCULJIZEqJVGh/uEtD1wL4/LIz
   5MD/wkD69cJUJzO2GSeRph6m/g++s0o9O3fXdHA/iJLVpXJJpQVrk5nG3
   Dl/k1X2aE7wMlv/Mb9s6Z8PaS7XwfX1PEhR1ggxAWNZLX7E07+K2SnIoV
   2cvRVz0DCkxMtPl+2NHkGhIZPCHR+0z+EKffDcpa0HuJtEVlnUToUanXp
   PTmyhD4Nr/rluQOvJSHHmeTtYvN2leWAVXhWVAZjDOPlrmcBw78EwX+IE
   sU4sQf/bIVXJMtfXSKPI3fDFj/Y2EjUsRr5SxhCXJIh4wiRuzNspSc5KM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254704226"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="254704226"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 05:27:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="578384421"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 09 Mar 2022 05:27:09 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRwLM-0003Gs-Dt; Wed, 09 Mar 2022 13:27:08 +0000
Date:   Wed, 09 Mar 2022 21:26:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 7f434dff76215af00c26ba6449eaa4738fe9e2ab
Message-ID: <6228ab1f.5h5SdV9AQOstKA4n%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
branch HEAD: 7f434dff76215af00c26ba6449eaa4738fe9e2ab  sched/topology: Remove redundant variable and fix incorrect type in build_sched_domains

elapsed time: 1280m

configs tested: 165
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
sh                   secureedge5410_defconfig
powerpc                    klondike_defconfig
m68k                          multi_defconfig
openrisc                 simple_smp_defconfig
arm                         lubbock_defconfig
s390                                defconfig
nios2                            alldefconfig
arm                        keystone_defconfig
microblaze                      mmu_defconfig
sh                ecovec24-romimage_defconfig
arm                           stm32_defconfig
ia64                         bigsur_defconfig
powerpc                 mpc834x_mds_defconfig
arm                          lpd270_defconfig
arc                          axs103_defconfig
m68k                             alldefconfig
arm                         s3c6400_defconfig
sh                           se7722_defconfig
mips                           xway_defconfig
ia64                          tiger_defconfig
h8300                     edosk2674_defconfig
sh                        apsh4ad0a_defconfig
powerpc                     ep8248e_defconfig
sparc                       sparc32_defconfig
xtensa                generic_kc705_defconfig
um                               alldefconfig
powerpc                        cell_defconfig
sh                   rts7751r2dplus_defconfig
sh                   sh7724_generic_defconfig
arm                        mini2440_defconfig
arm                          pxa3xx_defconfig
xtensa                    xip_kc705_defconfig
sh                           se7721_defconfig
sh                           se7206_defconfig
xtensa                          iss_defconfig
nds32                             allnoconfig
arm                          simpad_defconfig
arc                      axs103_smp_defconfig
powerpc                      arches_defconfig
microblaze                          defconfig
arm                  randconfig-c002-20220308
arm                  randconfig-c002-20220309
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220309
arc                  randconfig-r043-20220308
riscv                randconfig-r042-20220308
s390                 randconfig-r044-20220308
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit

clang tested configs:
x86_64                        randconfig-c007
riscv                randconfig-c006-20220308
powerpc              randconfig-c003-20220308
i386                          randconfig-c001
arm                  randconfig-c002-20220308
mips                 randconfig-c004-20220308
powerpc                      ppc64e_defconfig
riscv                    nommu_virt_defconfig
mips                       lemote2f_defconfig
mips                        workpad_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                       ebony_defconfig
mips                           ip22_defconfig
powerpc                    ge_imp3a_defconfig
mips                         tb0219_defconfig
arm                           spitz_defconfig
x86_64                           allyesconfig
powerpc                      obs600_defconfig
mips                malta_qemu_32r6_defconfig
arm                            mmp2_defconfig
riscv                            alldefconfig
powerpc                          allyesconfig
arm                           sama7_defconfig
mips                            e55_defconfig
powerpc                     ppa8548_defconfig
arm                         shannon_defconfig
arm                  colibri_pxa300_defconfig
arm                         hackkit_defconfig
arm                         orion5x_defconfig
mips                        omega2p_defconfig
hexagon                             defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc8272_ads_defconfig
mips                          ath25_defconfig
powerpc                     skiroot_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                       netwinder_defconfig
powerpc                      katmai_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220309
hexagon              randconfig-r041-20220309
riscv                randconfig-r042-20220309
hexagon              randconfig-r045-20220308
hexagon              randconfig-r041-20220308
s390                 randconfig-r044-20220309

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

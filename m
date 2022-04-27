Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC94751102E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 06:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357655AbiD0Edk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 00:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiD0Edh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 00:33:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5206AFD15
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 21:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651033828; x=1682569828;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DjrPVN1OFKYz1MmgqNGxngfLRFxIbb97u1B8GQrB6qY=;
  b=WJ18U/IrGmV+rfzx1Tg6E0HsA+iZTOlK+14ubS/foigw9NXdI9PXl6Hn
   hgYZXWnP2Fr+4HZgd6EfW51Dl8F7XG+j/E0RLlyiIXxlUYgSxv0oxLtoK
   xeO7IULpp7DegpnVDUBOpFDWsFVlRCLHUh8cQ7FuMkweqdXwTZj9kwKYO
   lKw9JxYq0sC1OEBG4R3aN8q9RYZ4XBTCQhBMMnEvPwtQbbkYLE32UzCPE
   UZVevZ+bNTr7gtZjaA9SprxtJfFsCQLfy/zHQA73pi/DxG+6jjdEGAU14
   Sl0HfHwYrIcA3vDLfuFq+r1R0LxgoDaQssVonkWfeQ7uYaUvYxuQd09Us
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="253190117"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="253190117"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 21:30:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="533012262"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Apr 2022 21:30:26 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njZJn-0004KE-D3;
        Wed, 27 Apr 2022 04:30:23 +0000
Date:   Wed, 27 Apr 2022 12:30:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 a658353167bf2ea6052cee071dbcc13e0f229dc9
Message-ID: <6268c6da.xd24vi16wE8/64NY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: a658353167bf2ea6052cee071dbcc13e0f229dc9  sched/fair: Revise comment about lb decision matrix

elapsed time: 6822m

configs tested: 128
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
powerpc                      ppc40x_defconfig
powerpc                     redwood_defconfig
powerpc                     asp8347_defconfig
um                           x86_64_defconfig
ia64                             alldefconfig
m68k                         apollo_defconfig
nios2                         10m50_defconfig
openrisc                  or1klitex_defconfig
ia64                             allyesconfig
nios2                            allyesconfig
sh                            migor_defconfig
arc                      axs103_smp_defconfig
arm                           imxrt_defconfig
powerpc                     rainier_defconfig
sh                              ul2_defconfig
arm                           sama5_defconfig
arm                             pxa_defconfig
arm                            lart_defconfig
arm                            zeus_defconfig
arm                       aspeed_g5_defconfig
sh                          r7785rp_defconfig
mips                  decstation_64_defconfig
sh                           se7780_defconfig
powerpc                     pq2fads_defconfig
nios2                            alldefconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                      tqm8xx_defconfig
arm                          badge4_defconfig
arc                        vdk_hs38_defconfig
m68k                         amcore_defconfig
parisc                generic-64bit_defconfig
um                                  defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220422
ia64                                defconfig
ia64                             allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                               defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
i386                          randconfig-a005
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220422
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                               defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
riscv                randconfig-c006-20220425
mips                 randconfig-c004-20220425
x86_64               randconfig-c007-20220425
arm                  randconfig-c002-20220425
i386                 randconfig-c001-20220425
powerpc              randconfig-c003-20220425
mips                 randconfig-c004-20220424
powerpc              randconfig-c003-20220424
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220424
s390                 randconfig-c005-20220424
riscv                randconfig-c006-20220424
powerpc                    ge_imp3a_defconfig
arm                  colibri_pxa270_defconfig
arm                        neponset_defconfig
powerpc                      pmac32_defconfig
arm                       netwinder_defconfig
hexagon                          alldefconfig
mips                          malta_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                    gamecube_defconfig
arm                       versatile_defconfig
x86_64                           allyesconfig
mips                          ath25_defconfig
powerpc                     tqm8540_defconfig
arm                         orion5x_defconfig
mips                     cu1830-neo_defconfig
riscv                    nommu_virt_defconfig
powerpc                     mpc5200_defconfig
mips                     cu1000-neo_defconfig
i386                          randconfig-a006
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220422
hexagon              randconfig-r045-20220422
riscv                randconfig-r042-20220422
s390                 randconfig-r044-20220422

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030D44CCAAA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 01:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbiCDAVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 19:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiCDAVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 19:21:22 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C28947386
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 16:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646353236; x=1677889236;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mwcN7ntVvz5WcBm9chQ0TkpYzN/Y70j/s9y/vh/Debk=;
  b=C9oea4UIzDhhyYbTuMVzijQsdXoeTrOsaCaOLbaALdKLsh0U7VBGq/Hg
   oReyypvuIeeZ2Y+qrTfMiYLAa/yEVthZF4Vjgw30aMwHr5gzkL7qFZwRG
   JOPP52xuT4X00EaA/dcmSUlXLmAO8/xOlWYcYX8y+KJR4Voai+U+9a2wY
   WNkmatNPiOkCXcqnfk6HiCVdNRaDnnWzifBrlz7gdCKErmAIgWGLP+Lfx
   ltq+f62EezGXWjHphPdLtn6JGX5spJIxuc3KUTw3sqXXrv2xLwGAO7bBN
   wEnVqFGAV8U2h+57GIuHjCEC3SsK2OmctPA28Gw5me/A/eWxwxNBJq0zp
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="233813096"
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="233813096"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 16:20:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="511660252"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Mar 2022 16:20:34 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPvgP-00014Z-Lu; Fri, 04 Mar 2022 00:20:33 +0000
Date:   Fri, 04 Mar 2022 08:20:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 a66320f041601309f1885bcb52e27e0c2f72079b
Message-ID: <62215b35./4X/f6SLAAN1slXF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git auto-latest
branch HEAD: a66320f041601309f1885bcb52e27e0c2f72079b  Merge branch into tip/master: 'core/core'

elapsed time: 725m

configs tested: 155
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220303
arm                          iop32x_defconfig
x86_64                              defconfig
ia64                         bigsur_defconfig
h8300                    h8300h-sim_defconfig
microblaze                          defconfig
arm                       omap2plus_defconfig
arm                          badge4_defconfig
m68k                       m5249evb_defconfig
sh                            migor_defconfig
arm                           sunxi_defconfig
mips                         db1xxx_defconfig
sh                            shmin_defconfig
m68k                             allyesconfig
arm                         axm55xx_defconfig
arm                        mvebu_v7_defconfig
arm                        cerfcube_defconfig
h8300                            alldefconfig
powerpc                  iss476-smp_defconfig
nios2                         10m50_defconfig
arc                        nsim_700_defconfig
sh                          kfr2r09_defconfig
sh                          r7780mp_defconfig
arm                           sama5_defconfig
arm                         lubbock_defconfig
sparc                       sparc64_defconfig
riscv             nommu_k210_sdcard_defconfig
h8300                     edosk2674_defconfig
xtensa                generic_kc705_defconfig
mips                           jazz_defconfig
mips                            gpr_defconfig
sh                   sh7724_generic_defconfig
microblaze                      mmu_defconfig
sparc                            allyesconfig
powerpc                     taishan_defconfig
m68k                        stmark2_defconfig
nds32                            alldefconfig
arm                            qcom_defconfig
um                             i386_defconfig
sh                        sh7757lcr_defconfig
powerpc                     sequoia_defconfig
parisc64                         alldefconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc837x_mds_defconfig
sh                          urquell_defconfig
arm                            lart_defconfig
arc                        nsimosci_defconfig
sh                           se7722_defconfig
um                           x86_64_defconfig
sparc64                          alldefconfig
powerpc                        warp_defconfig
s390                          debug_defconfig
arm                           h5000_defconfig
arm                            mps2_defconfig
arm                        clps711x_defconfig
m68k                        m5407c3_defconfig
sh                           se7712_defconfig
m68k                          multi_defconfig
powerpc                    sam440ep_defconfig
powerpc                      arches_defconfig
arm                        trizeps4_defconfig
arm                  randconfig-c002-20220302
arm                  randconfig-c002-20220303
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a016
i386                          randconfig-a012
arc                  randconfig-r043-20220303
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220303
riscv                randconfig-c006-20220303
i386                          randconfig-c001
arm                  randconfig-c002-20220303
mips                 randconfig-c004-20220303
powerpc              randconfig-c003-20220302
riscv                randconfig-c006-20220302
arm                  randconfig-c002-20220302
mips                 randconfig-c004-20220302
arm                      tct_hammer_defconfig
i386                             allyesconfig
powerpc                      ppc64e_defconfig
mips                        workpad_defconfig
mips                           mtx1_defconfig
arm                        vexpress_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220303
riscv                randconfig-r042-20220303
hexagon              randconfig-r041-20220303
s390                 randconfig-r044-20220303

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

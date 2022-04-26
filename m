Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEB150EE4F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239137AbiDZByM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 21:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiDZByK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:54:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A9960AA4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 18:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650937864; x=1682473864;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Tzh+mcGYtBz5SL7Vm036vg7Q2MBRwu15pUavtuN+vm8=;
  b=epKxVvTYDrnGvVXbHSBy9NeWoLAv8qsJ75wRqK7SkoPOpSfQpZNhkLis
   HlUJ7D23Ief3XEekg40Kvr0B6EnXSAsrOVDiXhmh0UxNV8sy7U0i22+jt
   uzRUecUcw/JQeUK4mFiET/91dshb8kKj4LTpOjCKoaeBI8B60H0G8NPX8
   NiX2XkCrH66FgCHxItB60lSI0V562IibFvHUmM6ZhS1xrM6FhUC8Rwwoj
   Ud4NurePW+KVsxj+tShBObmg+P0AfR0Fvit/Km0u2KkaJppFpmrAgMaCA
   mo6nMBJFxM9zqWP/A69ndhbDZb5DKTmGTDo+1XqvDzc1CLDY6d0LYlfDj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="264265291"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="264265291"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 18:51:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="512909473"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Apr 2022 18:51:03 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njAM2-00037K-Ae;
        Tue, 26 Apr 2022 01:51:02 +0000
Date:   Tue, 26 Apr 2022 09:50:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 8ad7e8f696951f192c6629a0cbda9ac94c773159
Message-ID: <62674fe4.aHXyUxZa1AV+CSe4%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/fpu
branch HEAD: 8ad7e8f696951f192c6629a0cbda9ac94c773159  x86/fpu/xsave: Support XSAVEC in the kernel

elapsed time: 730m

configs tested: 129
configs skipped: 77

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
powerpc                       ppc64_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                    sam440ep_defconfig
sh                           se7619_defconfig
powerpc                      pasemi_defconfig
sh                        sh7785lcr_defconfig
powerpc                    amigaone_defconfig
um                               alldefconfig
arm                      integrator_defconfig
m68k                            q40_defconfig
arc                              alldefconfig
arm                           sunxi_defconfig
sparc                               defconfig
arm                            hisi_defconfig
alpha                            alldefconfig
powerpc                        cell_defconfig
arm                         assabet_defconfig
xtensa                generic_kc705_defconfig
openrisc                  or1klitex_defconfig
m68k                       bvme6000_defconfig
sh                              ul2_defconfig
sh                          sdk7786_defconfig
arm                           viper_defconfig
mips                      loongson3_defconfig
parisc64                            defconfig
microblaze                          defconfig
mips                            gpr_defconfig
m68k                        mvme147_defconfig
h8300                       h8s-sim_defconfig
xtensa                          iss_defconfig
sparc64                             defconfig
powerpc                  storcenter_defconfig
arc                      axs103_smp_defconfig
arm                         lubbock_defconfig
arc                     haps_hs_smp_defconfig
arm                           h3600_defconfig
xtensa                  nommu_kc705_defconfig
x86_64               randconfig-c001-20220425
arm                  randconfig-c002-20220425
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                               defconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
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
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
riscv                randconfig-c006-20220425
mips                 randconfig-c004-20220425
x86_64               randconfig-c007-20220425
arm                  randconfig-c002-20220425
i386                 randconfig-c001-20220425
powerpc              randconfig-c003-20220425
arm                     davinci_all_defconfig
powerpc                     tqm5200_defconfig
mips                           ip22_defconfig
mips                        workpad_defconfig
mips                           ip27_defconfig
x86_64               randconfig-a002-20220425
x86_64               randconfig-a004-20220425
x86_64               randconfig-a003-20220425
x86_64               randconfig-a001-20220425
x86_64               randconfig-a005-20220425
x86_64               randconfig-a006-20220425
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a006-20220425
i386                 randconfig-a002-20220425
i386                 randconfig-a005-20220425
i386                 randconfig-a003-20220425
i386                 randconfig-a001-20220425
i386                 randconfig-a004-20220425

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

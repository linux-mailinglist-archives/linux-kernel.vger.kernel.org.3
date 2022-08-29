Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD905A4439
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiH2Hyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiH2Hym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:54:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A919813D19
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 00:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661759681; x=1693295681;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0uZNNBItLs/QWlQb5mI6Gwx8bGbW/sY4euE5DrNSnz0=;
  b=GQANwYVscQfdgelOph0shsOCEjGOBNOVR2Mc5C/+VePj/9HZG7s1kom1
   y+l9dQf9BeGBb5vRnX286d7PCvpQKBouWoDXWkp/NQqm2TYWwEjGkytET
   JZRoNKuT4JBA0S0Rl8BGX1Q7PA/Np5dzmmNVcS95u5wY3b48jzudHuA+Y
   Igs9n87mbcO6bljt+qskVjdtP9iGpXgTKh9hc9EUmlhcAJu2G51yblFXa
   Y0WOs+lN/Jd8eDIzdx7vqkIz9J5cUBzbGQsAaMi4PW8aA4HfRheor6QyF
   tmOeJ9AzfbylM+rejvcD1PnYQJMY9yQ80wQ+SBFEySwbHxJLgJtpx0C8Y
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="356551189"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="356551189"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 00:54:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="640840198"
Received: from lkp-server01.sh.intel.com (HELO b2bbdd52f619) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Aug 2022 00:54:32 -0700
Received: from kbuild by b2bbdd52f619 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSZbL-0000N8-1d;
        Mon, 29 Aug 2022 07:54:31 +0000
Date:   Mon, 29 Aug 2022 15:54:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 a6fa671e8ba741d5cebb81742562d02d19a2b8af
Message-ID: <630c70ab.BzzKq3RmlkPon2XA%lkp@intel.com>
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
branch HEAD: a6fa671e8ba741d5cebb81742562d02d19a2b8af  Merge branch into tip/master: 'x86/timers'

elapsed time: 720m

configs tested: 126
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
loongarch                         allnoconfig
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
loongarch                           defconfig
csky                                defconfig
x86_64                                  kexec
sparc                            allyesconfig
x86_64                              defconfig
sparc                               defconfig
csky                              allnoconfig
riscv                             allnoconfig
x86_64                               rhel-8.3
s390                                defconfig
riscv                    nommu_virt_defconfig
i386                        debian-10.3-kunit
x86_64               randconfig-a003-20220829
powerpc                        cell_defconfig
x86_64                          rhel-8.3-func
xtensa                           allyesconfig
x86_64               randconfig-a004-20220829
arc                               allnoconfig
riscv                          rv32_defconfig
riscv                randconfig-r042-20220828
x86_64               randconfig-a005-20220829
alpha                             allnoconfig
i386                         debian-10.3-func
x86_64                         rhel-8.3-kunit
s390                             allmodconfig
um                                  defconfig
riscv                            allmodconfig
arc                              allyesconfig
x86_64                           rhel-8.3-kvm
i386                          debian-10.3-kvm
arc                  randconfig-r043-20220829
alpha                            allyesconfig
arc                  randconfig-r043-20220828
nios2                               defconfig
x86_64                    rhel-8.3-kselftests
i386                   debian-10.3-kselftests
x86_64                           allyesconfig
x86_64               randconfig-a002-20220829
powerpc                          allyesconfig
i386                              debian-10.3
m68k                       bvme6000_defconfig
riscv                               defconfig
x86_64               randconfig-a006-20220829
x86_64                           rhel-8.3-syz
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
i386                 randconfig-a001-20220829
nios2                            allyesconfig
i386                 randconfig-a003-20220829
m68k                             allyesconfig
arc                        nsimosci_defconfig
i386                 randconfig-a002-20220829
powerpc                           allnoconfig
m68k                             allmodconfig
i386                 randconfig-a004-20220829
powerpc                      makalu_defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                 randconfig-a005-20220829
parisc64                            defconfig
i386                 randconfig-a006-20220829
arm                             pxa_defconfig
s390                 randconfig-r044-20220828
x86_64               randconfig-a001-20220829
parisc                              defconfig
ia64                             allmodconfig
i386                                defconfig
mips                      fuloong2e_defconfig
s390                          debug_defconfig
arm                        spear6xx_defconfig
arm                                 defconfig
sh                               allmodconfig
powerpc                     tqm8555_defconfig
parisc                generic-64bit_defconfig
arm                          pxa3xx_defconfig
sh                        dreamcast_defconfig
mips                             allyesconfig
sh                          urquell_defconfig
powerpc                          allmodconfig
powerpc                       maple_defconfig
sh                          rsk7201_defconfig
i386                             allyesconfig
arm64                               defconfig
i386                          randconfig-c001
m68k                                defconfig
ia64                                defconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                              allmodconfig
ia64                             allyesconfig
mips                             allmodconfig
i386                             alldefconfig
sh                            hp6xx_defconfig
xtensa                  nommu_kc705_defconfig
arm                         lubbock_defconfig
loongarch                        alldefconfig
sh                                  defconfig
arm                           corgi_defconfig

clang tested configs:
mips                           ip28_defconfig
powerpc                     tqm8560_defconfig
powerpc                      walnut_defconfig
hexagon              randconfig-r041-20220829
riscv                randconfig-r042-20220829
hexagon              randconfig-r041-20220828
s390                 randconfig-r044-20220829
hexagon              randconfig-r045-20220828
hexagon              randconfig-r045-20220829
powerpc                    ge_imp3a_defconfig
arm                     davinci_all_defconfig
x86_64               randconfig-a011-20220829
riscv                    nommu_virt_defconfig
i386                 randconfig-a011-20220829
x86_64               randconfig-a014-20220829
i386                 randconfig-a014-20220829
x86_64               randconfig-a016-20220829
i386                 randconfig-a013-20220829
x86_64               randconfig-a015-20220829
i386                 randconfig-a012-20220829
x86_64               randconfig-a012-20220829
i386                 randconfig-a015-20220829
x86_64               randconfig-a013-20220829
i386                 randconfig-a016-20220829

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

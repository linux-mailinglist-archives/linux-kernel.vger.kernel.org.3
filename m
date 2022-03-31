Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D48B4EDFB0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiCaRfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiCaRfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:35:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD964507D
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 10:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648748010; x=1680284010;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rjBhwrsUW1QcHMo026YNOf+aUum4ZPfnVBc2ulzFlKc=;
  b=XiBMPDyOE8x181UigDPhsXZ49RUs2K4g9vkEZ6G7KZONp2jadYraVMVN
   F6lgcL8z643K0fqokzUQvACUI4nQHLnFYSo3121ne7M0bQhrM/mdW3o+w
   5X164TVf4ynBul+IxyAoOuAInqiUX7CQ7Tni6aBeNCU4npFx5Pzd8sKSo
   lJH+CqbZoAFkKqkSNrGNnDPKhsoaGSg0SoBaQm4MoyZ0K2/mMeY9eM4Lw
   uBWBArL4K1ktfk2UpazwKOE8hggVXXDCx0DSUyWexjm6/Xrn6OlR8Z973
   nHj9iFG3LRPBa6no1jURkSLSuj5d/1Gy5u2nbuwH3wBw2ZE0yVhezcPgJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259615354"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="259615354"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 10:33:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="654929645"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 31 Mar 2022 10:33:01 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZyfN-0000Ub-2z;
        Thu, 31 Mar 2022 17:33:01 +0000
Date:   Fri, 01 Apr 2022 01:32:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.03.29b] BUILD SUCCESS
 b9209c6b5fb310b6f3297617ad7aeabcd3de1d58
Message-ID: <6245e5c1.AGc3Lq+2EKIuPCHB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.03.29b
branch HEAD: b9209c6b5fb310b6f3297617ad7aeabcd3de1d58  tools/include/string: Implement `strdup()` and `strndup()`

elapsed time: 1103m

configs tested: 135
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                ecovec24-romimage_defconfig
arc                                 defconfig
arc                 nsimosci_hs_smp_defconfig
arm64                            alldefconfig
ia64                        generic_defconfig
parisc                              defconfig
s390                       zfcpdump_defconfig
arc                              alldefconfig
sh                            hp6xx_defconfig
sh                            migor_defconfig
powerpc                         wii_defconfig
powerpc                     taishan_defconfig
sh                             shx3_defconfig
powerpc                      chrp32_defconfig
powerpc                 mpc837x_mds_defconfig
sh                         microdev_defconfig
m68k                            q40_defconfig
powerpc                     sequoia_defconfig
arc                    vdk_hs38_smp_defconfig
sh                               j2_defconfig
powerpc                 mpc837x_rdb_defconfig
nios2                         10m50_defconfig
sh                           sh2007_defconfig
m68k                            mac_defconfig
powerpc                       ppc64_defconfig
arm                          pxa3xx_defconfig
xtensa                    smp_lx200_defconfig
powerpc                      ep88xc_defconfig
sh                          rsk7203_defconfig
arm                            xcep_defconfig
arm                         cm_x300_defconfig
arc                     nsimosci_hs_defconfig
sparc                       sparc32_defconfig
powerpc                 linkstation_defconfig
arm                        trizeps4_defconfig
sh                           se7724_defconfig
arm                       aspeed_g5_defconfig
parisc                           alldefconfig
i386                                defconfig
arc                        nsim_700_defconfig
arm                     eseries_pxa_defconfig
ia64                      gensparse_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220331
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
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
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
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220331
powerpc              randconfig-c003-20220331
riscv                randconfig-c006-20220331
mips                 randconfig-c004-20220331
powerpc                    socrates_defconfig
powerpc                   lite5200b_defconfig
arm                          pcm027_defconfig
powerpc                     ksi8560_defconfig
arm                      pxa255-idp_defconfig
powerpc                     mpc5200_defconfig
mips                     cu1830-neo_defconfig
arm                            mmp2_defconfig
mips                       rbtx49xx_defconfig
powerpc                    mvme5100_defconfig
arm                            dove_defconfig
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
hexagon              randconfig-r045-20220331
hexagon              randconfig-r041-20220331
riscv                randconfig-r042-20220331

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

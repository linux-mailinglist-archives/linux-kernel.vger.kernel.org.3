Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5433A4D4048
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 05:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239149AbiCJE3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 23:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbiCJE3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 23:29:39 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DE2F70CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 20:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646886519; x=1678422519;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=r5P6pgmFvpUwPme6Z0RWBtZLIpzLTXQmfNYivHdmpCQ=;
  b=QzKgRdRFZbk0l6jEwLIUtpq+N12cvXlN2R8UooN7d51C84+LOFQUc0Fl
   tC6GqgFNCcirgiKEGJNp1JHW0ecEhclaaLdm0NXMmNKYeXjLB44OnvEg3
   0j6Y9d6xC/Ey3WZkTUon8E9AwqnIEioEggflyWqlBHNCosIhb8vmTE3pU
   vfY71X97Z1oqtiDyCbs2g6vzRGZ1MSLSxAXQF8WRaBTp4fk8QAKM+Vdvw
   h1aed/71WFnS790AlaWqrHalgeQPV4RCSIfIHPTJOpVBsc7d8gnNswBMj
   IHVFcweQMSFL7m4Y6CYgjU+M89wFY0R1ozj2KZxCbuucuMjcu76ZG92wq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="318381003"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="318381003"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 20:28:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="642413411"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2022 20:28:37 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSAPl-0004JC-4l; Thu, 10 Mar 2022 04:28:37 +0000
Date:   Thu, 10 Mar 2022 12:27:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 445c1470b6ef96440e7cfc42dfc160f5004fd149
Message-ID: <62297e4c.FH2lTw+61kqlxcJN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 445c1470b6ef96440e7cfc42dfc160f5004fd149  x86/boot: Add setup_indirect support in early_memremap_is_setup_data()

elapsed time: 720m

configs tested: 149
configs skipped: 108

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                  maltasmvp_eva_defconfig
powerpc                     sequoia_defconfig
powerpc                     taishan_defconfig
ia64                             alldefconfig
arm                        clps711x_defconfig
m68k                       m5208evb_defconfig
sparc64                          alldefconfig
sh                              ul2_defconfig
powerpc                      tqm8xx_defconfig
arm                         cm_x300_defconfig
arm                       multi_v4t_defconfig
sh                            migor_defconfig
h8300                     edosk2674_defconfig
sh                           se7206_defconfig
arm                           corgi_defconfig
arm                        spear6xx_defconfig
mips                           gcw0_defconfig
sh                          sdk7786_defconfig
mips                       capcella_defconfig
arm                           viper_defconfig
powerpc                 mpc8540_ads_defconfig
arc                          axs103_defconfig
powerpc                    klondike_defconfig
arm                       aspeed_g5_defconfig
sh                        apsh4ad0a_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
sh                               allmodconfig
m68k                         apollo_defconfig
parisc64                         alldefconfig
powerpc                  iss476-smp_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                           se7780_defconfig
sh                                  defconfig
sh                 kfr2r09-romimage_defconfig
sparc                       sparc64_defconfig
arm                           tegra_defconfig
arm                         axm55xx_defconfig
arc                 nsimosci_hs_smp_defconfig
h8300                               defconfig
m68k                          multi_defconfig
mips                         rt305x_defconfig
sh                          rsk7264_defconfig
arm                          exynos_defconfig
nios2                            alldefconfig
arm                            pleb_defconfig
mips                        vocore2_defconfig
powerpc                     asp8347_defconfig
xtensa                       common_defconfig
sh                  sh7785lcr_32bit_defconfig
openrisc                         alldefconfig
sh                             espt_defconfig
powerpc                     rainier_defconfig
arm                        mini2440_defconfig
sh                           se7705_defconfig
sh                           se7722_defconfig
arm                        keystone_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                            qcom_defconfig
powerpc                     stx_gp3_defconfig
mips                           xway_defconfig
arm                  randconfig-c002-20220309
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
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
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220309
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
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
riscv                randconfig-c006-20220309
powerpc              randconfig-c003-20220309
i386                          randconfig-c001
arm                  randconfig-c002-20220309
arm                                 defconfig
riscv                             allnoconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     tqm8560_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220309
hexagon              randconfig-r041-20220309
riscv                randconfig-r042-20220309

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

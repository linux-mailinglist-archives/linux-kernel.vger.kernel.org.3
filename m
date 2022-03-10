Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCE34D4067
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 05:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbiCJEtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 23:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbiCJEtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 23:49:40 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6177841336
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 20:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646887720; x=1678423720;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+1w06Q+yQJCRUdHszNrahxFwWk0rMz5ruLBYYOeZ7bQ=;
  b=cs3v6HKLD9Z8/8773e34bpFJ8CAJ3jl+TcAYXwpeB7A9Oj8Te6OGfGDK
   F3SWfUv7ZpuvestN32eLTxbx6QMsUxvXKAu22rQdYwpfMHS5mgvwTnHWq
   /V9PhHb3GY4Lig7+JuQ9eWocflHkwqDw5njrNq0/ZTURHdihz3zbeLXQ2
   13+YEJNk7adPhTbXrBCa3GH+QIYfi0q1QhnJhsGEGRtdnepO122jwv4Mw
   ovmfg4KEa67Cfarl5uDWWEU3sI+7A21Tflh5+IX4Q+C7oU48+vXNATKbu
   RSdwnFPqdfH3Cfa4sff+5hRohtlmJbQYJINVV1nfsz/pScYnrLWScnndJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="341587954"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="341587954"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 20:48:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="632862538"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Mar 2022 20:48:38 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSAj7-0004Kj-Og; Thu, 10 Mar 2022 04:48:37 +0000
Date:   Thu, 10 Mar 2022 12:48:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.03.01a] BUILD SUCCESS
 7bf8d644f869260f63eaaedebabdd2054f59ecc4
Message-ID: <62298322.dHSgi2qk4QJIZIoe%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.03.01a
branch HEAD: 7bf8d644f869260f63eaaedebabdd2054f59ecc4  fixup! EXP srcu: Check for too many zero-delay srcu_reschedule() calls

elapsed time: 740m

configs tested: 155
configs skipped: 4

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
sh                               allmodconfig
sh                        apsh4ad0a_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
m68k                         apollo_defconfig
parisc64                         alldefconfig
powerpc                  iss476-smp_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                           se7780_defconfig
um                                  defconfig
m68k                          multi_defconfig
sh                                  defconfig
sh                 kfr2r09-romimage_defconfig
sparc                       sparc64_defconfig
arm                           tegra_defconfig
arm                         axm55xx_defconfig
arc                 nsimosci_hs_smp_defconfig
h8300                               defconfig
mips                         rt305x_defconfig
sh                          rsk7264_defconfig
arm                          exynos_defconfig
nios2                            alldefconfig
arm                            pleb_defconfig
mips                        vocore2_defconfig
powerpc                      chrp32_defconfig
sh                         ap325rxa_defconfig
parisc                generic-32bit_defconfig
powerpc                 mpc837x_mds_defconfig
sh                            hp6xx_defconfig
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
arc                                 defconfig
h8300                            allyesconfig
xtensa                           allyesconfig
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
arc                  randconfig-r043-20220309
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
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
powerpc                 mpc8540_ads_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     tqm8560_defconfig
mips                     cu1830-neo_defconfig
arm                           spitz_defconfig
arm                          pxa168_defconfig
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

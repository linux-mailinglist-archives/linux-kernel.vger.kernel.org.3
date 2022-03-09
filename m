Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBD64D3D85
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 00:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238867AbiCIXZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 18:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238086AbiCIXZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 18:25:26 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA7062A36
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 15:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646868266; x=1678404266;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/+pWGwfm3L+x1xsi7HHDEjGfwaS9kh9Y1QienuGjKbM=;
  b=Jrl+MN/59KdxZZSYYRFbxv/hdJlZUHEl5vumzIHj/zoxTVZgc4syV/IF
   5IKgVkYDEc5LkyV7P546F1j+NEFRQ8xY39mPOT7t43Ss/VTEK0AgghlZZ
   OuaNSwRGFeTmjJcFivOe1D1Bbgox4JbQS+10sWr+F61lmMbSycBY04OTj
   Uz4cb700qxqiRnE9T/t+fLczxL3OeopxcPWbQDrZ8Maju84voEnc+K0P3
   wRocmF+pO0zfZRUd9pID6xZj4YixDeQPiyKFcTYbw86ztJBogewJGc+8L
   c/gcRQpzlDAK44ag41uS+lDohegE3KPwEe9f8EhQGzerCp+eaqnP65txo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="235064381"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="235064381"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 15:24:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="644222597"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 09 Mar 2022 15:24:24 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nS5fL-0003xJ-Le; Wed, 09 Mar 2022 23:24:23 +0000
Date:   Thu, 10 Mar 2022 07:24:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 8959fcf5650e1a344ce8a71c0d7203318e8faa84
Message-ID: <62293715.olJEllcPbldw+B+N%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 8959fcf5650e1a344ce8a71c0d7203318e8faa84  x86/alternative: Use .ibt_endbr_seal to seal indirect calls

elapsed time: 853m

configs tested: 105
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
powerpc                      tqm8xx_defconfig
arm                         cm_x300_defconfig
arm                       multi_v4t_defconfig
sh                            migor_defconfig
mips                           gcw0_defconfig
sh                          sdk7786_defconfig
mips                       capcella_defconfig
arm                           viper_defconfig
powerpc                 mpc8540_ads_defconfig
arc                          axs103_defconfig
sh                                  defconfig
sh                 kfr2r09-romimage_defconfig
sparc                       sparc64_defconfig
arm                           tegra_defconfig
mips                         rt305x_defconfig
sh                          rsk7264_defconfig
arm                          exynos_defconfig
openrisc                         alldefconfig
sh                             espt_defconfig
powerpc                     rainier_defconfig
powerpc                     sequoia_defconfig
arm                        mini2440_defconfig
arm                            qcom_defconfig
powerpc                     stx_gp3_defconfig
arm                  randconfig-c002-20220309
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
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
sh                               allmodconfig
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
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a016
i386                          randconfig-a014
i386                          randconfig-a012
arc                  randconfig-r043-20220309
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
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
s390                 randconfig-r044-20220309

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E114D6D8E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 09:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiCLI3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 03:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiCLI3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 03:29:31 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF6C1DD0E1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 00:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647073706; x=1678609706;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=V84UHGfUUc9EBJ0+RP2e3LRwu5+YQ5tnufzlqeNhHmQ=;
  b=NMzw9RfORF+aS+ZsWin2ToHc4VTbCuuOaoQoyUKqZpqYv4Zc8ffaBXKc
   uEe69S1XjAYEm/YUBxi8AeN3ra8BuCfSIoU1GP613ntGALvBU73ck6ttB
   JDDf11MzEB8ioLSek96f/hfNkBA0zcVn0y+NNOxCVK0nL5aIOV+Vqub1+
   jTzZP1zYd6IoUnS/ygQ27zqwBHI7QfX+nFoUM2rP6bzvjch4zt6+frgj4
   Re7ke/5ya2FTV9NdEdMbrz+wynO9QrfCpjnHSbfOg05KeOe9dEOyv5MHi
   vf2mw59gpk9sznIIMNIKFOsMmXZIgpqU0q6j0aJ63n38HR1XH5q/ww9Jd
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="253336200"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="253336200"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 00:28:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="633695699"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Mar 2022 00:28:25 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSx6u-0007iT-J1; Sat, 12 Mar 2022 08:28:24 +0000
Date:   Sat, 12 Mar 2022 16:28:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 9e1db76f44de4d9439e48c9ef61e5d457395202b
Message-ID: <622c5999.svGB30AihHglAQtP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 9e1db76f44de4d9439e48c9ef61e5d457395202b  x86,bpf: Fix bpf_arch_text_poke()

elapsed time: 1059m

configs tested: 101
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
mips                        vocore2_defconfig
i386                             alldefconfig
arm                            zeus_defconfig
mips                           gcw0_defconfig
sh                        apsh4ad0a_defconfig
m68k                           sun3_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        trizeps4_defconfig
sh                ecovec24-romimage_defconfig
parisc64                            defconfig
arm                          lpd270_defconfig
powerpc                       ppc64_defconfig
ia64                      gensparse_defconfig
arm                  randconfig-c002-20220310
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
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
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220310
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
arm                         shannon_defconfig
powerpc                     akebono_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220310
hexagon              randconfig-r045-20220310
s390                 randconfig-r044-20220310
riscv                randconfig-r042-20220310

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

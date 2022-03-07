Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B824D081C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245202AbiCGUCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245224AbiCGUB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:01:58 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B727C8933D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646683263; x=1678219263;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XatpkQCUgwTKz/y5tYMLZcuQD7A0FmaT7uHI50aOOig=;
  b=Va4Mwe8qbota6YeZd0FJZjZWFeciTGUolS0m9gpw516y+Gu3/MwbXYlm
   TtjnECDJEd7vV12fL9kQtI2QqYmziDA/svkJitlgvmb4sof8T6A9uWY1v
   DrQARLbyDGME1XgPjI09YuL5OEBs3091Q0+mEhJuw6SJgqXrTr4dfxgpq
   yF4h8F5C+EKzU26MdEykiAbgfheYo2YFwiazsAhZOyGKha7k9QnbiHkvP
   KWfgbgvxHLcAvXNMg2nKVGv5t1KwZ0r7Sr311fun5Zmm2l423dV+zOwf3
   iFtCUH0YeZkKVGgCClw+pXEk8XfILvdEsjDShbnFLSJrFaU0t+Am3MAXh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="234445955"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="234445955"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 12:01:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="780441966"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 07 Mar 2022 12:01:02 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRJXR-0000f9-Ne; Mon, 07 Mar 2022 20:01:01 +0000
Date:   Tue, 08 Mar 2022 04:00:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/core] BUILD SUCCESS
 bf9ad37dc8a30cce22ae95d6c2ca6abf8731d305
Message-ID: <6226644a.7d8moH9PhsNjJtNr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/core
branch HEAD: bf9ad37dc8a30cce22ae95d6c2ca6abf8731d305  signal, x86: Delay calling signals in atomic on RT enabled kernels

elapsed time: 770m

configs tested: 104
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220307
powerpc                     pq2fads_defconfig
um                             i386_defconfig
ia64                          tiger_defconfig
m68k                        m5272c3_defconfig
arm                        multi_v7_defconfig
powerpc                    amigaone_defconfig
sh                           se7724_defconfig
arm                           tegra_defconfig
xtensa                         virt_defconfig
mips                         db1xxx_defconfig
arm                      jornada720_defconfig
powerpc                    klondike_defconfig
arm                         vf610m4_defconfig
arm                          exynos_defconfig
arm                  randconfig-c002-20220307
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
x86_64               randconfig-a006-20220307
x86_64               randconfig-a004-20220307
x86_64               randconfig-a005-20220307
x86_64               randconfig-a001-20220307
x86_64               randconfig-a003-20220307
x86_64               randconfig-a002-20220307
i386                 randconfig-a005-20220307
i386                 randconfig-a004-20220307
i386                 randconfig-a003-20220307
i386                 randconfig-a006-20220307
i386                 randconfig-a002-20220307
i386                 randconfig-a001-20220307
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20220307
i386                 randconfig-c001-20220307
powerpc              randconfig-c003-20220307
riscv                randconfig-c006-20220307
mips                 randconfig-c004-20220307
arm                  randconfig-c002-20220307
s390                 randconfig-c005-20220307
arm                       imx_v4_v5_defconfig
x86_64                           allyesconfig
mips                     cu1000-neo_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                   microwatt_defconfig
powerpc                          allmodconfig
mips                           rs90_defconfig
powerpc                     tqm8540_defconfig
powerpc                      ppc64e_defconfig
i386                 randconfig-a012-20220307
i386                 randconfig-a013-20220307
i386                 randconfig-a015-20220307
i386                 randconfig-a011-20220307
i386                 randconfig-a014-20220307
i386                 randconfig-a016-20220307
hexagon              randconfig-r045-20220307
riscv                randconfig-r042-20220307
hexagon              randconfig-r041-20220307

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

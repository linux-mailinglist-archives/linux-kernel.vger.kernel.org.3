Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D0F488706
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 00:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbiAHX6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 18:58:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:36430 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234993AbiAHX6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 18:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641686295; x=1673222295;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xsMPkkGUuklechvf2OLagmEIVOYMurAOB4hvlT6J/pc=;
  b=eom+q9QNHkrcyPbpXQGovgd3FIWnBhNDhPOvIAUderq6k+wPx3aoiYK/
   CbcpTdySZsI64dq5vLCwLLGxqaIx1wr58qiVWFQX3bqeVuDelUh586ZRu
   PpIPhkAsprWS2SKi2w9s+jMS97q/vTebkkgjXkrcEjJONIG0oTS+K1ycd
   yDa5ODlPv6XwHLWMDSkoCItaF8irveY4Wnk8yKadV2xC/UJ95TIa7H50E
   O3NmLp33xcyFtuZijIAiE+4kYsLq/vZKBOtagqSWX4V46Gb8WCW/k/qOJ
   OCRNrA/ZXrzT/AMVqLX0dMtfG8WjlHO1XXHjlnkACUYV4nOukj1XlHm4U
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="223032280"
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="223032280"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 15:58:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="489652115"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 08 Jan 2022 15:58:13 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6LbB-0001By-57; Sat, 08 Jan 2022 23:58:13 +0000
Date:   Sun, 09 Jan 2022 07:57:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 09122757c8101a3f07f6843a5401655193db0204
Message-ID: <61da24e7.lv8VPvIcmk4omMLU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 09122757c8101a3f07f6843a5401655193db0204  Merge branch into tip/master: 'core/core'

elapsed time: 723m

configs tested: 102
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220108
m68k                            q40_defconfig
powerpc                        warp_defconfig
arm                       multi_v4t_defconfig
sh                           se7619_defconfig
arm                           corgi_defconfig
m68k                         amcore_defconfig
mips                        bcm47xx_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
powerpc                     mpc83xx_defconfig
ia64                         bigsur_defconfig
arm                         cm_x300_defconfig
arm                           h3600_defconfig
sh                           se7721_defconfig
sh                               allmodconfig
arm                  randconfig-c002-20220108
ia64                                defconfig
ia64                             allmodconfig
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
i386                 randconfig-a004-20220107
i386                 randconfig-a006-20220107
i386                 randconfig-a002-20220107
i386                 randconfig-a001-20220107
i386                 randconfig-a003-20220107
i386                 randconfig-a005-20220107
x86_64               randconfig-a015-20220108
x86_64               randconfig-a012-20220108
x86_64               randconfig-a014-20220108
x86_64               randconfig-a013-20220108
x86_64               randconfig-a011-20220108
x86_64               randconfig-a016-20220108
i386                 randconfig-a012-20220108
i386                 randconfig-a016-20220108
i386                 randconfig-a015-20220108
i386                 randconfig-a014-20220108
i386                 randconfig-a011-20220108
i386                 randconfig-a013-20220108
s390                 randconfig-r044-20220108
arc                  randconfig-r043-20220108
riscv                randconfig-r042-20220108
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
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220108
mips                 randconfig-c004-20220108
i386                 randconfig-c001-20220108
riscv                randconfig-c006-20220108
powerpc              randconfig-c003-20220108
x86_64               randconfig-c007-20220108
powerpc                          allyesconfig
arm                       versatile_defconfig
x86_64               randconfig-a005-20220108
x86_64               randconfig-a001-20220108
x86_64               randconfig-a004-20220108
x86_64               randconfig-a006-20220108
x86_64               randconfig-a003-20220108
x86_64               randconfig-a002-20220108

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

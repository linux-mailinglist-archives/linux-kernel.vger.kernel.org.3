Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEE74742CC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbhLNMkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:40:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:37404 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234075AbhLNMkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639485615; x=1671021615;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=MS7IUx5oS2Z3M8qt93lhA/JdfRo+RykzJGloitg/XyE=;
  b=gs+A2HiYYkI5nfUdVKVRFjniHUuuc/x6fHr6PhzbRJsMNFqYhq3aYjo+
   vFOT/HXgTQ1LXydXb+VdYlslxEAZ0NQFGMdMBTLPk8K1YfqOAaSOrZoW4
   AVe4QfXbRY5JgetCLcxkENs+1ay+EHE0/ZCPI8EmPoEgpXK65vxIh1oh5
   +g3BXWFIFKyRcGprfhJDAjwwyUHqdAAfwYwSNhxIR1qWDqbsscJeagegT
   7/RztnviR4q33FC7WpW/PCBbjRt4SXehPASGILnR4BtP1PyhIChA90XzX
   FdW3rigGtAVbvOyrKCP6PdnxiZzmiE5atfeUF8gZnA2ccSZmwP5p9Kx5P
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="238779372"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="238779372"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 04:40:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="609725687"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 14 Dec 2021 04:40:08 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mx76F-0000Il-UK; Tue, 14 Dec 2021 12:40:07 +0000
Date:   Tue, 14 Dec 2021 20:39:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS WITH WARNING
 a4b57ded94e522e2870ae9504f776caa0f615148
Message-ID: <61b89072.qUNRw6XOvnTiAC5I%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: a4b57ded94e522e2870ae9504f776caa0f615148  rcu: Remove unused rcu_state.boost

Warning reports:

https://lore.kernel.org/lkml/202112141117.jFtY2VyL-lkp@intel.com
https://lore.kernel.org/lkml/202112141454.Emc8fZvq-lkp@intel.com

Warning in current branch:

kernel/rcu/tree.c:1180:19: warning: variable 'rnp' set but not used [-Wunused-but-set-variable]
kernel/rcu/tree.c:1180:26: warning: variable 'rnp' set but not used [-Wunused-but-set-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allmodconfig
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- arm-allyesconfig
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- arm-imx_v6_v7_defconfig
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- arm64-allyesconfig
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- arm64-randconfig-r012-20211213
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- i386-allyesconfig
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- i386-debian-10.3-kselftests
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- i386-randconfig-a003-20211214
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- i386-randconfig-a004-20211214
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- i386-randconfig-a006-20211214
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- i386-randconfig-a012-20211213
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- i386-randconfig-a013-20211213
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- i386-randconfig-a014-20211213
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- i386-randconfig-a015-20211213
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- i386-randconfig-c021-20211213
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- i386-randconfig-r022-20211213
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- i386-randconfig-s001-20211213
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- i386-randconfig-s002-20211213
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- mips-allmodconfig
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- mips-allyesconfig
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- powerpc-allmodconfig
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- powerpc-allyesconfig
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- powerpc-randconfig-c024-20211213
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- powerpc64-randconfig-r011-20211213
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- riscv-allmodconfig
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- riscv-allyesconfig
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- riscv-randconfig-r042-20211213
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- s390-allmodconfig
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- s390-allyesconfig
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- s390-buildonly-randconfig-r003-20211213
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- s390-randconfig-p001-20211213
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- s390-randconfig-r002-20211214
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- sparc-allyesconfig
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- sparc64-allyesconfig
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- sparc64-buildonly-randconfig-r001-20211214
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- sparc64-randconfig-r013-20211213
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- x86_64-allyesconfig
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- x86_64-randconfig-a011-20211213
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- x86_64-randconfig-a014-20211213
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- x86_64-randconfig-c022-20211213
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- x86_64-randconfig-c023-20211213
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- x86_64-randconfig-m001-20211213
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- x86_64-randconfig-m001-20211214
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- x86_64-randconfig-r002-20211214
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- x86_64-randconfig-s021-20211213
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
|-- x86_64-randconfig-s022-20211213
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
`-- x86_64-rhel-8.3-kselftests
    `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used

clang_recent_errors
|-- x86_64-randconfig-c007-20211213
|   `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used
`-- x86_64-randconfig-r021-20211214
    `-- kernel-rcu-tree.c:warning:variable-rnp-set-but-not-used

elapsed time: 726m

configs tested: 142
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211213
sh                          landisk_defconfig
powerpc                         wii_defconfig
powerpc                      acadia_defconfig
arm                        magician_defconfig
arm                        oxnas_v6_defconfig
arc                        vdk_hs38_defconfig
powerpc                     pq2fads_defconfig
arm                           h5000_defconfig
powerpc                 mpc837x_mds_defconfig
openrisc                 simple_smp_defconfig
powerpc                   motionpro_defconfig
arm                       imx_v6_v7_defconfig
arm                         s5pv210_defconfig
powerpc                     taishan_defconfig
arm                          pxa3xx_defconfig
sh                           se7722_defconfig
arc                     haps_hs_smp_defconfig
mips                     decstation_defconfig
mips                          rm200_defconfig
xtensa                  audio_kc705_defconfig
mips                           gcw0_defconfig
mips                         tb0219_defconfig
powerpc                       ebony_defconfig
parisc                           allyesconfig
arm                        trizeps4_defconfig
i386                             alldefconfig
sh                         ap325rxa_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                      ppc6xx_defconfig
powerpc                    sam440ep_defconfig
m68k                       m5208evb_defconfig
m68k                         apollo_defconfig
powerpc                       holly_defconfig
sh                              ul2_defconfig
m68k                       bvme6000_defconfig
powerpc                 canyonlands_defconfig
sh                        sh7785lcr_defconfig
arm                           sunxi_defconfig
mips                           ip22_defconfig
nds32                            alldefconfig
sh                           se7712_defconfig
m68k                        mvme147_defconfig
powerpc                     kilauea_defconfig
mips                      pic32mzda_defconfig
powerpc                     mpc512x_defconfig
m68k                          multi_defconfig
arm                  randconfig-c002-20211213
arm                  randconfig-c002-20211214
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
i386                 randconfig-a001-20211214
i386                 randconfig-a002-20211214
i386                 randconfig-a005-20211214
i386                 randconfig-a003-20211214
i386                 randconfig-a006-20211214
i386                 randconfig-a004-20211214
x86_64               randconfig-a011-20211213
x86_64               randconfig-a012-20211213
x86_64               randconfig-a014-20211213
x86_64               randconfig-a013-20211213
x86_64               randconfig-a016-20211213
x86_64               randconfig-a015-20211213
i386                 randconfig-a013-20211213
i386                 randconfig-a011-20211213
i386                 randconfig-a016-20211213
i386                 randconfig-a014-20211213
i386                 randconfig-a015-20211213
i386                 randconfig-a012-20211213
arc                  randconfig-r043-20211213
riscv                randconfig-r042-20211213
s390                 randconfig-r044-20211213
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20211213
arm                  randconfig-c002-20211213
riscv                randconfig-c006-20211213
mips                 randconfig-c004-20211213
i386                 randconfig-c001-20211213
s390                 randconfig-c005-20211213
powerpc              randconfig-c003-20211213
x86_64               randconfig-a006-20211213
x86_64               randconfig-a005-20211213
x86_64               randconfig-a001-20211213
x86_64               randconfig-a002-20211213
x86_64               randconfig-a003-20211213
x86_64               randconfig-a004-20211213
i386                 randconfig-a001-20211213
i386                 randconfig-a002-20211213
i386                 randconfig-a005-20211213
i386                 randconfig-a003-20211213
i386                 randconfig-a006-20211213
i386                 randconfig-a004-20211213
hexagon              randconfig-r045-20211213
hexagon              randconfig-r041-20211213

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

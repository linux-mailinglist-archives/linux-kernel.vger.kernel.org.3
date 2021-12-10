Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F4D46F9CD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 05:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhLJEXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 23:23:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:45615 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229767AbhLJEX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 23:23:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639109994; x=1670645994;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UzCH/FOfspuQCNwINB5h/u3CFKlgV5fLUKTh9f9PeL8=;
  b=iEi0b5ZUHgx0UFP47WhcXRZ7QfI9zCeuCHRsVlUeg3NxxWCq540aV0pj
   tV240mlzp8Q1zjhA2YHyQ6qX3t8xBRUXe0eSlINuXsbTChGrzULjz+EOo
   y4uo6tENCVJkcmhmcTBdgzW5hzVyC1He9L6eR57u8aVUq+q5vStwE/bGh
   +t6XRtb9LGRO2QcFM5y0bPg7LNVRiiBxz/Qo356P1XoYcaDQfosR+MY0x
   BhdeUZQlcwAKu/m3XuOGqlaXulE0x6e8scnCS4WrNvrrhyhjp/62ZeJ9/
   /RNcOyjwpSRzugsvimiEO6uc22QBtkNSufKKqwZcmmtWn0cyI0PeZGdJ0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="235780811"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="235780811"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 20:19:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="680608439"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 09 Dec 2021 20:19:53 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvXNw-0002kl-Ff; Fri, 10 Dec 2021 04:19:52 +0000
Date:   Fri, 10 Dec 2021 12:19:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/msi] BUILD SUCCESS
 60bf9b33c82c0e040a98272d7ff4f5a52e7469d6
Message-ID: <61b2d535.q7JzVtD3baxKwCmj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/msi
branch HEAD: 60bf9b33c82c0e040a98272d7ff4f5a52e7469d6  PCI/MSI: Move descriptor counting on allocation fail to the legacy code

elapsed time: 721m

configs tested: 174
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211209
i386                 randconfig-c001-20211210
powerpc              randconfig-c003-20211209
powerpc                    sam440ep_defconfig
m68k                        m5307c3_defconfig
sh                          sdk7780_defconfig
arm                           sunxi_defconfig
xtensa                  cadence_csp_defconfig
arm                          pxa3xx_defconfig
m68k                       m5475evb_defconfig
ia64                            zx1_defconfig
ia64                      gensparse_defconfig
powerpc                      tqm8xx_defconfig
arm                             mxs_defconfig
sh                        apsh4ad0a_defconfig
alpha                            allyesconfig
arm                            pleb_defconfig
ia64                        generic_defconfig
mips                          malta_defconfig
h8300                    h8300h-sim_defconfig
openrisc                 simple_smp_defconfig
sh                        sh7763rdp_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                     kilauea_defconfig
powerpc                      makalu_defconfig
sh                          lboxre2_defconfig
nios2                            alldefconfig
sh                          landisk_defconfig
powerpc                         wii_defconfig
arm                           tegra_defconfig
powerpc                        icon_defconfig
mips                        bcm63xx_defconfig
mips                           ip27_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                    socrates_defconfig
nds32                             allnoconfig
mips                  maltasmvp_eva_defconfig
mips                           rs90_defconfig
sh                           se7705_defconfig
powerpc                      mgcoge_defconfig
sh                          sdk7786_defconfig
arm                           sama7_defconfig
mips                         cobalt_defconfig
sh                          rsk7201_defconfig
arm                             rpc_defconfig
arm                        multi_v5_defconfig
powerpc                     redwood_defconfig
sh                          rsk7269_defconfig
arm                           sama5_defconfig
powerpc                     rainier_defconfig
arm                            dove_defconfig
nds32                               defconfig
m68k                         apollo_defconfig
arm                     am200epdkit_defconfig
mips                         mpc30x_defconfig
powerpc                 canyonlands_defconfig
m68k                             alldefconfig
arm                      jornada720_defconfig
m68k                          hp300_defconfig
arm                       omap2plus_defconfig
ia64                                defconfig
powerpc                     ep8248e_defconfig
arm                             ezx_defconfig
arm                       multi_v4t_defconfig
arm                             pxa_defconfig
m68k                        m5407c3_defconfig
powerpc                        warp_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                      chrp32_defconfig
um                           x86_64_defconfig
arm                       spear13xx_defconfig
arm                          pxa168_defconfig
powerpc                      ppc44x_defconfig
arm                  randconfig-c002-20211209
arm                  randconfig-c002-20211210
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211209
x86_64               randconfig-a005-20211209
x86_64               randconfig-a001-20211209
x86_64               randconfig-a002-20211209
x86_64               randconfig-a004-20211209
x86_64               randconfig-a003-20211209
i386                 randconfig-a001-20211209
i386                 randconfig-a005-20211209
i386                 randconfig-a003-20211209
i386                 randconfig-a002-20211209
i386                 randconfig-a006-20211209
i386                 randconfig-a004-20211209
i386                 randconfig-a001-20211210
i386                 randconfig-a002-20211210
i386                 randconfig-a005-20211210
i386                 randconfig-a003-20211210
i386                 randconfig-a006-20211210
i386                 randconfig-a004-20211210
arc                  randconfig-r043-20211209
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20211209
x86_64               randconfig-c007-20211209
riscv                randconfig-c006-20211209
i386                 randconfig-c001-20211209
mips                 randconfig-c004-20211209
powerpc              randconfig-c003-20211209
s390                 randconfig-c005-20211209
x86_64               randconfig-a016-20211209
x86_64               randconfig-a011-20211209
x86_64               randconfig-a013-20211209
x86_64               randconfig-a015-20211209
x86_64               randconfig-a012-20211209
x86_64               randconfig-a014-20211209
i386                 randconfig-a013-20211210
i386                 randconfig-a011-20211210
i386                 randconfig-a016-20211210
i386                 randconfig-a014-20211210
i386                 randconfig-a015-20211210
i386                 randconfig-a012-20211210
i386                 randconfig-a013-20211209
i386                 randconfig-a016-20211209
i386                 randconfig-a011-20211209
i386                 randconfig-a014-20211209
i386                 randconfig-a012-20211209
i386                 randconfig-a015-20211209
hexagon              randconfig-r045-20211209
s390                 randconfig-r044-20211209
hexagon              randconfig-r041-20211209
riscv                randconfig-r042-20211209
hexagon              randconfig-r045-20211210
riscv                randconfig-r042-20211210
s390                 randconfig-r044-20211210
hexagon              randconfig-r041-20211210

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

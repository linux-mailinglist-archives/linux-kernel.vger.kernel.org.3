Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22522473D04
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 07:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhLNGLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 01:11:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:47923 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229744AbhLNGLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 01:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639462272; x=1670998272;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=x72t4BcBV1oNay1PnwcQl/WgC3h5851hbaxwc68Ag7g=;
  b=R+VHgj294um4melD0vSNf4/wjPJIWegssMPRigaYy01jdThZWJ1KLrJ8
   9Cl+rnHSFQh54gmpnoPlLHqZzHDE/wd4Fwz5U5rubGGfIqMKbnBJImuz3
   ZCrEoLl+Apag2gswpVa8ClhYzOnKYkL/R3sWa6+zfY7h7mb+AyhLKLysZ
   YoMYdiUCXz13UMj/Rn5vcR++8MleypiRTDeuSeuLs1EAaU9psbbDho6i6
   guJvm9dMKgVOh2jD2nzGo4dEO97H80Cw8SQQMU9Opht8IfsRd+OZXNUJL
   Vi9K0l+egeNxArTshLNtaRKrSRpctu9eGVd3x3D/AADdmdzZ5I4cJ5JOw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="263044531"
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="263044531"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 22:11:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="481790360"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Dec 2021 22:11:10 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mx11p-0007Uq-QC; Tue, 14 Dec 2021 06:11:09 +0000
Date:   Tue, 14 Dec 2021 14:10:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 e3d72e8eee53c55835ab4664920d83400ff5d6c2
Message-ID: <61b83567.zQQdz0t8NhuT+n8j%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: e3d72e8eee53c55835ab4664920d83400ff5d6c2  x86/mce: Mark mce_start() noinstr

possible Warning in current branch (please contact us if interested):

vmlinux.o: warning: objtool: do_machine_check()+0x444: call to test_bit() leaves .noinstr.text section
vmlinux.o: warning: objtool: do_machine_check()+0xa1: call to mce_no_way_out() leaves .noinstr.text section
vmlinux.o: warning: objtool: mce_read_aux()+0x41: call to mca_msr_reg() leaves .noinstr.text section

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-a012-20211213
    |-- vmlinux.o:warning:objtool:do_machine_check():call-to-test_bit()-leaves-.noinstr.text-section
    `-- vmlinux.o:warning:objtool:mce_read_aux():call-to-mca_msr_reg()-leaves-.noinstr.text-section

clang_recent_errors
`-- x86_64-randconfig-a005-20211213
    `-- vmlinux.o:warning:objtool:do_machine_check():call-to-mce_no_way_out()-leaves-.noinstr.text-section

elapsed time: 729m

configs tested: 169
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211213
arc                        vdk_hs38_defconfig
powerpc                     pq2fads_defconfig
arm                           h5000_defconfig
powerpc                 mpc837x_mds_defconfig
openrisc                 simple_smp_defconfig
powerpc                     tqm5200_defconfig
powerpc                      walnut_defconfig
sh                ecovec24-romimage_defconfig
mips                           xway_defconfig
arm                        keystone_defconfig
powerpc                   motionpro_defconfig
powerpc                          allyesconfig
arm                       imx_v6_v7_defconfig
arm                         s5pv210_defconfig
powerpc                     taishan_defconfig
powerpc                      acadia_defconfig
arm                          pxa3xx_defconfig
sh                           se7722_defconfig
arc                     haps_hs_smp_defconfig
mips                     decstation_defconfig
mips                          rm200_defconfig
xtensa                  audio_kc705_defconfig
powerpc                   bluestone_defconfig
mips                           mtx1_defconfig
s390                             allyesconfig
m68k                       m5249evb_defconfig
mips                           gcw0_defconfig
mips                         tb0219_defconfig
powerpc                       ebony_defconfig
arm                        trizeps4_defconfig
arm                         at91_dt_defconfig
arm                       spear13xx_defconfig
powerpc64                        alldefconfig
sh                        sh7785lcr_defconfig
m68k                        stmark2_defconfig
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
arm                           sunxi_defconfig
mips                           ip22_defconfig
openrisc                         alldefconfig
mips                         bigsur_defconfig
arc                 nsimosci_hs_smp_defconfig
openrisc                            defconfig
powerpc                  iss476-smp_defconfig
m68k                          hp300_defconfig
mips                          malta_defconfig
powerpc                     ksi8560_defconfig
arc                          axs101_defconfig
powerpc                      obs600_defconfig
m68k                          atari_defconfig
mips                     loongson1c_defconfig
h8300                       h8s-sim_defconfig
arm                       multi_v4t_defconfig
mips                      loongson3_defconfig
arm                            qcom_defconfig
sh                           se7724_defconfig
mips                      bmips_stb_defconfig
mips                      pic32mzda_defconfig
powerpc                     mpc512x_defconfig
m68k                          multi_defconfig
arm                  randconfig-c002-20211213
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
i386                 randconfig-a013-20211214
i386                 randconfig-a011-20211214
i386                 randconfig-a016-20211214
i386                 randconfig-a014-20211214
i386                 randconfig-a015-20211214
i386                 randconfig-a012-20211214
hexagon              randconfig-r045-20211213
hexagon              randconfig-r041-20211213

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

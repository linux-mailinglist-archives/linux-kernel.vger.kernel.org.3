Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101E547E884
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 20:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350179AbhLWT4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 14:56:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:19666 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244935AbhLWT4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 14:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640289366; x=1671825366;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=WErW4BHcxtmCwZOjNoLXEmSmCYrSarVDP90bgNIp+Qk=;
  b=W1s/6j3pFnsnSvJLTAHBUPKgyfljBBysV2W0a43HMeKmZYzzm5p8BykU
   8JgID8FtuAXS31CKkg87HDDQ/WeRFxlFK3rKwv4lpsL3jiVo3GM5xsVob
   XsiFxEYd2gb3ZUaJKDyIGb/CTEOuCHWVxJzKjalwsbMluUYnWxyuq+ZbT
   nsH3xR9sjphU8gORHRMp1TLLC6K0twy7i1DVb867eqmUXommuopI1nkgt
   2qctLWLv8SgO4WtG5BK5Lb3URDfyenfT9nhQ6sKSU/gsMZYbZL+dYEzyN
   EiEODfg/OS+5lPln5wBp2R0OllG4E+8NjTSnD4Sp8O7Y6hlAkZ/yEyibA
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="240832688"
X-IronPort-AV: E=Sophos;i="5.88,230,1635231600"; 
   d="scan'208";a="240832688"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 11:56:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,230,1635231600"; 
   d="scan'208";a="468637690"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 Dec 2021 11:56:04 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n0UC4-0002Dg-8n; Thu, 23 Dec 2021 19:56:04 +0000
Date:   Fri, 24 Dec 2021 03:55:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 91f75eb481cfaee5c4ed8fb5214bf2fbfa04bd7b
Message-ID: <61c4d427.O/RFkp/ASu1G+qy1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 91f75eb481cfaee5c4ed8fb5214bf2fbfa04bd7b  x86/MCE/AMD, EDAC/mce_amd: Support non-uniform MCA bank type enumeration

possible Warning in current branch (please contact us if interested):

vmlinux.o: warning: objtool: do_machine_check()+0x3c3: call to test_bit() leaves .noinstr.text section
vmlinux.o: warning: objtool: mce_read_aux()+0x46: call to mca_msr_reg() leaves .noinstr.text section
vmlinux.o: warning: objtool: mce_start()+0x46: call to __tsan_atomic64_fetch_add() leaves .noinstr.text section

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-buildonly-randconfig-r002-20211222
    |-- vmlinux.o:warning:objtool:do_machine_check():call-to-test_bit()-leaves-.noinstr.text-section
    `-- vmlinux.o:warning:objtool:mce_read_aux():call-to-mca_msr_reg()-leaves-.noinstr.text-section

clang_recent_errors
`-- x86_64-randconfig-a013-20211222
    `-- vmlinux.o:warning:objtool:mce_start():call-to-__tsan_atomic64_fetch_add()-leaves-.noinstr.text-section

elapsed time: 1491m

configs tested: 189
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211223
arm                          moxart_defconfig
powerpc               mpc834x_itxgp_defconfig
sparc                       sparc64_defconfig
powerpc                         wii_defconfig
powerpc64                        alldefconfig
powerpc                      ppc44x_defconfig
powerpc                   bluestone_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                     loongson1b_defconfig
mips                        maltaup_defconfig
mips                  decstation_64_defconfig
sh                      rts7751r2d1_defconfig
arm                         lubbock_defconfig
arm                   milbeaut_m10v_defconfig
mips                             allmodconfig
m68k                        mvme147_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                      pcm030_defconfig
arc                     nsimosci_hs_defconfig
mips                         db1xxx_defconfig
arm                          badge4_defconfig
powerpc                     tqm8540_defconfig
mips                           ip22_defconfig
sparc                            allyesconfig
sh                          sdk7786_defconfig
powerpc                   motionpro_defconfig
arm                        clps711x_defconfig
sh                           se7343_defconfig
ia64                      gensparse_defconfig
h8300                     edosk2674_defconfig
arc                        vdk_hs38_defconfig
m68k                       m5208evb_defconfig
powerpc                     tqm8555_defconfig
arm                         lpc32xx_defconfig
mips                   sb1250_swarm_defconfig
arm                       aspeed_g4_defconfig
arm                          pxa3xx_defconfig
sh                           se7722_defconfig
mips                     cu1000-neo_defconfig
mips                            e55_defconfig
arm                             pxa_defconfig
sh                          kfr2r09_defconfig
powerpc                 mpc832x_mds_defconfig
ia64                             allyesconfig
powerpc                     skiroot_defconfig
powerpc                      ep88xc_defconfig
mips                     decstation_defconfig
arc                            hsdk_defconfig
powerpc                      pmac32_defconfig
arm                        oxnas_v6_defconfig
powerpc                     ppa8548_defconfig
sh                          rsk7264_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
powerpc                     kilauea_defconfig
arm                         hackkit_defconfig
mips                     loongson2k_defconfig
ia64                         bigsur_defconfig
mips                          ath25_defconfig
mips                          ath79_defconfig
arm                          pxa168_defconfig
powerpc                      makalu_defconfig
arm                        trizeps4_defconfig
arm                            zeus_defconfig
m68k                       m5475evb_defconfig
xtensa                    smp_lx200_defconfig
arm                        vexpress_defconfig
powerpc                          allmodconfig
arm                           corgi_defconfig
powerpc                     redwood_defconfig
arm                          iop32x_defconfig
powerpc                 mpc836x_mds_defconfig
s390                             allyesconfig
openrisc                            defconfig
m68k                       bvme6000_defconfig
alpha                               defconfig
riscv             nommu_k210_sdcard_defconfig
mips                         rt305x_defconfig
powerpc                       maple_defconfig
arm                            qcom_defconfig
powerpc                      obs600_defconfig
sh                          rsk7203_defconfig
mips                       capcella_defconfig
mips                         tb0226_defconfig
xtensa                           alldefconfig
sh                           se7724_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                           sunxi_defconfig
sh                           se7721_defconfig
arc                          axs101_defconfig
openrisc                         alldefconfig
arm                          pcm027_defconfig
powerpc                    adder875_defconfig
arm                     eseries_pxa_defconfig
arm                        neponset_defconfig
arm                  randconfig-c002-20211223
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20211222
i386                 randconfig-a003-20211222
i386                 randconfig-a001-20211222
i386                 randconfig-a005-20211222
i386                 randconfig-a006-20211222
i386                 randconfig-a004-20211222
x86_64               randconfig-a013-20211223
x86_64               randconfig-a015-20211223
x86_64               randconfig-a014-20211223
x86_64               randconfig-a011-20211223
x86_64               randconfig-a012-20211223
x86_64               randconfig-a016-20211223
i386                 randconfig-a012-20211223
i386                 randconfig-a011-20211223
i386                 randconfig-a014-20211223
i386                 randconfig-a016-20211223
i386                 randconfig-a015-20211223
i386                 randconfig-a013-20211223
x86_64               randconfig-a001-20211222
x86_64               randconfig-a003-20211222
x86_64               randconfig-a005-20211222
x86_64               randconfig-a006-20211222
x86_64               randconfig-a004-20211222
x86_64               randconfig-a002-20211222
arc                  randconfig-r043-20211222
arc                  randconfig-r043-20211223
riscv                randconfig-r042-20211223
s390                 randconfig-r044-20211223
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20211223
x86_64               randconfig-a003-20211223
x86_64               randconfig-a005-20211223
x86_64               randconfig-a006-20211223
x86_64               randconfig-a004-20211223
x86_64               randconfig-a002-20211223
i386                 randconfig-a006-20211223
i386                 randconfig-a004-20211223
i386                 randconfig-a002-20211223
i386                 randconfig-a003-20211223
i386                 randconfig-a005-20211223
i386                 randconfig-a001-20211223
hexagon              randconfig-r045-20211222
hexagon              randconfig-r041-20211222
riscv                randconfig-r042-20211222
s390                 randconfig-r044-20211222

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

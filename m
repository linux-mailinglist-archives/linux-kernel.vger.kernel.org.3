Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC7047F1B4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 03:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhLYCST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 21:18:19 -0500
Received: from mga06.intel.com ([134.134.136.31]:53633 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhLYCSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 21:18:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640398698; x=1671934698;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=goeosF5ioCv9tZgn9tzHLdEat0giZK/O8LYS10W/CLc=;
  b=OqCWXd5UIbt/yRQXM70SDA0Oekv9X065pQ94l9ngRJGscjtVLUVEioff
   c38UOExgshVdyNnNMdXCnOagRL7ttYZB8SLSl8OR7Lnq0XsJ79AAqTBjE
   rZPCA9j1rfI0cXya2XLdcgILJ37bjehKlKLf+bOJyxTPM66k2v8HiS8ga
   VblVSv6GExHxokJfnXHE+ldo5kK0LqeJjMc/7V33XMAL0Fr+OcgX5BE39
   Ie7fVpwlHQEtVHQMtlG1F5UlDtRP4IkAwmKrxjyetlyL/cGl572eq3DyZ
   yIJFw4tCNjiteJlhNspqveZghnGv9I2WpsEtQ2iucoWXtxI5lQ73lscsW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="301780936"
X-IronPort-AV: E=Sophos;i="5.88,233,1635231600"; 
   d="scan'208";a="301780936"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2021 18:18:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,233,1635231600"; 
   d="scan'208";a="608148598"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Dec 2021 18:18:16 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n0wdT-0003i3-Qq; Sat, 25 Dec 2021 02:18:15 +0000
Date:   Sat, 25 Dec 2021 10:18:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 efe89e99910e01ea1080e99b1eb6f97a00c59d08
Message-ID: <61c67f5d.gbwnTz8wARAORiTC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: efe89e99910e01ea1080e99b1eb6f97a00c59d08  Merge x86/build into tip/master

elapsed time: 723m

configs tested: 140
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211224
i386                 randconfig-c001-20211225
mips                         rt305x_defconfig
mips                       capcella_defconfig
arm                          ep93xx_defconfig
xtensa                  audio_kc705_defconfig
arm                        vexpress_defconfig
arc                     nsimosci_hs_defconfig
m68k                          amiga_defconfig
arm64                            alldefconfig
m68k                          sun3x_defconfig
arm                        trizeps4_defconfig
sh                        edosk7760_defconfig
arm                      pxa255-idp_defconfig
m68k                            mac_defconfig
mips                         tb0226_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                             pxa_defconfig
arc                                 defconfig
powerpc                 linkstation_defconfig
mips                        qi_lb60_defconfig
m68k                         amcore_defconfig
arm                           omap1_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc64                           defconfig
riscv                    nommu_virt_defconfig
xtensa                       common_defconfig
sh                            migor_defconfig
m68k                       m5475evb_defconfig
mips                           mtx1_defconfig
arc                            hsdk_defconfig
powerpc                     ksi8560_defconfig
csky                             alldefconfig
csky                                defconfig
sh                        apsh4ad0a_defconfig
mips                          rb532_defconfig
nios2                         3c120_defconfig
powerpc                       ebony_defconfig
sh                  sh7785lcr_32bit_defconfig
nios2                               defconfig
sparc                            allyesconfig
m68k                       m5275evb_defconfig
arm                        mini2440_defconfig
powerpc                      pmac32_defconfig
sh                           se7721_defconfig
sh                        sh7763rdp_defconfig
powerpc                     pseries_defconfig
m68k                          multi_defconfig
powerpc                 mpc8272_ads_defconfig
sparc                            alldefconfig
arm                             rpc_defconfig
xtensa                  nommu_kc705_defconfig
arm                            qcom_defconfig
mips                        omega2p_defconfig
arm                         lubbock_defconfig
h8300                               defconfig
arm                  randconfig-c002-20211224
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a003-20211224
x86_64               randconfig-a001-20211224
x86_64               randconfig-a005-20211224
x86_64               randconfig-a006-20211224
x86_64               randconfig-a004-20211224
x86_64               randconfig-a002-20211224
i386                 randconfig-a006-20211224
i386                 randconfig-a004-20211224
i386                 randconfig-a002-20211224
i386                 randconfig-a003-20211224
i386                 randconfig-a005-20211224
i386                 randconfig-a001-20211224
x86_64               randconfig-a013-20211225
x86_64               randconfig-a014-20211225
x86_64               randconfig-a015-20211225
x86_64               randconfig-a011-20211225
x86_64               randconfig-a012-20211225
x86_64               randconfig-a016-20211225
i386                 randconfig-a012-20211225
i386                 randconfig-a011-20211225
i386                 randconfig-a014-20211225
i386                 randconfig-a016-20211225
i386                 randconfig-a015-20211225
i386                 randconfig-a013-20211225
arc                  randconfig-r043-20211225
s390                 randconfig-r044-20211225
riscv                randconfig-r042-20211225
arc                  randconfig-r043-20211224
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
hexagon              randconfig-r041-20211224
hexagon              randconfig-r045-20211224
s390                 randconfig-r044-20211224
riscv                randconfig-r042-20211224
hexagon              randconfig-r041-20211225
hexagon              randconfig-r045-20211225

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1224F1407
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376570AbiDDLt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376579AbiDDLt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:49:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF291DEE7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 04:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649072851; x=1680608851;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Va4qYWMppawm/Zz/8SwdMk5TNxzvgUdJnvXhPz6uw/4=;
  b=cl0EX+I52/YQQrMRgOw4sFauBY6rzSMwL2/K4UQ2LyHv74g1+GlCvSPV
   +BvNnuDy9P3EDnl5Ouhf0W3MJbTEbx41fkdrF/GnM0bx7QIlPOIEyOC1T
   OugfdyfPL3VSvz6w47pEVED9DaXV6ApkJQbwFpffDKLHaAVAPY8hKnrfv
   ODelmzBX6wL5VGog6pjFcZtdSmTK9DjHBAnVyWqrxkMR8TX9EdHq15iIK
   4xDIRJ4IM7mvNTbMyBDX07OUwFvz4cPZKE8xXOMGdYfgnI6t4ZF+uQpuu
   MgggqQzF/XbR+zzAlZias5YWkyP5ZdQlwOPkN6eb2CZmORIbwju0jUZom
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="248007589"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="248007589"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 04:47:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="587542036"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 04 Apr 2022 04:47:13 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbLAu-00021E-Ao;
        Mon, 04 Apr 2022 11:47:12 +0000
Date:   Mon, 04 Apr 2022 19:46:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.03.30a] BUILD SUCCESS
 c5bf22d44924f7b839e4750d78e9c30c9687e8b3
Message-ID: <624adaa2.T8zdNFjBDF493yhS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.03.30a
branch HEAD: c5bf22d44924f7b839e4750d78e9c30c9687e8b3  squash! rcutorture: Allow rcutorture without RCU Tasks Trace

elapsed time: 724m

configs tested: 140
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                          gemini_defconfig
mips                        vocore2_defconfig
powerpc                           allnoconfig
sh                          rsk7269_defconfig
sh                 kfr2r09-romimage_defconfig
parisc64                         alldefconfig
sh                          rsk7264_defconfig
arm                           sama5_defconfig
powerpc                    klondike_defconfig
sh                        edosk7705_defconfig
m68k                          hp300_defconfig
sh                           se7722_defconfig
arm                           h3600_defconfig
arm                          simpad_defconfig
arm                           stm32_defconfig
parisc                           alldefconfig
alpha                               defconfig
sh                             sh03_defconfig
powerpc                     taishan_defconfig
ia64                        generic_defconfig
arc                            hsdk_defconfig
sh                     sh7710voipgw_defconfig
arm                        oxnas_v6_defconfig
sh                        sh7763rdp_defconfig
arc                              alldefconfig
powerpc                      ppc6xx_defconfig
powerpc                 mpc834x_itx_defconfig
sh                          r7785rp_defconfig
sh                            migor_defconfig
xtensa                generic_kc705_defconfig
arm                        spear6xx_defconfig
parisc                generic-64bit_defconfig
x86_64                              defconfig
sh                         ecovec24_defconfig
sh                   sh7770_generic_defconfig
arm                         cm_x300_defconfig
arm                        mvebu_v7_defconfig
mips                         rt305x_defconfig
mips                    maltaup_xpa_defconfig
sh                   secureedge5410_defconfig
sh                               j2_defconfig
i386                 randconfig-c001-20220404
x86_64               randconfig-c001-20220404
arm                  randconfig-c002-20220404
arm                  randconfig-c002-20220403
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a011-20220404
x86_64               randconfig-a013-20220404
x86_64               randconfig-a015-20220404
x86_64               randconfig-a012-20220404
x86_64               randconfig-a016-20220404
x86_64               randconfig-a014-20220404
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                 randconfig-a014-20220404
i386                 randconfig-a013-20220404
i386                 randconfig-a016-20220404
i386                 randconfig-a015-20220404
i386                 randconfig-a011-20220404
i386                 randconfig-a012-20220404
riscv                randconfig-r042-20220404
arc                  randconfig-r043-20220403
arc                  randconfig-r043-20220404
s390                 randconfig-r044-20220404
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                               defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220403
riscv                randconfig-c006-20220403
mips                 randconfig-c004-20220403
arm                  randconfig-c002-20220403
mips                   sb1250_swarm_defconfig
arm                         socfpga_defconfig
x86_64               randconfig-a006-20220404
x86_64               randconfig-a002-20220404
x86_64               randconfig-a001-20220404
x86_64               randconfig-a005-20220404
x86_64               randconfig-a003-20220404
x86_64               randconfig-a004-20220404
i386                 randconfig-a006-20220404
i386                 randconfig-a002-20220404
i386                 randconfig-a001-20220404
i386                 randconfig-a004-20220404
i386                 randconfig-a003-20220404
i386                 randconfig-a005-20220404
hexagon              randconfig-r045-20220403
riscv                randconfig-r042-20220403
hexagon              randconfig-r041-20220403
hexagon              randconfig-r045-20220404
hexagon              randconfig-r041-20220404
s390                 randconfig-r044-20220403

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

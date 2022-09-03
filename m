Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9156B5AC184
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 00:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiICWCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 18:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiICWCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 18:02:13 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79FB4F68B
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 15:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662242532; x=1693778532;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8fBW0viorQMJ2c0oueLm4TdDYwvawv+uq/THXTY8Ao4=;
  b=DV/yyoLMLHAYRLLxxzZi0dxON2tIg0K8MUJrOAcqD9LUxZzuMkZ+TrXi
   ILFeYoZM12kYHGp6OT9qAoYZ5ia6R74AQYCbEL9KblPtx6rFN+wo0E/C7
   WyaPF/hdD3/H3dXQUdSnVdV3tQTFq4gC730nGXtkeAkw8YU0AQlDU8W6z
   ykPYkcreJ+hJ94Jq78C2zmHWKI3Yzcgj2cG07IQbK5JZEgk7+K2RryUQt
   fKSiuPVpZJf6sQ6yopMleb1q90z8OsyviwFLyHU5wjTmygk3F4iaHjDsy
   pss3Ip4sNWFNb1g5+ZHVqqcnSqRJAEY+CUT2kxtM6NeVT/grw9RoU5+i5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="283181453"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="283181453"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 15:02:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="590463651"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 03 Sep 2022 15:02:11 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUbDO-0002G5-1y;
        Sat, 03 Sep 2022 22:02:10 +0000
Date:   Sun, 04 Sep 2022 06:02:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/fam0-non-uapi] BUILD SUCCESS
 0811296c55b7f0c5b038410828e37a1a1bf04463
Message-ID: <6313cedb.plLpwX/OMUi/bqIU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/fam0-non-uapi
branch HEAD: 0811296c55b7f0c5b038410828e37a1a1bf04463  exportfs: Replace zero-length array with DECLARE_FLEX_ARRAY() helper

elapsed time: 723m

configs tested: 124
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                          randconfig-a016
x86_64                        randconfig-a015
x86_64                        randconfig-a002
i386                          randconfig-a001
powerpc                          allmodconfig
i386                          randconfig-a005
sh                           sh2007_defconfig
arc                              alldefconfig
mips                             allyesconfig
x86_64                           rhel-8.3-syz
arc                               allnoconfig
arc                  randconfig-r043-20220901
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                                defconfig
arm                                 defconfig
i386                          randconfig-a003
powerpc                           allnoconfig
x86_64                              defconfig
x86_64                        randconfig-a004
x86_64                          rhel-8.3-func
alpha                             allnoconfig
m68k                             allmodconfig
x86_64                        randconfig-a013
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
i386                          randconfig-a012
x86_64                        randconfig-a011
x86_64                    rhel-8.3-kselftests
arc                          axs101_defconfig
i386                             allyesconfig
arc                  randconfig-r043-20220903
x86_64                               rhel-8.3
arc                              allyesconfig
sh                               allmodconfig
sh                           se7722_defconfig
powerpc                     taishan_defconfig
sh                   rts7751r2dplus_defconfig
mips                    maltaup_xpa_defconfig
arm                              allyesconfig
arm64                            allyesconfig
riscv                             allnoconfig
sh                         microdev_defconfig
csky                              allnoconfig
openrisc                 simple_smp_defconfig
m68k                         apollo_defconfig
powerpc                    adder875_defconfig
alpha                            allyesconfig
m68k                             allyesconfig
arc                        nsim_700_defconfig
arm                          simpad_defconfig
mips                            ar7_defconfig
arm                           sunxi_defconfig
arm                           sama5_defconfig
m68k                          multi_defconfig
powerpc                       ppc64_defconfig
sparc64                             defconfig
ia64                             allmodconfig
loongarch                           defconfig
sh                 kfr2r09-romimage_defconfig
arm                            qcom_defconfig
riscv                               defconfig
powerpc                     tqm8555_defconfig
s390                             allyesconfig
i386                          randconfig-c001
loongarch                         allnoconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220902
m68k                        m5407c3_defconfig
powerpc                        warp_defconfig
arm                           h5000_defconfig
arm                            zeus_defconfig
powerpc                     rainier_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
ia64                                defconfig
m68k                             alldefconfig
sh                          sdk7780_defconfig
mips                      fuloong2e_defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a016
i386                          randconfig-a015
riscv                randconfig-r042-20220903
hexagon              randconfig-r041-20220903
i386                          randconfig-a002
hexagon              randconfig-r045-20220901
x86_64                        randconfig-a003
hexagon              randconfig-r045-20220903
riscv                randconfig-r042-20220901
x86_64                        randconfig-a005
i386                          randconfig-a011
arm                         mv78xx0_defconfig
hexagon              randconfig-r041-20220901
i386                          randconfig-a004
i386                          randconfig-a006
arm                       spear13xx_defconfig
s390                 randconfig-r044-20220901
i386                          randconfig-a013
x86_64                        randconfig-a012
s390                 randconfig-r044-20220903
arm                         s3c2410_defconfig
x86_64                        randconfig-a014
powerpc                 xes_mpc85xx_defconfig
powerpc                          g5_defconfig
arm                      pxa255-idp_defconfig
powerpc                     powernv_defconfig
powerpc                       ebony_defconfig
powerpc                     tqm5200_defconfig
powerpc                     kilauea_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                      walnut_defconfig
arm                          ixp4xx_defconfig
x86_64                        randconfig-k001
powerpc                      ppc64e_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

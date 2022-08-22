Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD6059CB54
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 00:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238432AbiHVWNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 18:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238399AbiHVWNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 18:13:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CAE328
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 15:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661206393; x=1692742393;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=fQX9oc4Ey5I/hNmpBfab9sOxuXvkkvd3xDp1S7whLTs=;
  b=erfblxiisnRfiemD7nGQKhqH0Rg0sIE4qlFpQqxoKYWlAXpF2cM/UJ/I
   0NdCHV+FFNrXDgU+8TNPvrqfQIQfqhKrMadbR3FUNzY8zeEKW+GDV2mqL
   xJqbPPUhv/YfEuCkFlUj33tlOUCCDrk8cx/sYKuOcWHY20dBWlw1rRmZY
   coVnAvM0stOnKEPS8LMi9cUxUVMFLrpDQeE00RUDz75pC+0QtWHjTW7O/
   uOFjGP0hDoH52m8rjBEwIHCiVWtUXlX2YJSmdv79wOG0KG63JuA9m/Kxn
   KMTNhgO7Qn4EyYHU5fMR1Rs1HbfntwzIDfpapY4YxwnFiEBEw/pvMIwVH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="294322333"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="294322333"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 15:13:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="638386008"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Aug 2022 15:13:11 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQFfT-0000mx-0g;
        Mon, 22 Aug 2022 22:13:11 +0000
Date:   Tue, 23 Aug 2022 06:12:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 cf90f46223eef9d5f389b4b88ee2fc7914458b06
Message-ID: <6303ff58.+ksQLzobPTdnzrMJ%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: cf90f46223eef9d5f389b4b88ee2fc7914458b06  Merge branch into tip/master: 'x86/timers'

elapsed time: 726m

configs tested: 144
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a013-20220822
mips                             allyesconfig
i386                 randconfig-a011-20220822
powerpc                          allmodconfig
i386                 randconfig-a012-20220822
sh                               allmodconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
i386                 randconfig-a014-20220822
i386                 randconfig-a016-20220822
i386                 randconfig-a015-20220822
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20220821
arm                                 defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                                defconfig
arm                              allyesconfig
arm64                            allyesconfig
x86_64               randconfig-a014-20220822
x86_64               randconfig-a012-20220822
arc                              allyesconfig
x86_64               randconfig-a013-20220822
alpha                            allyesconfig
x86_64               randconfig-a011-20220822
csky                              allnoconfig
m68k                             allyesconfig
arc                               allnoconfig
m68k                             allmodconfig
alpha                             allnoconfig
x86_64               randconfig-a015-20220822
riscv                             allnoconfig
x86_64               randconfig-a016-20220822
i386                             allyesconfig
ia64                             allmodconfig
sh                          rsk7201_defconfig
powerpc                 canyonlands_defconfig
arm                          badge4_defconfig
sh                   sh7724_generic_defconfig
sh                            titan_defconfig
s390                             allmodconfig
riscv                randconfig-r042-20220822
s390                 randconfig-r044-20220822
arc                  randconfig-r043-20220822
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
loongarch                           defconfig
loongarch                         allnoconfig
sh                          rsk7264_defconfig
arc                     haps_hs_smp_defconfig
arm                          exynos_defconfig
xtensa                  nommu_kc705_defconfig
mips                            gpr_defconfig
sh                   sh7770_generic_defconfig
arm                         lubbock_defconfig
sh                                  defconfig
parisc                generic-32bit_defconfig
i386                          randconfig-c001
arm                      footbridge_defconfig
arm                         axm55xx_defconfig
powerpc                 mpc85xx_cds_defconfig
loongarch                 loongson3_defconfig
mips                           xway_defconfig
arc                              alldefconfig
arc                                 defconfig
sparc                               defconfig
powerpc                      ppc6xx_defconfig
sh                          rsk7269_defconfig
ia64                            zx1_defconfig
arm                        oxnas_v6_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                        cell_defconfig
arm                             pxa_defconfig
mips                    maltaup_xpa_defconfig
mips                          rb532_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                    amigaone_defconfig
arc                           tb10x_defconfig
arc                 nsimosci_hs_smp_defconfig
m68k                          amiga_defconfig
sh                               j2_defconfig
powerpc                     taishan_defconfig
arm                        cerfcube_defconfig
powerpc                mpc7448_hpc2_defconfig

clang tested configs:
x86_64               randconfig-a002-20220822
x86_64               randconfig-a004-20220822
x86_64               randconfig-a003-20220822
x86_64               randconfig-a001-20220822
x86_64               randconfig-a005-20220822
x86_64               randconfig-a006-20220822
hexagon              randconfig-r045-20220821
hexagon              randconfig-r041-20220821
riscv                randconfig-r042-20220821
s390                 randconfig-r044-20220821
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
powerpc                      katmai_defconfig
arm                        neponset_defconfig
mips                      maltaaprp_defconfig
arm                         s5pv210_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                          moxart_defconfig
arm                         bcm2835_defconfig
i386                 randconfig-a002-20220822
i386                 randconfig-a005-20220822
i386                 randconfig-a001-20220822
i386                 randconfig-a006-20220822
i386                 randconfig-a003-20220822
i386                 randconfig-a004-20220822
x86_64                        randconfig-k001
arm                     am200epdkit_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                     mpc5200_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
powerpc                        fsp2_defconfig
arm                          sp7021_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                    gamecube_defconfig
arm                         palmz72_defconfig
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

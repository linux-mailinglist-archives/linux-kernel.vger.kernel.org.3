Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF17557F347
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 06:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiGXE6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 00:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGXE6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 00:58:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79D0183BF
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 21:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658638720; x=1690174720;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GUaULa1J7RNGAM1hVBKNWN/czkZa2DSE0AoXiaBwBuQ=;
  b=mxzfVi0Aam9mRCr70FQy66CZCXaO43OMLqeIqoUGy240QijNK83eIl3/
   w3UA0nwAx9sZ7ZBEfY5fy1fs9IJi+iRiJ+dvFVTeGxAT4ThJqp4uP9xKU
   wCM0jFRjWWJgsZliEEg4IARYmgtclpj8Xa7Hvqq2kinfq60OT4IXF1VXW
   K00orzRX/OJg2Y4C5hdKwUhFiW/MOzVYuBepzD3IL/Pcs4LjmAWZ5aLaF
   QeMJbUddGn/Jub4o3gmdE5KeN6E8JKuK1Vv8NAUv9djOJ/3bE21OIfdO3
   lAGSPa6775SVTjm/zU6zeWWpI2TezS4BHyC4VytGJWa9Y7dD0ATWJH04n
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="267288578"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="267288578"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 21:58:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="549602074"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Jul 2022 21:58:39 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFThO-0003ZQ-11;
        Sun, 24 Jul 2022 04:58:38 +0000
Date:   Sun, 24 Jul 2022 12:58:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 1ad094e97207be677c2a3c2f28fc76e2a754c5d6
Message-ID: <62dcd174.9yTzxzQb9S9FQ3c+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 1ad094e97207be677c2a3c2f28fc76e2a754c5d6  Merge x86/core into tip/master

elapsed time: 721m

configs tested: 111
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                               alldefconfig
arm                          lpd270_defconfig
m68k                            mac_defconfig
um                                  defconfig
arm                           h5000_defconfig
mips                  decstation_64_defconfig
mips                         mpc30x_defconfig
powerpc                     pq2fads_defconfig
mips                       bmips_be_defconfig
mips                         bigsur_defconfig
sh                          rsk7269_defconfig
sh                     magicpanelr2_defconfig
sh                          r7785rp_defconfig
parisc                           alldefconfig
m68k                          amiga_defconfig
mips                 decstation_r4k_defconfig
sh                        sh7763rdp_defconfig
m68k                         amcore_defconfig
arm                            hisi_defconfig
sh                         ap325rxa_defconfig
xtensa                  nommu_kc705_defconfig
arm                           stm32_defconfig
arm                           tegra_defconfig
sh                                  defconfig
parisc                generic-64bit_defconfig
riscv                               defconfig
powerpc                 mpc837x_rdb_defconfig
mips                          rb532_defconfig
openrisc                         alldefconfig
powerpc                     tqm8548_defconfig
m68k                       m5208evb_defconfig
sh                            titan_defconfig
arm                            pleb_defconfig
ia64                         bigsur_defconfig
loongarch                           defconfig
parisc64                         alldefconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                         allnoconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-c001
arm                  randconfig-c002-20220724
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220724
riscv                randconfig-r042-20220724
s390                 randconfig-r044-20220724
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                          malta_defconfig
powerpc                 mpc832x_mds_defconfig
arm                       mainstone_defconfig
mips                        qi_lb60_defconfig
mips                        bcm63xx_defconfig
riscv                    nommu_virt_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     ppa8548_defconfig
mips                      malta_kvm_defconfig
mips                           rs90_defconfig
powerpc                   microwatt_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        spear3xx_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220724
hexagon              randconfig-r045-20220724

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

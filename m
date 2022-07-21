Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A671C57D55B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiGUU75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiGUU7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:59:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3506904E2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 13:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658437194; x=1689973194;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5G6eEwaey1KnQr2At9qze2kaA1RjheNkIje8PKWjOWo=;
  b=RA8xi2PKWH0v1OxijNGZQ1EMjygE5Fibghl0S9exGeCuTN5NkjSbXAX+
   fxqWDnDLxGJJVcJdn6nIHorDa75TJuFGI+7/W5ii5KlR2YHawBLTTyvSs
   yilSrl4JI0SJI9ldyCFJjk8HENwW3yGCFbj74ajn1keuM4aI5Cx8XpTsz
   bpZnSXYZxQmoVSmegUs1IwjJaFXGpfcWeZ4EDiJf3cxRKhoLNdbbnpfTH
   ks0w0sKBzi+YaWuZWsTW0f4gCSHZZuuvg2X/+i0JvhfV7iqZJtRZBXp1F
   Zqq4KnMn6XeFlQSa/2VZZXce7Q5RTn1KwXsudfSbGJQo9gcvORnphl3dP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="284725810"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="284725810"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 13:59:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="626291116"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Jul 2022 13:59:53 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEdGy-0000YA-1C;
        Thu, 21 Jul 2022 20:59:52 +0000
Date:   Fri, 22 Jul 2022 04:59:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 14b3f2d9ee8df3b6040f7e21f9fcd1d848938fd9
Message-ID: <62d9be39.bko6cYzB1j+l+fXx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 14b3f2d9ee8df3b6040f7e21f9fcd1d848938fd9  sched/fair: Disallow sync wakeup from interrupt context

elapsed time: 728m

configs tested: 101
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                        spear6xx_defconfig
arm                          pxa910_defconfig
mips                        vocore2_defconfig
powerpc                         ps3_defconfig
m68k                        mvme147_defconfig
xtensa                           alldefconfig
ia64                        generic_defconfig
xtensa                    smp_lx200_defconfig
arm                         assabet_defconfig
parisc                generic-64bit_defconfig
arm                         at91_dt_defconfig
powerpc                       maple_defconfig
sh                               alldefconfig
arm                           sama5_defconfig
sh                   sh7770_generic_defconfig
xtensa                       common_defconfig
m68k                       bvme6000_defconfig
arm                             rpc_defconfig
arm                        shmobile_defconfig
arc                          axs103_defconfig
xtensa                              defconfig
m68k                            mac_defconfig
arm                           viper_defconfig
arm                             pxa_defconfig
powerpc                      tqm8xx_defconfig
mips                           gcw0_defconfig
arm                        oxnas_v6_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
loongarch                           defconfig
loongarch                         allnoconfig
arm                  randconfig-c002-20220721
x86_64                        randconfig-c001
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a012-20220718
x86_64               randconfig-a011-20220718
i386                 randconfig-a013-20220718
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220721
s390                 randconfig-r044-20220718
riscv                randconfig-r042-20220718
arc                  randconfig-r043-20220718
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
mips                      malta_kvm_defconfig
arm                                 defconfig
arm                           spitz_defconfig
powerpc                        fsp2_defconfig
powerpc                          allyesconfig
arm                             mxs_defconfig
arm                      tct_hammer_defconfig
mips                        qi_lb60_defconfig
mips                           mtx1_defconfig
powerpc                     kmeter1_defconfig
powerpc                  mpc866_ads_defconfig
x86_64                           allyesconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                 randconfig-a001-20220718
i386                 randconfig-a006-20220718
i386                 randconfig-a002-20220718
i386                          randconfig-a004
i386                          randconfig-a002
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220721
hexagon              randconfig-r045-20220721
riscv                randconfig-r042-20220721
s390                 randconfig-r044-20220721

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

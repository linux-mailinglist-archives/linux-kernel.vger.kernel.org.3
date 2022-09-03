Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ED55ABED4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 13:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiICL5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 07:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiICL5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 07:57:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AAB78BD9
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 04:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662206252; x=1693742252;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=WMfD17hOuYZbjKMAArmXOTMgvOGXcrPvbKUtOcHN7dc=;
  b=Wm959D5YuYjQ2qtd4woJQrFaKv2lSiZZYyengQcu692dqGCsDsnCuycT
   wdGdzogN9RlWUP3F735tBmeuNvtXYOkD83C4QzLxtM/jQWXnHAXeVydDb
   rWjDeMKxhE4+nm8OX1djQ3h5hiNqsC7Xji7mVjifb7r+Dzpy2N9UyqrL0
   D8sJklWzG4PqdSei0eAQb2GHbxezna5uWjDi6Fu0bWCrTZJDTiG3EA6tj
   P8r4xLe/qRoxKwNTLHx/GqkYZ5ajtqw/3UXIa0+MC9qH9Q3Reo1S3mSSb
   LdSVDKA3xN6QcD4B+e0CVxakHOtVGoCOJhpho34q8n7EKEYKj0Hbe3HTV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="279168110"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="279168110"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 04:57:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="609239673"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 03 Sep 2022 04:57:30 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oURmE-0001cz-0T;
        Sat, 03 Sep 2022 11:57:30 +0000
Date:   Sat, 03 Sep 2022 19:56:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/6.0-rc2-fam0-non-uapi] BUILD SUCCESS
 8a09a674560855effa4e33efa15de1eece07bf04
Message-ID: <631340fa.Yeyv0QF7jroP2ISf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/6.0-rc2-fam0-non-uapi
branch HEAD: 8a09a674560855effa4e33efa15de1eece07bf04  exportfs: Replace zero-length array with DECLARE_FLEX_ARRAY() helper

elapsed time: 720m

configs tested: 108
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
i386                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                               rhel-8.3
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a001
m68k                             allyesconfig
i386                          randconfig-a003
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a005
x86_64                           allyesconfig
i386                          randconfig-a016
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                             allyesconfig
arc                  randconfig-r043-20220901
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                          rhel-8.3-func
sh                               allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
parisc64                            defconfig
alpha                             allnoconfig
sh                        dreamcast_defconfig
xtensa                  nommu_kc705_defconfig
m68k                       m5249evb_defconfig
sh                                  defconfig
sh                        apsh4ad0a_defconfig
xtensa                              defconfig
arc                               allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
sh                     magicpanelr2_defconfig
xtensa                       common_defconfig
arm                            qcom_defconfig
riscv                               defconfig
arm                           stm32_defconfig
sparc64                          alldefconfig
powerpc                      tqm8xx_defconfig
mips                        vocore2_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arc                        nsim_700_defconfig
arm                          simpad_defconfig
sparc64                             defconfig
arm                           sunxi_defconfig
arm                           sama5_defconfig
sh                         microdev_defconfig
powerpc                    adder875_defconfig
powerpc                       ppc64_defconfig
mips                            ar7_defconfig
mips                    maltaup_xpa_defconfig
i386                          randconfig-c001
mips                           jazz_defconfig
um                               alldefconfig
mips                      loongson3_defconfig
arm                           tegra_defconfig
ia64                             allmodconfig
powerpc                        warp_defconfig
arm                           h5000_defconfig
arm                            zeus_defconfig
powerpc                     rainier_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220902
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a002
i386                          randconfig-a011
i386                          randconfig-a004
x86_64                        randconfig-a014
i386                          randconfig-a015
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a006
hexagon              randconfig-r041-20220901
riscv                randconfig-r042-20220901
x86_64                        randconfig-a001
hexagon              randconfig-r045-20220901
x86_64                        randconfig-a003
s390                 randconfig-r044-20220901
x86_64                        randconfig-a005
arm                         mv78xx0_defconfig
powerpc                   microwatt_defconfig
powerpc                       ebony_defconfig
riscv                            alldefconfig
powerpc                     tqm5200_defconfig
x86_64                        randconfig-k001
powerpc                      walnut_defconfig
arm                          ixp4xx_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

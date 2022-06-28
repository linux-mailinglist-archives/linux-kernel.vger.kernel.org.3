Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA10A55F182
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiF1Wmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiF1Wml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:42:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D473A712
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656456160; x=1687992160;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=MvKSuLa+hRfwe3A/6xhoiKuAedAcQ5IP42ZUvSWvZAA=;
  b=g0yGE4CmvhOV8I4eoST+56bzJ9ny3+dX30JoHOv+1iLQeXdioYsdOC3t
   NVTclZ70woc+Ddm5rmI34MG1z2+LiwEcLVtKp+UFxx0vNF8h6kklV9G/r
   gAQiH9j1u0Vo3XawknXSU+4UiSoUI4n0fg1iNxc0e3wsV9pfE/OtzBRtf
   Rzjqg8RBzKJ4rHj+ozGtBdl0WouTllDtRswLnY1XgQXqqx/Q18j+0Qgw7
   4aM1IO4gZa1Sw+RRTu9yD/OW9jRmEhffTapzL976EdF2UXdD2xNrX7l6T
   Z5cycffDwze1ckSKuwt5hai4ijJtBLugETUVTcA4kT4GtY4+zCP53Y03M
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="368180455"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="368180455"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 15:42:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="917357460"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2022 15:42:38 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6Jun-000Ahe-IB;
        Tue, 28 Jun 2022 22:42:37 +0000
Date:   Wed, 29 Jun 2022 06:42:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 891e465a1bd8798d5f97c3afb99393f123817fef
Message-ID: <62bb83dc.AZqvJI9zyIM7yUvL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 891e465a1bd8798d5f97c3afb99393f123817fef  x86/mce: Check whether writes to MCA_STATUS are getting ignored

elapsed time: 725m

configs tested: 90
configs skipped: 75

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20220627
xtensa                  audio_kc705_defconfig
sh                              ul2_defconfig
sh                               j2_defconfig
sh                           se7343_defconfig
parisc64                         alldefconfig
arm                          pxa910_defconfig
mips                      maltasmvp_defconfig
powerpc                     ep8248e_defconfig
xtensa                    smp_lx200_defconfig
sh                            hp6xx_defconfig
arm                           viper_defconfig
mips                           ip32_defconfig
arm                         vf610m4_defconfig
mips                        vocore2_defconfig
arm                            hisi_defconfig
powerpc                      ppc40x_defconfig
arc                     nsimosci_hs_defconfig
arm                        cerfcube_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                 mpc837x_mds_defconfig
sh                           se7712_defconfig
arm                      jornada720_defconfig
arm                        mini2440_defconfig
arm                      integrator_defconfig
arm                          simpad_defconfig
sh                         apsh4a3a_defconfig
arm                          exynos_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64               randconfig-k001-20220627
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
x86_64               randconfig-a012-20220627
x86_64               randconfig-a011-20220627
x86_64               randconfig-a013-20220627
x86_64               randconfig-a014-20220627
x86_64               randconfig-a015-20220627
x86_64               randconfig-a016-20220627
i386                 randconfig-a014-20220627
i386                 randconfig-a012-20220627
i386                 randconfig-a011-20220627
i386                 randconfig-a013-20220627
i386                 randconfig-a015-20220627
i386                 randconfig-a016-20220627
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                     tqm5200_defconfig
mips                        bcm63xx_defconfig
arm                     am200epdkit_defconfig
arm                      pxa255-idp_defconfig
arm                            dove_defconfig
arm                        neponset_defconfig
powerpc                      acadia_defconfig
mips                           ip27_defconfig
powerpc                     ksi8560_defconfig
x86_64               randconfig-a004-20220627
x86_64               randconfig-a006-20220627
x86_64               randconfig-a001-20220627
x86_64               randconfig-a005-20220627
x86_64               randconfig-a002-20220627
x86_64               randconfig-a003-20220627
i386                 randconfig-a005-20220627
i386                 randconfig-a001-20220627
i386                 randconfig-a006-20220627
i386                 randconfig-a004-20220627
i386                 randconfig-a003-20220627
i386                 randconfig-a002-20220627
hexagon              randconfig-r041-20220627
hexagon              randconfig-r045-20220627

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

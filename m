Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214094B4050
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbiBNDbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 22:31:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiBNDbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:31:50 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B9B5548A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 19:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644809504; x=1676345504;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=52IQI4cS29y2q6n1yCeJi/u72PGQ/UcbjHQhX7M9cQM=;
  b=b6T85IGO2KaFHlutCSJxCxDcH2J18imKHIfOddgAQPX6Rf1IQhZ9NvTC
   5Hs7lO2pa2eqsO7ylx4FopiMDDlRQS3lX+eHyRo4KsgDnqiMGrvKBGkEt
   eBb5Sho3liNGIVkuPr2+IeftTlhzGXo11Tv0W5VuTtwDjXXYMOyOecwbX
   vbtk53xUkdTZq+8yx7ubPxQkQtpm9tezeQ/gRNV1mo4yQoABxUMxwHGS0
   79DE1V8pWP21rRHsGRJ01jqmOLauyfTDReBnzr77OqBH4LdKboUZkfUh3
   FVnHb4r0udy3eJOZXtq3eE3G8O4xUJYCiA9/JvabHsAB4+9wiv5LL+1sC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="310740457"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="310740457"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 19:31:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="587015324"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 13 Feb 2022 19:31:25 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJS5F-00089f-7a; Mon, 14 Feb 2022 03:31:25 +0000
Date:   Mon, 14 Feb 2022 11:31:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 1e34064b60552616b2767d22f2e6f440ced09acb
Message-ID: <6209cd03.ES1cLD3Hhn2gGthz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: 1e34064b60552616b2767d22f2e6f440ced09acb  Merge tag 'irqchip-fixes-5.17-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

elapsed time: 723m

configs tested: 189
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
i386                 randconfig-c001-20220214
i386                          randconfig-c001
sh                          rsk7264_defconfig
arm                           h3600_defconfig
openrisc                            defconfig
m68k                        mvme147_defconfig
sh                            hp6xx_defconfig
powerpc64                        alldefconfig
sh                          sdk7786_defconfig
xtensa                    smp_lx200_defconfig
sh                   sh7770_generic_defconfig
powerpc                     pq2fads_defconfig
m68k                         apollo_defconfig
ia64                        generic_defconfig
mips                      maltasmvp_defconfig
parisc                generic-32bit_defconfig
sh                            shmin_defconfig
powerpc                 mpc85xx_cds_defconfig
sparc                       sparc64_defconfig
csky                                defconfig
powerpc                     mpc83xx_defconfig
arm                          pxa910_defconfig
arm                           corgi_defconfig
sh                ecovec24-romimage_defconfig
sh                              ul2_defconfig
mips                     decstation_defconfig
mips                         rt305x_defconfig
arc                     haps_hs_smp_defconfig
sh                        edosk7705_defconfig
powerpc                      cm5200_defconfig
powerpc                       eiger_defconfig
nds32                             allnoconfig
arc                 nsimosci_hs_smp_defconfig
m68k                       m5275evb_defconfig
m68k                       m5475evb_defconfig
powerpc                 linkstation_defconfig
mips                     loongson1b_defconfig
sparc64                             defconfig
sh                             shx3_defconfig
powerpc                      chrp32_defconfig
h8300                            alldefconfig
sh                         apsh4a3a_defconfig
sh                            titan_defconfig
m68k                            mac_defconfig
mips                         tb0226_defconfig
sparc64                          alldefconfig
mips                            gpr_defconfig
arm                         axm55xx_defconfig
sh                           se7721_defconfig
powerpc                     rainier_defconfig
powerpc                       ppc64_defconfig
s390                                defconfig
powerpc                    amigaone_defconfig
alpha                            alldefconfig
m68k                        stmark2_defconfig
sh                           se7722_defconfig
nios2                            alldefconfig
mips                         db1xxx_defconfig
powerpc                      ppc40x_defconfig
h8300                               defconfig
mips                            ar7_defconfig
xtensa                           alldefconfig
mips                 decstation_r4k_defconfig
mips                          rb532_defconfig
powerpc                  iss476-smp_defconfig
arm                  randconfig-c002-20220213
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc64                            defconfig
s390                             allyesconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64               randconfig-a013-20220214
x86_64               randconfig-a014-20220214
x86_64               randconfig-a012-20220214
x86_64               randconfig-a015-20220214
x86_64               randconfig-a011-20220214
x86_64               randconfig-a016-20220214
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                 randconfig-a013-20220214
i386                 randconfig-a016-20220214
i386                 randconfig-a012-20220214
i386                 randconfig-a015-20220214
i386                 randconfig-a011-20220214
i386                 randconfig-a014-20220214
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
riscv                randconfig-c006-20220213
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220213
arm                  randconfig-c002-20220213
i386                          randconfig-c001
mips                 randconfig-c004-20220213
powerpc                 mpc836x_rdk_defconfig
mips                   sb1250_swarm_defconfig
mips                           ip27_defconfig
arm                        neponset_defconfig
arm                       aspeed_g4_defconfig
hexagon                             defconfig
arm                     davinci_all_defconfig
powerpc                      ppc64e_defconfig
arm                              alldefconfig
mips                         tb0287_defconfig
powerpc                     tqm8540_defconfig
powerpc                     mpc5200_defconfig
arm                          moxart_defconfig
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-a005
x86_64               randconfig-a002-20220214
x86_64               randconfig-a006-20220214
x86_64               randconfig-a005-20220214
x86_64               randconfig-a004-20220214
x86_64               randconfig-a003-20220214
x86_64               randconfig-a001-20220214
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a004-20220214
i386                 randconfig-a005-20220214
i386                 randconfig-a006-20220214
i386                 randconfig-a002-20220214
i386                 randconfig-a003-20220214
i386                 randconfig-a001-20220214
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220213
hexagon              randconfig-r045-20220214
hexagon              randconfig-r041-20220214
hexagon              randconfig-r041-20220213
riscv                randconfig-r042-20220213
s390                 randconfig-r044-20220213

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

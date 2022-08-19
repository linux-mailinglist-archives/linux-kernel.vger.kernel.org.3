Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195175992FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 04:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244806AbiHSCOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 22:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbiHSCO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 22:14:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C130C558D6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 19:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660875266; x=1692411266;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FtdePT0ZzIx4qM3bdnGAXp/bePEi9jcartKgnqFsRLE=;
  b=kGVKkG6Fit8G9yxMhpPzwM8Q4kkC33DZE/xi14fGxHQ2cU+cqG8iCmRC
   dA32bKtrhPgcBWDl1uJRtiNYQ5E+/f6uaIv5Y+Fh+YaX5tlpB4OG6e8qx
   oXY8aB7FIo6wAsTJu06pSmA3IAhxQOaAEV8PS0HgW5yNPIHHAP+PdeYZH
   0DwMTUZomGQrBVtGab6Jydlyq0cFavP7XXAWNfEK5eSdRjJsWs7jBt5ep
   tarvTDQGImSSR0XvY6mb0hDcOjOKgP2NHB5XP/yU2nZ1YpUoCsrQjXM2j
   VvDme1WZO19Lu5uUaFJeVDcxBBA3H15T/NjQ0om/zo0J2+LT7na5Re8My
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="279877582"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="279877582"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 19:14:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="936043942"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 18 Aug 2022 19:14:23 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOrWg-0000vX-2v;
        Fri, 19 Aug 2022 02:14:22 +0000
Date:   Fri, 19 Aug 2022 10:13:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 3ecf671f1d354f40228e407ab350abd41034410b
Message-ID: <62fef1c4.+pFt0Z95FbBSCxqT%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: 3ecf671f1d354f40228e407ab350abd41034410b  x86/microcode: Document the whole late loading problem

elapsed time: 723m

configs tested: 114
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
sh                               allmodconfig
x86_64                              defconfig
powerpc                          allmodconfig
arm                                 defconfig
mips                             allyesconfig
i386                                defconfig
arc                  randconfig-r043-20220818
x86_64                               rhel-8.3
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                        randconfig-a011
arm                              allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a002
alpha                             allnoconfig
arm64                            allyesconfig
x86_64                    rhel-8.3-kselftests
riscv                             allnoconfig
riscv                randconfig-r042-20220818
csky                              allnoconfig
s390                 randconfig-r044-20220818
x86_64                        randconfig-a004
arc                               allnoconfig
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
i386                          randconfig-a001
x86_64                          rhel-8.3-func
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a003
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a006
i386                          randconfig-a005
i386                             allyesconfig
ia64                             allmodconfig
mips                      loongson3_defconfig
sh                          polaris_defconfig
arc                          axs103_defconfig
powerpc                       maple_defconfig
sh                        edosk7705_defconfig
powerpc                         wii_defconfig
sh                               j2_defconfig
mips                  decstation_64_defconfig
powerpc                      cm5200_defconfig
mips                            gpr_defconfig
sh                   rts7751r2dplus_defconfig
sh                                  defconfig
sh                               alldefconfig
loongarch                           defconfig
loongarch                         allnoconfig
sparc                             allnoconfig
m68k                         amcore_defconfig
xtensa                              defconfig
ia64                                defconfig
arm                           sama5_defconfig
sparc                       sparc64_defconfig
m68k                        m5307c3_defconfig
i386                          randconfig-c001
arm                        clps711x_defconfig
arm                      footbridge_defconfig
ia64                             alldefconfig
arm                            qcom_defconfig
m68k                           sun3_defconfig
sh                           sh2007_defconfig
arm                          gemini_defconfig
mips                         db1xxx_defconfig
mips                       bmips_be_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm                           sunxi_defconfig
arc                 nsimosci_hs_smp_defconfig
loongarch                        alldefconfig
m68k                                defconfig
arm64                               defconfig
m68k                          hp300_defconfig
sh                          landisk_defconfig
openrisc                       virt_defconfig
arm                          pxa910_defconfig
um                                  defconfig
arm                            mps2_defconfig

clang tested configs:
i386                          randconfig-a013
hexagon              randconfig-r041-20220818
hexagon              randconfig-r045-20220818
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
mips                        omega2p_defconfig
arm                             mxs_defconfig
x86_64                        randconfig-k001
arm                         s5pv210_defconfig
arm                         shannon_defconfig
riscv                randconfig-r042-20220819
s390                 randconfig-r044-20220819
hexagon              randconfig-r045-20220819
hexagon              randconfig-r041-20220819

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

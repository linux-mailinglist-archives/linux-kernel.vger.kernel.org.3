Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A854A52DF9F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245322AbiESVz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243496AbiESVzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:55:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62385E93
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652997350; x=1684533350;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2ab3id/8iPR+n/7YC89vmcdwcxlBU+vbcz1+L5Pls1c=;
  b=Vz6AXPzC41n8MrUsktfdIhpC87XFgYB42+tQJ398f9PYvKsO9LROMZS0
   ytdvH/AAyzu6JwaNI7drg7+HolzphITVjPDCrqJm/gAKtyYwNvhq8yAFG
   p5PnUai4s7nKkpiIewTBhAYAIg98v7smzWguq+D4n/sburBMn9i6ZdsAw
   OQjxB8KEIKTdd7CPC8NWFN0lgNwp4Irpdtklb7bsZ9LGmpHNVN4FY7oeM
   YhS9uvtIEvu85EVlF5efDUlYY1QeqU1QQrkh3tNYKM6EZ2bi+FomzIty2
   9ZfvOkKE/e/lW+I0sPQac9Qs/JrhjcbQ3cZObDJFLAmhxEAlhKfj6zJC7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272091893"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="272091893"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 14:55:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="661929366"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 19 May 2022 14:55:37 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nro7M-0003yv-HI;
        Thu, 19 May 2022 21:55:36 +0000
Date:   Fri, 20 May 2022 05:55:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 47f33de4aafb2f5e43d480d590a939d0f1d566a9
Message-ID: <6286bcd1.zXDun8TZ2tyouoFC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: 47f33de4aafb2f5e43d480d590a939d0f1d566a9  x86/sev: Mark the code returning to user space as syscall gap

elapsed time: 720m

configs tested: 154
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
m68k                          hp300_defconfig
m68k                             alldefconfig
openrisc                 simple_smp_defconfig
sh                         microdev_defconfig
xtensa                generic_kc705_defconfig
sh                           se7724_defconfig
powerpc                     rainier_defconfig
m68k                            mac_defconfig
sh                        sh7785lcr_defconfig
m68k                           sun3_defconfig
mips                         bigsur_defconfig
xtensa                    smp_lx200_defconfig
powerpc                     mpc83xx_defconfig
riscv                               defconfig
mips                           ci20_defconfig
x86_64                              defconfig
xtensa                          iss_defconfig
sh                           se7705_defconfig
powerpc                      pcm030_defconfig
sh                   sh7770_generic_defconfig
h8300                    h8300h-sim_defconfig
sh                        sh7763rdp_defconfig
powerpc                     sequoia_defconfig
riscv                            allyesconfig
arm                      jornada720_defconfig
arm                        realview_defconfig
ia64                      gensparse_defconfig
xtensa                       common_defconfig
powerpc64                           defconfig
mips                       capcella_defconfig
powerpc                 linkstation_defconfig
powerpc                        warp_defconfig
h8300                            allyesconfig
sh                   secureedge5410_defconfig
sh                            shmin_defconfig
mips                  decstation_64_defconfig
m68k                        stmark2_defconfig
sh                          landisk_defconfig
sh                           se7343_defconfig
sh                            migor_defconfig
nios2                            alldefconfig
arm                        mini2440_defconfig
arc                            hsdk_defconfig
mips                    maltaup_xpa_defconfig
arc                      axs103_smp_defconfig
xtensa                         virt_defconfig
arm                        keystone_defconfig
parisc64                            defconfig
powerpc                      arches_defconfig
m68k                          sun3x_defconfig
mips                           gcw0_defconfig
mips                         mpc30x_defconfig
parisc                           alldefconfig
mips                         rt305x_defconfig
sh                   rts7751r2dplus_defconfig
sh                          urquell_defconfig
ia64                         bigsur_defconfig
arc                         haps_hs_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220519
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc              randconfig-c003-20220519
x86_64                        randconfig-c007
riscv                randconfig-c006-20220519
mips                 randconfig-c004-20220519
i386                          randconfig-c001
arm                  randconfig-c002-20220519
s390                 randconfig-c005-20220519
powerpc                          g5_defconfig
hexagon                             defconfig
mips                     loongson2k_defconfig
arm                          pxa168_defconfig
mips                      pic32mzda_defconfig
mips                malta_qemu_32r6_defconfig
mips                  cavium_octeon_defconfig
riscv                          rv32_defconfig
powerpc                     akebono_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         shannon_defconfig
powerpc                       ebony_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                     tqm8540_defconfig
arm                         palmz72_defconfig
mips                            e55_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220519
riscv                randconfig-r042-20220519
hexagon              randconfig-r041-20220519
s390                 randconfig-r044-20220519

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

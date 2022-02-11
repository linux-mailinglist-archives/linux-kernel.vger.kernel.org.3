Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827174B2846
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351017AbiBKOt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:49:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbiBKOt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:49:57 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE3B133
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 06:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644590996; x=1676126996;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Aj1U+IntqjqngzRKK1z17ORqRjm38ebKNCoTqpgkJ0Q=;
  b=AyCpc1HiI/nb8pHg+8jci633zNz6k7hEOImdI+tJpOW+/2I/iDyg3tFJ
   9m3YmSr743csVibaZPX+UEyRoQ/8OSJsLqaYQ+FqOQL3JkzhIIujEARkE
   +c/TvO/UOumPaq1MBBRkQdnWZ5qA51VpmZ8uG4S6iJSzIgbT/GUE6Ln6X
   Av8QMf7i4w+VVj7ySaZu+uGK5zJ8XFrpufI2NyNNPMLg+AURKJOar6R5O
   6i4ZLuOcT5ijU11t4GerBrLKQOFKDWpJbnHpT5Lwl/CJtDyRLo1F0tH9U
   33s8BUZ9fnkx39IvbYAfp+jtwi9DrV1NwV1W7SqtRaj15j2wDYyfxYXS1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="274300491"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="274300491"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 06:49:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="483424911"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Feb 2022 06:49:54 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIXFB-0004hV-Nw; Fri, 11 Feb 2022 14:49:53 +0000
Date:   Fri, 11 Feb 2022 22:49:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 8795359e35bc33bf86b6d0765aa7f37431db3b9c
Message-ID: <6206777c.7e9/PRnGI9vUXdCY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 8795359e35bc33bf86b6d0765aa7f37431db3b9c  x86/sgx: Silence softlockup detection when releasing large enclaves

elapsed time: 726m

configs tested: 107
configs skipped: 117

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
xtensa                          iss_defconfig
openrisc                 simple_smp_defconfig
arm                          simpad_defconfig
arm                         at91_dt_defconfig
mips                  maltasmvp_eva_defconfig
arm                           stm32_defconfig
sh                           se7343_defconfig
riscv                    nommu_k210_defconfig
h8300                     edosk2674_defconfig
s390                             allmodconfig
powerpc                      ppc40x_defconfig
openrisc                         alldefconfig
sh                           se7724_defconfig
mips                     loongson1b_defconfig
m68k                       m5275evb_defconfig
arm                  randconfig-c002-20220211
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220211
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220211
arm                  randconfig-c002-20220211
i386                          randconfig-c001
mips                 randconfig-c004-20220211
arm                        mvebu_v5_defconfig
powerpc                      katmai_defconfig
powerpc                     mpc5200_defconfig
powerpc                     akebono_defconfig
mips                     loongson2k_defconfig
mips                         tb0219_defconfig
arm                         lpc32xx_defconfig
arm                          pxa168_defconfig
powerpc                   bluestone_defconfig
mips                      pic32mzda_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220211
hexagon              randconfig-r041-20220211
riscv                randconfig-r042-20220211

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

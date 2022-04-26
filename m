Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EA050EFF3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 06:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244106AbiDZEcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 00:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243726AbiDZEcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 00:32:20 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EC360D9A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 21:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650947354; x=1682483354;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=AKckjXYaxQGxTNPTsQ7PBu5TUGPg1ZpPQG3uCju+UvI=;
  b=M4jaAzTuNPt2FAOR4DfxzND0+08TqtBNGXriGhHwYT59K5S2ai8LwPvW
   +rSWnxYGlJJmC56l8uPZGlsgw0Byl6RLHKjaSa4p//es02ccfBJoPhlML
   Hhal7iNOYT70N6PP7hcPRZa9Ck4KofZzrnr3u1zUCCcmVg9HZFCd2EDxd
   qyI4OXmF9KxLl+ZRkwaPB8mIaHszoDByCP9jIuAWxhAxm00tVYc6I/skb
   WfCDy4Zes/ivci00eOqAHGm8kXHKiW/6wLTckrvbWlRAYEspWIxOP0ouu
   dffa9fDjshLKqM9ySxGvxWKWWJF6+s+oUeW8JDacUWUQ1geKTCiBEaa3S
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="351891210"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="351891210"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 21:28:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="512955263"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Apr 2022 21:28:23 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njCoJ-0003DC-0L;
        Tue, 26 Apr 2022 04:28:23 +0000
Date:   Tue, 26 Apr 2022 12:27:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 fa619f5156cf1ee3773edc6d756be262c9ef35de
Message-ID: <626774bd.EvNTJxOMGUjgEeXy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: fa619f5156cf1ee3773edc6d756be262c9ef35de  x86/mce: Add messages for panic errors in AMD's MCE grading

elapsed time: 740m

configs tested: 110
configs skipped: 87

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
mips                 randconfig-c004-20220425
i386                 randconfig-c001-20220425
powerpc                       ppc64_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                    sam440ep_defconfig
sh                           se7619_defconfig
powerpc                      pasemi_defconfig
sh                        sh7785lcr_defconfig
powerpc                    amigaone_defconfig
um                               alldefconfig
sh                              ul2_defconfig
sh                          sdk7786_defconfig
arm                           viper_defconfig
mips                      loongson3_defconfig
parisc64                            defconfig
sparc                               defconfig
arm                         lubbock_defconfig
h8300                       h8s-sim_defconfig
arc                     haps_hs_smp_defconfig
arm                           h3600_defconfig
xtensa                  nommu_kc705_defconfig
x86_64               randconfig-c001-20220425
arm                  randconfig-c002-20220425
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a015-20220425
x86_64               randconfig-a014-20220425
x86_64               randconfig-a011-20220425
x86_64               randconfig-a013-20220425
x86_64               randconfig-a012-20220425
x86_64               randconfig-a016-20220425
i386                 randconfig-a011-20220425
i386                 randconfig-a014-20220425
i386                 randconfig-a015-20220425
i386                 randconfig-a012-20220425
i386                 randconfig-a013-20220425
i386                 randconfig-a016-20220425
arc                  randconfig-r043-20220425
s390                 randconfig-r044-20220425
riscv                randconfig-r042-20220425
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
riscv                randconfig-c006-20220425
mips                 randconfig-c004-20220425
x86_64               randconfig-c007-20220425
arm                  randconfig-c002-20220425
i386                 randconfig-c001-20220425
powerpc              randconfig-c003-20220425
arm                        magician_defconfig
powerpc                       ebony_defconfig
arm                     davinci_all_defconfig
mips                        workpad_defconfig
mips                           ip27_defconfig
x86_64               randconfig-a002-20220425
x86_64               randconfig-a004-20220425
x86_64               randconfig-a003-20220425
x86_64               randconfig-a001-20220425
x86_64               randconfig-a005-20220425
x86_64               randconfig-a006-20220425
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a003-20220425
i386                 randconfig-a002-20220425
i386                 randconfig-a001-20220425
i386                 randconfig-a005-20220425
i386                 randconfig-a004-20220425
i386                 randconfig-a006-20220425

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

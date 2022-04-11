Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254774FBADB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344882AbiDKL2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241757AbiDKL2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:28:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C5538DAD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649676367; x=1681212367;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ptwZowuews8b7YIuVfZnUSjP57RWQMODKD8r+8x93NQ=;
  b=YNMqoYZbPuuvY6/gOj8w7JYo+Q3vUtta5xrXT8KW+FnUCM8ylDFkNgl/
   GahCyN1ns39cRMKYUtLtmXWGgE8+pWuv5NJX1VOnurGWX5xKK2WjlVdmr
   a+j6sQW58a1kebzjoR8VqtBlTlVfNBOxi3ZKeIfHhP7NDjdz9eicyoUR4
   UEg5F6WQWCQvIS8qBBo9qy+7kDb7f3XjXSCMv4XjAvA17Xw9HsEjOmwI1
   aa7QFSWNNgdTQF+CYbt86pe/oumQS7cFvowapBYHnnxpEQV/qRlpoxi5V
   7pXQBkKpchAQbDdjmnVoI6Di9lBfgN/qB4GblZq+w/oR3QXQeF6u4+gu0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="261836833"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="261836833"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 04:26:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="572081813"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 11 Apr 2022 04:25:58 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndsBB-0001oR-E3;
        Mon, 11 Apr 2022 11:25:57 +0000
Date:   Mon, 11 Apr 2022 19:25:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 c2a911d302b0d014a4d0d732a2bfc319e643eb62
Message-ID: <62541015.vjLLl8gdeoAYGyzL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: c2a911d302b0d014a4d0d732a2bfc319e643eb62  x86/mm: Replace nodes_weight() with nodes_empty() where appropriate

elapsed time: 726m

configs tested: 144
configs skipped: 72

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
powerpc              randconfig-c003-20220410
i386                          randconfig-c001
i386                 randconfig-c001-20220411
xtensa                         virt_defconfig
powerpc                     taishan_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                   currituck_defconfig
nios2                            alldefconfig
arm                       omap2plus_defconfig
arc                          axs101_defconfig
arm                             pxa_defconfig
arm                        mini2440_defconfig
powerpc                    adder875_defconfig
powerpc                      bamboo_defconfig
m68k                        m5307c3_defconfig
mips                        vocore2_defconfig
sh                          r7780mp_defconfig
sh                            migor_defconfig
powerpc                      makalu_defconfig
powerpc                     stx_gp3_defconfig
arc                          axs103_defconfig
arm                      jornada720_defconfig
sh                   sh7724_generic_defconfig
arm                           h3600_defconfig
arm                       multi_v4t_defconfig
arm                          pxa910_defconfig
m68k                       m5275evb_defconfig
powerpc                mpc7448_hpc2_defconfig
h8300                            allyesconfig
arm                        clps711x_defconfig
m68k                           sun3_defconfig
mips                         tb0226_defconfig
sh                        sh7785lcr_defconfig
openrisc                    or1ksim_defconfig
arm                  randconfig-c002-20220411
arm                  randconfig-c002-20220410
x86_64               randconfig-c001-20220411
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64               randconfig-a016-20220411
x86_64               randconfig-a012-20220411
x86_64               randconfig-a013-20220411
x86_64               randconfig-a014-20220411
x86_64               randconfig-a015-20220411
x86_64               randconfig-a011-20220411
i386                 randconfig-a015-20220411
i386                 randconfig-a011-20220411
i386                 randconfig-a016-20220411
i386                 randconfig-a012-20220411
i386                 randconfig-a013-20220411
i386                 randconfig-a014-20220411
riscv                randconfig-r042-20220411
arc                  randconfig-r043-20220411
s390                 randconfig-r044-20220411
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
arm                       netwinder_defconfig
arm                      pxa255-idp_defconfig
mips                         tb0219_defconfig
mips                      bmips_stb_defconfig
powerpc                     akebono_defconfig
mips                     loongson2k_defconfig
arm64                            allyesconfig
powerpc                     kilauea_defconfig
mips                          ath25_defconfig
powerpc                     powernv_defconfig
arm                         hackkit_defconfig
mips                       lemote2f_defconfig
mips                   sb1250_swarm_defconfig
mips                          malta_defconfig
powerpc                 mpc8272_ads_defconfig
arm                         s3c2410_defconfig
arm                          collie_defconfig
x86_64               randconfig-a003-20220411
x86_64               randconfig-a004-20220411
x86_64               randconfig-a006-20220411
x86_64               randconfig-a001-20220411
x86_64               randconfig-a002-20220411
x86_64               randconfig-a005-20220411
i386                 randconfig-a004-20220411
i386                 randconfig-a001-20220411
i386                 randconfig-a003-20220411
i386                 randconfig-a005-20220411
i386                 randconfig-a006-20220411
i386                 randconfig-a002-20220411
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
riscv                randconfig-r042-20220410
hexagon              randconfig-r041-20220411
hexagon              randconfig-r041-20220410
hexagon              randconfig-r045-20220411
hexagon              randconfig-r045-20220410

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

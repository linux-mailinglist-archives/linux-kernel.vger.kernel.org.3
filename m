Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039E6562B17
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 07:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbiGAFxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 01:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbiGAFxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 01:53:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2701902D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 22:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656654810; x=1688190810;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0iDwVs0meeDu9n02d5NWnR4P6WjXE0EdHHLt+iK/66k=;
  b=ClcU0gOsGv6Zd8NxWbI9b86Dygd4cwrO7o9ei8e/AU4ydLUZ6S4XED74
   v8j7AwPUc0L0vmisPQOCvRm339t9vU3GyzH3fG2aLzzm5YwBbw+RDL20P
   Bka7+Csf3IjXBIVakUIJD9mZUzePCkzW6Ep9QSnqPh+bkGKAB7dBAbnms
   5vg/yZ4b9H3Zanr/mpMJTBzSkajodSULiRMvuq5swV0e9GfZ8fCjK0BbM
   H9VW1zBKeyS5teoZ7o4qkAH0v0GcrFCzyXPXXDBaixua7sH1CQu6QuAP/
   eFgnp/BKC+3igNq8Iem6qUSOLDVBFpX41RucGlPsPuE6ubcQ5h0DR+dcG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="265591430"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="265591430"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 22:53:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="918344938"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jun 2022 22:53:29 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o79aq-000DcY-Hk;
        Fri, 01 Jul 2022 05:53:28 +0000
Date:   Fri, 01 Jul 2022 13:52:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:quic_neeraju.2022.06.30a] BUILD SUCCESS
 bd5b5ebd0dc0a3035d8d9b262695cc34d83d0796
Message-ID: <62be8bba.vyeBR/MoveMjWbHm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git quic_neeraju.2022.06.30a
branch HEAD: bd5b5ebd0dc0a3035d8d9b262695cc34d83d0796  srcu: Reduce blocking agressiveness of expedited grace periods further

elapsed time: 722m

configs tested: 80
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
riscv                               defconfig
mips                           gcw0_defconfig
openrisc                            defconfig
sh                          urquell_defconfig
mips                      maltasmvp_defconfig
mips                        bcm47xx_defconfig
sh                          rsk7203_defconfig
sparc64                          alldefconfig
xtensa                  audio_kc705_defconfig
arc                              alldefconfig
arm                          pxa910_defconfig
arm                           stm32_defconfig
arm                         axm55xx_defconfig
mips                           ip32_defconfig
powerpc                     tqm8548_defconfig
m68k                       bvme6000_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-c001
arm                  randconfig-c002-20220629
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220629
riscv                randconfig-r042-20220629
s390                 randconfig-r044-20220629
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz

clang tested configs:
mips                        maltaup_defconfig
arm                       imx_v4_v5_defconfig
arm                         palmz72_defconfig
powerpc                          allmodconfig
arm                       netwinder_defconfig
powerpc                        fsp2_defconfig
mips                       lemote2f_defconfig
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r041-20220629
hexagon              randconfig-r045-20220629

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

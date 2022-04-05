Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC194F4149
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442081AbiDEUHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384414AbiDEM1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:27:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5261E344F1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 04:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649158928; x=1680694928;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=spOVTBjTD6IjOwr93EwblCXM/4VjxZnqhXMg90AhUTg=;
  b=UACx6q/bGUWbs0lD48QO7z80f3+az/c47GPWni/tnTO2lOu8i7sqCBjN
   umWUcnqsVz/fbQyzGGed3YSWbkkVT/TupyKInEUrSaeHCk7/TMm0M0PIk
   EgRuU+iOqeFBPtJHszPjYnzaX5D2lIoI2pCyJo2T5dTrhClFUN25dFIT7
   q9CJAA5m7WD3H+s/96aCqwMSt0qr5ht0tYiqXohEmV/WmL6D2+I50Im9E
   heyNVWF46ZbryvnpY+uGcAeiqGZPMJx2CNgPK2osuZ7Uu5817jVPxUtLN
   A/b66e9C65BpNbIpP6RZs9K92FlXusNoP+ABFS8b+GV2NLOLrKILRUCXL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="323901880"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="323901880"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 04:42:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="569847261"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 05 Apr 2022 04:42:06 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbhZW-00038d-2I;
        Tue, 05 Apr 2022 11:42:06 +0000
Date:   Tue, 05 Apr 2022 19:42:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 b77b2981bb22c4449a0a6e86eeb9fbab36a2beae
Message-ID: <624c2b0d.MPU0WPJjZVrlWPga%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: b77b2981bb22c4449a0a6e86eeb9fbab36a2beae  rcu-tasks: Handle sparse cpu_possible_mask

elapsed time: 929m

configs tested: 127
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                         s3c6400_defconfig
mips                         db1xxx_defconfig
openrisc                 simple_smp_defconfig
arm                         at91_dt_defconfig
sh                           se7751_defconfig
mips                        vocore2_defconfig
arm                         lpc18xx_defconfig
sh                           se7343_defconfig
sh                         ap325rxa_defconfig
arm                       imx_v6_v7_defconfig
arc                        vdk_hs38_defconfig
m68k                       m5475evb_defconfig
arc                           tb10x_defconfig
sh                          sdk7786_defconfig
powerpc                        cell_defconfig
powerpc                      chrp32_defconfig
csky                             alldefconfig
mips                    maltaup_xpa_defconfig
arm                           stm32_defconfig
powerpc                     pq2fads_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                          multi_defconfig
arm                             ezx_defconfig
xtensa                       common_defconfig
sh                        edosk7760_defconfig
powerpc                     stx_gp3_defconfig
powerpc                  iss476-smp_defconfig
sh                           se7750_defconfig
powerpc                      pcm030_defconfig
sh                  sh7785lcr_32bit_defconfig
xtensa                generic_kc705_defconfig
m68k                       m5249evb_defconfig
m68k                       m5275evb_defconfig
sh                     sh7710voipgw_defconfig
powerpc                      pasemi_defconfig
sh                             sh03_defconfig
ia64                          tiger_defconfig
arm                       multi_v4t_defconfig
mips                         cobalt_defconfig
powerpc                      arches_defconfig
i386                                defconfig
sh                            migor_defconfig
sh                 kfr2r09-romimage_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220405
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                             allyesconfig
parisc64                            defconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                               defconfig
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
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220405
riscv                randconfig-c006-20220405
mips                 randconfig-c004-20220405
arm                  randconfig-c002-20220405
arm                         lpc32xx_defconfig
powerpc                     ksi8560_defconfig
powerpc                   bluestone_defconfig
arm                  colibri_pxa300_defconfig
mips                     loongson1c_defconfig
arm                        neponset_defconfig
mips                         tb0219_defconfig
arm                       spear13xx_defconfig
arm                         socfpga_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220405
riscv                randconfig-r042-20220405
hexagon              randconfig-r041-20220405

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

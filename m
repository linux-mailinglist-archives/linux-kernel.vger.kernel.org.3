Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14185A95AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbiIAL0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbiIAL01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:26:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8360F134194
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662031585; x=1693567585;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=sC4QdX0r1MwQtaRfsRE9/BVMBzDWVXkdnI+yv3yJ7FE=;
  b=DTeSx8/nY9SPhDNdU8mrXqQLYBUAAZddpvSqSpUhB7nT4W5IUyXg1P5R
   jOczB1rkTDPArw8pOXTpzg7eZXAkaubHJDVRsHGkltmrtD0wnDMYxGIzO
   z+FLlFujScvmVdo1CS/GNmgHaliUa8m7yQM+ezcptJYZSLa+0R7iBqk43
   wDUfWVTj8774y3uQrvGpklYq3ZMEVGwSgtPFgT8WJApLDEx3Ix8vGkhXq
   HkmxcS2k+1ZzPMewjHytdrtdTYqu5w6FcUpXb8541FAk3y6k4IL9l47vW
   m7pbeAi5qDj5kFb+cP8NaUdVpFK+3Vt2BvF2WadaQKmK8DmnBdqRNiUjS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296473135"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="296473135"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 04:26:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="642292767"
Received: from lkp-server02.sh.intel.com (HELO b138c9e8658c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 01 Sep 2022 04:26:24 -0700
Received: from kbuild by b138c9e8658c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTiL1-0000Db-15;
        Thu, 01 Sep 2022 11:26:23 +0000
Date:   Thu, 01 Sep 2022 19:26:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 b8d1d163604bd1e600b062fb00de5dc42baa355f
Message-ID: <631096ca.OTqBiwtxd7k7vDDu%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
branch HEAD: b8d1d163604bd1e600b062fb00de5dc42baa355f  x86/apic: Don't disable x2APIC if locked

elapsed time: 821m

configs tested: 87
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
arc                              allyesconfig
um                             i386_defconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                              defconfig
sh                               allmodconfig
x86_64                               rhel-8.3
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a013
x86_64                           allyesconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arc                  randconfig-r043-20220831
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
riscv                randconfig-r042-20220831
s390                 randconfig-r044-20220831
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a002
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a004
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a006
x86_64                           rhel-8.3-kvm
i386                             allyesconfig
i386                                defconfig
sh                   sh7724_generic_defconfig
sparc                       sparc32_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                          rsk7203_defconfig
sh                               alldefconfig
arc                           tb10x_defconfig
arm                       multi_v4t_defconfig
parisc64                            defconfig
powerpc                      cm5200_defconfig
arm                            hisi_defconfig
powerpc                      pcm030_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     rainier_defconfig
arm                      jornada720_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
mips                         cobalt_defconfig
mips                           xway_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
xtensa                         virt_defconfig
powerpc                        warp_defconfig
arm                        multi_v7_defconfig
arm64                            alldefconfig
i386                          randconfig-c001
mips                      loongson3_defconfig
sh                          r7780mp_defconfig
sh                           se7705_defconfig
sh                          lboxre2_defconfig
ia64                             allmodconfig

clang tested configs:
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r041-20220831
hexagon              randconfig-r045-20220831
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a015
x86_64                        randconfig-a005
arm                         socfpga_defconfig
arm                        vexpress_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

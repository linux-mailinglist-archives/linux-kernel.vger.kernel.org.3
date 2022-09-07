Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388D75AF944
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 02:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiIGA6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 20:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiIGA57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 20:57:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C214797D6B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 17:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662512276; x=1694048276;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=o/MCaxqHGLZgzRxhERKBKEPSeCsgBelZjOxaZKLu3vs=;
  b=T0DU8id7TEmmjnvoOyI6g3y/OwFzCCQH/3HnjPqODRTAZ+L5RMvfHm5x
   zfC+b7twCYp+svriqcynbggPswAUpvd4Ji3ba0dsvn0OsaTK8NM/A42G2
   297Mkt8rF2lb+Dn1PsFQtjohCKs65PzL4VnXvlKYMDMjwt9uS7Z9jVMOo
   3A2DYNc9fSwNTqymBtPSTOvCZ9RX/0pZt3h1Stp+TKr3FMvUDgrrw0BdV
   8lut9cHhdtYQt+yMNiWup5lVEVlnSbmT7fr9nhXXPa6sWcNmA5RspTIpi
   iVTjEEZVqomNP7Eqt7bPx1zLyOrJONhGMJl1BRjHce7vNezEfkWV2dkm/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="322928535"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="322928535"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 17:57:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="756573422"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 06 Sep 2022 17:57:55 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVjO6-0005sW-2M;
        Wed, 07 Sep 2022 00:57:54 +0000
Date:   Wed, 07 Sep 2022 08:57:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 ee9db0e14b0575aa827579dc2471a29ec5fc6877
Message-ID: <6317ec7f.5c4DZvUQakcyAZ5o%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: ee9db0e14b0575aa827579dc2471a29ec5fc6877  perf: Use sample_flags for txn

elapsed time: 892m

configs tested: 105
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
alpha                            allyesconfig
arc                              allyesconfig
arc                  randconfig-r043-20220906
m68k                             allyesconfig
riscv                randconfig-r042-20220906
m68k                             allmodconfig
s390                 randconfig-r044-20220906
powerpc                          allmodconfig
x86_64                              defconfig
x86_64                        randconfig-a013
mips                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a011
x86_64                               rhel-8.3
powerpc                           allnoconfig
sh                               allmodconfig
x86_64                           allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a015
i386                          randconfig-a005
x86_64                        randconfig-a002
arm                                 defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                           rhel-8.3-syz
i386                          randconfig-a016
arm                              allyesconfig
arm64                            allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
nios2                         10m50_defconfig
arc                          axs103_defconfig
xtensa                          iss_defconfig
sh                          r7780mp_defconfig
sparc                       sparc64_defconfig
parisc64                            defconfig
powerpc                 canyonlands_defconfig
arm                           viper_defconfig
powerpc                    adder875_defconfig
sh                        dreamcast_defconfig
sh                   sh7770_generic_defconfig
sh                          lboxre2_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                mpc7448_hpc2_defconfig
alpha                               defconfig
arm                           sama5_defconfig
powerpc                     tqm8548_defconfig
sh                            titan_defconfig
sh                     sh7710voipgw_defconfig
i386                          randconfig-c001
csky                             alldefconfig
m68k                                defconfig
powerpc                     pq2fads_defconfig
arm                          iop32x_defconfig
mips                           ip32_defconfig
sh                           se7750_defconfig
sparc64                          alldefconfig
arm                             ezx_defconfig
sh                          rsk7264_defconfig
m68k                        mvme16x_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                    amigaone_defconfig
arm                        cerfcube_defconfig
sparc                            allyesconfig
sh                           se7705_defconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220906
hexagon              randconfig-r045-20220906
x86_64                        randconfig-a012
i386                          randconfig-a002
x86_64                        randconfig-a016
i386                          randconfig-a006
x86_64                        randconfig-a014
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
powerpc                     akebono_defconfig
powerpc                   lite5200b_defconfig
powerpc                     tqm5200_defconfig
powerpc                     mpc512x_defconfig
arm                           spitz_defconfig
arm                       spear13xx_defconfig
mips                      malta_kvm_defconfig
arm                    vt8500_v6_v7_defconfig
arm                     davinci_all_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

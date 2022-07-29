Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5A95849BA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbiG2C2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiG2C2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:28:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C85B4A826
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659061689; x=1690597689;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lHOc8eHYOvsAljPITfP+9+3/txLgdAdoJ5IcVmwCXYw=;
  b=RBG+rk2UxIiwmzfiIRNV+57QeiIjJUiVovgq7/frHFPK0cMap/QfoPHI
   NKOfW2yjXqMVngDW/nONyB84qluzSY1cASbraTS+ZjqVE36nhmB0vQz+P
   UQfl36J84K02qqKdUKsh17kgW/vXq1eE07idf3j4NmgW48/iuLAyQHWMp
   C5REbqXXpzeJhLQe9IsuKBrX3i2riWwl0N5LUKA+vx6aP88xoFrrjVY4d
   mCA8eDtULAFaEmDpa67XPUd07D3N2Op4yHKuXwB92405MpxcWRDggbci/
   RFs5hYtu80a3/5i9Fmi8Zao0UfglG0IP1T4KCJhr84cng2ClBT/ZpxseX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="269056116"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="269056116"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 19:28:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="660044235"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jul 2022 19:28:08 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHFjT-000AvW-1E;
        Fri, 29 Jul 2022 02:28:07 +0000
Date:   Fri, 29 Jul 2022 10:27:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 2eac2b956b6d26d510a20ac11626072d2e8c1447
Message-ID: <62e34585.7yktMQz8UjFiBVMS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git auto-latest
branch HEAD: 2eac2b956b6d26d510a20ac11626072d2e8c1447  Merge branch into tip/master: 'x86/vmware'

elapsed time: 2432m

configs tested: 95
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                             allyesconfig
i386                                defconfig
nios2                         3c120_defconfig
arm                           viper_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
sparc64                             defconfig
sh                            shmin_defconfig
arc                     haps_hs_smp_defconfig
powerpc                     asp8347_defconfig
powerpc                    amigaone_defconfig
arm                           tegra_defconfig
parisc                generic-64bit_defconfig
openrisc                         alldefconfig
i386                          randconfig-c001
loongarch                           defconfig
loongarch                         allnoconfig
sh                          landisk_defconfig
sh                           se7343_defconfig
m68k                                defconfig
sh                      rts7751r2d1_defconfig
loongarch                 loongson3_defconfig
sh                          urquell_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
arc                  randconfig-r043-20220728
s390                 randconfig-r044-20220728
riscv                randconfig-r042-20220728
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220727
hexagon              randconfig-r045-20220727
s390                 randconfig-r044-20220727
riscv                randconfig-r042-20220727
arm                         bcm2835_defconfig
powerpc                        icon_defconfig
powerpc               mpc834x_itxgp_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
powerpc                 mpc8315_rdb_defconfig
powerpc                 mpc832x_mds_defconfig
mips                           ip27_defconfig
arm                          ixp4xx_defconfig
x86_64                        randconfig-k001
powerpc                 mpc832x_rdb_defconfig
hexagon              randconfig-r045-20220728
hexagon              randconfig-r041-20220728

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

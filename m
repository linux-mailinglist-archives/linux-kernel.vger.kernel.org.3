Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593F55B1002
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 00:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIGWsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 18:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiIGWsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 18:48:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0221FADCC0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 15:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662590915; x=1694126915;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/4t7JI9DEpMpSRfunMHLpDJzNbOpCp4Sq1D0Us23rH8=;
  b=YYycCUcgE2YfkY7Dr6VnB/ExopTnALvQgKpt6l0bSqFe961yCJj+Megc
   OI0pQTqdVfpzHM2Oq9b3RRn+zPItLhTiLdPI/ujklDk2+eA/6/S8/JRNP
   QhnfV//UpCGBbCZGa90LYO63ljKdfc5dxq3KGV6WAlsq+Y2MFQJeM9wQE
   CZpRVGXAyLLU7yHWpL6sNravHP47sXMwX6iP1YYXOgs1kJl0HvLiGoVzr
   E0X0ZoD6j/HfHWUvGDAVxSYyb6OGIotvdY+0KA+jJfg/JLdLjhEuQ7fVP
   Xl1l7YKYMK3NEHl7xCXU/SyN+AvoEXhK3jEXwcDHslMiRbjRz4M0f7dLT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="297015738"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="297015738"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 15:48:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="644816540"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 07 Sep 2022 15:48:34 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oW3qT-00072D-1n;
        Wed, 07 Sep 2022 22:48:33 +0000
Date:   Thu, 08 Sep 2022 06:48:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 b8b09110cf290fdab4006b717da7a776ffb0cb73
Message-ID: <63191fa3.yF1uIRzVqBIDfTda%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git master
branch HEAD: b8b09110cf290fdab4006b717da7a776ffb0cb73  Merge branch into tip/master: 'x86/timers'

elapsed time: 909m

configs tested: 99
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220906
i386                                defconfig
riscv                randconfig-r042-20220906
s390                 randconfig-r044-20220906
x86_64                              defconfig
i386                             allyesconfig
arm                                 defconfig
arc                              allyesconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arm64                            allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
x86_64                        randconfig-a013
arm                              allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a015
m68k                             allmodconfig
sh                               allmodconfig
x86_64                        randconfig-a004
m68k                             allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a001
i386                          randconfig-a016
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                             alldefconfig
powerpc                     ep8248e_defconfig
m68k                          hp300_defconfig
m68k                        m5272c3_defconfig
arm                          exynos_defconfig
sparc                            alldefconfig
sparc                             allnoconfig
arm                        cerfcube_defconfig
powerpc                      arches_defconfig
openrisc                 simple_smp_defconfig
powerpc                     asp8347_defconfig
arm                          pxa3xx_defconfig
arm                         s3c6400_defconfig
powerpc                     stx_gp3_defconfig
arm64                            alldefconfig
sh                           se7722_defconfig
i386                          randconfig-c001
sh                             sh03_defconfig
sh                           se7750_defconfig
s390                             allmodconfig
xtensa                       common_defconfig
sh                          r7785rp_defconfig
arm                          iop32x_defconfig
powerpc                     mpc83xx_defconfig
xtensa                generic_kc705_defconfig
csky                                defconfig
sparc                               defconfig
um                                  defconfig
sh                            titan_defconfig
arm                            mps2_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
sh                          r7780mp_defconfig
arm                            qcom_defconfig
ia64                          tiger_defconfig
arc                              alldefconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220906
hexagon              randconfig-r045-20220906
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a015
i386                          randconfig-a006
powerpc                     tqm8540_defconfig
arm                           spitz_defconfig
riscv                randconfig-r042-20220907
hexagon              randconfig-r041-20220907
hexagon              randconfig-r045-20220907
s390                 randconfig-r044-20220907

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

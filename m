Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FA85858F0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 09:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiG3HOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 03:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiG3HN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 03:13:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9576D1057D
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 00:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659165237; x=1690701237;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=EUcDr2U0BMUm7C5B9bqi6NrwfnD71UZUPavUgVdMPH4=;
  b=jptzJTZgZlLaBb+w1lLvrhpu12aP19wZeHWv3cmGaP0W1GEOQiltT7b/
   IYXIkihT6kkfDGL1+KRXjocAVxPGk4OYIpF1eR9+jkelWD5SZNDaY/G76
   wDgPvdjRwOrFS7QswsHPeOsANBkBdJRpnzXmR14C9rcsfGSl3acZSx5J5
   rH+da2yYw3jJtFkdMkUsy1eESgLqBzi+aVUPJARizWEDG2YmGniVNDA9a
   SkRlEONCCQwM3LaMQml19Y01wwyh3uIx3cuyeShcS6pC3f68uLZwUqnJO
   S/S8ax2D4BSx0WWob8ZXkdxaC2+fXkk+pZmAHol+hkmf+h6TVtxXABJW3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="287654779"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="287654779"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 00:13:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="690952231"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jul 2022 00:13:55 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHgfa-000CaJ-2D;
        Sat, 30 Jul 2022 07:13:54 +0000
Date:   Sat, 30 Jul 2022 15:13:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 7f8508a70951dda747c40759d863847a70e08272
Message-ID: <62e4da23.nSgNLFJ5vHXGFOar%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 7f8508a70951dda747c40759d863847a70e08272  Merge x86/urgent into tip/master

elapsed time: 710m

configs tested: 75
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
i386                             allyesconfig
arc                  randconfig-r043-20220729
x86_64                              defconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
powerpc                          allmodconfig
arc                              allyesconfig
mips                             allyesconfig
alpha                            allyesconfig
x86_64                           allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a013
x86_64                        randconfig-a011
sh                               allmodconfig
x86_64                        randconfig-a015
i386                          randconfig-a014
x86_64                        randconfig-a004
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a006
arm                                 defconfig
ia64                             allmodconfig
arm                              allyesconfig
powerpc                      bamboo_defconfig
m68k                          hp300_defconfig
sh                              ul2_defconfig
nios2                               defconfig
sh                         ecovec24_defconfig
arm64                            allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm                         lpc18xx_defconfig
powerpc                 mpc8540_ads_defconfig
xtensa                    xip_kc705_defconfig
i386                          randconfig-c001
powerpc                      pcm030_defconfig
m68k                                defconfig
mips                         tb0226_defconfig
sh                     sh7710voipgw_defconfig
loongarch                           defconfig
loongarch                         allnoconfig

clang tested configs:
hexagon              randconfig-r041-20220729
riscv                randconfig-r042-20220729
hexagon              randconfig-r045-20220729
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
x86_64                        randconfig-a005
i386                          randconfig-a002
x86_64                        randconfig-a001
i386                          randconfig-a006
x86_64                        randconfig-a003
i386                          randconfig-a004
s390                 randconfig-r044-20220729
x86_64                        randconfig-k001
mips                     loongson1c_defconfig
arm                         palmz72_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

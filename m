Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4045B5AD9BA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 21:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiIETg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 15:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiIETgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 15:36:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EC9501B4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 12:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662406613; x=1693942613;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=J9Sntj6lpirkv8YfEPsIBobwbrrf+kJSBmd/Heg9YCk=;
  b=jCrBbfsewnLS5meeiMJb4+o0hfb69JGW2C9F31oVsjJfjCZA1I3s/fnL
   tlemrIbCkDzkLSk84VpmpZciV7Oi3b/AR+12OPz1OmGAVR0IPheWMFrMU
   ByHDikFMQZXvzlMU3h5pOWTukR4sBlfDifsI66jDodSFASu72lQ/tKw9n
   yATt9cmQAjPf/kQldKbLmLlXL44GmOfeficl+LCjQHl7y2ZAoamlbA+YD
   r6bZnAthBPn37uEv9edlUkZ689pkAN2ByBZb7jmG70Rz497mxhqcQVuOJ
   WMdyLh6Zp2IhcCp9fuCZjyqmTns81gTAsgSx0o5tFOcSS3fUIupSqd7NO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="283440007"
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="283440007"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 12:36:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="682152139"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 05 Sep 2022 12:36:51 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVHtq-0004UA-2W;
        Mon, 05 Sep 2022 19:36:50 +0000
Date:   Tue, 06 Sep 2022 03:36:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 4ad861bb89e01fc6166afcc53bff767913b4d285
Message-ID: <63164faf.5W+0tBRkzX3TTSKq%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 4ad861bb89e01fc6166afcc53bff767913b4d285  Merge branch into tip/master: 'x86/timers'

elapsed time: 724m

configs tested: 57
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220905
i386                 randconfig-a001-20220905
m68k                             allmodconfig
i386                 randconfig-a002-20220905
arc                              allyesconfig
x86_64                              defconfig
powerpc                          allmodconfig
alpha                            allyesconfig
i386                 randconfig-a005-20220905
i386                 randconfig-a003-20220905
i386                             allyesconfig
i386                 randconfig-a006-20220905
mips                             allyesconfig
i386                 randconfig-a004-20220905
powerpc                           allnoconfig
m68k                             allyesconfig
sh                               allmodconfig
sparc                               defconfig
sh                               j2_defconfig
sh                             espt_defconfig
sh                 kfr2r09-romimage_defconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                           allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64               randconfig-a001-20220905
x86_64               randconfig-a006-20220905
x86_64               randconfig-a004-20220905
x86_64               randconfig-a003-20220905
x86_64               randconfig-a002-20220905
x86_64               randconfig-a005-20220905
i386                 randconfig-c001-20220905
loongarch                           defconfig
loongarch                         allnoconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220905
hexagon              randconfig-r041-20220905
s390                 randconfig-r044-20220905
riscv                randconfig-r042-20220905
i386                 randconfig-a016-20220905
i386                 randconfig-a012-20220905
i386                 randconfig-a015-20220905
i386                 randconfig-a011-20220905
i386                 randconfig-a013-20220905
i386                 randconfig-a014-20220905
x86_64               randconfig-a012-20220905
x86_64               randconfig-a014-20220905
x86_64               randconfig-a013-20220905

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

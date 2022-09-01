Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4CC5A9451
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbiIAKX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbiIAKXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:23:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A031360A4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662027802; x=1693563802;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jh6f2qse35WzAgNQ5WBVrMVUwxK7H1xPD4xrnVBxlDA=;
  b=GBP4xnm6WlIzsOudwphz2o2jQfUIABuE40nB0jariyDBCu+PxGz6STpG
   1UlLLHhCfn5dCt8qxXpjKP6s5G2npAfRCvRO0OidNsYF6OVoQAzt0Te+x
   X83Lp+JAnM1vBkJv6doMnMiKmWl1TvEr5soghIrMdG9YeydipZHrUyQaG
   +AF8u4QE1GGkjxOYo3aetjhXouLtBvL30f0x+soyk3O7GPHYbm263NQOY
   7a437IhtqeDAftdNfj9MqON2diOcR+Dc7p5AwtiZtbjsljK92cEj/B10A
   VxYcHktZReUao0Rqtu0MfJYHRu9wzfuuzR7Z1ZV7s0ie2b6uocw4/ctZ6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="357396137"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="357396137"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 03:23:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="563405026"
Received: from lkp-server02.sh.intel.com (HELO b138c9e8658c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 01 Sep 2022 03:23:20 -0700
Received: from kbuild by b138c9e8658c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oThLz-0000AR-2U;
        Thu, 01 Sep 2022 10:23:19 +0000
Date:   Thu, 01 Sep 2022 18:22:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 7987448ffc34f41590bae5b28cd23ca0b8c93291
Message-ID: <631087e8.AQN9QJzOy6wUjqAQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: 7987448ffc34f41590bae5b28cd23ca0b8c93291  x86/Kconfig: Specify idle=poll instead of no-hlt

elapsed time: 728m

configs tested: 81
configs skipped: 78

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                                defconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a015
x86_64                           rhel-8.3-syz
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
s390                 randconfig-r044-20220831
riscv                randconfig-r042-20220831
arc                           tb10x_defconfig
arm                       multi_v4t_defconfig
parisc64                            defconfig
powerpc                      cm5200_defconfig
sh                   sh7724_generic_defconfig
sparc                       sparc32_defconfig
sh                          rsk7203_defconfig
sh                               alldefconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc                      pcm030_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     rainier_defconfig
arm                      jornada720_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
mips                         cobalt_defconfig
mips                           xway_defconfig
xtensa                         virt_defconfig
powerpc                        warp_defconfig
arm                        multi_v7_defconfig
arm64                            alldefconfig
i386                          randconfig-c001
mips                      loongson3_defconfig
sh                          r7780mp_defconfig
sh                           se7705_defconfig
sh                          lboxre2_defconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a014
i386                          randconfig-a015
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r045-20220831
hexagon              randconfig-r041-20220831
arm                         socfpga_defconfig
arm                        vexpress_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

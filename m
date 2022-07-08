Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2077A56B3EB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbiGHH6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237275AbiGHH6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:58:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7FC12AE8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 00:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657267116; x=1688803116;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rqKkPt3MPpjqyc4mN+BxX7fkKVYruefqKX/Mr0FjC8I=;
  b=gJZzruConck0jV7YPFTL0TE3j5DE/ZfIJOytrnFrqoEapIfjpfqPagpM
   DBht2fqezBZqLpdFiLBwidDUB3dhVS5UcDjrqcCHAxJCqr3y1lCfhOikz
   leFd1K46+p1VjikcM4eTiXbWCxERmGNFKLiFepNX3h+eMibTiDFvzA/8J
   8RLqva46FvL8sycud24GhuKiG4x+aMQdNoyOkf+xcBFqfaF2/3/w37p7O
   F+3hFQBrmheCrFUEErdTJLc2CfVA8zir5ze4ij3tl4GSakq3KOOqELufl
   +tY/J9unNqs+C+wt7qAMhChCEWvHRJIexH8Q9mvgCygCXYYQOk5t2gazY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="370537183"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="370537183"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 00:58:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="626626632"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Jul 2022 00:58:35 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9isk-000N9Q-FO;
        Fri, 08 Jul 2022 07:58:34 +0000
Date:   Fri, 08 Jul 2022 15:57:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 6507cce561b43b071999502103804e3dc1478e60
Message-ID: <62c7e387.cS6w8gT1tWMFnIy+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
branch HEAD: 6507cce561b43b071999502103804e3dc1478e60  selftests/sgx: Page removal stress test

elapsed time: 815m

configs tested: 52
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220707
riscv                randconfig-r042-20220707
s390                 randconfig-r044-20220707
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220707
hexagon              randconfig-r041-20220707

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

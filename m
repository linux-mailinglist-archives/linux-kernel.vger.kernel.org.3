Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD7358497C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 03:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbiG2BzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 21:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiG2BzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 21:55:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E6C1ADBC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 18:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659059713; x=1690595713;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=H+JbAZdaIRIMUMWdYG0n3GQdEpnZnj9yh2OVyXtClOM=;
  b=QSDqYT8J5ly9VJ5HiyweRK+hVbIzn1TbvIoj+exPw5AoY4bp2SRHcIKt
   Hiv72jNtxl6HjtFvR/BOwgHUPSsqo0FM0AAXkTeTjAL4EJPzf9iy0PdWP
   1U0L2EJo8saSs25FbpO+m0kpmiKXy7rDKeAXNUmq+olQaYhkR8G/0uOA/
   J2b6NohZ8NMHPnmxz1TtZnjJc8PuW1anherhWOvp16VY6TtTkWV8q0P7b
   19qK67EORssZJ1NivMcQNGF1xqMsglKlo2z17KQc/bKYIb7SuYLFUHxY9
   3KuygZUNr2RDUVrKPdQkvNTBAd2Nk2AQlR4oI+9BCJ1ySrDhyDdwSHj/G
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="350372416"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="350372416"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 18:55:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="576756304"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Jul 2022 18:55:04 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHFDU-000Arw-08;
        Fri, 29 Jul 2022 01:55:04 +0000
Date:   Fri, 29 Jul 2022 09:54:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 779fda86bdeb86bad6daa4f0ecf37788dfc26f6c
Message-ID: <62e33de3.CNGfVkwZnWEzumeB%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 779fda86bdeb86bad6daa4f0ecf37788dfc26f6c  Merge tag 'irqchip-5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

elapsed time: 901m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
i386                          randconfig-a014
x86_64                        randconfig-a015
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20220728
x86_64                        randconfig-a002
i386                          randconfig-a005
riscv                randconfig-r042-20220728
i386                             allyesconfig
x86_64                           rhel-8.3-syz
s390                 randconfig-r044-20220728
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a006
mips                             allyesconfig
powerpc                           allnoconfig
arm                                 defconfig
sh                               allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig

clang tested configs:
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a014
i386                          randconfig-a015
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220728
i386                          randconfig-a002
hexagon              randconfig-r041-20220728
i386                          randconfig-a006
x86_64                        randconfig-a001
i386                          randconfig-a004
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

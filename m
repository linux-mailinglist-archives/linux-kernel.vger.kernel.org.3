Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F9555AC4B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 22:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbiFYUCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 16:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbiFYUCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 16:02:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DD6140A6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 13:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656187350; x=1687723350;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kjDSb+MHDS7UHHDHrCopoQzl0kLxOnHTS/Sxp5Ajj/U=;
  b=mcp81u4cenH6rf6ZbzXv0y0jGcjQ+gfFW2AoR1iiL68RataVx/5ZJfW0
   pCq5zU3u1qEp7TwBu2aynqRVWC+ODtv9qaIYGZD+PcRTXzvZXn+p2b/Rb
   piiF1h7So0qt4siUZYV5OIvD815nLqX9+rjEjBLoD/tirfv2xHF8cUS5j
   FI9SvytGKfGudaOBeGeDmd4NsQYB0fAnyKbKz6xNAc837+Q+m8bi8vUbv
   4Y6/YP4a3kKPz2wYI00sr98VIAyoQi2q/tcM7nFwdGv/WB2sX8FsELh/b
   Pzjb+2aCufHSiGDofFuaR6/8xyt4QOR3r7yqNqApl1F3RwSSJcPV/E44v
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10389"; a="269957030"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="269957030"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 13:02:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="539641505"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Jun 2022 13:02:28 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5BzA-0006FH-2j;
        Sat, 25 Jun 2022 20:02:28 +0000
Date:   Sun, 26 Jun 2022 04:02:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 7089155b2877a54e33d4ab21eb68c28568aea2fe
Message-ID: <62b769bb.n1i4MA3w6xyjr0to%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 7089155b2877a54e33d4ab21eb68c28568aea2fe  Merge branch into tip/master: 'x86/vmware'

elapsed time: 724m

configs tested: 52
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
riscv                randconfig-r042-20220625
s390                 randconfig-r044-20220625
arc                  randconfig-r043-20220625
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r041-20220625
hexagon              randconfig-r045-20220625

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

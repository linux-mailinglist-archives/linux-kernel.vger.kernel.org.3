Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AC6563DCF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 04:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiGBCqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 22:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGBCqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 22:46:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4E72E0A5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 19:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656729991; x=1688265991;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xh3MYoe0DUgCe1Ha1ycnxwaavJAuwXESvQH5Ry7iWI0=;
  b=n/UdnVXqn6InS8rgMmu9bf7NYTJPSJCwaJJbuUGHHtQvaDlr632k7AB8
   P9bTntKZAiFLcEzUSPrKrdESA1J+POM3HT1SNSJnjQGLfFWX9qu98F+6z
   Q3a8nYKeSlC9bIpSnJ9bOkoVJWnUHnREWehIzQmZEmTVaGYrzeg2lnD7O
   suTvXDIVMg2VXcdVi9FDqX5pa4iPJfj8U7WfozySTwjBXK9ipCuHpDjGo
   LKQLbuS5Rv0bgQRZE5EUgy3Xszon9X63FA8eIf2kl5qV3BM3GLhkUtNS1
   eXiq9MornJ99blMy0nGkVGPnjAR6mos7EIWuChDUHlJgGnWV+G14metqn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="369104664"
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="369104664"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 19:46:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="541923543"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Jul 2022 19:46:29 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7T9Q-000Ehe-Pg;
        Sat, 02 Jul 2022 02:46:28 +0000
Date:   Sat, 02 Jul 2022 10:46:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/kdump] BUILD SUCCESS
 b69a2afd5afce9bf6d56e349d6ab592c916e20f2
Message-ID: <62bfb175.5j+wO3citfXnsg70%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/kdump
branch HEAD: b69a2afd5afce9bf6d56e349d6ab592c916e20f2  x86/kexec: Carry forward IMA measurement log on kexec

elapsed time: 723m

configs tested: 52
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220629
s390                 randconfig-r044-20220629
riscv                randconfig-r042-20220629
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220629
hexagon              randconfig-r041-20220629

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97291578F35
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbiGSAYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiGSAY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:24:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E6CE15
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658190268; x=1689726268;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HC5Y5n+o0N1GDG9lfdnVAazFEF8Tun0jXYTQJnoSuZw=;
  b=DFnAmUQzKhT8wrI4IPO5K2kOmHBR+gQnoreeavCzvzr2OceBsO1rLqcM
   XDxo4lPx5YUbERyj/Ub1I8WqCg+Cz4NflDWXZvo/kEJm43iheXWylCWbK
   /VQTBiPI0C18EGjKBKupLJyy7njq6BfmoOWZG6c3l0sL+W/Oba55AgMUV
   7Wd1KUTVpT+Sm5IlSK12kwKkqdFMaVCoedqjWnJ1Li7IZnENgijjeqCUE
   jUZzPnB3t9uymmAyQKWvxmAR4qlgJmbCtMKgo7n4TLoUG9OJ3gUV5ifiT
   m6Ba0r8aWcfCz9OPt6EHQuZwg90e/WOQzn8XKRkiIuripCjk+LXoX2srL
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="285106978"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="285106978"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 17:24:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="665209742"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jul 2022 17:24:26 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDb2I-00051l-3m;
        Tue, 19 Jul 2022 00:24:26 +0000
Date:   Tue, 19 Jul 2022 08:24:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 1cf86c1c72384ec9e2f906dc0a428ea9314444d5
Message-ID: <62d5f9b2.gCKLim+kLPUt3rjV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 1cf86c1c72384ec9e2f906dc0a428ea9314444d5  Merge sched/core into tip/master

elapsed time: 729m

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
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64               randconfig-a013-20220718
x86_64               randconfig-a012-20220718
x86_64               randconfig-a015-20220718
x86_64               randconfig-a014-20220718
x86_64               randconfig-a016-20220718
x86_64               randconfig-a011-20220718
i386                 randconfig-a011-20220718
i386                 randconfig-a013-20220718
i386                 randconfig-a016-20220718
i386                 randconfig-a012-20220718
i386                 randconfig-a015-20220718
i386                 randconfig-a014-20220718
arc                  randconfig-r043-20220718
riscv                randconfig-r042-20220718
s390                 randconfig-r044-20220718
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
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                 randconfig-a004-20220718
i386                 randconfig-a003-20220718
i386                 randconfig-a005-20220718
i386                 randconfig-a001-20220718
i386                 randconfig-a002-20220718
i386                 randconfig-a006-20220718
hexagon              randconfig-r041-20220718
hexagon              randconfig-r045-20220718

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A56458889F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 10:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbiHCISC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 04:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbiHCIR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 04:17:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A597960D0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 01:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659514678; x=1691050678;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=EaVg96O0YM9hi6X5WO+yC871BCEp8S+50Soi1s7DljQ=;
  b=WLZ2mtN2Sqc/8MVCKJ/LsWZDnqXSv6CG2a6Cx8sibE4zR5plfN1Dma27
   QCt1zPShJCR+znQUzDsEx6Vt4NSCgCMAdDp+bz33/+L6dRfvo4xROFfII
   zES4R4l+oshbjRu8IBcP9HKrB1jvAXREdQNj/xmwjisiabEH9AZoTXYGy
   KokHp3+l3u+6mlEvAAkEt1+xum83SS+YtYPdYP6DEh0g+4KYzU0PJyQI0
   h8JZFlI2HET2mAMmCorpG5zcTwV+O+bzEb5eWj0tCRIUjTIqFgGz43fDU
   BVVSPbo6xi+eorN4snvkhgYNnGDBjkRJkb+P/W03pel5lfvET+cVOC4FG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="315473829"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="315473829"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 01:17:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="553236914"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 03 Aug 2022 01:17:57 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ9Zk-000H2T-1q;
        Wed, 03 Aug 2022 08:17:56 +0000
Date:   Wed, 03 Aug 2022 16:17:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 a41a2e2e34a907bd8979a53c58f44287630616e8
Message-ID: <62ea2f2f.UAhAmZtQ7vyNLiPC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: a41a2e2e34a907bd8979a53c58f44287630616e8  scripts/faddr2line: Add CONFIG_DEBUG_INFO check

elapsed time: 720m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
arm                                 defconfig
i386                                defconfig
powerpc                           allnoconfig
x86_64                           allyesconfig
mips                             allyesconfig
ia64                             allmodconfig
powerpc                          allmodconfig
s390                 randconfig-r044-20220801
riscv                randconfig-r042-20220801
arm64                            allyesconfig
arc                  randconfig-r043-20220801
x86_64               randconfig-a011-20220801
i386                             allyesconfig
arm                              allyesconfig
sh                               allmodconfig
x86_64               randconfig-a012-20220801
x86_64               randconfig-a013-20220801
x86_64               randconfig-a014-20220801
x86_64               randconfig-a015-20220801
m68k                             allmodconfig
i386                 randconfig-a012-20220801
alpha                            allyesconfig
i386                 randconfig-a013-20220801
arc                              allyesconfig
x86_64               randconfig-a016-20220801
i386                 randconfig-a014-20220801
x86_64                          rhel-8.3-func
i386                 randconfig-a011-20220801
x86_64                         rhel-8.3-kunit
i386                 randconfig-a016-20220801
i386                 randconfig-a015-20220801
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
m68k                             allyesconfig

clang tested configs:
x86_64               randconfig-a002-20220801
x86_64               randconfig-a001-20220801
x86_64               randconfig-a003-20220801
x86_64               randconfig-a004-20220801
x86_64               randconfig-a005-20220801
i386                 randconfig-a001-20220801
x86_64               randconfig-a006-20220801
i386                 randconfig-a002-20220801
hexagon              randconfig-r045-20220801
i386                 randconfig-a003-20220801
i386                 randconfig-a005-20220801
hexagon              randconfig-r041-20220801
i386                 randconfig-a004-20220801
i386                 randconfig-a006-20220801

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

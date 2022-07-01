Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4980E562786
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 02:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiGAADl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 20:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGAADi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 20:03:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF5713E06
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 17:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656633814; x=1688169814;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5Ice+PluGRM3uVyKmxbu57oQYul5exZwX1qYrpuQ+0U=;
  b=f5++y5Rz0svRs1AjtlZLPYInD4qrAdQ904qsFWsG5IYtjESi2dNQj3IV
   +pgre4dQR5FczpenHB93cQh1EN9RECIOlsYRrlw0mrSnrCL7/TFwu4dra
   v5z9JdE/gn6gXeKcaWNTCY5C/flYLJ13fNzk3Dhzb/SQbEnoKG5aIFod7
   bq+PzLZMqh53F5tZT6urN2OAQMVQUskqQ03/maYIe7/cem56gdOxk14M0
   NiPD4EWzktNjC+CNt+syII2ZK0dOkXpsJox6A/JMX7oAxt0sNrlMX55OR
   Xi0tmtZ+OIHN1Zw/5MK+raYNFVJmlmykw9C8ZHDNg3mPCCIq488K62PoH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="262302933"
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="262302933"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 17:03:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="659220205"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jun 2022 17:03:17 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o747w-000DL4-G9;
        Fri, 01 Jul 2022 00:03:16 +0000
Date:   Fri, 01 Jul 2022 08:02:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 f4fadf62be8da2e6d2d23519f21e17d0ff773113
Message-ID: <62be399c.lZkeU6cM1ok/uXbv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: f4fadf62be8da2e6d2d23519f21e17d0ff773113  Merge branch into tip/master: 'x86/vmware'

elapsed time: 854m

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
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
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
riscv                randconfig-r042-20220629
s390                 randconfig-r044-20220629
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220629
hexagon              randconfig-r041-20220629
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDCC4AA560
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 02:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378914AbiBEBsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 20:48:08 -0500
Received: from mga17.intel.com ([192.55.52.151]:11016 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378908AbiBEBsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 20:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644025687; x=1675561687;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0p14woOfoN7obeU2ZuHQMgMqsoUyFX4qECH8/iS9sGM=;
  b=LUyDORRarT1lDPENAtYlMbd3mMEmFdk9zMI8QLUN9fuqpabeAwzP+zL1
   Xn+/lLMcR/IJHN8hyufxzJBCHQgRxBtO8Cyj/V2jKHJXbbXroyrUEHYKf
   /D8EEzJl0vz1GZCA1sBtvmby/T0hTV+feJ2aVFWn0MeM5TbvVX/Sx9Rxs
   0hQIjBKvLROnpTcI+MNCFhreSoO7IGHLFEumSN3oWSeA5xgzOc+srEhEA
   KnEvxuWSl2wVIv05oDcI0pSPLHFX83rkq1KykbsAulQtl+/xFYm73Hfs4
   qJaNNCQjJS5oiN5S4+mWM4WGgJLQybrhdZCZFq23zAlf0mSMtC+BGvuGh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="229124507"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="229124507"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 17:48:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="699863390"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 04 Feb 2022 17:48:05 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGABI-000YRc-Qd; Sat, 05 Feb 2022 01:48:04 +0000
Date:   Sat, 5 Feb 2022 09:47:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 156/167]
 arch/x86/kvm/mmu/tdp_mmu.c:1205:17: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202202050947.502aKrF4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   ae19e4b18af5a4b4b7d7b3d9c86614006d0a0216
commit: 0e712f59902e53822c6d9fb3bf0903917ddd1594 [156/167] [REVERTME] KVM, x86/mmu: add WARN_ON for debug
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220205/202202050947.502aKrF4-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel/tdx/commit/0e712f59902e53822c6d9fb3bf0903917ddd1594
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 0e712f59902e53822c6d9fb3bf0903917ddd1594
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/x86/kvm/mmu/tdp_mmu.c:561:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu * @@
   arch/x86/kvm/mmu/tdp_mmu.c:561:17: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:561:17: sparse:     got unsigned long long [noderef] [usertype] __rcu *
   arch/x86/kvm/mmu/tdp_mmu.c:1051:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:1051:41: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1051:41: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
>> arch/x86/kvm/mmu/tdp_mmu.c:1205:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:1205:17: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1205:17: sparse:     got unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1344:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:1344:33: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1344:33: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1395:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:1395:13: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1395:13: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:332:9: sparse: sparse: context imbalance in 'tdp_mmu_unlink_page' - different lock contexts for basic block
   arch/x86/kvm/mmu/tdp_mmu.c:686:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:686:9: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:686:9: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:701:80: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:701:80: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:701:80: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:708:67: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:708:67: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:708:67: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:594:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:594:48: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:594:48: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:599:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:599:9: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:599:9: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:618:80: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:618:80: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:618:80: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:594:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:594:48: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:594:48: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:599:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:599:9: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:599:9: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:618:80: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:618:80: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:618:80: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:594:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:594:48: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:594:48: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:599:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:599:9: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:599:9: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:618:80: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:618:80: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:618:80: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:594:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:594:48: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:594:48: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:599:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:599:9: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:599:9: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:618:80: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:618:80: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:618:80: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:686:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:686:9: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:686:9: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:701:80: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:701:80: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:701:80: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:708:67: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:708:67: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:708:67: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:686:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:686:9: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:686:9: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:701:80: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:701:80: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:701:80: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:708:67: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:708:67: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:708:67: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:686:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:686:9: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:686:9: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:701:80: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:701:80: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:701:80: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:708:67: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:708:67: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:708:67: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:594:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:594:48: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:594:48: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:599:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:599:9: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:599:9: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:618:80: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:618:80: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:618:80: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:594:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:594:48: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:594:48: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:599:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:599:9: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:599:9: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:618:80: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:618:80: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:618:80: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:686:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@

vim +1205 arch/x86/kvm/mmu/tdp_mmu.c

  1165	
  1166	/*
  1167	 * Handle a TDP page fault (NPT/EPT violation/misconfiguration) by installing
  1168	 * page tables and SPTEs to translate the faulting guest physical address.
  1169	 */
  1170	int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
  1171	{
  1172		struct kvm_mmu *mmu = vcpu->arch.mmu;
  1173		struct tdp_iter iter;
  1174		gfn_t raw_gfn;
  1175		bool is_private;
  1176		int ret;
  1177	
  1178		kvm_mmu_hugepage_adjust(vcpu, fault);
  1179	
  1180		trace_kvm_mmu_spte_requested(fault);
  1181	
  1182		rcu_read_lock();
  1183	
  1184		raw_gfn = fault->addr >> PAGE_SHIFT;
  1185		is_private = kvm_is_private_gfn(vcpu->kvm, raw_gfn);
  1186	
  1187		if (is_error_noslot_pfn(fault->pfn) || kvm_is_reserved_pfn(fault->pfn)) {
  1188			if (is_private) {
  1189				rcu_read_unlock();
  1190				return -EFAULT;
  1191			}
  1192		} else if (kvm_gfn_stolen_mask(vcpu->kvm)) {
  1193			if (!is_private) {
  1194				/*
  1195				 * If raw_gfn is shared gfn, check if shared mapping
  1196				 * is allowed.  Private mapping case is checked by
  1197				 * tdp_mmu_map_handle_target_level().
  1198				 */
  1199				if (!tdp_mmu_private_prohibit(vcpu, raw_gfn))
  1200					return RET_PF_RETRY;
  1201			}
  1202		}
  1203	
  1204		tdp_mmu_for_each_pte(iter, mmu, is_private, raw_gfn, raw_gfn + 1) {
> 1205			WARN_ON(is_private_spte(iter.sptep) != is_private);
  1206	
  1207			if (fault->nx_huge_page_workaround_enabled)
  1208				disallowed_hugepage_adjust(fault, iter.old_spte, iter.level);
  1209	
  1210			if (iter.level == fault->goal_level)
  1211				break;
  1212	
  1213			/*
  1214			 * If there is an SPTE mapping a large page at a higher level
  1215			 * than the target, that SPTE must be cleared and replaced
  1216			 * with a non-leaf SPTE.
  1217			 */
  1218			if (is_shadow_present_pte(iter.old_spte) &&
  1219			    is_large_pte(iter.old_spte)) {
  1220				if (!tdp_mmu_zap_spte_atomic(vcpu->kvm, &iter))
  1221					break;
  1222				/*
  1223				 * TODO: large page support.
  1224				 * Doesn't support large page for TDX now
  1225				 */
  1226				WARN_ON(is_private_spte(&iter.old_spte));
  1227	
  1228	
  1229				/*
  1230				 * The iter must explicitly re-read the spte here
  1231				 * because the new value informs the !present
  1232				 * path below.
  1233				 */
  1234				iter.old_spte = READ_ONCE(*rcu_dereference(iter.sptep));
  1235			}
  1236	
  1237			if (!is_shadow_present_pte(iter.old_spte)) {
  1238				bool account_nx;
  1239	
  1240				/*
  1241				 * If SPTE has been frozen by another thread, just
  1242				 * give up and retry, avoiding unnecessary page table
  1243				 * allocation and free.
  1244				 */
  1245				if (is_removed_spte(iter.old_spte))
  1246					break;
  1247	
  1248				account_nx = fault->huge_page_disallowed &&
  1249					fault->req_level >= iter.level;
  1250				if (!tdp_mmu_populate_nonleaf(
  1251						vcpu, &iter, is_private, account_nx))
  1252					break;
  1253			}
  1254		}
  1255	
  1256		if (iter.level != fault->goal_level) {
  1257			rcu_read_unlock();
  1258			return RET_PF_RETRY;
  1259		}
  1260	
  1261		ret = tdp_mmu_map_handle_target_level(vcpu, fault, &iter);
  1262		rcu_read_unlock();
  1263	
  1264		return ret;
  1265	}
  1266	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCB0576ACC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 01:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiGOXh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 19:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGOXhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 19:37:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EA813E19
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657928272; x=1689464272;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gpoaudhISyiHtnW+TKOddqLfjUeMa8t0GUHO0GaMdcs=;
  b=NJlryBFyKgF5njxQzj1TCwXQ3hMlAT/ESSnI4A1ELhR8QOu6kqhxKui6
   mFXNmKsBKhs3MYPVin3kS5NlX38DVXSTLzIbWMD+3Wo2KBU3wGL8XPFAX
   Ri434NOoABNRzC2SsJuMbgY0owrQJHdVwNb+tHgwDB5zAioD/SrM+juOO
   pSpLVCPW/GdXLjK5YGsdaeQdtlV18Iip9mZAlk3fsJKvcT93ICaHML6E1
   kZ2sWCPTIOtfmz1ZyjHhwZt1F/fZgNjedyY6aJKi0QKeKO7TMmWHnFts2
   /aP7CXsybWOFmTzN/LaYDFc8QxqGniDSQJsumfG2Z1RNkTlQ1tOKiE0sE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="347608950"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="347608950"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 16:37:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="654551900"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jul 2022 16:37:49 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCUsW-0000se-Pt;
        Fri, 15 Jul 2022 23:37:48 +0000
Date:   Sat, 16 Jul 2022 07:37:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Smart <jsmart2021@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: arch/arm64/include/asm/cmpxchg.h:88:1: sparse: sparse: cast
 truncates bits from constant value (369 becomes 69)
Message-ID: <202207160705.E13ZH3rE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9b59ec8d50a1f28747ceff9a4f39af5deba9540e
commit: 17b27ac5922454ff7de91cbed458643608c36abc scsi: lpfc: Add rx monitoring statistics
date:   11 months ago
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220716/202207160705.E13ZH3rE-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=17b27ac5922454ff7de91cbed458643608c36abc
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 17b27ac5922454ff7de91cbed458643608c36abc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/cpufreq/ drivers/irqchip/ drivers/scsi/hisi_sas/ drivers/scsi/lpfc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/scsi/lpfc/lpfc_init.c: note: in included file:
   drivers/scsi/lpfc/lpfc_ids.h:26:28: sparse: sparse: symbol 'lpfc_id_table' was not declared. Should it be static?
   drivers/scsi/lpfc/lpfc_init.c:145:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_init.c:145:40: sparse:     expected unsigned int [usertype]
   drivers/scsi/lpfc/lpfc_init.c:145:40: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_init.c:385:27: sparse: sparse: restricted __be32 degrades to integer
   drivers/scsi/lpfc/lpfc_init.c:390:34: sparse: sparse: restricted __be32 degrades to integer
   drivers/scsi/lpfc/lpfc_init.c:4442:24: sparse: sparse: cast to restricted __be64
   drivers/scsi/lpfc/lpfc_init.c:4442:24: sparse: sparse: cast to restricted __be64
   drivers/scsi/lpfc/lpfc_init.c:4442:24: sparse: sparse: cast to restricted __be64
   drivers/scsi/lpfc/lpfc_init.c:4442:24: sparse: sparse: cast to restricted __be64
   drivers/scsi/lpfc/lpfc_init.c:4442:24: sparse: sparse: cast to restricted __be64
   drivers/scsi/lpfc/lpfc_init.c:4442:24: sparse: sparse: cast to restricted __be64
   drivers/scsi/lpfc/lpfc_init.c:4442:24: sparse: sparse: cast to restricted __be64
   drivers/scsi/lpfc/lpfc_init.c:4442:24: sparse: sparse: cast to restricted __be64
   drivers/scsi/lpfc/lpfc_init.c:4442:24: sparse: sparse: cast to restricted __be64
   drivers/scsi/lpfc/lpfc_init.c:4442:24: sparse: sparse: cast to restricted __be64
   drivers/scsi/lpfc/lpfc_init.c:6111:32: sparse: sparse: Using plain integer as NULL pointer
   drivers/scsi/lpfc/lpfc_init.c:7518:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [addressable] [usertype] wwn @@     got restricted __be64 [usertype] @@
   drivers/scsi/lpfc/lpfc_init.c:7518:21: sparse:     expected unsigned long long [addressable] [usertype] wwn
   drivers/scsi/lpfc/lpfc_init.c:7518:21: sparse:     got restricted __be64 [usertype]
   drivers/scsi/lpfc/lpfc_init.c:7523:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [addressable] [usertype] wwn @@     got restricted __be64 [usertype] @@
   drivers/scsi/lpfc/lpfc_init.c:7523:21: sparse:     expected unsigned long long [addressable] [usertype] wwn
   drivers/scsi/lpfc/lpfc_init.c:7523:21: sparse:     got restricted __be64 [usertype]
   drivers/scsi/lpfc/lpfc_init.c:13866:24: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13866:24: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13866:24: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13866:24: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13866:24: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13866:24: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13867:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13867:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13867:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13867:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13867:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13867:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13868:15: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13868:15: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13868:15: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13868:15: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13868:15: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13868:15: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13869:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13869:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13869:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13869:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13869:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13869:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c: note: in included file (through arch/arm64/include/asm/atomic.h, include/linux/atomic.h, include/asm-generic/bitops/atomic.h, ...):
>> arch/arm64/include/asm/cmpxchg.h:88:1: sparse: sparse: cast truncates bits from constant value (369 becomes 69)

vim +88 arch/arm64/include/asm/cmpxchg.h

10b663aef1c2479 Catalin Marinas 2012-03-05  84  
305d454aaa292be Will Deacon     2015-10-08  85  __XCHG_GEN()
305d454aaa292be Will Deacon     2015-10-08  86  __XCHG_GEN(_acq)
305d454aaa292be Will Deacon     2015-10-08  87  __XCHG_GEN(_rel)
305d454aaa292be Will Deacon     2015-10-08 @88  __XCHG_GEN(_mb)
305d454aaa292be Will Deacon     2015-10-08  89  

:::::: The code at line 88 was first introduced by commit
:::::: 305d454aaa292be3a09a9d674e6c35f5b4249a13 arm64: atomics: implement native {relaxed, acquire, release} atomics

:::::: TO: Will Deacon <will.deacon@arm.com>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC75E57F204
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 01:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbiGWXCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 19:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiGWXB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 19:01:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1C91A063
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 16:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658617317; x=1690153317;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+qYeABImKkCa3/hprWAOVdAiMmIb+T3f66Lu/PXSCnU=;
  b=Tyvha+3GvHlC3V0dzcRe1TwtVX+RyXFuiyOr1Sq8mrro3BxjW09W5iVa
   dA6iZK+jcIaKs38IaYXWVX/pVqtMnvSWEFWM2EmEurTrXQ8NZ5Jbpx+hZ
   8BIK0yIvyvlhSob9e0HaCfotTCKO0ZLpvP4UEnCR0Cl++Ht5HLc0bYdo+
   DjwtYC3VFEvIukbCIx8MepDzvIivvvNrAuFlokIonqIIL2xMwZQe11BPa
   B+6rrpN9KhpHlQIpw/hOFAyY7Xz9dW4FwhyzGYeM42SyeM5yTrw4yo9j1
   Gy2YN9xkq76o4LNXXqCScb6A4df1IQ3npb8oIdqFmPuJVajqjBC4RJr56
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="288678860"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="288678860"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 16:01:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="725771892"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Jul 2022 16:01:55 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFO8B-0003Cb-0S;
        Sat, 23 Jul 2022 23:01:55 +0000
Date:   Sun, 24 Jul 2022 07:01:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/xtensa/lib/kcsan-stubs.c:6:6: sparse: sparse: symbol
 '__atomic_store_8' was not declared. Should it be static?
Message-ID: <202207240618.RpyqtnDw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   515f71412bb73ebd7f41f90e1684fc80b8730789
commit: 725aea873261e8d986e527838fde2a721f0962d8 xtensa: enable KCSAN
date:   3 months ago
config: xtensa-randconfig-s052-20220724 (https://download.01.org/0day-ci/archive/20220724/202207240618.RpyqtnDw-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=725aea873261e8d986e527838fde2a721f0962d8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 725aea873261e8d986e527838fde2a721f0962d8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> arch/xtensa/lib/kcsan-stubs.c:6:6: sparse: sparse: symbol '__atomic_store_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:11:5: sparse: sparse: symbol '__atomic_load_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:16:5: sparse: sparse: symbol '__atomic_exchange_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:21:6: sparse: sparse: symbol '__atomic_compare_exchange_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:26:5: sparse: sparse: symbol '__atomic_fetch_add_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:31:5: sparse: sparse: symbol '__atomic_fetch_sub_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:36:5: sparse: sparse: symbol '__atomic_fetch_and_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:41:5: sparse: sparse: symbol '__atomic_fetch_or_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:46:5: sparse: sparse: symbol '__atomic_fetch_xor_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:51:5: sparse: sparse: symbol '__atomic_fetch_nand_8' was not declared. Should it be static?

vim +/__atomic_store_8 +6 arch/xtensa/lib/kcsan-stubs.c

     5	
   > 6	void __atomic_store_8(volatile void *p, u64 v, int i)
     7	{
     8		BUG();
     9	}
    10	
  > 11	u64 __atomic_load_8(const volatile void *p, int i)
    12	{
    13		BUG();
    14	}
    15	
  > 16	u64 __atomic_exchange_8(volatile void *p, u64 v, int i)
    17	{
    18		BUG();
    19	}
    20	
  > 21	bool __atomic_compare_exchange_8(volatile void *p1, void *p2, u64 v, bool b, int i1, int i2)
    22	{
    23		BUG();
    24	}
    25	
  > 26	u64 __atomic_fetch_add_8(volatile void *p, u64 v, int i)
    27	{
    28		BUG();
    29	}
    30	
  > 31	u64 __atomic_fetch_sub_8(volatile void *p, u64 v, int i)
    32	{
    33		BUG();
    34	}
    35	
  > 36	u64 __atomic_fetch_and_8(volatile void *p, u64 v, int i)
    37	{
    38		BUG();
    39	}
    40	
  > 41	u64 __atomic_fetch_or_8(volatile void *p, u64 v, int i)
    42	{
    43		BUG();
    44	}
    45	
  > 46	u64 __atomic_fetch_xor_8(volatile void *p, u64 v, int i)
    47	{
    48		BUG();
    49	}
    50	
  > 51	u64 __atomic_fetch_nand_8(volatile void *p, u64 v, int i)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

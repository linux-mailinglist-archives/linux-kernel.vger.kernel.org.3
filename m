Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C70557D87B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbiGVCYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiGVCYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:24:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C3B974AC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 19:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658456652; x=1689992652;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BRQ52GKy6Pc1+uWcW0oc5AqbIKyLAI56YqhyTYJh7jA=;
  b=kxlZMAACd/DnpUdyaAWOq8tffybi533tJdaraCZhZ1fAXVYcJsauS5qT
   s+byIhIMM287bokMVwqtKw6awuutroD2h6Lc2jAL3G3FHtARAKhrjVjCU
   mKp00ciLV6UFiTfUcY53E2vAWrsovfylUcBg4wS2/jKCmC0W/RH3MKLpv
   wToDQVylJPMe9iRILXMyFGTSha7Zi+b9LOTIdLS13yZagLq8IgONRCfMm
   WsjKE62ZkyM3oK95+nUeZhxn8scDT1jSpQMKAJHd2T1S2c3OIdq+AWf8B
   unPJX3YffncjgZ3S+jhBYUXBumm9siARjZtpMGC+uSZo3i19/muB89IaE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="351215904"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="351215904"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 19:24:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="657023343"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jul 2022 19:24:09 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEiKm-0000rI-14;
        Fri, 22 Jul 2022 02:24:08 +0000
Date:   Fri, 22 Jul 2022 10:23:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     kbuild-all@lists.01.org, Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org
Subject: [atishp04:kvm_perf_rfc 15/24] include/linux/compiler_types.h:354:45:
 error: call to '__compiletime_assert_265' declared with attribute error:
 BUILD_BUG failed
Message-ID: <202207221049.L22fElYW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux kvm_perf_rfc
head:   f7c410879b9a723ff8fbc32e4acb668b7fee423a
commit: 20c5f15d297fb5a842bb1488be2781826b65a1dd [15/24] COVER
config: openrisc-randconfig-r035-20220720 (https://download.01.org/0day-ci/archive/20220722/202207221049.L22fElYW-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/atishp04/linux/commit/20c5f15d297fb5a842bb1488be2781826b65a1dd
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 kvm_perf_rfc
        git checkout 20c5f15d297fb5a842bb1488be2781826b65a1dd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   mm/shmem.c: In function 'shmem_getattr':
>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_265' declared with attribute error: BUILD_BUG failed
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
     335 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
         |                     ^~~~~~~~~~~~~~~~
   include/linux/huge_mm.h:323:27: note: in expansion of macro 'BUILD_BUG'
     323 | #define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })
         |                           ^~~~~~~~~
   mm/shmem.c:1064:33: note: in expansion of macro 'HPAGE_PMD_SIZE'
    1064 |                 stat->blksize = HPAGE_PMD_SIZE;
         |                                 ^~~~~~~~~~~~~~


vim +/__compiletime_assert_265 +354 include/linux/compiler_types.h

eb5c2d4b45e3d2d Will Deacon 2020-07-21  340  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  341  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21  342  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  343  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  344  /**
eb5c2d4b45e3d2d Will Deacon 2020-07-21  345   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  346   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2d Will Deacon 2020-07-21  347   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  348   *
eb5c2d4b45e3d2d Will Deacon 2020-07-21  349   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  350   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  351   * compiler has support to do so.
eb5c2d4b45e3d2d Will Deacon 2020-07-21  352   */
eb5c2d4b45e3d2d Will Deacon 2020-07-21  353  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21 @354  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  355  

:::::: The code at line 354 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FFA4E84BC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 00:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiC0AAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 20:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiC0AAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 20:00:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E57954BEA
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 16:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648339123; x=1679875123;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9YBtb7SRWGN7PUW22D/1S2UqYzDN2EzU9pfZzbMmhqw=;
  b=aNBv7kYzulAb2LI8zLLrwJXbafqhsnh2egCAQeQy0SNoN1e3TYu/TOtK
   ifuP1o7zIJwj7lxVnDMJ3IcKHApHfbQI8lcOOHXrDa9nyDHRbE45zQU8L
   MOE6JHdJhsxTyR8OXqO2mT9TOQvGT2aipebS8leR2QmyQM4iK30Cul6zd
   p7+oNpSFxbjfSamwe+/qCFa7GualHeOOLQk17Emtzus92JtBvSUk3+s4l
   0dw6/GH2L0nV0l6PUPZFHUx46XGRVGnxVqzCTf5/1U1y6BeRyYLF8aXpB
   /DqGqvKDvvN7O+nAoCCnWoc7En5UKyKDScdTebESBfnERj+zkHTMJkaU7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10298"; a="238746159"
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="238746159"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 16:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="520578135"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 26 Mar 2022 16:58:41 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYGIq-0000XB-U7; Sat, 26 Mar 2022 23:58:40 +0000
Date:   Sun, 27 Mar 2022 07:58:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/afs-testing 44/45]
 arch/arm64/include/asm/cmpxchg.h:88:1: sparse: sparse: cast truncates bits
 from constant value (5e5ee5e5 becomes e5)
Message-ID: <202203270756.wzqWZ0Ez-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/afs-testing
head:   bd9f21ac2aa3a4b3332c504a89afe0019a56391a
commit: 17b80dadaf0195ee91f7f115d78b0ea93ae3355c [44/45] Check for dead timer
config: arm64-randconfig-s032-20220327 (https://download.01.org/0day-ci/archive/20220327/202203270756.wzqWZ0Ez-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/17b80dadaf0195ee91f7f115d78b0ea93ae3355c
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/afs-testing
        git checkout 17b80dadaf0195ee91f7f115d78b0ea93ae3355c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/ kernel/time/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/time/timer.c: note: in included file (through arch/arm64/include/asm/atomic.h, include/linux/atomic.h, include/asm-generic/bitops/atomic.h, ...):
>> arch/arm64/include/asm/cmpxchg.h:88:1: sparse: sparse: cast truncates bits from constant value (5e5ee5e5 becomes e5)
>> arch/arm64/include/asm/cmpxchg.h:88:1: sparse: sparse: cast truncates bits from constant value (5e5ee5e5 becomes e5e5)

vim +88 arch/arm64/include/asm/cmpxchg.h

10b663aef1c247 Catalin Marinas 2012-03-05  84  
305d454aaa292b Will Deacon     2015-10-08  85  __XCHG_GEN()
305d454aaa292b Will Deacon     2015-10-08  86  __XCHG_GEN(_acq)
305d454aaa292b Will Deacon     2015-10-08  87  __XCHG_GEN(_rel)
305d454aaa292b Will Deacon     2015-10-08 @88  __XCHG_GEN(_mb)
305d454aaa292b Will Deacon     2015-10-08  89  

:::::: The code at line 88 was first introduced by commit
:::::: 305d454aaa292be3a09a9d674e6c35f5b4249a13 arm64: atomics: implement native {relaxed, acquire, release} atomics

:::::: TO: Will Deacon <will.deacon@arm.com>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

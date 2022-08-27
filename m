Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112C55A3A7D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 01:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiH0Xj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 19:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiH0Xj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 19:39:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233D54054F
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 16:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661643562; x=1693179562;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VWze/pU9bTEd+NDM0EpnmGOG3DLSG5nTEvjA69/pPrc=;
  b=LLrbMCTXojqRE87CzQinHM2cCeHPzYW7KjaiDK+94+LQVL63gLzvKmu1
   6RBrjR1vudRPIkI3TZHqFey01dpDmaVg1WYyM71KLivZ0BMvrf7QLhHNo
   pD3NObIefDauijIWrz7UNRr+p8yrJpaM3LKk79M9mU46v/qQ5+hEJDRuP
   Mv9yS2VjU9yv/w37vyq5uQTGPnPXYOwDOx9dEGV84LCtRs/eKItlWfJnj
   Tws8J/oq30VFiymjqUa3TvPQps2DkGP7cdRHIEjjyMoxj2J0p/mXw6EDQ
   /LNeAh/BRGqpnpSdAaSeQM4K2HNs0GsMLA5jl1ssi8HYPzyLZy7VxRk0k
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10452"; a="292276276"
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="292276276"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 16:39:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="561816333"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Aug 2022 16:39:20 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oS5OZ-0000Zb-21;
        Sat, 27 Aug 2022 23:39:19 +0000
Date:   Sun, 28 Aug 2022 07:39:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: include/linux/atomic/atomic-instrumented.h:476:16: sparse: sparse:
 cast truncates bits from constant value (ffffffffaaa31337 becomes 37)
Message-ID: <202208280731.ipmZVeen-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   89b749d8552d78c4dd86dea86e2e6ba8aafab9fe
commit: e3d18cee258b898017b298b5b93f8134dd62aee3 locking/atomic: centralize generated headers
date:   1 year, 1 month ago
config: ia64-randconfig-s043-20220828 (https://download.01.org/0day-ci/archive/20220828/202208280731.ipmZVeen-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e3d18cee258b898017b298b5b93f8134dd62aee3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e3d18cee258b898017b298b5b93f8134dd62aee3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   lib/atomic64_test.c: note: in included file (through include/linux/atomic.h):
>> include/linux/atomic/atomic-instrumented.h:476:16: sparse: sparse: cast truncates bits from constant value (ffffffffaaa31337 becomes 37)
   include/linux/atomic/atomic-instrumented.h:476:16: sparse: sparse: cast truncates bits from constant value (ffffffffaaa31337 becomes 1337)
   include/linux/atomic/atomic-instrumented.h:483:16: sparse: sparse: cast truncates bits from constant value (ffffffffaaa31337 becomes 37)
   include/linux/atomic/atomic-instrumented.h:483:16: sparse: sparse: cast truncates bits from constant value (ffffffffaaa31337 becomes 1337)
   include/linux/atomic/atomic-instrumented.h:490:16: sparse: sparse: cast truncates bits from constant value (ffffffffaaa31337 becomes 37)
   include/linux/atomic/atomic-instrumented.h:490:16: sparse: sparse: cast truncates bits from constant value (ffffffffaaa31337 becomes 1337)
   include/linux/atomic/atomic-instrumented.h:497:16: sparse: sparse: cast truncates bits from constant value (ffffffffaaa31337 becomes 37)
   include/linux/atomic/atomic-instrumented.h:497:16: sparse: sparse: cast truncates bits from constant value (ffffffffaaa31337 becomes 1337)
>> include/linux/atomic/atomic-instrumented.h:476:16: sparse: sparse: cast truncates bits from constant value (11112222 becomes 22)
   include/linux/atomic/atomic-instrumented.h:476:16: sparse: sparse: cast truncates bits from constant value (11112222 becomes 2222)
   include/linux/atomic/atomic-instrumented.h:483:16: sparse: sparse: cast truncates bits from constant value (11112222 becomes 22)
   include/linux/atomic/atomic-instrumented.h:483:16: sparse: sparse: cast truncates bits from constant value (11112222 becomes 2222)
   include/linux/atomic/atomic-instrumented.h:490:16: sparse: sparse: cast truncates bits from constant value (11112222 becomes 22)
   include/linux/atomic/atomic-instrumented.h:490:16: sparse: sparse: cast truncates bits from constant value (11112222 becomes 2222)
   include/linux/atomic/atomic-instrumented.h:497:16: sparse: sparse: cast truncates bits from constant value (11112222 becomes 22)
   include/linux/atomic/atomic-instrumented.h:497:16: sparse: sparse: cast truncates bits from constant value (11112222 becomes 2222)
>> include/linux/atomic/atomic-instrumented.h:1054:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes d)
>> include/linux/atomic/atomic-instrumented.h:1054:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes d00d)
>> include/linux/atomic/atomic-instrumented.h:1054:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes c001d00d)
   include/linux/atomic/atomic-instrumented.h:1061:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes d)
   include/linux/atomic/atomic-instrumented.h:1061:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes d00d)
   include/linux/atomic/atomic-instrumented.h:1061:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes c001d00d)
   include/linux/atomic/atomic-instrumented.h:1068:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes d)
   include/linux/atomic/atomic-instrumented.h:1068:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes d00d)
   include/linux/atomic/atomic-instrumented.h:1068:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes c001d00d)
   include/linux/atomic/atomic-instrumented.h:1075:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes d)
   include/linux/atomic/atomic-instrumented.h:1075:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes d00d)
   include/linux/atomic/atomic-instrumented.h:1075:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes c001d00d)
>> include/linux/atomic/atomic-instrumented.h:1054:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes 1)
>> include/linux/atomic/atomic-instrumented.h:1054:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes f001)
>> include/linux/atomic/atomic-instrumented.h:1054:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes f00df001)
   include/linux/atomic/atomic-instrumented.h:1061:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes 1)
   include/linux/atomic/atomic-instrumented.h:1061:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes f001)
   include/linux/atomic/atomic-instrumented.h:1061:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes f00df001)
   include/linux/atomic/atomic-instrumented.h:1068:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes 1)
   include/linux/atomic/atomic-instrumented.h:1068:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes f001)
   include/linux/atomic/atomic-instrumented.h:1068:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes f00df001)
   include/linux/atomic/atomic-instrumented.h:1075:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes 1)
   include/linux/atomic/atomic-instrumented.h:1075:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes f001)
   include/linux/atomic/atomic-instrumented.h:1075:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes f00df001)

vim +476 include/linux/atomic/atomic-instrumented.h

aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  471  
c020395b6634b7 include/asm-generic/atomic-instrumented.h Marco Elver  2019-11-26  472  static __always_inline int
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  473  atomic_cmpxchg(atomic_t *v, int old, int new)
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  474  {
3570a1bcf45e9a include/asm-generic/atomic-instrumented.h Marco Elver  2020-07-24  475  	instrument_atomic_read_write(v, sizeof(*v));
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04 @476  	return arch_atomic_cmpxchg(v, old, new);
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  477  }
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  478  

:::::: The code at line 476 was first introduced by commit
:::::: aa525d063851a98e020b827fdd1d7776ae652301 locking/atomics: Switch to generated instrumentation

:::::: TO: Mark Rutland <mark.rutland@arm.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

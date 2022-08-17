Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2141A596B31
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbiHQIOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiHQIOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:14:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19267474DE
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660724065; x=1692260065;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0tqerVnGokmDgpuMJWnHbJ0LwGABUHb9fOAuziZi1Js=;
  b=m3Ll87Fd8lHxxeC/1232Gn4z3JroV3Vb+hYbGZUyodjEiJmnNBCYNfq0
   TaArLtaQHtEngBWOxfYTjHT/JYspEvJodmtB/ElXXiDYJ8Ut+C7FQqxTC
   jDikx5HyQd10y+Z4va8l6+i6SGczW4rSik9Yd78E11HNxq8KBj27485Am
   /2+A/W0+4n/EKUSlMK682AmaVRHqn5BAbazQE2iCOuAK6RWQEngnGcWl7
   uCMmGqhDDTSRSX1SH0rj9jV6IKyMXlBZslm+Mt+TLrONYg1bYEl+bZ/tB
   fr9afyFuOHF99lSTqgkoK/GSuuEgOoN5VH6jr9XWFSoW8x7bPjKa3VMxH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="293710752"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="293710752"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:14:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="675548890"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2022 01:14:14 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOEBq-0000iw-14;
        Wed, 17 Aug 2022 08:14:14 +0000
Date:   Wed, 17 Aug 2022 16:13:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     kbuild-all@lists.01.org, Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org
Subject: [atishp04:kvm_perf_rfc_buildtest 15/24]
 include/asm-generic/cmpxchg.h:76: undefined reference to
 `__generic_xchg_called_with_bad_pointer'
Message-ID: <202208171554.YLAVtmnV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux kvm_perf_rfc_buildtest
head:   ff2f56ec4ff4f67ae3da3936939b1dcf53099a6e
commit: 5faed77192c5455fe17fb4e6aea87e5bcc48a13d [15/24] COVER
config: microblaze-buildonly-randconfig-r006-20220717 (https://download.01.org/0day-ci/archive/20220817/202208171554.YLAVtmnV-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/atishp04/linux/commit/5faed77192c5455fe17fb4e6aea87e5bcc48a13d
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 kvm_perf_rfc_buildtest
        git checkout 5faed77192c5455fe17fb4e6aea87e5bcc48a13d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: kernel/rcu/rcutorture.o: in function `__generic_xchg':
>> include/asm-generic/cmpxchg.h:76: undefined reference to `__generic_xchg_called_with_bad_pointer'
   microblaze-linux-ld: kernel/trace/ring_buffer.o: in function `__generic_cmpxchg_local':
>> include/asm-generic/cmpxchg-local.h:24: undefined reference to `wrong_size_cmpxchg'
>> microblaze-linux-ld: include/asm-generic/cmpxchg-local.h:45: undefined reference to `wrong_size_cmpxchg'


vim +76 include/asm-generic/cmpxchg.h

b4816afa3986704 David Howells 2012-03-28  74  
b4816afa3986704 David Howells 2012-03-28  75  	default:
82b993e8249ae3c Mark Rutland  2021-05-25 @76  		__generic_xchg_called_with_bad_pointer();
b4816afa3986704 David Howells 2012-03-28  77  		return x;
b4816afa3986704 David Howells 2012-03-28  78  	}
b4816afa3986704 David Howells 2012-03-28  79  }
b4816afa3986704 David Howells 2012-03-28  80  

:::::: The code at line 76 was first introduced by commit
:::::: 82b993e8249ae3cb29c1b6eb8f6548f5748508b7 locking/atomic: cmpxchg: support ARCH_ATOMIC

:::::: TO: Mark Rutland <mark.rutland@arm.com>
:::::: CC: Peter Zijlstra <peterz@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

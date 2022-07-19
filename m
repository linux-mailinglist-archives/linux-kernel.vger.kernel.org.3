Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A95C57A74E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbiGSTid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbiGSTib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:38:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D134B0C7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658259510; x=1689795510;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=j1NSqX65Z1POM4/Ayq9+N9CgUstQx3vxobykYw22oGY=;
  b=OO/TJXM2Cq2VgNEwgwsj/wR3n11dtUabORrgktA8UoAfn1FHpGxtZBF/
   Z31toHHB5FSjeKYaSwGsPJYocCtdSnqIPXSZa4jBfR+sN9Qhbv7C5UgNM
   gDzO3WFX4M6fdJzZ/yyVj36CkubB8ChyFSIzEtKANJWhHCVv8uBwu/sJ1
   elN+1JGiTZbR24fYZkZyz/z7mmrsAFTuXWX8AEQjRWytgRn+1CTWVvWHy
   QVZHu86yn0utCl5KSfH2p8wIFzyF01YMO4x9N23DrVx54elMGT2aEfF8y
   /S8VPVEoPHVIZwFxQpwqOrTKcEGcNEZvpM/vyM7VbCFK9Y41eywjUlEsn
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="269608709"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="269608709"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 12:38:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="548036058"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 19 Jul 2022 12:38:29 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDt36-0005xi-FG;
        Tue, 19 Jul 2022 19:38:28 +0000
Date:   Wed, 20 Jul 2022 03:38:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     kbuild-all@lists.01.org, Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org
Subject: [atishp04:kvm_perf_rfc 15/24]
 arch/openrisc/include/asm/cmpxchg.h:131:24: error: call to
 '__cmpxchg_called_with_bad_pointer' declared with attribute error: Bad
 argument size for cmpxchg
Message-ID: <202207200317.VLiEV0Zq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux kvm_perf_rfc
head:   f7c410879b9a723ff8fbc32e4acb668b7fee423a
commit: 20c5f15d297fb5a842bb1488be2781826b65a1dd [15/24] COVER
config: openrisc-randconfig-c024-20220718 (https://download.01.org/0day-ci/archive/20220720/202207200317.VLiEV0Zq-lkp@intel.com/config)
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

   In file included from arch/openrisc/include/asm/atomic.h:131,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/openrisc/include/asm/bitops.h:41,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from lib/atomic64_test.c:12:
   arch/openrisc/include/asm/cmpxchg.h: In function '__cmpxchg':
>> arch/openrisc/include/asm/cmpxchg.h:131:24: error: call to '__cmpxchg_called_with_bad_pointer' declared with attribute error: Bad argument size for cmpxchg
     131 |                 return __cmpxchg_called_with_bad_pointer();
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/__cmpxchg_called_with_bad_pointer +131 arch/openrisc/include/asm/cmpxchg.h

489e0f802db708 Stafford Horne 2017-03-23  113  
489e0f802db708 Stafford Horne 2017-03-23  114  /*
489e0f802db708 Stafford Horne 2017-03-23  115   * This function doesn't exist, so you'll get a linker error
489e0f802db708 Stafford Horne 2017-03-23  116   * if something tries to do an invalid cmpxchg().
489e0f802db708 Stafford Horne 2017-03-23  117   */
489e0f802db708 Stafford Horne 2017-03-23  118  extern unsigned long __cmpxchg_called_with_bad_pointer(void)
489e0f802db708 Stafford Horne 2017-03-23  119  	__compiletime_error("Bad argument size for cmpxchg");
489e0f802db708 Stafford Horne 2017-03-23  120  
489e0f802db708 Stafford Horne 2017-03-23  121  static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
489e0f802db708 Stafford Horne 2017-03-23  122  		unsigned long new, int size)
489e0f802db708 Stafford Horne 2017-03-23  123  {
489e0f802db708 Stafford Horne 2017-03-23  124  	switch (size) {
489e0f802db708 Stafford Horne 2017-03-23  125  	case 1:
489e0f802db708 Stafford Horne 2017-03-23  126  	case 2:
489e0f802db708 Stafford Horne 2017-03-23  127  		return cmpxchg_small(ptr, old, new, size);
489e0f802db708 Stafford Horne 2017-03-23  128  	case 4:
489e0f802db708 Stafford Horne 2017-03-23  129  		return cmpxchg_u32(ptr, old, new);
489e0f802db708 Stafford Horne 2017-03-23  130  	default:
489e0f802db708 Stafford Horne 2017-03-23 @131  		return __cmpxchg_called_with_bad_pointer();
489e0f802db708 Stafford Horne 2017-03-23  132  	}
489e0f802db708 Stafford Horne 2017-03-23  133  }
489e0f802db708 Stafford Horne 2017-03-23  134  

:::::: The code at line 131 was first introduced by commit
:::::: 489e0f802db708c69004f64d92a3e1b70731614a openrisc: add 1 and 2 byte cmpxchg support

:::::: TO: Stafford Horne <shorne@gmail.com>
:::::: CC: Stafford Horne <shorne@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

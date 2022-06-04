Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020E453D80E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 19:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239277AbiFDRjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 13:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbiFDRjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 13:39:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12B138D9D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 10:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654364390; x=1685900390;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fw58+DLuVveflhvtJyRFgJ7M82oNU8uKvexxbDIxiWU=;
  b=NiReMtrIdkjoW32pUpvo4/ZEA13mgsEuQMC5jbRHCZjHkQg/wOMjMC6u
   svR2lyqlGxVawzz4+6Xk356JhEPqkFwjLQl9X/9KHIkNo04s9b8V7x58x
   4MiRRRzfx0tU+6gaz5SXQSzPnQ3KPW/4EX/FosDzH0EuMacYVcKm2OugH
   PJN/GFCIOR+9V2L8xQsCzfJk09QuRdhYPJGw4nT6Pc/BldKEWfBVhZwrY
   zvqS+p4JMm+sG6bAB6XDvzdCWQS+mhdrG1R7gTO9huEOKcJyXPEhZE60l
   4RqJWSEOYKfqZRjEoj9z6Fyh4OHs3uUPsOOJ356X4tAOq2VMYC6pKLgRz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="339530743"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="339530743"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 10:39:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="531444736"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Jun 2022 10:39:48 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxXka-000B5l-6K;
        Sat, 04 Jun 2022 17:39:48 +0000
Date:   Sun, 5 Jun 2022 01:39:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: arch/powerpc/mm/book3s64/radix_tlb.c:418:20: error: unused function
 '_tlbie_pid_lpid'
Message-ID: <202206050116.iF1fFubY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   032dcf09e2bf7c822be25b4abef7a6c913870d98
commit: a736143afd036f2078fe19435b16fd55abc789a9 Merge branch 'topic/ppc-kvm' into next
date:   12 months ago
config: powerpc64-buildonly-randconfig-r006-20220604 (https://download.01.org/0day-ci/archive/20220605/202206050116.iF1fFubY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0a90b72c432d70aae035727ece4ba80ce820f381)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc64 cross compiling tool for clang build
        # apt-get install binutils-powerpc64le-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a736143afd036f2078fe19435b16fd55abc789a9
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a736143afd036f2078fe19435b16fd55abc789a9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/mm/book3s64/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/powerpc/mm/book3s64/radix_tlb.c:418:20: error: unused function '_tlbie_pid_lpid' [-Werror,-Wunused-function]
   static inline void _tlbie_pid_lpid(unsigned long pid, unsigned long lpid,
                      ^
>> arch/powerpc/mm/book3s64/radix_tlb.c:662:20: error: unused function '_tlbie_va_range_lpid' [-Werror,-Wunused-function]
   static inline void _tlbie_va_range_lpid(unsigned long start, unsigned long end,
                      ^
   2 errors generated.


vim +/_tlbie_pid_lpid +418 arch/powerpc/mm/book3s64/radix_tlb.c

1a472c9dba6b96 arch/powerpc/mm/tlb-radix.c          Aneesh Kumar K.V 2016-04-29  417  
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21 @418  static inline void _tlbie_pid_lpid(unsigned long pid, unsigned long lpid,
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  419  				   unsigned long ric)
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  420  {
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  421  	asm volatile("ptesync" : : : "memory");
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  422  
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  423  	/*
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  424  	 * Workaround the fact that the "ric" argument to __tlbie_pid
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  425  	 * must be a compile-time contraint to match the "i" constraint
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  426  	 * in the asm statement.
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  427  	 */
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  428  	switch (ric) {
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  429  	case RIC_FLUSH_TLB:
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  430  		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_TLB);
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  431  		fixup_tlbie_pid_lpid(pid, lpid);
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  432  		break;
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  433  	case RIC_FLUSH_PWC:
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  434  		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_PWC);
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  435  		break;
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  436  	case RIC_FLUSH_ALL:
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  437  	default:
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  438  		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_ALL);
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  439  		fixup_tlbie_pid_lpid(pid, lpid);
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  440  	}
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  441  	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  442  }
2275d7b5754a57 arch/powerpc/mm/book3s64/radix_tlb.c Nicholas Piggin  2019-09-03  443  struct tlbiel_pid {
2275d7b5754a57 arch/powerpc/mm/book3s64/radix_tlb.c Nicholas Piggin  2019-09-03  444  	unsigned long pid;
2275d7b5754a57 arch/powerpc/mm/book3s64/radix_tlb.c Nicholas Piggin  2019-09-03  445  	unsigned long ric;
2275d7b5754a57 arch/powerpc/mm/book3s64/radix_tlb.c Nicholas Piggin  2019-09-03  446  };
2275d7b5754a57 arch/powerpc/mm/book3s64/radix_tlb.c Nicholas Piggin  2019-09-03  447  

:::::: The code at line 418 was first introduced by commit
:::::: f0c6fbbb90504fb7e9dbf0865463d3c2b4de49e5 KVM: PPC: Book3S HV: Add support for H_RPT_INVALIDATE

:::::: TO: Bharata B Rao <bharata@linux.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

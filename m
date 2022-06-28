Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E15255C9BB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241711AbiF1HbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiF1HbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:31:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395F92CDEA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656401476; x=1687937476;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MEDXCJKlUeRWDEf8GYWxhQSY4NEFo4w2mQeBhKA8GQ8=;
  b=iEUztBbReX4s4GEkndjSeUskwT9KEY24rcnrf4nVVYetMfBPjKawcWDB
   1aZuWe77g8oI4pCM6udyJ5RsJ7trkKZxsarSfaBCenySIWlrDqEE+/kkA
   WfZ8db1ctKoWkxSFxi5Q2yuadOR4naGJ9QyU3+7jS3L7UA529pSLj1Fn/
   RC9+lMvuBoHkH9+Rq/78hu7Z0iNccRmj2bleAPWF77g873wfRd8963JiE
   Lk4ZoIaqIxxv9cK8g0EEk80xpPhbCMGzjVgp9OOtNUd4nbDf7/J3UnmYc
   gFDqXb7qGswzt9GaofEtt2NCTM0XETa2u+8UOvK5Nhva9KWPgEacZPriY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="282754968"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="282754968"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 00:31:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="836564054"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jun 2022 00:31:13 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o65gn-0009gs-3T;
        Tue, 28 Jun 2022 07:31:13 +0000
Date:   Tue, 28 Jun 2022 15:30:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: [akpm-mm:mm-unstable 137/269] mm/memory-failure.c:1728:19: error:
 redefinition of 'mf_generic_kill_procs'
Message-ID: <202206281524.6A02wFc0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
head:   e75a11c67c2bbfefe57713b8bd62e488a9196baf
commit: 4184e8d7d056b7943348dabb99a37ca9ba51fb8d [137/269] mm-factor-helpers-for-memory_failure_dev_pagemap-fix
config: x86_64-randconfig-a002-20220627 (https://download.01.org/0day-ci/archive/20220628/202206281524.6A02wFc0-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project df18167ac56d05f2ab55f9d874aee7ab6d5bc9a2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=4184e8d7d056b7943348dabb99a37ca9ba51fb8d
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch --no-tags akpm-mm mm-unstable
        git checkout 4184e8d7d056b7943348dabb99a37ca9ba51fb8d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> mm/memory-failure.c:1728:8: warning: attribute declaration must precede definition [-Wignored-attributes]
   static inline int mf_generic_kill_procs(unsigned long long pfn, int flags,
          ^
   include/linux/compiler_types.h:155:23: note: expanded from macro 'inline'
   #define inline inline __gnu_inline __inline_maybe_unused notrace
                         ^
   include/linux/compiler_attributes.h:173:56: note: expanded from macro '__gnu_inline'
   #define __gnu_inline                    __attribute__((__gnu_inline__))
                                                          ^
   mm/memory-failure.c:1526:12: note: previous definition is here
   static int mf_generic_kill_procs(unsigned long long pfn, int flags,
              ^
>> mm/memory-failure.c:1728:8: warning: attribute declaration must precede definition [-Wignored-attributes]
   static inline int mf_generic_kill_procs(unsigned long long pfn, int flags,
          ^
   include/linux/compiler_types.h:155:58: note: expanded from macro 'inline'
   #define inline inline __gnu_inline __inline_maybe_unused notrace
                                                            ^
   arch/x86/include/asm/linkage.h:9:32: note: expanded from macro 'notrace'
   #define notrace __attribute__((no_instrument_function))
                                  ^
   mm/memory-failure.c:1526:12: note: previous definition is here
   static int mf_generic_kill_procs(unsigned long long pfn, int flags,
              ^
>> mm/memory-failure.c:1728:19: error: redefinition of 'mf_generic_kill_procs'
   static inline int mf_generic_kill_procs(unsigned long long pfn, int flags,
                     ^
   mm/memory-failure.c:1526:12: note: previous definition is here
   static int mf_generic_kill_procs(unsigned long long pfn, int flags,
              ^
   2 warnings and 1 error generated.


vim +/mf_generic_kill_procs +1728 mm/memory-failure.c

  1727	
> 1728	static inline int mf_generic_kill_procs(unsigned long long pfn, int flags,
  1729						struct dev_pagemap *pgmap)
  1730	{
  1731		return 0;
  1732	}
  1733	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

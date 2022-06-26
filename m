Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758AB55AE78
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 05:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbiFZDZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 23:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiFZDZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 23:25:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7D613D27
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 20:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656213948; x=1687749948;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jr/HcbevOlaii7rg9PSyBHzHq02Cs59Ujht+bBcVbnQ=;
  b=dqYjb40JdvaEAZAbp9aBn/FKljt1D0NdvWMZaM+f+VQIOU7coSPpUtQ4
   5fy66DgkhmbK4k3HRS+l2rzhabsWeOa5ajqZh73iJ2y5PHOUyjhEQFHGG
   19ZC+pZdSFuiviGhEVZiL3bV/6g+iPtOaK2wu+q90+paCdpRLAtRcmUmn
   kjo8v9tYMArAWwBYspXNIdYqb/V5cSq+Nd9QCA25EGNiFwi0CUYFSGNnm
   kOO36D3kMJMYzqcE7RXkdCUJA3Yx4V8ds2lHjcJorqEuiHvZRE0DsEj5D
   /3+hru5gZX93W3FTxUbS3Xd1IQmOmLbijYbulm6Ak6ogqWI1QnDcG+Gau
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10389"; a="278786713"
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; 
   d="scan'208";a="278786713"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 20:25:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; 
   d="scan'208";a="593800557"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jun 2022 20:25:47 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5IuA-0006g7-FV;
        Sun, 26 Jun 2022 03:25:46 +0000
Date:   Sun, 26 Jun 2022 11:25:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [norov:fns 14/24] include/linux/nodemask.h:281:16: error: too many
 arguments to function 'find_next_bit_wrap'
Message-ID: <202206261141.Ih0GKUsa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux fns
head:   c6f11d769095eb58ae2f05e3df1d8e71b7ccc5d7
commit: 2578c583b93e113c3f4bab20524203227add8495 [14/24] find_next_bit_wrap
config: x86_64-rhel-8.3-kselftests
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/norov/linux/commit/2578c583b93e113c3f4bab20524203227add8495
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov fns
        git checkout 2578c583b93e113c3f4bab20524203227add8495
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: the norov/fns HEAD c6f11d769095eb58ae2f05e3df1d8e71b7ccc5d7 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from include/linux/bitmap.h:9,
                    from include/linux/cpumask.h:12,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:22,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/ktime.h:24,
                    from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/slab.h:18,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/find.h: In function '_find_next_bit_wrap':
   include/linux/find.h:30:24: error: implicit declaration of function 'find_next_bit'; did you mean '_find_next_bit'? [-Werror=implicit-function-declaration]
      30 |                 from = find_next_bit(addr, to, from);
         |                        ^~~~~~~~~~~~~
         |                        _find_next_bit
   include/linux/find.h:38:16: error: implicit declaration of function 'find_first_bit'; did you mean '_find_first_bit'? [-Werror=implicit-function-declaration]
      38 |         from = find_first_bit(addr, to);
         |                ^~~~~~~~~~~~~~
         |                _find_first_bit
   include/linux/find.h: At top level:
   include/linux/find.h:69:15: error: conflicting types for 'find_next_bit'; have 'long unsigned int(const long unsigned int *, long unsigned int,  long unsigned int)'
      69 | unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
         |               ^~~~~~~~~~~~~
   include/linux/find.h:30:24: note: previous implicit declaration of 'find_next_bit' with type 'int()'
      30 |                 from = find_next_bit(addr, to, from);
         |                        ^~~~~~~~~~~~~
   include/linux/find.h:154:15: error: conflicting types for 'find_first_bit'; have 'long unsigned int(const long unsigned int *, long unsigned int)'
     154 | unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
         |               ^~~~~~~~~~~~~~
   include/linux/find.h:38:16: note: previous implicit declaration of 'find_first_bit' with type 'int()'
      38 |         from = find_first_bit(addr, to);
         |                ^~~~~~~~~~~~~~
   In file included from include/linux/mmzone.h:17,
                    from include/linux/gfp.h:6,
                    from include/linux/percpu-refcount.h:57,
                    from include/linux/slab.h:19,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/nodemask.h: In function '__next_node_in':
   include/linux/nodemask.h:281:61: error: 'n' undeclared (first use in this function)
     281 |         return find_next_bit_wrap(srcp->bits, MAX_NUMNODES, n+1, n+1);
         |                                                             ^
   include/linux/nodemask.h:281:61: note: each undeclared identifier is reported only once for each function it appears in
>> include/linux/nodemask.h:281:16: error: too many arguments to function 'find_next_bit_wrap'
     281 |         return find_next_bit_wrap(srcp->bits, MAX_NUMNODES, n+1, n+1);
         |                ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/bitmap.h:9,
                    from include/linux/cpumask.h:12,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:22,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/ktime.h:24,
                    from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/slab.h:18,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/find.h:52:15: note: declared here
      52 | unsigned long find_next_bit_wrap(const unsigned long *addr, unsigned long size,
         |               ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:117: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1200: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/find_next_bit_wrap +281 include/linux/nodemask.h

   273	
   274	/*
   275	 * Find the next present node in src, starting after node n, wrapping around to
   276	 * the first node in src if needed.  Returns MAX_NUMNODES if src is empty.
   277	 */
   278	#define next_node_in(n, src) __next_node_in((n), &(src))
   279	static inline unsigned int __next_node_in(int node, const nodemask_t *srcp)
   280	{
 > 281		return find_next_bit_wrap(srcp->bits, MAX_NUMNODES, n+1, n+1);
   282	}
   283	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

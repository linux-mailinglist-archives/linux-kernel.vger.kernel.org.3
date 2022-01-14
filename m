Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1BE48E453
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbiANGnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:43:32 -0500
Received: from mga03.intel.com ([134.134.136.65]:37892 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239399AbiANGnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642142611; x=1673678611;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=z5cPCFHmTD8/jiKEy8BLiYmqSxUyiszD9/cUiylII58=;
  b=OGhB/tU+DWFGeJKDqGUHblWMzPfqsC/EemHdxosYq52qZ8qqVzh8eBgc
   HGMjuFV0I2Im0z6g349vEja604AiRDOYTdlA9CncYmIja6/4C3qrt1yG3
   F1OVilk0UlIpsihFkJGCxMIYlTQ9YDCQpuwCYttKvNhSMKC6r03zWAggE
   nyiBXmCTKXeceHcZ2EyA66xjPjlD0dsxGH5c+MRyD+ZyoJBOxG4tGffyS
   VW5rNYMoEKK6tylx/6sE13g8vcFNJe/4CErcjBrJ9Fjf0zMGJiZN3J0Mm
   KZrHCZIrrfxK6mzgxGpfX4ES9XrXDG+Rkc79tEIZFkIqiz49mJvJlOkl0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="244149698"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="244149698"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 22:43:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="593628267"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jan 2022 22:43:28 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8GJ6-0008Cv-7X; Fri, 14 Jan 2022 06:43:28 +0000
Date:   Fri, 14 Jan 2022 14:42:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jens-wiklander-tee:testing/tuxbuild 5/13]
 drivers/tee/tee_shm_pool.c:17:13: warning: comparison of distinct pointer
 types ('typeof (align) *' (aka 'unsigned int *') and 'typeof (((((1UL))) <<
 (genpool->min_alloc_order))) *' (aka 'unsigned long *'))
Message-ID: <202201141423.k7Z21dOm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   http://git.linaro.org/people/jens.wiklander/linux-tee testing/tuxbuild
head:   9ea0d125d4c9a4144b8641c454e97406b483722d
commit: 5b552e1bc3780894781030500c0216a9e0bef3f8 [5/13] tee: simplify shm pool handling
config: hexagon-randconfig-r041-20220113 (https://download.01.org/0day-ci/archive/20220114/202201141423.k7Z21dOm-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 82c8aca93488730ce8f66101e0f3538f14b551dd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add jens-wiklander-tee http://git.linaro.org/people/jens.wiklander/linux-tee
        git fetch --no-tags jens-wiklander-tee testing/tuxbuild
        git checkout 5b552e1bc3780894781030500c0216a9e0bef3f8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/tee/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/tee/tee_shm_pool.c:17:13: warning: comparison of distinct pointer types ('typeof (align) *' (aka 'unsigned int *') and 'typeof (((((1UL))) << (genpool->min_alloc_order))) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
           size_t a = max(align, BIT(genpool->min_alloc_order));
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:52:19: note: expanded from macro 'max'
   #define max(x, y)       __careful_cmp(x, y, >)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   1 warning generated.


vim +17 drivers/tee/tee_shm_pool.c

    11	
    12	static int pool_op_gen_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
    13				     size_t size, size_t align)
    14	{
    15		unsigned long va;
    16		struct gen_pool *genpool = pool->private_data;
  > 17		size_t a = max(align, BIT(genpool->min_alloc_order));
    18		struct genpool_data_align data = { .align = a };
    19		size_t s = roundup(size, a);
    20	
    21		va = gen_pool_alloc_algo(genpool, s, gen_pool_first_fit_align, &data);
    22		if (!va)
    23			return -ENOMEM;
    24	
    25		memset((void *)va, 0, s);
    26		shm->kaddr = (void *)va;
    27		shm->paddr = gen_pool_virt_to_phys(genpool, va);
    28		shm->size = s;
    29		/*
    30		 * This is from a static shared memory pool so no need to register
    31		 * each chunk, and no need to unregister later either.
    32		 */
    33		shm->flags &= ~TEE_SHM_REGISTER;
    34		return 0;
    35	}
    36	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EB9479A19
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 11:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhLRKAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 05:00:43 -0500
Received: from mga07.intel.com ([134.134.136.100]:21439 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229632AbhLRKAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 05:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639821642; x=1671357642;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LuX2as4JMWdT21tsjom/hoLRUPwLC1tZPMkCGMK1WGE=;
  b=S1RZcd4HRK1Zv+kxkOzh+wB3qJiQHHk/DxaW60MiSsHEx+9QGTlDAdeR
   r8dwXHXX9w9Jagr2KKsP+ghmZdaTUQPY2oIFlY3vThVyzejj9sz7IYVps
   rEtw64XXNxnIRwEFatKwlTHMOgrjXj6Wcw9Sr4BnMBKzuUSUNqyCtIFMN
   GtxScbJhPvZ/PNNmwhHNMZfMJCj6sHY2ZUMIG9FtHx/df63tYse2S8/qU
   0LBRlTwXkbzG/nFCTK0XTgHbW7EloNv91Vf8ZExdumGX7GC1a+CLdfaUd
   WuIfIvtBNjj88fSZjGizDO+lGQmyDr2usA3Q5ypR4qzq3zkAo/flWcKe6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="303283448"
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="303283448"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 02:00:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="466798383"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 18 Dec 2021 02:00:41 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myWW8-0005r8-Aj; Sat, 18 Dec 2021 10:00:40 +0000
Date:   Sat, 18 Dec 2021 18:00:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [thomash:async_vma10 6/7]
 drivers/gpu/drm/i915/i915_vma_resource.c:379:39: error: format specifies
 type 'unsigned long' but the argument has type 'unsigned int'
Message-ID: <202112181745.36r8RZEy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://people.freedesktop.org/~thomash/linux async_vma10
head:   597bad76cbd833089ad27552582b3a0ac942f8ba
commit: 7a09f14a4d7a15d8b0568e527448617a72ee51e8 [6/7] drm/i915: Use vma resources for async unbinding
config: i386-randconfig-r011-20211216 (https://download.01.org/0day-ci/archive/20211218/202112181745.36r8RZEy-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 4c9e31a4814592bbda7153833e46728dc7b21100)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add thomash git://people.freedesktop.org/~thomash/linux
        git fetch --no-tags thomash async_vma10
        git checkout 7a09f14a4d7a15d8b0568e527448617a72ee51e8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/i915/i915_vma_resource.c:379:39: error: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Werror,-Wformat]
           pr_err("vma resource size is %lu\n", sizeof(struct i915_vma_resource));
                                        ~~~     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                        %u
   include/linux/printk.h:493:33: note: expanded from macro 'pr_err'
           printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
                                  ~~~     ^~~~~~~~~~~
   include/linux/printk.h:450:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:422:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   1 error generated.


vim +379 drivers/gpu/drm/i915/i915_vma_resource.c

   376	
   377	int __init i915_vma_resource_module_init(void)
   378	{
 > 379		pr_err("vma resource size is %lu\n", sizeof(struct i915_vma_resource));

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

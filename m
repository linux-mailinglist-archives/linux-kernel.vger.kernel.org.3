Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBEA473696
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240209AbhLMVfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:35:00 -0500
Received: from mga03.intel.com ([134.134.136.65]:12898 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233303AbhLMVe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:34:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639431298; x=1670967298;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RJc7pEH8Sy4NUdd6omExoUO3uJEj/K3Z8y4XqXiMlzE=;
  b=ilvE4PS0SRO3XIESXi7tIDDx2MlPsMOD1ihulWusche57XgJlRJQ3V4m
   uXcVqGheztyuN13UPJRpcoOfV4GfRslsuQ3EDuCRaYvXqQb1AEEuVMNaO
   TNBpBoZPVzpKvos7tp3i7jEQ4/N0hpGWtGdBNcio/qWgPnhU9tdZvOzpD
   hmuCDfWYl6BkJKkJ609VEfKcLp665MChYQmqKSsQhaPL3qFtzskOPMbSF
   albCW8cQwaZgDW3SQbxm7MiskDlhd/y2E8pmGFeLdIXNbOnu/g2nn24VT
   4X7QToKDbFqzb6Hcfsfra/KkvAHb7AJpYBx1plwXp1bdVYiRDIa5K3THh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="238781383"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="238781383"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 13:34:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="613984014"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 13 Dec 2021 13:34:56 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwsyG-00075b-5j; Mon, 13 Dec 2021 21:34:56 +0000
Date:   Tue, 14 Dec 2021 05:34:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kbuild-all@lists.01.org, wangkefeng.wang@huawei.com,
        weiyongjun1@huawei.com, linux-kernel@vger.kernel.org
Subject: [kevin78:percpu-cleanup 3/4] <command-line>: warning: format '%lx'
 expects argument of type 'long unsigned int', but argument 5 has type
 'phys_addr_t' {aka 'long long unsigned int'}
Message-ID: <202112140527.SRPXMPJU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/kevin78/linux.git percpu-cleanup
head:   ec8bef0e65982bb71c931efddde0fca6418e02ba
commit: c3ebf9a83e686d6d3dc8b571493219a64558d536 [3/4] mm: percpu: Add generic pcpu_fc_alloc/free funciton
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20211214/202112140527.SRPXMPJU-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/kevin78/linux/commit/c3ebf9a83e686d6d3dc8b571493219a64558d536
        git remote add kevin78 https://github.com/kevin78/linux.git
        git fetch --no-tags kevin78 percpu-cleanup
        git checkout c3ebf9a83e686d6d3dc8b571493219a64558d536
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/percpu.c: In function 'pcpu_fc_alloc':
>> <command-line>: warning: format '%lx' expects argument of type 'long unsigned int', but argument 5 has type 'phys_addr_t' {aka 'long long unsigned int'} [-Wformat=]
   mm/percpu.c:69:21: note: in expansion of macro 'KBUILD_MODNAME'
      69 | #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
         |                     ^~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in expansion of macro 'pr_fmt'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:152:9: note: in expansion of macro '__dynamic_func_call'
     152 |         __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_func_call'
     162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:574:9: note: in expansion of macro 'dynamic_pr_debug'
     574 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   mm/percpu.c:3011:17: note: in expansion of macro 'pr_debug'
    3011 |                 pr_debug("per cpu data for cpu%d %lu bytes at %016lx\n",
         |                 ^~~~~~~~
   <command-line>: warning: format '%lx' expects argument of type 'long unsigned int', but argument 6 has type 'phys_addr_t' {aka 'long long unsigned int'} [-Wformat=]
   mm/percpu.c:69:21: note: in expansion of macro 'KBUILD_MODNAME'
      69 | #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
         |                     ^~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in expansion of macro 'pr_fmt'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:152:9: note: in expansion of macro '__dynamic_func_call'
     152 |         __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_func_call'
     162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:574:9: note: in expansion of macro 'dynamic_pr_debug'
     574 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   mm/percpu.c:3018:17: note: in expansion of macro 'pr_debug'
    3018 |                 pr_debug("per cpu data for cpu%d %lu bytes on node%d at %016lx\n",
         |                 ^~~~~~~~

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF184902FE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbiAQHi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:38:29 -0500
Received: from mga05.intel.com ([192.55.52.43]:2026 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237582AbiAQHi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642405108; x=1673941108;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Zved+1luvwAvJlvtMjwPMjVVFJImLNxrs1+SJq8VYew=;
  b=UTWgcygI0z6a+E7kywstOT4D03CaJdSxdpTnejo2x+sETeq7VkUUBBWb
   Kd5+/VP0+krTZTGoM2XX04RbfXUZ5PhYpmBw7OcjOwhzvaxvrOqMC5DqE
   9MWXeozWGBW2V9T94Dy0QLXrninp8+l3P1VnDPzH0P2TGJJNz1npiHOBw
   CG0LLtSKE5GRvdmIXANootduQG+UvIfRsEJ0hcHrGb0MBnZ0yzG7Lj6uX
   JEa3HLGg9Y2+K/ptNlndCErsD/G1bx55ZkAmp8egvgOYUAqGfo1THCumL
   ugq6helM6CwuK3OcJaWYxHOPCSRGW7LulKI3NmPajgdOJ6H9AK7mUsOK0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="330921398"
X-IronPort-AV: E=Sophos;i="5.88,295,1635231600"; 
   d="scan'208";a="330921398"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 23:38:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,295,1635231600"; 
   d="scan'208";a="577963593"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jan 2022 23:38:26 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9Maw-000BM2-8R; Mon, 17 Jan 2022 07:38:26 +0000
Date:   Mon, 17 Jan 2022 15:38:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 203/2384] kernel/kcsan/permissive.h:31:26:
 error: no member named 'flags' in 'struct task_struct'
Message-ID: <202201171545.dO2soyng-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: 762c0e5e35546dcaccb201e1e3dae69e34f7733b [203/2384] headers/deps: Move task_struct::flags to per_task()
config: x86_64-randconfig-c007 (https://download.01.org/0day-ci/archive/20220117/202201171545.dO2soyng-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c63a3175c2947e8c1a2d3bbe16a8586600705c54)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=762c0e5e35546dcaccb201e1e3dae69e34f7733b
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 762c0e5e35546dcaccb201e1e3dae69e34f7733b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/kcsan/core.c:25:
>> kernel/kcsan/permissive.h:31:26: error: no member named 'flags' in 'struct task_struct'
           return ptr == &current->flags;
                          ~~~~~~~  ^
   1 error generated.


vim +31 kernel/kcsan/permissive.h

49f72d5358dd3c Marco Elver 2021-06-07  18  
49f72d5358dd3c Marco Elver 2021-06-07  19  /*
49f72d5358dd3c Marco Elver 2021-06-07  20   * Access ignore rules based on address.
49f72d5358dd3c Marco Elver 2021-06-07  21   */
49f72d5358dd3c Marco Elver 2021-06-07  22  static __always_inline bool kcsan_ignore_address(const volatile void *ptr)
49f72d5358dd3c Marco Elver 2021-06-07  23  {
49f72d5358dd3c Marco Elver 2021-06-07  24  	if (!IS_ENABLED(CONFIG_KCSAN_PERMISSIVE))
49f72d5358dd3c Marco Elver 2021-06-07  25  		return false;
49f72d5358dd3c Marco Elver 2021-06-07  26  
d8fd74d35a8d3c Marco Elver 2021-06-07  27  	/*
d8fd74d35a8d3c Marco Elver 2021-06-07  28  	 * Data-racy bitops on current->flags are too common, ignore completely
d8fd74d35a8d3c Marco Elver 2021-06-07  29  	 * for now.
d8fd74d35a8d3c Marco Elver 2021-06-07  30  	 */
d8fd74d35a8d3c Marco Elver 2021-06-07 @31  	return ptr == &current->flags;
49f72d5358dd3c Marco Elver 2021-06-07  32  }
49f72d5358dd3c Marco Elver 2021-06-07  33  

:::::: The code at line 31 was first introduced by commit
:::::: d8fd74d35a8d3c602232e3238e916bda9d03d520 kcsan: permissive: Ignore data-racy 1-bit value changes

:::::: TO: Marco Elver <elver@google.com>
:::::: CC: Paul E. McKenney <paulmck@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

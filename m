Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE9A488641
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 22:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiAHVUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 16:20:15 -0500
Received: from mga05.intel.com ([192.55.52.43]:38033 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbiAHVUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 16:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641676812; x=1673212812;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ur+RHZ2uYfVNTbYuazwnYsitFHH8JK7Y6Ggp5nKyGCk=;
  b=aUttaLhGDkLLYeXcw3oWs2KeYps+kvib6q9xf6swE0b6ti3uOrhLtZWP
   /Rxcj5C837axIcH5C4f2AVwv2lAWSchTYAQOjYJS6DuHA+IvTfBNPt2WP
   YcCGIMuLIq+dUVm99GZ+BbxeijIV9WRlTAXneg67/odzeLz+mS3T7warj
   QOiyV+/EyWybLneQh7Qq2Blq0dpGNpzYTguYgCS8FS4TlZ7qM893xbPBW
   4bZ1EMoB6ySHHAOzu9EkaIFY/wO+bSArtw7EGK2Ua06rd0xffqxjkz/+x
   Q/sT9DBq0Ow2RFeX2LMlfLaCQidFQdD7nksXwFhUB3e2Obp6ct7DbVvbQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="329382337"
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="329382337"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 13:20:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="764176364"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jan 2022 13:20:10 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6J8E-00014H-9F; Sat, 08 Jan 2022 21:20:10 +0000
Date:   Sun, 9 Jan 2022 05:19:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 203/2375] kernel/kcsan/permissive.h:31:26:
 error: no member named 'flags' in 'struct task_struct'
Message-ID: <202201090555.OpViV38G-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   351ceeab2ef96ab2fc306934ddb201b44636181b
commit: 6d8683d081e753b3921879e105659a4bcfd9c08c [203/2375] headers/deps: Move task_struct::flags to per_task()
config: x86_64-buildonly-randconfig-r004-20220108 (https://download.01.org/0day-ci/archive/20220109/202201090555.OpViV38G-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f3a344d2125fa37e59bae1b0874442c650a19607)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=6d8683d081e753b3921879e105659a4bcfd9c08c
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 6d8683d081e753b3921879e105659a4bcfd9c08c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847CE488425
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 16:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbiAHPKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 10:10:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:47642 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbiAHPJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 10:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641654599; x=1673190599;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=egaIQ5m9qoPJm/1lBOuR354trcJguGwR8zwQdgNNxWU=;
  b=dY+0h/XATObOxObKqooHKNJgwKFCkDhWn7GoZP6EDPIxqfOo7KsnuxXL
   ZeacK5QJY6F4EGlVFgmOfyRDXr4Mx6jTb6jh47ksFKkfP1fqK1biKA9bz
   jPonNcq6UH9aXu7mKqpu0y/0yNhW+N7FUAwNpgcWeK1mBTmcrU1yR+MmC
   wIzKATGFQXBmyUrOuC1k+TidR1eg+37yxBu7TrBfTV0e3x7jSRN6R5JRz
   QrDkSyLjmEOlcGLA8x3M38TX76G8xizKDw5bHun1fLGn4F2EAMeoSr0H5
   aM5uCiHDwqB43WVizdLqgoNUfzL3yrtnT9tKa5T/fqqa3f3M0EQgYZGZF
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="240569967"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="240569967"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 07:09:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="471615046"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Jan 2022 07:09:58 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6DLx-0000iu-HZ; Sat, 08 Jan 2022 15:09:57 +0000
Date:   Sat, 8 Jan 2022 23:09:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1933/2300] drivers/infiniband/ulp/srp/ib_srp.c:75:
 warning: "DEFINE_DYNAMIC_DEBUG_METADATA" redefined
Message-ID: <202201082344.172v62OJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   4e348e961395297bb17f101cc63bc133d8a348e9
commit: 545982ee482536cdce1a96526ba2ccefe94188c6 [1933/2300] headers/deps: Optimize <linux/jump_label.h>, remove the <linux/atomic_api.h> inclusion in the CONFIG_JUMP_LABEL=y case
config: i386-randconfig-a014-20220108 (https://download.01.org/0day-ci/archive/20220108/202201082344.172v62OJ-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=545982ee482536cdce1a96526ba2ccefe94188c6
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 545982ee482536cdce1a96526ba2ccefe94188c6
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/infiniband/ulp/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/infiniband/ulp/srp/ib_srp.c:75: warning: "DEFINE_DYNAMIC_DEBUG_METADATA" redefined
      75 | #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)
         | 
   In file included from include/linux/dev_printk.h:16,
                    from include/linux/device_types.h:19,
                    from include/linux/device_api.h:15,
                    from include/linux/device_api_lock.h:5,
                    from include/linux/fwnode.h:12,
                    from include/linux/logic_pio.h:11,
                    from include/asm-generic/io.h:526,
                    from arch/x86/include/asm/io.h:377,
                    from include/linux/scatterlist_api.h:12,
                    from drivers/infiniband/ulp/srp/ib_srp.c:38:
   include/linux/dynamic_debug.h:90: note: this is the location of the previous definition
      90 | #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)  \
         | 
>> drivers/infiniband/ulp/srp/ib_srp.c:76: warning: "DYNAMIC_DEBUG_BRANCH" redefined
      76 | #define DYNAMIC_DEBUG_BRANCH(descriptor) false
         | 
   In file included from include/linux/dev_printk.h:16,
                    from include/linux/device_types.h:19,
                    from include/linux/device_api.h:15,
                    from include/linux/device_api_lock.h:5,
                    from include/linux/fwnode.h:12,
                    from include/linux/logic_pio.h:11,
                    from include/asm-generic/io.h:526,
                    from arch/x86/include/asm/io.h:377,
                    from include/linux/scatterlist_api.h:12,
                    from drivers/infiniband/ulp/srp/ib_srp.c:38:
   include/linux/dynamic_debug.h:113: note: this is the location of the previous definition
     113 | #define DYNAMIC_DEBUG_BRANCH(descriptor) \
         | 


vim +/DEFINE_DYNAMIC_DEBUG_METADATA +75 drivers/infiniband/ulp/srp/ib_srp.c

aef9ec39c47f0c Roland Dreier   2005-11-02  73  
1a1faf7a8a251d Bart Van Assche 2016-11-21  74  #if !defined(CONFIG_DYNAMIC_DEBUG)
1a1faf7a8a251d Bart Van Assche 2016-11-21 @75  #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)
1a1faf7a8a251d Bart Van Assche 2016-11-21 @76  #define DYNAMIC_DEBUG_BRANCH(descriptor) false
1a1faf7a8a251d Bart Van Assche 2016-11-21  77  #endif
1a1faf7a8a251d Bart Van Assche 2016-11-21  78  

:::::: The code at line 75 was first introduced by commit
:::::: 1a1faf7a8a251d134d375b7783a614ee79e932f2 IB/srp: Fix CONFIG_DYNAMIC_DEBUG=n build

:::::: TO: Bart Van Assche <bart.vanassche@sandisk.com>
:::::: CC: Doug Ledford <dledford@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

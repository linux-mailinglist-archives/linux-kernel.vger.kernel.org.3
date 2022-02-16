Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9184B82F0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiBPI1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:27:47 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiBPI1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:27:44 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950D3CA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645000052; x=1676536052;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dA/rS+M9aCB3qdQBqlUeUkzdz4VMGgfW2hykH5H4eMU=;
  b=BrBiPeucQcrsoeLCtGgX8qGOSdMxJTiuC/J4dgaY8ijqQj9bTb4yzjWO
   6ey493Ft9WEi6seRzg1FjEyIXOcWDQhqLEoWLCh2PFcCg7t5LWIEw+c2L
   LYZZo/9EEEv2AcBOdhcsNpeUCniHexJC1oUoHglGBY97gvmXkZjVNIDOb
   zVU0aos3Dtwg6sC8OGJ2eVO9JYj/Gvn75H/vkyzxX4p1FcHLs/fyLZ1Gc
   Q7xfTICnaBzQ2kE4KlSVAF9ZnnHepP/G1TLA4AG7gcb9ZaeZgXbcPgY7c
   IxSpCi8odWPW6Lb1iC3zV6+NVTvgZ5m65iWaMBoQwBUCa0OxsqypK53VG
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="275131378"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="275131378"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 00:27:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="704207154"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Feb 2022 00:27:30 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKFes-000Abt-1A; Wed, 16 Feb 2022 08:27:30 +0000
Date:   Wed, 16 Feb 2022 16:26:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arnd-playground:set_fs-2 12/17] lib/test_lockup.c:422:13: sparse:
 sparse: incorrect type in initializer (different address spaces)
Message-ID: <202202161630.LUggdKp0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git set_fs-2
head:   cb5b88c78bb9c229c93bf11ea66d622a3ba4bf2d
commit: 5c46fbe679aaca0b693101e743e46ba571403b7c [12/17] uaccess: fix type mismatch warnings from access_ok()
config: mips-randconfig-s031-20220216 (https://download.01.org/0day-ci/archive/20220216/202202161630.LUggdKp0-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?id=5c46fbe679aaca0b693101e743e46ba571403b7c
        git remote add arnd-playground https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
        git fetch --no-tags arnd-playground set_fs-2
        git checkout 5c46fbe679aaca0b693101e743e46ba571403b7c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> lib/test_lockup.c:422:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gk_ptr @@     got void [noderef] __user *ptr @@
   lib/test_lockup.c:422:13: sparse:     expected char const *__gk_ptr
   lib/test_lockup.c:422:13: sparse:     got void [noderef] __user *ptr
>> lib/test_lockup.c:423:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gk_ptr @@     got void [noderef] __user * @@
   lib/test_lockup.c:423:13: sparse:     expected char const *__gk_ptr
   lib/test_lockup.c:423:13: sparse:     got void [noderef] __user *
   lib/test_lockup.c:230:9: sparse: sparse: context imbalance in 'test_lock' - wrong count at exit
   lib/test_lockup.c:250:25: sparse: sparse: context imbalance in 'test_unlock' - unexpected unlock

vim +422 lib/test_lockup.c

30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  410  
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  411  static bool test_kernel_ptr(unsigned long addr, int size)
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  412  {
5c46fbe679aaca Arnd Bergmann         2022-02-14  413  	void __user *ptr = (void __user *)addr;
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  414  	char buf;
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  415  
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  416  	if (!addr)
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  417  		return false;
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  418  
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  419  	/* should be at least readable kernel address */
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  420  	if (access_ok(ptr, 1) ||
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  421  	    access_ok(ptr + size - 1, 1) ||
25f12ae45fc193 Christoph Hellwig     2020-06-17 @422  	    get_kernel_nofault(buf, ptr) ||
25f12ae45fc193 Christoph Hellwig     2020-06-17 @423  	    get_kernel_nofault(buf, ptr + size - 1)) {
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  424  		pr_err("invalid kernel ptr: %#lx\n", addr);
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  425  		return true;
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  426  	}
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  427  
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  428  	return false;
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  429  }
30428ef5d1e8ca Konstantin Khlebnikov 2020-04-06  430  

:::::: The code at line 422 was first introduced by commit
:::::: 25f12ae45fc1931a1dce3cc59f9989a9d87834b0 maccess: rename probe_kernel_address to get_kernel_nofault

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

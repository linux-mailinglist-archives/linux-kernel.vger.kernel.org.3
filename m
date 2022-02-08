Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C13F4ACDE7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245517AbiBHBTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343998AbiBHBTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:19:16 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FA2C03FED0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 17:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644282604; x=1675818604;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RtrIuk6XnpXK6Bn1icYdRFqEsnH8wSVRifepjc0UwCM=;
  b=HSMA8706Z5Ysy9qsyZNPzPIgfiA5m9RxO/48hLo5JQZiGr7ICNF4d4Az
   RGpdoS/FJjOkhaE8THlql55ISwSsDXhVr4ONbuA77EItul7k9BoDfcxp3
   V4zZdDY0PD2R6Ja4EG9cDpSdMhFPOu9aQhOB148bV7uFyNNDdWVoYduhY
   DT1nVLEGgZ9yJjD5EMvfM97xNyN13XjnLVZBFfzn8atC5AtSvrg5tF0tC
   w+2I/LCBrv1feR3EBOb5vAXSUujo8ATav1MsiFhgX8Iy32nBQfr0QSkLq
   AaSDiTppH8sjprHEe7HY/E4z2wBTIjzUpGipjCpKyxDNGb54Jwg3uR6Pt
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="232411085"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="232411085"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 17:09:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="567676656"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Feb 2022 17:09:03 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHF0B-00019s-3r; Tue, 08 Feb 2022 01:09:03 +0000
Date:   Tue, 8 Feb 2022 09:08:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mahendran Ganesh <opensource.ganesh@gmail.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-gs-raviole-5.10-android12-qpr1-d
 1711/8858] arch/arm64/mm/fault.c:492:31: sparse: sparse: incorrect type in
 return expression (different base types)
Message-ID: <202202080945.Pweq3bsl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-gs-raviole-5.10-android12-qpr1-d
head:   9771767708df4fcf51cd1642e041c804a86e740c
commit: 2fd69fa6bcab984b56ccfd4860b10f11f1966bed [1711/8858] FROMLIST: arm64/mm: add speculative page fault
config: arm64-randconfig-s031-20220207 (https://download.01.org/0day-ci/archive/20220208/202202080945.Pweq3bsl-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/2fd69fa6bcab984b56ccfd4860b10f11f1966bed
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-gs-raviole-5.10-android12-qpr1-d
        git checkout 2fd69fa6bcab984b56ccfd4860b10f11f1966bed
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/arm64/mm/fault.c:492:31: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted vm_fault_t @@
   arch/arm64/mm/fault.c:492:31: sparse:     expected int
   arch/arm64/mm/fault.c:492:31: sparse:     got restricted vm_fault_t
   arch/arm64/mm/fault.c:561:15: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted vm_fault_t [usertype] fault @@     got int @@
   arch/arm64/mm/fault.c:561:15: sparse:     expected restricted vm_fault_t [usertype] fault
   arch/arm64/mm/fault.c:561:15: sparse:     got int
   arch/arm64/mm/fault.c:591:15: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted vm_fault_t [usertype] fault @@     got int @@
   arch/arm64/mm/fault.c:591:15: sparse:     expected restricted vm_fault_t [usertype] fault
   arch/arm64/mm/fault.c:591:15: sparse:     got int
   arch/arm64/mm/fault.c:620:13: sparse: sparse: restricted vm_fault_t degrades to integer
   arch/arm64/mm/fault.c:620:13: sparse: sparse: restricted vm_fault_t degrades to integer
   arch/arm64/mm/fault.c:665:39: sparse: sparse: restricted vm_fault_t degrades to integer

vim +492 arch/arm64/mm/fault.c

1d18c47c735e8a Catalin Marinas   2012-03-05  471  
1d18c47c735e8a Catalin Marinas   2012-03-05  472  	if (unlikely(!vma))
4745224b45097d Anshuman Khandual 2019-06-07  473  		return VM_FAULT_BADMAP;
1d18c47c735e8a Catalin Marinas   2012-03-05  474  
1d18c47c735e8a Catalin Marinas   2012-03-05  475  	/*
1d18c47c735e8a Catalin Marinas   2012-03-05  476  	 * Ok, we have a good vm_area for this memory access, so we can handle
1d18c47c735e8a Catalin Marinas   2012-03-05  477  	 * it.
1d18c47c735e8a Catalin Marinas   2012-03-05  478  	 */
4745224b45097d Anshuman Khandual 2019-06-07  479  	if (unlikely(vma->vm_start > addr)) {
4745224b45097d Anshuman Khandual 2019-06-07  480  		if (!(vma->vm_flags & VM_GROWSDOWN))
4745224b45097d Anshuman Khandual 2019-06-07  481  			return VM_FAULT_BADMAP;
4745224b45097d Anshuman Khandual 2019-06-07  482  		if (expand_stack(vma, addr))
4745224b45097d Anshuman Khandual 2019-06-07  483  			return VM_FAULT_BADMAP;
4745224b45097d Anshuman Khandual 2019-06-07  484  	}
4745224b45097d Anshuman Khandual 2019-06-07  485  
db6f41063cbdb5 Will Deacon       2013-07-19  486  	/*
db6f41063cbdb5 Will Deacon       2013-07-19  487  	 * Check that the permissions on the VMA allow for the fault which
cab15ce604e550 Catalin Marinas   2016-08-11  488  	 * occurred.
db6f41063cbdb5 Will Deacon       2013-07-19  489  	 */
4745224b45097d Anshuman Khandual 2019-06-07  490  	if (!(vma->vm_flags & vm_flags))
4745224b45097d Anshuman Khandual 2019-06-07  491  		return VM_FAULT_BADACCESS;
6a1bb025d28e10 Peter Xu          2020-08-11 @492  	return handle_mm_fault(vma, addr & PAGE_MASK, mm_flags, regs);
1d18c47c735e8a Catalin Marinas   2012-03-05  493  }
1d18c47c735e8a Catalin Marinas   2012-03-05  494  

:::::: The code at line 492 was first introduced by commit
:::::: 6a1bb025d28e1026fead73b7b33e2dfccba3f4d2 mm/arm64: use general page fault accounting

:::::: TO: Peter Xu <peterx@redhat.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

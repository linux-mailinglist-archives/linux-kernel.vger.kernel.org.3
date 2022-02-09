Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301D54AF09F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbiBIMDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiBIMDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:03:10 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472C4C0401E6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 03:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644406487; x=1675942487;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Em5A+ej455tm5t+/Qxjvx4NvKWVn+YggF6vVxioP5+s=;
  b=hrwMlMDBe1kU/yyu2meN6MbAQX908bskwXN6fPO/s9u94y6ICS2vQDXW
   kna3Iy5ZLP61YyRJfVXSUdset++EurMNIiOq6G67MB0bLq5s1WD3wuFF/
   iqbhoIoqGBftxIxDhGRdDolV/IOYp+uHJ71UfnYf1GPOCEOm+r4tuaEBx
   GH2IN62ipw+LrIc3c+oMGms4CiGBN9TP+g+SnP7Rc0eu0Bcp/iLVTEagl
   yWwEZzY7WnDNC74NOaF5cQ/lNV95KXfw9ZAuYbnih8EdCpUl4fbp6tNi0
   +WJ+v13iDESUS8QChCpLNL4n9ZMcuKDNFe1cKdhzbiHt1OD/9RmJ8flF/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="248943499"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="248943499"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 03:34:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="525954504"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Feb 2022 03:34:44 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHlFE-0001jw-03; Wed, 09 Feb 2022 11:34:44 +0000
Date:   Wed, 9 Feb 2022 19:34:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/infiniband/hw/ocrdma/ocrdma.h:499:21: sparse: sparse: cast
 to restricted __le32
Message-ID: <202202091914.WouzjlIJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e6251ab4551f51fa4cee03523e08051898c3ce82
commit: d991bb1c8da842a2a0b9dc83b1005e655783f861 include/linux/compiler-gcc.h: sparse can do constant folding of __builtin_bswap*()
date:   10 months ago
config: mips-randconfig-s031-20220209 (https://download.01.org/0day-ci/archive/20220209/202202091914.WouzjlIJ-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d991bb1c8da842a2a0b9dc83b1005e655783f861
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d991bb1c8da842a2a0b9dc83b1005e655783f861
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash drivers/infiniband/

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
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:831:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] pa_lo @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:831:28: sparse:     expected unsigned int [usertype] pa_lo
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:831:28: sparse:     got restricted __le32 [usertype]
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:832:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] pa_hi @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:832:28: sparse:     expected unsigned int [usertype] pa_hi
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:832:28: sparse:     got restricted __le32 [usertype]
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:1632:44: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2072:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] pa_lo @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2072:28: sparse:     expected unsigned int [usertype] pa_lo
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2072:28: sparse:     got restricted __le32 [usertype]
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2073:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] pa_hi @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2073:28: sparse:     expected unsigned int [usertype] pa_hi
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2073:28: sparse:     got restricted __le32 [usertype]
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2421:18: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2452:44: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2452:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flags_status_srcqpn @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2452:42: sparse:     expected unsigned int [usertype] flags_status_srcqpn
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2452:42: sparse:     got restricted __le32 [usertype]
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2455:44: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2455:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flags_status_srcqpn @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2455:42: sparse:     expected unsigned int [usertype] flags_status_srcqpn
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2455:42: sparse:     got restricted __le32 [usertype]
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2461:52: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2461:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flags_status_srcqpn @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2461:50: sparse:     expected unsigned int [usertype] flags_status_srcqpn
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2461:50: sparse:     got restricted __le32 [usertype]
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2464:52: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2464:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flags_status_srcqpn @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2464:50: sparse:     expected unsigned int [usertype] flags_status_srcqpn
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2464:50: sparse:     got restricted __le32 [usertype]
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2469:52: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2469:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flags_status_srcqpn @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2469:50: sparse:     expected unsigned int [usertype] flags_status_srcqpn
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2469:50: sparse:     got restricted __le32 [usertype]
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2472:52: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2472:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flags_status_srcqpn @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2472:50: sparse:     expected unsigned int [usertype] flags_status_srcqpn
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2472:50: sparse:     got restricted __le32 [usertype]
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2528:23: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2583:20: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2598:19: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2614:19: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2616:24: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2620:27: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2625:29: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2644:20: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2703:34: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2706:37: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2710:37: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2713:44: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2732:27: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2736:27: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:2780:24: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c: note: in included file:
>> drivers/infiniband/hw/ocrdma/ocrdma.h:499:21: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma.h:505:17: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c: note: in included file:
   drivers/infiniband/hw/ocrdma/ocrdma_hw.h:55:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 @@
   drivers/infiniband/hw/ocrdma/ocrdma_hw.h:55:32: sparse:     expected unsigned int [usertype]
   drivers/infiniband/hw/ocrdma/ocrdma_hw.h:55:32: sparse:     got restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_hw.h:55:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 @@
   drivers/infiniband/hw/ocrdma/ocrdma_hw.h:55:32: sparse:     expected unsigned int [usertype]
   drivers/infiniband/hw/ocrdma/ocrdma_hw.h:55:32: sparse:     got restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c: note: in included file:
   drivers/infiniband/hw/ocrdma/ocrdma.h:505:17: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma.h:517:17: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma.h:523:17: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma.h:511:17: sparse: sparse: cast to restricted __le32
>> drivers/infiniband/hw/ocrdma/ocrdma.h:499:21: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/ocrdma/ocrdma.h:505:17: sparse: sparse: cast to restricted __le32

vim +499 drivers/infiniband/hw/ocrdma/ocrdma.h

fe2caefcdf5869 Parav Pandit        2012-03-21  495  
df176ea0743fd0 Naresh Gottumukkala 2013-06-10  496  static inline int is_cqe_valid(struct ocrdma_cq *cq, struct ocrdma_cqe *cqe)
df176ea0743fd0 Naresh Gottumukkala 2013-06-10  497  {
df176ea0743fd0 Naresh Gottumukkala 2013-06-10  498  	int cqe_valid;
df176ea0743fd0 Naresh Gottumukkala 2013-06-10 @499  	cqe_valid = le32_to_cpu(cqe->flags_status_srcqpn) & OCRDMA_CQE_VALID;
f99b1649dbb634 Naresh Gottumukkala 2013-08-07  500  	return (cqe_valid == cq->phase);
df176ea0743fd0 Naresh Gottumukkala 2013-06-10  501  }
df176ea0743fd0 Naresh Gottumukkala 2013-06-10  502  

:::::: The code at line 499 was first introduced by commit
:::::: df176ea0743fd0fb0514c862797f6bd8c08ab42e RDMA/ocrdma: Change macros to inline funtions

:::::: TO: Naresh Gottumukkala <bgottumukkala@emulex.com>
:::::: CC: Roland Dreier <roland@purestorage.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

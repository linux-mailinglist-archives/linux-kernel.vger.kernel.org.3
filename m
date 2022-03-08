Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7044D212D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbiCHTPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiCHTPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:15:36 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3774E394
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646766880; x=1678302880;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L+gpSj+pPQl5DMIPXZmQxYL82Vfx6CAWAydGcCei1i8=;
  b=Kjp33i2EefYq3OqwRIPStZIx8gLeR6m+ZTamPD8lnIW5bHm6jh5qYwmV
   xnFanq4B1c+hHXspaRscyMnZ39zE/D7Jw/WQFc8g/i7XlJt6ROtBvOKMr
   Wj96m78ErrGtwNkvPQ+x1+ndiUMc5tZqh0aoN9w+apZcmKKT8DBgqzPX7
   JGz23oo9am+uGIJHgm7NG3aWITkxyqDBPhwHS9bdZhkOeSXjzR5LxHr3x
   BSCnsUBa8TonnB8TPDhW6TwMfMu/wPMdG8iObdsknRET1YNlb/e3CQrUV
   LaQklI/5ahFpdmBSDI5q72hBqzssmO1q9qGrvm6H0499GmG12yMYbJtNA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254979829"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="254979829"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 11:14:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="495570750"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2022 11:14:36 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRfI3-0001rE-IT; Tue, 08 Mar 2022 19:14:35 +0000
Date:   Wed, 9 Mar 2022 03:14:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: include/linux/pgtable.h:257:16: sparse: sparse: cast to non-scalar
Message-ID: <202203090359.xgOwYxvo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ea4424be16887a37735d6550cfd0611528dbe5d9
commit: b99a342d4f11a5455d999b12f5fee42ab6acaf8c NUMA balancing: reduce TLB flush via delaying mapping on hint page fault
date:   10 months ago
config: alpha-randconfig-s031-20220308 (https://download.01.org/0day-ci/archive/20220309/202203090359.xgOwYxvo-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b99a342d4f11a5455d999b12f5fee42ab6acaf8c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b99a342d4f11a5455d999b12f5fee42ab6acaf8c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   mm/memory.c:949:17: sparse: sparse: context imbalance in 'copy_pte_range' - different lock contexts for basic block
   mm/memory.c:1629:16: sparse: sparse: context imbalance in '__get_locked_pte' - different lock contexts for basic block
   mm/memory.c:1678:9: sparse: sparse: context imbalance in 'insert_page' - different lock contexts for basic block
   mm/memory.c:2180:17: sparse: sparse: context imbalance in 'remap_pte_range' - different lock contexts for basic block
   mm/memory.c:2436:17: sparse: sparse: context imbalance in 'apply_to_pte_range' - unexpected unlock
   mm/memory.c:2692:17: sparse: sparse: context imbalance in 'wp_page_copy' - unexpected unlock
   mm/memory.c:3038:17: sparse: sparse: context imbalance in 'wp_pfn_shared' - unexpected unlock
   mm/memory.c:3101:19: sparse: sparse: context imbalance in 'do_wp_page' - different lock contexts for basic block
   mm/memory.c: note: in included file (through include/linux/mm.h, arch/alpha/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
>> include/linux/pgtable.h:257:16: sparse: sparse: cast to non-scalar
>> include/linux/pgtable.h:257:16: sparse: sparse: cast from non-scalar
   mm/memory.c:4660:5: sparse: sparse: context imbalance in 'follow_invalidate_pte' - different lock contexts for basic block
   mm/memory.c:4781:9: sparse: sparse: context imbalance in 'follow_pfn' - unexpected unlock

vim +257 include/linux/pgtable.h

e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  253  
481e980a7c199c include/linux/pgtable.h       Christophe Leroy 2020-06-15  254  #ifndef __HAVE_ARCH_PTEP_GET
481e980a7c199c include/linux/pgtable.h       Christophe Leroy 2020-06-15  255  static inline pte_t ptep_get(pte_t *ptep)
481e980a7c199c include/linux/pgtable.h       Christophe Leroy 2020-06-15  256  {
481e980a7c199c include/linux/pgtable.h       Christophe Leroy 2020-06-15 @257  	return READ_ONCE(*ptep);
481e980a7c199c include/linux/pgtable.h       Christophe Leroy 2020-06-15  258  }
481e980a7c199c include/linux/pgtable.h       Christophe Leroy 2020-06-15  259  #endif
481e980a7c199c include/linux/pgtable.h       Christophe Leroy 2020-06-15  260  

:::::: The code at line 257 was first introduced by commit
:::::: 481e980a7c199c5a4634fd7ea308067dd4ba75fa mm: Allow arches to provide ptep_get()

:::::: TO: Christophe Leroy <christophe.leroy@csgroup.eu>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

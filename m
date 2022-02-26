Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94904C5543
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 11:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiBZKva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 05:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiBZKv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 05:51:28 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8F31C2F7D
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 02:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645872651; x=1677408651;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8FQzQ58GKeyFQZYqqn6L2zsbnBTTBgBmNi/95u0hIuA=;
  b=ScARUjQNIIIIGzkZp2Xgry60satu9jBsFdZm4uxzIR0S/emi+1GeKWej
   ztt3J+sBUJLpqk5R3HVs1drGlC7pOQfJlfluu/paZh4RpqGA/H/v6c2J7
   AjqWJGEjS6xv9QwL+zXb48Lt9v9OkucVlTxvolelRHemPcQ6JaBmxVIy/
   pPfGviCf+A9OPqHsWkCjTknjqCJXiljgg5C81J3zZ7JYJJYf0/BxjjWIp
   uEbJOiQQjU2y09hHbMpanOZYVYw7aJgPd/C9rNrcxlxu/wgamzW3U9Yev
   kSdAXRyas6xX950urXoE/RCw9LzxYFUmSiKzlGtIXzZhBPwbF4YYmTBxC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="252379596"
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="252379596"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 02:50:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="640398491"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Feb 2022 02:50:47 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNuf0-0005OF-UE; Sat, 26 Feb 2022 10:50:46 +0000
Date:   Sat, 26 Feb 2022 18:50:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [ammarfaizi2-block:next/linux-next/master 127/370]
 arch/xtensa/mm/init.c:220:10: error: redefinition of 'vm_get_page_prot'
Message-ID: <202202261831.AGgPQFZ9-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block next/linux-next/master
head:   06aeb1495c39c86ccfaf1adadc1d2200179f16eb
commit: 1e2bfe0a0db508e2169bf8d45a8331d430c3a58c [127/370] extensa/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
config: xtensa-nommu_kc705_defconfig (https://download.01.org/0day-ci/archive/20220226/202202261831.AGgPQFZ9-lkp@intel.com/config)
compiler: xtensa-de212-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/1e2bfe0a0db508e2169bf8d45a8331d430c3a58c
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block next/linux-next/master
        git checkout 1e2bfe0a0db508e2169bf8d45a8331d430c3a58c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/xtensa/mm/init.c:220:10: error: redefinition of 'vm_get_page_prot'
     220 | pgprot_t vm_get_page_prot(unsigned long vm_flags)
         |          ^~~~~~~~~~~~~~~~
   In file included from include/linux/memblock.h:12,
                    from arch/xtensa/mm/init.c:21:
   include/linux/mm.h:2838:24: note: previous definition of 'vm_get_page_prot' with type 'pgprot_t(long unsigned int)'
    2838 | static inline pgprot_t vm_get_page_prot(unsigned long vm_flags)
         |                        ^~~~~~~~~~~~~~~~
   arch/xtensa/mm/init.c: In function 'vm_get_page_prot':
>> arch/xtensa/mm/init.c:232:24: error: 'PAGE_READONLY_EXEC' undeclared (first use in this function); did you mean 'PAGE_READONLY'?
     232 |                 return PAGE_READONLY_EXEC;
         |                        ^~~~~~~~~~~~~~~~~~
         |                        PAGE_READONLY
   arch/xtensa/mm/init.c:232:24: note: each undeclared identifier is reported only once for each function it appears in
>> arch/xtensa/mm/init.c:235:24: error: 'PAGE_COPY_EXEC' undeclared (first use in this function); did you mean 'PAGE_COPY'?
     235 |                 return PAGE_COPY_EXEC;
         |                        ^~~~~~~~~~~~~~
         |                        PAGE_COPY
>> arch/xtensa/mm/init.c:248:24: error: 'PAGE_SHARED_EXEC' undeclared (first use in this function); did you mean 'PAGE_SHARED'?
     248 |                 return PAGE_SHARED_EXEC;
         |                        ^~~~~~~~~~~~~~~~
         |                        PAGE_SHARED


vim +/vm_get_page_prot +220 arch/xtensa/mm/init.c

   219	
 > 220	pgprot_t vm_get_page_prot(unsigned long vm_flags)
   221	{
   222		switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
   223		case VM_NONE:
   224			return PAGE_NONE;
   225		case VM_READ:
   226			return PAGE_READONLY;
   227		case VM_WRITE:
   228		case VM_WRITE | VM_READ:
   229			return PAGE_COPY;
   230		case VM_EXEC:
   231		case VM_EXEC | VM_READ:
 > 232			return PAGE_READONLY_EXEC;
   233		case VM_EXEC | VM_WRITE:
   234		case VM_EXEC | VM_WRITE | VM_READ:
 > 235			return PAGE_COPY_EXEC;
   236		case VM_SHARED:
   237			return PAGE_NONE;
   238		case VM_SHARED | VM_READ:
   239			return PAGE_READONLY;
   240		case VM_SHARED | VM_WRITE:
   241		case VM_SHARED | VM_WRITE | VM_READ:
   242			return PAGE_SHARED;
   243		case VM_SHARED | VM_EXEC:
   244		case VM_SHARED | VM_EXEC | VM_READ:
   245			return PAGE_READONLY_EXEC;
   246		case VM_SHARED | VM_EXEC | VM_WRITE:
   247		case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
 > 248			return PAGE_SHARED_EXEC;

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

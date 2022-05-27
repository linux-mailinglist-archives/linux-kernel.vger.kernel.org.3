Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC47535EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 13:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351183AbiE0LCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 07:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351179AbiE0LCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 07:02:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC30112088
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 04:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653649352; x=1685185352;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BqVMsKuKuFhCglDn4LhU2ZXFc0fT1uxftXQtbO0F3eA=;
  b=f5GZaLfBicXVaQnKI0w6tWbN+hhI38+HkmRaBPZ+DtEySEvRwIxwv9Cs
   kLt+9+crXk3xpBUXglrM9iMt2DkiE04iW8YlV1iHOZW+W9YeHkszq659i
   TC8qK9L/GR6OBTZNRUBc6fBRljj8/LFCi2sSemtiHUsLf9QVc2PCWd37a
   Le1l7ACHFLz7eiCWKlcLm8stOyzpXY/sHlgUvYSQJDDYmgndbWZAYzohQ
   yKszXAJJ+mlDtu8TtwG5uYDE5MJgIUJ/mMqXscZ0KTDV181lIGWDJGTfV
   Pnt7YZLrqc/iMmJk+wb8ixVekN7orSzJuXVk4JEIR2R0fhme8a0Q5q9jM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="262067843"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="262067843"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 04:02:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="705084587"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 May 2022 04:02:30 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuXjh-0004h7-OX;
        Fri, 27 May 2022 11:02:29 +0000
Date:   Fri, 27 May 2022 19:01:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 333/429]
 include/linux/memfile_notifier.h:87:57: error: unknown type name 'flags'
Message-ID: <202205271903.LhlXvUsN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   49c277ae966b45577acad5c6d98acba3d27d63af
commit: a46fd36366f3a53f0ea7385cdddef7d5e373edd0 [333/429] mm/shmem: Support memfile_notifier
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220527/202205271903.LhlXvUsN-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/a46fd36366f3a53f0ea7385cdddef7d5e373edd0
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout a46fd36366f3a53f0ea7385cdddef7d5e373edd0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/shmem_fs.h:12,
                    from kernel/events/uprobes.c:28:
>> include/linux/memfile_notifier.h:87:57: error: unknown type name 'flags'
      87 | static int memfile_register_notifier(struct file *file, flags,
         |                                                         ^~~~~
   include/linux/memfile_notifier.h:93:13: warning: 'memfile_unregister_notifier' defined but not used [-Wunused-function]
      93 | static void memfile_unregister_notifier(struct memfile_notifier *notifier)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/memfile_notifier.h:82:13: warning: 'memfile_notifier_invalidate' defined but not used [-Wunused-function]
      82 | static void memfile_notifier_invalidate(struct memfile_node *node,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/memfile_notifier.h:77:13: warning: 'memfile_notifier_populate' defined but not used [-Wunused-function]
      77 | static void memfile_notifier_populate(struct memfile_node *node,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/memfile_notifier.h:72:12: warning: 'memfile_node_set_flags' defined but not used [-Wunused-function]
      72 | static int memfile_node_set_flags(struct file *file, unsigned long flags)
         |            ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/memfile_notifier.h:68:13: warning: 'memfile_register_backing_store' defined but not used [-Wunused-function]
      68 | static void memfile_register_backing_store(struct memfile_backing_store *bs)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/shmem_fs.h:12,
                    from include/linux/khugepaged.h:6,
                    from mm/shmem.c:37:
>> include/linux/memfile_notifier.h:87:57: error: unknown type name 'flags'
      87 | static int memfile_register_notifier(struct file *file, flags,
         |                                                         ^~~~~
   In file included from include/linux/shmem_fs.h:12,
                    from include/linux/khugepaged.h:6,
                    from mm/shmem.c:37:
   include/linux/memfile_notifier.h:93:13: warning: 'memfile_unregister_notifier' defined but not used [-Wunused-function]
      93 | static void memfile_unregister_notifier(struct memfile_notifier *notifier)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/memfile_notifier.h:72:12: warning: 'memfile_node_set_flags' defined but not used [-Wunused-function]
      72 | static int memfile_node_set_flags(struct file *file, unsigned long flags)
         |            ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/memfile_notifier.h:68:13: warning: 'memfile_register_backing_store' defined but not used [-Wunused-function]
      68 | static void memfile_register_backing_store(struct memfile_backing_store *bs)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/flags +87 include/linux/memfile_notifier.h

07b4263e3099f7 Chao Peng 2022-01-12  86  
07b4263e3099f7 Chao Peng 2022-01-12 @87  static int memfile_register_notifier(struct file *file, flags,
07b4263e3099f7 Chao Peng 2022-01-12  88  				     struct memfile_notifier *notifier)
07b4263e3099f7 Chao Peng 2022-01-12  89  {
07b4263e3099f7 Chao Peng 2022-01-12  90  	return -EOPNOTSUPP;
07b4263e3099f7 Chao Peng 2022-01-12  91  }
07b4263e3099f7 Chao Peng 2022-01-12  92  

:::::: The code at line 87 was first introduced by commit
:::::: 07b4263e3099f776c35284155851f0e202b12a44 mm: Introduce memfile_notifier

:::::: TO: Chao Peng <chao.p.peng@linux.intel.com>
:::::: CC: Isaku Yamahata <isaku.yamahata@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

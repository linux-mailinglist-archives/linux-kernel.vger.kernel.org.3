Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2513F535FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 13:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351795AbiE0Lor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 07:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351126AbiE0Ln6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 07:43:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271DA65D13
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 04:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653651654; x=1685187654;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RGiHMYrBTbn5qGGGzyVkG1d+wPvM4hkxm05f/PDF7A8=;
  b=DGakbBbF4Q5UWNzh4qFlZeEjMtv229ZeQkNyvLFqDUxSnRcuEC+Vl6Qg
   s3v0eQ8HjFxqVdZ2rdlXtyFy9QVK2YDZ14H19ZDxn1yKDa29etE/MNX2i
   sP64OcWVovMqUsai1U3PNt7UNNfZzMW+qpNQPu4I7PYNACXwd6/rWhzJo
   oGGvSRcPJnPlkehNuH8dPfngzyzdg1NMs+X5WOg7uLMqSgZdfMqOARw+Q
   yLvZ+ozqQ3szersebesRhSQX4iCTxwViOm99Q/kMTtNzEkkob9erKLH10
   ilplRIjg5FGR8Z6oxsHHwx83JHUETVwmVaWZGLLDKN/3/tLmXR1+mHh5s
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="337502340"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="337502340"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 04:40:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="528076236"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 May 2022 04:40:51 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuYKo-0004hq-SJ;
        Fri, 27 May 2022 11:40:50 +0000
Date:   Fri, 27 May 2022 19:40:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 333/429]
 include/linux/memfile_notifier.h:93:13: error: 'memfile_unregister_notifier'
 defined but not used
Message-ID: <202205271946.aUffZ0Xh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   49c277ae966b45577acad5c6d98acba3d27d63af
commit: a46fd36366f3a53f0ea7385cdddef7d5e373edd0 [333/429] mm/shmem: Support memfile_notifier
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220527/202205271946.aUffZ0Xh-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/a46fd36366f3a53f0ea7385cdddef7d5e373edd0
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout a46fd36366f3a53f0ea7385cdddef7d5e373edd0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/shmem_fs.h:12,
                    from drivers/gpu/drm/i915/gt/shmem_utils.c:9:
   include/linux/memfile_notifier.h:87:57: error: unknown type name 'flags'
      87 | static int memfile_register_notifier(struct file *file, flags,
         |                                                         ^~~~~
   In file included from include/linux/shmem_fs.h:12,
                    from drivers/gpu/drm/i915/gt/shmem_utils.c:9:
>> include/linux/memfile_notifier.h:93:13: error: 'memfile_unregister_notifier' defined but not used [-Werror=unused-function]
      93 | static void memfile_unregister_notifier(struct memfile_notifier *notifier)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/memfile_notifier.h:82:13: error: 'memfile_notifier_invalidate' defined but not used [-Werror=unused-function]
      82 | static void memfile_notifier_invalidate(struct memfile_node *node,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/memfile_notifier.h:77:13: error: 'memfile_notifier_populate' defined but not used [-Werror=unused-function]
      77 | static void memfile_notifier_populate(struct memfile_node *node,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/memfile_notifier.h:72:12: error: 'memfile_node_set_flags' defined but not used [-Werror=unused-function]
      72 | static int memfile_node_set_flags(struct file *file, unsigned long flags)
         |            ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/memfile_notifier.h:68:13: error: 'memfile_register_backing_store' defined but not used [-Werror=unused-function]
      68 | static void memfile_register_backing_store(struct memfile_backing_store *bs)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/memfile_unregister_notifier +93 include/linux/memfile_notifier.h

07b4263e3099f77 Chao Peng 2022-01-12  66  
07b4263e3099f77 Chao Peng 2022-01-12  67  #else /* !CONFIG_MEMFILE_NOTIFIER */
07b4263e3099f77 Chao Peng 2022-01-12 @68  static void memfile_register_backing_store(struct memfile_backing_store *bs)
07b4263e3099f77 Chao Peng 2022-01-12  69  {
07b4263e3099f77 Chao Peng 2022-01-12  70  }
07b4263e3099f77 Chao Peng 2022-01-12  71  
07b4263e3099f77 Chao Peng 2022-01-12 @72  static int memfile_node_set_flags(struct file *file, unsigned long flags)
07b4263e3099f77 Chao Peng 2022-01-12  73  {
07b4263e3099f77 Chao Peng 2022-01-12  74  	return -EOPNOTSUPP;
07b4263e3099f77 Chao Peng 2022-01-12  75  }
07b4263e3099f77 Chao Peng 2022-01-12  76  
07b4263e3099f77 Chao Peng 2022-01-12 @77  static void memfile_notifier_populate(struct memfile_node *node,
07b4263e3099f77 Chao Peng 2022-01-12  78  				      pgoff_t start, pgoff_t end)
07b4263e3099f77 Chao Peng 2022-01-12  79  {
07b4263e3099f77 Chao Peng 2022-01-12  80  }
07b4263e3099f77 Chao Peng 2022-01-12  81  
07b4263e3099f77 Chao Peng 2022-01-12 @82  static void memfile_notifier_invalidate(struct memfile_node *node,
07b4263e3099f77 Chao Peng 2022-01-12  83  					pgoff_t start, pgoff_t end)
07b4263e3099f77 Chao Peng 2022-01-12  84  {
07b4263e3099f77 Chao Peng 2022-01-12  85  }
07b4263e3099f77 Chao Peng 2022-01-12  86  
07b4263e3099f77 Chao Peng 2022-01-12  87  static int memfile_register_notifier(struct file *file, flags,
07b4263e3099f77 Chao Peng 2022-01-12  88  				     struct memfile_notifier *notifier)
07b4263e3099f77 Chao Peng 2022-01-12  89  {
07b4263e3099f77 Chao Peng 2022-01-12  90  	return -EOPNOTSUPP;
07b4263e3099f77 Chao Peng 2022-01-12  91  }
07b4263e3099f77 Chao Peng 2022-01-12  92  
07b4263e3099f77 Chao Peng 2022-01-12 @93  static void memfile_unregister_notifier(struct memfile_notifier *notifier)
07b4263e3099f77 Chao Peng 2022-01-12  94  {
07b4263e3099f77 Chao Peng 2022-01-12  95  }
07b4263e3099f77 Chao Peng 2022-01-12  96  

:::::: The code at line 93 was first introduced by commit
:::::: 07b4263e3099f776c35284155851f0e202b12a44 mm: Introduce memfile_notifier

:::::: TO: Chao Peng <chao.p.peng@linux.intel.com>
:::::: CC: Isaku Yamahata <isaku.yamahata@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

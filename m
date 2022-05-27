Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7594535F41
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 13:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350965AbiE0La5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 07:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236784AbiE0Lay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 07:30:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F0D5BD31
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 04:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653651053; x=1685187053;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WMFJJZ6HLj4gQSVHjvYyKMWAyLkF08ix5YrY58k9LIA=;
  b=ULjfkQrJtq6gzXSVLYb7b2CcpfRCi9HDkceabt4OQ4jRZeAKDm6hhkMW
   uIxOnrMugsnaWlGhv8eDZvssPG2Fk3ZolIOkRrh0kMVIIG3jvANvoYVea
   TM4SQWS68SDlKYykdcHc+fug8GOFov9BDG2VX9gfQFeusFaBRBi88/YBK
   XALZt3b/8Y7SIVXdloUHyztuVJQ9oxg29Wbyna1mtTZUakhEfJiWDVLsx
   tizjjEfMqfPEl+SYzO2Hof3oHyHdbVobRiUcPQKV4BSBg0tcuWrN/9Z7+
   6cREcnn6cRl7LOZMmlfa2BNSp3N17b+ogus4/jMz/+mrgfg2ItBVBiWv5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="262074289"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="262074289"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 04:30:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="560722632"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 27 May 2022 04:30:51 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuYB8-0004ha-JE;
        Fri, 27 May 2022 11:30:50 +0000
Date:   Fri, 27 May 2022 19:30:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 333/429]
 include/linux/memfile_notifier.h:87:57: error: type specifier missing,
 defaults to 'int'; ISO C99 and later do not support implicit int
Message-ID: <202205271916.7L8Eg9yk-lkp@intel.com>
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
config: hexagon-randconfig-r045-20220524 (https://download.01.org/0day-ci/archive/20220527/202205271916.7L8Eg9yk-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 134d7f9a4b97e9035150d970bd9e376043c4577e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/a46fd36366f3a53f0ea7385cdddef7d5e373edd0
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout a46fd36366f3a53f0ea7385cdddef7d5e373edd0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/char/mem.c:25:
   In file included from include/linux/shmem_fs.h:12:
>> include/linux/memfile_notifier.h:87:57: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
   static int memfile_register_notifier(struct file *file, flags,
                                                           ^
                                                           int
   drivers/char/mem.c:95:13: warning: no previous prototype for function 'unxlate_dev_mem_ptr' [-Wmissing-prototypes]
   void __weak unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
               ^
   drivers/char/mem.c:94:29: note: expanded from macro 'unxlate_dev_mem_ptr'
   #define unxlate_dev_mem_ptr unxlate_dev_mem_ptr
                               ^
   drivers/char/mem.c:95:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __weak unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
   ^
   static 
   1 warning and 1 error generated.
--
   In file included from drivers/gpu/drm/drm_gem_shmem_helper.c:10:
   In file included from include/linux/shmem_fs.h:12:
>> include/linux/memfile_notifier.h:87:57: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
   static int memfile_register_notifier(struct file *file, flags,
                                                           ^
                                                           int
   1 error generated.
--
   In file included from drivers/gpu/drm/vgem/vgem_drv.c:36:
   In file included from include/linux/shmem_fs.h:12:
>> include/linux/memfile_notifier.h:87:57: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
   static int memfile_register_notifier(struct file *file, flags,
                                                           ^
                                                           int
   drivers/gpu/drm/vgem/vgem_drv.c:144:10: warning: shift count >= width of type [-Wshift-count-overflow]
                                        DMA_BIT_MASK(64));
                                        ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   1 warning and 1 error generated.
--
   In file included from init/main.c:80:
   In file included from include/linux/shmem_fs.h:12:
>> include/linux/memfile_notifier.h:87:57: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
   static int memfile_register_notifier(struct file *file, flags,
                                                           ^
                                                           int
   init/main.c:769:20: warning: no previous prototype for function 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
   void __init __weak arch_post_acpi_subsys_init(void) { }
                      ^
   init/main.c:769:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak arch_post_acpi_subsys_init(void) { }
   ^
   static 
   init/main.c:781:20: warning: no previous prototype for function 'mem_encrypt_init' [-Wmissing-prototypes]
   void __init __weak mem_encrypt_init(void) { }
                      ^
   init/main.c:781:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak mem_encrypt_init(void) { }
   ^
   static 
   init/main.c:783:20: warning: no previous prototype for function 'poking_init' [-Wmissing-prototypes]
   void __init __weak poking_init(void) { }
                      ^
   init/main.c:783:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak poking_init(void) { }
   ^
   static 
   3 warnings and 1 error generated.
--
   In file included from kernel/fork.c:86:
   In file included from include/linux/khugepaged.h:6:
   In file included from include/linux/shmem_fs.h:12:
>> include/linux/memfile_notifier.h:87:57: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
   static int memfile_register_notifier(struct file *file, flags,
                                                           ^
                                                           int
   kernel/fork.c:163:13: warning: no previous prototype for function 'arch_release_task_struct' [-Wmissing-prototypes]
   void __weak arch_release_task_struct(struct task_struct *tsk)
               ^
   kernel/fork.c:163:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __weak arch_release_task_struct(struct task_struct *tsk)
   ^
   static 
   kernel/fork.c:854:20: warning: no previous prototype for function 'arch_task_cache_init' [-Wmissing-prototypes]
   void __init __weak arch_task_cache_init(void) { }
                      ^
   kernel/fork.c:854:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak arch_task_cache_init(void) { }
   ^
   static 
   kernel/fork.c:949:12: warning: no previous prototype for function 'arch_dup_task_struct' [-Wmissing-prototypes]
   int __weak arch_dup_task_struct(struct task_struct *dst,
              ^
   kernel/fork.c:949:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __weak arch_dup_task_struct(struct task_struct *dst,
   ^
   static 
   3 warnings and 1 error generated.
--
   In file included from mm/shmem.c:37:
   In file included from include/linux/khugepaged.h:6:
   In file included from include/linux/shmem_fs.h:12:
>> include/linux/memfile_notifier.h:87:57: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
   static int memfile_register_notifier(struct file *file, flags,
                                                           ^
                                                           int
   In file included from mm/shmem.c:55:
   include/linux/mman.h:158:9: warning: division by zero is undefined [-Wdivision-by-zero]
                  _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mman.h:136:21: note: expanded from macro '_calc_vm_trans'
      : ((x) & (bit1)) / ((bit1) / (bit2))))
                       ^ ~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +/int +87 include/linux/memfile_notifier.h

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

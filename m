Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A81595595
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiHPItL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiHPIso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:48:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558FD14EBA2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 23:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660632834; x=1692168834;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0Dx23CFW/qsKnrfUErD+hh/0dSZqJCUJzWBw2hBY8Pc=;
  b=QqbtsOlCTV/pImc0rnxRG83HLhKNHXs4yDn0i9TNk4nWqpy8FQn06Zsp
   yXygjvTzbXL7u3BP5+JcRKqupz836Bdq9oH31wwvNIBG/7vZRoWSE84CT
   cH5YrcU38PprUqUYOdNeiqmzpQjWGVFQjJ1OO60WnucU3guVis8xACbX4
   23T4wCe2Pk4tJ+Ve/3euHhUsp07k6lgoc+PLXPWtwq9kcsD7o2GJvLeEg
   +Duf503h69zG6iUNbTAsqCO+3TmqemnbP8/fVRP2RswS0I9tw0Hy9tZrM
   4WR53B5AGspx8XyJb+fRXqHETNkkDWUY7m7HI5EfZaEArTaTMPKq8H6cK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="356144193"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="356144193"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 23:53:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="675102184"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 15 Aug 2022 23:53:49 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNqSS-0001a9-1n;
        Tue, 16 Aug 2022 06:53:48 +0000
Date:   Tue, 16 Aug 2022 14:52:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Subject: arch/um/include/asm/processor-generic.h:97:19: error: called object
 is not a function or function pointer
Message-ID: <202208161404.QXtm39M1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   568035b01cfb107af8d2e4bd2fb9aea22cf5b868
commit: 68f5d3f3b6543266b29e047cfaf9842333019b4c um: add PCI over virtio emulation driver
date:   1 year, 2 months ago
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20220816/202208161404.QXtm39M1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=68f5d3f3b6543266b29e047cfaf9842333019b4c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 68f5d3f3b6543266b29e047cfaf9842333019b4c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/um/asm/processor.h:41,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/pci.h:35,
                    from drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:25:
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: In function 'kfd_cpumask_to_apic_id':
>> arch/um/include/asm/processor-generic.h:97:19: error: called object is not a function or function pointer
      97 | #define cpu_data (&boot_cpu_data)
         |                  ~^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1500:16: note: in expansion of macro 'cpu_data'
    1500 |         return cpu_data(first_cpu_of_numa_node).apicid;
         |                ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1504:1: error: control reaches end of non-void function [-Werror=return-type]
    1504 | }
         | ^
   cc1: some warnings being treated as errors
--
   In file included from arch/x86/um/asm/processor.h:41,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/pci.h:35,
                    from drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:23:
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c: In function 'kfd_fill_iolink_info_for_cpu':
>> arch/um/include/asm/processor-generic.h:97:19: error: called object is not a function or function pointer
      97 | #define cpu_data (&boot_cpu_data)
         |                  ~^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:921:34: note: in expansion of macro 'cpu_data'
     921 |         struct cpuinfo_x86 *c = &cpu_data(0);
         |                                  ^~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:924:14: error: invalid use of undefined type 'struct cpuinfo_x86'
     924 |         if (c->x86_vendor == X86_VENDOR_AMD)
         |              ^~
>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:924:30: error: 'X86_VENDOR_AMD' undeclared (first use in this function); did you mean 'X86_VENDOR_ANY'?
     924 |         if (c->x86_vendor == X86_VENDOR_AMD)
         |                              ^~~~~~~~~~~~~~
         |                              X86_VENDOR_ANY
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:924:30: note: each undeclared identifier is reported only once for each function it appears in
--
   drivers/infiniband/sw/rdmavt/qp.c: In function 'rvt_wss_llc_size':
>> drivers/infiniband/sw/rdmavt/qp.c:130:29: error: 'struct cpuinfo_um' has no member named 'x86_cache_size'
     130 |         return boot_cpu_data.x86_cache_size;
         |                             ^
   drivers/infiniband/sw/rdmavt/qp.c: In function 'cacheless_memcpy':
>> drivers/infiniband/sw/rdmavt/qp.c:142:9: error: implicit declaration of function '__copy_user_nocache'; did you mean 'copy_user_page'? [-Werror=implicit-function-declaration]
     142 |         __copy_user_nocache(dst, (void __user *)src, n, 0);
         |         ^~~~~~~~~~~~~~~~~~~
         |         copy_user_page
   drivers/infiniband/sw/rdmavt/qp.c: In function 'rvt_wss_llc_size':
   drivers/infiniband/sw/rdmavt/qp.c:131:1: error: control reaches end of non-void function [-Werror=return-type]
     131 | }
         | ^
   cc1: some warnings being treated as errors
--
   In file included from include/linux/mm.h:33,
                    from include/linux/scatterlist.h:8,
                    from include/linux/dmapool.h:14,
                    from include/linux/pci.h:1463,
                    from drivers/infiniband/hw/qib/qib_wc_x86_64.c:40:
   arch/x86/include/asm/pgtable_types.h:286:43: error: expected ')' before 'prot'
     286 | static inline pgprot_t pgprot_nx(pgprot_t prot)
         |                                           ^~~~
   include/linux/pgtable.h:896:26: note: in definition of macro 'pgprot_nx'
     896 | #define pgprot_nx(prot) (prot)
         |                          ^~~~
   In file included from arch/x86/include/asm/memtype.h:6,
                    from arch/x86/include/asm/mtrr.h:27,
                    from drivers/infiniband/hw/qib/qib_wc_x86_64.c:41:
   arch/x86/include/asm/pgtable_types.h:290: warning: "pgprot_nx" redefined
     290 | #define pgprot_nx pgprot_nx
         | 
   In file included from include/linux/mm.h:33,
                    from include/linux/scatterlist.h:8,
                    from include/linux/dmapool.h:14,
                    from include/linux/pci.h:1463,
                    from drivers/infiniband/hw/qib/qib_wc_x86_64.c:40:
   include/linux/pgtable.h:896: note: this is the location of the previous definition
     896 | #define pgprot_nx(prot) (prot)
         | 
   In file included from arch/x86/include/asm/memtype.h:6,
                    from arch/x86/include/asm/mtrr.h:27,
                    from drivers/infiniband/hw/qib/qib_wc_x86_64.c:41:
   arch/x86/include/asm/pgtable_types.h: In function 'native_make_p4d':
   arch/x86/include/asm/pgtable_types.h:347:33: error: incompatible types when initializing type 'long unsigned int' using type 'pgd_t'
     347 |         return (p4d_t) { .pgd = native_make_pgd((pgdval_t)val) };
         |                                 ^~~~~~~~~~~~~~~
   arch/x86/include/asm/pgtable_types.h: In function 'native_p4d_val':
   arch/x86/include/asm/pgtable_types.h:352:34: error: incompatible type for argument 1 of 'native_pgd_val'
     352 |         return native_pgd_val(p4d.pgd);
         |                               ~~~^~~~
         |                                  |
         |                                  pgd_t
   arch/x86/include/asm/pgtable_types.h:320:45: note: expected 'pgd_t' but argument is of type 'pgd_t'
     320 | static inline pgdval_t native_pgd_val(pgd_t pgd)
         |                                       ~~~~~~^~~
   arch/x86/include/asm/pgtable_types.h: In function 'native_make_pud':
   arch/x86/include/asm/pgtable_types.h:373:37: error: incompatible types when initializing type 'long unsigned int' using type 'pgd_t'
     373 |         return (pud_t) { .p4d.pgd = native_make_pgd(val) };
         |                                     ^~~~~~~~~~~~~~~
   arch/x86/include/asm/pgtable_types.h: In function 'native_pud_val':
   arch/x86/include/asm/pgtable_types.h:378:38: error: incompatible type for argument 1 of 'native_pgd_val'
     378 |         return native_pgd_val(pud.p4d.pgd);
         |                               ~~~~~~~^~~~
         |                                      |
         |                                      pgd_t
   arch/x86/include/asm/pgtable_types.h:320:45: note: expected 'pgd_t' but argument is of type 'pgd_t'
     320 | static inline pgdval_t native_pgd_val(pgd_t pgd)
         |                                       ~~~~~~^~~
   arch/x86/include/asm/pgtable_types.h: At top level:
   arch/x86/include/asm/pgtable_types.h:383:34: error: conflicting types for 'pmd_t'; have 'struct <anonymous>'
     383 | typedef struct { pmdval_t pmd; } pmd_t;
         |                                  ^~~~~
   In file included from arch/um/include/asm/thread_info.h:15,
                    from include/linux/thread_info.h:59,
                    from include/asm-generic/current.h:5,
                    from ./arch/um/include/generated/asm/current.h:1,
                    from include/linux/mutex.h:14,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/pci.h:35,
                    from drivers/infiniband/hw/qib/qib_wc_x86_64.c:40:
   arch/um/include/asm/page.h:61:39: note: previous declaration of 'pmd_t' with type 'pmd_t'
      61 | typedef struct { unsigned long pmd; } pmd_t;
         |                                       ^~~~~
   In file included from arch/x86/include/asm/memtype.h:6,
                    from arch/x86/include/asm/mtrr.h:27,
                    from drivers/infiniband/hw/qib/qib_wc_x86_64.c:41:
   arch/x86/include/asm/pgtable_types.h:514: warning: "pgprot_writecombine" redefined
     514 | #define pgprot_writecombine     pgprot_writecombine
         | 
   In file included from include/linux/mm.h:33,
                    from include/linux/scatterlist.h:8,
                    from include/linux/dmapool.h:14,
                    from include/linux/pci.h:1463,
                    from drivers/infiniband/hw/qib/qib_wc_x86_64.c:40:
   include/linux/pgtable.h:904: note: this is the location of the previous definition
     904 | #define pgprot_writecombine pgprot_noncached
         | 
   In file included from arch/x86/include/asm/memtype.h:6,
                    from arch/x86/include/asm/mtrr.h:27,
                    from drivers/infiniband/hw/qib/qib_wc_x86_64.c:41:
   arch/x86/include/asm/pgtable_types.h:517: warning: "pgprot_writethrough" redefined
     517 | #define pgprot_writethrough     pgprot_writethrough
         | 
   In file included from include/linux/mm.h:33,
                    from include/linux/scatterlist.h:8,
                    from include/linux/dmapool.h:14,
                    from include/linux/pci.h:1463,
                    from drivers/infiniband/hw/qib/qib_wc_x86_64.c:40:
   include/linux/pgtable.h:908: note: this is the location of the previous definition
     908 | #define pgprot_writethrough pgprot_noncached
         | 
   drivers/infiniband/hw/qib/qib_wc_x86_64.c: In function 'qib_unordered_wc':
>> drivers/infiniband/hw/qib/qib_wc_x86_64.c:149:29: error: 'struct cpuinfo_um' has no member named 'x86_vendor'
     149 |         return boot_cpu_data.x86_vendor != X86_VENDOR_AMD;
         |                             ^
>> drivers/infiniband/hw/qib/qib_wc_x86_64.c:149:44: error: 'X86_VENDOR_AMD' undeclared (first use in this function); did you mean 'X86_VENDOR_ANY'?
     149 |         return boot_cpu_data.x86_vendor != X86_VENDOR_AMD;
         |                                            ^~~~~~~~~~~~~~
         |                                            X86_VENDOR_ANY
   drivers/infiniband/hw/qib/qib_wc_x86_64.c:149:44: note: each undeclared identifier is reported only once for each function it appears in
   drivers/infiniband/hw/qib/qib_wc_x86_64.c:150:1: error: control reaches end of non-void function [-Werror=return-type]
     150 | }
         | ^
   cc1: some warnings being treated as errors


vim +97 arch/um/include/asm/processor-generic.h

^1da177e4c3f41 include/asm-um/processor-generic.h Linus Torvalds 2005-04-16  96  
^1da177e4c3f41 include/asm-um/processor-generic.h Linus Torvalds 2005-04-16 @97  #define cpu_data (&boot_cpu_data)
^1da177e4c3f41 include/asm-um/processor-generic.h Linus Torvalds 2005-04-16  98  #define current_cpu_data boot_cpu_data
^1da177e4c3f41 include/asm-um/processor-generic.h Linus Torvalds 2005-04-16  99  

:::::: The code at line 97 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

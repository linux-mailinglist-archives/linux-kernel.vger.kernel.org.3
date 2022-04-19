Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BF5506208
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344464AbiDSC1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344385AbiDSC05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:26:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B122C114
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650335055; x=1681871055;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f6eI5kOAYPkiUJk787cuT0kQdJ/sRCerAuqGQgxF2Xs=;
  b=Us9CRjil82fboXao+9fRF7dyhAtwQEksPlUrTwgj4WxltR3tg5oHcD3i
   Z4METJWGUxrJ9pzu0vvt0HpdJYaUs7NIzshaHoMsnENeHu9LtHmIJXRH5
   ySPr51IJKYQkjlWAFXRkWpF/dQsj3QQeWwEvhmfM16EGe/s6RY5SvQNRv
   AGv6+wCx/MV8G7bxa/r60HVfk99LMtIs9UX82soO0ZtCoNnGPGmUH63f/
   cUCsExOhOJXQ5gYz2UBKPRAOyOlcvEQPRHluGbwia0egcFBiWo4h2QA+r
   U7raH4B3ztLJl32gjnDEUtwJNnbM+TssE+EiyGf6QXwVz6/S4HHPuqQbu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="261259037"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="261259037"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 19:24:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="613828400"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 18 Apr 2022 19:24:14 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngdXJ-0005D2-DL;
        Tue, 19 Apr 2022 02:24:13 +0000
Date:   Tue, 19 Apr 2022 10:23:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2230/2356] drivers/virt/acrn/mm.c:177:24:
 error: incomplete definition of type 'struct task_struct'
Message-ID: <202204191036.Yw9ZzovK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: 1951372245ed8de4c0b52806b4dddc5957b2db20 [2230/2356] headers/deps: mm: Optimize <linux/mm_api.h> dependencies, remove <linux/mmzone_api.h> dependency
config: x86_64-randconfig-a015-20220418 (https://download.01.org/0day-ci/archive/20220419/202204191036.Yw9ZzovK-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=1951372245ed8de4c0b52806b4dddc5957b2db20
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 1951372245ed8de4c0b52806b4dddc5957b2db20
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/virt/acrn/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/virt/acrn/mm.c:177:2: error: implicit declaration of function 'mmap_read_lock' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           mmap_read_lock(current->mm);
           ^
   drivers/virt/acrn/mm.c:177:2: note: did you mean '_raw_read_lock'?
   include/linux/rwlock_api_smp.h:22:17: note: '_raw_read_lock' declared here
   void __lockfunc _raw_read_lock(rwlock_t *lock)          __acquires(lock);
                   ^
>> drivers/virt/acrn/mm.c:177:24: error: incomplete definition of type 'struct task_struct'
           mmap_read_lock(current->mm);
                          ~~~~~~~^
   arch/x86/include/asm/smp.h:40:8: note: forward declaration of 'struct task_struct'
   struct task_struct;
          ^
   drivers/virt/acrn/mm.c:178:26: error: incomplete definition of type 'struct task_struct'
           vma = vma_lookup(current->mm, memmap->vma_base);
                            ~~~~~~~^
   arch/x86/include/asm/smp.h:40:8: note: forward declaration of 'struct task_struct'
   struct task_struct;
          ^
   drivers/virt/acrn/mm.c:181:4: error: implicit declaration of function 'mmap_read_unlock' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           mmap_read_unlock(current->mm);
                           ^
   drivers/virt/acrn/mm.c:181:4: note: did you mean 'mmap_read_lock'?
   drivers/virt/acrn/mm.c:177:2: note: 'mmap_read_lock' declared here
           mmap_read_lock(current->mm);
           ^
   drivers/virt/acrn/mm.c:181:28: error: incomplete definition of type 'struct task_struct'
                           mmap_read_unlock(current->mm);
                                            ~~~~~~~^
   arch/x86/include/asm/smp.h:40:8: note: forward declaration of 'struct task_struct'
   struct task_struct;
          ^
   drivers/virt/acrn/mm.c:186:3: error: implicit declaration of function 'mmap_read_unlock' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   mmap_read_unlock(current->mm);
                   ^
   drivers/virt/acrn/mm.c:186:27: error: incomplete definition of type 'struct task_struct'
                   mmap_read_unlock(current->mm);
                                    ~~~~~~~^
   arch/x86/include/asm/smp.h:40:8: note: forward declaration of 'struct task_struct'
   struct task_struct;
          ^
   drivers/virt/acrn/mm.c:197:2: error: implicit declaration of function 'mmap_read_unlock' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           mmap_read_unlock(current->mm);
           ^
   drivers/virt/acrn/mm.c:197:26: error: incomplete definition of type 'struct task_struct'
           mmap_read_unlock(current->mm);
                            ~~~~~~~^
   arch/x86/include/asm/smp.h:40:8: note: forward declaration of 'struct task_struct'
   struct task_struct;
          ^
   9 errors generated.


vim +177 drivers/virt/acrn/mm.c

88f537d5e8ddc89 Shuo Liu      2021-02-07  153  
88f537d5e8ddc89 Shuo Liu      2021-02-07  154  /**
88f537d5e8ddc89 Shuo Liu      2021-02-07  155   * acrn_vm_ram_map() - Create a RAM EPT mapping of User VM.
88f537d5e8ddc89 Shuo Liu      2021-02-07  156   * @vm:		The User VM pointer
88f537d5e8ddc89 Shuo Liu      2021-02-07  157   * @memmap:	Info of the EPT mapping
88f537d5e8ddc89 Shuo Liu      2021-02-07  158   *
88f537d5e8ddc89 Shuo Liu      2021-02-07  159   * Return: 0 on success, <0 for error.
88f537d5e8ddc89 Shuo Liu      2021-02-07  160   */
88f537d5e8ddc89 Shuo Liu      2021-02-07  161  int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
88f537d5e8ddc89 Shuo Liu      2021-02-07  162  {
88f537d5e8ddc89 Shuo Liu      2021-02-07  163  	struct vm_memory_region_batch *regions_info;
88f537d5e8ddc89 Shuo Liu      2021-02-07  164  	int nr_pages, i = 0, order, nr_regions = 0;
88f537d5e8ddc89 Shuo Liu      2021-02-07  165  	struct vm_memory_mapping *region_mapping;
88f537d5e8ddc89 Shuo Liu      2021-02-07  166  	struct vm_memory_region_op *vm_region;
88f537d5e8ddc89 Shuo Liu      2021-02-07  167  	struct page **pages = NULL, *page;
88f537d5e8ddc89 Shuo Liu      2021-02-07  168  	void *remap_vaddr;
88f537d5e8ddc89 Shuo Liu      2021-02-07  169  	int ret, pinned;
88f537d5e8ddc89 Shuo Liu      2021-02-07  170  	u64 user_vm_pa;
8a6e85f75a83d16 Yonghua Huang 2022-02-28  171  	unsigned long pfn;
8a6e85f75a83d16 Yonghua Huang 2022-02-28  172  	struct vm_area_struct *vma;
88f537d5e8ddc89 Shuo Liu      2021-02-07  173  
88f537d5e8ddc89 Shuo Liu      2021-02-07  174  	if (!vm || !memmap)
88f537d5e8ddc89 Shuo Liu      2021-02-07  175  		return -EINVAL;
88f537d5e8ddc89 Shuo Liu      2021-02-07  176  
8a6e85f75a83d16 Yonghua Huang 2022-02-28 @177  	mmap_read_lock(current->mm);
8a6e85f75a83d16 Yonghua Huang 2022-02-28  178  	vma = vma_lookup(current->mm, memmap->vma_base);
8a6e85f75a83d16 Yonghua Huang 2022-02-28  179  	if (vma && ((vma->vm_flags & VM_PFNMAP) != 0)) {
8a6e85f75a83d16 Yonghua Huang 2022-02-28  180  		if ((memmap->vma_base + memmap->len) > vma->vm_end) {
8a6e85f75a83d16 Yonghua Huang 2022-02-28  181  			mmap_read_unlock(current->mm);
8a6e85f75a83d16 Yonghua Huang 2022-02-28  182  			return -EINVAL;
8a6e85f75a83d16 Yonghua Huang 2022-02-28  183  		}
8a6e85f75a83d16 Yonghua Huang 2022-02-28  184  
8a6e85f75a83d16 Yonghua Huang 2022-02-28  185  		ret = follow_pfn(vma, memmap->vma_base, &pfn);
8a6e85f75a83d16 Yonghua Huang 2022-02-28  186  		mmap_read_unlock(current->mm);
8a6e85f75a83d16 Yonghua Huang 2022-02-28  187  		if (ret < 0) {
8a6e85f75a83d16 Yonghua Huang 2022-02-28  188  			dev_dbg(acrn_dev.this_device,
8a6e85f75a83d16 Yonghua Huang 2022-02-28  189  				"Failed to lookup PFN at VMA:%pK.\n", (void *)memmap->vma_base);
8a6e85f75a83d16 Yonghua Huang 2022-02-28  190  			return ret;
8a6e85f75a83d16 Yonghua Huang 2022-02-28  191  		}
8a6e85f75a83d16 Yonghua Huang 2022-02-28  192  
8a6e85f75a83d16 Yonghua Huang 2022-02-28  193  		return acrn_mm_region_add(vm, memmap->user_vm_pa,
8a6e85f75a83d16 Yonghua Huang 2022-02-28  194  			 PFN_PHYS(pfn), memmap->len,
8a6e85f75a83d16 Yonghua Huang 2022-02-28  195  			 ACRN_MEM_TYPE_WB, memmap->attr);
8a6e85f75a83d16 Yonghua Huang 2022-02-28  196  	}
8a6e85f75a83d16 Yonghua Huang 2022-02-28  197  	mmap_read_unlock(current->mm);
8a6e85f75a83d16 Yonghua Huang 2022-02-28  198  
88f537d5e8ddc89 Shuo Liu      2021-02-07  199  	/* Get the page number of the map region */
88f537d5e8ddc89 Shuo Liu      2021-02-07  200  	nr_pages = memmap->len >> PAGE_SHIFT;
88f537d5e8ddc89 Shuo Liu      2021-02-07  201  	pages = vzalloc(nr_pages * sizeof(struct page *));
88f537d5e8ddc89 Shuo Liu      2021-02-07  202  	if (!pages)
88f537d5e8ddc89 Shuo Liu      2021-02-07  203  		return -ENOMEM;
88f537d5e8ddc89 Shuo Liu      2021-02-07  204  
88f537d5e8ddc89 Shuo Liu      2021-02-07  205  	/* Lock the pages of user memory map region */
88f537d5e8ddc89 Shuo Liu      2021-02-07  206  	pinned = pin_user_pages_fast(memmap->vma_base,
88f537d5e8ddc89 Shuo Liu      2021-02-07  207  				     nr_pages, FOLL_WRITE | FOLL_LONGTERM,
88f537d5e8ddc89 Shuo Liu      2021-02-07  208  				     pages);
88f537d5e8ddc89 Shuo Liu      2021-02-07  209  	if (pinned < 0) {
88f537d5e8ddc89 Shuo Liu      2021-02-07  210  		ret = pinned;
88f537d5e8ddc89 Shuo Liu      2021-02-07  211  		goto free_pages;
88f537d5e8ddc89 Shuo Liu      2021-02-07  212  	} else if (pinned != nr_pages) {
88f537d5e8ddc89 Shuo Liu      2021-02-07  213  		ret = -EFAULT;
88f537d5e8ddc89 Shuo Liu      2021-02-07  214  		goto put_pages;
88f537d5e8ddc89 Shuo Liu      2021-02-07  215  	}
88f537d5e8ddc89 Shuo Liu      2021-02-07  216  
88f537d5e8ddc89 Shuo Liu      2021-02-07  217  	/* Create a kernel map for the map region */
88f537d5e8ddc89 Shuo Liu      2021-02-07  218  	remap_vaddr = vmap(pages, nr_pages, VM_MAP, PAGE_KERNEL);
88f537d5e8ddc89 Shuo Liu      2021-02-07  219  	if (!remap_vaddr) {
88f537d5e8ddc89 Shuo Liu      2021-02-07  220  		ret = -ENOMEM;
88f537d5e8ddc89 Shuo Liu      2021-02-07  221  		goto put_pages;
88f537d5e8ddc89 Shuo Liu      2021-02-07  222  	}
88f537d5e8ddc89 Shuo Liu      2021-02-07  223  
88f537d5e8ddc89 Shuo Liu      2021-02-07  224  	/* Record Service VM va <-> User VM pa mapping */
88f537d5e8ddc89 Shuo Liu      2021-02-07  225  	mutex_lock(&vm->regions_mapping_lock);
88f537d5e8ddc89 Shuo Liu      2021-02-07  226  	region_mapping = &vm->regions_mapping[vm->regions_mapping_count];
88f537d5e8ddc89 Shuo Liu      2021-02-07  227  	if (vm->regions_mapping_count < ACRN_MEM_MAPPING_MAX) {
88f537d5e8ddc89 Shuo Liu      2021-02-07  228  		region_mapping->pages = pages;
88f537d5e8ddc89 Shuo Liu      2021-02-07  229  		region_mapping->npages = nr_pages;
88f537d5e8ddc89 Shuo Liu      2021-02-07  230  		region_mapping->size = memmap->len;
88f537d5e8ddc89 Shuo Liu      2021-02-07  231  		region_mapping->service_vm_va = remap_vaddr;
88f537d5e8ddc89 Shuo Liu      2021-02-07  232  		region_mapping->user_vm_pa = memmap->user_vm_pa;
88f537d5e8ddc89 Shuo Liu      2021-02-07  233  		vm->regions_mapping_count++;
88f537d5e8ddc89 Shuo Liu      2021-02-07  234  	} else {
88f537d5e8ddc89 Shuo Liu      2021-02-07  235  		dev_warn(acrn_dev.this_device,
88f537d5e8ddc89 Shuo Liu      2021-02-07  236  			"Run out of memory mapping slots!\n");
88f537d5e8ddc89 Shuo Liu      2021-02-07  237  		ret = -ENOMEM;
88f537d5e8ddc89 Shuo Liu      2021-02-07  238  		mutex_unlock(&vm->regions_mapping_lock);
88f537d5e8ddc89 Shuo Liu      2021-02-07  239  		goto unmap_no_count;
88f537d5e8ddc89 Shuo Liu      2021-02-07  240  	}
88f537d5e8ddc89 Shuo Liu      2021-02-07  241  	mutex_unlock(&vm->regions_mapping_lock);
88f537d5e8ddc89 Shuo Liu      2021-02-07  242  
88f537d5e8ddc89 Shuo Liu      2021-02-07  243  	/* Calculate count of vm_memory_region_op */
88f537d5e8ddc89 Shuo Liu      2021-02-07  244  	while (i < nr_pages) {
88f537d5e8ddc89 Shuo Liu      2021-02-07  245  		page = pages[i];
88f537d5e8ddc89 Shuo Liu      2021-02-07  246  		VM_BUG_ON_PAGE(PageTail(page), page);
88f537d5e8ddc89 Shuo Liu      2021-02-07  247  		order = compound_order(page);
88f537d5e8ddc89 Shuo Liu      2021-02-07  248  		nr_regions++;
88f537d5e8ddc89 Shuo Liu      2021-02-07  249  		i += 1 << order;
88f537d5e8ddc89 Shuo Liu      2021-02-07  250  	}
88f537d5e8ddc89 Shuo Liu      2021-02-07  251  
88f537d5e8ddc89 Shuo Liu      2021-02-07  252  	/* Prepare the vm_memory_region_batch */
88f537d5e8ddc89 Shuo Liu      2021-02-07  253  	regions_info = kzalloc(sizeof(*regions_info) +
88f537d5e8ddc89 Shuo Liu      2021-02-07  254  			       sizeof(*vm_region) * nr_regions,
88f537d5e8ddc89 Shuo Liu      2021-02-07  255  			       GFP_KERNEL);
88f537d5e8ddc89 Shuo Liu      2021-02-07  256  	if (!regions_info) {
88f537d5e8ddc89 Shuo Liu      2021-02-07  257  		ret = -ENOMEM;
88f537d5e8ddc89 Shuo Liu      2021-02-07  258  		goto unmap_kernel_map;
88f537d5e8ddc89 Shuo Liu      2021-02-07  259  	}
88f537d5e8ddc89 Shuo Liu      2021-02-07  260  
88f537d5e8ddc89 Shuo Liu      2021-02-07  261  	/* Fill each vm_memory_region_op */
88f537d5e8ddc89 Shuo Liu      2021-02-07  262  	vm_region = (struct vm_memory_region_op *)(regions_info + 1);
88f537d5e8ddc89 Shuo Liu      2021-02-07  263  	regions_info->vmid = vm->vmid;
88f537d5e8ddc89 Shuo Liu      2021-02-07  264  	regions_info->regions_num = nr_regions;
88f537d5e8ddc89 Shuo Liu      2021-02-07  265  	regions_info->regions_gpa = virt_to_phys(vm_region);
88f537d5e8ddc89 Shuo Liu      2021-02-07  266  	user_vm_pa = memmap->user_vm_pa;
88f537d5e8ddc89 Shuo Liu      2021-02-07  267  	i = 0;
88f537d5e8ddc89 Shuo Liu      2021-02-07  268  	while (i < nr_pages) {
88f537d5e8ddc89 Shuo Liu      2021-02-07  269  		u32 region_size;
88f537d5e8ddc89 Shuo Liu      2021-02-07  270  
88f537d5e8ddc89 Shuo Liu      2021-02-07  271  		page = pages[i];
88f537d5e8ddc89 Shuo Liu      2021-02-07  272  		VM_BUG_ON_PAGE(PageTail(page), page);
88f537d5e8ddc89 Shuo Liu      2021-02-07  273  		order = compound_order(page);
88f537d5e8ddc89 Shuo Liu      2021-02-07  274  		region_size = PAGE_SIZE << order;
88f537d5e8ddc89 Shuo Liu      2021-02-07  275  		vm_region->type = ACRN_MEM_REGION_ADD;
88f537d5e8ddc89 Shuo Liu      2021-02-07  276  		vm_region->user_vm_pa = user_vm_pa;
88f537d5e8ddc89 Shuo Liu      2021-02-07  277  		vm_region->service_vm_pa = page_to_phys(page);
88f537d5e8ddc89 Shuo Liu      2021-02-07  278  		vm_region->size = region_size;
88f537d5e8ddc89 Shuo Liu      2021-02-07  279  		vm_region->attr = (ACRN_MEM_TYPE_WB & ACRN_MEM_TYPE_MASK) |
88f537d5e8ddc89 Shuo Liu      2021-02-07  280  				  (memmap->attr & ACRN_MEM_ACCESS_RIGHT_MASK);
88f537d5e8ddc89 Shuo Liu      2021-02-07  281  
88f537d5e8ddc89 Shuo Liu      2021-02-07  282  		vm_region++;
88f537d5e8ddc89 Shuo Liu      2021-02-07  283  		user_vm_pa += region_size;
88f537d5e8ddc89 Shuo Liu      2021-02-07  284  		i += 1 << order;
88f537d5e8ddc89 Shuo Liu      2021-02-07  285  	}
88f537d5e8ddc89 Shuo Liu      2021-02-07  286  
88f537d5e8ddc89 Shuo Liu      2021-02-07  287  	/* Inform the ACRN Hypervisor to set up EPT mappings */
88f537d5e8ddc89 Shuo Liu      2021-02-07  288  	ret = hcall_set_memory_regions(virt_to_phys(regions_info));
88f537d5e8ddc89 Shuo Liu      2021-02-07  289  	if (ret < 0) {
88f537d5e8ddc89 Shuo Liu      2021-02-07  290  		dev_dbg(acrn_dev.this_device,
88f537d5e8ddc89 Shuo Liu      2021-02-07  291  			"Failed to set regions, VM[%u]!\n", vm->vmid);
88f537d5e8ddc89 Shuo Liu      2021-02-07  292  		goto unset_region;
88f537d5e8ddc89 Shuo Liu      2021-02-07  293  	}
88f537d5e8ddc89 Shuo Liu      2021-02-07  294  	kfree(regions_info);
88f537d5e8ddc89 Shuo Liu      2021-02-07  295  
88f537d5e8ddc89 Shuo Liu      2021-02-07  296  	dev_dbg(acrn_dev.this_device,
88f537d5e8ddc89 Shuo Liu      2021-02-07  297  		"%s: VM[%u] service-GVA[%pK] user-GPA[%pK] size[0x%llx]\n",
88f537d5e8ddc89 Shuo Liu      2021-02-07  298  		__func__, vm->vmid,
88f537d5e8ddc89 Shuo Liu      2021-02-07  299  		remap_vaddr, (void *)memmap->user_vm_pa, memmap->len);
88f537d5e8ddc89 Shuo Liu      2021-02-07  300  	return ret;
88f537d5e8ddc89 Shuo Liu      2021-02-07  301  
88f537d5e8ddc89 Shuo Liu      2021-02-07  302  unset_region:
88f537d5e8ddc89 Shuo Liu      2021-02-07  303  	kfree(regions_info);
88f537d5e8ddc89 Shuo Liu      2021-02-07  304  unmap_kernel_map:
88f537d5e8ddc89 Shuo Liu      2021-02-07  305  	mutex_lock(&vm->regions_mapping_lock);
88f537d5e8ddc89 Shuo Liu      2021-02-07  306  	vm->regions_mapping_count--;
88f537d5e8ddc89 Shuo Liu      2021-02-07  307  	mutex_unlock(&vm->regions_mapping_lock);
88f537d5e8ddc89 Shuo Liu      2021-02-07  308  unmap_no_count:
88f537d5e8ddc89 Shuo Liu      2021-02-07  309  	vunmap(remap_vaddr);
88f537d5e8ddc89 Shuo Liu      2021-02-07  310  put_pages:
88f537d5e8ddc89 Shuo Liu      2021-02-07  311  	for (i = 0; i < pinned; i++)
88f537d5e8ddc89 Shuo Liu      2021-02-07  312  		unpin_user_page(pages[i]);
88f537d5e8ddc89 Shuo Liu      2021-02-07  313  free_pages:
88f537d5e8ddc89 Shuo Liu      2021-02-07  314  	vfree(pages);
88f537d5e8ddc89 Shuo Liu      2021-02-07  315  	return ret;
88f537d5e8ddc89 Shuo Liu      2021-02-07  316  }
88f537d5e8ddc89 Shuo Liu      2021-02-07  317  

:::::: The code at line 177 was first introduced by commit
:::::: 8a6e85f75a83d16a71077e41f2720c691f432002 virt: acrn: obtain pa from VMA with PFNMAP flag

:::::: TO: Yonghua Huang <yonghua.huang@intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39786577281
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiGPXmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiGPXmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:42:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B2F1903A
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658014925; x=1689550925;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bF0oyXUZjhIjG50FPWj8h4YcMo4Z17EKwia92aSURfI=;
  b=at6u4H/hs234PmGtMU8wXSMzv1407EPgT4X5xJGptLtOWgd2OBxnuZPv
   t52224hIq70Igzt40e9L568H4IxMcHemdr4h5x/1TYfOIAqb8bvaTwp+/
   GFwQ4pCFQpgDwcTOgIh05Y0RnONcV4ByInbLpKOuwTddZRVzMZpB4y8LF
   k6De8hJ7FtTbquIUNyaSeWuRPynmYZeBDeTnl3l3iCETqoujErtxIiowG
   mvWPsZsPqAvySZ9rSiwhylC+xdrj7J6cUrZdL20H9nGzp6V8D8dBmBwXZ
   87Y7S2k7aaj7OwRzCBjzac9vWIo+1AaJcjyxNCfg9Ye3XuJrsMfinLjkX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="349976934"
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="349976934"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 16:42:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="571969229"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Jul 2022 16:42:03 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCrQ6-0002Ia-7t;
        Sat, 16 Jul 2022 23:41:58 +0000
Date:   Sun, 17 Jul 2022 07:41:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 13/23]
 kernel/dma/swiotlb.c:531:75: warning: suggest parentheses around '-' in
 operand of '&'
Message-ID: <202207170722.7onSclOe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-hardening-rebased
head:   c170462888e1dab8e3e80c1c6e3708dd473ad1ed
commit: 294874a30f655fe082a24e1ca1aa3cafe41d00fd [13/23] swiotlb: Allocate memory in a cache-friendly way
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220717/202207170722.7onSclOe-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/294874a30f655fe082a24e1ca1aa3cafe41d00fd
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout 294874a30f655fe082a24e1ca1aa3cafe41d00fd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/dma/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/dma/swiotlb.c: In function 'swiotlb_find_slots':
>> kernel/dma/swiotlb.c:531:75: warning: suggest parentheses around '-' in operand of '&' [-Wparentheses]
     531 |                 if (alloc_align_mask && (slot_dma_addr & alloc_align_mask - 1))
         |                                                          ~~~~~~~~~~~~~~~~~^~~


vim +531 kernel/dma/swiotlb.c

   487	
   488	/*
   489	 * Find a suitable number of IO TLB entries size that will fit this request and
   490	 * allocate a buffer from that IO TLB pool.
   491	 */
   492	static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
   493				      size_t alloc_size, unsigned int alloc_align_mask)
   494	{
   495		struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
   496		struct io_tlb_slot *slot, *tmp;
   497		unsigned long boundary_mask = dma_get_seg_boundary(dev);
   498		dma_addr_t tbl_dma_addr =
   499			phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
   500		dma_addr_t slot_dma_addr;
   501		unsigned long max_slots = get_max_slots(boundary_mask);
   502		unsigned int iotlb_align_mask =
   503			dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
   504		unsigned int nslots = nr_slots(alloc_size);
   505		unsigned int index, i;
   506		unsigned int offset = swiotlb_align_offset(dev, orig_addr);
   507		unsigned long flags;
   508	
   509		BUG_ON(!nslots);
   510	
   511		spin_lock_irqsave(&mem->lock, flags);
   512		if (unlikely(nslots > mem->nslabs - mem->used))
   513			goto not_found;
   514	
   515		list_for_each_entry_safe(slot, tmp, &mem->free_slots, node) {
   516			index = slot - mem->slots;
   517			slot_dma_addr = slot_addr(tbl_dma_addr, index);
   518			if (orig_addr &&
   519			    (slot_dma_addr & iotlb_align_mask) !=
   520				    (orig_addr & iotlb_align_mask)) {
   521				continue;
   522			}
   523			/*
   524			 * If requested size is larger than a page, ensure allocated
   525			 * memory to be page aligned.
   526			 */
   527			if (alloc_size >= PAGE_SIZE && (slot_dma_addr & ~PAGE_MASK))
   528				continue;
   529	
   530			/* Ensure requested alignment is met */
 > 531			if (alloc_align_mask && (slot_dma_addr & alloc_align_mask - 1))
   532				continue;
   533	
   534			if (io_tlb_offset(index) + nslots > IO_TLB_SEGSIZE)
   535				continue;
   536	
   537			/*
   538			 * If we find a slot that indicates we have 'nslots' number of
   539			 * contiguous buffers, we allocate the buffers from that slot
   540			 * and mark the entries as '0' indicating unavailable.
   541			 */
   542			if (!iommu_is_span_boundary(index, nslots,
   543						    nr_slots(tbl_dma_addr),
   544						    max_slots)) {
   545				if (find_next_zero_bit(mem->bitmap, index + nslots, index) ==
   546						index + nslots)
   547					goto found;
   548			}
   549		}
   550	
   551	not_found:
   552		spin_unlock_irqrestore(&mem->lock, flags);
   553		return -1;
   554	
   555	found:
   556		for (i = index; i < index + nslots; i++) {
   557			__clear_bit(i, mem->bitmap);
   558			mem->slots[i].alloc_size =
   559				alloc_size - (offset + ((i - index) << IO_TLB_SHIFT));
   560			list_del(&mem->slots[i].node);
   561		}
   562	
   563		mem->used += nslots;
   564	
   565		spin_unlock_irqrestore(&mem->lock, flags);
   566		return index;
   567	}
   568	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

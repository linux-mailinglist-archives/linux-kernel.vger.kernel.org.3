Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8003A494A82
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241284AbiATJN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:13:58 -0500
Received: from mga01.intel.com ([192.55.52.88]:40621 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237469AbiATJN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642670036; x=1674206036;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cK8fG4NQ1lLYtkh+oYSvCamKhc4CeZkehTuxWGKWaiA=;
  b=c3enh4VcQpKaRuZTxHBac+TmRIqJ8yMk/IjITBxJJfN7lr+vMMdNnc6d
   yyNxgdlUZl8onYjXGjjga+lvOXFjQWlv+1w2ZY6nFuB0v68EQOF1DMlmH
   OANxfFa56ikPEXGrwEnbprJ39xqrNLk27+kZD9IS21jf89atP/U69oLSe
   ATKzQAQUzxzsglX+G/jrQwxaUWwm5e+n/8L+/hMeLxksZ1XH3lQwzhbOu
   UzeRXmbkHlXCvlb8xI43pQD3mvq324AP3iY4rHioDOkPlsXyOif3rVoWb
   Z2ghx2Xq3Ihz7HFsvjiBjLfILtbUDM1In6oUHWHdKpaZMHtJwuJvt+kWc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="269706628"
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="269706628"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 01:13:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="518542720"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 20 Jan 2022 01:13:54 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nATVy-000EAd-8T; Thu, 20 Jan 2022 09:13:54 +0000
Date:   Thu, 20 Jan 2022 17:13:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guangming <Guangming.Cao@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: drivers/dma-buf/heaps/system_heap.c:357:24: sparse: sparse:
 incorrect type in return expression (different base types)
Message-ID: <202201201703.UusZsskM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220120-113516/guangming-cao-mediatek-com/dma-buf-dma-heap-Add-a-size-limitation-for-allocation/20211217-174135
head:   d6d3f09d899553b1100b195a91a8f718d1bd6bc2
commit: d6d3f09d899553b1100b195a91a8f718d1bd6bc2 dma-buf: system_heap: Add a size check for allocation
date:   6 hours ago
config: sh-randconfig-s031-20220117 (https://download.01.org/0day-ci/archive/20220120/202201201703.UusZsskM-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/d6d3f09d899553b1100b195a91a8f718d1bd6bc2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20220120-113516/guangming-cao-mediatek-com/dma-buf-dma-heap-Add-a-size-limitation-for-allocation/20211217-174135
        git checkout d6d3f09d899553b1100b195a91a8f718d1bd6bc2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash drivers/dma-buf/heaps/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/dma-buf/heaps/system_heap.c:357:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected struct dma_buf * @@     got int @@
   drivers/dma-buf/heaps/system_heap.c:357:24: sparse:     expected struct dma_buf *
   drivers/dma-buf/heaps/system_heap.c:357:24: sparse:     got int

vim +357 drivers/dma-buf/heaps/system_heap.c

   334	
   335	static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
   336						    unsigned long len,
   337						    unsigned long fd_flags,
   338						    unsigned long heap_flags)
   339	{
   340		struct system_heap_buffer *buffer;
   341		DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
   342		unsigned long size_remaining = len;
   343		unsigned int max_order = orders[0];
   344		struct dma_buf *dmabuf;
   345		struct sg_table *table;
   346		struct scatterlist *sg;
   347		struct list_head pages;
   348		struct page *page, *tmp_page;
   349		int i, ret = -ENOMEM;
   350	
   351		/*
   352		 * Size check. The "len" should be less than totalram since system_heap
   353		 * memory is comes from system. Adding check here can prevent consuming
   354		 * too much time for invalid allocations.
   355		 */
   356		if (len >> PAGE_SHIFT > totalram_pages())
 > 357			return -EINVAL;
   358		buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
   359		if (!buffer)
   360			return ERR_PTR(-ENOMEM);
   361	
   362		INIT_LIST_HEAD(&buffer->attachments);
   363		mutex_init(&buffer->lock);
   364		buffer->heap = heap;
   365		buffer->len = len;
   366	
   367		INIT_LIST_HEAD(&pages);
   368		i = 0;
   369		while (size_remaining > 0) {
   370			/*
   371			 * Avoid trying to allocate memory if the process
   372			 * has been killed by SIGKILL
   373			 */
   374			if (fatal_signal_pending(current)) {
   375				ret = -EINTR;
   376				goto free_buffer;
   377			}
   378	
   379			page = alloc_largest_available(size_remaining, max_order);
   380			if (!page)
   381				goto free_buffer;
   382	
   383			list_add_tail(&page->lru, &pages);
   384			size_remaining -= page_size(page);
   385			max_order = compound_order(page);
   386			i++;
   387		}
   388	
   389		table = &buffer->sg_table;
   390		if (sg_alloc_table(table, i, GFP_KERNEL))
   391			goto free_buffer;
   392	
   393		sg = table->sgl;
   394		list_for_each_entry_safe(page, tmp_page, &pages, lru) {
   395			sg_set_page(sg, page, page_size(page), 0);
   396			sg = sg_next(sg);
   397			list_del(&page->lru);
   398		}
   399	
   400		/* create the dmabuf */
   401		exp_info.exp_name = dma_heap_get_name(heap);
   402		exp_info.ops = &system_heap_buf_ops;
   403		exp_info.size = buffer->len;
   404		exp_info.flags = fd_flags;
   405		exp_info.priv = buffer;
   406		dmabuf = dma_buf_export(&exp_info);
   407		if (IS_ERR(dmabuf)) {
   408			ret = PTR_ERR(dmabuf);
   409			goto free_pages;
   410		}
   411		return dmabuf;
   412	
   413	free_pages:
   414		for_each_sgtable_sg(table, sg, i) {
   415			struct page *p = sg_page(sg);
   416	
   417			__free_pages(p, compound_order(p));
   418		}
   419		sg_free_table(table);
   420	free_buffer:
   421		list_for_each_entry_safe(page, tmp_page, &pages, lru)
   422			__free_pages(page, compound_order(page));
   423		kfree(buffer);
   424	
   425		return ERR_PTR(ret);
   426	}
   427	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

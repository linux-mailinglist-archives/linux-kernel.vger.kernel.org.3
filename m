Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FE24BEA9B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiBUS4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:56:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiBUS4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:56:03 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26368111
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 10:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645469740; x=1677005740;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jkRLGIfqXS24d0An72RVRQY19IUIuY+vYtpRSavSads=;
  b=g9NvtysNZQ/eTROrtSqR+TsfT2tdNaiF2N60tMt+5N7VHr7992PhC9K6
   E0hDLG7VSeMs6eC/hJz71o99qUqSbNY3CIOQIbPrVfRByx1kCVPqh1f9i
   sSQ4Ug4oIE2ZV1utalv/zLagKgPHToFDOYxjT0LiihRi/dHfkwB8MHm/m
   8JTx5bTovjZn13rDFp+ZiXJWU4bKjxlRDtox2AvcDR40kBm9jnVpcKdA7
   EPgN/GB2dJ6Xe41x333qt95fnoKeYnR1FlQM5muyo3HMQiJkOrXjK6ObU
   VS96L5JdPczMsEXyGHlGwxwHaCZCKHv9CCduXAvdW70A3eVLJ2Dw8ToIn
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="251314242"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="251314242"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 10:55:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="776071957"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 21 Feb 2022 10:55:38 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMDqT-0001tr-Fx; Mon, 21 Feb 2022 18:55:37 +0000
Date:   Tue, 22 Feb 2022 02:55:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ohad Sharabi <osharabi@habana.ai>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Oded Gabbay <ogabbay@kernel.org>
Subject: [ogabbay:habanalabs-next 46/47]
 drivers/misc/habanalabs/common/memory.c:114:33: warning: cast from pointer
 to integer of different size
Message-ID: <202202220233.tn8HeY3b-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git habanalabs-next
head:   8cdf815f29cb63929861473c69d7f969291452a4
commit: 6049dde7033922e889e7decf18fbc2863f8b16f9 [46/47] habanalabs: make sure device mem alloc is page aligned
config: m68k-randconfig-r035-20220221 (https://download.01.org/0day-ci/archive/20220222/202202220233.tn8HeY3b-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=6049dde7033922e889e7decf18fbc2863f8b16f9
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay habanalabs-next
        git checkout 6049dde7033922e889e7decf18fbc2863f8b16f9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/misc/habanalabs/common/memory.c: In function 'alloc_device_memory':
>> drivers/misc/habanalabs/common/memory.c:114:33: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     114 |                         paddr = (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool, total_size, NULL,
         |                                 ^
   drivers/misc/habanalabs/common/memory.c:153:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     153 |                                                 (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
         |                                                 ^

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SND_ISA
   Depends on SOUND && !UML && SND && (ISA || COMPILE_TEST && ISA_DMA_API && !M68K
   Selected by
   - RADIO_MIROPCM20 && MEDIA_SUPPORT && RADIO_ADAPTERS && V4L_RADIO_ISA_DRIVERS && (ISA || COMPILE_TEST && ISA_DMA_API && VIDEO_V4L2 && SND


vim +114 drivers/misc/habanalabs/common/memory.c

    51	
    52	/*
    53	 * The va ranges in context object contain a list with the available chunks of
    54	 * device virtual memory.
    55	 * There is one range for host allocations and one for DRAM allocations.
    56	 *
    57	 * On initialization each range contains one chunk of all of its available
    58	 * virtual range which is a half of the total device virtual range.
    59	 *
    60	 * On each mapping of physical pages, a suitable virtual range chunk (with a
    61	 * minimum size) is selected from the list. If the chunk size equals the
    62	 * requested size, the chunk is returned. Otherwise, the chunk is split into
    63	 * two chunks - one to return as result and a remainder to stay in the list.
    64	 *
    65	 * On each Unmapping of a virtual address, the relevant virtual chunk is
    66	 * returned to the list. The chunk is added to the list and if its edges match
    67	 * the edges of the adjacent chunks (means a contiguous chunk can be created),
    68	 * the chunks are merged.
    69	 *
    70	 * On finish, the list is checked to have only one chunk of all the relevant
    71	 * virtual range (which is a half of the device total virtual range).
    72	 * If not (means not all mappings were unmapped), a warning is printed.
    73	 */
    74	
    75	/*
    76	 * alloc_device_memory() - allocate device memory.
    77	 * @ctx: pointer to the context structure.
    78	 * @args: host parameters containing the requested size.
    79	 * @ret_handle: result handle.
    80	 *
    81	 * This function does the following:
    82	 * - Allocate the requested size rounded up to 'dram_page_size' pages.
    83	 * - Return unique handle for later map/unmap/free.
    84	 */
    85	static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
    86					u32 *ret_handle)
    87	{
    88		struct hl_device *hdev = ctx->hdev;
    89		struct hl_vm *vm = &hdev->vm;
    90		struct hl_vm_phys_pg_pack *phys_pg_pack;
    91		u64 paddr = 0, total_size, num_pgs, i;
    92		u32 num_curr_pgs, page_size;
    93		bool contiguous;
    94		int handle, rc;
    95	
    96		num_curr_pgs = 0;
    97	
    98		rc = set_alloc_page_size(hdev, args, &page_size);
    99		if (rc)
   100			return rc;
   101	
   102		num_pgs = DIV_ROUND_UP_ULL(args->alloc.mem_size, page_size);
   103		total_size = num_pgs * page_size;
   104	
   105		if (!total_size) {
   106			dev_err(hdev->dev, "Cannot allocate 0 bytes\n");
   107			return -EINVAL;
   108		}
   109	
   110		contiguous = args->flags & HL_MEM_CONTIGUOUS;
   111	
   112		if (contiguous) {
   113			if (is_power_of_2(page_size))
 > 114				paddr = (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool, total_size, NULL,
   115								page_size);
   116			else
   117				paddr = (u64) gen_pool_alloc(vm->dram_pg_pool, total_size);
   118			if (!paddr) {
   119				dev_err(hdev->dev,
   120					"failed to allocate %llu contiguous pages with total size of %llu\n",
   121					num_pgs, total_size);
   122				return -ENOMEM;
   123			}
   124		}
   125	
   126		phys_pg_pack = kzalloc(sizeof(*phys_pg_pack), GFP_KERNEL);
   127		if (!phys_pg_pack) {
   128			rc = -ENOMEM;
   129			goto pages_pack_err;
   130		}
   131	
   132		phys_pg_pack->vm_type = VM_TYPE_PHYS_PACK;
   133		phys_pg_pack->asid = ctx->asid;
   134		phys_pg_pack->npages = num_pgs;
   135		phys_pg_pack->page_size = page_size;
   136		phys_pg_pack->total_size = total_size;
   137		phys_pg_pack->flags = args->flags;
   138		phys_pg_pack->contiguous = contiguous;
   139	
   140		phys_pg_pack->pages = kvmalloc_array(num_pgs, sizeof(u64), GFP_KERNEL);
   141		if (ZERO_OR_NULL_PTR(phys_pg_pack->pages)) {
   142			rc = -ENOMEM;
   143			goto pages_arr_err;
   144		}
   145	
   146		if (phys_pg_pack->contiguous) {
   147			for (i = 0 ; i < num_pgs ; i++)
   148				phys_pg_pack->pages[i] = paddr + i * page_size;
   149		} else {
   150			for (i = 0 ; i < num_pgs ; i++) {
   151				if (is_power_of_2(page_size))
   152					phys_pg_pack->pages[i] =
   153							(u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
   154											page_size, NULL,
   155											page_size);
   156				else
   157					phys_pg_pack->pages[i] = (u64) gen_pool_alloc(vm->dram_pg_pool,
   158											page_size);
   159				if (!phys_pg_pack->pages[i]) {
   160					dev_err(hdev->dev,
   161						"Failed to allocate device memory (out of memory)\n");
   162					rc = -ENOMEM;
   163					goto page_err;
   164				}
   165	
   166				num_curr_pgs++;
   167			}
   168		}
   169	
   170		spin_lock(&vm->idr_lock);
   171		handle = idr_alloc(&vm->phys_pg_pack_handles, phys_pg_pack, 1, 0,
   172					GFP_ATOMIC);
   173		spin_unlock(&vm->idr_lock);
   174	
   175		if (handle < 0) {
   176			dev_err(hdev->dev, "Failed to get handle for page\n");
   177			rc = -EFAULT;
   178			goto idr_err;
   179		}
   180	
   181		for (i = 0 ; i < num_pgs ; i++)
   182			kref_get(&vm->dram_pg_pool_refcount);
   183	
   184		phys_pg_pack->handle = handle;
   185	
   186		atomic64_add(phys_pg_pack->total_size, &ctx->dram_phys_mem);
   187		atomic64_add(phys_pg_pack->total_size, &hdev->dram_used_mem);
   188	
   189		*ret_handle = handle;
   190	
   191		return 0;
   192	
   193	idr_err:
   194	page_err:
   195		if (!phys_pg_pack->contiguous)
   196			for (i = 0 ; i < num_curr_pgs ; i++)
   197				gen_pool_free(vm->dram_pg_pool, phys_pg_pack->pages[i],
   198						page_size);
   199	
   200		kvfree(phys_pg_pack->pages);
   201	pages_arr_err:
   202		kfree(phys_pg_pack);
   203	pages_pack_err:
   204		if (contiguous)
   205			gen_pool_free(vm->dram_pg_pool, paddr, total_size);
   206	
   207		return rc;
   208	}
   209	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

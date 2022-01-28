Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BCE4A0480
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351813AbiA1XsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:48:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:34000 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242914AbiA1XsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643413688; x=1674949688;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/8msM2VUnlqmgHypISLJUIjknUtMpcDdEmBx1rlEpm8=;
  b=HmGgP7WJV7zW6NjO/UguMcb6jYyyjX6x6PJIbhz624gpT+ZBa0hBgP7G
   85NZKcqLlwTt6DHiDfkB+tz/nAWbv2433bbsZMu+8ramGIZnl3RXbjhTN
   /NixCpf3pBzoTvh6FsZMZI7H6KA2AT/2WwPyij7BzMUR8m5oaXj4n3aFf
   5+rStTKfdXmqE/oA1z8GhSdu6FHvBWlsX8p4zmXQn3iGugqaWg+3AhreF
   tlKVPE0tS2Sk5uuvwFk18jyCQl01t7cqAf71Bq4LbxN9waPKRf+wmva5h
   bONkUx+P2MNtmhZdz9tswSGBtegkg8U3Av/l7Sf2RMe3QsmrwL9Jj6AaE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="246058668"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="246058668"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 15:48:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="770252229"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jan 2022 15:48:07 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDayM-000OSm-Hf; Fri, 28 Jan 2022 23:48:06 +0000
Date:   Sat, 29 Jan 2022 07:47:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     farah kassabri <fkassabri@habana.ai>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Oded Gabbay <ogabbay@kernel.org>
Subject: [ogabbay:habanalabs-next 32/33]
 drivers/misc/habanalabs/common/irq.c:178:5: warning: no previous prototype
 for 'handle_registration_node'
Message-ID: <202201290701.fKs5pg0E-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git habanalabs-next
head:   c720ae02be190b7639446bba872752a68cb4ba17
commit: 402f801a3488a90a5481524ea87c3da17867e635 [32/33] habanalabs: Timestamps buffers registration
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220129/202201290701.fKs5pg0E-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=402f801a3488a90a5481524ea87c3da17867e635
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay habanalabs-next
        git checkout 402f801a3488a90a5481524ea87c3da17867e635
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/misc/habanalabs/common/irq.c:178:5: warning: no previous prototype for 'handle_registration_node' [-Wmissing-prototypes]
     178 | int handle_registration_node(struct hl_device *hdev, struct hl_user_pending_interrupt *pend,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/misc/habanalabs/common/memory.c: In function 'ts_buff_release':
   drivers/misc/habanalabs/common/memory.c:2046:9: error: implicit declaration of function 'vfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
    2046 |         vfree(buff->kernel_buff_address);
         |         ^~~~~
         |         kvfree
   drivers/misc/habanalabs/common/memory.c: In function 'hl_ts_mmap':
   drivers/misc/habanalabs/common/memory.c:2150:14: error: implicit declaration of function 'remap_vmalloc_range'; did you mean 'ida_alloc_range'? [-Werror=implicit-function-declaration]
    2150 |         rc = remap_vmalloc_range(vma, buff->user_buff_address, 0);
         |              ^~~~~~~~~~~~~~~~~~~
         |              ida_alloc_range
   drivers/misc/habanalabs/common/memory.c: In function 'hl_ts_alloc_buff':
   drivers/misc/habanalabs/common/memory.c:2201:13: error: implicit declaration of function 'vmalloc_user'; did you mean 'kmalloc_order'? [-Werror=implicit-function-declaration]
    2201 |         p = vmalloc_user(size);
         |             ^~~~~~~~~~~~
         |             kmalloc_order
>> drivers/misc/habanalabs/common/memory.c:2201:11: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    2201 |         p = vmalloc_user(size);
         |           ^
   drivers/misc/habanalabs/common/memory.c:2210:13: error: implicit declaration of function 'vmalloc'; did you mean 'kvmalloc'? [-Werror=implicit-function-declaration]
    2210 |         p = vmalloc(size);
         |             ^~~~~~~
         |             kvmalloc
   drivers/misc/habanalabs/common/memory.c:2210:11: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    2210 |         p = vmalloc(size);
         |           ^
   cc1: some warnings being treated as errors


vim +/handle_registration_node +178 drivers/misc/habanalabs/common/irq.c

   167	
   168	/*
   169	 * This function called with spin_lock of wait_list_lock taken
   170	 * This function will set timestamp and delete the registration node from the
   171	 * wait_list_lock.
   172	 * and since we're protected with spin_lock here, so we cannot just put the refcount
   173	 * for the objects here, since the release function may be called and it's also a long
   174	 * logic (which might sleep also) that cannot be handled in irq context.
   175	 * so here we'll be filling a list with nodes of "put" jobs and then will send this
   176	 * list to a dedicated workqueue to do the actual put.
   177	 */
 > 178	int handle_registration_node(struct hl_device *hdev, struct hl_user_pending_interrupt *pend,
   179							struct list_head **free_list)
   180	{
   181		struct timestamp_reg_free_node *free_node;
   182		u64 timestamp;
   183	
   184		if (!(*free_list)) {
   185			/* Alloc/Init the timestamp registration free objects list */
   186			*free_list = kmalloc(sizeof(struct list_head), GFP_ATOMIC);
   187			if (!(*free_list))
   188				return -ENOMEM;
   189	
   190			INIT_LIST_HEAD(*free_list);
   191		}
   192	
   193		free_node = kmalloc(sizeof(*free_node), GFP_ATOMIC);
   194		if (!free_node)
   195			return -ENOMEM;
   196	
   197		timestamp = ktime_get_ns();
   198	
   199		*pend->ts_reg_info.timestamp_kernel_addr = timestamp;
   200	
   201		dev_dbg(hdev->dev, "Timestamp is set to ts cb address (%p), ts: 0x%llx\n",
   202				pend->ts_reg_info.timestamp_kernel_addr,
   203				*(u64 *)pend->ts_reg_info.timestamp_kernel_addr);
   204	
   205		list_del(&pend->wait_list_node);
   206	
   207		/* Mark kernel CB node as free */
   208		pend->ts_reg_info.in_use = 0;
   209	
   210		/* Putting the refcount for ts_buff and cq_cb objects will be handled
   211		 * in workqueue context, just add job to free_list.
   212		 */
   213		free_node->ts_buff = pend->ts_reg_info.ts_buff;
   214		free_node->cq_cb = pend->ts_reg_info.cq_cb;
   215		list_add(&free_node->free_objects_node, *free_list);
   216	
   217		return 0;
   218	}
   219	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

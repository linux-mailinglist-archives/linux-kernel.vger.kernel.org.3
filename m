Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC5A4B3C26
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 16:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbiBMPrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 10:47:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiBMPrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 10:47:06 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17D95F8D1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 07:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644767220; x=1676303220;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Eu2lNFHw9gZD5FS1UCfmtR5lsQf+5JS20XXMIEG5kFc=;
  b=YJvpPvebqSdWRL+1RijUg1aXyY/CWmGiKZ2hDwRcHK2l1i72btw0On72
   klBLtbB/nrDsnE8yD+yxpIKbdiyB82HcWDc0rNwbyISOkop9jia0nztJB
   HWAYF/aXuBQtcLCIuKmt3/cUpeVAFYZMaVUZtb16lWlI5c8NVSjBrUtIV
   bY+WftumhjIpHmklMdd45KNiT9W9TZIOKfJqXJNv1ahw0aSjZM6zwWSG1
   xpPY0JseKuDYVn6nPY/8ld5+ouM89ZHmUpnYMPsvFbnGdjwdyFzYYZzPw
   ntM5xGnFElQkpk5pQTktBCHBELdDz0VDjWlAx+KdDCPiFUL5wrE0AdMJn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="250163807"
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="250163807"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 07:47:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="569575771"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Feb 2022 07:46:58 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJH5V-0007bB-QI; Sun, 13 Feb 2022 15:46:57 +0000
Date:   Sun, 13 Feb 2022 23:46:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anatolij Gustschin <agust@denx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: drivers/dma/bestcomm/bestcomm.c:98:30: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202202132337.6w53hDke-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
commit: adec566b05288f2787a1f88dbaf77ed8b0c644fa dmaengine: bestcomm: fix system boot lockups
date:   4 months ago
config: powerpc-randconfig-s032-20220213 (https://download.01.org/0day-ci/archive/20220213/202202132337.6w53hDke-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=adec566b05288f2787a1f88dbaf77ed8b0c644fa
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout adec566b05288f2787a1f88dbaf77ed8b0c644fa
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/dma/bestcomm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/dma/bestcomm/bestcomm.c:98:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got struct bcom_bd *bd @@
   drivers/dma/bestcomm/bestcomm.c:98:30: sparse:     expected void volatile [noderef] __iomem *a
   drivers/dma/bestcomm/bestcomm.c:98:30: sparse:     got struct bcom_bd *bd
>> drivers/dma/bestcomm/bestcomm.c:189:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got unsigned int [usertype] *[assigned] var @@
   drivers/dma/bestcomm/bestcomm.c:189:19: sparse:     expected void volatile [noderef] __iomem *a
   drivers/dma/bestcomm/bestcomm.c:189:19: sparse:     got unsigned int [usertype] *[assigned] var
>> drivers/dma/bestcomm/bestcomm.c:190:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got unsigned int [usertype] *[assigned] inc @@
   drivers/dma/bestcomm/bestcomm.c:190:19: sparse:     expected void volatile [noderef] __iomem *a
   drivers/dma/bestcomm/bestcomm.c:190:19: sparse:     got unsigned int [usertype] *[assigned] inc
>> drivers/dma/bestcomm/bestcomm.c:196:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got unsigned int [usertype] *[assigned] desc @@
   drivers/dma/bestcomm/bestcomm.c:196:21: sparse:     expected void volatile [noderef] __iomem *d
   drivers/dma/bestcomm/bestcomm.c:196:21: sparse:     got unsigned int [usertype] *[assigned] desc
>> drivers/dma/bestcomm/bestcomm.c:197:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got unsigned int [usertype] * @@
   drivers/dma/bestcomm/bestcomm.c:197:25: sparse:     expected void volatile [noderef] __iomem *d
   drivers/dma/bestcomm/bestcomm.c:197:25: sparse:     got unsigned int [usertype] *
>> drivers/dma/bestcomm/bestcomm.c:198:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got unsigned int [usertype] *[assigned] inc @@
   drivers/dma/bestcomm/bestcomm.c:198:21: sparse:     expected void volatile [noderef] __iomem *d
   drivers/dma/bestcomm/bestcomm.c:198:21: sparse:     got unsigned int [usertype] *[assigned] inc
>> drivers/dma/bestcomm/bestcomm.c:305:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got struct bcom_tdt *tdt @@
   drivers/dma/bestcomm/bestcomm.c:305:27: sparse:     expected void volatile [noderef] __iomem *a
   drivers/dma/bestcomm/bestcomm.c:305:27: sparse:     got struct bcom_tdt *tdt
>> drivers/dma/bestcomm/bestcomm.c:306:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got unsigned int [usertype] *ctx @@
   drivers/dma/bestcomm/bestcomm.c:306:27: sparse:     expected void volatile [noderef] __iomem *a
   drivers/dma/bestcomm/bestcomm.c:306:27: sparse:     got unsigned int [usertype] *ctx
>> drivers/dma/bestcomm/bestcomm.c:307:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got unsigned int [usertype] *var @@
   drivers/dma/bestcomm/bestcomm.c:307:27: sparse:     expected void volatile [noderef] __iomem *a
   drivers/dma/bestcomm/bestcomm.c:307:27: sparse:     got unsigned int [usertype] *var
>> drivers/dma/bestcomm/bestcomm.c:308:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got unsigned int [usertype] *fdt @@
   drivers/dma/bestcomm/bestcomm.c:308:27: sparse:     expected void volatile [noderef] __iomem *a
   drivers/dma/bestcomm/bestcomm.c:308:27: sparse:     got unsigned int [usertype] *fdt
   drivers/dma/bestcomm/bestcomm.c:311:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got unsigned int [usertype] * @@
   drivers/dma/bestcomm/bestcomm.c:311:35: sparse:     expected void volatile [noderef] __iomem *d
   drivers/dma/bestcomm/bestcomm.c:311:35: sparse:     got unsigned int [usertype] *

vim +98 drivers/dma/bestcomm/bestcomm.c

    48	
    49	struct bcom_task *
    50	bcom_task_alloc(int bd_count, int bd_size, int priv_size)
    51	{
    52		int i, tasknum = -1;
    53		struct bcom_task *tsk;
    54	
    55		/* Don't try to do anything if bestcomm init failed */
    56		if (!bcom_eng)
    57			return NULL;
    58	
    59		/* Get and reserve a task num */
    60		spin_lock(&bcom_eng->lock);
    61	
    62		for (i=0; i<BCOM_MAX_TASKS; i++)
    63			if (!bcom_eng->tdt[i].stop) {	/* we use stop as a marker */
    64				bcom_eng->tdt[i].stop = 0xfffffffful; /* dummy addr */
    65				tasknum = i;
    66				break;
    67			}
    68	
    69		spin_unlock(&bcom_eng->lock);
    70	
    71		if (tasknum < 0)
    72			return NULL;
    73	
    74		/* Allocate our structure */
    75		tsk = kzalloc(sizeof(struct bcom_task) + priv_size, GFP_KERNEL);
    76		if (!tsk)
    77			goto error;
    78	
    79		tsk->tasknum = tasknum;
    80		if (priv_size)
    81			tsk->priv = (void*)tsk + sizeof(struct bcom_task);
    82	
    83		/* Get IRQ of that task */
    84		tsk->irq = irq_of_parse_and_map(bcom_eng->ofnode, tsk->tasknum);
    85		if (!tsk->irq)
    86			goto error;
    87	
    88		/* Init the BDs, if needed */
    89		if (bd_count) {
    90			tsk->cookie = kmalloc_array(bd_count, sizeof(void *),
    91						    GFP_KERNEL);
    92			if (!tsk->cookie)
    93				goto error;
    94	
    95			tsk->bd = bcom_sram_alloc(bd_count * bd_size, 4, &tsk->bd_pa);
    96			if (!tsk->bd)
    97				goto error;
  > 98			memset_io(tsk->bd, 0x00, bd_count * bd_size);
    99	
   100			tsk->num_bd = bd_count;
   101			tsk->bd_size = bd_size;
   102		}
   103	
   104		return tsk;
   105	
   106	error:
   107		if (tsk) {
   108			if (tsk->irq)
   109				irq_dispose_mapping(tsk->irq);
   110			bcom_sram_free(tsk->bd);
   111			kfree(tsk->cookie);
   112			kfree(tsk);
   113		}
   114	
   115		bcom_eng->tdt[tasknum].stop = 0;
   116	
   117		return NULL;
   118	}
   119	EXPORT_SYMBOL_GPL(bcom_task_alloc);
   120	
   121	void
   122	bcom_task_free(struct bcom_task *tsk)
   123	{
   124		/* Stop the task */
   125		bcom_disable_task(tsk->tasknum);
   126	
   127		/* Clear TDT */
   128		bcom_eng->tdt[tsk->tasknum].start = 0;
   129		bcom_eng->tdt[tsk->tasknum].stop  = 0;
   130	
   131		/* Free everything */
   132		irq_dispose_mapping(tsk->irq);
   133		bcom_sram_free(tsk->bd);
   134		kfree(tsk->cookie);
   135		kfree(tsk);
   136	}
   137	EXPORT_SYMBOL_GPL(bcom_task_free);
   138	
   139	int
   140	bcom_load_image(int task, u32 *task_image)
   141	{
   142		struct bcom_task_header *hdr = (struct bcom_task_header *)task_image;
   143		struct bcom_tdt *tdt;
   144		u32 *desc, *var, *inc;
   145		u32 *desc_src, *var_src, *inc_src;
   146	
   147		/* Safety checks */
   148		if (hdr->magic != BCOM_TASK_MAGIC) {
   149			printk(KERN_ERR DRIVER_NAME
   150				": Trying to load invalid microcode\n");
   151			return -EINVAL;
   152		}
   153	
   154		if ((task < 0) || (task >= BCOM_MAX_TASKS)) {
   155			printk(KERN_ERR DRIVER_NAME
   156				": Trying to load invalid task %d\n", task);
   157			return -EINVAL;
   158		}
   159	
   160		/* Initial load or reload */
   161		tdt = &bcom_eng->tdt[task];
   162	
   163		if (tdt->start) {
   164			desc = bcom_task_desc(task);
   165			if (hdr->desc_size != bcom_task_num_descs(task)) {
   166				printk(KERN_ERR DRIVER_NAME
   167					": Trying to reload wrong task image "
   168					"(%d size %d/%d)!\n",
   169					task,
   170					hdr->desc_size,
   171					bcom_task_num_descs(task));
   172				return -EINVAL;
   173			}
   174		} else {
   175			phys_addr_t start_pa;
   176	
   177			desc = bcom_sram_alloc(hdr->desc_size * sizeof(u32), 4, &start_pa);
   178			if (!desc)
   179				return -ENOMEM;
   180	
   181			tdt->start = start_pa;
   182			tdt->stop = start_pa + ((hdr->desc_size-1) * sizeof(u32));
   183		}
   184	
   185		var = bcom_task_var(task);
   186		inc = bcom_task_inc(task);
   187	
   188		/* Clear & copy */
 > 189		memset_io(var, 0x00, BCOM_VAR_SIZE);
 > 190		memset_io(inc, 0x00, BCOM_INC_SIZE);
   191	
   192		desc_src = (u32 *)(hdr + 1);
   193		var_src = desc_src + hdr->desc_size;
   194		inc_src = var_src + hdr->var_size;
   195	
 > 196		memcpy_toio(desc, desc_src, hdr->desc_size * sizeof(u32));
 > 197		memcpy_toio(var + hdr->first_var, var_src, hdr->var_size * sizeof(u32));
 > 198		memcpy_toio(inc, inc_src, hdr->inc_size * sizeof(u32));
   199	
   200		return 0;
   201	}
   202	EXPORT_SYMBOL_GPL(bcom_load_image);
   203	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

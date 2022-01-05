Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344E6485265
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240002AbiAEMY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 07:24:58 -0500
Received: from mga14.intel.com ([192.55.52.115]:13477 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239995AbiAEMYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641385484; x=1672921484;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r5JZLyr11z0Z51lLLunHx6t0CsMuvI0PaO1r39W4iYE=;
  b=IZjn/3z9F+hWz3ZKqSEglWGdlQu/NAPCxMU8MRh65OvO5QlAZvQUFPyn
   3W+yrKxNXiHt4lJua1hvFFOf/Y03TPD34duJwOUMGRyoATXG7UphKqpOc
   d70bty4c2duDGwSNytx6+6LcsHrfHccEURQuhOO5afX1hUeQw4TmCMgf+
   9skYqHgeu79D1wRW8VGKtRTjmciyRnWE7UikrN9GbFzE1AriYpe5FhSZq
   XFLGk4gJxsUyZOCj0cljOAc9LCNNMzXxj2npO1fbce7UjOkyvoFR03QYQ
   pc2tqEF5xe2YRfRCggou7slqFGfcWGVDro4OqylRvc9SKWEV+eEbS7MXI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242635154"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="242635154"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 04:24:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="688959827"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 05 Jan 2022 04:24:38 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n55LK-000Gad-7J; Wed, 05 Jan 2022 12:24:38 +0000
Date:   Wed, 5 Jan 2022 20:24:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [narmstrong-oxnas:oxnas/v5.18/dma 2/4]
 drivers/dma/oxnas_adma.c:355:45: warning: format '%x' expects argument of
 type 'unsigned int', but argument 6 has type 'dma_addr_t' {aka 'long long
 unsigned int'}
Message-ID: <202201052040.tCKTvGRC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git oxnas/v5.18/dma
head:   8a4b70b0d54020bfae32041369422c3b41c0cd56
commit: 90ad9e59c40581027a2fd9134e4e160ad0a7f5d2 [2/4] dmaengine: Add Oxford Semiconductor OXNAS DMA Controller
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220105/202201052040.tCKTvGRC-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git/commit/?id=90ad9e59c40581027a2fd9134e4e160ad0a7f5d2
        git remote add narmstrong-oxnas https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git
        git fetch --no-tags narmstrong-oxnas oxnas/v5.18/dma
        git checkout 90ad9e59c40581027a2fd9134e4e160ad0a7f5d2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/ata/ drivers/dma/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:555,
                    from include/linux/numa.h:24,
                    from arch/ia64/include/asm/nodedata.h:14,
                    from arch/ia64/include/asm/processor.h:81,
                    from arch/ia64/include/asm/timex.h:15,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/dma/oxnas_adma.c:7:
   drivers/dma/oxnas_adma.c: In function 'oxnas_dma_start_next':
>> drivers/dma/oxnas_adma.c:355:45: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
     355 |                 dev_dbg(&dmadev->pdev->dev, "ch%d: started req %d from %08x to %08x, %lubytes\n",
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/dma/oxnas_adma.c:355:17: note: in expansion of macro 'dev_dbg'
     355 |                 dev_dbg(&dmadev->pdev->dev, "ch%d: started req %d from %08x to %08x, %lubytes\n",
         |                 ^~~~~~~
   drivers/dma/oxnas_adma.c:355:75: note: format string is defined here
     355 |                 dev_dbg(&dmadev->pdev->dev, "ch%d: started req %d from %08x to %08x, %lubytes\n",
         |                                                                        ~~~^
         |                                                                           |
         |                                                                           unsigned int
         |                                                                        %08llx
   In file included from include/linux/printk.h:555,
                    from include/linux/numa.h:24,
                    from arch/ia64/include/asm/nodedata.h:14,
                    from arch/ia64/include/asm/processor.h:81,
                    from arch/ia64/include/asm/timex.h:15,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/dma/oxnas_adma.c:7:
   drivers/dma/oxnas_adma.c:355:45: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
     355 |                 dev_dbg(&dmadev->pdev->dev, "ch%d: started req %d from %08x to %08x, %lubytes\n",
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/dma/oxnas_adma.c:355:17: note: in expansion of macro 'dev_dbg'
     355 |                 dev_dbg(&dmadev->pdev->dev, "ch%d: started req %d from %08x to %08x, %lubytes\n",
         |                 ^~~~~~~
   drivers/dma/oxnas_adma.c:355:83: note: format string is defined here
     355 |                 dev_dbg(&dmadev->pdev->dev, "ch%d: started req %d from %08x to %08x, %lubytes\n",
         |                                                                                ~~~^
         |                                                                                   |
         |                                                                                   unsigned int
         |                                                                                %08llx
   In file included from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from drivers/dma/oxnas_adma.c:13:
   drivers/dma/oxnas_adma.c: In function 'oxnas_dma_prep_slave_sg':
>> drivers/dma/oxnas_adma.c:450:53: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'phys_addr_t' {aka 'long long unsigned int'} [-Wformat=]
     450 |                         dev_err(&dmadev->pdev->dev, "invalid memory address %08x\n",
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/dma/oxnas_adma.c:450:25: note: in expansion of macro 'dev_err'
     450 |                         dev_err(&dmadev->pdev->dev, "invalid memory address %08x\n",
         |                         ^~~~~~~
   drivers/dma/oxnas_adma.c:450:80: note: format string is defined here
     450 |                         dev_err(&dmadev->pdev->dev, "invalid memory address %08x\n",
         |                                                                             ~~~^
         |                                                                                |
         |                                                                                unsigned int
         |                                                                             %08llx
   In file included from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from drivers/dma/oxnas_adma.c:13:
   drivers/dma/oxnas_adma.c:462:53: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'phys_addr_t' {aka 'long long unsigned int'} [-Wformat=]
     462 |                         dev_err(&dmadev->pdev->dev, "invalid memory address %08x\n",
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/dma/oxnas_adma.c:462:25: note: in expansion of macro 'dev_err'
     462 |                         dev_err(&dmadev->pdev->dev, "invalid memory address %08x\n",
         |                         ^~~~~~~
   drivers/dma/oxnas_adma.c:462:80: note: format string is defined here
     462 |                         dev_err(&dmadev->pdev->dev, "invalid memory address %08x\n",
         |                                                                             ~~~^
         |                                                                                |
         |                                                                                unsigned int
         |                                                                             %08llx
   In file included from include/linux/printk.h:555,
                    from include/linux/numa.h:24,
                    from arch/ia64/include/asm/nodedata.h:14,
                    from arch/ia64/include/asm/processor.h:81,
                    from arch/ia64/include/asm/timex.h:15,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/dma/oxnas_adma.c:7:
   drivers/dma/oxnas_adma.c:500:37: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
     500 |         dev_dbg(&dmadev->pdev->dev, "got entry %p (%08x)\n", entry_dev, entry_dev->this_paddr);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/dma/oxnas_adma.c:500:9: note: in expansion of macro 'dev_dbg'
     500 |         dev_dbg(&dmadev->pdev->dev, "got entry %p (%08x)\n", entry_dev, entry_dev->this_paddr);
         |         ^~~~~~~
   drivers/dma/oxnas_adma.c:500:55: note: format string is defined here
     500 |         dev_dbg(&dmadev->pdev->dev, "got entry %p (%08x)\n", entry_dev, entry_dev->this_paddr);
         |                                                    ~~~^
         |                                                       |
         |                                                       unsigned int
         |                                                    %08llx
   In file included from include/linux/printk.h:555,
                    from include/linux/numa.h:24,
                    from arch/ia64/include/asm/nodedata.h:14,
                    from arch/ia64/include/asm/processor.h:81,
                    from arch/ia64/include/asm/timex.h:15,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/dma/oxnas_adma.c:7:
   drivers/dma/oxnas_adma.c:520:37: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
     520 |         dev_dbg(&dmadev->pdev->dev, "src = %p (%08x) dst = %p (%08x)\n",
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/dma/oxnas_adma.c:520:9: note: in expansion of macro 'dev_dbg'


vim +355 drivers/dma/oxnas_adma.c

   298	
   299	static void oxnas_dma_start_next(struct oxnas_dma_channel *channel)
   300	{
   301		struct oxnas_dma_device *dmadev = channel->dmadev;
   302		struct virt_dma_desc *vd = vchan_next_desc(&channel->vc);
   303		struct oxnas_dma_desc *desc;
   304		unsigned long ctrl_status;
   305	
   306		if (!vd) {
   307			channel->cur = NULL;
   308			return;
   309		}
   310	
   311		list_del(&vd->node);
   312	
   313		desc = container_of(&vd->tx, struct oxnas_dma_desc, vd.tx);
   314		channel->cur = desc;
   315	
   316		if (desc->type == OXNAS_DMA_TYPE_SIMPLE) {
   317			/* Write the control/status value to the DMAC */
   318			writel(desc->ctrl,
   319			       dmadev->dma_base + DMA_CALC_REG_ADR(channel->id, DMA_CTRL_STATUS));
   320	
   321			/* Ensure control/status word makes it to the DMAC before
   322			 * we write address/length info
   323			 */
   324			wmb();
   325	
   326			/* Write the source addresses to the DMAC */
   327			writel(desc->src_adr & OXNAS_DMA_ADR_MASK,
   328			       dmadev->dma_base + DMA_CALC_REG_ADR(channel->id, DMA_BASE_SRC_ADR));
   329	
   330			/* Write the destination addresses to the DMAC */
   331			writel(desc->dst_adr & OXNAS_DMA_ADR_MASK,
   332			       dmadev->dma_base + DMA_CALC_REG_ADR(channel->id, DMA_BASE_DST_ADR));
   333	
   334			/* Write the length, with EOT configuration
   335			 * for the single transfer
   336			 */
   337			writel(desc->len,
   338			       dmadev->dma_base + DMA_CALC_REG_ADR(channel->id, DMA_BYTE_CNT));
   339	
   340			/* Ensure adr/len info makes it to DMAC before later modifications to
   341			 * control/status register due to starting the transfer, which happens in
   342			 * oxnas_dma_start()
   343			 */
   344			wmb();
   345	
   346			/* Setup channel data */
   347			atomic_set(&channel->active, 1);
   348	
   349			/* Single transfer mode, so unpause the DMA controller channel */
   350			ctrl_status = readl(dmadev->dma_base +
   351					    DMA_CALC_REG_ADR(channel->id, DMA_CTRL_STATUS));
   352			writel(ctrl_status & ~DMA_CTRL_STATUS_PAUSE,
   353			       dmadev->dma_base + DMA_CALC_REG_ADR(channel->id, DMA_CTRL_STATUS));
   354	
 > 355			dev_dbg(&dmadev->pdev->dev, "ch%d: started req %d from %08x to %08x, %lubytes\n",
   356				channel->id, vd->tx.cookie,
   357				desc->src_adr, desc->dst_adr,
   358				desc->len & OXNAS_DMA_MAX_TRANSFER_LENGTH);
   359		} else if (desc->type == OXNAS_DMA_TYPE_SG) {
   360			/* Write to the SG-DMA channel's reset register to reset the control
   361			 * in case the previous SG-DMA transfer failed in some way, thus
   362			 * leaving the SG-DMA controller hung up part way through processing
   363			 * its SG list. The reset bits are self-clearing
   364			 */
   365			writel(DMA_SG_RESETS_CONTROL,
   366			       dmadev->sgdma_base + DMA_SG_CALC_REG_ADR(channel->id, DMA_SG_RESETS));
   367	
   368			/* Copy the sg_info structure */
   369			memcpy(channel->sg_info, &desc->sg_info, sizeof(struct oxnas_dma_sg_info));
   370	
   371			/* Ensure adr/len info makes it to DMAC before later modifications to
   372			 * control/status register due to starting the transfer, which happens in
   373			 * oxnas_dma_start()
   374			 */
   375			wmb();
   376	
   377			/* Write the pointer to the SG info struct into the Request Pointer reg */
   378			writel(channel->p_sg_info,
   379			       dmadev->sgdma_base + DMA_SG_CALC_REG_ADR(channel->id, DMA_SG_REQ_PTR));
   380	
   381			/* Setup channel data */
   382			atomic_set(&channel->active, 1);
   383	
   384			/* Start the transfert */
   385			writel(DMA_SG_CONTROL_START |
   386			       DMA_SG_CONTROL_QUEUING_ENABLE |
   387			       DMA_SG_CONTROL_HBURST_ENABLE,
   388			       dmadev->sgdma_base + DMA_SG_CALC_REG_ADR(channel->id, DMA_SG_CONTROL));
   389	
   390			dev_dbg(&dmadev->pdev->dev, "ch%d: started %d sg req with %d entries\n",
   391				channel->id, vd->tx.cookie,
   392				desc->entries);
   393		}
   394	}
   395	
   396	static void oxnas_dma_sched(unsigned long data)
   397	{
   398		struct oxnas_dma_device *dmadev = (struct oxnas_dma_device *)data;
   399		LIST_HEAD(head);
   400	
   401		spin_lock_irq(&dmadev->lock);
   402		list_splice_tail_init(&dmadev->pending, &head);
   403		spin_unlock_irq(&dmadev->lock);
   404	
   405		while (!list_empty(&head)) {
   406			struct oxnas_dma_channel *ch = list_first_entry(&head,
   407									struct oxnas_dma_channel, node);
   408	
   409			spin_lock_irq(&ch->vc.lock);
   410	
   411			list_del_init(&ch->node);
   412			oxnas_dma_start_next(ch);
   413	
   414			spin_unlock_irq(&ch->vc.lock);
   415		}
   416	}
   417	
   418	static int oxnas_check_address(struct oxnas_dma_device *dmadev, dma_addr_t address)
   419	{
   420		int i;
   421	
   422		for (i = 0 ; i <  dmadev->authorized_types_count ; ++i) {
   423			if (address >= dmadev->authorized_types[i].start &&
   424			    address < dmadev->authorized_types[i].end)
   425				return dmadev->authorized_types[i].type;
   426		}
   427	
   428		return -1;
   429	}
   430	
   431	static struct dma_async_tx_descriptor *oxnas_dma_prep_slave_sg(struct dma_chan *chan,
   432								       struct scatterlist *sgl,
   433								       unsigned int sglen,
   434								       enum dma_transfer_direction dir,
   435								       unsigned long flags, void *context)
   436	{
   437		struct oxnas_dma_channel *channel = container_of(chan, struct oxnas_dma_channel, vc.chan);
   438		struct oxnas_dma_device *dmadev = channel->dmadev;
   439		struct oxnas_dma_desc *desc;
   440		struct scatterlist *sgent;
   441		struct oxnas_dma_sg_entry *entry_mem = NULL, *prev_entry_mem = NULL;
   442		struct oxnas_dma_sg_entry *entry_dev = NULL;
   443		unsigned int i;
   444		int src_memory = OXNAS_DMA_DREQ_MEMORY;
   445		int dst_memory = OXNAS_DMA_DREQ_MEMORY;
   446	
   447		if (dir == DMA_DEV_TO_MEM) {
   448			src_memory = oxnas_check_address(dmadev, channel->cfg.src_addr);
   449			if (src_memory == -1) {
 > 450				dev_err(&dmadev->pdev->dev, "invalid memory address %08x\n",
   451					channel->cfg.src_addr);
   452				return NULL;
   453			}
   454	
   455			if (src_memory == OXNAS_DMA_DREQ_MEMORY) {
   456				dev_err(&dmadev->pdev->dev, "In DEV_TO_MEM, src cannot be memory\n");
   457				return NULL;
   458			}
   459		} else if (dir == DMA_MEM_TO_DEV) {
   460			dst_memory = oxnas_check_address(dmadev, channel->cfg.dst_addr);
   461			if (dst_memory == -1) {
   462				dev_err(&dmadev->pdev->dev, "invalid memory address %08x\n",
   463					channel->cfg.dst_addr);
   464				return NULL;
   465			}
   466	
   467			if (dst_memory == OXNAS_DMA_DREQ_MEMORY) {
   468				dev_err(&dmadev->pdev->dev, "In MEM_TO_DEV, dst cannot be memory\n");
   469				return NULL;
   470			}
   471		} else {
   472			dev_err(&dmadev->pdev->dev, "invalid direction\n");
   473			return NULL;
   474		}
   475	
   476		if (atomic_read(&dmadev->free_entries_count) < (sglen + 1)) {
   477			dev_err(&dmadev->pdev->dev, "Missing sg entries...\n");
   478			return NULL;
   479		}
   480	
   481		desc = kzalloc(sizeof(*desc), GFP_KERNEL);
   482		if (unlikely(!desc))
   483			return NULL;
   484		desc->channel = channel;
   485	
   486		INIT_LIST_HEAD(&desc->sg_entries);
   487		desc->entries = 0;
   488	
   489		/* Device single entry */
   490		entry_dev = list_first_entry_or_null(&dmadev->free_entries,
   491						     struct oxnas_dma_sg_entry, entry);
   492		if (!entry_dev) {
   493			dev_err(&dmadev->pdev->dev, "Fatal error: Missing dev sg entry...\n");
   494			goto entries_cleanup;
   495		}
   496	
   497		atomic_dec(&dmadev->free_entries_count);
   498		list_move(&entry_dev->entry, &desc->sg_entries);
   499		++desc->entries;
   500		dev_dbg(&dmadev->pdev->dev, "got entry %p (%08x)\n", entry_dev, entry_dev->this_paddr);
   501	
   502		entry_dev->next_entry = NULL;
   503		entry_dev->p_next_entry = 0;
   504		entry_dev->data_length = 0; /* Completed by mem sg entries */
   505	
   506		if (dir == DMA_DEV_TO_MEM) {
   507			entry_dev->data_addr = channel->cfg.src_addr & OXNAS_DMA_ADR_MASK;
   508			desc->sg_info.src_entries = entry_dev;
   509			desc->sg_info.p_src_entries = entry_dev->this_paddr;
   510	
   511			dev_dbg(&dmadev->pdev->dev, "src set %p\n", entry_dev);
   512		} else if (dir == DMA_MEM_TO_DEV) {
   513			entry_dev->data_addr = channel->cfg.dst_addr & OXNAS_DMA_ADR_MASK;
   514			desc->sg_info.dst_entries = entry_dev;
   515			desc->sg_info.p_dst_entries = entry_dev->this_paddr;
   516	
   517			dev_dbg(&dmadev->pdev->dev, "dst set %p\n", entry_dev);
   518		}
   519	
   520		dev_dbg(&dmadev->pdev->dev, "src = %p (%08x) dst = %p (%08x)\n",
   521			desc->sg_info.src_entries, desc->sg_info.p_src_entries,
   522			desc->sg_info.dst_entries, desc->sg_info.p_dst_entries);
   523	
   524		/* Memory entries */
   525		for_each_sg(sgl, sgent, sglen, i) {
   526			entry_mem = list_first_entry_or_null(&dmadev->free_entries,
   527							     struct oxnas_dma_sg_entry, entry);
   528			if (!entry_mem) {
   529				dev_err(&dmadev->pdev->dev, "Fatal error: Missing mem sg entries...\n");
   530				goto entries_cleanup;
   531			}
   532	
   533			atomic_dec(&dmadev->free_entries_count);
   534			list_move(&entry_mem->entry, &desc->sg_entries);
   535			++desc->entries;
   536			dev_dbg(&dmadev->pdev->dev, "got entry %p (%08x)\n",
   537				entry_mem, entry_mem->this_paddr);
   538	
   539			/* Fill the linked list */
   540			if (prev_entry_mem) {
   541				prev_entry_mem->next_entry = entry_mem;
   542				prev_entry_mem->p_next_entry = entry_mem->this_paddr;
   543			} else {
   544				if (dir == DMA_DEV_TO_MEM) {
   545					desc->sg_info.dst_entries = entry_mem;
   546					desc->sg_info.p_dst_entries = entry_mem->this_paddr;
   547					dev_dbg(&dmadev->pdev->dev, "src set %p\n", entry_mem);
   548				} else if (dir == DMA_MEM_TO_DEV) {
   549					desc->sg_info.src_entries = entry_mem;
   550					desc->sg_info.p_src_entries = entry_mem->this_paddr;
   551					dev_dbg(&dmadev->pdev->dev, "dst set %p\n", entry_mem);
   552				}
   553	
   554				dev_dbg(&dmadev->pdev->dev, "src = %p (%08x) dst = %p (%08x)\n",
   555					desc->sg_info.src_entries, desc->sg_info.p_src_entries,
   556					desc->sg_info.dst_entries, desc->sg_info.p_dst_entries);
   557			}
   558			prev_entry_mem = entry_mem;
   559	
   560			/* Fill the entry from the SG */
   561			entry_mem->next_entry = NULL;
   562			entry_mem->p_next_entry = 0;
   563	
   564			entry_mem->data_addr = sg_dma_address(sgent) & OXNAS_DMA_ADR_MASK;
   565			entry_mem->data_length = sg_dma_len(sgent);
   566			dev_dbg(&dmadev->pdev->dev, "sg = %08x len = %d\n",
   567				sg_dma_address(sgent), sg_dma_len(sgent));
   568	
   569			/* Add to dev sg length */
   570			entry_dev->data_length += sg_dma_len(sgent);
   571		}
   572		dev_dbg(&dmadev->pdev->dev, "allocated %d sg entries\n", desc->entries);
   573	
   574		desc->sg_info.qualifier = FIELD_PREP(OXNAS_DMA_SG_CHANNEL, channel->id) |
   575					  OXNAS_DMA_SG_QUALIFIER;
   576	
   577		if (dir == DMA_DEV_TO_MEM)
   578			desc->sg_info.qualifier |= FIELD_PREP(OXNAS_DMA_SG_SRC_EOT, 2);
   579		else if (dir == DMA_MEM_TO_DEV)
   580			desc->sg_info.qualifier |= FIELD_PREP(OXNAS_DMA_SG_DST_EOT, 2);
   581	
   582		desc->sg_info.control = (DMA_CTRL_STATUS_INTERRUPT_ENABLE |
   583					 DMA_CTRL_STATUS_FAIR_SHARE_ARB |
   584					 DMA_CTRL_STATUS_INTR_CLEAR_ENABLE);
   585		desc->sg_info.control |= FIELD_PREP(DMA_CTRL_STATUS_SRC_DREQ, src_memory);
   586		desc->sg_info.control |= FIELD_PREP(DMA_CTRL_STATUS_DEST_DREQ, dst_memory);
   587	
   588		if (dir == DMA_DEV_TO_MEM) {
   589			desc->sg_info.control |= DMA_CTRL_STATUS_SRC_ADR_MODE;
   590			desc->sg_info.control &= ~DMA_CTRL_STATUS_SOURCE_ADDRESS_FIXED;
   591			desc->sg_info.control |= DMA_CTRL_STATUS_DEST_ADR_MODE;
   592			desc->sg_info.control &= ~DMA_CTRL_STATUS_DESTINATION_ADDRESS_FIXED;
   593		} else if (dir == DMA_MEM_TO_DEV) {
   594			desc->sg_info.control |= DMA_CTRL_STATUS_SRC_ADR_MODE;
   595			desc->sg_info.control &= ~DMA_CTRL_STATUS_SOURCE_ADDRESS_FIXED;
   596			desc->sg_info.control |= DMA_CTRL_STATUS_DEST_ADR_MODE;
   597			desc->sg_info.control &= ~DMA_CTRL_STATUS_DESTINATION_ADDRESS_FIXED;
   598		}
   599		desc->sg_info.control |= DMA_CTRL_STATUS_TRANSFER_MODE_A;
   600		desc->sg_info.control |= DMA_CTRL_STATUS_TRANSFER_MODE_B;
   601		desc->sg_info.control |= FIELD_PREP(DMA_CTRL_STATUS_DIR, OXNAS_DMA_A_TO_B);
   602	
   603		desc->sg_info.control |= FIELD_PREP(DMA_CTRL_STATUS_SRC_WIDTH,
   604						    OXNAS_DMA_TRANSFER_WIDTH_32BITS);
   605		desc->sg_info.control |= FIELD_PREP(DMA_CTRL_STATUS_DEST_WIDTH,
   606						    OXNAS_DMA_TRANSFER_WIDTH_32BITS);
   607		desc->sg_info.control &= ~DMA_CTRL_STATUS_STARVE_LOW_PRIORITY;
   608	
   609		desc->type = OXNAS_DMA_TYPE_SG;
   610	
   611		return vchan_tx_prep(&channel->vc, &desc->vd, flags);
   612	
   613	entries_cleanup:
   614		/* Put back all entries in the free entries... */
   615		list_splice_tail_init(&desc->sg_entries, &dmadev->free_entries);
   616		atomic_add(desc->entries, &dmadev->free_entries_count);
   617		dev_dbg(&dmadev->pdev->dev, "freed %d sg entries\n", desc->entries);
   618	
   619		kfree(desc);
   620	
   621		return NULL;
   622	}
   623	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

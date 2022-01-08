Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12138488090
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 02:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiAHBcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 20:32:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:41138 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230445AbiAHBcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 20:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641605551; x=1673141551;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=j13VVmZ70osedOweydclqQICgC7vGcCyMjM8sb6qaF0=;
  b=GvPtgui6q0CiSjRBVn0ZGSLc2veWz5xHn9mSkBLf3g95Z5JX5JHwNis1
   AOuVptbGejOXOTMzzMHpBdCvj049RGlO5QkK4tPiCG/xgfSkYwob+NF8m
   9cJfK8snVHu/K3CeZyHZyiztGN82qj5vIF2Bp0vSrk/3mZNXwPKfHqe/X
   bFrQh6Wtg9kfpgsgSRRG9UXvZ907tq83JFgEQ5M6ZEbbK7cb88fcHFaGn
   AaqJeP6kMqAxJPXo8vNulGZI1Y76CbZ+tZeyAVyaQ59YU+/Ul+Au4VL2y
   l0hUnLKQkxJQ5oGEmqk9PkuL34UeSOaeNJFeaT/4/mJ9g6mgglkTZCLUW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="243170712"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="243170712"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 17:32:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="622119453"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Jan 2022 17:32:29 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n60aq-00009b-Qa; Sat, 08 Jan 2022 01:32:28 +0000
Date:   Sat, 8 Jan 2022 09:32:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [narmstrong-oxnas:oxnas/v5.18/dma 2/4]
 drivers/dma/oxnas_adma.c:915:40: warning: cast to pointer from integer of
 different size
Message-ID: <202201080904.ADmkINrx-lkp@intel.com>
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
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20220108/202201080904.ADmkINrx-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git/commit/?id=90ad9e59c40581027a2fd9134e4e160ad0a7f5d2
        git remote add narmstrong-oxnas https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git
        git fetch --no-tags narmstrong-oxnas oxnas/v5.18/dma
        git checkout 90ad9e59c40581027a2fd9134e4e160ad0a7f5d2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/dma/ drivers/net/wireless/ath/wcn36xx/ drivers/nvme/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

         |                                                               |
         |                                                               unsigned int
         |                                                            %08llx
   In file included from include/linux/printk.h:555,
                    from include/linux/kernel.h:20,
                    from include/linux/cpumask.h:10,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/dma/oxnas_adma.c:7:
   drivers/dma/oxnas_adma.c:655:37: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
     655 |         dev_dbg(&dmadev->pdev->dev, "preparing memcpy from %08x to %08x, %lubytes (flags %x)\n",
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   drivers/dma/oxnas_adma.c:655:9: note: in expansion of macro 'dev_dbg'
     655 |         dev_dbg(&dmadev->pdev->dev, "preparing memcpy from %08x to %08x, %lubytes (flags %x)\n",
         |         ^~~~~~~
   drivers/dma/oxnas_adma.c:655:71: note: format string is defined here
     655 |         dev_dbg(&dmadev->pdev->dev, "preparing memcpy from %08x to %08x, %lubytes (flags %x)\n",
         |                                                                    ~~~^
         |                                                                       |
         |                                                                       unsigned int
         |                                                                    %08llx
   In file included from include/linux/printk.h:555,
                    from include/linux/kernel.h:20,
                    from include/linux/cpumask.h:10,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/dma/oxnas_adma.c:7:
   drivers/dma/oxnas_adma.c: In function 'oxnas_dma_probe':
   drivers/dma/oxnas_adma.c:869:37: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
     869 |                 dev_dbg(&pdev->dev, "0x%08x-0x%08x = %d\n",
         |                                     ^~~~~~~~~~~~~~~~~~~~~~
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
   drivers/dma/oxnas_adma.c:869:17: note: in expansion of macro 'dev_dbg'
     869 |                 dev_dbg(&pdev->dev, "0x%08x-0x%08x = %d\n",
         |                 ^~~~~~~
   drivers/dma/oxnas_adma.c:869:43: note: format string is defined here
     869 |                 dev_dbg(&pdev->dev, "0x%08x-0x%08x = %d\n",
         |                                        ~~~^
         |                                           |
         |                                           unsigned int
         |                                        %08llx
   In file included from include/linux/printk.h:555,
                    from include/linux/kernel.h:20,
                    from include/linux/cpumask.h:10,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/dma/oxnas_adma.c:7:
   drivers/dma/oxnas_adma.c:869:37: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
     869 |                 dev_dbg(&pdev->dev, "0x%08x-0x%08x = %d\n",
         |                                     ^~~~~~~~~~~~~~~~~~~~~~
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
   drivers/dma/oxnas_adma.c:869:17: note: in expansion of macro 'dev_dbg'
     869 |                 dev_dbg(&pdev->dev, "0x%08x-0x%08x = %d\n",
         |                 ^~~~~~~
   drivers/dma/oxnas_adma.c:869:50: note: format string is defined here
     869 |                 dev_dbg(&pdev->dev, "0x%08x-0x%08x = %d\n",
         |                                               ~~~^
         |                                                  |
         |                                                  unsigned int
         |                                               %08llx
>> drivers/dma/oxnas_adma.c:915:40: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     915 |                         (dma_addr_t)&(((struct oxnas_dma_sg_data *)dmadev->p_sg_data)->entries[i]);
         |                                        ^
>> drivers/dma/oxnas_adma.c:915:25: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     915 |                         (dma_addr_t)&(((struct oxnas_dma_sg_data *)dmadev->p_sg_data)->entries[i]);
         |                         ^
   drivers/dma/oxnas_adma.c:944:39: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     944 |                         (dma_addr_t)&((struct oxnas_dma_sg_data *)dmadev->p_sg_data)->infos[i];
         |                                       ^
   drivers/dma/oxnas_adma.c:944:25: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     944 |                         (dma_addr_t)&((struct oxnas_dma_sg_data *)dmadev->p_sg_data)->infos[i];
         |                         ^


vim +915 drivers/dma/oxnas_adma.c

   794	
   795	static int oxnas_dma_probe(struct platform_device *pdev)
   796	{
   797		struct oxnas_dma_device *dmadev;
   798		struct resource *res;
   799		int hwid, i, ret;
   800	
   801		dmadev = devm_kzalloc(&pdev->dev, sizeof(struct oxnas_dma_device), GFP_KERNEL);
   802		if (!dmadev)
   803			return -ENOMEM;
   804	
   805		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   806		dmadev->dma_base = devm_ioremap_resource(&pdev->dev, res);
   807		if (IS_ERR(dmadev->dma_base))
   808			return PTR_ERR(dmadev->dma_base);
   809	
   810		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
   811		dmadev->sgdma_base = devm_ioremap_resource(&pdev->dev, res);
   812		if (IS_ERR(dmadev->sgdma_base))
   813			return PTR_ERR(dmadev->sgdma_base);
   814	
   815		dmadev->dma_rst = devm_reset_control_get(&pdev->dev, "dma");
   816		if (IS_ERR(dmadev->dma_rst))
   817			return PTR_ERR(dmadev->dma_rst);
   818	
   819		dmadev->sgdma_rst = devm_reset_control_get(&pdev->dev, "sgdma");
   820		if (IS_ERR(dmadev->sgdma_rst))
   821			return PTR_ERR(dmadev->sgdma_rst);
   822	
   823		dmadev->dma_clk = devm_clk_get(&pdev->dev, 0);
   824		if (IS_ERR(dmadev->dma_clk))
   825			return PTR_ERR(dmadev->dma_clk);
   826	
   827		ret = of_property_count_elems_of_size(pdev->dev.of_node, "oxsemi,targets-types", 4);
   828		if (ret <= 0 || (ret % 3) != 0) {
   829			dev_err(&pdev->dev, "malformed or missing oxsemi,targets-types\n");
   830			return -EINVAL;
   831		}
   832	
   833		dmadev->authorized_types_count = ret / 3;
   834		dmadev->authorized_types = devm_kzalloc(&pdev->dev,
   835			sizeof(*dmadev->authorized_types) * dmadev->authorized_types_count, GFP_KERNEL);
   836	
   837		if (!dmadev->authorized_types)
   838			return -ENOMEM;
   839	
   840		for (i = 0 ; i < dmadev->authorized_types_count ; ++i) {
   841			u32 value;
   842	
   843			ret = of_property_read_u32_index(pdev->dev.of_node,
   844							 "oxsemi,targets-types",
   845							 (i * 3), &value);
   846			if (ret < 0)
   847				return ret;
   848	
   849			dmadev->authorized_types[i].start = value;
   850			ret = of_property_read_u32_index(pdev->dev.of_node,
   851							 "oxsemi,targets-types",
   852							 (i * 3) + 1, &value);
   853			if (ret < 0)
   854				return ret;
   855	
   856			dmadev->authorized_types[i].end = value;
   857			ret = of_property_read_u32_index(pdev->dev.of_node,
   858							 "oxsemi,targets-types",
   859							 (i * 3) + 2, &value);
   860			if (ret < 0)
   861				return ret;
   862	
   863			dmadev->authorized_types[i].type = value;
   864		}
   865	
   866		dev_dbg(&pdev->dev, "Authorized memory ranges :\n");
   867		dev_dbg(&pdev->dev, " Start    - End      = Type\n");
   868		for (i = 0 ; i <  dmadev->authorized_types_count ; ++i)
   869			dev_dbg(&pdev->dev, "0x%08x-0x%08x = %d\n",
   870				dmadev->authorized_types[i].start,
   871				dmadev->authorized_types[i].end,
   872				dmadev->authorized_types[i].type);
   873	
   874		dmadev->pdev = pdev;
   875	
   876		spin_lock_init(&dmadev->lock);
   877	
   878		tasklet_init(&dmadev->tasklet, oxnas_dma_sched, (unsigned long)dmadev);
   879		INIT_LIST_HEAD(&dmadev->common.channels);
   880		INIT_LIST_HEAD(&dmadev->pending);
   881		INIT_LIST_HEAD(&dmadev->free_entries);
   882	
   883		/* Enable HW & Clocks */
   884		reset_control_reset(dmadev->dma_rst);
   885		reset_control_reset(dmadev->sgdma_rst);
   886		clk_prepare_enable(dmadev->dma_clk);
   887	
   888		/* Discover the number of channels available */
   889		hwid = readl(dmadev->dma_base + DMA_CALC_REG_ADR(0, DMA_INTR_ID));
   890		dmadev->channels_count = DMA_INTR_ID_GET_NUM_CHANNELS(hwid);
   891		dmadev->hwversion = DMA_INTR_ID_GET_VERSION(hwid);
   892	
   893		dev_dbg(&pdev->dev, "OXNAS DMA v%x with %d channels\n",
   894			dmadev->hwversion, dmadev->channels_count);
   895	
   896		/* Limit channels count */
   897		if (dmadev->channels_count > MAX_OXNAS_DMA_CHANNELS)
   898			dmadev->channels_count = MAX_OXNAS_DMA_CHANNELS;
   899	
   900		/* Allocate coherent memory for sg descriptors */
   901		dmadev->sg_data = dma_alloc_coherent(&pdev->dev, sizeof(struct oxnas_dma_sg_data),
   902						     &dmadev->p_sg_data, GFP_KERNEL);
   903		if (!dmadev->sg_data) {
   904			ret = -ENOMEM;
   905			goto disable_clks;
   906		}
   907	
   908		/* Reset SG descritors */
   909		memset(dmadev->sg_data, 0, sizeof(struct oxnas_dma_sg_data));
   910		atomic_set(&dmadev->free_entries_count, 0);
   911	
   912		/* Initialize and add all sg entries to the free list */
   913		for (i = 0 ; i < MAX_OXNAS_SG_ENTRIES ; ++i) {
   914			dmadev->sg_data->entries[i].this_paddr =
 > 915				(dma_addr_t)&(((struct oxnas_dma_sg_data *)dmadev->p_sg_data)->entries[i]);
   916			INIT_LIST_HEAD(&dmadev->sg_data->entries[i].entry);
   917			list_add_tail(&dmadev->sg_data->entries[i].entry,
   918				      &dmadev->free_entries);
   919			atomic_inc(&dmadev->free_entries_count);
   920		}
   921	
   922		/* Init all channels */
   923		for (i = 0 ; i < dmadev->channels_count ; ++i) {
   924			struct oxnas_dma_channel *ch = &dmadev->channels[i];
   925	
   926			ch->dmadev = dmadev;
   927			ch->id = i;
   928	
   929			ch->irq = irq_of_parse_and_map(pdev->dev.of_node, i);
   930			if (ch->irq <= 0) {
   931				dev_err(&pdev->dev, "invalid irq%d from platform\n", i);
   932				goto free_coherent;
   933			}
   934	
   935			ret = devm_request_irq(&pdev->dev, ch->irq,
   936					       oxnas_dma_interrupt, 0,
   937					       "DMA", ch);
   938			if (ret < 0) {
   939				dev_err(&pdev->dev, "failed to request irq%d\n", i);
   940				goto free_coherent;
   941			}
   942	
   943			ch->p_sg_info =
   944				(dma_addr_t)&((struct oxnas_dma_sg_data *)dmadev->p_sg_data)->infos[i];
   945			ch->sg_info = &dmadev->sg_data->infos[i];
   946			memset(ch->sg_info, 0, sizeof(struct oxnas_dma_sg_info));
   947	
   948			atomic_set(&ch->active, 0);
   949	
   950			ch->vc.desc_free = oxnas_dma_desc_free;
   951			vchan_init(&ch->vc, &dmadev->common);
   952			INIT_LIST_HEAD(&ch->node);
   953		}
   954	
   955		platform_set_drvdata(pdev, dmadev);
   956	
   957		dma_cap_set(DMA_MEMCPY, dmadev->common.cap_mask);
   958		dmadev->common.chancnt = dmadev->channels_count;
   959		dmadev->common.device_free_chan_resources = oxnas_dma_free_chan_resources;
   960		dmadev->common.device_tx_status = oxnas_dma_tx_status;
   961		dmadev->common.device_issue_pending = oxnas_dma_issue_pending;
   962		dmadev->common.device_prep_dma_memcpy = oxnas_dma_prep_dma_memcpy;
   963		dmadev->common.device_prep_slave_sg = oxnas_dma_prep_slave_sg;
   964		dmadev->common.device_config = oxnas_dma_slave_config;
   965		dmadev->common.copy_align = DMAENGINE_ALIGN_4_BYTES;
   966		dmadev->common.src_addr_widths = DMA_SLAVE_BUSWIDTH_4_BYTES;
   967		dmadev->common.dst_addr_widths = DMA_SLAVE_BUSWIDTH_4_BYTES;
   968		dmadev->common.directions = BIT(DMA_MEM_TO_MEM);
   969		dmadev->common.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
   970		dmadev->common.dev = &pdev->dev;
   971	
   972		ret = dma_async_device_register(&dmadev->common);
   973		if (ret)
   974			goto free_coherent;
   975	
   976		ret = of_dma_controller_register(pdev->dev.of_node,
   977						 of_dma_xlate_by_chan_id,
   978						 &dmadev->common);
   979		if (ret) {
   980			dev_warn(&pdev->dev, "Failed to register DMA Controller\n");
   981			goto dma_unregister;
   982		}
   983	
   984		dev_info(&pdev->dev, "OXNAS DMA Registered\n");
   985	
   986		return 0;
   987	
   988	dma_unregister:
   989		dma_async_device_unregister(&dmadev->common);
   990	
   991	free_coherent:
   992		dma_free_coherent(&pdev->dev, sizeof(struct oxnas_dma_sg_data),
   993				  dmadev->sg_data, dmadev->p_sg_data);
   994	
   995	disable_clks:
   996		clk_disable_unprepare(dmadev->dma_clk);
   997	
   998		return ret;
   999	}
  1000	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

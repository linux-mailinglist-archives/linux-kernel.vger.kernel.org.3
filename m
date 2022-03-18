Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB4D4DD5E5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbiCRIRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiCRIRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:17:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340832D919E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647591389; x=1679127389;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HRQNtbeBkKGn+ugZ4fx5fkcMkiHnQQTzPlGSSDDGbPk=;
  b=dYqWmJe1o4TB6/EpovsGJjGtTZgorn3kFxwBWZa+C6NlSgMadq45RklB
   6jClbkjaplpSlZrX6PZlveznnm3mBKtk+/vHoKp7gi3mvrUx/6axbxKkR
   RZzV2tZqf8CdvqFFSo6reFpBAIxOYDuddPrU/zFax9XRDFWgpha/DAPIt
   HiLl54zfW0w0cjLtkms+cFsF1mVq4OyowXLSGxGsNGFmWsVgHnG5I4kx1
   03h15d/XJHnGjjaU3vpA4MHkbbT5N+1pmd5s0NPxM9SrBIutt8crU0Umf
   3jDA1Onv+Mf6QdR+/4410KJrVT7/hVCYWjFI1gTWXbeepOGOEnlFwACpS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257279758"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="257279758"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 01:16:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="581610366"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 18 Mar 2022 01:16:27 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nV7mc-000EZ5-Lu; Fri, 18 Mar 2022 08:16:26 +0000
Date:   Fri, 18 Mar 2022 16:16:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/070-audio 14/32] drivers/dma/apple-admac.c:202:26:
 warning: format '%llx' expects argument of type 'long long unsigned int',
 but argument 5 has type 'dma_addr_t' {aka 'unsigned int'}
Message-ID: <202203181652.rlHAU1Qo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/070-audio
head:   d35f2ed6fe7eeda94beff1f5c0d98581cafb9bb6
commit: c06b0748391ea85d168b3543033fc97342822e24 [14/32] dmaengine: apple-admac: Add Apple ADMAC driver
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220318/202203181652.rlHAU1Qo-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/c06b0748391ea85d168b3543033fc97342822e24
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/070-audio
        git checkout c06b0748391ea85d168b3543033fc97342822e24
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:555,
                    from include/asm-generic/bug.h:22,
                    from arch/arm/include/asm/bug.h:60,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/dma/apple-admac.c:3:
   drivers/dma/apple-admac.c: In function 'admac_cyclic_write_one_desc':
>> drivers/dma/apple-admac.c:202:26: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
     202 |         dev_dbg(ad->dev, "ch%d descriptor: addr=0x%llx len=0x%x flags=0x%lx\n",
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   drivers/dma/apple-admac.c:202:9: note: in expansion of macro 'dev_dbg'
     202 |         dev_dbg(ad->dev, "ch%d descriptor: addr=0x%llx len=0x%x flags=0x%lx\n",
         |         ^~~~~~~
   drivers/dma/apple-admac.c:202:54: note: format string is defined here
     202 |         dev_dbg(ad->dev, "ch%d descriptor: addr=0x%llx len=0x%x flags=0x%lx\n",
         |                                                   ~~~^
         |                                                      |
         |                                                      long long unsigned int
         |                                                   %x
>> drivers/dma/apple-admac.c:206:53: warning: right shift count >= width of type [-Wshift-count-overflow]
     206 |         admac_poke(ad, REG_DESC_WRITE(channo), addr >> 32);
         |                                                     ^~
   drivers/dma/apple-admac.c: At top level:
>> drivers/dma/apple-admac.c:260:5: warning: no previous prototype for 'admac_cyclic_read_residue' [-Wmissing-prototypes]
     260 | u32 admac_cyclic_read_residue(struct admac_data *ad, int channo, struct admac_tx *adtx)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +202 drivers/dma/apple-admac.c

   > 3	#include <linux/device.h>
     4	#include <linux/init.h>
     5	#include <linux/module.h>
     6	#include <linux/of_device.h>
     7	#include <linux/of_dma.h>
     8	#include <linux/interrupt.h>
     9	#include <linux/spinlock.h>
    10	#include <linux/pm_runtime.h>
    11	
    12	#include "dmaengine.h"
    13	
    14	#define NCHANNELS_MAX	64
    15	
    16	#define RING_WRITE_SLOT		GENMASK(1, 0)
    17	#define RING_READ_SLOT		GENMASK(5, 4)
    18	#define RING_FULL  		BIT(9)
    19	#define RING_EMPTY 		BIT(8)
    20	#define RING_ERR   		BIT(10)
    21	
    22	#define STATUS_DESC_DONE	BIT(0)
    23	#define STATUS_ERR		BIT(6)
    24	
    25	#define FLAG_DESC_NOTIFY	BIT(16)
    26	
    27	#define REG_TX_START		0x0000
    28	#define REG_TX_STOP		0x0004
    29	#define REG_RX_START		0x0008
    30	#define REG_RX_STOP		0x000c
    31	
    32	#define REG_CHAN_CTL(ch)	(0x8000 + (ch)*0x200)
    33	#define REG_CHAN_CTL_RST_RINGS	BIT(0)
    34	
    35	#define REG_DESC_RING(ch)	(0x8070 + (ch)*0x200)
    36	#define REG_REPORT_RING(ch)	(0x8074 + (ch)*0x200)
    37	
    38	#define REG_RESIDUE(ch)		(0x8064 + (ch)*0x200)
    39	
    40	#define REG_BUS_WIDTH(ch)	(0x8040 + (ch)*0x200)
    41	
    42	#define BUS_WIDTH_8BIT		0x00
    43	#define BUS_WIDTH_16BIT		0x01
    44	#define BUS_WIDTH_32BIT		0x02
    45	#define BUS_WIDTH_FRAME_2_WORDS	0x10
    46	#define BUS_WIDTH_FRAME_4_WORDS	0x20
    47	
    48	#define REG_CHAN_BURSTSIZE(ch)  (0x8054 + (ch)*0x200)
    49	
    50	#define REG_DESC_WRITE(ch)	(0x10000 + (ch / 2) * 0x4 + (ch & 1) * 0x4000)
    51	#define REG_REPORT_READ(ch)	(0x10100 + (ch / 2) * 0x4 + (ch & 1) * 0x4000)
    52	
    53	#define IRQ_INDEX_MAX		3
    54	
    55	#define REG_TX_INTSTATE(idx)		(0x0030 + (idx) * 4)
    56	#define REG_RX_INTSTATE(idx)		(0x0040 + (idx) * 4)
    57	#define REG_CHAN_INTSTATUS(ch,idx)	(0x8010 + (ch) * 0x200 + (idx) * 4)
    58	#define REG_CHAN_INTMASK(ch,idx)	(0x8020 + (ch) * 0x200 + (idx) * 4)
    59	
    60	struct admac_data;
    61	struct admac_tx;
    62	
    63	struct admac_chan {
    64		int no;
    65		struct admac_data *host;
    66		struct dma_chan chan;
    67		struct tasklet_struct tasklet;
    68	
    69		spinlock_t lock;
    70		struct admac_tx *current_tx;
    71		int nperiod_acks;
    72	
    73		struct list_head submitted;
    74		struct list_head issued;
    75	};
    76	
    77	struct admac_data {
    78		struct dma_device dma;
    79		struct device *dev;
    80		__iomem void *base;
    81	
    82		int irq_index;
    83		int nchannels;
    84		struct admac_chan channels[];
    85	};
    86	
    87	struct admac_tx {
    88		struct dma_async_tx_descriptor tx;
    89		bool cyclic;
    90		dma_addr_t buf_addr;
    91		dma_addr_t buf_end;
    92		size_t buf_len;
    93		size_t period_len;
    94	
    95		size_t submitted_pos;
    96		size_t reclaimed_pos;
    97	
    98		struct list_head node;
    99	};
   100	
   101	static void admac_poke(struct admac_data *ad, int reg, u32 val)
   102	{
   103		writel_relaxed(val, ad->base + reg);
   104	}
   105	
   106	static u32 admac_peek(struct admac_data *ad, int reg)
   107	{
   108		return readl_relaxed(ad->base + reg);
   109	}
   110	
   111	static void admac_modify(struct admac_data *ad, int reg, u32 mask, u32 val)
   112	{
   113		void __iomem *addr = ad->base + reg;
   114		u32 curr = readl_relaxed(addr);
   115	
   116		writel_relaxed((curr & ~mask) | (val & mask), addr);
   117	}
   118	
   119	static struct admac_chan *to_admac_chan(struct dma_chan *chan)
   120	{
   121		return container_of(chan, struct admac_chan, chan);
   122	}
   123	
   124	static struct admac_tx *to_admac_tx(struct dma_async_tx_descriptor *tx)
   125	{
   126		return container_of(tx, struct admac_tx, tx);
   127	}
   128	
   129	static enum dma_transfer_direction admac_chan_direction(int channo)
   130	{
   131		return (channo & 1) ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV;
   132	}
   133	
   134	static dma_cookie_t admac_tx_submit(struct dma_async_tx_descriptor *tx)
   135	{
   136		struct admac_tx *adtx = to_admac_tx(tx);
   137		struct admac_chan *adchan = to_admac_chan(tx->chan);
   138		unsigned long flags;
   139		dma_cookie_t cookie;
   140	
   141		spin_lock_irqsave(&adchan->lock, flags);
   142		cookie = dma_cookie_assign(tx);
   143		list_add_tail(&adtx->node, &adchan->submitted);
   144		spin_unlock_irqrestore(&adchan->lock, flags);
   145	
   146		return cookie;
   147	}
   148	
   149	static int admac_desc_free(struct dma_async_tx_descriptor *tx)
   150	{
   151		struct admac_tx *adtx = to_admac_tx(tx);
   152		devm_kfree(to_admac_chan(tx->chan)->host->dev, adtx);
   153		return 0;
   154	}
   155	
   156	static struct dma_async_tx_descriptor *admac_prep_dma_cyclic(
   157			struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
   158			size_t period_len, enum dma_transfer_direction direction,
   159			unsigned long flags)
   160	{
   161		struct admac_chan *adchan = container_of(chan, struct admac_chan, chan);
   162		struct admac_tx *adtx;
   163	
   164		if (direction != admac_chan_direction(adchan->no))
   165			return NULL;
   166	
   167		adtx = devm_kzalloc(adchan->host->dev, sizeof(*adtx), GFP_NOWAIT);
   168		if (!adtx)
   169			return NULL;
   170	
   171		adtx->cyclic = true;
   172	
   173		adtx->buf_addr = buf_addr;
   174		adtx->buf_len = buf_len;
   175		adtx->buf_end = buf_addr + buf_len;
   176		adtx->period_len = period_len;
   177	
   178		adtx->submitted_pos = 0;
   179		adtx->reclaimed_pos = 0;
   180	
   181		dma_async_tx_descriptor_init(&adtx->tx, chan);
   182		adtx->tx.tx_submit = admac_tx_submit;
   183		adtx->tx.desc_free = admac_desc_free;
   184	
   185		return &adtx->tx;
   186	}
   187	
   188	/*
   189	 * Write one hardware descriptor for a dmaegine cyclic transaction.
   190	 */
   191	static void admac_cyclic_write_one_desc(struct admac_data *ad, int channo,
   192						struct admac_tx *tx)
   193	{
   194		dma_addr_t addr;
   195	
   196		if (WARN_ON(!tx->cyclic))
   197			return;
   198	
   199		addr = tx->buf_addr + (tx->submitted_pos % tx->buf_len);
   200		WARN_ON(addr + tx->period_len > tx->buf_end);
   201	
 > 202		dev_dbg(ad->dev, "ch%d descriptor: addr=0x%llx len=0x%x flags=0x%lx\n",
   203			channo, addr, (u32) tx->period_len, FLAG_DESC_NOTIFY);
   204	
   205		admac_poke(ad, REG_DESC_WRITE(channo), addr);
 > 206		admac_poke(ad, REG_DESC_WRITE(channo), addr >> 32);
   207		admac_poke(ad, REG_DESC_WRITE(channo), tx->period_len);
   208		admac_poke(ad, REG_DESC_WRITE(channo), FLAG_DESC_NOTIFY);
   209	
   210		tx->submitted_pos += tx->period_len;
   211		tx->submitted_pos %= 2 * tx->buf_len;
   212	}
   213	
   214	/*
   215	 * Write all the hardware descriptors for a cyclic transaction
   216	 * there is space for.
   217	 */
   218	static void admac_cyclic_write_desc(struct admac_data *ad, int channo,
   219						struct admac_tx *tx)
   220	{
   221		int i;
   222	
   223		for (i = 0; i < 4; i++) {
   224			if (admac_peek(ad, REG_DESC_RING(channo)) & RING_FULL)
   225				break;
   226			admac_cyclic_write_one_desc(ad, channo, tx);
   227		}
   228	}
   229	
   230	static int admac_alloc_chan_resources(struct dma_chan *chan)
   231	{
   232		return 0;
   233	}
   234	
   235	static void admac_free_chan_resources(struct dma_chan *chan)
   236	{
   237		// TODO
   238	}
   239	
   240	static int admac_ring_noccupied_slots(int ringval)
   241	{
   242		int wrslot = FIELD_GET(RING_WRITE_SLOT, ringval);
   243		int rdslot = FIELD_GET(RING_READ_SLOT, ringval);
   244	
   245		if (wrslot != rdslot) {
   246			return (wrslot + 4 - rdslot) % 4;
   247		} else {
   248			WARN_ON((ringval & (RING_FULL | RING_EMPTY)) == 0);
   249	
   250			if (ringval & RING_FULL)
   251				return 4;
   252			else
   253				return 0;
   254		}
   255	}
   256	
   257	/*
   258	 * Read from hardware the residue of a cyclic dmaengine transaction.
   259	 */
 > 260	u32 admac_cyclic_read_residue(struct admac_data *ad, int channo, struct admac_tx *adtx)
   261	{
   262		u32 ring1, ring2;
   263		u32 residue1, residue2;
   264		int nreports;
   265		size_t pos;
   266	
   267		ring1 =    admac_peek(ad, REG_REPORT_RING(channo));
   268		residue1 = admac_peek(ad, REG_RESIDUE(channo));
   269		ring2 =    admac_peek(ad, REG_REPORT_RING(channo));
   270		residue2 = admac_peek(ad, REG_RESIDUE(channo));
   271	
   272		if (residue2 > residue1) {
   273			// engine must have loaded next descriptor between the two residue reads
   274			nreports = admac_ring_noccupied_slots(ring1) + 1;
   275		} else {
   276			// no descriptor load between the two reads, ring2 is safe to use
   277			nreports = admac_ring_noccupied_slots(ring2);
   278		}
   279	
   280		pos = adtx->reclaimed_pos + adtx->period_len * (nreports + 1) \
   281							 - residue2;
   282	
   283		return adtx->buf_len - pos % adtx->buf_len;
   284	}
   285	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

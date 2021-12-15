Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A63D4760C2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343803AbhLOSbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:31:18 -0500
Received: from mga01.intel.com ([192.55.52.88]:25938 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234977AbhLOSbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639593077; x=1671129077;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gT93YTFUd1oay4T19IykMIAQYN6cpltdRMR3bDC75ac=;
  b=C7gdl/VyJwsNOgPEWTi9FZS12zlUaDlVdKmBUUPcYanxWtt6I8xUpihe
   yzCfk2Kz6+obknVkvX03yCKCtBDDTt8tCTueBfdKe9aL7Q5AxAhi2iDfo
   8by2QXZaGCSm39CfPhDdOuaFsDOZ/8oRQk0mkZHJFf6Ixrboz6G2h2wnm
   DV6aLkkC5Kuhonr/0EbmXy5TznqcR66i4+d/NJhjl8APXhQex3v9R5e8c
   Xdo/ihLltGoM75esO7cM++LqxiVMkvi34Vc7/cuFgjhvy3Guy5G+d096y
   0fViNr4ZfLdhbP61+SSihezyvGiCIrKH1ftqbhpCwpXf7ugMF0mb4pcRL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="263461346"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="263461346"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 10:31:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="682607665"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Dec 2021 10:31:15 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxZ3a-0002Av-7F; Wed, 15 Dec 2021 18:31:14 +0000
Date:   Thu, 16 Dec 2021 02:30:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik@protonmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:touchpad/wip 63/82] drivers/dma/apple-admac.c:125:5:
 warning: no previous prototype for 'admac_alloc_chan_resources'
Message-ID: <202112160214.4Ffd17JG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux touchpad/wip
head:   a2281d64fdbcbab0dae68c6ea75bd5b548332e06
commit: ebaeac45289171e9e6a775d13f2bf34bfec4d104 [63/82] dmaengine: apple-admac: Add Apple ADMAC driver
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20211216/202112160214.4Ffd17JG-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/ebaeac45289171e9e6a775d13f2bf34bfec4d104
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux touchpad/wip
        git checkout ebaeac45289171e9e6a775d13f2bf34bfec4d104
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash drivers/clk/ drivers/dma/ sound/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/dma/apple-admac.c:125:5: warning: no previous prototype for 'admac_alloc_chan_resources' [-Wmissing-prototypes]
     125 | int admac_alloc_chan_resources(struct dma_chan *chan)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/dma/apple-admac.c:130:6: warning: no previous prototype for 'admac_free_chan_resources' [-Wmissing-prototypes]
     130 | void admac_free_chan_resources(struct dma_chan *chan)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/dma/apple-admac.c:135:5: warning: no previous prototype for 'admac_ring_noccupied_slots' [-Wmissing-prototypes]
     135 | int admac_ring_noccupied_slots(int ringval)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c: In function 'admac_ring_noccupied_slots':
   drivers/dma/apple-admac.c:137:22: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
     137 |         int wrslot = FIELD_GET(RING_WRITE_SLOT, ringval);
         |                      ^~~~~~~~~
         |                      FOLL_GET
   drivers/dma/apple-admac.c: At top level:
>> drivers/dma/apple-admac.c:155:5: warning: no previous prototype for 'admac_cyclic_read_residue' [-Wmissing-prototypes]
     155 | u32 admac_cyclic_read_residue(struct admac_data *ad, int channo, struct admac_tx *adtx)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/dma/apple-admac.c:181:17: warning: no previous prototype for 'admac_tx_status' [-Wmissing-prototypes]
     181 | enum dma_status admac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
         |                 ^~~~~~~~~~~~~~~
>> drivers/dma/apple-admac.c:228:6: warning: no previous prototype for 'admac_start' [-Wmissing-prototypes]
     228 | void admac_start(struct admac_chan *adchan)
         |      ^~~~~~~~~~~
>> drivers/dma/apple-admac.c:244:6: warning: no previous prototype for 'admac_issue_pending' [-Wmissing-prototypes]
     244 | void admac_issue_pending(struct dma_chan *chan)
         |      ^~~~~~~~~~~~~~~~~~~
>> drivers/dma/apple-admac.c:263:5: warning: no previous prototype for 'admac_pause' [-Wmissing-prototypes]
     263 | int admac_pause(struct dma_chan *chan)
         |     ^~~~~~~~~~~
>> drivers/dma/apple-admac.c:272:5: warning: no previous prototype for 'admac_resume' [-Wmissing-prototypes]
     272 | int admac_resume(struct dma_chan *chan)
         |     ^~~~~~~~~~~~
>> drivers/dma/apple-admac.c:281:5: warning: no previous prototype for 'admac_terminate_all' [-Wmissing-prototypes]
     281 | int admac_terminate_all(struct dma_chan *chan)
         |     ^~~~~~~~~~~~~~~~~~~
>> drivers/dma/apple-admac.c:303:14: warning: no previous prototype for 'admac_tx_submit' [-Wmissing-prototypes]
     303 | dma_cookie_t admac_tx_submit(struct dma_async_tx_descriptor *tx)
         |              ^~~~~~~~~~~~~~~
>> drivers/dma/apple-admac.c:325:33: warning: no previous prototype for 'admac_prep_dma_cyclic' [-Wmissing-prototypes]
     325 | struct dma_async_tx_descriptor *admac_prep_dma_cyclic(
         |                                 ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/admac_alloc_chan_resources +125 drivers/dma/apple-admac.c

   124	
 > 125	int admac_alloc_chan_resources(struct dma_chan *chan)
   126	{
   127		return 0;
   128	}
   129	
 > 130	void admac_free_chan_resources(struct dma_chan *chan)
   131	{
   132		// TODO
   133	}
   134	
 > 135	int admac_ring_noccupied_slots(int ringval)
   136	{
   137		int wrslot = FIELD_GET(RING_WRITE_SLOT, ringval);
   138		int rdslot = FIELD_GET(RING_READ_SLOT, ringval);
   139	
   140		if (wrslot != rdslot) {
   141			return (wrslot + 4 - rdslot) % 4;
   142		} else {
   143			WARN_ON((ringval & (RING_FULL | RING_EMPTY)) == 0);
   144	
   145			if (ringval & RING_FULL)
   146				return 4;
   147			else
   148				return 0;
   149		}
   150	}
   151	
   152	/*
   153	 * Read from hardware the residue of a cyclic dmaengine transaction.
   154	 */
 > 155	u32 admac_cyclic_read_residue(struct admac_data *ad, int channo, struct admac_tx *adtx)
   156	{
   157		u32 ring1, ring2;
   158		u32 residue1, residue2;
   159		int nreports;
   160		size_t pos;
   161	
   162		ring1 =    admac_peek(ad, REG_TX_REPORT_RING(channo));
   163		residue1 = admac_peek(ad, REG_TX_RESIDUE(channo));
   164		ring2 =    admac_peek(ad, REG_TX_REPORT_RING(channo));
   165		residue2 = admac_peek(ad, REG_TX_RESIDUE(channo));
   166	
   167		if (residue2 > residue1) {
   168			// engine must have loaded next descriptor between the two residue reads
   169			nreports = admac_ring_noccupied_slots(ring1) + 1;
   170		} else {
   171			// no descriptor load between the two reads, ring2 is safe to use
   172			nreports = admac_ring_noccupied_slots(ring2);
   173		}
   174	
   175		pos = adtx->reclaimed_pos + adtx->period_len * (nreports + 1) \
   176							 - residue2;
   177	
   178		return adtx->buf_len - pos % adtx->buf_len;
   179	}
   180	
 > 181	enum dma_status admac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
   182					struct dma_tx_state *txstate)
   183	{
   184		struct admac_chan *adchan = to_admac_chan(chan);
   185		struct admac_data *ad = adchan->host;
   186		struct admac_tx *adtx;
   187	
   188		enum dma_status ret;
   189		size_t residue;
   190		unsigned long flags;
   191	
   192		ret = dma_cookie_status(chan, cookie, txstate);
   193		if (ret == DMA_COMPLETE || !txstate)
   194			return ret;
   195	
   196		/*
   197		 * Presumably ALSA code will query residue to know if an overrun occured,
   198		 * this seems a proper place to insert a write barrier.
   199		 */
   200		wmb();
   201	
   202		spin_lock_irqsave(&adchan->lock, flags);
   203		adtx = adchan->current_tx;
   204	
   205		if (adtx && adtx->tx.cookie == cookie) {
   206			ret = DMA_IN_PROGRESS;
   207			residue = admac_cyclic_read_residue(ad, adchan->no, adtx);
   208		} else {
   209			ret = DMA_IN_PROGRESS;
   210			residue = 0;
   211			list_for_each_entry(adtx, &adchan->issued, node) {
   212				if (adtx->tx.cookie == cookie) {
   213					residue = adtx->buf_len;
   214					break;
   215				}
   216			}
   217		}
   218		spin_unlock_irqrestore(&adchan->lock, flags);
   219	
   220		if (adtx)
   221			dev_dbg(ad->dev, "ch%d residue: %lx, (%ld%%)\n", adchan->no,
   222				residue, residue*100/adtx->buf_len);
   223	
   224		dma_set_residue(txstate, residue);
   225		return ret;
   226	}
   227	
 > 228	void admac_start(struct admac_chan *adchan)
   229	{
   230		struct admac_data *ad = adchan->host;
   231		int ch = adchan->no;
   232	
   233		admac_poke(ad, REG_TX_STATUS1(ch), STATUS_DESC_DONE | STATUS_ERR);
   234		admac_poke(ad, REG_TX_CTL(ch), REG_TX_CTL_RESET_RINGS);
   235		admac_poke(ad, REG_TX_CTL(ch), 0);
   236		admac_cyclic_write_one_desc(ad, ch, adchan->current_tx);
   237		admac_poke(ad, REG_TX_EN, 1 << ch);
   238	
   239		admac_cyclic_write_desc(ad, ch, adchan->current_tx);
   240	
   241		dev_dbg(ad->dev, "ch%d start\n", ch);
   242	}
   243	
 > 244	void admac_issue_pending(struct dma_chan *chan)
   245	{
   246		struct admac_chan *adchan = to_admac_chan(chan);
   247		struct admac_tx *tx;
   248		unsigned long flags;
   249	
   250		spin_lock_irqsave(&adchan->lock, flags);
   251		list_splice_tail_init(&adchan->submitted, &adchan->issued);
   252		if (!list_empty(&adchan->issued) && !adchan->current_tx) {
   253			tx = list_first_entry(&adchan->issued, struct admac_tx, node);
   254			list_del(&tx->node);
   255	
   256			adchan->current_tx = tx;
   257			adchan->nperiod_acks = 0;
   258			admac_start(adchan);
   259		}
   260		spin_unlock_irqrestore(&adchan->lock, flags);
   261	}
   262	
 > 263	int admac_pause(struct dma_chan *chan)
   264	{
   265		struct admac_chan *adchan = to_admac_chan(chan);
   266	
   267		admac_poke(adchan->host, REG_TX_EN_CLR, 1 << adchan->no);
   268	
   269		return 0;
   270	}
   271	
 > 272	int admac_resume(struct dma_chan *chan)
   273	{
   274		struct admac_chan *adchan = to_admac_chan(chan);
   275		
   276		admac_poke(adchan->host, REG_TX_EN, 1 << adchan->no);
   277	
   278		return 0;
   279	}
   280	
 > 281	int admac_terminate_all(struct dma_chan *chan)
   282	{
   283		struct admac_chan *adchan = to_admac_chan(chan);
   284		struct admac_tx *adtx, *_adtx;
   285		unsigned long flags;
   286		LIST_HEAD(head);
   287	
   288		spin_lock_irqsave(&adchan->lock, flags);
   289		admac_poke(adchan->host, REG_TX_EN_CLR, 1 << adchan->no);
   290		adchan->current_tx = NULL;
   291		list_splice_tail_init(&adchan->submitted, &head);
   292		list_splice_tail_init(&adchan->issued, &head);
   293		spin_unlock_irqrestore(&adchan->lock, flags);
   294	
   295		list_for_each_entry_safe(adtx, _adtx, &head, node) {
   296			list_del(&adtx->node);
   297			admac_desc_free(&adtx->tx);
   298		}
   299	
   300		return 0;
   301	}
   302	
 > 303	dma_cookie_t admac_tx_submit(struct dma_async_tx_descriptor *tx)
   304	{
   305		struct admac_tx *adtx = to_admac_tx(tx);
   306		struct admac_chan *adchan = to_admac_chan(tx->chan);
   307		unsigned long flags;
   308		dma_cookie_t cookie;
   309	
   310		spin_lock_irqsave(&adchan->lock, flags);
   311		cookie = dma_cookie_assign(tx);
   312		list_add_tail(&adtx->node, &adchan->submitted);
   313		spin_unlock_irqrestore(&adchan->lock, flags);
   314	
   315		return cookie;
   316	}
   317	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

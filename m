Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957A14BD847
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbiBUIUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:20:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbiBUIUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:20:34 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705A3F4C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645431611; x=1676967611;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BTup9VLu8wdYFRgxpXodNxt1J1CV7t2oQa5Opeb9ODQ=;
  b=DzFFSQD/JZywlNtcNJrQTtv5ZvL059OeC6wDs7/03YXn2InZuP1jLsCT
   f/wzhbxW3u6aWB71A5rzHuY89MEDuhc+0D5byTF6hXo/7snLHZOYuI3Nk
   XsDECu3nWr9Qx0JBIQtUjo3HQll8abz3Z6g98JJw9caf6+B4x1abuwsMe
   DHLPALpHk/bfEkyFx0ds834w+N4YY2+26rXzOfCZBEqOFbT92GOGHieFb
   vmr8++phHqIvExdnUmeed/sTwtUw3QoUbA+Yhe9062rUPZx7c5suoCVTY
   pFPkkI74nVoFC/4pI84DIb1NGLvy68lJlNa41M9s1JrozxSQYf5XudW1t
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="251643638"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="251643638"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 00:20:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="490366074"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Feb 2022 00:20:08 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM3vU-0001PW-75; Mon, 21 Feb 2022 08:20:08 +0000
Date:   Mon, 21 Feb 2022 16:19:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/m1/2022-02-19 521/552]
 drivers/dma/apple-admac.c:132:14: warning: no previous prototype for
 'admac_tx_submit'
Message-ID: <202202211610.hJ0TsjqV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1/2022-02-19
head:   b781e0ccdc0c9a931571d15db09d45b7258b9905
commit: bee62b9888b1bd6bd610383080a17ba0c9bb215b [521/552] dmaengine: apple-admac: Add Apple ADMAC driver
config: m68k-buildonly-randconfig-r005-20220221 (https://download.01.org/0day-ci/archive/20220221/202202211610.hJ0TsjqV-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/bee62b9888b1bd6bd610383080a17ba0c9bb215b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1/2022-02-19
        git checkout bee62b9888b1bd6bd610383080a17ba0c9bb215b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash drivers/dma/ sound/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/dma/apple-admac.c:132:14: warning: no previous prototype for 'admac_tx_submit' [-Wmissing-prototypes]
     132 | dma_cookie_t admac_tx_submit(struct dma_async_tx_descriptor *tx)
         |              ^~~~~~~~~~~~~~~
>> drivers/dma/apple-admac.c:154:33: warning: no previous prototype for 'admac_prep_dma_cyclic' [-Wmissing-prototypes]
     154 | struct dma_async_tx_descriptor *admac_prep_dma_cyclic(
         |                                 ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/device.h:15,
                    from drivers/dma/apple-admac.c:2:
   drivers/dma/apple-admac.c: In function 'admac_cyclic_write_one_desc':
>> drivers/dma/apple-admac.c:200:26: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
     200 |         dev_dbg(ad->dev, "ch%d descriptor: addr=0x%llx len=0x%x flags=0x%lx\n",
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:129:41: note: in definition of macro 'dev_printk'
     129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
         |                                         ^~~
   include/linux/dev_printk.h:158:37: note: in expansion of macro 'dev_fmt'
     158 |         dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                     ^~~~~~~
   drivers/dma/apple-admac.c:200:9: note: in expansion of macro 'dev_dbg'
     200 |         dev_dbg(ad->dev, "ch%d descriptor: addr=0x%llx len=0x%x flags=0x%lx\n",
         |         ^~~~~~~
   drivers/dma/apple-admac.c:200:54: note: format string is defined here
     200 |         dev_dbg(ad->dev, "ch%d descriptor: addr=0x%llx len=0x%x flags=0x%lx\n",
         |                                                   ~~~^
         |                                                      |
         |                                                      long long unsigned int
         |                                                   %x
>> drivers/dma/apple-admac.c:204:53: warning: right shift count >= width of type [-Wshift-count-overflow]
     204 |         admac_poke(ad, REG_DESC_WRITE(channo), addr >> 32);
         |                                                     ^~
   drivers/dma/apple-admac.c: At top level:
>> drivers/dma/apple-admac.c:228:5: warning: no previous prototype for 'admac_alloc_chan_resources' [-Wmissing-prototypes]
     228 | int admac_alloc_chan_resources(struct dma_chan *chan)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/dma/apple-admac.c:233:6: warning: no previous prototype for 'admac_free_chan_resources' [-Wmissing-prototypes]
     233 | void admac_free_chan_resources(struct dma_chan *chan)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/dma/apple-admac.c:238:5: warning: no previous prototype for 'admac_ring_noccupied_slots' [-Wmissing-prototypes]
     238 | int admac_ring_noccupied_slots(int ringval)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c: In function 'admac_ring_noccupied_slots':
   drivers/dma/apple-admac.c:240:22: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
     240 |         int wrslot = FIELD_GET(RING_WRITE_SLOT, ringval);
         |                      ^~~~~~~~~
         |                      FOLL_GET
   drivers/dma/apple-admac.c: At top level:
>> drivers/dma/apple-admac.c:258:5: warning: no previous prototype for 'admac_cyclic_read_residue' [-Wmissing-prototypes]
     258 | u32 admac_cyclic_read_residue(struct admac_data *ad, int channo, struct admac_tx *adtx)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/dma/apple-admac.c:284:17: warning: no previous prototype for 'admac_tx_status' [-Wmissing-prototypes]
     284 | enum dma_status admac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
         |                 ^~~~~~~~~~~~~~~
>> drivers/dma/apple-admac.c:353:6: warning: no previous prototype for 'admac_start_current_tx' [-Wmissing-prototypes]
     353 | void admac_start_current_tx(struct admac_chan *adchan)
         |      ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/dma/apple-admac.c:367:6: warning: no previous prototype for 'admac_issue_pending' [-Wmissing-prototypes]
     367 | void admac_issue_pending(struct dma_chan *chan)
         |      ^~~~~~~~~~~~~~~~~~~
>> drivers/dma/apple-admac.c:386:5: warning: no previous prototype for 'admac_pause' [-Wmissing-prototypes]
     386 | int admac_pause(struct dma_chan *chan)
         |     ^~~~~~~~~~~
>> drivers/dma/apple-admac.c:395:5: warning: no previous prototype for 'admac_resume' [-Wmissing-prototypes]
     395 | int admac_resume(struct dma_chan *chan)
         |     ^~~~~~~~~~~~
>> drivers/dma/apple-admac.c:404:5: warning: no previous prototype for 'admac_terminate_all' [-Wmissing-prototypes]
     404 | int admac_terminate_all(struct dma_chan *chan)
         |     ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for NFSD_V2_ACL
   Depends on NETWORK_FILESYSTEMS && NFSD
   Selected by
   - NFSD_V3_ACL && NETWORK_FILESYSTEMS


vim +/admac_tx_submit +132 drivers/dma/apple-admac.c

   131	
 > 132	dma_cookie_t admac_tx_submit(struct dma_async_tx_descriptor *tx)
   133	{
   134		struct admac_tx *adtx = to_admac_tx(tx);
   135		struct admac_chan *adchan = to_admac_chan(tx->chan);
   136		unsigned long flags;
   137		dma_cookie_t cookie;
   138	
   139		spin_lock_irqsave(&adchan->lock, flags);
   140		cookie = dma_cookie_assign(tx);
   141		list_add_tail(&adtx->node, &adchan->submitted);
   142		spin_unlock_irqrestore(&adchan->lock, flags);
   143	
   144		return cookie;
   145	}
   146	
   147	static int admac_desc_free(struct dma_async_tx_descriptor *tx)
   148	{
   149		struct admac_tx *adtx = to_admac_tx(tx);
   150		devm_kfree(to_admac_chan(tx->chan)->host->dev, adtx);
   151		return 0;
   152	}
   153	
 > 154	struct dma_async_tx_descriptor *admac_prep_dma_cyclic(
   155			struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
   156			size_t period_len, enum dma_transfer_direction direction,
   157			unsigned long flags)
   158	{
   159		struct admac_chan *adchan = container_of(chan, struct admac_chan, chan);
   160		struct admac_tx *adtx;
   161	
   162		if (direction != admac_chan_direction(adchan->no))
   163			return NULL;
   164	
   165		adtx = devm_kzalloc(adchan->host->dev, sizeof(*adtx), GFP_NOWAIT);
   166		if (!adtx)
   167			return NULL;
   168	
   169		adtx->cyclic = true;
   170	
   171		adtx->buf_addr = buf_addr;
   172		adtx->buf_len = buf_len;
   173		adtx->buf_end = buf_addr + buf_len;
   174		adtx->period_len = period_len;
   175	
   176		adtx->submitted_pos = 0;
   177		adtx->reclaimed_pos = 0;
   178	
   179		dma_async_tx_descriptor_init(&adtx->tx, chan);
   180		adtx->tx.tx_submit = admac_tx_submit;
   181		adtx->tx.desc_free = admac_desc_free;
   182	
   183		return &adtx->tx;
   184	}
   185	
   186	/*
   187	 * Write one hardware descriptor for a dmaegine cyclic transaction.
   188	 */
   189	static void admac_cyclic_write_one_desc(struct admac_data *ad, int channo,
   190						struct admac_tx *tx)
   191	{
   192		dma_addr_t addr;
   193	
   194		if (WARN_ON(!tx->cyclic))
   195			return;
   196	
   197		addr = tx->buf_addr + (tx->submitted_pos % tx->buf_len);
   198		WARN_ON(addr + tx->period_len > tx->buf_end);
   199	
 > 200		dev_dbg(ad->dev, "ch%d descriptor: addr=0x%llx len=0x%x flags=0x%lx\n",
   201			channo, addr, (u32) tx->period_len, FLAG_DESC_NOTIFY);
   202	
   203		admac_poke(ad, REG_DESC_WRITE(channo), addr);
 > 204		admac_poke(ad, REG_DESC_WRITE(channo), addr >> 32);
   205		admac_poke(ad, REG_DESC_WRITE(channo), tx->period_len);
   206		admac_poke(ad, REG_DESC_WRITE(channo), FLAG_DESC_NOTIFY);
   207	
   208		tx->submitted_pos += tx->period_len;
   209		tx->submitted_pos %= 2 * tx->buf_len;
   210	}
   211	
   212	/*
   213	 * Write all the hardware descriptors for a cyclic transaction
   214	 * there is space for.
   215	 */
   216	static void admac_cyclic_write_desc(struct admac_data *ad, int channo,
   217						struct admac_tx *tx)
   218	{
   219		int i;
   220	
   221		for (i = 0; i < 4; i++) {
   222			if (admac_peek(ad, REG_DESC_RING(channo)) & RING_FULL)
   223				break;
   224			admac_cyclic_write_one_desc(ad, channo, tx);
   225		}
   226	}
   227	
 > 228	int admac_alloc_chan_resources(struct dma_chan *chan)
   229	{
   230		return 0;
   231	}
   232	
 > 233	void admac_free_chan_resources(struct dma_chan *chan)
   234	{
   235		// TODO
   236	}
   237	
 > 238	int admac_ring_noccupied_slots(int ringval)
   239	{
   240		int wrslot = FIELD_GET(RING_WRITE_SLOT, ringval);
   241		int rdslot = FIELD_GET(RING_READ_SLOT, ringval);
   242	
   243		if (wrslot != rdslot) {
   244			return (wrslot + 4 - rdslot) % 4;
   245		} else {
   246			WARN_ON((ringval & (RING_FULL | RING_EMPTY)) == 0);
   247	
   248			if (ringval & RING_FULL)
   249				return 4;
   250			else
   251				return 0;
   252		}
   253	}
   254	
   255	/*
   256	 * Read from hardware the residue of a cyclic dmaengine transaction.
   257	 */
 > 258	u32 admac_cyclic_read_residue(struct admac_data *ad, int channo, struct admac_tx *adtx)
   259	{
   260		u32 ring1, ring2;
   261		u32 residue1, residue2;
   262		int nreports;
   263		size_t pos;
   264	
   265		ring1 =    admac_peek(ad, REG_REPORT_RING(channo));
   266		residue1 = admac_peek(ad, REG_RESIDUE(channo));
   267		ring2 =    admac_peek(ad, REG_REPORT_RING(channo));
   268		residue2 = admac_peek(ad, REG_RESIDUE(channo));
   269	
   270		if (residue2 > residue1) {
   271			// engine must have loaded next descriptor between the two residue reads
   272			nreports = admac_ring_noccupied_slots(ring1) + 1;
   273		} else {
   274			// no descriptor load between the two reads, ring2 is safe to use
   275			nreports = admac_ring_noccupied_slots(ring2);
   276		}
   277	
   278		pos = adtx->reclaimed_pos + adtx->period_len * (nreports + 1) \
   279							 - residue2;
   280	
   281		return adtx->buf_len - pos % adtx->buf_len;
   282	}
   283	
 > 284	enum dma_status admac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
   285					struct dma_tx_state *txstate)
   286	{
   287		struct admac_chan *adchan = to_admac_chan(chan);
   288		struct admac_data *ad = adchan->host;
   289		struct admac_tx *adtx;
   290	
   291		enum dma_status ret;
   292		size_t residue;
   293		unsigned long flags;
   294	
   295		ret = dma_cookie_status(chan, cookie, txstate);
   296		if (ret == DMA_COMPLETE || !txstate)
   297			return ret;
   298	
   299		spin_lock_irqsave(&adchan->lock, flags);
   300		adtx = adchan->current_tx;
   301	
   302		if (adtx && adtx->tx.cookie == cookie) {
   303			ret = DMA_IN_PROGRESS;
   304			residue = admac_cyclic_read_residue(ad, adchan->no, adtx);
   305		} else {
   306			ret = DMA_IN_PROGRESS;
   307			residue = 0;
   308			list_for_each_entry(adtx, &adchan->issued, node) {
   309				if (adtx->tx.cookie == cookie) {
   310					residue = adtx->buf_len;
   311					break;
   312				}
   313			}
   314		}
   315		spin_unlock_irqrestore(&adchan->lock, flags);
   316	
   317		dma_set_residue(txstate, residue);
   318		return ret;
   319	}
   320	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

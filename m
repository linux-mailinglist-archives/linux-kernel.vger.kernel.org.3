Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A68475DDA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244971AbhLOQsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:48:10 -0500
Received: from mga17.intel.com ([192.55.52.151]:41796 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239830AbhLOQsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639586889; x=1671122889;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WUX53sGX7cPkQV6k5UQNwcjN69T3ZaxQRWXWWP5hYOE=;
  b=YpS1fI7tl9bWsDN4zpqmRY04q4v7Wv8ZtSdpj0i6dR6ijtG7tpbn4zm9
   bzjrPgm74og+wt2yC5tIQLVyRhL4JaF+lkFYHDR6b3Ke9rAgokJYmHh5K
   vjTO18+L9CCY5aDUCr/mEj6wHjrA4434HiXykJHzaLCWMT5mvazyVEE51
   RBRPc+RuBzhTSTCOqlCfUnU9cMZiW4S/8j+jMUsezzF8qP/ULoaXCbAY+
   nrHTYZI6dAvnZLwbp2Cykwfzry7BGuxN3518ABl9OvNfEG7+6h9fjGWyJ
   M+ncW9cRlcHAbjD+qjAzfbEgM2CL1A5oHBroWjpZcLARfB1xI3mx7RSxb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="219955806"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="219955806"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 08:48:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="464335835"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Dec 2021 08:48:07 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxXRm-00023z-K6; Wed, 15 Dec 2021 16:48:06 +0000
Date:   Thu, 16 Dec 2021 00:47:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik@protonmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:touchpad/wip 63/82] drivers/dma/apple-admac.c:221:34:
 warning: format '%lx' expects argument of type 'long unsigned int', but
 argument 5 has type 'size_t' {aka 'unsigned int'}
Message-ID: <202112160031.DEIICVwO-lkp@intel.com>
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
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20211216/202112160031.DEIICVwO-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/ebaeac45289171e9e6a775d13f2bf34bfec4d104
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux touchpad/wip
        git checkout ebaeac45289171e9e6a775d13f2bf34bfec4d104
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash drivers/dma/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/dma/apple-admac.c:125:5: warning: no previous prototype for 'admac_alloc_chan_resources' [-Wmissing-prototypes]
     125 | int admac_alloc_chan_resources(struct dma_chan *chan)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:130:6: warning: no previous prototype for 'admac_free_chan_resources' [-Wmissing-prototypes]
     130 | void admac_free_chan_resources(struct dma_chan *chan)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:135:5: warning: no previous prototype for 'admac_ring_noccupied_slots' [-Wmissing-prototypes]
     135 | int admac_ring_noccupied_slots(int ringval)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c: In function 'admac_ring_noccupied_slots':
   drivers/dma/apple-admac.c:137:22: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
     137 |         int wrslot = FIELD_GET(RING_WRITE_SLOT, ringval);
         |                      ^~~~~~~~~
         |                      FOLL_GET
   drivers/dma/apple-admac.c: At top level:
   drivers/dma/apple-admac.c:155:5: warning: no previous prototype for 'admac_cyclic_read_residue' [-Wmissing-prototypes]
     155 | u32 admac_cyclic_read_residue(struct admac_data *ad, int channo, struct admac_tx *adtx)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:181:17: warning: no previous prototype for 'admac_tx_status' [-Wmissing-prototypes]
     181 | enum dma_status admac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
         |                 ^~~~~~~~~~~~~~~
   In file included from include/linux/printk.h:555,
                    from include/linux/kernel.h:20,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/parisc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/dma/apple-admac.c:2:
   drivers/dma/apple-admac.c: In function 'admac_tx_status':
>> drivers/dma/apple-admac.c:221:34: warning: format '%lx' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     221 |                 dev_dbg(ad->dev, "ch%d residue: %lx, (%ld%%)\n", adchan->no,
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   drivers/dma/apple-admac.c:221:17: note: in expansion of macro 'dev_dbg'
     221 |                 dev_dbg(ad->dev, "ch%d residue: %lx, (%ld%%)\n", adchan->no,
         |                 ^~~~~~~
   drivers/dma/apple-admac.c:221:51: note: format string is defined here
     221 |                 dev_dbg(ad->dev, "ch%d residue: %lx, (%ld%%)\n", adchan->no,
         |                                                 ~~^
         |                                                   |
         |                                                   long unsigned int
         |                                                 %x
   In file included from include/linux/printk.h:555,
                    from include/linux/kernel.h:20,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/parisc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/dma/apple-admac.c:2:
>> drivers/dma/apple-admac.c:221:34: warning: format '%ld' expects argument of type 'long int', but argument 6 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     221 |                 dev_dbg(ad->dev, "ch%d residue: %lx, (%ld%%)\n", adchan->no,
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   drivers/dma/apple-admac.c:221:17: note: in expansion of macro 'dev_dbg'
     221 |                 dev_dbg(ad->dev, "ch%d residue: %lx, (%ld%%)\n", adchan->no,
         |                 ^~~~~~~
   drivers/dma/apple-admac.c:221:57: note: format string is defined here
     221 |                 dev_dbg(ad->dev, "ch%d residue: %lx, (%ld%%)\n", adchan->no,
         |                                                       ~~^
         |                                                         |
         |                                                         long int
         |                                                       %d
   drivers/dma/apple-admac.c: At top level:
   drivers/dma/apple-admac.c:228:6: warning: no previous prototype for 'admac_start' [-Wmissing-prototypes]
     228 | void admac_start(struct admac_chan *adchan)
         |      ^~~~~~~~~~~
   drivers/dma/apple-admac.c:244:6: warning: no previous prototype for 'admac_issue_pending' [-Wmissing-prototypes]
     244 | void admac_issue_pending(struct dma_chan *chan)
         |      ^~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:263:5: warning: no previous prototype for 'admac_pause' [-Wmissing-prototypes]
     263 | int admac_pause(struct dma_chan *chan)
         |     ^~~~~~~~~~~
   drivers/dma/apple-admac.c:272:5: warning: no previous prototype for 'admac_resume' [-Wmissing-prototypes]
     272 | int admac_resume(struct dma_chan *chan)
         |     ^~~~~~~~~~~~
   drivers/dma/apple-admac.c:281:5: warning: no previous prototype for 'admac_terminate_all' [-Wmissing-prototypes]
     281 | int admac_terminate_all(struct dma_chan *chan)
         |     ^~~~~~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:303:14: warning: no previous prototype for 'admac_tx_submit' [-Wmissing-prototypes]
     303 | dma_cookie_t admac_tx_submit(struct dma_async_tx_descriptor *tx)
         |              ^~~~~~~~~~~~~~~
   drivers/dma/apple-admac.c:325:33: warning: no previous prototype for 'admac_prep_dma_cyclic' [-Wmissing-prototypes]
     325 | struct dma_async_tx_descriptor *admac_prep_dma_cyclic(
         |                                 ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/printk.h:555,
                    from include/linux/kernel.h:20,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/parisc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/dma/apple-admac.c:2:
   drivers/dma/apple-admac.c: In function 'admac_cyclic_write_one_desc':
>> drivers/dma/apple-admac.c:387:26: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
     387 |         dev_dbg(ad->dev, "ch%d descriptor: addr=0x%llx len=0x%x flags=0x%lx\n",
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
   drivers/dma/apple-admac.c:387:9: note: in expansion of macro 'dev_dbg'
     387 |         dev_dbg(ad->dev, "ch%d descriptor: addr=0x%llx len=0x%x flags=0x%lx\n",
         |         ^~~~~~~
   drivers/dma/apple-admac.c:387:54: note: format string is defined here
     387 |         dev_dbg(ad->dev, "ch%d descriptor: addr=0x%llx len=0x%x flags=0x%lx\n",
         |                                                   ~~~^
         |                                                      |
         |                                                      long long unsigned int
         |                                                   %x
>> drivers/dma/apple-admac.c:391:56: warning: right shift count >= width of type [-Wshift-count-overflow]
     391 |         admac_poke(ad, REG_TX_DESC_WRITE(channo), addr >> 32);
         |                                                        ^~
   cc1: some warnings being treated as errors


vim +221 drivers/dma/apple-admac.c

   180	
   181	enum dma_status admac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
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
 > 221			dev_dbg(ad->dev, "ch%d residue: %lx, (%ld%%)\n", adchan->no,
   222				residue, residue*100/adtx->buf_len);
   223	
   224		dma_set_residue(txstate, residue);
   225		return ret;
   226	}
   227	
   228	void admac_start(struct admac_chan *adchan)
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
   244	void admac_issue_pending(struct dma_chan *chan)
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
   263	int admac_pause(struct dma_chan *chan)
   264	{
   265		struct admac_chan *adchan = to_admac_chan(chan);
   266	
   267		admac_poke(adchan->host, REG_TX_EN_CLR, 1 << adchan->no);
   268	
   269		return 0;
   270	}
   271	
   272	int admac_resume(struct dma_chan *chan)
   273	{
   274		struct admac_chan *adchan = to_admac_chan(chan);
   275		
   276		admac_poke(adchan->host, REG_TX_EN, 1 << adchan->no);
   277	
   278		return 0;
   279	}
   280	
   281	int admac_terminate_all(struct dma_chan *chan)
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
   303	dma_cookie_t admac_tx_submit(struct dma_async_tx_descriptor *tx)
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
   318	static int admac_desc_free(struct dma_async_tx_descriptor *tx)
   319	{
   320		struct admac_tx *adtx = to_admac_tx(tx);
   321		devm_kfree(to_admac_chan(tx->chan)->host->dev, adtx);
   322		return 0;
   323	}
   324	
   325	struct dma_async_tx_descriptor *admac_prep_dma_cyclic(
   326			struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
   327			size_t period_len, enum dma_transfer_direction direction,
   328			unsigned long flags)
   329	{
   330		struct admac_chan *adchan = container_of(chan, struct admac_chan, chan);
   331		struct admac_tx *adtx;
   332	
   333		adtx = devm_kzalloc(adchan->host->dev, sizeof(*adtx), GFP_NOWAIT);
   334		if (!adtx)
   335			return NULL;
   336	
   337		adtx->cyclic = true;
   338	
   339		adtx->buf_addr = buf_addr;
   340		adtx->buf_len = buf_len;
   341		adtx->buf_end = buf_addr + buf_len;
   342		adtx->period_len = period_len;
   343	
   344		adtx->submitted_pos = 0;
   345		adtx->reclaimed_pos = 0;
   346	
   347		dma_async_tx_descriptor_init(&adtx->tx, chan);
   348		adtx->tx.tx_submit = admac_tx_submit;
   349		adtx->tx.desc_free = admac_desc_free;
   350	
   351		return &adtx->tx;
   352	}
   353	
   354	static struct dma_chan *admac_dma_of_xlate(struct of_phandle_args *dma_spec,
   355							struct of_dma *ofdma)
   356	{
   357		struct admac_data *ad = (struct admac_data*) ofdma->of_dma_data;
   358		unsigned int index;
   359	
   360		if (dma_spec->args_count != 1)
   361			return NULL;
   362	
   363		index = dma_spec->args[0];
   364	
   365		if (index >= ad->nchannels) {
   366			dev_err(ad->dev, "channel index %u out of bounds\n", index);
   367			return NULL;
   368		}
   369	
   370		return &ad->channels[index].chan;
   371	}
   372	
   373	/*
   374	 * Write one hardware descriptor for a dmaegine cyclic transaction.
   375	 */
   376	static void admac_cyclic_write_one_desc(struct admac_data *ad, int channo,
   377						struct admac_tx *tx)
   378	{
   379		dma_addr_t addr;
   380	
   381		if (WARN_ON(!tx->cyclic))
   382			return;
   383	
   384		addr = tx->buf_addr + (tx->submitted_pos % tx->buf_len);
   385		WARN_ON(addr + tx->period_len > tx->buf_end);
   386	
 > 387		dev_dbg(ad->dev, "ch%d descriptor: addr=0x%llx len=0x%x flags=0x%lx\n",
   388			channo, addr, (u32) tx->period_len, FLAG_DESC_NOTIFY);
   389	
   390		admac_poke(ad, REG_TX_DESC_WRITE(channo), addr);
 > 391		admac_poke(ad, REG_TX_DESC_WRITE(channo), addr >> 32);
   392		admac_poke(ad, REG_TX_DESC_WRITE(channo), tx->period_len);
   393		admac_poke(ad, REG_TX_DESC_WRITE(channo), FLAG_DESC_NOTIFY);
   394	
   395		tx->submitted_pos += tx->period_len;
   396		tx->submitted_pos %= 2 * tx->buf_len;
   397	}
   398	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

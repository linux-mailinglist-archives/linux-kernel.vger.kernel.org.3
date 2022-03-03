Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872FC4CBC0B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiCCLCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiCCLCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:02:38 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F681786B7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646305312; x=1677841312;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gSQPkn/TuZLMNqTIS+EqBIFhqpvKZeiYQNdjzGOc6Jg=;
  b=YSQCdyAT/o+HWasX73enCpsTm31VfYXcZHYwwLomBUv1ZdUgDnkL5nRv
   keA6w+d/b5bAKRPhPG7KnWxDQjYWya2tDB2uiaABHtmHKmjlFPBLfKpfC
   zKU1/8os4qcaOcaCBhwSXxnnqJzksA0+xIlOKKo6TN+N+rji9gAtpcQli
   mrYXIQJv5d5zmbidKwIraKERqQkFVhE/9shJBgh9B493oxdXYu7f1LW5T
   yIguBdqLNeBLM3pyUNQTrNR+WtzfWD6eTJTvWkwzng6ZmcsRqih33uHQT
   Zlc2MfqkaPb3f+0kJwyLZrrjdyaQ0+wk8O0ySYa/3w576ilIs8aOYQ38W
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="251218952"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="251218952"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 03:01:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="630753454"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Mar 2022 03:01:51 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPjDS-0000Pz-En; Thu, 03 Mar 2022 11:01:50 +0000
Date:   Thu, 3 Mar 2022 19:00:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Elder <elder@linaro.org>
Subject: [mani-mhi:mhi-next 28/30] drivers/bus/mhi/ep/main.c:518:59: sparse:
 sparse: incorrect type in argument 2 (different address spaces)
Message-ID: <202203031843.MqGoCnTF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git mhi-next
head:   4aa2b597db8f8808b7e0f89239cd98c3a56b21b1
commit: 32e645601057f7a917ac6c9d007fd6d9a0ff2635 [28/30] bus: mhi: ep: Add support for queueing SKBs to the host
config: ia64-randconfig-s031-20220302 (https://download.01.org/0day-ci/archive/20220303/202203031843.MqGoCnTF-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git/commit/?id=32e645601057f7a917ac6c9d007fd6d9a0ff2635
        git remote add mani-mhi https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
        git fetch --no-tags mani-mhi mhi-next
        git checkout 32e645601057f7a917ac6c9d007fd6d9a0ff2635
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/bus/mhi/ep/ drivers/nvmem/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/bus/mhi/ep/main.c:152:5: sparse: sparse: symbol 'mhi_ep_process_cmd_ring' was not declared. Should it be static?
   drivers/bus/mhi/ep/main.c:357:71: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *to @@     got void *[assigned] write_addr @@
   drivers/bus/mhi/ep/main.c:357:71: sparse:     expected void [noderef] __iomem *to
   drivers/bus/mhi/ep/main.c:357:71: sparse:     got void *[assigned] write_addr
   drivers/bus/mhi/ep/main.c:423:5: sparse: sparse: symbol 'mhi_ep_process_ch_ring' was not declared. Should it be static?
>> drivers/bus/mhi/ep/main.c:518:59: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *from @@     got void *[assigned] read_addr @@
   drivers/bus/mhi/ep/main.c:518:59: sparse:     expected void [noderef] __iomem *from
   drivers/bus/mhi/ep/main.c:518:59: sparse:     got void *[assigned] read_addr
   drivers/bus/mhi/ep/main.c:620:34: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct mhi_cmd_ctxt *cmd_ctx_cache @@
   drivers/bus/mhi/ep/main.c:620:34: sparse:     expected void [noderef] __iomem *virt
   drivers/bus/mhi/ep/main.c:620:34: sparse:     got struct mhi_cmd_ctxt *cmd_ctx_cache
   drivers/bus/mhi/ep/main.c:624:34: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct mhi_event_ctxt *ev_ctx_cache @@
   drivers/bus/mhi/ep/main.c:624:34: sparse:     expected void [noderef] __iomem *virt
   drivers/bus/mhi/ep/main.c:624:34: sparse:     got struct mhi_event_ctxt *ev_ctx_cache
   drivers/bus/mhi/ep/main.c:628:34: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct mhi_chan_ctxt *ch_ctx_cache @@
   drivers/bus/mhi/ep/main.c:628:34: sparse:     expected void [noderef] __iomem *virt
   drivers/bus/mhi/ep/main.c:628:34: sparse:     got struct mhi_chan_ctxt *ch_ctx_cache
   drivers/bus/mhi/ep/main.c:642:34: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct mhi_cmd_ctxt *cmd_ctx_cache @@
   drivers/bus/mhi/ep/main.c:642:34: sparse:     expected void [noderef] __iomem *virt
   drivers/bus/mhi/ep/main.c:642:34: sparse:     got struct mhi_cmd_ctxt *cmd_ctx_cache
   drivers/bus/mhi/ep/main.c:644:34: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct mhi_event_ctxt *ev_ctx_cache @@
   drivers/bus/mhi/ep/main.c:644:34: sparse:     expected void [noderef] __iomem *virt
   drivers/bus/mhi/ep/main.c:644:34: sparse:     got struct mhi_event_ctxt *ev_ctx_cache
   drivers/bus/mhi/ep/main.c:646:34: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct mhi_chan_ctxt *ch_ctx_cache @@
   drivers/bus/mhi/ep/main.c:646:34: sparse:     expected void [noderef] __iomem *virt
   drivers/bus/mhi/ep/main.c:646:34: sparse:     got struct mhi_chan_ctxt *ch_ctx_cache

vim +518 drivers/bus/mhi/ep/main.c

   473	
   474	/* TODO: Handle partially formed TDs */
   475	int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
   476	{
   477		struct mhi_ep_cntrl *mhi_cntrl = mhi_dev->mhi_cntrl;
   478		struct mhi_ep_chan *mhi_chan = mhi_dev->dl_chan;
   479		struct device *dev = &mhi_chan->mhi_dev->dev;
   480		struct mhi_ring_element *el;
   481		u32 buf_left, read_offset;
   482		struct mhi_ep_ring *ring;
   483		enum mhi_ev_ccs code;
   484		void *read_addr;
   485		u64 write_addr;
   486		size_t tr_len;
   487		u32 tre_len;
   488		int ret;
   489	
   490		buf_left = skb->len;
   491		ring = &mhi_cntrl->mhi_chan[mhi_chan->chan].ring;
   492	
   493		mutex_lock(&mhi_chan->lock);
   494	
   495		do {
   496			/* Don't process the transfer ring if the channel is not in RUNNING state */
   497			if (mhi_chan->state != MHI_CH_STATE_RUNNING) {
   498				dev_err(dev, "Channel not available\n");
   499				ret = -ENODEV;
   500				goto err_exit;
   501			}
   502	
   503			if (mhi_ep_queue_is_empty(mhi_dev, DMA_FROM_DEVICE)) {
   504				dev_err(dev, "TRE not available!\n");
   505				ret = -ENOSPC;
   506				goto err_exit;
   507			}
   508	
   509			el = &ring->ring_cache[ring->rd_offset];
   510			tre_len = MHI_TRE_DATA_GET_LEN(el);
   511	
   512			tr_len = min(buf_left, tre_len);
   513			read_offset = skb->len - buf_left;
   514			read_addr = skb->data + read_offset;
   515			write_addr = MHI_TRE_DATA_GET_PTR(el);
   516	
   517			dev_dbg(dev, "Writing %zd bytes to channel (%u)\n", tr_len, ring->ch_id);
 > 518			ret = mhi_cntrl->write_to_host(mhi_cntrl, read_addr, write_addr, tr_len);
   519			if (ret < 0) {
   520				dev_err(dev, "Error writing to the channel\n");
   521				goto err_exit;
   522			}
   523	
   524			buf_left -= tr_len;
   525			/*
   526			 * For all TREs queued by the host for DL channel, only the EOT flag will be set.
   527			 * If the packet doesn't fit into a single TRE, send the OVERFLOW event to
   528			 * the host so that the host can adjust the packet boundary to next TREs. Else send
   529			 * the EOT event to the host indicating the packet boundary.
   530			 */
   531			if (buf_left)
   532				code = MHI_EV_CC_OVERFLOW;
   533			else
   534				code = MHI_EV_CC_EOT;
   535	
   536			ret = mhi_ep_send_completion_event(mhi_cntrl, ring, el, tr_len, code);
   537			if (ret) {
   538				dev_err(dev, "Error sending transfer completion event\n");
   539				goto err_exit;
   540			}
   541	
   542			mhi_ep_ring_inc_index(ring);
   543		} while (buf_left);
   544	
   545		mutex_unlock(&mhi_chan->lock);
   546	
   547		return 0;
   548	
   549	err_exit:
   550		mutex_unlock(&mhi_chan->lock);
   551	
   552		return ret;
   553	}
   554	EXPORT_SYMBOL_GPL(mhi_ep_queue_skb);
   555	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

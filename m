Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726F24CB699
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 06:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiCCF4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 00:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiCCF4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 00:56:32 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8C7C9A24
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 21:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646286947; x=1677822947;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6ovB6vVB1YiVQjCPofVI32+qZDjcMARUkCWmcU5z5J0=;
  b=cwkBIzQg/x/yzbCCBymoLIfM+KQL+0tkY0Mth7ZG0iMW/d+o9asr0T5h
   Vd8k9bYl8l6eWHjqoXL87pdU2YObZvk4rMGL6oez1QyljjOuMNwpRB08E
   oIhPWBb+byImnDID0l0BePl0pDR0ahR/yb49pPqVYD1RtlWsy0m9+mXv1
   TPsqF687Cs9TZEa+TmsbRf0/JpOq8qrZbXNiVyY6+agBFuftTgycWlO/f
   goXTjyo2jofoLj61rcAiaezpC5i3DOCJn+scRv+GoCo8OftxhZi9o1tYf
   l6JDZnKYv8c+XFes4LY9cFv+fdSHCzWO/ZYS4+KPxOSJKYwGzLtpLlYwD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="233550564"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="233550564"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 21:55:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="594268649"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 Mar 2022 21:55:45 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPeRF-0000Cj-7z; Thu, 03 Mar 2022 05:55:45 +0000
Date:   Thu, 3 Mar 2022 13:55:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Elder <elder@linaro.org>
Subject: [mani-mhi:mhi-next 26/30] drivers/bus/mhi/ep/main.c:357:71: sparse:
 sparse: incorrect type in argument 3 (different address spaces)
Message-ID: <202203031356.vS8LSPwY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git mhi-next
head:   4aa2b597db8f8808b7e0f89239cd98c3a56b21b1
commit: 8c4345a08ac4d20d50fe394141ba5f7945196c7d [26/30] bus: mhi: ep: Add support for reading from the host
config: ia64-randconfig-s031-20220302 (https://download.01.org/0day-ci/archive/20220303/202203031356.vS8LSPwY-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git/commit/?id=8c4345a08ac4d20d50fe394141ba5f7945196c7d
        git remote add mani-mhi https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
        git fetch --no-tags mani-mhi mhi-next
        git checkout 8c4345a08ac4d20d50fe394141ba5f7945196c7d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/bus/mhi/ep/ drivers/nvmem/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/bus/mhi/ep/main.c:152:5: sparse: sparse: symbol 'mhi_ep_process_cmd_ring' was not declared. Should it be static?
>> drivers/bus/mhi/ep/main.c:357:71: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *to @@     got void *[assigned] write_addr @@
   drivers/bus/mhi/ep/main.c:357:71: sparse:     expected void [noderef] __iomem *to
   drivers/bus/mhi/ep/main.c:357:71: sparse:     got void *[assigned] write_addr
   drivers/bus/mhi/ep/main.c:487:34: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct mhi_cmd_ctxt *cmd_ctx_cache @@
   drivers/bus/mhi/ep/main.c:487:34: sparse:     expected void [noderef] __iomem *virt
   drivers/bus/mhi/ep/main.c:487:34: sparse:     got struct mhi_cmd_ctxt *cmd_ctx_cache
   drivers/bus/mhi/ep/main.c:491:34: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct mhi_event_ctxt *ev_ctx_cache @@
   drivers/bus/mhi/ep/main.c:491:34: sparse:     expected void [noderef] __iomem *virt
   drivers/bus/mhi/ep/main.c:491:34: sparse:     got struct mhi_event_ctxt *ev_ctx_cache
   drivers/bus/mhi/ep/main.c:495:34: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct mhi_chan_ctxt *ch_ctx_cache @@
   drivers/bus/mhi/ep/main.c:495:34: sparse:     expected void [noderef] __iomem *virt
   drivers/bus/mhi/ep/main.c:495:34: sparse:     got struct mhi_chan_ctxt *ch_ctx_cache
   drivers/bus/mhi/ep/main.c:509:34: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct mhi_cmd_ctxt *cmd_ctx_cache @@
   drivers/bus/mhi/ep/main.c:509:34: sparse:     expected void [noderef] __iomem *virt
   drivers/bus/mhi/ep/main.c:509:34: sparse:     got struct mhi_cmd_ctxt *cmd_ctx_cache
   drivers/bus/mhi/ep/main.c:511:34: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct mhi_event_ctxt *ev_ctx_cache @@
   drivers/bus/mhi/ep/main.c:511:34: sparse:     expected void [noderef] __iomem *virt
   drivers/bus/mhi/ep/main.c:511:34: sparse:     got struct mhi_event_ctxt *ev_ctx_cache
   drivers/bus/mhi/ep/main.c:513:34: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct mhi_chan_ctxt *ch_ctx_cache @@
   drivers/bus/mhi/ep/main.c:513:34: sparse:     expected void [noderef] __iomem *virt
   drivers/bus/mhi/ep/main.c:513:34: sparse:     got struct mhi_chan_ctxt *ch_ctx_cache

vim +357 drivers/bus/mhi/ep/main.c

   312	
   313	static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
   314					struct mhi_ep_ring *ring,
   315					struct mhi_result *result,
   316					u32 len)
   317	{
   318		struct mhi_ep_chan *mhi_chan = &mhi_cntrl->mhi_chan[ring->ch_id];
   319		struct device *dev = &mhi_cntrl->mhi_dev->dev;
   320		size_t tr_len, read_offset, write_offset;
   321		struct mhi_ring_element *el;
   322		bool tr_done = false;
   323		void *write_addr;
   324		u64 read_addr;
   325		u32 buf_left;
   326		int ret;
   327	
   328		buf_left = len;
   329	
   330		do {
   331			/* Don't process the transfer ring if the channel is not in RUNNING state */
   332			if (mhi_chan->state != MHI_CH_STATE_RUNNING) {
   333				dev_err(dev, "Channel not available\n");
   334				return -ENODEV;
   335			}
   336	
   337			el = &ring->ring_cache[ring->rd_offset];
   338	
   339			/* Check if there is data pending to be read from previous read operation */
   340			if (mhi_chan->tre_bytes_left) {
   341				dev_dbg(dev, "TRE bytes remaining: %u\n", mhi_chan->tre_bytes_left);
   342				tr_len = min(buf_left, mhi_chan->tre_bytes_left);
   343			} else {
   344				mhi_chan->tre_loc = MHI_TRE_DATA_GET_PTR(el);
   345				mhi_chan->tre_size = MHI_TRE_DATA_GET_LEN(el);
   346				mhi_chan->tre_bytes_left = mhi_chan->tre_size;
   347	
   348				tr_len = min(buf_left, mhi_chan->tre_size);
   349			}
   350	
   351			read_offset = mhi_chan->tre_size - mhi_chan->tre_bytes_left;
   352			write_offset = len - buf_left;
   353			read_addr = mhi_chan->tre_loc + read_offset;
   354			write_addr = result->buf_addr + write_offset;
   355	
   356			dev_dbg(dev, "Reading %zd bytes from channel (%u)\n", tr_len, ring->ch_id);
 > 357			ret = mhi_cntrl->read_from_host(mhi_cntrl, read_addr, write_addr, tr_len);
   358			if (ret < 0) {
   359				dev_err(&mhi_chan->mhi_dev->dev, "Error reading from channel\n");
   360				return ret;
   361			}
   362	
   363			buf_left -= tr_len;
   364			mhi_chan->tre_bytes_left -= tr_len;
   365	
   366			/*
   367			 * Once the TRE (Transfer Ring Element) of a TD (Transfer Descriptor) has been
   368			 * read completely:
   369			 *
   370			 * 1. Send completion event to the host based on the flags set in TRE.
   371			 * 2. Increment the local read offset of the transfer ring.
   372			 */
   373			if (!mhi_chan->tre_bytes_left) {
   374				/*
   375				 * The host will split the data packet into multiple TREs if it can't fit
   376				 * the packet in a single TRE. In that case, CHAIN flag will be set by the
   377				 * host for all TREs except the last one.
   378				 */
   379				if (MHI_TRE_DATA_GET_CHAIN(el)) {
   380					/*
   381					 * IEOB (Interrupt on End of Block) flag will be set by the host if
   382					 * it expects the completion event for all TREs of a TD.
   383					 */
   384					if (MHI_TRE_DATA_GET_IEOB(el)) {
   385						ret = mhi_ep_send_completion_event(mhi_cntrl, ring, el,
   386									     MHI_TRE_DATA_GET_LEN(el),
   387									     MHI_EV_CC_EOB);
   388						if (ret < 0) {
   389							dev_err(&mhi_chan->mhi_dev->dev,
   390								"Error sending transfer compl. event\n");
   391							return ret;
   392						}
   393					}
   394				} else {
   395					/*
   396					 * IEOT (Interrupt on End of Transfer) flag will be set by the host
   397					 * for the last TRE of the TD and expects the completion event for
   398					 * the same.
   399					 */
   400					if (MHI_TRE_DATA_GET_IEOT(el)) {
   401						ret = mhi_ep_send_completion_event(mhi_cntrl, ring, el,
   402									     MHI_TRE_DATA_GET_LEN(el),
   403									     MHI_EV_CC_EOT);
   404						if (ret < 0) {
   405							dev_err(&mhi_chan->mhi_dev->dev,
   406								"Error sending transfer compl. event\n");
   407							return ret;
   408						}
   409					}
   410	
   411					tr_done = true;
   412				}
   413	
   414				mhi_ep_ring_inc_index(ring);
   415			}
   416	
   417			result->bytes_xferd += tr_len;
   418		} while (buf_left && !tr_done);
   419	
   420		return 0;
   421	}
   422	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

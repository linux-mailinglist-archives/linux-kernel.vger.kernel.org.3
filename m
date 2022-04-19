Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B002506356
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348331AbiDSEgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348275AbiDSEgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:36:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4CB2B19F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650342809; x=1681878809;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I6BNEXCrHWfdRfeF2Ry9GJmcP9eFN8eWWWmV8o60rmo=;
  b=ZTpLjGKuJGEOuTkx2DNFxTJkPJc4GRjaGatvzojukxB1K0qwzPu+kD6M
   B0Hv8sfm/YoYnm+don0FPk7Yejjkh+bvOkgqusuyT5+K/9C8EQ0IB+LAJ
   2IhtxkBj2cYO0wBYVFWJ/+uAbzDDlAu+8l1MDUCqW4wsaWyTprIGvfYK2
   7GsR045d3g3SXs/r0cSQ9Cy6i8Mk1zxNbvBqlnVjqOiYfKB/xSNWauHR+
   K3EIVqQBKL0Vvt0/kW0Mt5LZqFkz2emI7vXXqiNSR21N3siUOXAlayTnH
   PFwDiVoPxrcQwDk7xa6nNIBbwThCRSM1+2p+EUdKN3N3v+wWd10K3nSaa
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="244256893"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="244256893"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 21:33:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="613859391"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 18 Apr 2022 21:33:24 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngfYJ-0005Ld-VF;
        Tue, 19 Apr 2022 04:33:23 +0000
Date:   Tue, 19 Apr 2022 12:32:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2226/2356]
 drivers/bus/mhi/host/main.c:642:33: error: implicit declaration of function
 'atomic_dec'
Message-ID: <202204191252.3D5Xwd3o-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: 44cbd089ce5d36cfd91b9e9486163f0bd38d8995 [2226/2356] headers/deps: irq: Optimize <linux/interrupt.h> dependencies
config: x86_64-randconfig-a004-20220418 (https://download.01.org/0day-ci/archive/20220419/202204191252.3D5Xwd3o-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=44cbd089ce5d36cfd91b9e9486163f0bd38d8995
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 44cbd089ce5d36cfd91b9e9486163f0bd38d8995
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/bus/mhi/host/main.c:21:
   drivers/bus/mhi/host/internal.h:203:31: error: field 'task' has incomplete type
     203 |         struct tasklet_struct task;
         |                               ^~~~
   drivers/bus/mhi/host/internal.h: In function 'mhi_trigger_resume':
   drivers/bus/mhi/host/internal.h:306:9: error: implicit declaration of function 'pm_wakeup_event' [-Werror=implicit-function-declaration]
     306 |         pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
         |         ^~~~~~~~~~~~~~~
   drivers/bus/mhi/host/main.c: In function 'mhi_create_devices':
   drivers/bus/mhi/host/main.c:422:25: error: implicit declaration of function 'device_init_wakeup'; did you mean 'device_initialize'? [-Werror=implicit-function-declaration]
     422 |                         device_init_wakeup(&mhi_dev->dev, true);
         |                         ^~~~~~~~~~~~~~~~~~
         |                         device_initialize
   drivers/bus/mhi/host/main.c: In function 'mhi_irq_handler':
   drivers/bus/mhi/host/main.c:460:17: error: implicit declaration of function 'tasklet_schedule' [-Werror=implicit-function-declaration]
     460 |                 tasklet_schedule(&mhi_event->task);
         |                 ^~~~~~~~~~~~~~~~
   drivers/bus/mhi/host/main.c: In function 'mhi_intvec_threaded_handler':
   drivers/bus/mhi/host/main.c:474:9: error: implicit declaration of function 'write_lock_irq' [-Werror=implicit-function-declaration]
     474 |         write_lock_irq(&mhi_cntrl->pm_lock);
         |         ^~~~~~~~~~~~~~
   drivers/bus/mhi/host/main.c:476:17: error: implicit declaration of function 'write_unlock_irq'; did you mean 'wait_event_lock_irq'? [-Werror=implicit-function-declaration]
     476 |                 write_unlock_irq(&mhi_cntrl->pm_lock);
         |                 ^~~~~~~~~~~~~~~~
         |                 wait_event_lock_irq
   drivers/bus/mhi/host/main.c: In function 'parse_xfer_event':
   drivers/bus/mhi/host/main.c:584:17: error: implicit declaration of function 'write_lock_irqsave' [-Werror=implicit-function-declaration]
     584 |                 write_lock_irqsave(&mhi_chan->lock, flags);
         |                 ^~~~~~~~~~~~~~~~~~
   drivers/bus/mhi/host/main.c:586:17: error: implicit declaration of function 'read_lock_bh' [-Werror=implicit-function-declaration]
     586 |                 read_lock_bh(&mhi_chan->lock);
         |                 ^~~~~~~~~~~~
>> drivers/bus/mhi/host/main.c:642:33: error: implicit declaration of function 'atomic_dec' [-Werror=implicit-function-declaration]
     642 |                                 atomic_dec(&mhi_cntrl->pending_pkts);
         |                                 ^~~~~~~~~~
   drivers/bus/mhi/host/main.c:672:17: error: implicit declaration of function 'read_lock_irqsave'; did you mean 'raw_local_irq_save'? [-Werror=implicit-function-declaration]
     672 |                 read_lock_irqsave(&mhi_cntrl->pm_lock, pm_lock_flags);
         |                 ^~~~~~~~~~~~~~~~~
         |                 raw_local_irq_save
   drivers/bus/mhi/host/main.c:677:17: error: implicit declaration of function 'read_unlock_irqrestore'; did you mean 'raw_local_irq_restore'? [-Werror=implicit-function-declaration]
     677 |                 read_unlock_irqrestore(&mhi_cntrl->pm_lock, pm_lock_flags);
         |                 ^~~~~~~~~~~~~~~~~~~~~~
         |                 raw_local_irq_restore
   drivers/bus/mhi/host/main.c:688:17: error: implicit declaration of function 'write_unlock_irqrestore'; did you mean 'printk_cpu_unlock_irqrestore'? [-Werror=implicit-function-declaration]
     688 |                 write_unlock_irqrestore(&mhi_chan->lock, flags);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
         |                 printk_cpu_unlock_irqrestore
   drivers/bus/mhi/host/main.c:690:17: error: implicit declaration of function 'read_unlock_bh' [-Werror=implicit-function-declaration]
     690 |                 read_unlock_bh(&mhi_chan->lock);
         |                 ^~~~~~~~~~~~~~
   drivers/bus/mhi/host/main.c: In function 'mhi_process_cmd_completion':
   drivers/bus/mhi/host/main.c:782:17: error: implicit declaration of function 'write_lock_bh' [-Werror=implicit-function-declaration]
     782 |                 write_lock_bh(&mhi_chan->lock);
         |                 ^~~~~~~~~~~~~
   drivers/bus/mhi/host/main.c:785:17: error: implicit declaration of function 'write_unlock_bh' [-Werror=implicit-function-declaration]
     785 |                 write_unlock_bh(&mhi_chan->lock);
         |                 ^~~~~~~~~~~~~~~
   drivers/bus/mhi/host/main.c: In function 'mhi_ev_task':
   drivers/bus/mhi/host/main.c:1040:9: error: implicit declaration of function 'spin_lock_bh'; did you mean 'spin_lock_init'? [-Werror=implicit-function-declaration]
    1040 |         spin_lock_bh(&mhi_event->lock);
         |         ^~~~~~~~~~~~
         |         spin_lock_init
   drivers/bus/mhi/host/main.c:1042:9: error: implicit declaration of function 'spin_unlock_bh' [-Werror=implicit-function-declaration]
    1042 |         spin_unlock_bh(&mhi_event->lock);
         |         ^~~~~~~~~~~~~~
   drivers/bus/mhi/host/main.c: In function 'mhi_queue':
>> drivers/bus/mhi/host/main.c:1137:17: error: implicit declaration of function 'atomic_inc' [-Werror=implicit-function-declaration]
    1137 |                 atomic_inc(&mhi_cntrl->pending_pkts);
         |                 ^~~~~~~~~~
   drivers/bus/mhi/host/main.c: In function 'mhi_prepare_channel':
   drivers/bus/mhi/host/main.c:1492:25: error: implicit declaration of function 'read_lock_irq' [-Werror=implicit-function-declaration]
    1492 |                         read_lock_irq(&mhi_chan->lock);
         |                         ^~~~~~~~~~~~~
   drivers/bus/mhi/host/main.c:1494:25: error: implicit declaration of function 'read_unlock_irq' [-Werror=implicit-function-declaration]
    1494 |                         read_unlock_irq(&mhi_chan->lock);
         |                         ^~~~~~~~~~~~~~~
   drivers/bus/mhi/host/main.c: In function 'mhi_mark_stale_events':
   drivers/bus/mhi/host/main.c:1536:9: error: implicit declaration of function 'spin_lock_irqsave'; did you mean 'spin_lock_init'? [-Werror=implicit-function-declaration]
    1536 |         spin_lock_irqsave(&mhi_event->lock, flags);
         |         ^~~~~~~~~~~~~~~~~
         |         spin_lock_init
   drivers/bus/mhi/host/main.c:1559:9: error: implicit declaration of function 'spin_unlock_irqrestore'; did you mean 'printk_cpu_unlock_irqrestore'? [-Werror=implicit-function-declaration]
    1559 |         spin_unlock_irqrestore(&mhi_event->lock, flags);
         |         ^~~~~~~~~~~~~~~~~~~~~~
         |         printk_cpu_unlock_irqrestore
   cc1: some warnings being treated as errors
--
   In file included from drivers/bus/mhi/host/debugfs.c:14:
   drivers/bus/mhi/host/internal.h:203:31: error: field 'task' has incomplete type
     203 |         struct tasklet_struct task;
         |                               ^~~~
   drivers/bus/mhi/host/internal.h: In function 'mhi_trigger_resume':
   drivers/bus/mhi/host/internal.h:306:9: error: implicit declaration of function 'pm_wakeup_event' [-Werror=implicit-function-declaration]
     306 |         pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
         |         ^~~~~~~~~~~~~~~
   drivers/bus/mhi/host/debugfs.c: In function 'mhi_debugfs_states_show':
>> drivers/bus/mhi/host/debugfs.c:33:20: error: implicit declaration of function 'atomic_read' [-Werror=implicit-function-declaration]
      33 |                    atomic_read(&mhi_cntrl->dev_wake),
         |                    ^~~~~~~~~~~
   drivers/bus/mhi/host/debugfs.c: In function 'mhi_debugfs_device_wake_write':
   drivers/bus/mhi/host/debugfs.c:259:13: error: implicit declaration of function 'copy_from_user' [-Werror=implicit-function-declaration]
     259 |         if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
         |             ^~~~~~~~~~~~~~
   drivers/bus/mhi/host/debugfs.c:259:40: error: implicit declaration of function 'min_t' [-Werror=implicit-function-declaration]
     259 |         if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
         |                                        ^~~~~
   drivers/bus/mhi/host/debugfs.c:259:46: error: expected expression before 'size_t'
     259 |         if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
         |                                              ^~~~~~
   cc1: some warnings being treated as errors


vim +/atomic_dec +642 drivers/bus/mhi/host/main.c

1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  559  
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  560  static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
84f5f31f110e5e drivers/bus/mhi/host/main.c Manivannan Sadhasivam 2022-03-01  561  			    struct mhi_ring_element *event,
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  562  			    struct mhi_chan *mhi_chan)
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  563  {
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  564  	struct mhi_ring *buf_ring, *tre_ring;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  565  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  566  	struct mhi_result result;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  567  	unsigned long flags = 0;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  568  	u32 ev_code;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  569  
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  570  	ev_code = MHI_TRE_GET_EV_CODE(event);
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  571  	buf_ring = &mhi_chan->buf_ring;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  572  	tre_ring = &mhi_chan->tre_ring;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  573  
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  574  	result.transaction_status = (ev_code == MHI_EV_CC_OVERFLOW) ?
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  575  		-EOVERFLOW : 0;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  576  
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  577  	/*
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  578  	 * If it's a DB Event then we need to grab the lock
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  579  	 * with preemption disabled and as a write because we
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  580  	 * have to update db register and there are chances that
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  581  	 * another thread could be doing the same.
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  582  	 */
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  583  	if (ev_code >= MHI_EV_CC_OOB)
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20 @584  		write_lock_irqsave(&mhi_chan->lock, flags);
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  585  	else
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  586  		read_lock_bh(&mhi_chan->lock);
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  587  
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  588  	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED)
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  589  		goto end_process_tx_event;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  590  
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  591  	switch (ev_code) {
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  592  	case MHI_EV_CC_OVERFLOW:
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  593  	case MHI_EV_CC_EOB:
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  594  	case MHI_EV_CC_EOT:
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  595  	{
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  596  		dma_addr_t ptr = MHI_TRE_GET_EV_PTR(event);
84f5f31f110e5e drivers/bus/mhi/host/main.c Manivannan Sadhasivam 2022-03-01  597  		struct mhi_ring_element *local_rp, *ev_tre;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  598  		void *dev_rp;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  599  		struct mhi_buf_info *buf_info;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  600  		u16 xfer_len;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  601  
ec32332df7645e drivers/bus/mhi/core/main.c Jeffrey Hugo          2021-03-10  602  		if (!is_valid_ring_ptr(tre_ring, ptr)) {
ec32332df7645e drivers/bus/mhi/core/main.c Jeffrey Hugo          2021-03-10  603  			dev_err(&mhi_cntrl->mhi_dev->dev,
ec32332df7645e drivers/bus/mhi/core/main.c Jeffrey Hugo          2021-03-10  604  				"Event element points outside of the tre ring\n");
ec32332df7645e drivers/bus/mhi/core/main.c Jeffrey Hugo          2021-03-10  605  			break;
ec32332df7645e drivers/bus/mhi/core/main.c Jeffrey Hugo          2021-03-10  606  		}
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  607  		/* Get the TRB this event points to */
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  608  		ev_tre = mhi_to_virtual(tre_ring, ptr);
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  609  
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  610  		dev_rp = ev_tre + 1;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  611  		if (dev_rp >= (tre_ring->base + tre_ring->len))
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  612  			dev_rp = tre_ring->base;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  613  
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  614  		result.dir = mhi_chan->dir;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  615  
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  616  		local_rp = tre_ring->rp;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  617  		while (local_rp != dev_rp) {
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  618  			buf_info = buf_ring->rp;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  619  			/* If it's the last TRE, get length from the event */
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  620  			if (local_rp == ev_tre)
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  621  				xfer_len = MHI_TRE_GET_EV_LEN(event);
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  622  			else
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  623  				xfer_len = buf_info->len;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  624  
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  625  			/* Unmap if it's not pre-mapped by client */
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  626  			if (likely(!buf_info->pre_mapped))
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  627  				mhi_cntrl->unmap_single(mhi_cntrl, buf_info);
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  628  
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  629  			result.buf_addr = buf_info->cb_buf;
ee75cedf82d832 drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  630  
ee75cedf82d832 drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  631  			/* truncate to buf len if xfer_len is larger */
ee75cedf82d832 drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  632  			result.bytes_xferd =
ee75cedf82d832 drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  633  				min_t(u16, xfer_len, buf_info->len);
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  634  			mhi_del_ring_element(mhi_cntrl, buf_ring);
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  635  			mhi_del_ring_element(mhi_cntrl, tre_ring);
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  636  			local_rp = tre_ring->rp;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  637  
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  638  			/* notify client */
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  639  			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  640  
4547a749be997e drivers/bus/mhi/core/main.c Loic Poulain          2021-04-06  641  			if (mhi_chan->dir == DMA_TO_DEVICE) {
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20 @642  				atomic_dec(&mhi_cntrl->pending_pkts);
4547a749be997e drivers/bus/mhi/core/main.c Loic Poulain          2021-04-06  643  				/* Release the reference got from mhi_queue() */
4547a749be997e drivers/bus/mhi/core/main.c Loic Poulain          2021-04-06  644  				mhi_cntrl->runtime_put(mhi_cntrl);
4547a749be997e drivers/bus/mhi/core/main.c Loic Poulain          2021-04-06  645  			}
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  646  
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  647  			/*
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  648  			 * Recycle the buffer if buffer is pre-allocated,
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  649  			 * if there is an error, not much we can do apart
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  650  			 * from dropping the packet
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  651  			 */
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  652  			if (mhi_chan->pre_alloc) {
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  653  				if (mhi_queue_buf(mhi_chan->mhi_dev,
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  654  						  mhi_chan->dir,
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  655  						  buf_info->cb_buf,
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  656  						  buf_info->len, MHI_EOT)) {
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  657  					dev_err(dev,
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  658  						"Error recycling buffer for chan:%d\n",
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  659  						mhi_chan->chan);
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  660  					kfree(buf_info->cb_buf);
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  661  				}
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  662  			}
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  663  		}
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  664  		break;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  665  	} /* CC_EOT */
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  666  	case MHI_EV_CC_OOB:
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  667  	case MHI_EV_CC_DB_MODE:
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  668  	{
683e77cadc839b drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2021-04-09  669  		unsigned long pm_lock_flags;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  670  
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  671  		mhi_chan->db_cfg.db_mode = 1;
683e77cadc839b drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2021-04-09  672  		read_lock_irqsave(&mhi_cntrl->pm_lock, pm_lock_flags);
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  673  		if (tre_ring->wp != tre_ring->rp &&
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  674  		    MHI_DB_ACCESS_VALID(mhi_cntrl)) {
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  675  			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  676  		}
683e77cadc839b drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2021-04-09  677  		read_unlock_irqrestore(&mhi_cntrl->pm_lock, pm_lock_flags);
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  678  		break;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  679  	}
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  680  	case MHI_EV_CC_BAD_TRE:
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  681  	default:
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  682  		dev_err(dev, "Unknown event 0x%x\n", ev_code);
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  683  		break;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  684  	} /* switch(MHI_EV_READ_CODE(EV_TRB_CODE,event)) */
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  685  
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  686  end_process_tx_event:
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  687  	if (ev_code >= MHI_EV_CC_OOB)
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  688  		write_unlock_irqrestore(&mhi_chan->lock, flags);
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  689  	else
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  690  		read_unlock_bh(&mhi_chan->lock);
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  691  
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  692  	return 0;
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  693  }
1d3173a3bae703 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  694  

:::::: The code at line 642 was first introduced by commit
:::::: 1d3173a3bae7039b765a0956e3e4bf846dbaacb8 bus: mhi: core: Add support for processing events from client device

:::::: TO: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

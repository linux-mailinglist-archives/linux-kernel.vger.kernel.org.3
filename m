Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F88B4D6ABD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiCKXNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 18:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiCKXMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:12:51 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5610B76640
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 15:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647040306; x=1678576306;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QMsbx5rPtWRwRTy10IhRmntb9XRfCfQKWwrjNcqx52I=;
  b=clSollSkVV68LLoUo92lwz4rVS7gK6gFqCZx03GOWPcosQECOsliOMBw
   A/0DAEwbgO3QZSGb41o2jiH5Ml4yfAOMh1Nrl7x78TX+EBkXbrreRIPz6
   RplW9SJkjDvSi2gucf3iNxI5FacHpBeZIxtlDnTGPWkovb27jjagwE2kg
   fFUYs9MOvvfo0JLlLax/XxDMBDKd5gzveMMvvkX0sWwxiG5k84MTIYERX
   aNdOr4ncQBeO3KKAwX8bpjusBdTU3wUm/iQ3MHb8PByzBiXQLLP5X+mnY
   ZxK0sPTFANJ4R1IA3EAdaDIFPBaERmHBHA4WeMFK8clYz3iU2EsCu6O4x
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="237838282"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="237838282"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 14:35:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="539162465"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 11 Mar 2022 14:34:52 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSnqW-0007BV-1f; Fri, 11 Mar 2022 22:34:52 +0000
Date:   Sat, 12 Mar 2022 06:34:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: drivers/firmware/stratix10-svc.c:823 stratix10_svc_send() warn:
 inconsistent indenting
Message-ID: <202203120650.bkPnjqde-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   79b00034e9dcd2b065c1665c8b42f62b6b80a9be
commit: 4a9a1a5602d82c079325bf37466af0b67d6c0b9e arm64: socfpga: merge Agilex and N5X into ARCH_INTEL_SOCFPGA
date:   12 months ago
config: arm64-randconfig-m031-20220310 (https://download.01.org/0day-ci/archive/20220312/202203120650.bkPnjqde-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/firmware/stratix10-svc.c:823 stratix10_svc_send() warn: inconsistent indenting

vim +823 drivers/firmware/stratix10-svc.c

7ca5ce896524f52 Richard Gong 2018-11-13  791  
7ca5ce896524f52 Richard Gong 2018-11-13  792  /**
7ca5ce896524f52 Richard Gong 2018-11-13  793   * stratix10_svc_send() - send a message data to the remote
7ca5ce896524f52 Richard Gong 2018-11-13  794   * @chan: service channel assigned to the client
7ca5ce896524f52 Richard Gong 2018-11-13  795   * @msg: message data to be sent, in the format of
7ca5ce896524f52 Richard Gong 2018-11-13  796   * "struct stratix10_svc_client_msg"
7ca5ce896524f52 Richard Gong 2018-11-13  797   *
7ca5ce896524f52 Richard Gong 2018-11-13  798   * This function is used by service client to add a message to the service
7ca5ce896524f52 Richard Gong 2018-11-13  799   * layer driver's queue for being sent to the secure world.
7ca5ce896524f52 Richard Gong 2018-11-13  800   *
7ca5ce896524f52 Richard Gong 2018-11-13  801   * Return: 0 for success, -ENOMEM or -ENOBUFS on error.
7ca5ce896524f52 Richard Gong 2018-11-13  802   */
7ca5ce896524f52 Richard Gong 2018-11-13  803  int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg)
7ca5ce896524f52 Richard Gong 2018-11-13  804  {
7ca5ce896524f52 Richard Gong 2018-11-13  805  	struct stratix10_svc_client_msg
7ca5ce896524f52 Richard Gong 2018-11-13  806  		*p_msg = (struct stratix10_svc_client_msg *)msg;
7ca5ce896524f52 Richard Gong 2018-11-13  807  	struct stratix10_svc_data_mem *p_mem;
7ca5ce896524f52 Richard Gong 2018-11-13  808  	struct stratix10_svc_data *p_data;
7ca5ce896524f52 Richard Gong 2018-11-13  809  	int ret = 0;
7ca5ce896524f52 Richard Gong 2018-11-13  810  	unsigned int cpu = 0;
7ca5ce896524f52 Richard Gong 2018-11-13  811  
7ca5ce896524f52 Richard Gong 2018-11-13  812  	p_data = kzalloc(sizeof(*p_data), GFP_KERNEL);
7ca5ce896524f52 Richard Gong 2018-11-13  813  	if (!p_data)
7ca5ce896524f52 Richard Gong 2018-11-13  814  		return -ENOMEM;
7ca5ce896524f52 Richard Gong 2018-11-13  815  
7ca5ce896524f52 Richard Gong 2018-11-13  816  	/* first client will create kernel thread */
7ca5ce896524f52 Richard Gong 2018-11-13  817  	if (!chan->ctrl->task) {
7ca5ce896524f52 Richard Gong 2018-11-13  818  		chan->ctrl->task =
7ca5ce896524f52 Richard Gong 2018-11-13  819  			kthread_create_on_node(svc_normal_to_secure_thread,
7ca5ce896524f52 Richard Gong 2018-11-13  820  					      (void *)chan->ctrl,
7ca5ce896524f52 Richard Gong 2018-11-13  821  					      cpu_to_node(cpu),
7ca5ce896524f52 Richard Gong 2018-11-13  822  					      "svc_smc_hvc_thread");
7ca5ce896524f52 Richard Gong 2018-11-13 @823  			if (IS_ERR(chan->ctrl->task)) {
7ca5ce896524f52 Richard Gong 2018-11-13  824  				dev_err(chan->ctrl->dev,
b5dc75c915cdaeb Richard Gong 2019-09-03  825  					"failed to create svc_smc_hvc_thread\n");
7ca5ce896524f52 Richard Gong 2018-11-13  826  				kfree(p_data);
7ca5ce896524f52 Richard Gong 2018-11-13  827  				return -EINVAL;
7ca5ce896524f52 Richard Gong 2018-11-13  828  			}
7ca5ce896524f52 Richard Gong 2018-11-13  829  		kthread_bind(chan->ctrl->task, cpu);
7ca5ce896524f52 Richard Gong 2018-11-13  830  		wake_up_process(chan->ctrl->task);
7ca5ce896524f52 Richard Gong 2018-11-13  831  	}
7ca5ce896524f52 Richard Gong 2018-11-13  832  
7ca5ce896524f52 Richard Gong 2018-11-13  833  	pr_debug("%s: sent P-va=%p, P-com=%x, P-size=%u\n", __func__,
7ca5ce896524f52 Richard Gong 2018-11-13  834  		 p_msg->payload, p_msg->command,
7ca5ce896524f52 Richard Gong 2018-11-13  835  		 (unsigned int)p_msg->payload_length);
7ca5ce896524f52 Richard Gong 2018-11-13  836  
7ca5ce896524f52 Richard Gong 2018-11-13  837  	if (list_empty(&svc_data_mem)) {
7ca5ce896524f52 Richard Gong 2018-11-13  838  		if (p_msg->command == COMMAND_RECONFIG) {
7ca5ce896524f52 Richard Gong 2018-11-13  839  			struct stratix10_svc_command_config_type *ct =
7ca5ce896524f52 Richard Gong 2018-11-13  840  				(struct stratix10_svc_command_config_type *)
7ca5ce896524f52 Richard Gong 2018-11-13  841  				p_msg->payload;
7ca5ce896524f52 Richard Gong 2018-11-13  842  			p_data->flag = ct->flags;
7ca5ce896524f52 Richard Gong 2018-11-13  843  		}
7ca5ce896524f52 Richard Gong 2018-11-13  844  	} else {
7ca5ce896524f52 Richard Gong 2018-11-13  845  		list_for_each_entry(p_mem, &svc_data_mem, node)
7ca5ce896524f52 Richard Gong 2018-11-13  846  			if (p_mem->vaddr == p_msg->payload) {
7ca5ce896524f52 Richard Gong 2018-11-13  847  				p_data->paddr = p_mem->paddr;
7ca5ce896524f52 Richard Gong 2018-11-13  848  				break;
7ca5ce896524f52 Richard Gong 2018-11-13  849  			}
7ca5ce896524f52 Richard Gong 2018-11-13  850  	}
7ca5ce896524f52 Richard Gong 2018-11-13  851  
7ca5ce896524f52 Richard Gong 2018-11-13  852  	p_data->command = p_msg->command;
7ca5ce896524f52 Richard Gong 2018-11-13  853  	p_data->arg[0] = p_msg->arg[0];
7ca5ce896524f52 Richard Gong 2018-11-13  854  	p_data->arg[1] = p_msg->arg[1];
7ca5ce896524f52 Richard Gong 2018-11-13  855  	p_data->arg[2] = p_msg->arg[2];
7ca5ce896524f52 Richard Gong 2018-11-13  856  	p_data->size = p_msg->payload_length;
7ca5ce896524f52 Richard Gong 2018-11-13  857  	p_data->chan = chan;
7ca5ce896524f52 Richard Gong 2018-11-13  858  	pr_debug("%s: put to FIFO pa=0x%016x, cmd=%x, size=%u\n", __func__,
7ca5ce896524f52 Richard Gong 2018-11-13  859  	       (unsigned int)p_data->paddr, p_data->command,
7ca5ce896524f52 Richard Gong 2018-11-13  860  	       (unsigned int)p_data->size);
7ca5ce896524f52 Richard Gong 2018-11-13  861  	ret = kfifo_in_spinlocked(&chan->ctrl->svc_fifo, p_data,
7ca5ce896524f52 Richard Gong 2018-11-13  862  				  sizeof(*p_data),
7ca5ce896524f52 Richard Gong 2018-11-13  863  				  &chan->ctrl->svc_fifo_lock);
7ca5ce896524f52 Richard Gong 2018-11-13  864  
7ca5ce896524f52 Richard Gong 2018-11-13  865  	kfree(p_data);
7ca5ce896524f52 Richard Gong 2018-11-13  866  
7ca5ce896524f52 Richard Gong 2018-11-13  867  	if (!ret)
7ca5ce896524f52 Richard Gong 2018-11-13  868  		return -ENOBUFS;
7ca5ce896524f52 Richard Gong 2018-11-13  869  
7ca5ce896524f52 Richard Gong 2018-11-13  870  	return 0;
7ca5ce896524f52 Richard Gong 2018-11-13  871  }
7ca5ce896524f52 Richard Gong 2018-11-13  872  EXPORT_SYMBOL_GPL(stratix10_svc_send);
7ca5ce896524f52 Richard Gong 2018-11-13  873  

:::::: The code at line 823 was first introduced by commit
:::::: 7ca5ce896524f5292e610b27d168269e5ab74951 firmware: add Intel Stratix10 service layer driver

:::::: TO: Richard Gong <richard.gong@intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

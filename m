Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBF14F0954
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 14:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357705AbiDCM12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 08:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbiDCM10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 08:27:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9BA2F032
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 05:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648988731; x=1680524731;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OUe9ITGXWm2HkX5Q2fscoToIQd8fw6TDokYeG8tAnx4=;
  b=N1U5oFYOiCZ8vpqDmE6SK/fxeVqzZfFvapxcH0vreZhqtDkVQYItO//b
   8Hhw5eMWvz//yOpCAn79uF3pD4qIZqLX7ZZ96+7HxD6ykw7JL/yoZ4u/b
   zWofCIfuHtWOA8p5L/xVfNIJ7ghPI2xgPXZ48Ffy8HbMzxHy0zYxWY/xD
   yx+QpDbH/vjOIJ3DHMyHavzaE6L5tY60/p16b1h6JFNclFnIR0vtctX9E
   q6aehO6Mj2+angmB6QPpXAsJJ4RqQDSDgV830CHaMUM7y6o1iz7oJmssE
   wyuoTDmBaK7dvRqwBS/LbLOOR63pkh0FKqzzlB0Y6NW57+lt33MlGbuZ1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10305"; a="323556576"
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="323556576"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 05:25:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="721369392"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 03 Apr 2022 05:25:29 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nazIP-0000xN-7q;
        Sun, 03 Apr 2022 12:25:29 +0000
Date:   Sun, 3 Apr 2022 20:24:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: drivers/firmware/arm_scmi/optee.c:428:20: sparse: sparse: incorrect
 type in return expression (different address spaces)
Message-ID: <202204032039.TEInlRXP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   be2d3ecedd9911fbfd7e55cc9ceac5f8b79ae4cf
commit: 5f90f189a052f6fc46048f6ce29a37b709548b81 firmware: arm_scmi: Add optee transport
date:   5 months ago
config: arm64-randconfig-s031-20220403 (https://download.01.org/0day-ci/archive/20220403/202204032039.TEInlRXP-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5f90f189a052f6fc46048f6ce29a37b709548b81
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5f90f189a052f6fc46048f6ce29a37b709548b81
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/bus/ drivers/firmware/arm_scmi/ drivers/firmware/meson/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/firmware/arm_scmi/optee.c:295:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct scmi_shared_mem [noderef] __iomem *shmem @@     got void * @@
   drivers/firmware/arm_scmi/optee.c:295:24: sparse:     expected struct scmi_shared_mem [noderef] __iomem *shmem
   drivers/firmware/arm_scmi/optee.c:295:24: sparse:     got void *
   drivers/firmware/arm_scmi/optee.c:296:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got struct scmi_shared_mem [noderef] __iomem *shmem @@
   drivers/firmware/arm_scmi/optee.c:296:23: sparse:     expected void *p
   drivers/firmware/arm_scmi/optee.c:296:23: sparse:     got struct scmi_shared_mem [noderef] __iomem *shmem
>> drivers/firmware/arm_scmi/optee.c:428:20: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected struct scmi_shared_mem * @@     got struct scmi_shared_mem [noderef] __iomem *shmem @@
   drivers/firmware/arm_scmi/optee.c:428:20: sparse:     expected struct scmi_shared_mem *
   drivers/firmware/arm_scmi/optee.c:428:20: sparse:     got struct scmi_shared_mem [noderef] __iomem *shmem
>> drivers/firmware/arm_scmi/optee.c:440:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct scmi_shared_mem [noderef] __iomem *shmem @@     got struct scmi_shared_mem *shmem @@
   drivers/firmware/arm_scmi/optee.c:440:26: sparse:     expected struct scmi_shared_mem [noderef] __iomem *shmem
   drivers/firmware/arm_scmi/optee.c:440:26: sparse:     got struct scmi_shared_mem *shmem
   drivers/firmware/arm_scmi/optee.c:444:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct scmi_shared_mem [noderef] __iomem *shmem @@     got struct scmi_shared_mem *shmem @@
   drivers/firmware/arm_scmi/optee.c:444:51: sparse:     expected struct scmi_shared_mem [noderef] __iomem *shmem
   drivers/firmware/arm_scmi/optee.c:444:51: sparse:     got struct scmi_shared_mem *shmem
   drivers/firmware/arm_scmi/optee.c:456:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct scmi_shared_mem [noderef] __iomem *shmem @@     got struct scmi_shared_mem *shmem @@
   drivers/firmware/arm_scmi/optee.c:456:30: sparse:     expected struct scmi_shared_mem [noderef] __iomem *shmem
   drivers/firmware/arm_scmi/optee.c:456:30: sparse:     got struct scmi_shared_mem *shmem
   drivers/firmware/arm_scmi/optee.c:465:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct scmi_shared_mem [noderef] __iomem *shmem @@     got struct scmi_shared_mem *shmem @@
   drivers/firmware/arm_scmi/optee.c:465:32: sparse:     expected struct scmi_shared_mem [noderef] __iomem *shmem
   drivers/firmware/arm_scmi/optee.c:465:32: sparse:     got struct scmi_shared_mem *shmem

vim +428 drivers/firmware/arm_scmi/optee.c

   421	
   422	static struct scmi_shared_mem *get_channel_shm(struct scmi_optee_channel *chan,
   423						       struct scmi_xfer *xfer)
   424	{
   425		if (!chan)
   426			return NULL;
   427	
 > 428		return chan->shmem;
   429	}
   430	
   431	
   432	static int scmi_optee_send_message(struct scmi_chan_info *cinfo,
   433					   struct scmi_xfer *xfer)
   434	{
   435		struct scmi_optee_channel *channel = cinfo->transport_info;
   436		struct scmi_shared_mem *shmem = get_channel_shm(channel, xfer);
   437		int ret;
   438	
   439		mutex_lock(&channel->mu);
 > 440		shmem_tx_prepare(shmem, xfer);
   441	
   442		ret = invoke_process_smt_channel(channel);
   443	
   444		scmi_rx_callback(cinfo, shmem_read_header(shmem), NULL);
   445		mutex_unlock(&channel->mu);
   446	
   447		return ret;
   448	}
   449	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53951502AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353977AbiDONYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352586AbiDONX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:23:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF91ABF6C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 06:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650028889; x=1681564889;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J5IdjM4bTiGgHDJNdfSgOfYbVJ4mpNxn9qhhWj7kVfU=;
  b=ZulwdtGveVJK2Ta6dBq+uq/Lx1D1QO8obNfKfznUdU6mJ3tZCz04VeT4
   QOteX3iiLQ90dKktRNaooRUTWer9S3LbHOMrUORKTBgUoamQSsur7c2tu
   qFh16d7VOtODFK6rKkAk7Hw1lexG7VsRQEKWXIEIj7VA1fUiNdH5ulRdi
   2CSJg+lNpH4QipPsn6JyiFjMSJIJnvuEndroJ39kmiGlD9jJq5sa4JyEz
   YGcZBeYiG2pGm9awqJQutF8EZMN54KeSqR0XE1OkK33OwF0uZbYlXSq/J
   JwLtUcUMDVSNaVnHFhclEHTzswfekWwAbT7g+FGvGpWpWacLM33TZi3qP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="326055751"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="326055751"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 06:21:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="662085064"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Apr 2022 06:21:28 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfLt9-0001yL-Gb;
        Fri, 15 Apr 2022 13:21:27 +0000
Date:   Fri, 15 Apr 2022 21:21:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [morimoto:r4-2022-04-15-v2 15/24]
 drivers/i2c/busses/i2c-rcar.c:806:29: error: expected ';' after expression
Message-ID: <202204152116.8xUwPO61-lkp@intel.com>
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

tree:   https://github.com/morimoto/linux r4-2022-04-15-v2
head:   88d865b299bcaa6c0a206a60dbf20e4e13130568
commit: 680cb6c79b44aacc594165e88b4af5d4acfa9f7c [15/24] i2c: rcar: use flags instead of atomic_xfer
config: arm64-randconfig-r022-20220414 (https://download.01.org/0day-ci/archive/20220415/202204152116.8xUwPO61-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b7e6ea489f6dd45a9b0da9ac20871560917b9b0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/morimoto/linux/commit/680cb6c79b44aacc594165e88b4af5d4acfa9f7c
        git remote add morimoto https://github.com/morimoto/linux
        git fetch --no-tags morimoto r4-2022-04-15-v2
        git checkout 680cb6c79b44aacc594165e88b4af5d4acfa9f7c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/i2c/busses/i2c-rcar.c:806:29: error: expected ';' after expression
           priv->flags &= ~ID_P_ATOMIC
                                      ^
                                      ;
   drivers/i2c/busses/i2c-rcar.c:1041:18: warning: cast to smaller integer type 'enum rcar_i2c_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
           priv->devtype = (enum rcar_i2c_type)of_device_get_match_data(dev);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +806 drivers/i2c/busses/i2c-rcar.c

   796	
   797	static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
   798					struct i2c_msg *msgs,
   799					int num)
   800	{
   801		struct rcar_i2c_priv *priv = i2c_get_adapdata(adap);
   802		struct device *dev = rcar_i2c_priv_to_dev(priv);
   803		int i, ret;
   804		long time_left;
   805	
 > 806		priv->flags &= ~ID_P_ATOMIC
   807	
   808		pm_runtime_get_sync(dev);
   809	
   810		/* Check bus state before init otherwise bus busy info will be lost */
   811		ret = rcar_i2c_bus_barrier(priv);
   812		if (ret < 0)
   813			goto out;
   814	
   815		/* Gen3 needs a reset before allowing RXDMA once */
   816		if (priv->devtype == I2C_RCAR_GEN3) {
   817			priv->flags |= ID_P_NO_RXDMA;
   818			if (!IS_ERR(priv->rstc)) {
   819				ret = rcar_i2c_do_reset(priv);
   820				if (ret == 0)
   821					priv->flags &= ~ID_P_NO_RXDMA;
   822			}
   823		}
   824	
   825		rcar_i2c_init(priv);
   826	
   827		for (i = 0; i < num; i++)
   828			rcar_i2c_request_dma(priv, msgs + i);
   829	
   830		/* init first message */
   831		priv->msg = msgs;
   832		priv->msgs_left = num;
   833		priv->flags = (priv->flags & ID_P_MASK) | ID_FIRST_MSG;
   834		rcar_i2c_prepare_msg(priv);
   835	
   836		time_left = wait_event_timeout(priv->wait, priv->flags & ID_DONE,
   837					     num * adap->timeout);
   838	
   839		/* cleanup DMA if it couldn't complete properly due to an error */
   840		if (priv->dma_direction != DMA_NONE)
   841			rcar_i2c_cleanup_dma(priv, true);
   842	
   843		if (!time_left) {
   844			rcar_i2c_init(priv);
   845			ret = -ETIMEDOUT;
   846		} else if (priv->flags & ID_NACK) {
   847			ret = -ENXIO;
   848		} else if (priv->flags & ID_ARBLOST) {
   849			ret = -EAGAIN;
   850		} else {
   851			ret = num - priv->msgs_left; /* The number of transfer */
   852		}
   853	out:
   854		pm_runtime_put(dev);
   855	
   856		if (ret < 0 && ret != -ENXIO)
   857			dev_err(dev, "error %d : %x\n", ret, priv->flags);
   858	
   859		return ret;
   860	}
   861	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE66502AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347381AbiDONE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354009AbiDONEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:04:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AB4CBE77
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 06:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650027686; x=1681563686;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jBEtjrAIVZdUYCK0+WiVoiCnG2qbbYtuxy5qM34HGCo=;
  b=VoiLAIDTS5TyqajyU2QxXqxAep6lxigoY0zM1X+nLs5HNVRWT7XNXppf
   KXtMYt7/e1yE9PwwvsZ9/9iMEdTOYeu+pdh/4ZTdms5BmoVqbZD1CA2y8
   cuY60Uyz/1LaFp+acbDPPOxMIR9d37nKrFsqlnn0SjLSKLRZTaAk4iDoR
   ZOsLJsnqtDdtWXHkudnD3D5C4M8A7O1zeQ94l/uzFGS2jsey9QaaQW+n1
   pr4kUXdAxHEa781F9ASzESDjT/mUpE5y+fRvD9fNRSaMstmpN+NxE8G2X
   xc3OcZGhqz5yga3kwAq34ia6fIOR0EuiSU81G9WEc3sg8IIDSsJJkmP40
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="250447820"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="250447820"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 06:01:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="612799573"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 15 Apr 2022 06:01:25 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfLZk-0001xN-Cr;
        Fri, 15 Apr 2022 13:01:24 +0000
Date:   Fri, 15 Apr 2022 21:00:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morimoto:r4-2022-04-15-v2 15/24]
 drivers/i2c/busses/i2c-rcar.c:808:9: error: expected ';' before
 'pm_runtime_get_sync'
Message-ID: <202204152038.ROQPJRMw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/morimoto/linux r4-2022-04-15-v2
head:   88d865b299bcaa6c0a206a60dbf20e4e13130568
commit: 680cb6c79b44aacc594165e88b4af5d4acfa9f7c [15/24] i2c: rcar: use flags instead of atomic_xfer
config: alpha-randconfig-r025-20220414 (https://download.01.org/0day-ci/archive/20220415/202204152038.ROQPJRMw-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/morimoto/linux/commit/680cb6c79b44aacc594165e88b4af5d4acfa9f7c
        git remote add morimoto https://github.com/morimoto/linux
        git fetch --no-tags morimoto r4-2022-04-15-v2
        git checkout 680cb6c79b44aacc594165e88b4af5d4acfa9f7c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/i2c/busses/i2c-rcar.c: In function 'rcar_i2c_master_xfer':
>> drivers/i2c/busses/i2c-rcar.c:808:9: error: expected ';' before 'pm_runtime_get_sync'
     808 |         pm_runtime_get_sync(dev);
         |         ^~~~~~~~~~~~~~~~~~~


vim +808 drivers/i2c/busses/i2c-rcar.c

3b770017b03a4c Wolfram Sang      2018-06-28  796  
6ccbe607132bd8 Kuninori Morimoto 2012-09-27  797  static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
6ccbe607132bd8 Kuninori Morimoto 2012-09-27  798  				struct i2c_msg *msgs,
6ccbe607132bd8 Kuninori Morimoto 2012-09-27  799  				int num)
6ccbe607132bd8 Kuninori Morimoto 2012-09-27  800  {
6ccbe607132bd8 Kuninori Morimoto 2012-09-27  801  	struct rcar_i2c_priv *priv = i2c_get_adapdata(adap);
6ccbe607132bd8 Kuninori Morimoto 2012-09-27  802  	struct device *dev = rcar_i2c_priv_to_dev(priv);
b6763d0da5c16e Wolfram Sang      2015-06-20  803  	int i, ret;
ff2316b87a336b Wolfram Sang      2015-11-19  804  	long time_left;
6ccbe607132bd8 Kuninori Morimoto 2012-09-27  805  
680cb6c79b44aa Kuninori Morimoto 2022-04-14  806  	priv->flags &= ~ID_P_ATOMIC
82531dfdf16331 Ulrich Hecht      2021-02-12  807  
6ccbe607132bd8 Kuninori Morimoto 2012-09-27 @808  	pm_runtime_get_sync(dev);
6ccbe607132bd8 Kuninori Morimoto 2012-09-27  809  
0b57436f15bf40 Wolfram Sang      2018-11-13  810  	/* Check bus state before init otherwise bus busy info will be lost */
0b57436f15bf40 Wolfram Sang      2018-11-13  811  	ret = rcar_i2c_bus_barrier(priv);
0b57436f15bf40 Wolfram Sang      2018-11-13  812  	if (ret < 0)
0b57436f15bf40 Wolfram Sang      2018-11-13  813  		goto out;
0b57436f15bf40 Wolfram Sang      2018-11-13  814  
3b770017b03a4c Wolfram Sang      2018-06-28  815  	/* Gen3 needs a reset before allowing RXDMA once */
3b770017b03a4c Wolfram Sang      2018-06-28  816  	if (priv->devtype == I2C_RCAR_GEN3) {
3b770017b03a4c Wolfram Sang      2018-06-28  817  		priv->flags |= ID_P_NO_RXDMA;
3b770017b03a4c Wolfram Sang      2018-06-28  818  		if (!IS_ERR(priv->rstc)) {
3b770017b03a4c Wolfram Sang      2018-06-28  819  			ret = rcar_i2c_do_reset(priv);
3b770017b03a4c Wolfram Sang      2018-06-28  820  			if (ret == 0)
3b770017b03a4c Wolfram Sang      2018-06-28  821  				priv->flags &= ~ID_P_NO_RXDMA;
3b770017b03a4c Wolfram Sang      2018-06-28  822  		}
3b770017b03a4c Wolfram Sang      2018-06-28  823  	}
3b770017b03a4c Wolfram Sang      2018-06-28  824  
ae481cc139658e Wolfram Sang      2017-04-18  825  	rcar_i2c_init(priv);
ae481cc139658e Wolfram Sang      2017-04-18  826  
3ef3e5cd72aa3b Wolfram Sang      2018-07-23  827  	for (i = 0; i < num; i++)
73e8b0528346e8 Niklas Söderlund  2016-05-14  828  		rcar_i2c_request_dma(priv, msgs + i);
d7653964c590ba Wolfram Sang      2014-05-05  829  
e49865d10ad563 Wolfram Sang      2015-11-19  830  	/* init first message */
cc21d0b4b62e41 Wolfram Sang      2015-11-19  831  	priv->msg = msgs;
cc21d0b4b62e41 Wolfram Sang      2015-11-19  832  	priv->msgs_left = num;
7ee24eb508d61e Wolfram Sang      2015-12-23  833  	priv->flags = (priv->flags & ID_P_MASK) | ID_FIRST_MSG;
7c7117ffe08fd5 Sergei Shtylyov   2014-09-15  834  	rcar_i2c_prepare_msg(priv);
6ccbe607132bd8 Kuninori Morimoto 2012-09-27  835  
42c0783b89ae4d Wolfram Sang      2015-12-23  836  	time_left = wait_event_timeout(priv->wait, priv->flags & ID_DONE,
cc21d0b4b62e41 Wolfram Sang      2015-11-19  837  				     num * adap->timeout);
31d86033a0749a Wolfram Sang      2018-10-19  838  
31d86033a0749a Wolfram Sang      2018-10-19  839  	/* cleanup DMA if it couldn't complete properly due to an error */
31d86033a0749a Wolfram Sang      2018-10-19  840  	if (priv->dma_direction != DMA_NONE)
a5f7cf953f2b47 Wolfram Sang      2021-12-08  841  		rcar_i2c_cleanup_dma(priv, true);
31d86033a0749a Wolfram Sang      2018-10-19  842  
31d86033a0749a Wolfram Sang      2018-10-19  843  	if (!time_left) {
ff2316b87a336b Wolfram Sang      2015-11-19  844  		rcar_i2c_init(priv);
6ccbe607132bd8 Kuninori Morimoto 2012-09-27  845  		ret = -ETIMEDOUT;
42c0783b89ae4d Wolfram Sang      2015-12-23  846  	} else if (priv->flags & ID_NACK) {
6ff4b105163223 Ben Dooks         2014-01-26  847  		ret = -ENXIO;
42c0783b89ae4d Wolfram Sang      2015-12-23  848  	} else if (priv->flags & ID_ARBLOST) {
6ccbe607132bd8 Kuninori Morimoto 2012-09-27  849  		ret = -EAGAIN;
cc21d0b4b62e41 Wolfram Sang      2015-11-19  850  	} else {
cc21d0b4b62e41 Wolfram Sang      2015-11-19  851  		ret = num - priv->msgs_left; /* The number of transfer */
6ccbe607132bd8 Kuninori Morimoto 2012-09-27  852  	}
3f7de22eb28244 Wolfram Sang      2014-05-28  853  out:
6ccbe607132bd8 Kuninori Morimoto 2012-09-27  854  	pm_runtime_put(dev);
6ccbe607132bd8 Kuninori Morimoto 2012-09-27  855  
6ff4b105163223 Ben Dooks         2014-01-26  856  	if (ret < 0 && ret != -ENXIO)
6ccbe607132bd8 Kuninori Morimoto 2012-09-27  857  		dev_err(dev, "error %d : %x\n", ret, priv->flags);
6ccbe607132bd8 Kuninori Morimoto 2012-09-27  858  
6ccbe607132bd8 Kuninori Morimoto 2012-09-27  859  	return ret;
6ccbe607132bd8 Kuninori Morimoto 2012-09-27  860  }
6ccbe607132bd8 Kuninori Morimoto 2012-09-27  861  

:::::: The code at line 808 was first introduced by commit
:::::: 6ccbe607132bd823abbad8d32b13af89161707da i2c: add Renesas R-Car I2C driver

:::::: TO: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
:::::: CC: Wolfram Sang <w.sang@pengutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

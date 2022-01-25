Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6570049BC19
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiAYT3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:29:25 -0500
Received: from mga11.intel.com ([192.55.52.93]:31440 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230053AbiAYT3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643138959; x=1674674959;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jFKNoV/7yjG6kr9SE45/mFwrpz5JGNeru0FJuQRCN8Y=;
  b=EMG89AdNAu8UZaDrPpG7vUuHksfvrlxkPjfGqzWCwRuxF+CV3ITRpc0w
   JBhGHwJ+ftLtF1E+YLvHWuB9AGIVxTVCB9HQ4sZsanYwtj1rdXsiR/RLI
   suGB6vqYhJi+AMJ6khGt+1GPE//gbsSysMehkibtz4Q0bT1E1aYSt9Vww
   YlzQPKgHBTdQGrl2LF99s6hA1NAnqOVfrlFmkYfnCkdKfbOPywRLRqBB6
   izynKS6kOomqSP6ir2m5yxzREs+Jtx3Gv2OkpRpD1OsOJAU0cd+Sevjcq
   EA+aSGlSY8PBVAzNuXqoH2pUTGt+1xgqBANCXA2xIxm+0JSpV0VSV3pAq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="243992846"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="243992846"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 11:29:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="477230951"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Jan 2022 11:29:17 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCRVE-000KNC-RH; Tue, 25 Jan 2022 19:29:16 +0000
Date:   Wed, 26 Jan 2022 03:28:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [broonie-misc:spi-5.18 8/9] drivers/spi/spi-sunplus-sp7021.c:127:5:
 warning: no previous prototype for 'sp7021_spi_slave_tx'
Message-ID: <202201260353.yX7WVJXz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git spi-5.18
head:   a708078eeb992799161e794d9c569cf4f725a5b0
commit: f62ca4e2a863033d9b3b5a00a0d897557c9da6c5 [8/9] spi: Add spi driver for Sunplus SP7021
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220126/202201260353.yX7WVJXz-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git/commit/?id=f62ca4e2a863033d9b3b5a00a0d897557c9da6c5
        git remote add broonie-misc https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git
        git fetch --no-tags broonie-misc spi-5.18
        git checkout f62ca4e2a863033d9b3b5a00a0d897557c9da6c5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-sunplus-sp7021.c:127:5: warning: no previous prototype for 'sp7021_spi_slave_tx' [-Wmissing-prototypes]
     127 | int sp7021_spi_slave_tx(struct spi_device *spi, struct spi_transfer *xfer)
         |     ^~~~~~~~~~~~~~~~~~~
>> drivers/spi/spi-sunplus-sp7021.c:145:5: warning: no previous prototype for 'sp7021_spi_slave_rx' [-Wmissing-prototypes]
     145 | int sp7021_spi_slave_rx(struct spi_device *spi, struct spi_transfer *xfer)
         |     ^~~~~~~~~~~~~~~~~~~
>> drivers/spi/spi-sunplus-sp7021.c:163:6: warning: no previous prototype for 'sp7021_spi_master_rb' [-Wmissing-prototypes]
     163 | void sp7021_spi_master_rb(struct sp7021_spi_ctlr *pspim, unsigned int len)
         |      ^~~~~~~~~~~~~~~~~~~~
>> drivers/spi/spi-sunplus-sp7021.c:174:6: warning: no previous prototype for 'sp7021_spi_master_wb' [-Wmissing-prototypes]
     174 | void sp7021_spi_master_wb(struct sp7021_spi_ctlr *pspim, unsigned int len)
         |      ^~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-sunplus-sp7021.c:568:12: warning: 'sp7021_spi_runtime_resume' defined but not used [-Wunused-function]
     568 | static int sp7021_spi_runtime_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-sunplus-sp7021.c:560:12: warning: 'sp7021_spi_runtime_suspend' defined but not used [-Wunused-function]
     560 | static int sp7021_spi_runtime_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/sp7021_spi_slave_tx +127 drivers/spi/spi-sunplus-sp7021.c

   126	
 > 127	int sp7021_spi_slave_tx(struct spi_device *spi, struct spi_transfer *xfer)
   128	{
   129		struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(spi->controller);
   130	
   131		reinit_completion(&pspim->slave_isr);
   132		writel(SP7021_SLAVE_DMA_EN | SP7021_SLAVE_DMA_RW | FIELD_PREP(SP7021_SLAVE_DMA_CMD, 3),
   133		       pspim->s_base + SP7021_SLAVE_DMA_CTRL_REG);
   134		writel(xfer->len, pspim->s_base + SP7021_SLAVE_DMA_LENGTH_REG);
   135		writel(xfer->tx_dma, pspim->s_base + SP7021_SLAVE_DMA_ADDR_REG);
   136		writel(readl(pspim->s_base + SP7021_DATA_RDY_REG) | SP7021_SLAVE_DATA_RDY,
   137		       pspim->s_base + SP7021_DATA_RDY_REG);
   138		if (wait_for_completion_interruptible(&pspim->isr_done)) {
   139			dev_err(&spi->dev, "%s() wait_for_completion err\n", __func__);
   140			return -EINTR;
   141		}
   142		return 0;
   143	}
   144	
 > 145	int sp7021_spi_slave_rx(struct spi_device *spi, struct spi_transfer *xfer)
   146	{
   147		struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(spi->controller);
   148		int ret = 0;
   149	
   150		reinit_completion(&pspim->isr_done);
   151		writel(SP7021_SLAVE_DMA_EN | FIELD_PREP(SP7021_SLAVE_DMA_CMD, 3),
   152		       pspim->s_base + SP7021_SLAVE_DMA_CTRL_REG);
   153		writel(xfer->len, pspim->s_base + SP7021_SLAVE_DMA_LENGTH_REG);
   154		writel(xfer->rx_dma, pspim->s_base + SP7021_SLAVE_DMA_ADDR_REG);
   155		if (wait_for_completion_interruptible(&pspim->isr_done)) {
   156			dev_err(&spi->dev, "%s() wait_for_completion err\n", __func__);
   157			return -EINTR;
   158		}
   159		writel(SP7021_SLAVE_SW_RST, pspim->s_base + SP7021_SLAVE_DMA_CTRL_REG);
   160		return ret;
   161	}
   162	
 > 163	void sp7021_spi_master_rb(struct sp7021_spi_ctlr *pspim, unsigned int len)
   164	{
   165		int i;
   166	
   167		for (i = 0; i < len; i++) {
   168			pspim->rx_buf[pspim->rx_cur_len] =
   169				readl(pspim->m_base + SP7021_FIFO_REG);
   170			pspim->rx_cur_len++;
   171		}
   172	}
   173	
 > 174	void sp7021_spi_master_wb(struct sp7021_spi_ctlr *pspim, unsigned int len)
   175	{
   176		int i;
   177	
   178		for (i = 0; i < len; i++) {
   179			writel(pspim->tx_buf[pspim->tx_cur_len],
   180			       pspim->m_base + SP7021_FIFO_REG);
   181			pspim->tx_cur_len++;
   182		}
   183	}
   184	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

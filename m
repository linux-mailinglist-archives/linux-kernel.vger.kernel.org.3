Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB5046F393
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhLITFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:05:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:6889 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230036AbhLITFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639076500; x=1670612500;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+zzfDrCEn3smLToOOTO9BvU+t1AP6sJU6M1ly9N/KyE=;
  b=WLB6YjOPtcVCywj5W+3qJ1DsXWUNfuKDDWxiA1IkXEcKAmRvyI1zKCdN
   sJKIlPCLSIbIQGQTNpP9cXDlugjhSiFI8yHgzDC4NmMIWZVExAWgIXsBo
   WcOUXBkgOlui/SaRDxRcTvi8hZYNto5t42ebFx01zNObRzzvwC+UFSHNb
   IGjqPrsZYfungamYwMIrCU2ogtwGus8uDK34AlBnd+EuP9y6lfMWOXKeX
   83EQls3nUWz275q8S38HLxleiFIMZNL5Sj+nwO8YClYNX12qDK/nDZk+U
   mPBoXOTeoOkqb7PozQXE179TtYo6oaRDQvpAtG596IWK32n96R4M7WzK3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="218208389"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="218208389"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 11:01:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="680451420"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 09 Dec 2021 11:01:36 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvOfg-0002HL-4g; Thu, 09 Dec 2021 19:01:36 +0000
Date:   Fri, 10 Dec 2021 03:01:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:asahi 54/56] drivers/spi/spi-apple.c:148:19: error:
 implicit declaration of function 'FIELD_PREP'
Message-ID: <202112100204.LNhZJUFo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux asahi
head:   139e005bda0da795d21b4afeae8b184b1792b2c6
commit: 0058b3377882b80df30d9490c4653bca12423ff2 [54/56] spi: apple: Add driver for Apple SPI controller
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20211210/202112100204.LNhZJUFo-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/0058b3377882b80df30d9490c4653bca12423ff2
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux asahi
        git checkout 0058b3377882b80df30d9490c4653bca12423ff2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/spi/spi-apple.c: In function 'apple_spi_init':
>> drivers/spi/spi-apple.c:148:19: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     148 |                   FIELD_PREP(APPLE_SPI_CFG_FIFO_THRESH, APPLE_SPI_CFG_FIFO_THRESH_8B) |
         |                   ^~~~~~~~~~
   drivers/spi/spi-apple.c: In function 'apple_spi_tx':
>> drivers/spi/spi-apple.c:250:17: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
     250 |         inuse = FIELD_GET(APPLE_SPI_FIFOSTAT_LEVEL_TX, reg_read(spi, APPLE_SPI_FIFOSTAT));
         |                 ^~~~~~~~~
         |                 FOLL_GET
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +148 drivers/spi/spi-apple.c

   135	
   136	static void apple_spi_init(struct apple_spi *spi)
   137	{
   138		/* Set CS high (inactive) and disable override and auto-CS */
   139		reg_write(spi, APPLE_SPI_PIN, APPLE_SPI_PIN_CS);
   140		reg_mask(spi, APPLE_SPI_SHIFTCFG, APPLE_SPI_SHIFTCFG_OVERRIDE_CS, 0);
   141		reg_mask(spi, APPLE_SPI_PINCFG, APPLE_SPI_PINCFG_CS_IDLE_VAL, APPLE_SPI_PINCFG_KEEP_CS);
   142	
   143		/* Reset FIFOs */
   144		reg_write(spi, APPLE_SPI_CTRL, APPLE_SPI_CTRL_RX_RESET | APPLE_SPI_CTRL_TX_RESET);
   145	
   146		/* Configure defaults */
   147		reg_write(spi, APPLE_SPI_CFG,
 > 148			  FIELD_PREP(APPLE_SPI_CFG_FIFO_THRESH, APPLE_SPI_CFG_FIFO_THRESH_8B) |
   149			  FIELD_PREP(APPLE_SPI_CFG_MODE, APPLE_SPI_CFG_MODE_IRQ) | 
   150			  FIELD_PREP(APPLE_SPI_CFG_WORD_SIZE, APPLE_SPI_CFG_WORD_SIZE_8B));
   151	
   152		/* Disable IRQs */
   153		reg_write(spi, APPLE_SPI_IE_FIFO, 0);
   154		reg_write(spi, APPLE_SPI_IE_XFER, 0);
   155	
   156		/* Disable delays */
   157		reg_write(spi, APPLE_SPI_DELAY_PRE, 0);
   158		reg_write(spi, APPLE_SPI_DELAY_POST, 0);
   159	}
   160	
   161	static int apple_spi_prepare_message(struct spi_controller *ctlr, struct spi_message *msg)
   162	{
   163		struct apple_spi *spi = spi_controller_get_devdata(ctlr);
   164		struct spi_device *device = msg->spi;
   165	
   166		u32 cfg = ((device->mode & SPI_CPHA ? APPLE_SPI_CFG_CPHA : 0) |
   167			   (device->mode & SPI_CPOL ? APPLE_SPI_CFG_CPOL : 0) |
   168			   (device->mode & SPI_LSB_FIRST ? APPLE_SPI_CFG_LSB_FIRST : 0));
   169	
   170		/* Update core config */
   171		reg_mask(spi, APPLE_SPI_CFG,
   172			 APPLE_SPI_CFG_CPHA | APPLE_SPI_CFG_CPOL | APPLE_SPI_CFG_LSB_FIRST, cfg);
   173	
   174		return 0;
   175	}
   176	
   177	static void apple_spi_set_cs(struct spi_device *device, bool is_high)
   178	{
   179		struct apple_spi *spi = spi_controller_get_devdata(device->controller);
   180	
   181		reg_mask(spi, APPLE_SPI_PIN, APPLE_SPI_PIN_CS, is_high ? APPLE_SPI_PIN_CS : 0);
   182	}
   183	
   184	static bool apple_spi_prep_transfer(struct apple_spi *spi, struct spi_device *device,
   185					   struct spi_transfer *t)
   186	{
   187		u32 cr;
   188	
   189		/* Calculate and program the clock rate */
   190		cr = DIV_ROUND_UP(clk_get_rate(spi->clk), t->speed_hz) - 1;
   191		reg_write(spi, APPLE_SPI_CLKDIV, min_t(u32, cr, APPLE_SPI_CLKDIV_MAX));
   192	
   193		/* Update bits per word */
   194		reg_mask(spi, APPLE_SPI_SHIFTCFG, APPLE_SPI_SHIFTCFG_BITS,
   195			 FIELD_PREP(APPLE_SPI_SHIFTCFG_BITS, t->bits_per_word));
   196	
   197		/* We will want to poll if the time we need to wait is
   198		 * less than the context switching time.
   199		 * Let's call that threshold 5us. The operation will take:
   200		 *    bits_per_word * fifo_threshold / hz <= 5 * 10^-6
   201		 *    200000 * bits_per_word * fifo_threshold <= hz
   202		 */
   203		return 200000 * t->bits_per_word * APPLE_SPI_FIFO_DEPTH / 2 <= t->speed_hz;
   204	}
   205	
   206	static irqreturn_t apple_spi_irq(int irq, void *dev_id)
   207	{
   208		struct apple_spi *spi = dev_id;
   209		u32 fifo = reg_read(spi, APPLE_SPI_IF_FIFO) & reg_read(spi, APPLE_SPI_IE_FIFO);
   210		u32 xfer = reg_read(spi, APPLE_SPI_IF_XFER) & reg_read(spi, APPLE_SPI_IE_XFER);
   211	
   212		if (fifo || xfer) {
   213			/* Disable interrupts until next transfer */
   214			reg_write(spi, APPLE_SPI_IE_XFER, 0);
   215			reg_write(spi, APPLE_SPI_IE_FIFO, 0);
   216			complete(&spi->done);
   217			return IRQ_HANDLED;
   218		}
   219	
   220		return IRQ_NONE;
   221	}
   222	
   223	static void apple_spi_wait(struct apple_spi *spi, u32 fifo_bit, u32 xfer_bit, int poll)
   224	{
   225		if (poll) {
   226			u32 fifo, xfer;
   227	
   228			do {
   229				fifo = reg_read(spi, APPLE_SPI_IF_FIFO);
   230				xfer = reg_read(spi, APPLE_SPI_IF_XFER);
   231			} while (!((fifo & fifo_bit) || (xfer & xfer_bit)));
   232		} else {
   233			reinit_completion(&spi->done);
   234			reg_write(spi, APPLE_SPI_IE_XFER, xfer_bit);
   235			reg_write(spi, APPLE_SPI_IE_FIFO, fifo_bit);
   236			wait_for_completion(&spi->done);
   237			reg_write(spi, APPLE_SPI_IE_XFER, 0);
   238			reg_write(spi, APPLE_SPI_IE_FIFO, 0);
   239		}
   240	}
   241	
   242	static void apple_spi_tx(struct apple_spi *spi, const void **tx_ptr, u32 *left,
   243				 unsigned int bpw)
   244	{
   245		u32 inuse, words, wrote;
   246	
   247		if (!*tx_ptr)
   248			return;
   249	
 > 250		inuse = FIELD_GET(APPLE_SPI_FIFOSTAT_LEVEL_TX, reg_read(spi, APPLE_SPI_FIFOSTAT));
   251		words = wrote = min_t(u32, *left, APPLE_SPI_FIFOSTAT_LEVEL_TX - inuse);
   252	
   253		if (!words)
   254			return;
   255	
   256		*left -= words;
   257	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

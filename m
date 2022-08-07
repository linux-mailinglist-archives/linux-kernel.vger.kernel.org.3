Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E4658B8C1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 02:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiHGAZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 20:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiHGAZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 20:25:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CB4FDF
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 17:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659831917; x=1691367917;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bCRxceCT1GPjBIM+KOuiyEmlVrNCV7RonyvHn8IUZx8=;
  b=e6IAlsJow03viDAGkdvqBDvm9z7dGUhh4edL56vhonOz/3V8fO92cFjX
   58oy87YTgoW/ghNT0TeU5YlzRVh+n2usglrDDl0P+4ye2K0pp+X/jPdO8
   mcGQ0hhvKmcUGgcTS/pttadmGd1f9DepPi8kCUWhCCRvZd9A7YFrbUiZ9
   xcGl0Jjqi/3wcGF4agKJz4SN7wNvRKOIBXggJxD1k3DZKkio/N9NwE4/4
   zxiSWMatGudNhs4UOodGntPD2S94eCIxKzK0+gZkmpWi2ck96iadW4GhO
   sdCPyHAD8s1GFNuWTniCSDa5iieoTwJGBRFw6EOpQsB9VVgR/QDtf2Nfk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="376693767"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="376693767"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 17:25:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="636883798"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 Aug 2022 17:25:14 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKU6T-000KnZ-2k;
        Sun, 07 Aug 2022 00:25:13 +0000
Date:   Sun, 7 Aug 2022 08:24:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>
Subject: drivers/spi/spi-lp8841-rtc.c:63:28: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202208070805.j8BM5XMV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4d1044fcb996e8de9b9ab392f4a767890e45202d
commit: 8f28ca6bd8211214faf717677bbffe375c2a6072 iomap: constify ioreadX() iomem argument (as in generic implementation)
date:   2 years ago
config: alpha-randconfig-s041-20220806 (https://download.01.org/0day-ci/archive/20220807/202208070805.j8BM5XMV-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8f28ca6bd8211214faf717677bbffe375c2a6072
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8f28ca6bd8211214faf717677bbffe375c2a6072
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/spi/spi-lp8841-rtc.c:112:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:112:41: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:112:41: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:121:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:121:41: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:121:41: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:143:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:143:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:143:33: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:147:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:147:41: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:147:41: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:209:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *iomem @@     got void [noderef] __iomem * @@
   drivers/spi/spi-lp8841-rtc.c:209:21: sparse:     expected void *iomem
   drivers/spi/spi-lp8841-rtc.c:209:21: sparse:     got void [noderef] __iomem *
   drivers/spi/spi-lp8841-rtc.c:57:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:57:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:57:33: sparse:     got void *iomem
>> drivers/spi/spi-lp8841-rtc.c:63:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse:     expected void const [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:57:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:57:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:57:33: sparse:     got void *iomem
>> drivers/spi/spi-lp8841-rtc.c:63:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse:     expected void const [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-lp8841-rtc.c:47:33: sparse:     got void *iomem

vim +63 drivers/spi/spi-lp8841-rtc.c

7ecbfff6711fb3 Sergei Ianovich 2016-02-23   59  
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   60  static inline int
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   61  getmiso(struct spi_lp8841_rtc *data)
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   62  {
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  @63  	return ioread8(data->iomem) & SPI_LP8841_RTC_MISO;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   64  }
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   65  
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   66  static inline u32
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   67  bitbang_txrx_be_cpha0_lsb(struct spi_lp8841_rtc *data,
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   68  		unsigned usecs, unsigned cpol, unsigned flags,
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   69  		u32 word, u8 bits)
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   70  {
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   71  	/* if (cpol == 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   72  
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   73  	u32 shift = 32 - bits;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   74  	/* clock starts at inactive polarity */
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   75  	for (; likely(bits); bits--) {
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   76  
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   77  		/* setup LSB (to slave) on leading edge */
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   78  		if ((flags & SPI_MASTER_NO_TX) == 0)
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   79  			setmosi(data, (word & 1));
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   80  
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   81  		usleep_range(usecs, usecs + 1);	/* T(setup) */
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   82  
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   83  		/* sample LSB (from slave) on trailing edge */
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   84  		word >>= 1;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   85  		if ((flags & SPI_MASTER_NO_RX) == 0)
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   86  			word |= (getmiso(data) << 31);
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   87  
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   88  		setsck(data, !cpol);
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   89  		usleep_range(usecs, usecs + 1);
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   90  
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   91  		setsck(data, cpol);
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   92  	}
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   93  
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   94  	word >>= shift;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   95  	return word;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   96  }
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   97  
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   98  static int
7ecbfff6711fb3 Sergei Ianovich 2016-02-23   99  spi_lp8841_rtc_transfer_one(struct spi_master *master,
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  100  			    struct spi_device *spi,
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  101  			    struct spi_transfer *t)
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  102  {
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  103  	struct spi_lp8841_rtc	*data = spi_master_get_devdata(master);
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  104  	unsigned		count = t->len;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  105  	const u8		*tx = t->tx_buf;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  106  	u8			*rx = t->rx_buf;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  107  	u8			word = 0;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  108  	int			ret = 0;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  109  
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  110  	if (tx) {
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  111  		data->state &= ~SPI_LP8841_RTC_nWE;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  112  		writeb(data->state, data->iomem);
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  113  		while (likely(count > 0)) {
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  114  			word = *tx++;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  115  			bitbang_txrx_be_cpha0_lsb(data, 1, 0,
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  116  					SPI_MASTER_NO_RX, word, 8);
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  117  			count--;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  118  		}
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  119  	} else if (rx) {
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  120  		data->state |= SPI_LP8841_RTC_nWE;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  121  		writeb(data->state, data->iomem);
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  122  		while (likely(count > 0)) {
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  123  			word = bitbang_txrx_be_cpha0_lsb(data, 1, 0,
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  124  					SPI_MASTER_NO_TX, word, 8);
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  125  			*rx++ = word;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  126  			count--;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  127  		}
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  128  	} else {
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  129  		ret = -EINVAL;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  130  	}
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  131  
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  132  	spi_finalize_current_transfer(master);
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  133  
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  134  	return ret;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  135  }
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  136  
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  137  static void
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  138  spi_lp8841_rtc_set_cs(struct spi_device *spi, bool enable)
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  139  {
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  140  	struct spi_lp8841_rtc *data = spi_master_get_devdata(spi->master);
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  141  
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  142  	data->state = 0;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  143  	writeb(data->state, data->iomem);
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  144  	if (enable) {
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  145  		usleep_range(4, 5);
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  146  		data->state |= SPI_LP8841_RTC_CE;
7ecbfff6711fb3 Sergei Ianovich 2016-02-23 @147  		writeb(data->state, data->iomem);
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  148  		usleep_range(4, 5);
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  149  	}
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  150  }
7ecbfff6711fb3 Sergei Ianovich 2016-02-23  151  

:::::: The code at line 63 was first introduced by commit
:::::: 7ecbfff6711fb331591003ac32c002ce55a0758f spi: master driver to enable RTC on ICPDAS LP-8841

:::::: TO: Sergei Ianovich <ynvich@gmail.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

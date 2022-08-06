Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345B258B386
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 05:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbiHFDar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 23:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbiHFDao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 23:30:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D1A19C11
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 20:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659756643; x=1691292643;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Dttl4EHdATcM/RVfWJNBkynKgEuv8Q+ibr3lQWlItz0=;
  b=FHakL2v0gOnZRTg1TMDdt1nKelKmRN2Eahhm4QhJKAk4efTyoAX+XQnr
   T43aY54EA2ZagXzhSZP3eAdDfLmDCG8r6QsxpiGa8xp3DyldZo7Qd1KoH
   WEdhft5hEzRQPPyIDMt25X+Ep//Gvy+p05oROZCN+PLq92M880OwWNtSp
   CNJFtcHSrWT55mrIDsGqGDu83jhQhvCxVs7/AMqxwRvfXQBrmgvPoK2in
   o/0Cvnhoz9MTJ+qRQwP5gOatrl+hdwNT5ZugGH8h9uET2exrXl8HKbBct
   jRBlD0eeEWDs00l+3IKXcQyb7cExBhAMJpV6ZHZrPzbsWUlTahV5e5W16
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="273383234"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="273383234"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 20:30:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="636706182"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 05 Aug 2022 20:30:41 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKAWO-000Jxv-1V;
        Sat, 06 Aug 2022 03:30:40 +0000
Date:   Sat, 6 Aug 2022 11:29:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Noam <lnoam@marvell.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Raz Adashi <raza@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: drivers/spi/spi-armada-3700.c:500:65: sparse: sparse: incorrect type
 in argument 3 (different base types)
Message-ID: <202208061151.1zncglDW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6614a3c3164a5df2b54abb0b3559f51041cf705b
commit: 66bbf1441d218316948877f7ec6b477c9a49d554 spi: a3700: support BE for AC5 SPI driver
date:   11 days ago
config: arm64-randconfig-s052-20220804 (https://download.01.org/0day-ci/archive/20220806/202208061151.1zncglDW-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=66bbf1441d218316948877f7ec6b477c9a49d554
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 66bbf1441d218316948877f7ec6b477c9a49d554
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/block/null_blk/./ drivers/spi/ fs/zonefs/./

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/spi/spi-armada-3700.c:500:65: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] data @@     got restricted __le32 [usertype] @@
   drivers/spi/spi-armada-3700.c:500:65: sparse:     expected unsigned int [usertype] data
   drivers/spi/spi-armada-3700.c:500:65: sparse:     got restricted __le32 [usertype]
>> drivers/spi/spi-armada-3700.c:522:31: sparse: sparse: cast to restricted __le32
>> drivers/spi/spi-armada-3700.c:522:31: sparse: sparse: cast to restricted __le32
>> drivers/spi/spi-armada-3700.c:522:31: sparse: sparse: cast to restricted __le32
>> drivers/spi/spi-armada-3700.c:522:31: sparse: sparse: cast to restricted __le32
>> drivers/spi/spi-armada-3700.c:522:31: sparse: sparse: cast to restricted __le32
>> drivers/spi/spi-armada-3700.c:522:31: sparse: sparse: cast to restricted __le32

vim +500 drivers/spi/spi-armada-3700.c

   493	
   494	static int a3700_spi_fifo_write(struct a3700_spi *a3700_spi)
   495	{
   496		u32 val;
   497	
   498		while (!a3700_is_wfifo_full(a3700_spi) && a3700_spi->buf_len) {
   499			val = *(u32 *)a3700_spi->tx_buf;
 > 500			spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG, cpu_to_le32(val));
   501			a3700_spi->buf_len -= 4;
   502			a3700_spi->tx_buf += 4;
   503		}
   504	
   505		return 0;
   506	}
   507	
   508	static int a3700_is_rfifo_empty(struct a3700_spi *a3700_spi)
   509	{
   510		u32 val = spireg_read(a3700_spi, A3700_SPI_IF_CTRL_REG);
   511	
   512		return (val & A3700_SPI_RFIFO_EMPTY);
   513	}
   514	
   515	static int a3700_spi_fifo_read(struct a3700_spi *a3700_spi)
   516	{
   517		u32 val;
   518	
   519		while (!a3700_is_rfifo_empty(a3700_spi) && a3700_spi->buf_len) {
   520			val = spireg_read(a3700_spi, A3700_SPI_DATA_IN_REG);
   521			if (a3700_spi->buf_len >= 4) {
 > 522				val = le32_to_cpu(val);
   523				memcpy(a3700_spi->rx_buf, &val, 4);
   524	
   525				a3700_spi->buf_len -= 4;
   526				a3700_spi->rx_buf += 4;
   527			} else {
   528				/*
   529				 * When remain bytes is not larger than 4, we should
   530				 * avoid memory overwriting and just write the left rx
   531				 * buffer bytes.
   532				 */
   533				while (a3700_spi->buf_len) {
   534					*a3700_spi->rx_buf = val & 0xff;
   535					val >>= 8;
   536	
   537					a3700_spi->buf_len--;
   538					a3700_spi->rx_buf++;
   539				}
   540			}
   541		}
   542	
   543		return 0;
   544	}
   545	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

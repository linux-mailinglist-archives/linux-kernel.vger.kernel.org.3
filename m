Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6074F8E46
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbiDHF22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 01:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbiDHF20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:28:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F9211FE09
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 22:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649395583; x=1680931583;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iQzLOJQM3kIsvkHG8F3r8zJt/G/5UYHiHT0sa+/ifME=;
  b=jeGyVSRIy2Ey+8jxssenPO8QaSrhP03rdT2Zw8iPj9i8SMvcCgwOpvoi
   aRj0odP1YNcWMnAK/10OkyI5VHm9HqPvu4R/96UgbdfQ2hzOE6Nt1z88b
   Hp4iRRhSf6OogLZsunxrT6t+Vqlzdb767sNruP+OKKyaIi1Zh2dESPrma
   6aIALFQr6dXNg1kSgULgU6lkaiZa7nt6jU+xq/9Y2D6t9q2p0hAL5zwyy
   A75HMHRRMFEzqLSrQKyCHCePXlAgjgwH/hIvOJTVidPJrs5tet3cUzne9
   aQAtTNKgzJgFz7sXMpvk2jr42GzTnceyWyei3gW23KQHdbBhU3ygcyBNO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="259111858"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="259111858"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 22:26:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="589098903"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 07 Apr 2022 22:26:21 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nch8X-00065h-7E;
        Fri, 08 Apr 2022 05:26:21 +0000
Date:   Fri, 8 Apr 2022 13:25:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
Subject: [l1k:smsc95xx_5.17 191/199]
 drivers/char/tpm/tpm_tis_spi_slb9670.c:24:5: warning: no previous prototype
 for 'slb9670_spi_unset_reset'
Message-ID: <202204081357.8SfjQosI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   b194077da9627d066b5fa96b0aa1515b3b982d15
commit: 0c5db7c8f524b10886d73cf60256665e5f6df603 [191/199] tpm: tpm_tis_spi_slb_9670: implement set_reset and unset_reset functions
config: h8300-randconfig-r035-20220408 (https://download.01.org/0day-ci/archive/20220408/202204081357.8SfjQosI-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/0c5db7c8f524b10886d73cf60256665e5f6df603
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout 0c5db7c8f524b10886d73cf60256665e5f6df603
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=h8300 SHELL=/bin/bash drivers/char/tpm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/char/tpm/tpm_tis_spi_slb9670.c:24:5: warning: no previous prototype for 'slb9670_spi_unset_reset' [-Wmissing-prototypes]
      24 | int slb9670_spi_unset_reset(struct tpm_tis_data *data)
         |     ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/char/tpm/tpm_tis_spi_slb9670.c:46:5: warning: no previous prototype for 'slb9670_spi_set_reset' [-Wmissing-prototypes]
      46 | int slb9670_spi_set_reset(struct tpm_tis_data *data)
         |     ^~~~~~~~~~~~~~~~~~~~~


vim +/slb9670_spi_unset_reset +24 drivers/char/tpm/tpm_tis_spi_slb9670.c

    23	
  > 24	int slb9670_spi_unset_reset(struct tpm_tis_data *data)
    25	{
    26		/*
    27		 * Perform the reset sequence: we have to deassert and assert the reset
    28		 * line two times and wait the respective time intervals.
    29		 * After a last wait interval of RSTIN the chip is ready to receive the
    30		 * first command.
    31		 */
    32		gpiod_set_value(data->reset_gpio, 0);
    33		msleep(SLB9670_TIME_RSTIN);
    34		gpiod_set_value(data->reset_gpio, 1);
    35		udelay(SLB9670_TIME_WRST);
    36		gpiod_set_value(data->reset_gpio, 0);
    37		msleep(SLB9670_TIME_RSTIN);
    38		gpiod_set_value(data->reset_gpio, 1);
    39		udelay(SLB9670_TIME_WRST);
    40		gpiod_set_value(data->reset_gpio, 0);
    41		msleep(SLB9670_TIME_RSTIN);
    42	
    43		return 0;
    44	}
    45	
  > 46	int slb9670_spi_set_reset(struct tpm_tis_data *data)
    47	{
    48		gpiod_set_value(data->reset_gpio, 1);
    49		return 0;
    50	}
    51	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

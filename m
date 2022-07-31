Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C775861F7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 01:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238586AbiGaXbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 19:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiGaXbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 19:31:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C6A11A0D
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 16:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659310261; x=1690846261;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yVHqvUoE5HERyWFBC98VpBqCS2cdtSxp50XlxNO/c30=;
  b=QANo+JavC0TJmCdi9om6ncrQFvX6ZIInxRqgs0A7ojq8d6rV388Qfd0B
   Zp6P5tcpNAI5ptfjcF1ku0eJ5McypVpbNfXM7Qib7w7SiO0CbJONWjMlA
   PiZW5S7wSCA7GIfSNrfvTvUNj9k0KBPVxiG5uzJ0wr/q5cA1GGqxfy2No
   BhVcIXw7fIFTT0toqN7X0vZx4iWUKGsT6NM79MbWiiSh9i4VSzKw8ev6z
   Y7sQasYvNDWIprpJNFdOxGbwIHDVq9kHR/MdZ5w9iJPCzXR2QDKN5F66g
   u9/KOZoKuahm3KtHLYIs0V3xd9BfWVK1td2ClJami00P/ZoUzzUgtY8Mj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="286592642"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="286592642"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 16:31:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="634705046"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 31 Jul 2022 16:30:59 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIIOg-000Ecv-1i;
        Sun, 31 Jul 2022 23:30:58 +0000
Date:   Mon, 1 Aug 2022 07:30:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [jic23-iio:testing 21/30] drivers/iio/adc/at91-sama5d2_adc.c:790:11:
 warning: variable 'nbits' is used uninitialized whenever 'if' condition is
 false
Message-ID: <202208010745.QZRYCihu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
head:   e776e5ec0a21cc38f5e853d4dc98845d6e7f76b0
commit: 1c890d33c115b6331d8df8c06e46d3fc4e4e9d42 [21/30] iio: adc: at91-sama5d2_adc: adjust osr based on specific platform data
config: arm-randconfig-r026-20220731 (https://download.01.org/0day-ci/archive/20220801/202208010745.QZRYCihu-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=1c890d33c115b6331d8df8c06e46d3fc4e4e9d42
        git remote add jic23-iio https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
        git fetch --no-tags jic23-iio testing
        git checkout 1c890d33c115b6331d8df8c06e46d3fc4e4e9d42
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/iio/adc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/at91-sama5d2_adc.c:790:11: warning: variable 'nbits' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           else if (st->oversampling_ratio == 16)
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/at91-sama5d2_adc.c:797:48: note: uninitialized use occurs here
           diff = st->soc_info.platform->chan_realbits - nbits;
                                                         ^~~~~
   drivers/iio/adc/at91-sama5d2_adc.c:790:7: note: remove the 'if' if its condition is always true
           else if (st->oversampling_ratio == 16)
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/at91-sama5d2_adc.c:784:11: note: initialize the variable 'nbits' to silence this warning
           int nbits, diff;
                    ^
                     = 0
   1 warning generated.


vim +790 drivers/iio/adc/at91-sama5d2_adc.c

   781	
   782	static int at91_adc_adjust_val_osr(struct at91_adc_state *st, int *val)
   783	{
   784		int nbits, diff;
   785	
   786		if (st->oversampling_ratio == 1)
   787			nbits = 12;
   788		else if (st->oversampling_ratio == 4)
   789			nbits = 13;
 > 790		else if (st->oversampling_ratio == 16)
   791			nbits = 14;
   792	
   793		/*
   794		 * We have nbits of real data and channel is registered as
   795		 * st->soc_info.platform->chan_realbits, so shift left diff bits.
   796		 */
   797		diff = st->soc_info.platform->chan_realbits - nbits;
   798		*val <<= diff;
   799	
   800		return IIO_VAL_INT;
   801	}
   802	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

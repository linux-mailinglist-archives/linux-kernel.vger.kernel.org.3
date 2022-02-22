Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33A34BEFAC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 03:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbiBVCrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 21:47:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiBVCrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 21:47:16 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463FA22BDE;
        Mon, 21 Feb 2022 18:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645498012; x=1677034012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9y052aQ+Fe5ENvoVdgRksoJLPjYxMJtbEtdkf1tp8po=;
  b=f986MjPcTBmPkRksbkczE+sdlRnVVun3EmuXXqgAfjIJR/XpAKaDzqmO
   MeUx8kGUvQGpWwXtkqAppUtllQYlKaJZry3u51OPb9H9dkzNlAf0Kod1g
   wHZnPoQqkDACZGoOj5Wgb28RernND/sSzqRNC/rMom+5089KYk9V+fmU5
   ZSUxQbY7Omu8+b40rO94ZTPJgOcQtllmqoOpd0YheQ3xCDjPGKTx2pXhC
   3FHw4Gd0TQM/ZvmQVz7s+IvLHxE24Q3KPFaWzzsMOHimFAp7l0Ue79NTA
   1aQyIplZ4PK8hfn8O21O1xB5uAhNbOW+E2hR3KWEHTyD8jFPOIGp1DLlg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="276195622"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="276195622"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 18:46:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="573271646"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Feb 2022 18:46:49 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMLCS-0002Fi-NN; Tue, 22 Feb 2022 02:46:48 +0000
Date:   Tue, 22 Feb 2022 10:46:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v1 2/8] iio: accel: adxl345: Set driver_data for OF
 enumeration
Message-ID: <202202221026.cREU7Drv-lkp@intel.com>
References: <20220221233235.86893-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221233235.86893-2-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on v5.17-rc5 next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/iio-accel-adxl345-Convert-to-use-dev_err_probe/20220222-073422
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: i386-randconfig-a014-20220221 (https://download.01.org/0day-ci/archive/20220222/202202221026.cREU7Drv-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/2d02dfc34a92b731790a911491fbb13cf2e6e882
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Andy-Shevchenko/iio-accel-adxl345-Convert-to-use-dev_err_probe/20220222-073422
        git checkout 2d02dfc34a92b731790a911491fbb13cf2e6e882
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/iio/accel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/iio/accel/adxl345_i2c.c:32:25: error: use of undeclared identifier 'spi'
                   return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
                                         ^
>> drivers/iio/accel/adxl345_i2c.c:47:33: warning: incompatible integer to pointer conversion initializing 'const void *' with an expression of type 'int' [-Wint-conversion]
           { .compatible = "adi,adxl345", ADXL345 },
                                          ^~~~~~~
   drivers/iio/accel/adxl345_i2c.c:48:33: warning: incompatible integer to pointer conversion initializing 'const void *' with an expression of type 'int' [-Wint-conversion]
           { .compatible = "adi,adxl375", ADXL375 },
                                          ^~~~~~~
   2 warnings and 1 error generated.
--
>> drivers/iio/accel/adxl345_spi.c:48:33: warning: incompatible integer to pointer conversion initializing 'const void *' with an expression of type 'int' [-Wint-conversion]
           { .compatible = "adi,adxl345", ADXL345 },
                                          ^~~~~~~
   drivers/iio/accel/adxl345_spi.c:49:33: warning: incompatible integer to pointer conversion initializing 'const void *' with an expression of type 'int' [-Wint-conversion]
           { .compatible = "adi,adxl375", ADXL375 },
                                          ^~~~~~~
   2 warnings generated.


vim +47 drivers/iio/accel/adxl345_i2c.c

    45	
    46	static const struct of_device_id adxl345_of_match[] = {
  > 47		{ .compatible = "adi,adxl345", ADXL345 },
    48		{ .compatible = "adi,adxl375", ADXL375 },
    49		{ },
    50	};
    51	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

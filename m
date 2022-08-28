Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D075A400C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 00:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiH1W1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 18:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiH1W0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 18:26:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A023A4AF
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 15:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661725599; x=1693261599;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dcSE9LOG7cZJjuiBzpglSaypITbH/OCbn76AdIOCtCs=;
  b=JW4AQGZ/FEHj9PKG9oFQV+TclJJIXkyZpxrEVBhx7vLWYbV4J8f96nIk
   LS0fTgx9B0ksIKgw8tjeC1e3YsZPD2+0EyHtIjfWlj53WXcB2nVnj5HeY
   7LUCWRBYzs9Oq4/jnC40lnkX68GnjcxDPTQAj+CqsUWIW39yM1p3SjYDI
   L9Zbm3Z3cfMS149esh90Bw3SOnCAXHOaoaMyEcFeA8fZ4jojpB1MU4uxt
   y7EmfMENU2aGfGkV+xAFbIr3lTNZVivFX+outr6lZivtud6GnWxqWvn+U
   YI7Y1xZeXR8ArPUmomL/J3Q54UJb39OAHY1nLz5B5F5rhkn96+Robt+H/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="358737538"
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="358737538"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 15:26:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="939367547"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Aug 2022 15:26:36 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSQjj-0001gf-2d;
        Sun, 28 Aug 2022 22:26:35 +0000
Date:   Mon, 29 Aug 2022 06:25:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [jic23-iio:testing 124/129] drivers/iio/accel/msa311.c:993:24:
 warning: format specifies type 'unsigned char' but the argument has type
 'unsigned int'
Message-ID: <202208290618.wU7mHfOp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
head:   fc32c348a52157665cd8f3f060669ef4e8a03cd4
commit: 1a622d75985c5950a470edc50c7ad7c10e79a1d3 [124/129] iio: add MEMSensing MSA311 3-axis accelerometer driver
config: powerpc-randconfig-r024-20220829 (https://download.01.org/0day-ci/archive/20220829/202208290618.wU7mHfOp-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project a2100daf12fb980a29fd1a9c85ccf8eaaaf79730)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=1a622d75985c5950a470edc50c7ad7c10e79a1d3
        git remote add jic23-iio https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
        git fetch --no-tags jic23-iio testing
        git checkout 1a622d75985c5950a470edc50c7ad7c10e79a1d3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/iio/accel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iio/accel/msa311.c:993:24: warning: format specifies type 'unsigned char' but the argument has type 'unsigned int' [-Wformat]
                                              "msa311-%hhx", partid);
                                                      ~~~~   ^~~~~~
                                                      %x
   1 warning generated.


vim +993 drivers/iio/accel/msa311.c

   977	
   978	static int msa311_check_partid(struct msa311_priv *msa311)
   979	{
   980		struct device *dev = msa311->dev;
   981		unsigned int partid;
   982		int err;
   983	
   984		err = regmap_read(msa311->regs, MSA311_PARTID_REG, &partid);
   985		if (err)
   986			return dev_err_probe(dev, err, "failed to read partid\n");
   987	
   988		if (partid != MSA311_WHO_AM_I)
   989			dev_warn(dev, "invalid partid (%#x), expected (%#x)\n",
   990				 partid, MSA311_WHO_AM_I);
   991	
   992		msa311->chip_name = devm_kasprintf(dev, GFP_KERNEL,
 > 993						   "msa311-%hhx", partid);
   994		if (!msa311->chip_name)
   995			return dev_err_probe(dev, -ENOMEM, "can't alloc chip name\n");
   996	
   997		return 0;
   998	}
   999	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

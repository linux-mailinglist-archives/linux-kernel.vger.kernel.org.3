Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1364B3E30
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 23:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbiBMWyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 17:54:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiBMWyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 17:54:20 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D6E54BDF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 14:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644792853; x=1676328853;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9FS4KGk3LBexEVGA1hxuAXf3bVaYurQsGHyT55cjkCY=;
  b=BLNOKGK6jUbEu4LpUp4DKtM1sEc26Wi9Md6A2L7TSu72bGnqvVUtzOMI
   gnx0Ckh3IhHNvMBvwxI5zciE+3VxxXJxOHsvXP089Uv3au09O2rvRBSo8
   ID/U46U3n5LtY8MXBX5n3MiXjgwspGFo9AP5hkRUwzBe5O287KUQTX1aK
   Mf1WHHX4ZgeKdfKO1S9LCW1asox/xZFkJ64YnHLxzqrJVyfhVAH8+KIeD
   KcMk/fjZd+wUn0ETmV2WbY7TDraYVICfNe0UDtiFHZZRdmRP3QyRnifr+
   X0Imk3MxsfUxmQ7aC1WTtkvgtui1m0L1cCm2qS2DidWWEaT3/vj1k57vh
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="310716268"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="310716268"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 14:54:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="634758269"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 Feb 2022 14:54:12 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJNkx-0007x2-CB; Sun, 13 Feb 2022 22:54:11 +0000
Date:   Mon, 14 Feb 2022 06:53:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [jic23-iio:testing 87/92] drivers/iio/accel/mma8452.c:1515:34:
 error: 'mma8452_dt_ids' defined but not used
Message-ID: <202202140655.BClq5vSX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
head:   a383b88d051c387eac8cd12b636e5c177e39cf0e
commit: 90adc57bd55a64d5b24ac3afc1b7dd98508ead7b [87/92] iio: mma8452: Fix probe failing when an i2c_device_id is used
config: arm-randconfig-r025-20220213 (https://download.01.org/0day-ci/archive/20220214/202202140655.BClq5vSX-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=90adc57bd55a64d5b24ac3afc1b7dd98508ead7b
        git remote add jic23-iio https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
        git fetch --no-tags jic23-iio testing
        git checkout 90adc57bd55a64d5b24ac3afc1b7dd98508ead7b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/iio/accel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iio/accel/mma8452.c:1515:34: error: 'mma8452_dt_ids' defined but not used [-Werror=unused-const-variable=]
    1515 | static const struct of_device_id mma8452_dt_ids[] = {
         |                                  ^~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/mma8452_dt_ids +1515 drivers/iio/accel/mma8452.c

ecabae71319695 Martin Fuzzey     2015-05-13  1514  
c3cdd6e48e35b7 Martin Kepplinger 2015-09-01 @1515  static const struct of_device_id mma8452_dt_ids[] = {
244a93f651937a Martin Kepplinger 2016-01-16  1516  	{ .compatible = "fsl,mma8451", .data = &mma_chip_info_table[mma8451] },
c3cdd6e48e35b7 Martin Kepplinger 2015-09-01  1517  	{ .compatible = "fsl,mma8452", .data = &mma_chip_info_table[mma8452] },
c5ea1b58e8f51d Martin Kepplinger 2015-09-01  1518  	{ .compatible = "fsl,mma8453", .data = &mma_chip_info_table[mma8453] },
417e008ba9db7c Martin Kepplinger 2015-09-01  1519  	{ .compatible = "fsl,mma8652", .data = &mma_chip_info_table[mma8652] },
417e008ba9db7c Martin Kepplinger 2015-09-01  1520  	{ .compatible = "fsl,mma8653", .data = &mma_chip_info_table[mma8653] },
e8731180fbf6fd Martin Kepplinger 2016-03-09  1521  	{ .compatible = "fsl,fxls8471", .data = &mma_chip_info_table[fxls8471] },
c3cdd6e48e35b7 Martin Kepplinger 2015-09-01  1522  	{ }
c3cdd6e48e35b7 Martin Kepplinger 2015-09-01  1523  };
c3cdd6e48e35b7 Martin Kepplinger 2015-09-01  1524  MODULE_DEVICE_TABLE(of, mma8452_dt_ids);
c3cdd6e48e35b7 Martin Kepplinger 2015-09-01  1525  

:::::: The code at line 1515 was first introduced by commit
:::::: c3cdd6e48e35b7a02f28e301ef30a87ff3cd6527 iio: mma8452: refactor for seperating chip specific data

:::::: TO: Martin Kepplinger <martink@posteo.de>
:::::: CC: Jonathan Cameron <jic23@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

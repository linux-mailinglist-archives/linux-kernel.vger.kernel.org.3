Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0CF4EBAB9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243257AbiC3GYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238147AbiC3GY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:24:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3F351322
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648621363; x=1680157363;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eIFlnXBVJctgeKMmtQQok9y37HYyNjDZKtPkoodIbwA=;
  b=KHn5CijYCEgcHZI4V1Me/GUPBxTAMLY9bxqS1lsIkn0Fl9YIaNTsUVx5
   +5Qqdcaz1qPwB/tMP1NQqYhDiZmk5bIarM0CuyrvllSpz/t1dFGT7TUSN
   wLkBlbPDQ7DYopxrJLJfgnDSh+Xlb8cGAIne4L3xYeMMF+xgqx8IF2sRz
   VJxfGvRHLKJtTiwTrKaH+c9Keel5gO/iNG/xQyfvVzSZk/sSF9U1nLmk4
   zOknYzf+/ESw5/3xU/HX/9JB3FhIPlpHcQ8jMPWZPKyjEnYT6xD4+wyWJ
   YgxnBwVgLqc03cIrr0tK1Ka++n662RaqZBjcAvUl6n7Ni5A9SESBM17me
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="258287275"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="258287275"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 23:22:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="719847229"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Mar 2022 23:22:42 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZRj7-000139-Jq; Wed, 30 Mar 2022 06:22:41 +0000
Date:   Wed, 30 Mar 2022 14:21:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h:484:1: warning: 'inline' is
 not at beginning of declaration
Message-ID: <202203301438.ye1Y6gf5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c24a186398f59c80adb9a967486b65c1423a59d
commit: 04e6fedb18f6899453e59a748fb95be56ef73836 iio: imu: st_lsm6dsx: add mount matrix support
date:   2 years, 2 months ago
config: x86_64-randconfig-a003-20220328 (https://download.01.org/0day-ci/archive/20220330/202203301438.ye1Y6gf5-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=04e6fedb18f6899453e59a748fb95be56ef73836
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 04e6fedb18f6899453e59a748fb95be56ef73836
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:63:
>> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h:484:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
     484 | static const inline struct iio_mount_matrix *
         | ^~~~~~
--
   In file included from drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:41:
>> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h:484:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
     484 | static const inline struct iio_mount_matrix *
         | ^~~~~~
   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h:494:44: warning: 'st_lsm6dsx_accel_ext_info' defined but not used [-Wunused-const-variable=]
     494 | static const struct iio_chan_spec_ext_info st_lsm6dsx_accel_ext_info[] = {
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/inline +484 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h

   483	
 > 484	static const inline struct iio_mount_matrix *
   485	st_lsm6dsx_get_mount_matrix(const struct iio_dev *iio_dev,
   486				    const struct iio_chan_spec *chan)
   487	{
   488		struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
   489		struct st_lsm6dsx_hw *hw = sensor->hw;
   490	
   491		return &hw->orientation;
   492	}
   493	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22CD4C5CB2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 16:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiB0P6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 10:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiB0P6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 10:58:15 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F13DF1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 07:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645977458; x=1677513458;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AHt/s4g/dYuuOBvQkAI3QRAylqg2uZiNG2VGURGRzz0=;
  b=hCI+HtfbhoGyOVbbtDoJVtWlac2+Er0CIASv/L8U7o1Edu6HAe1b6Bsi
   dVQvm10Q+Eq8ltW0iNxgzjDFHBv6pucy9a8q7saCrP3oBHZH9QbMGA8yL
   h9a3fVt5cx02U0mdgAfrFUD6hKoiIDWiVbTXQCxddRwaSSuXzsGXWlwFa
   fx5SoEIkGDbiS+PsJNkmoSvScPb+SEpJQqh8E9OPT8ASIdS5tnF0hlUuz
   +z0njjq01A6mJ1XvHMlPEgeAVlrK4uHmpYtFPGVqY4Zi5ZFjPbYm/tWti
   8l1/QKnmNeTv7zWzZ6397XfiYOaI3ZpxJRodp5PwZ2hkTpz5OKh+vXwTZ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="277391909"
X-IronPort-AV: E=Sophos;i="5.90,141,1643702400"; 
   d="scan'208";a="277391909"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2022 07:57:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,141,1643702400"; 
   d="scan'208";a="799968151"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Feb 2022 07:57:36 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOLvT-0006bb-Q0; Sun, 27 Feb 2022 15:57:35 +0000
Date:   Sun, 27 Feb 2022 23:57:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [jic23-iio:testing 231/235] iio-test-rescale.c:undefined reference
 to `kunit_binary_str_assert_format'
Message-ID: <202202272331.LeHn9U6H-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
head:   95df41f4ef19f5884269e6c62dc1d128a23c94cb
commit: 683352565c0396077086ae0bec530d03e6b3c6df [231/235] iio: test: add basic tests for the iio-rescale driver
config: m68k-randconfig-r004-20220227 (https://download.01.org/0day-ci/archive/20220227/202202272331.LeHn9U6H-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=683352565c0396077086ae0bec530d03e6b3c6df
        git remote add jic23-iio https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
        git fetch --no-tags jic23-iio testing
        git checkout 683352565c0396077086ae0bec530d03e6b3c6df
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/iio/test/iio-test-rescale.o: in function `iio_rescale_test_offset':
>> iio-test-rescale.c:(.text+0x126): undefined reference to `kunit_binary_str_assert_format'
>> m68k-linux-ld: iio-test-rescale.c:(.text+0x22): undefined reference to `kunit_do_assertion'
>> m68k-linux-ld: iio-test-rescale.c:(.text+0x32): undefined reference to `kunit_kmalloc_array'
>> m68k-linux-ld: iio-test-rescale.c:(.text+0x9c): undefined reference to `kunit_binary_assert_format'
   m68k-linux-ld: drivers/iio/test/iio-test-rescale.o: in function `iio_rescale_test_scale':
>> iio-test-rescale.c:(.text+0x2e6): undefined reference to `kunit_do_assertion'
   m68k-linux-ld: iio-test-rescale.c:(.text+0x304): undefined reference to `kunit_kmalloc_array'
   m68k-linux-ld: iio-test-rescale.c:(.text+0x364): undefined reference to `kunit_binary_assert_format'
   m68k-linux-ld: iio-test-rescale.c:(.text+0x4f8): undefined reference to `kunit_binary_assert_format'
   m68k-linux-ld: iio-test-rescale.c:(.text+0x572): undefined reference to `kunit_binary_assert_format'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

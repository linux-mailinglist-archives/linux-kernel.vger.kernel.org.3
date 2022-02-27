Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A474C5DAB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 18:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiB0RTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 12:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiB0RTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 12:19:20 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B30113E89
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 09:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645982322; x=1677518322;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jbL7slDERTMyYql2ymMr6DnFSb/2JvhP5zFVTczr5Mk=;
  b=ADUEZbcR6Gk2pQ1W4R4CMG4lG4q2L5q28YLTVY302MyltNc1I1E6xB+G
   haYqgUsqQRdUCc7CD3y/DJgpCjlNPqnDANY1ShrDPCpQZKzNfdXKqAS62
   PFuGfdHW7YYXkDEjNtw9o7zz2VSpQM/YpXC5cppVIFACti86lPQ0jAdfG
   V5AhBosDwdV+2DIO2J346r+cewwdOcGKKmmgrwTF842kHP94yIAXn0Rhn
   ysTQ7lnO9QlgnKk/pB9nnDFJR+R6wngQmKxKO3iRACFsZKbtJvwvExmfZ
   TthlCc5XbUrdDS8UaX/Nu9QbeezedOd7N0Pn0WtMenrQgnl4k8mjz1Cfe
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="251583934"
X-IronPort-AV: E=Sophos;i="5.90,141,1643702400"; 
   d="scan'208";a="251583934"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2022 09:18:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,141,1643702400"; 
   d="scan'208";a="640644028"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Feb 2022 09:18:39 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nONBv-0006ey-16; Sun, 27 Feb 2022 17:18:39 +0000
Date:   Mon, 28 Feb 2022 01:18:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [jic23-iio:testing 231/235] iio-test-rescale.c:undefined reference
 to `kunit_binary_assert_format'
Message-ID: <202202280119.ftKfZpaB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
head:   95df41f4ef19f5884269e6c62dc1d128a23c94cb
commit: 683352565c0396077086ae0bec530d03e6b3c6df [231/235] iio: test: add basic tests for the iio-rescale driver
config: m68k-randconfig-m031-20220227 (https://download.01.org/0day-ci/archive/20220228/202202280119.ftKfZpaB-lkp@intel.com/config)
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
>> iio-test-rescale.c:(.text+0xaa): undefined reference to `kunit_binary_assert_format'
>> m68k-linux-ld: iio-test-rescale.c:(.text+0x134): undefined reference to `kunit_binary_str_assert_format'
   m68k-linux-ld: drivers/iio/test/iio-test-rescale.o: in function `iio_rescale_test_scale':
   iio-test-rescale.c:(.text+0x35e): undefined reference to `kunit_binary_assert_format'
   m68k-linux-ld: iio-test-rescale.c:(.text+0x4a6): undefined reference to `kunit_binary_assert_format'
   m68k-linux-ld: iio-test-rescale.c:(.text+0x514): undefined reference to `kunit_binary_assert_format'
   m68k-linux-ld: iio-test-rescale.c:(.text+0x600): undefined reference to `kunit_binary_assert_format'
   m68k-linux-ld: iio-test-rescale.c:(.text+0x66e): undefined reference to `kunit_binary_assert_format'
   m68k-linux-ld: drivers/iio/test/iio-test-rescale.o: in function `iio_rescale_test_offset':
>> iio-test-rescale.c:(.text+0x20): undefined reference to `kunit_kmalloc_array'
   m68k-linux-ld: iio-test-rescale.c:(.text+0xfa): undefined reference to `kunit_do_assertion'
   m68k-linux-ld: drivers/iio/test/iio-test-rescale.o: in function `iio_rescale_test_scale':
   iio-test-rescale.c:(.text+0x2e0): undefined reference to `kunit_kmalloc_array'
   m68k-linux-ld: iio-test-rescale.c:(.text+0x3ae): undefined reference to `kunit_do_assertion'
   m68k-linux-ld: net/core/sock.o: in function `sk_destruct':
   (.text+0x411a): undefined reference to `__sk_defer_free_flush'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

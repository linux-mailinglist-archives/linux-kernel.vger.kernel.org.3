Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A0847BB6E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbhLUIDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:03:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:43348 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235383AbhLUIDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640073831; x=1671609831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=41Ve57LH9vKZVkmrFdgNEo5ROhFavgNxMAwyZUJAA3g=;
  b=ReRiju6WMjirNb7Fwpa5QPqzc94UL3DpNgVC6aFqv6tEbx6Dc/VTd30d
   jKn7tTI8nwiOZuzeaOyRhEY/jNezBwb4HFa0zWPnNTIvIJbkdfu9FFGZm
   MMVTeXkbSPJwX0us+5gKfWqdnIFm2gHvDpfhKWm0rOmAl7FUt6ZCoYAjv
   dCxi3hU67HTjwYTceWntGkGs+lR9qWsOVbSvW3wdbjQIEAuibiP6Ickhg
   Anh02Ui/lP/xsJn7Sc2pQCtxvERnrGXWb/5G/IJJXG+7CP6BuzUGgZ53N
   EziCa88U0ogE72VHM9lrjS4w6OdqZs4uA3Hi1nBpG0XNaL4kJnIs8OCPc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="227640800"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="227640800"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 00:03:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="684580945"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2021 00:03:49 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mza7g-0008qw-HR; Tue, 21 Dec 2021 08:03:48 +0000
Date:   Tue, 21 Dec 2021 16:03:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liam Beguin <liambeguin@gmail.com>, peda@axentia.se,
        jic23@kernel.org, lars@metafoo.de
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v10 10/14] iio: test: add basic tests for the iio-rescale
 driver
Message-ID: <202112211530.JHHCLDOr-lkp@intel.com>
References: <20211219223953.16074-11-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211219223953.16074-11-liambeguin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 2b6bff0b122785f09cfbdc34b1aa9edceea6e4c1]

url:    https://github.com/0day-ci/linux/commits/Liam-Beguin/iio-afe-add-temperature-rescaling-support/20211220-064048
base:   2b6bff0b122785f09cfbdc34b1aa9edceea6e4c1
config: mips-randconfig-r026-20211220 (https://download.01.org/0day-ci/archive/20211221/202112211530.JHHCLDOr-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/833188fad2d37f1e40f56eb7286d6dd2e1a2ced5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Liam-Beguin/iio-afe-add-temperature-rescaling-support/20211220-064048
        git checkout 833188fad2d37f1e40f56eb7286d6dd2e1a2ced5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mipsel-linux-ld: drivers/iio/test/iio-test-rescale.o: in function `iio_rescale_test_offset':
>> iio-test-rescale.c:(.text+0x48): undefined reference to `kunit_kmalloc_array'
>> mipsel-linux-ld: iio-test-rescale.c:(.text+0xc4): undefined reference to `kunit_binary_assert_format'
   mipsel-linux-ld: iio-test-rescale.c:(.text+0xc8): undefined reference to `kunit_binary_assert_format'
>> mipsel-linux-ld: iio-test-rescale.c:(.text+0x13c): undefined reference to `kunit_do_assertion'
>> mipsel-linux-ld: iio-test-rescale.c:(.text+0x15c): undefined reference to `kunit_binary_str_assert_format'
   mipsel-linux-ld: iio-test-rescale.c:(.text+0x160): undefined reference to `kunit_binary_str_assert_format'
   mipsel-linux-ld: iio-test-rescale.c:(.text+0x1b0): undefined reference to `kunit_do_assertion'
   mipsel-linux-ld: drivers/iio/test/iio-test-rescale.o: in function `iio_rescale_test_scale':
   iio-test-rescale.c:(.text+0x40c): undefined reference to `kunit_kmalloc_array'
   mipsel-linux-ld: iio-test-rescale.c:(.text+0x490): undefined reference to `kunit_binary_assert_format'
   mipsel-linux-ld: iio-test-rescale.c:(.text+0x4c0): undefined reference to `kunit_binary_assert_format'
   mipsel-linux-ld: iio-test-rescale.c:(.text+0x4f0): undefined reference to `kunit_do_assertion'
   mipsel-linux-ld: iio-test-rescale.c:(.text+0x6a4): undefined reference to `kunit_do_assertion'
   mipsel-linux-ld: iio-test-rescale.c:(.text+0x718): undefined reference to `kunit_do_assertion'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

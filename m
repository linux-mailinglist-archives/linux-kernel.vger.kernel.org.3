Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE3049815E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbiAXNtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:49:55 -0500
Received: from mga05.intel.com ([192.55.52.43]:11290 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232688AbiAXNtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643032187; x=1674568187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SZOZaltlzRkEFvk7iyPFTYTArEs+caDEG/8y0bOW5QQ=;
  b=jBaYD5WBGXQqsavxFF8qSKv9xVcYAGK7XRJ08NG6B2ncbqAZP5P4pR5K
   Bsx1IQVOsS9RTldhjnaIenkiXGYlwFZNLJaPazSUrrIZPlTG4//DjePzu
   ugiBNYXDBrthX0zfwZ3yqXwAduHJkmyqwSrPEUhXWgN5l8qhub9UbWxKs
   Sb7Q3XGOkYIQg784DcZztWZKO19oxTxFmK5jfWxA7GzlHz+OyT6jJc4RS
   C2F8CevCfc5S16B15Ro6DofXJr5H4AjJ6HaPxL+6uyDTW9KdIb+zgvp1m
   lPM/4Dj0YWUFclkDzqWnID42Lw788V+nIC69gKnKLEqWSufQVwkMguVfT
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="332400062"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="332400062"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 05:49:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="673628194"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jan 2022 05:49:42 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBzj4-000IPB-6r; Mon, 24 Jan 2022 13:49:42 +0000
Date:   Mon, 24 Jan 2022 21:49:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: Re: [PATCH V1 2/6] iio: accel: sca3300: Add interface for operation
 modes.
Message-ID: <202201242108.VNQCotc3-lkp@intel.com>
References: <20220124093912.2429190-3-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124093912.2429190-3-Qing-wu.Li@leica-geosystems.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi LI,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on v5.17-rc1 next-20220124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/LI-Qingwu/i-iio-accel-sca3300-add-compitible-for-scl3300/20220124-174021
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: hexagon-randconfig-r033-20220124 (https://download.01.org/0day-ci/archive/20220124/202201242108.VNQCotc3-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2e58a18910867ba6795066e044293e6daf89edf5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/1521580933c9c08143fc14b23a363eb7961d4520
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review LI-Qingwu/i-iio-accel-sca3300-add-compitible-for-scl3300/20220124-174021
        git checkout 1521580933c9c08143fc14b23a363eb7961d4520
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/iio/accel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iio/accel/sca3300.c:74:53: error: too few arguments provided to function-like macro invocation
           IIO_ENUM_AVAILABLE("op_mode", &sca3300_op_mode_enum),
                                                              ^
   include/linux/iio/iio.h:112:9: note: macro 'IIO_ENUM_AVAILABLE' defined here
   #define IIO_ENUM_AVAILABLE(_name, _shared, _e) \
           ^
>> drivers/iio/accel/sca3300.c:74:2: error: use of undeclared identifier 'IIO_ENUM_AVAILABLE'
           IIO_ENUM_AVAILABLE("op_mode", &sca3300_op_mode_enum),
           ^
   2 errors generated.


vim +74 drivers/iio/accel/sca3300.c

    71	
    72	static const struct iio_chan_spec_ext_info sca3300_ext_info[] = {
    73		IIO_ENUM("op_mode", IIO_SHARED_BY_DIR, &sca3300_op_mode_enum),
  > 74		IIO_ENUM_AVAILABLE("op_mode", &sca3300_op_mode_enum),
    75		{ }
    76	};
    77	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

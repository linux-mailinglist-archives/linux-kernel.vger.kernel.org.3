Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B27498191
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbiAXN7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:59:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:12583 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237570AbiAXN7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643032786; x=1674568786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=unFXJyKVZTyhnyECH5pNwXJIWt4xgpdJKxD05+OTTHA=;
  b=BRJPgCyO01A9W/+Af99a73qI2Ob2vPD1uRCeG2K5YjzYYda0uTiykD7z
   9CU5PGf9qjmTSZIXP/Avg3A2PParlHbalaBAsl7h6z0Odp/eXsRpAv4CQ
   GmzvR/vYJmdYtYLSZGpCrhJAdYARgEviNOuTkR35mlruub5PSRPJLeWBM
   u04vL2cB2ZJt8JD7YYjNEwXheV1xMGYIbSQHyo48eSRufn78OHf6BgtIX
   fScU6JSb5Uxexmn7Kd9dzRZ2rfMaK8ai9C8Cr/cBj6odyekwGFmeXiPJm
   uh24Bz4JNhyp/PUmoYuCc2etfoNZqqfBytATKxnFfxMH4RQU6QLfLrES+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="309366787"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="309366787"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 05:59:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="624087198"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jan 2022 05:59:43 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBzsk-000IQ8-Kb; Mon, 24 Jan 2022 13:59:42 +0000
Date:   Mon, 24 Jan 2022 21:59:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: Re: [PATCH V1 2/6] iio: accel: sca3300: Add interface for operation
 modes.
Message-ID: <202201242143.uZzucUii-lkp@intel.com>
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
config: parisc-randconfig-r015-20220124 (https://download.01.org/0day-ci/archive/20220124/202201242143.uZzucUii-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/1521580933c9c08143fc14b23a363eb7961d4520
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review LI-Qingwu/i-iio-accel-sca3300-add-compitible-for-scl3300/20220124-174021
        git checkout 1521580933c9c08143fc14b23a363eb7961d4520
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash drivers/iio/accel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iio/accel/sca3300.c:74:60: error: macro "IIO_ENUM_AVAILABLE" requires 3 arguments, but only 2 given
      74 |         IIO_ENUM_AVAILABLE("op_mode", &sca3300_op_mode_enum),
         |                                                            ^
   In file included from include/linux/iio/buffer.h:10,
                    from drivers/iio/accel/sca3300.c:17:
   include/linux/iio/iio.h:112: note: macro "IIO_ENUM_AVAILABLE" defined here
     112 | #define IIO_ENUM_AVAILABLE(_name, _shared, _e) \
         | 
>> drivers/iio/accel/sca3300.c:74:9: error: 'IIO_ENUM_AVAILABLE' undeclared here (not in a function)
      74 |         IIO_ENUM_AVAILABLE("op_mode", &sca3300_op_mode_enum),
         |         ^~~~~~~~~~~~~~~~~~


vim +/IIO_ENUM_AVAILABLE +74 drivers/iio/accel/sca3300.c

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

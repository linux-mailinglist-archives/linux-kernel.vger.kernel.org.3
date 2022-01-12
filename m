Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C924E48C4F3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353666AbiALNhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:37:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:1279 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353635AbiALNgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641994609; x=1673530609;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y15fyvFsXPPjrxE4U3JxxUpz4g4dVIRVvVS6UW8aFic=;
  b=hPv1oQ+1jgrZMkLVSSxMdQqOSWmTIP+KRuoLBObHeY0+sBenJHrBNZhf
   mtAau5eNqDFLZx8Rvmoen+ONK6dzpmSH04811lIYJEbySFKvmSS9gwc4H
   nJYcNj1dZG/XzJpcQcEXKu+Fx/LIr277yiPXbWkjO6YhVHgPZlUmwU1qj
   p1ijjPL6Us5/6N7nUFkM+HnC8InrtZnY4Tbk9h+L7XKRL3+XrrDF9dlxw
   v1pVojfc1Y0J3//MTnj5KAT2TBsSjgfoqXIbeyxHiT3pSG8twXvQqFaws
   d+PBYaLo8LTevJnqPwPGwoJGov0qAb6tx0YIkJNIKQ/OKeQXmpMWa5FGM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="241287651"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="241287651"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 05:36:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="576552091"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jan 2022 05:36:47 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7dnz-0005rV-8z; Wed, 12 Jan 2022 13:36:47 +0000
Date:   Wed, 12 Jan 2022 21:36:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [chenxing:msc313_mainlining 52/82] drivers/mtd/spi-nor/zbit.c:13:8:
 error: too many arguments provided to function-like macro invocation
Message-ID: <202201122102.bNB0eDU9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/linux-chenxing/linux.git msc313_mainlining
head:   18ce00127e968c06cc0fe1157d36858f59272624
commit: 9994994d1139138f2b0ce3ffbaec1c3d1471c7e2 [52/82] mtd: spi-nor: Add support for ZB25VQ128
config: arm-randconfig-r006-20220112 (https://download.01.org/0day-ci/archive/20220112/202201122102.bNB0eDU9-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 244dd2913a43a200f5a6544d424cdc37b771028b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/linux-chenxing/linux/commit/9994994d1139138f2b0ce3ffbaec1c3d1471c7e2
        git remote add chenxing git://github.com/linux-chenxing/linux.git
        git fetch --no-tags chenxing msc313_mainlining
        git checkout 9994994d1139138f2b0ce3ffbaec1c3d1471c7e2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/mtd/spi-nor/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/mtd/spi-nor/zbit.c:13:8: error: too many arguments provided to function-like macro invocation
                               SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
                               ^
   drivers/mtd/spi-nor/core.h:427:9: note: macro 'INFO' defined here
   #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)              \
           ^
>> drivers/mtd/spi-nor/zbit.c:12:17: error: use of undeclared identifier 'INFO'
           { "zb25vq128", INFO(0x5e4018, 0, 64 * 1024, 256,
                          ^
>> drivers/mtd/spi-nor/zbit.c:20:12: error: invalid application of 'sizeof' to an incomplete type 'const struct flash_info[]'
           .nparts = ARRAY_SIZE(zbit_parts),
                     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:46:32: note: expanded from macro 'ARRAY_SIZE'
   #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                  ^~~~~
   3 errors generated.


vim +13 drivers/mtd/spi-nor/zbit.c

     9	
    10	static const struct flash_info zbit_parts[] = {
    11		/* zbit */
  > 12		{ "zb25vq128", INFO(0x5e4018, 0, 64 * 1024, 256,
  > 13				    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
    14				    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
    15	};
    16	
    17	const struct spi_nor_manufacturer spi_nor_zbit = {
    18		.name = "zbit",
    19		.parts = zbit_parts,
  > 20		.nparts = ARRAY_SIZE(zbit_parts),

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

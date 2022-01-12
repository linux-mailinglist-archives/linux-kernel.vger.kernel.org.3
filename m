Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D71048C4F2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353647AbiALNgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:36:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:1269 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240715AbiALNgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641994609; x=1673530609;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Pjl3uIIOwa1FA2Lee2DdGWEMC8vr8bNVu0Vj/brIK80=;
  b=N11pt8gYZL0MpAjcMxIyUu3/JimBdWjwMjVNirEfimi1Ad6dnzkgZrkg
   3Cqqu/1kCxr2ArQXvI6V+lOmnkzFE8rI0AXH6MPfk+gqNxxh6d4K/5ty/
   WBeJESQDfNx/0suyKA+jjU9vl1RUHR66ZpYIJjo2qwcKIDJPCBBJNu5JE
   sgU39Es15Je3HL0vdHcbWinwtVlaE0c1BfZAK3JL/N6BIt1VoSR9poC9N
   JNCufVczjK7cX8hco7VK3QGbzUkZ+7YfWfp3UR1yilLRKslW5V8R62roR
   eEHor9TcLOmx1pZksgt/5DvNLul02OTqS6zjNUO2+9iBatvUOK3+SDkfH
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="241287649"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="241287649"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 05:36:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="670148644"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jan 2022 05:36:48 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7dnz-0005ra-AC; Wed, 12 Jan 2022 13:36:47 +0000
Date:   Wed, 12 Jan 2022 21:35:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [chenxing:msc313_mainlining 52/82] drivers/mtd/spi-nor/zbit.c:14:62:
 error: macro "INFO" passed 5 arguments, but takes just 4
Message-ID: <202201122159.BZm1t7Kt-lkp@intel.com>
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
config: arc-randconfig-r003-20220112 (https://download.01.org/0day-ci/archive/20220112/202201122159.BZm1t7Kt-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/linux-chenxing/linux/commit/9994994d1139138f2b0ce3ffbaec1c3d1471c7e2
        git remote add chenxing git://github.com/linux-chenxing/linux.git
        git fetch --no-tags chenxing msc313_mainlining
        git checkout 9994994d1139138f2b0ce3ffbaec1c3d1471c7e2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/mtd/spi-nor/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/mtd/spi-nor/zbit.c:14:62: error: macro "INFO" passed 5 arguments, but takes just 4
      14 |                             SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
         |                                                              ^
   In file included from drivers/mtd/spi-nor/zbit.c:8:
   drivers/mtd/spi-nor/core.h:427: note: macro "INFO" defined here
     427 | #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)              \
         | 
>> drivers/mtd/spi-nor/zbit.c:12:24: error: 'INFO' undeclared here (not in a function)
      12 |         { "zb25vq128", INFO(0x5e4018, 0, 64 * 1024, 256,
         |                        ^~~~


vim +/INFO +14 drivers/mtd/spi-nor/zbit.c

     9	
    10	static const struct flash_info zbit_parts[] = {
    11		/* zbit */
  > 12		{ "zb25vq128", INFO(0x5e4018, 0, 64 * 1024, 256,
    13				    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
  > 14				    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
    15	};
    16	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

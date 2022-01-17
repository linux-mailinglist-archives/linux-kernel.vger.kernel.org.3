Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98AE49059A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238416AbiAQKA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:00:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:36835 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232590AbiAQKA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642413657; x=1673949657;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1uoyrp3eIEAIF6bYh4g52Jc2dFepbnqicFJBUSwG1XQ=;
  b=S1IcdyXpp28WqE8brlsNdnKjBTsGH+HVpYh2cJ6sLI7b71jgPlTtDPkA
   V+j0YGweFgCqM40RjZHjDy7yrXKsDcrg2FZArAJomiTuH+cO6YKoM01ea
   43b3OHVyld1M8ISW2SATgbVNAxp/HNMmyS7E22GVKB4fuaWAh8+8rePLY
   XUo4NzKmoN57sJLndSLKZd3vF5M29h+/lEk0n8STKkR7DKqJyMnqgUFgm
   +la24x5LCB9to7XZxVWOucCQfnVgX8g+B1eACPV11y0xFs0gCnJ+oHZdk
   D73Or+2e6D2Le+WqD6PGfeVygeN+O3UdvveZZ2/gzODErAfgflim6DBc2
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="244393361"
X-IronPort-AV: E=Sophos;i="5.88,295,1635231600"; 
   d="scan'208";a="244393361"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 02:00:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,295,1635231600"; 
   d="scan'208";a="476592974"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 17 Jan 2022 02:00:30 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9OoP-000BRi-HW; Mon, 17 Jan 2022 10:00:29 +0000
Date:   Mon, 17 Jan 2022 18:00:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: drivers/iio/adc/ti-tsc2046.c:242:62: warning: taking address of
 packed member 'data' of class or structure 'tsc2046_adc_atom' may result in
 an unaligned pointer value
Message-ID: <202201171718.7ZCI4YeQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0c947b893d69231a9add855939da7c66237ab44f
commit: 9374e8f5a38defe90bc65b2decf317c1c62d91dd iio: adc: add ADC driver for the TI TSC2046 controller
date:   8 months ago
config: mips-randconfig-r002-20220116 (https://download.01.org/0day-ci/archive/20220117/202201171718.7ZCI4YeQ-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c63a3175c2947e8c1a2d3bbe16a8586600705c54)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9374e8f5a38defe90bc65b2decf317c1c62d91dd
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9374e8f5a38defe90bc65b2decf317c1c62d91dd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/iio/adc/ drivers/usb/gadget/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/ti-tsc2046.c:242:62: warning: taking address of packed member 'data' of class or structure 'tsc2046_adc_atom' may result in an unaligned pointer value [-Waddress-of-packed-member]
           return FIELD_GET(TI_TSC2046_DATA_12BIT, get_unaligned_be16(&buf->data));
                                                                       ^~~~~~~~~
   include/linux/bitfield.h:108:27: note: expanded from macro 'FIELD_GET'
                   __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
                                           ^~~~
   include/linux/bitfield.h:52:38: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG((_mask) > (typeof(_reg))~0ull,         \
                                                      ^~~~
   include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                                            ^~~~
   include/linux/compiler_types.h:328:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                               ^~~~~~~~~
   include/linux/compiler_types.h:316:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
                                ^~~~~~~~~
   include/linux/compiler_types.h:308:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   1 warning generated.


vim +242 drivers/iio/adc/ti-tsc2046.c

   239	
   240	static u16 tsc2046_adc_get_value(struct tsc2046_adc_atom *buf)
   241	{
 > 242		return FIELD_GET(TI_TSC2046_DATA_12BIT, get_unaligned_be16(&buf->data));
   243	}
   244	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

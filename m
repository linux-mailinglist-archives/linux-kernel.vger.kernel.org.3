Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6C04855A9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241302AbiAEPRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:17:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:17779 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237011AbiAEPRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641395867; x=1672931867;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hpKl/9ZkBTGQ5ElBaYyYUoe3zIlQdBS1rTdYZzRiWqE=;
  b=jOXJgm2o0Y+5BnxwC6hTcOIpFiee6BjINDrOVHEYEwgeh4UIcSDS/tW+
   kpmu7xqiJYYq0jcmiqRqXR8DkLdOmR0cB19KV1eofqlVo6LP8T3YU5m8t
   jgBRhJvtNEdDsJhhFSNBrRE1Oh8GI/6sybUuDiYwDgVe7l2+V6ufeP/mW
   5xZ1F6u+yu+11+KxoXxiaUBbU6BXs7JTBKAX/TDoFlKspJlTjcVclMeSO
   6+ig2eAh2ziijMm9T28hDhGphxzL6Vh9+zRWjOtNtJ7gP54wT9LBbh2yd
   Sy2xCeAu+2uSSHr3GhZ0TqzFYKQdeOknVnew2JOVNtG/osewGXkfoHc8L
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="305813232"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="305813232"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 07:17:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="470602837"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Jan 2022 07:17:44 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n582p-000Gmj-U6; Wed, 05 Jan 2022 15:17:43 +0000
Date:   Wed, 5 Jan 2022 23:17:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Zaidman <michael.zaidman@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Subject: drivers/hid/hid-ft260.c:879:1: warning: taking address of packed
 member 'clock' of class or structure 'ft260_get_i2c_status_report' may
 result in an unaligned pointer value
Message-ID: <202201052330.GECx4YSO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c9e6606c7fe92b50a02ce51dda82586ebdf99b48
commit: 6a82582d9fa438045191074856f47165334f2777 HID: ft260: add usb hid to i2c host bridge driver
date:   10 months ago
config: mips-randconfig-r036-20220105 (https://download.01.org/0day-ci/archive/20220105/202201052330.GECx4YSO-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d5b6e30ed3acad794dd0aec400e617daffc6cc3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6a82582d9fa438045191074856f47165334f2777
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6a82582d9fa438045191074856f47165334f2777
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/hid/ drivers/usb/gadget/ fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/hid/hid-ft260.c:515:59: warning: variable 'len' is uninitialized when used here [-Wuninitialized]
                   hid_err(hdev, "%s: unsupported wr len: %d\n", __func__, len);
                                                                           ^~~
   include/linux/hid.h:1190:30: note: expanded from macro 'hid_err'
           dev_err(&(hid)->dev, fmt, ##__VA_ARGS__)
                                       ^~~~~~~~~~~
   include/linux/dev_printk.h:112:32: note: expanded from macro 'dev_err'
           _dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                         ^~~~~~~~~~~
   drivers/hid/hid-ft260.c:507:9: note: initialize the variable 'len' to silence this warning
           int len, ret;
                  ^
                   = 0
>> drivers/hid/hid-ft260.c:879:1: warning: taking address of packed member 'clock' of class or structure 'ft260_get_i2c_status_report' may result in an unaligned pointer value [-Waddress-of-packed-member]
   FT260_I2CST_ATTR_SHOW(clock);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-ft260.c:814:3: note: expanded from macro 'FT260_I2CST_ATTR_SHOW'
                   FT260_ATTR_SHOW(name, ft260_get_i2c_status_report,             \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-ft260.c:803:18: note: expanded from macro 'FT260_ATTR_SHOW'
                   type *field = &rep.name;                                       \
                                  ^~~~~~~~
   2 warnings generated.


vim +879 drivers/hid/hid-ft260.c

   878	
 > 879	FT260_I2CST_ATTR_SHOW(clock);
   880	FT260_WORD_ATTR_STORE(clock, ft260_set_i2c_speed_report,
   881			      FT260_SET_I2C_CLOCK_SPEED);
   882	static DEVICE_ATTR_RW(clock);
   883	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

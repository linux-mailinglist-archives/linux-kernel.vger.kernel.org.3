Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C83465C11
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 03:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354461AbhLBCVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 21:21:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:20648 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344989AbhLBCVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 21:21:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="299995880"
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; 
   d="scan'208";a="299995880"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 18:18:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; 
   d="scan'208";a="500499377"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 01 Dec 2021 18:17:59 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msbfb-000FgV-8M; Thu, 02 Dec 2021 02:17:59 +0000
Date:   Thu, 2 Dec 2021 10:17:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [driver-core:hid_is_usb 3/3] arc-elf-ld: hid-corsair.c:undefined
 reference to `usb_hid_driver'
Message-ID: <202112021000.3GKuE8mS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git hid_is_usb
head:   0a6c579f381aa88f6e8f7cd5515056416e247a2b
commit: 0a6c579f381aa88f6e8f7cd5515056416e247a2b [3/3] HID: check for valid USB device for many HID drivers
config: arc-buildonly-randconfig-r001-20211128 (https://download.01.org/0day-ci/archive/20211202/202112021000.3GKuE8mS-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?id=0a6c579f381aa88f6e8f7cd5515056416e247a2b
        git remote add driver-core https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
        git fetch --no-tags driver-core hid_is_usb
        git checkout 0a6c579f381aa88f6e8f7cd5515056416e247a2b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arc-elf-ld: drivers/hid/hid-chicony.o: in function `ch_probe':
   hid-chicony.c:(.text+0x16): undefined reference to `usb_hid_driver'
   arc-elf-ld: hid-chicony.c:(.text+0x16): undefined reference to `usb_hid_driver'
   arc-elf-ld: drivers/hid/hid-corsair.o: in function `corsair_probe':
   hid-corsair.c:(.text+0x70e): undefined reference to `usb_hid_driver'
>> arc-elf-ld: hid-corsair.c:(.text+0x70e): undefined reference to `usb_hid_driver'
   arc-elf-ld: drivers/hid/hid-lg.o: in function `lg_probe':
   hid-lg.c:(.text+0x40c): undefined reference to `usb_hid_driver'
   arc-elf-ld: drivers/hid/hid-lg.o:hid-lg.c:(.text+0x40c): more undefined references to `usb_hid_driver' follow

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

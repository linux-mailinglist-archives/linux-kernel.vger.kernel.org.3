Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB628465B4A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344226AbhLBAtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:49:19 -0500
Received: from mga01.intel.com ([192.55.52.88]:61774 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231544AbhLBAtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:49:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="260581513"
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; 
   d="scan'208";a="260581513"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 16:45:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; 
   d="scan'208";a="512945696"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 01 Dec 2021 16:45:55 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msaEV-000FaY-0h; Thu, 02 Dec 2021 00:45:55 +0000
Date:   Thu, 2 Dec 2021 08:45:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [driver-core:hid_is_usb 3/3] hppa-linux-ld: undefined reference to
 `usb_hid_driver'
Message-ID: <202112020808.AZ5usuXj-lkp@intel.com>
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
config: parisc-randconfig-r036-20211129 (https://download.01.org/0day-ci/archive/20211202/202112020808.AZ5usuXj-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?id=0a6c579f381aa88f6e8f7cd5515056416e247a2b
        git remote add driver-core https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
        git fetch --no-tags driver-core hid_is_usb
        git checkout 0a6c579f381aa88f6e8f7cd5515056416e247a2b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/hid/hid-lg.o: in function `lg_probe':
   (.text+0x9fc): undefined reference to `usb_hid_driver'
>> hppa-linux-ld: (.text+0xa04): undefined reference to `usb_hid_driver'
   hppa-linux-ld: drivers/hid/hid-samsung.o: in function `samsung_probe':
   (.text+0x18): undefined reference to `usb_hid_driver'
   hppa-linux-ld: (.text+0x1c): undefined reference to `usb_hid_driver'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E384466B68
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 22:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358342AbhLBVLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 16:11:21 -0500
Received: from mga03.intel.com ([134.134.136.65]:45085 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhLBVLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 16:11:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="236776909"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="236776909"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 13:07:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="500908993"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 02 Dec 2021 13:07:41 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mstIr-000GgS-8H; Thu, 02 Dec 2021 21:07:41 +0000
Date:   Fri, 3 Dec 2021 05:07:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [driver-core:hid_is_usb 4/4] nios2-linux-ld:
 hid-prodikeys.c:undefined reference to `usb_hid_driver'
Message-ID: <202112030506.aNZw7UPL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git hid_is_usb
head:   be29771805ee7d748ac02a0df3e1e10f5ead521f
commit: be29771805ee7d748ac02a0df3e1e10f5ead521f [4/4] HID: add USB_HID dependancy on some USB HID drivers
config: nios2-randconfig-r015-20211202 (https://download.01.org/0day-ci/archive/20211203/202112030506.aNZw7UPL-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?id=be29771805ee7d748ac02a0df3e1e10f5ead521f
        git remote add driver-core https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
        git fetch --no-tags driver-core hid_is_usb
        git checkout be29771805ee7d748ac02a0df3e1e10f5ead521f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/hid/hid-chicony.o: in function `ch_probe':
   hid-chicony.c:(.text+0x4): undefined reference to `usb_hid_driver'
   nios2-linux-ld: hid-chicony.c:(.text+0x8): undefined reference to `usb_hid_driver'
   nios2-linux-ld: drivers/hid/hid-prodikeys.o: in function `pk_probe':
   hid-prodikeys.c:(.text+0x1150): undefined reference to `usb_hid_driver'
>> nios2-linux-ld: hid-prodikeys.c:(.text+0x1154): undefined reference to `usb_hid_driver'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

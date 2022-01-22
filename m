Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893B0496E34
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 23:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiAVWXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 17:23:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:15921 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230441AbiAVWXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 17:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642890187; x=1674426187;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qwYHApND6PGB3VaMQYRpdw2IasKnIdvtLiYgQJM2hmo=;
  b=fi0aTDJNuMRJCD8U7/91L76t8LZOzQlSVtFrA4xBlVlVpRUgx0DD5yj6
   qqWF8TAWXhJAgoxBYJMikxY3Q9MyCwULsjDMuqA8OM75xFMsD2tUciW5U
   J8pWQY1KsT74zRpZXsrtfUbflGDk+u8BfRQk19lK38i/gQiKy77biflGt
   8OgZimxWDsF70QhW1QA6T6gJvq/AG5uiq9U2OW19c8bhOoC96oPyMpTmM
   zyGs30SWCeAGJlXNjFcb/fBSSvrYDVFOHZ8Mi/lpjctdHRAkEBp2FsVx4
   MKb6i7nRDKVQHoh8vRkfOY+wnxQ/hwaWPGTyeZdYKD71M9M++HYxjlDgt
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10235"; a="225833288"
X-IronPort-AV: E=Sophos;i="5.88,309,1635231600"; 
   d="scan'208";a="225833288"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2022 14:23:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,309,1635231600"; 
   d="scan'208";a="478627892"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Jan 2022 14:23:05 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBOmm-000GnS-HV; Sat, 22 Jan 2022 22:23:04 +0000
Date:   Sun, 23 Jan 2022 06:22:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Will McVicker <willmcvicker@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.19-stable
 527/9999] drivers/tty/serial/msm_geni_serial_console.c:479:6: warning:
 variable 'rx_stale' set but not used
Message-ID: <202201230619.eSYoDVW1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mukesh,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-stable
head:   90a691fca4c2525068d9908ac203e9f09e4e33c0
commit: 3b328707cf5e600683b13c9b19de3a3f22ea81e0 [527/9999] ANDROID: serial: msm_geni_serial_console : Add Earlycon support
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220123/202201230619.eSYoDVW1-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/3b328707cf5e600683b13c9b19de3a3f22ea81e0
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.19-stable
        git checkout 3b328707cf5e600683b13c9b19de3a3f22ea81e0
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/tty/serial/ mm/ sound/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/tty/serial/msm_geni_serial_console.c: In function 'msm_geni_serial_earlycon_setup':
>> drivers/tty/serial/msm_geni_serial_console.c:479:6: warning: variable 'rx_stale' set but not used [-Wunused-but-set-variable]
     479 |  u32 rx_stale = 0;
         |      ^~~~~~~~
>> drivers/tty/serial/msm_geni_serial_console.c:477:6: warning: variable 'rx_parity_cfg' set but not used [-Wunused-but-set-variable]
     477 |  u32 rx_parity_cfg = 0;
         |      ^~~~~~~~~~~~~
>> drivers/tty/serial/msm_geni_serial_console.c:476:6: warning: variable 'rx_trans_cfg' set but not used [-Wunused-but-set-variable]
     476 |  u32 rx_trans_cfg = 0;
         |      ^~~~~~~~~~~~


vim +/rx_stale +479 drivers/tty/serial/msm_geni_serial_console.c

   467	
   468	static int __init
   469	msm_geni_serial_earlycon_setup(struct earlycon_device *dev,
   470			const char *opt)
   471	{
   472		struct uart_port *uport = &dev->port;
   473		int ret = 0;
   474		u32 tx_trans_cfg = 0;
   475		u32 tx_parity_cfg = 0;
 > 476		u32 rx_trans_cfg = 0;
 > 477		u32 rx_parity_cfg = 0;
   478		u32 stop_bit = 0;
 > 479		u32 rx_stale = 0;

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B9447F447
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 20:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhLYTCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 14:02:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:35856 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232694AbhLYTCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 14:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640458968; x=1671994968;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LC/MhaNs7X+4u/hyr9yjlyShLJI2fVek4eObRmY9Z6o=;
  b=ExX+UKpasEY2p/ADRXjIS/n64Ia+gMSPoTk22/MrSU1TtPfSvRoAEAQB
   86igDsbJgbA7Jd8beUVXZwgCJJa3uGnwb3XlSc+/896u/sk7+eE8WGo4f
   Kq4YQyYBZbIR8QlcMMjfejUoiijnxSWAHxTRA5dfNY6DAIqKsRvCVdVt3
   Ow7gZ+2Wy0bzf35j6xVgHeLxogYv/pLJf1/eMicfUv7tI2qaKFRFXui1a
   fv5/mRZe++hfxlcpP8BtgotgzmXf/euxbULfN2M7G2EJwcZKFo7+kF2Fg
   Yx7lKre7xlLynp9En175kdaXbT3pvmXcO5D+gDMHxzo/bmy4P40Ow2iSk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="227903219"
X-IronPort-AV: E=Sophos;i="5.88,235,1635231600"; 
   d="scan'208";a="227903219"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2021 11:02:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,235,1635231600"; 
   d="scan'208";a="618002285"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 Dec 2021 11:02:46 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1CJa-0004cZ-7l; Sat, 25 Dec 2021 19:02:46 +0000
Date:   Sun, 26 Dec 2021 03:02:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: powerpc-linux-ld: warning: orphan section `.init.plt' from
 `drivers/platform/chrome/cros_ec_trace.o' being placed in section
 `.init.plt'
Message-ID: <202112260213.ZrEsU3Yt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b927dfc67d05a72167ab980c375ed98b2ee9c2c6
commit: d453ceb6549af8798913de6a20444cb7200fdb69 platform/chrome: sensorhub: Add trace events for sample
date:   5 months ago
config: powerpc-randconfig-r012-20211225 (https://download.01.org/0day-ci/archive/20211226/202112260213.ZrEsU3Yt-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d453ceb6549af8798913de6a20444cb7200fdb69
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d453ceb6549af8798913de6a20444cb7200fdb69
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> powerpc-linux-ld: warning: orphan section `.init.plt' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.init.plt'
>> powerpc-linux-ld: warning: orphan section `.init.plt' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.init.plt'
>> powerpc-linux-ld: warning: orphan section `.init.plt' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.init.plt'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

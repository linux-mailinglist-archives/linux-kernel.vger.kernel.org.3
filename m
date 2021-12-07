Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F145546B131
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 04:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhLGDIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 22:08:00 -0500
Received: from mga07.intel.com ([134.134.136.100]:28493 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhLGDH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 22:07:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="300863518"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="300863518"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 19:04:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="611494730"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 06 Dec 2021 19:04:27 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muQmI-000M3Y-PT; Tue, 07 Dec 2021 03:04:26 +0000
Date:   Tue, 7 Dec 2021 11:04:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: powerpc64le-linux-ld: warning: orphan section `.stubs' from
 `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.stubs'
Message-ID: <202112071027.esr07P52-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cd8c917a56f20f48748dd43d9ae3caff51d5b987
commit: d453ceb6549af8798913de6a20444cb7200fdb69 platform/chrome: sensorhub: Add trace events for sample
date:   4 months ago
config: powerpc64-buildonly-randconfig-r004-20211207 (https://download.01.org/0day-ci/archive/20211207/202112071027.esr07P52-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 11.2.0
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

>> powerpc64le-linux-ld: warning: orphan section `.stubs' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.stubs'
>> powerpc64le-linux-ld: warning: orphan section `.stubs' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.stubs'
>> powerpc64le-linux-ld: warning: orphan section `.stubs' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.stubs'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175F048CAF4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 19:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343863AbiALS12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 13:27:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:44810 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241342AbiALS1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642012044; x=1673548044;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0+NkWW6qywvtFgaGsVQbspWDwmhowFhe7mqGDdfAd/g=;
  b=iSSEZhv8LygiSjLAX8G9C0Ig2oLd9g7EUnne67/x4zYuyVpx3U2uXFQx
   g9F6++lopuBDlN460/V7nWLTWgkgwWJzGL3ejY1LjFzkaJKihpWJ24miz
   oG2meqfkWaSb6tMYBOUrzGiaeXblbmkQh/lGw+6Xu8vyoRp12qh8S+fDW
   lJR/7JBpn3Qkdpr3HUP0vlgUmcUVHJIU9URMuKc2SQ5TWk3l6kBw/pP8G
   OOfeHR2392/ol/tvVnOW0BN5hfuGMwWmiEbZwiw88d1fsmGoJQPvWS9b5
   wTr8NwaPdH3K8fP8iFGzVdJx0i4OFWb7Ba6RQxV8tpA1wrHfJZE628OMv
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="304548546"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="304548546"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 10:12:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="474998077"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 12 Jan 2022 10:12:06 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7i6Q-0006Cy-6l; Wed, 12 Jan 2022 18:12:06 +0000
Date:   Thu, 13 Jan 2022 02:11:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Stuge <peter@stuge.se>
Subject: ERROR: modpost: "__divsi3_table" [lib/lz4/lz4_compress.ko] undefined!
Message-ID: <202201130256.3TGIbq70-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   daadb3bd0e8d3e317e36bc2c1542e86c528665e5
commit: 40e1a70b4aedf2859a1829991b48ef0ebe650bf2 drm: Add GUD USB Display driver
date:   10 months ago
config: nios2-randconfig-r031-20220112 (https://download.01.org/0day-ci/archive/20220113/202201130256.3TGIbq70-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=40e1a70b4aedf2859a1829991b48ef0ebe650bf2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 40e1a70b4aedf2859a1829991b48ef0ebe650bf2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__divsi3_table" [lib/lz4/lz4_compress.ko] undefined!

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SERIAL_CORE_CONSOLE
   Depends on TTY && HAS_IOMEM
   Selected by
   - EARLY_PRINTK

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

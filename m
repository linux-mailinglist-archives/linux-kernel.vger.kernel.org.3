Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A4B488640
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 22:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiAHVUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 16:20:14 -0500
Received: from mga11.intel.com ([192.55.52.93]:25742 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229638AbiAHVUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 16:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641676812; x=1673212812;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y4UZJ4cX7OU1X3j3Ps5JxeT1lk3Rm7W0CKTCNXxPRn4=;
  b=c1U3Y4xVgur5nfWi5t7vv6rLIMDbjybim7iZ161pO1j9+r0x0k9J65cM
   AZ8MUKuM3l6JTMhnr4DzXvJkO75vGNPqsNIQo+tQ1u8u2rwe450gSUuXv
   2rAHGTh250Ave0/YSl0NKAY6uhjkhVEG2Cd1W725FDexZQtZJVYVBHsDl
   U0j6GUAa1QmO7LZcsz8aLEFQb8et2mybfWl2e9pQJD0uBiVTnfZBk9UgD
   QJl4Un4aYUXhysanLvQF5kryr6ZIk3hbNgBSMguZOJe/rjJiURBuSCyNQ
   KbXCuwcOWpZK4dYATBnSFRctKaPb9eUQrD31YRg8NLHrI8bbphOoOL4r/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="240590005"
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="240590005"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 13:20:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="669109780"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jan 2022 13:20:10 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6J8E-00014E-8h; Sat, 08 Jan 2022 21:20:10 +0000
Date:   Sun, 9 Jan 2022 05:19:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: ERROR: modpost: "__ld_r13_to_r25_ret" [lib/zstd/zstd_decompress.ko]
 undefined!
Message-ID: <202201090409.Bi3yEXiF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d1587f7bfe9a0f97a75d42ac1489aeda551106bc
commit: 7416cdc9b9c10968c57b1f73be5d48b3ecdaf3c8 lib: zstd: Don't add -O3 to cflags
date:   7 weeks ago
config: arc-randconfig-r001-20220107 (https://download.01.org/0day-ci/archive/20220109/202201090409.Bi3yEXiF-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7416cdc9b9c10968c57b1f73be5d48b3ecdaf3c8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7416cdc9b9c10968c57b1f73be5d48b3ecdaf3c8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__ld_r13_to_r25_ret" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__st_r13_to_r25" [lib/zstd/zstd_decompress.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

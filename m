Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF544809C9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 15:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhL1OAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 09:00:08 -0500
Received: from mga04.intel.com ([192.55.52.120]:45363 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhL1OAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 09:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640700007; x=1672236007;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=snmMcckc/DVmney3hsgcGSxRFMm2LSQfRnW5z2QIJxw=;
  b=myBGrSw9Nh33JnhDQCw8WiuV9+R5isUUZ3l3PRsxPiXka6H2qjfEQjZM
   smWgXjqAe4S3Unoz8+AuOdNYUT7G26FUFhNtrrIo4/XVTZxbkAuVtS/BW
   0Xz8/s+3y8HuKfbhsbK6wAHQ/tshb58nzuzh4oLpsD/pIpnxrYb/Bifzh
   TJxnYl/u6NuQTyt/cKAVdEqahtwBeJ1zRpKFOej6j4sjk6b4zYl5NUy84
   BAU3xj81OzLes+SWSC+rVv4tdCpkpc0E24kOiajz/oRivyFTgNyfftLdK
   9wMwRqU0NkslAaCYye/vM4eUpn84Y9erH5JXIB/iaF9Gul7mxTrQw9JXl
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="240151554"
X-IronPort-AV: E=Sophos;i="5.88,242,1635231600"; 
   d="scan'208";a="240151554"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 06:00:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,242,1635231600"; 
   d="scan'208";a="666023641"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Dec 2021 06:00:05 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2D1J-0007bm-5W; Tue, 28 Dec 2021 14:00:05 +0000
Date:   Tue, 28 Dec 2021 21:59:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: ERROR: modpost: "clk_set_parent"
 [sound/soc/jz4740/snd-soc-jz4740-i2s.ko] undefined!
Message-ID: <202112282120.C6LrrV0g-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a8ad9a2434dc7967ab285437f443cae633b6fc1c
commit: fc1aabb088860d6cf9dd03612b7a6f0de91ccac2 mips: lantiq: add support for clk_get_parent()
date:   6 weeks ago
config: mips-randconfig-r023-20211228 (https://download.01.org/0day-ci/archive/20211228/202112282120.C6LrrV0g-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fc1aabb088860d6cf9dd03612b7a6f0de91ccac2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout fc1aabb088860d6cf9dd03612b7a6f0de91ccac2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "clk_set_parent" [sound/soc/jz4740/snd-soc-jz4740-i2s.ko] undefined!
>> ERROR: modpost: "clk_set_parent" [sound/soc/atmel/snd-soc-atmel-i2s.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

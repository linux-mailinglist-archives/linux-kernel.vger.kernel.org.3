Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9844A477C77
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240993AbhLPTXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:23:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:58422 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236592AbhLPTXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639682628; x=1671218628;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+9UIs6DXdw/2p0SD8sm0w2yn59ctufkPEAeuZZ/z2LI=;
  b=PsP0wtkG58EvD5Dr71Fdbp3p9vUG5eT6ZKept63tCGQS870/CyUigKP4
   XglLjqPlBOYUMTmvvG/cs6dlFmVB3FqcFDrlay7F+ZTUpbwqp1BftO+4s
   3ElbzX0m3MOhmSLS2WL2Mp5F6Rdx1i82ozBHAw8xNm5m0vASKzZ7adiM4
   oZ0/qvfeEG9OZSJ+xMsUc7D+qtp5r+YxN8E/Mgoye77RTS1fpF5L4Riay
   8tZyzez1qBIpC52xXnn55xC5IDXXqwPBiAbyw0G7QR/os3v9J8J/BUBjY
   MrJpRvy0KfTCrheVr3MXzzD7iw1i1/Bb3gFBMCLtucMMFykiDpmSWWGxt
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="220257676"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="220257676"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 11:23:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="506429023"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Dec 2021 11:23:20 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxwLY-0003iS-4O; Thu, 16 Dec 2021 19:23:20 +0000
Date:   Fri, 17 Dec 2021 03:23:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [t-kristo-pm:usi-5.16-v5-bpf 16/19]
 ./usr/include/linux/bpf_hid.h:13:10: fatal error: 'linux/workqueue.h' file
 not found
Message-ID: <202112170310.bckZdCKh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/t-kristo/linux-pm usi-5.16-v5-bpf
head:   82a2c7cbd9682f2664179cd7e01647e46272c316
commit: 8ffc42bfd37f05ffa2c284b71a6c3bb5021fac8f [16/19] HID: bpf: add support for new workqueue triggering BPF call
config: x86_64-randconfig-a014-20211216 (https://download.01.org/0day-ci/archive/20211217/202112170310.bckZdCKh-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dd245bab9fbb364faa1581e4f92ba3119a872fba)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/t-kristo/linux-pm/commit/8ffc42bfd37f05ffa2c284b71a6c3bb5021fac8f
        git remote add t-kristo-pm https://github.com/t-kristo/linux-pm
        git fetch --no-tags t-kristo-pm usi-5.16-v5-bpf
        git checkout 8ffc42bfd37f05ffa2c284b71a6c3bb5021fac8f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/bpf_hid.h:13:10: fatal error: 'linux/workqueue.h' file not found
   #include <linux/workqueue.h>
            ^~~~~~~~~~~~~~~~~~~
   1 error generated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

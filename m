Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016B9472196
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhLMHSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:18:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:3461 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232453AbhLMHSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639379921; x=1670915921;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AIbbmzNZcgzxQKEzVLn/5Cw5O8pw129BW14If9H5KUY=;
  b=aatBznFdS/ue8zCU+wrj+4bI8KFRyd+xkh3gYr9OSXaaogzcv8KK5GCa
   p49nHz6uT4ebW3STXxjn/Y1wfgwFL5xT3tYLsPazOlqcT+BEKIx4AMUxm
   qU0R85zGD09n9DEhJXKZWleqQtpSth6DMYNIn1NRZnmjnsxCN5yrQPlAq
   SW5Yy3/gfXRfW9MghpRNLGTY/yMVlV5nYwNGn72JKpB+v4VGSk/oxLqcu
   D8HFk/TnfJhhavqnL1826Lu4ww9bpkZj78cMqGI5ioDnDG82viYjse1EI
   aHZgFnD6FvfncXKUN4vS39fnqwXtexsYXTa8iUSAGp24Xhq2u/6Csb7bF
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="324945400"
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="324945400"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 23:18:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="608908851"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 12 Dec 2021 23:18:39 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwfbb-0006Qd-8E; Mon, 13 Dec 2021 07:18:39 +0000
Date:   Mon, 13 Dec 2021 15:18:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [asahilinux:asahi-soc/pmgr 1/2] ERROR: modpost:
 "of_phandle_iterator_args" [drivers/soc/apple/apple-pmgr-pwrstate.ko]
 undefined!
Message-ID: <202112131521.YW7Lbttb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux asahi-soc/pmgr
head:   cc1fe1e54ba565aaec0006796db65b7c3b1ccd69
commit: 6df9d38f9146e83b473f0c9e57fb5fdf3fcc93e2 [1/2] soc: apple: Add driver for Apple PMGR power state controls
config: arm64-randconfig-r006-20211213 (https://download.01.org/0day-ci/archive/20211213/202112131521.YW7Lbttb-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/AsahiLinux/linux/commit/6df9d38f9146e83b473f0c9e57fb5fdf3fcc93e2
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux asahi-soc/pmgr
        git checkout 6df9d38f9146e83b473f0c9e57fb5fdf3fcc93e2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "of_phandle_iterator_args" [drivers/soc/apple/apple-pmgr-pwrstate.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

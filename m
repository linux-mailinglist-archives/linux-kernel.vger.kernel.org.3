Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB461479B69
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 15:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbhLROfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 09:35:51 -0500
Received: from mga01.intel.com ([192.55.52.88]:19477 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230522AbhLROfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 09:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639838150; x=1671374150;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SCVDBzyKX6F1AI1mGQL5GjvCKYXu3dtpUA3OC8P2Dig=;
  b=ThqVMb30b2IsDVVZZ4JXIcsl66Cg5V2hnLw02yM/+wQMEiwjQD009fuK
   g3Fwvp9T9CfBZzEbIP6iIBG/Emg1BvNh5ZIWG6VULD2pqEUbHluy7Dj0Q
   cUQrKBXkWGB63Wn0KnfOVuCTdczagu4e2WbifSDevL/uY1bCqlSI6mpBM
   fc+GZoxF1fauZrOrSY5V53qq3kw+JvP/j4QQjaiFkv8t+gOG/k0gbZYny
   aneFNM2e8tib7S8vH3mXKpXUy4+nU2hXOewbF4SxpM+QzDNNQMTF4FFHz
   64wfAzjImEhbDuGRl0ZTP9/HbvKyUUwT4OwMAyOFiZtuUQwGN9sU+hOv3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="264107662"
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="264107662"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 06:35:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="546716207"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 18 Dec 2021 06:35:49 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myaoO-00067b-BJ; Sat, 18 Dec 2021 14:35:48 +0000
Date:   Sat, 18 Dec 2021 22:34:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:asahi 30/63] apple-rtkit.c:undefined reference to
 `mbox_free_channel'
Message-ID: <202112182234.4VC4iNXD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux asahi
head:   b63c1083b20eefa3b23180ae57e1919c723f7d86
commit: 34c1be37ea53de482315de47fb1a82e02f7bf9f9 [30/63] WIP: soc: apple: rtkit: Add RTKit library
config: arm64-randconfig-p002-20211218 (https://download.01.org/0day-ci/archive/20211218/202112182234.4VC4iNXD-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/34c1be37ea53de482315de47fb1a82e02f7bf9f9
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux asahi
        git checkout 34c1be37ea53de482315de47fb1a82e02f7bf9f9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> aarch64-linux-ld: Unexpected GOT/PLT entries detected!
>> aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: Entry trampoline text too big
   aarch64-linux-ld: drivers/soc/apple/apple-rtkit.o: in function `apple_rtkit_boot_abort':
>> apple-rtkit.c:(.text+0x28): undefined reference to `mbox_free_channel'
   aarch64-linux-ld: drivers/soc/apple/apple-rtkit.o: in function `apple_rtkit_send_message':
>> apple-rtkit.c:(.text+0x164): undefined reference to `mbox_send_message'
   aarch64-linux-ld: drivers/soc/apple/apple-rtkit.o: in function `apple_rtkit_init':
>> apple-rtkit.c:(.text+0xcec): undefined reference to `mbox_request_channel_byname'
>> aarch64-linux-ld: apple-rtkit.c:(.text+0xd70): undefined reference to `mbox_request_channel'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

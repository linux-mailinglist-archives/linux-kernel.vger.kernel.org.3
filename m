Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9664859DD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 21:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243941AbiAEUOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 15:14:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:14058 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243914AbiAEUN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 15:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641413636; x=1672949636;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1aVZWQN7vUSHKq9BFGWAoGVZDtXwaTtida2nDnEmvEE=;
  b=Ka72yznCbYkKI73CwYVsO2W17u6fB+84P1gry9KIakswL8iRqWknLGOR
   eWEsJQ1CTp1zOiYozqfWWZJrLFQ5PEMHsXKapKPdZYOyrdFM5nZnWTCnl
   SF24+u1Yz9h74DolC5DUfY9W935VsdgC3UHCvX3ssyXPaYH99DwIx9bm2
   yYb4yE2V55Dn693Rpfab+5zj5rUAdHYLNPNhvpR7Z7uQPyqTCPRvSVFaR
   cTfQ4ZwZ+Ab8gQh0omDL/F8Qj1OTz3CoZsj/dy+/xSWR5QgCHS1sYv8tK
   BuBZfkmZIA8gB0ZmFdZV+5bnZbhhFjt91mSh8AxLO83++WVnqrwm1m72k
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="303280169"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="303280169"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 12:13:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="470698443"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Jan 2022 12:13:53 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5CfQ-000H0b-VO; Wed, 05 Jan 2022 20:13:52 +0000
Date:   Thu, 6 Jan 2022 04:13:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [chenxing:msc313_mainlining 85/86] Error:
 arch/arm/boot/dts/mstar-infinity2m-ssd201-wirelesstag-ido-som2d01.dtsi:18.1-9
 Label or path pm_uart not found
Message-ID: <202201060459.ALRhCSGK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/linux-chenxing/linux.git msc313_mainlining
head:   2269f75a5b53b9a05d21d432ad75f5e41b344814
commit: 7bf46c9e0566d3046584d7fed53d1587c316fde5 [85/86] ARM: dts: mstar: Add top level dts for ssd201-som2d01
config: arm-buildonly-randconfig-r001-20220105 (https://download.01.org/0day-ci/archive/20220106/202201060459.ALRhCSGK-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/linux-chenxing/linux/commit/7bf46c9e0566d3046584d7fed53d1587c316fde5
        git remote add chenxing git://github.com/linux-chenxing/linux.git
        git fetch --no-tags chenxing msc313_mainlining
        git checkout 7bf46c9e0566d3046584d7fed53d1587c316fde5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/mstar-infinity2m-ssd201-wirelesstag-ido-som2d01.dtsi:18.1-9 Label or path pm_uart not found
>> FATAL ERROR: Syntax error parsing input tree

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

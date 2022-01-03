Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0E54838F4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 00:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiACXDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 18:03:21 -0500
Received: from mga04.intel.com ([192.55.52.120]:57737 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230343AbiACXDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 18:03:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641250999; x=1672786999;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3IMir7bHq3FA6eo0MQd9Rr+HvDz01+2BDkL6zkQgisE=;
  b=dlJqyL/gi5lMIBplE/IgNjJGjckDukuwdGYM2GuGIzM7FAqJkXUIvdQ9
   J+sPfIpE17VlSfw4a0lVDmDB6GAsKclKFCe4UY8yWF+FTrOyt3RPG0D8m
   dlKDB/dVuK2tKq/FaOR8OY3mc+lNsqw+/yi5TdG9BqvcYZCshBhincYBn
   ySgpug0G0V1/anAWo4aaLbi0DcKDUItkVZA8Ht+iQDME//SLrdL8cGjX2
   OCdXYoMYd56hobvw+pbeJ9kFkY0YlqMRy41ME6chDkkqfETinqOvzP0+m
   2or8DLkgHndtXj5NLS7Q8B87wO07P3YIguzvoXcISuW+kP36MtcBLi/cZ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="240947441"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="240947441"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 15:03:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="471790208"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Jan 2022 15:03:17 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4WMH-000EU9-1q; Mon, 03 Jan 2022 23:03:17 +0000
Date:   Tue, 4 Jan 2022 07:02:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [chenxing:msc313_mainlining 85/86] Error:
 arch/arm/boot/dts/mstar-infinity2m-ssd201-wirelesstag-ido-som2d01.dtsi:18.1-9
 Label or path pm_uart not found
Message-ID: <202201040602.CbRBg9gS-lkp@intel.com>
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
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220104/202201040602.CbRBg9gS-lkp@intel.com/config)
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
   FATAL ERROR: Syntax error parsing input tree

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

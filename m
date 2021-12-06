Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E884F46A3B5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346242AbhLFSFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:05:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:12523 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240373AbhLFSFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:05:15 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="218055149"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="218055149"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 10:01:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="461928374"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 06 Dec 2021 10:01:14 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muIIb-000LYj-Mb; Mon, 06 Dec 2021 18:01:13 +0000
Date:   Tue, 7 Dec 2021 02:00:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [chenxing:msc313_mainlining 40/73]
 drivers/pinctrl/mstar/pinctrl-msc313-pm.c:35:27: warning: unused variable
 'pm_uart_groups'
Message-ID: <202112070109.hEWDj0ar-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/linux-chenxing/linux.git msc313_mainlining
head:   4c9fe2eaf0fcfd50fbd5abafd740731257f5a8d6
commit: 321b224e4ea050bdf9043a0ee577448ed3233bc7 [40/73] pinctrl: mstar: msc313 pinctrl driver
config: arm-randconfig-r005-20211205 (https://download.01.org/0day-ci/archive/20211207/202112070109.hEWDj0ar-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f1d1854eb1450d352663ee732235893c5782237)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/linux-chenxing/linux/commit/321b224e4ea050bdf9043a0ee577448ed3233bc7
        git remote add chenxing git://github.com/linux-chenxing/linux.git
        git fetch --no-tags chenxing msc313_mainlining
        git checkout 321b224e4ea050bdf9043a0ee577448ed3233bc7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/pinctrl/mstar/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/mstar/pinctrl-msc313-pm.c:35:27: warning: unused variable 'pm_uart_groups' [-Wunused-const-variable]
   static const char * const pm_uart_groups[] = {
                             ^
>> drivers/pinctrl/mstar/pinctrl-msc313-pm.c:39:27: warning: unused variable 'pm_spi_groups' [-Wunused-const-variable]
   static const char * const pm_spi_groups[] = {
                             ^
>> drivers/pinctrl/mstar/pinctrl-msc313-pm.c:43:27: warning: unused variable 'pm_irin_groups' [-Wunused-const-variable]
   static const char * const pm_irin_groups[] = {
                             ^
   3 warnings generated.


vim +/pm_uart_groups +35 drivers/pinctrl/mstar/pinctrl-msc313-pm.c

acfcb56b8544d2 Daniel Palmer 2021-01-10  34  
acfcb56b8544d2 Daniel Palmer 2021-01-10 @35  static const char * const pm_uart_groups[] = {
acfcb56b8544d2 Daniel Palmer 2021-01-10  36  	GROUPNAME_PM_UART,
acfcb56b8544d2 Daniel Palmer 2021-01-10  37  };
acfcb56b8544d2 Daniel Palmer 2021-01-10  38  
acfcb56b8544d2 Daniel Palmer 2021-01-10 @39  static const char * const pm_spi_groups[] = {
acfcb56b8544d2 Daniel Palmer 2021-01-10  40  	GROUPNAME_PM_SPI,
acfcb56b8544d2 Daniel Palmer 2021-01-10  41  };
acfcb56b8544d2 Daniel Palmer 2021-01-10  42  
acfcb56b8544d2 Daniel Palmer 2021-01-10 @43  static const char * const pm_irin_groups[] = {
acfcb56b8544d2 Daniel Palmer 2021-01-10  44  	GROUPNAME_PM_IRIN,
acfcb56b8544d2 Daniel Palmer 2021-01-10  45  };
acfcb56b8544d2 Daniel Palmer 2021-01-10  46  

:::::: The code at line 35 was first introduced by commit
:::::: acfcb56b8544d28d329b493d3c74542f857f60b3 pinctrl: mstar: msc313 pm pinctrl driver

:::::: TO: Daniel Palmer <daniel@0x0f.com>
:::::: CC: Daniel Palmer <daniel@0x0f.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

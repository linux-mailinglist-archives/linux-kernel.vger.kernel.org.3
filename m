Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B12497B08
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242364AbiAXJHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:07:33 -0500
Received: from mga17.intel.com ([192.55.52.151]:37923 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242260AbiAXJH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643015247; x=1674551247;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YmzdN2bIsA0xpAKAgJhy2hbELF6dLcDthdX7FVNDJ2U=;
  b=KOfhTf1vlCxEVXGsA9SrRxX4f5oGo1qvxRZ8pZntLTuvLg6gbXyKqlwe
   MirrKK94QgBmJ6/VdlJkud/0j79ZvZvvMJl7f/9KBUkk2aOyDYyygj7DU
   KvBS3k6isyXJ5T0+wm0DflOGm2Zl4zZAp/s+zyLxlOImLziHx1TinA/II
   xgCNi0N1+mwAzlC/CFzANsKtX8Q6Zo5IKlurv/EhKsAyqWvz/5UTJ64Oa
   hfODe272TBFDpurmdHqDhN2RVOpZ31S4b4016zTTk43D/zRiSVHjQZB/6
   10Wr9jTYdQ3UOWv2fkWIiWgJ8AQxGNlZ9HzOZwx9ZSrvICjzv8QKSUQ1b
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="226673876"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="226673876"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 01:07:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="624017976"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jan 2022 01:07:25 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBvJt-000I54-0J; Mon, 24 Jan 2022 09:07:25 +0000
Date:   Mon, 24 Jan 2022 17:07:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [chenxing:msc313_mainlining 82/90]
 drivers/gpio/gpio-msc313-pm.c:90:11: warning: initialization discards
 'const' qualifier from pointer target type
Message-ID: <202201241610.bOsvsExd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/linux-chenxing/linux.git msc313_mainlining
head:   95bf95e262689705ba9f678bb9d61c0430b1d12c
commit: b2498532eaf18ca377ffdad0364c3f5eb39185a7 [82/90] gpio: msc313: MStar MSC313 PM GPIO driver
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220124/202201241610.bOsvsExd-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/linux-chenxing/linux/commit/b2498532eaf18ca377ffdad0364c3f5eb39185a7
        git remote add chenxing git://github.com/linux-chenxing/linux.git
        git fetch --no-tags chenxing msc313_mainlining
        git checkout b2498532eaf18ca377ffdad0364c3f5eb39185a7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpio/gpio-msc313-pm.c:90:11: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      90 | CHIP_DATA(msc313);
         |           ^~~~~~
   drivers/gpio/gpio-msc313-pm.c:72:26: note: in definition of macro 'CHIP_DATA'
      72 |                 .names = chipname##_names,\
         |                          ^~~~~~~~


vim +/const +90 drivers/gpio/gpio-msc313-pm.c

    89	
  > 90	CHIP_DATA(msc313);
    91	#endif /* infinity */
    92	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

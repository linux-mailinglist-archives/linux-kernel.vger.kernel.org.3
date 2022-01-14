Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5949948E1B9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 01:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbiANAr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 19:47:28 -0500
Received: from mga07.intel.com ([134.134.136.100]:29285 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbiANAr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 19:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642121248; x=1673657248;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nG4HRJHAoVChSdrA7YfUThhGqm64uQvf4SjHfzChLu4=;
  b=OiY7B3enkLtmW2WpH9Xx1+HG4WMTwxrfknPRImMuKETWbXYuTZZXVfXE
   asu042Kfd8dPfdhXZfo8wlKTFQTae1V2MCCXtw7r6FmI0A91hPojHmddJ
   lIq3KpwWbDUTJdkRjlthayQyaiRdkuJBnJLetyrSGxhiu7prvQsscWuJV
   DVDBz0HVsziVWEpGvGPZ61CD89Fbl/bt7O/g+sUsRwXmZ0SVhXD0O13cn
   Lx0p+f0csfx/RaTem0KzHwjkC/rq+wU47qLu+VCmXRUJRgLBw+qAh6w7D
   QsNiX5IB3I16a00i2gFFpeeQfPpucVIMvD+P6fK0xXvN1RqadEXKhWP6B
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="307495129"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="307495129"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 16:47:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="559305514"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Jan 2022 16:47:15 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8AkN-0007py-7l; Fri, 14 Jan 2022 00:47:15 +0000
Date:   Fri, 14 Jan 2022 08:46:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [ardb:for-kernelci 7/32] undefined reference to
 `generic_handle_arch_irq'
Message-ID: <202201140816.NP44eEC3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git for-kernelci
head:   852d1768db03fbc19f5bd643d2e4c8f34c4343a2
commit: 67375b8991dfdaee8738584a1621a47d27b5a9b7 [7/32] ARM: remove old-style irq entry
config: arm-randconfig-s031-20220113 (https://download.01.org/0day-ci/archive/20220114/202201140816.NP44eEC3-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=67375b8991dfdaee8738584a1621a47d27b5a9b7
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb for-kernelci
        git checkout 67375b8991dfdaee8738584a1621a47d27b5a9b7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: arch/arm/kernel/entry-armv.o: in function `__irq_svc':
>> (.entry.text+0x120): undefined reference to `generic_handle_arch_irq'
   arm-linux-gnueabi-ld: arch/arm/kernel/entry-armv.o: in function `__irq_usr':
   (.entry.text+0x3ec): undefined reference to `generic_handle_arch_irq'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

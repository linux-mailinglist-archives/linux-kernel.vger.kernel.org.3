Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54123486385
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 12:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbiAFLLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 06:11:15 -0500
Received: from mga02.intel.com ([134.134.136.20]:45908 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238304AbiAFLLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 06:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641467474; x=1673003474;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pRxGZic71BOxqn8qKdxkMUjgBeOF6SFtA8ONOF0q13o=;
  b=MxgVOo/CwvM3xduiJmHGZ1lhZii4Nwg8uOG8o3cNbUGxdGiq7A8VY+tH
   1zu/JKWd/T5xBYHo7yh9eRK5wBH4VSslXQtsOMwhb/wKBZcOfliZqRfP1
   JvIAP5KJd82Ondtv/6LkITZMGFpNWu4Yu51fBTOJ9XnXkyPB9azzrMR/P
   4wktkVMonlvyAJoFFgVVYHGMqz5ayIIWaYKTVsTFHDjUxv4ThioRoH1S+
   eTF7LGpRHIiDHzbVZm5LEd081NWW0EwWpdnpSyC1vUTTd83b5GVcACH+Y
   l1xkYI+tIYpTuG7gFpSVW1E+G1JYS6+qLO0nTdTz/aoLNR94l6X8bbBfh
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229966205"
X-IronPort-AV: E=Sophos;i="5.88,266,1635231600"; 
   d="scan'208";a="229966205"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 03:11:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,266,1635231600"; 
   d="scan'208";a="472852766"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Jan 2022 03:11:12 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5Qfo-000HaU-A3; Thu, 06 Jan 2022 11:11:12 +0000
Date:   Thu, 6 Jan 2022 19:10:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:nvme/dev 18/18] apple.c:undefined reference to
 `apple_sart_remove_allowed_region'
Message-ID: <202201061938.mkpqWe1k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux nvme/dev
head:   95d74d28463059dbd4d9cf8e62a2ea0a71d15d06
commit: 95d74d28463059dbd4d9cf8e62a2ea0a71d15d06 [18/18] WIP: nvme-apple: add initial Apple SoC NVMe driver
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20220106/202201061938.mkpqWe1k-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/95d74d28463059dbd4d9cf8e62a2ea0a71d15d06
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux nvme/dev
        git checkout 95d74d28463059dbd4d9cf8e62a2ea0a71d15d06
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_sart_dma_free':
>> apple.c:(.text+0x6d0): undefined reference to `apple_sart_remove_allowed_region'
   s390-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_sart_dma_alloc':
>> apple.c:(.text+0x7d2): undefined reference to `apple_sart_add_allowed_region'
   s390-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_probe':
>> apple.c:(.text+0x23aa): undefined reference to `apple_sart_get'
   s390-linux-ld: apple.c:(.text+0x2852): undefined reference to `devm_apple_rtkit_init'
   s390-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_disable':
>> apple.c:(.text+0x431c): undefined reference to `apple_rtkit_is_crashed'
   s390-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_shutdown':
>> apple.c:(.text+0x479a): undefined reference to `apple_rtkit_is_running'
   s390-linux-ld: apple.c:(.text+0x47ce): undefined reference to `apple_rtkit_shutdown'
   s390-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_remove':
   apple.c:(.text+0x4894): undefined reference to `apple_rtkit_is_running'
   s390-linux-ld: apple.c:(.text+0x48c8): undefined reference to `apple_rtkit_shutdown'
   s390-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_timeout':
   apple.c:(.text+0x4bac): undefined reference to `apple_rtkit_is_crashed'
   s390-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_reset_work':
   apple.c:(.text+0x4ef2): undefined reference to `apple_rtkit_is_crashed'
   s390-linux-ld: apple.c:(.text+0x4fae): undefined reference to `apple_rtkit_is_running'
   s390-linux-ld: apple.c:(.text+0x50cc): undefined reference to `apple_rtkit_shutdown'
   s390-linux-ld: apple.c:(.text+0x5106): undefined reference to `apple_rtkit_reinit'
   s390-linux-ld: apple.c:(.text+0x51dc): undefined reference to `apple_rtkit_boot'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD4D4959BC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 07:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348804AbiAUGGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 01:06:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:64902 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234118AbiAUGGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:06:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642745197; x=1674281197;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aogatRpN0+7y/WsY4/r/3WuGHAqSWznFO2Wj//v+cRU=;
  b=eQ7Fk0o3HIBmkvK/UTY5nrQpbt01x2FaepGHLqA1cYBrdRnYygPRyBno
   e1AUdkApWRQnIGLziuPwyQaCRVkO7dXgW3YoP6FTPTXRreop9+spJ5VJK
   Euj/DHLrZVu/wzqm5AXKz97GKeF5CRi64FsuSmbWSNd8+UgHxAWzhRiPF
   fSHh4zijFXz+8N+eF3rBKrGIIt0afuUwrE6CsMXs52PyPQM8r/RGtbMuw
   vfF13ndRlBWQ6Q31ORTLmHMW13qJ9AlnbhF4TUy2C71P36VEZ/AVyLFLC
   Efr/kYJJ9C3cpGlsid23/s2iYYo/3y8bG7I6k+j/8VRE62EDh8KaI3zF6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="243168976"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="243168976"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 22:06:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="579496500"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jan 2022 22:06:34 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAn4D-000EzC-FN; Fri, 21 Jan 2022 06:06:33 +0000
Date:   Fri, 21 Jan 2022 14:06:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [ardb:for-kernelci 10/36] undefined reference to
 `generic_handle_arch_irq'
Message-ID: <202201211358.6poBspsr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git for-kernelci
head:   5370dd921360db999b1a1de514945e83b6abbf22
commit: 4ac1707c32a60783207ce699e5f29d39be7d91c1 [10/36] ARM: remove old-style irq entry
config: arm-randconfig-c002-20220118 (https://download.01.org/0day-ci/archive/20220121/202201211358.6poBspsr-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=4ac1707c32a60783207ce699e5f29d39be7d91c1
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb for-kernelci
        git checkout 4ac1707c32a60783207ce699e5f29d39be7d91c1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: arch/arm/kernel/entry-armv.o: in function `__irq_svc':
>> (.entry.text+0xf4): undefined reference to `generic_handle_arch_irq'
   arm-linux-gnueabi-ld: arch/arm/kernel/entry-armv.o: in function `__irq_usr':
   (.entry.text+0x3a0): undefined reference to `generic_handle_arch_irq'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

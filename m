Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B1D49A816
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1316297AbiAYCzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:55:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:6167 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S3413644AbiAYAjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643071176; x=1674607176;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RkpYEPfF7bArgAh5McSlrTbYd3M7mMqu9dUInBEThIc=;
  b=B7hM2jrWv29ypfNYB2mAF5OGmBJXuA/Tx91AB2JJWHCmzCPfI9IVUl9H
   mz6o/OH5bBK63b5PIOK6IyF69QWyF3eex/qL/0NC8JZ0GlB1ZSvZjnk2f
   zPPruhGlenXQF8Fc2F+zPga9J8/gMEtSiW3VhpJJNBjru5vqxen6rrbXE
   CLC1v1usEp8F6efC9XR1++O9cbk7trAmmOUOXDWGELneUO9u5DmQTyPXi
   kF4DqRv5lHvOkvRGY61TKueUPMFZY939AQkkTphAkImJeQllttxFmhdZe
   88pOzYH9/F0OkdZzGMZyRvS5y7K87jK21nC1KIcvrzQtWIw/IW/5JJ5TH
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="332536821"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="332536821"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 16:27:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="768849518"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jan 2022 16:27:15 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nC9g2-000J6v-DD; Tue, 25 Jan 2022 00:27:14 +0000
Date:   Tue, 25 Jan 2022 08:26:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2259/2384]
 arch/mips/include/asm/sgi/heart.h:321:25: error: implicit declaration of
 function '____raw_writeq'
Message-ID: <202201250737.EsYDONpH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: a589a381615b4e9581c08e10c86d4fc56bd817ea [2259/2384] headers/deps: irq: Optimize <linux/interrupt.h> dependencies
config: mips-randconfig-m031-20220124 (https://download.01.org/0day-ci/archive/20220125/202201250737.EsYDONpH-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=a589a381615b4e9581c08e10c86d4fc56bd817ea
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout a589a381615b4e9581c08e10c86d4fc56bd817ea
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/sgi-ip30/ drivers/media/test-drivers/vidtv/ drivers/usb/chipidea/ drivers/usb/usbip/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/mips/sgi-ip30/ip30-power.c:21:
   arch/mips/sgi-ip30/ip30-power.c: In function 'ip30_machine_restart':
>> arch/mips/include/asm/sgi/heart.h:321:25: error: implicit declaration of function '____raw_writeq' [-Werror=implicit-function-declaration]
     321 | #define heart_write     ____raw_writeq
         |                         ^~~~~~~~~~~~~~
   arch/mips/sgi-ip30/ip30-power.c:29:9: note: in expansion of macro 'heart_write'
      29 |         heart_write((heart_read(&heart_regs->mode) | HM_COLD_RST),
         |         ^~~~~~~~~~~
>> arch/mips/include/asm/sgi/heart.h:320:25: error: implicit declaration of function '____raw_readq' [-Werror=implicit-function-declaration]
     320 | #define heart_read      ____raw_readq
         |                         ^~~~~~~~~~~~~
   arch/mips/sgi-ip30/ip30-power.c:29:22: note: in expansion of macro 'heart_read'
      29 |         heart_write((heart_read(&heart_regs->mode) | HM_COLD_RST),
         |                      ^~~~~~~~~~
   cc1: some warnings being treated as errors
--
>> drivers/usb/usbip/vhci_hcd.c:287:43: error: implicit declaration of function 'ilog2' [-Werror=implicit-function-declaration]
     287 |                 .bFunctionalitySupport  = ilog2(USB_5GBPS_OPERATION),
         |                                           ^~~~~
>> drivers/usb/usbip/vhci_hcd.c:287:43: error: initializer element is not constant
   drivers/usb/usbip/vhci_hcd.c:287:43: note: (near initialization for 'usb3_bos_desc.ss_cap.bFunctionalitySupport')
   cc1: some warnings being treated as errors


vim +/____raw_writeq +321 arch/mips/include/asm/sgi/heart.h

7505576d1c1ac0 Thomas Bogendoerfer 2019-10-24  319  
7505576d1c1ac0 Thomas Bogendoerfer 2019-10-24 @320  #define heart_read	____raw_readq
7505576d1c1ac0 Thomas Bogendoerfer 2019-10-24 @321  #define heart_write	____raw_writeq
7505576d1c1ac0 Thomas Bogendoerfer 2019-10-24  322  

:::::: The code at line 321 was first introduced by commit
:::::: 7505576d1c1ac0cfe85fdf90999433dd8b673012 MIPS: add support for SGI Octane (IP30)

:::::: TO: Thomas Bogendoerfer <tbogendoerfer@suse.de>
:::::: CC: Paul Burton <paulburton@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

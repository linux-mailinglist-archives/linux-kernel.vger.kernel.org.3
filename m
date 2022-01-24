Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E77498E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 20:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345451AbiAXTnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 14:43:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:30783 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352906AbiAXTbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 14:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643052675; x=1674588675;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q1Bhf6Ww5I5xdm+fU1OBOpYVFdM2uPYEpZ7nHNC3PiA=;
  b=Lexm2id+2HKUofb3FzC+8ASFmdnxltByiQGu2JWZ6NyK9v/EHR/iinwm
   P2NwOS5rl7dHKS7YDQs1YDCqUaRbvUYf+Ox41nRKF5wzINJCKsFXy5T81
   i7Us3SbEFurTkXvTjDLLYmvMr7jqs1OG8v3pgav4hkhSCPuAEFYrHgA3Y
   9TZ3X3+MOxyVubYXzA4lQPajdEcdUfMZgwBR/zwkXizmdZb48vTM6RcPA
   lVvX4v8cJHOcF9V97Dtq8cYySXbc+l7EJxjWyTLc9/YCmtQ/j9dMATXYu
   C+25wX7rgza673rcynPXZo2m3DrSAF1JD/XakW8c8PpJMBwn0x+/DjiiJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226108566"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="226108566"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 11:25:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="476834099"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2022 11:25:03 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nC4xa-000IoL-Nn; Mon, 24 Jan 2022 19:25:02 +0000
Date:   Tue, 25 Jan 2022 03:24:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2040/2384]
 arch/mips/sgi-ip30/ip30-setup.c:136:9: error: 'ioport_resource' undeclared
Message-ID: <202201250357.V6BlaZ0J-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: abe1ece6c06895bf5e7c8f03d10061f5712d8326 [2040/2384] headers/deps: dev/core: Optimize <linux/device.h> dependencies, remove <linux/device_api.h> inclusion
config: mips-randconfig-m031-20220124 (https://download.01.org/0day-ci/archive/20220125/202201250357.V6BlaZ0J-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=abe1ece6c06895bf5e7c8f03d10061f5712d8326
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout abe1ece6c06895bf5e7c8f03d10061f5712d8326
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/pci/ arch/mips/sgi-ip30/ drivers/media/test-drivers/vidtv/ drivers/usb/chipidea/ drivers/usb/usbip/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/mips/sgi-ip30/ip30-setup.c:123:13: warning: no previous prototype for 'plat_mem_setup' [-Wmissing-prototypes]
     123 | void __init plat_mem_setup(void)
         |             ^~~~~~~~~~~~~~
   arch/mips/sgi-ip30/ip30-setup.c: In function 'plat_mem_setup':
>> arch/mips/sgi-ip30/ip30-setup.c:136:9: error: 'ioport_resource' undeclared (first use in this function)
     136 |         ioport_resource.start = 0;
         |         ^~~~~~~~~~~~~~~
   arch/mips/sgi-ip30/ip30-setup.c:136:9: note: each undeclared identifier is reported only once for each function it appears in


vim +/ioport_resource +136 arch/mips/sgi-ip30/ip30-setup.c

7505576d1c1ac0 Thomas Bogendoerfer 2019-10-24  135  
7505576d1c1ac0 Thomas Bogendoerfer 2019-10-24 @136  	ioport_resource.start = 0;

:::::: The code at line 136 was first introduced by commit
:::::: 7505576d1c1ac0cfe85fdf90999433dd8b673012 MIPS: add support for SGI Octane (IP30)

:::::: TO: Thomas Bogendoerfer <tbogendoerfer@suse.de>
:::::: CC: Paul Burton <paulburton@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

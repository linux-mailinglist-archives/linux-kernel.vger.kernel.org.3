Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC0649AB69
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390748AbiAYEwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:52:02 -0500
Received: from mga17.intel.com ([192.55.52.151]:10061 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S254077AbiAYEfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 23:35:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643085336; x=1674621336;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=btpSsofGXMb//G1HnIaGfv9hthpngTmm6P9YloCibIM=;
  b=hjAsUs4NhDYcpF7hdbRfaEhby1kDUsKSrOqK7EE90ja3uncrHr8FQ5n5
   SbMYtFSYPcTf5txhg8IOt+qO0Mju7sZDay5v0W6NRuNkYZAZtexlqWArG
   /zyD2Aq77l6NIG5h4mxV4z22ULOtZ+oQHzTea+1mq4mAk+9QvMC6f0FsP
   LHgj0d/WY+vK24+4pZ80Se50ETu2AWRMJ1GCAbHSfpzKESTdcRb0WM24g
   C6e6MzfufZrybeATc19RcHuuyeIP5y+JaZqUFHUJ6Co10O9FxbOjgszTF
   YeoSrAtFadNHCwDtjT671osfWGewhwS/VCyRXh1wgeaZZIvgd4d7HQWBm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226886255"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="226886255"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 20:30:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="768899550"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jan 2022 20:30:23 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCDTK-000JMB-Gj; Tue, 25 Jan 2022 04:30:22 +0000
Date:   Tue, 25 Jan 2022 12:29:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2357/2384]
 drivers/usb/chipidea/ci.h:427:32: error: implicit declaration of function
 '__ffs'
Message-ID: <202201251220.wdEh9zG4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: 61ea5a6fab5c8fae043a02a100970041dc6a877e [2357/2384] headers/deps: delay: Optimize <linux/delay.h> dependencies, remove <linux/sched.h> inclusion
config: mips-randconfig-m031-20220124 (https://download.01.org/0day-ci/archive/20220125/202201251220.wdEh9zG4-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=61ea5a6fab5c8fae043a02a100970041dc6a877e
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 61ea5a6fab5c8fae043a02a100970041dc6a877e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/usb/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/usb/chipidea/otg.c:23:
   drivers/usb/chipidea/ci.h: In function 'hw_test_and_write':
>> drivers/usb/chipidea/ci.h:427:32: error: implicit declaration of function '__ffs' [-Werror=implicit-function-declaration]
     427 |         return (val & mask) >> __ffs(mask);
         |                                ^~~~~
   cc1: some warnings being treated as errors


vim +/__ffs +427 drivers/usb/chipidea/ci.h

e443b333629f82 Alexander Shishkin 2012-05-11  411  
e443b333629f82 Alexander Shishkin 2012-05-11  412  /**
e443b333629f82 Alexander Shishkin 2012-05-11  413   * hw_test_and_write: tests & writes a hw register
19353881b4afc9 Peter Chen         2014-09-22  414   * @ci: the controller
e443b333629f82 Alexander Shishkin 2012-05-11  415   * @reg:  register index
e443b333629f82 Alexander Shishkin 2012-05-11  416   * @mask: bitfield mask
e443b333629f82 Alexander Shishkin 2012-05-11  417   * @data: new value
e443b333629f82 Alexander Shishkin 2012-05-11  418   *
e443b333629f82 Alexander Shishkin 2012-05-11  419   * This function returns register contents
e443b333629f82 Alexander Shishkin 2012-05-11  420   */
8e22978c57087a Alexander Shishkin 2013-06-24  421  static inline u32 hw_test_and_write(struct ci_hdrc *ci, enum ci_hw_regs reg,
e443b333629f82 Alexander Shishkin 2012-05-11  422  				    u32 mask, u32 data)
e443b333629f82 Alexander Shishkin 2012-05-11  423  {
26c696c678c4ce Richard Zhao       2012-07-07  424  	u32 val = hw_read(ci, reg, ~0);
e443b333629f82 Alexander Shishkin 2012-05-11  425  
26c696c678c4ce Richard Zhao       2012-07-07  426  	hw_write(ci, reg, mask, data);
727b4ddb48dcd8 Felipe Balbi       2013-03-30 @427  	return (val & mask) >> __ffs(mask);
e443b333629f82 Alexander Shishkin 2012-05-11  428  }
e443b333629f82 Alexander Shishkin 2012-05-11  429  

:::::: The code at line 427 was first introduced by commit
:::::: 727b4ddb48dcd8c9ca81b58ca58191233bdf75aa usb: chipidea: don't redefine __ffs()

:::::: TO: Felipe Balbi <balbi@ti.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

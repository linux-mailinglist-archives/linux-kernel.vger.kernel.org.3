Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062DA4673BC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379450AbhLCJQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:16:34 -0500
Received: from mga07.intel.com ([134.134.136.100]:61721 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243758AbhLCJQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:16:28 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="300329317"
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="300329317"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 01:13:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="610330849"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 03 Dec 2021 01:13:02 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mt4cn-000HJh-RL; Fri, 03 Dec 2021 09:13:01 +0000
Date:   Fri, 3 Dec 2021 17:12:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, wells.lu@sunplus.com,
        tony.huang@sunplus.com, Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: Re: [PATCH v2 2/2] misc: Add iop driver for Sunplus SP7021
Message-ID: <202112031753.KIjg9ffN-lkp@intel.com>
References: <9bb79f74ff1b08a5f9a1f6707b3b41484506468a.1638499659.git.tonyhuang.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bb79f74ff1b08a5f9a1f6707b3b41484506468a.1638499659.git.tonyhuang.sunplus@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

I love your patch! Yet something to improve:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on robh/for-next soc/for-next linus/master v5.16-rc3 next-20211202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Tony-Huang/Add-iop-driver-for-Sunplus-SP7021/20211203-114932
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 5d331b5922551637c586cdf5fdc1778910fc937f
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20211203/202112031753.KIjg9ffN-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/5a13966416937e820ad198a487deb9308cb86061
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Tony-Huang/Add-iop-driver-for-Sunplus-SP7021/20211203-114932
        git checkout 5a13966416937e820ad198a487deb9308cb86061
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/misc/iop/sunplus_iop.c:10:
>> drivers/misc/iop/sunplus_iop.h:5:10: fatal error: mach/io_map.h: No such file or directory
       5 | #include <mach/io_map.h>
         |          ^~~~~~~~~~~~~~~
   compilation terminated.


vim +5 drivers/misc/iop/sunplus_iop.h

     2	
     3	#ifndef __SP_IOP_H__
     4	#define __SP_IOP_H__
   > 5	#include <mach/io_map.h>
     6	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

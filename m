Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC214884DE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 18:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiAHRMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 12:12:06 -0500
Received: from mga05.intel.com ([192.55.52.43]:31828 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232548AbiAHRME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 12:12:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641661924; x=1673197924;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dwH0pSVP2xSw9DHGOdd7z50SBxYcy3eGeVZoAFYmuHY=;
  b=lKbPHgN5OcW9rbQcDpRxJtlk92LaCLkyOsuPXBIn7ksWWKqJQZqZ7jfj
   G1ASUTVwwacrmLpqSGE0cckyFjblTJRf6rrwm6r4kTbFtB9lyaPr94aIN
   ZhSy+iP0beak7hcHqB93io2ZFZlj22QIL0RXnysh9FjA3j1eKLuHSXf7I
   5qmak6cGhsM2cYKmkI7Ade9r+xawmOrtXqs3QoBCQ5yUDXHyIIm/2bzfA
   FnwtKUb+wQD9T9QBZwtL0ZKHerl95rOZcKz1LvdIILewdesDzeP/UvS3w
   1qG2wPGr0QkJLyrAV0CUGwrCvFN9pziaLzo31/TaV1zxgAwfvY+ByS0yo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="329370084"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="329370084"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 09:12:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="622253286"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 Jan 2022 09:12:02 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6FG5-0000r0-L9; Sat, 08 Jan 2022 17:12:01 +0000
Date:   Sun, 9 Jan 2022 01:11:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2037/2375]
 drivers/video/console/newport_con.c:746:1: warning: data definition has no
 type or storage class
Message-ID: <202201090153.UNw6LldM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   351ceeab2ef96ab2fc306934ddb201b44636181b
commit: 54c5029d29aefc6e1cdd9ce1650822a5a4e1105a [2037/2375] headers/deps: dev/core: Optimize <linux/device.h> dependencies, remove <linux/device_api.h> inclusion
config: mips-buildonly-randconfig-r003-20220108 (https://download.01.org/0day-ci/archive/20220109/202201090153.UNw6LldM-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=54c5029d29aefc6e1cdd9ce1650822a5a4e1105a
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 54c5029d29aefc6e1cdd9ce1650822a5a4e1105a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/video/console/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/video/console/newport_con.c:746:1: warning: data definition has no type or storage class
     746 | module_driver(newport_driver, gio_register_driver, gio_unregister_driver);
         | ^~~~~~~~~~~~~
   drivers/video/console/newport_con.c:746:1: error: type defaults to 'int' in declaration of 'module_driver' [-Werror=implicit-int]
>> drivers/video/console/newport_con.c:746:1: warning: parameter names (without types) in function declaration
   drivers/video/console/newport_con.c:740:26: warning: 'newport_driver' defined but not used [-Wunused-variable]
     740 | static struct gio_driver newport_driver = {
         |                          ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +746 drivers/video/console/newport_con.c

e84de0c6190503 Thomas Bogendoerfer 2011-11-22  739  
e84de0c6190503 Thomas Bogendoerfer 2011-11-22  740  static struct gio_driver newport_driver = {
e84de0c6190503 Thomas Bogendoerfer 2011-11-22  741  	.name = "newport",
e84de0c6190503 Thomas Bogendoerfer 2011-11-22  742  	.id_table = newport_ids,
e84de0c6190503 Thomas Bogendoerfer 2011-11-22  743  	.probe = newport_probe,
e84de0c6190503 Thomas Bogendoerfer 2011-11-22  744  	.remove = newport_remove,
e84de0c6190503 Thomas Bogendoerfer 2011-11-22  745  };
9b07655c7740a9 Jiri Slaby          2020-08-18 @746  module_driver(newport_driver, gio_register_driver, gio_unregister_driver);
^1da177e4c3f41 Linus Torvalds      2005-04-16  747  

:::::: The code at line 746 was first introduced by commit
:::::: 9b07655c7740a97b918ebe7dc59447e29e22a957 newport_con: make module's init & exit static using module_driver

:::::: TO: Jiri Slaby <jslaby@suse.cz>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

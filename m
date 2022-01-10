Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FBB489575
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243144AbiAJJjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:39:33 -0500
Received: from mga09.intel.com ([134.134.136.24]:5204 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243064AbiAJJj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:39:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641807566; x=1673343566;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vD2onmq9VM6jNPZJ8lLODW36KWmUej8oJs7+fyb2T1w=;
  b=LglV5hewmQzAHDcI7nxvSTSomgkTDJyOtwu4Ek5hBEMHrVKT0tdd/An6
   NU62nKwAPTGaEDsKeQhgnB6r2uYEbpRuiMJBzjYzlb2W1FbzUdJgbfxEY
   4kOrKqyBrT/Ivv+VySnf7Ct+GFUVxIFBXVUUe5gR48eRH86ECrXMn9phx
   Gd/FbXcVM9R1ZekjY3GReEY2voxnvG1E1hjcRAmV8SmYFmbOOa170UsQ0
   0PdSDYihxfKg5AXjPt3Guq/fr2yrt9PFd183unapeo3N966u6dHI5ypZq
   HtiDhWW6Y6CxOkn/jyx+WFsJpXgu6uYUE4umUbyQL9m37Mk5SdXIRKTxl
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="242987634"
X-IronPort-AV: E=Sophos;i="5.88,276,1635231600"; 
   d="scan'208";a="242987634"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 01:39:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,276,1635231600"; 
   d="scan'208";a="472018412"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 10 Jan 2022 01:39:24 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6r99-0002iQ-AD; Mon, 10 Jan 2022 09:39:23 +0000
Date:   Mon, 10 Jan 2022 17:38:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1850/2375] arch/mips/ralink/mt7620.c:59:9: error:
 implicit declaration of function 'do_div'
Message-ID: <202201101720.QTGys8N9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   391ce485ced0e47bf8d2ce8bc32bb87887e16656
commit: d10ef57285dc3c6092c8c535c0bbd77e1cf09b08 [1850/2375] headers/deps: cpumask: Optimize <linux/cpumask.h>, remove <linux/cpumask_api.h>
config: mips-vocore2_defconfig (https://download.01.org/0day-ci/archive/20220110/202201101720.QTGys8N9-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=d10ef57285dc3c6092c8c535c0bbd77e1cf09b08
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout d10ef57285dc3c6092c8c535c0bbd77e1cf09b08
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/ralink/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/mips/ralink/mt7620.c: In function 'mt7620_calc_rate':
>> arch/mips/ralink/mt7620.c:59:9: error: implicit declaration of function 'do_div' [-Werror=implicit-function-declaration]
      59 |         do_div(t, div);
         |         ^~~~~~
   cc1: some warnings being treated as errors


vim +/do_div +59 arch/mips/ralink/mt7620.c

594bde683d36c3 John Crispin 2013-03-21  51  
ded1e9d727f0e7 Gabor Juhos  2013-08-23  52  static __init u32
ded1e9d727f0e7 Gabor Juhos  2013-08-23  53  mt7620_calc_rate(u32 ref_rate, u32 mul, u32 div)
ded1e9d727f0e7 Gabor Juhos  2013-08-23  54  {
ded1e9d727f0e7 Gabor Juhos  2013-08-23  55  	u64 t;
ded1e9d727f0e7 Gabor Juhos  2013-08-23  56  
ded1e9d727f0e7 Gabor Juhos  2013-08-23  57  	t = ref_rate;
ded1e9d727f0e7 Gabor Juhos  2013-08-23  58  	t *= mul;
ded1e9d727f0e7 Gabor Juhos  2013-08-23 @59  	do_div(t, div);
ded1e9d727f0e7 Gabor Juhos  2013-08-23  60  
ded1e9d727f0e7 Gabor Juhos  2013-08-23  61  	return t;
ded1e9d727f0e7 Gabor Juhos  2013-08-23  62  }
ded1e9d727f0e7 Gabor Juhos  2013-08-23  63  

:::::: The code at line 59 was first introduced by commit
:::::: ded1e9d727f0e7cb1cf7f243dac2a87974ae048f MIPS: ralink: mt7620: Improve clock frequency detection

:::::: TO: Gabor Juhos <juhosg@openwrt.org>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0354548F5A7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 08:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiAOHbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 02:31:49 -0500
Received: from mga04.intel.com ([192.55.52.120]:15465 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230297AbiAOHbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 02:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642231908; x=1673767908;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ADT4kKYK18b/FFOcSf8II8IdYBpOTs8RkYhyGZyy0ZE=;
  b=Ijj4PX0zH0adW2drZVlEPoNwfmwX6ZK+HVetszQIC/uO4LOGdWp7/t35
   pfPHHESPVQA7zATNU2c0a2zAeo5Zx6eKC2RlzGVA3y4atBk9rhRsvYSur
   Ybs30NACnsY+KElU8W+WQHyXv5nbUKPWYbE90l2gdyxJFwfRvLaupMUvl
   qH3Jsk+Yjk86lTWOK2qYrBHyWWuZuqO2k/LmdWlkGOATpZtwKrhq6QQng
   AutHgh2eI6/JKIcvWiVhAtK4ckUjhWSRM90CvXG26fInIouSNVtgM6kFz
   AAP39VtNIKvmjBqrdKITpcClZ70I1vK5xnoXHvqf6RaCVG/rfILSw4ADz
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="243201917"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="243201917"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 23:31:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="692485318"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2022 23:31:47 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8dXO-0009V8-Lw; Sat, 15 Jan 2022 07:31:46 +0000
Date:   Sat, 15 Jan 2022 15:31:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2353/2384]
 drivers/media/rc/mtk-cir.c:163:15: error: implicit declaration of function
 'DIV_ROUND_CLOSEST'
Message-ID: <202201151534.1iCJKuH9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: 6bdaa08124f2198c510118e5ae8816748e9816df [2353/2384] headers/deps: time: Optimize <linux/time64.h> dependencies, remove <linux/time64_api.h> inclusion
config: mips-randconfig-r036-20220113 (https://download.01.org/0day-ci/archive/20220115/202201151534.1iCJKuH9-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=6bdaa08124f2198c510118e5ae8816748e9816df
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 6bdaa08124f2198c510118e5ae8816748e9816df
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/media/rc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/media/rc/mtk-cir.c: In function 'mtk_chk_period':
>> drivers/media/rc/mtk-cir.c:163:15: error: implicit declaration of function 'DIV_ROUND_CLOSEST' [-Werror=implicit-function-declaration]
     163 |         val = DIV_ROUND_CLOSEST(clk_get_rate(ir->bus),
         |               ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/DIV_ROUND_CLOSEST +163 drivers/media/rc/mtk-cir.c

50c3c1ba171f3f Sean Wang  2017-06-30  154  
50c3c1ba171f3f Sean Wang  2017-06-30  155  static inline u32 mtk_chk_period(struct mtk_ir *ir)
50c3c1ba171f3f Sean Wang  2017-06-30  156  {
50c3c1ba171f3f Sean Wang  2017-06-30  157  	u32 val;
50c3c1ba171f3f Sean Wang  2017-06-30  158  
50c3c1ba171f3f Sean Wang  2017-06-30  159  	/*
50c3c1ba171f3f Sean Wang  2017-06-30  160  	 * Period for software decoder used in the
50c3c1ba171f3f Sean Wang  2017-06-30  161  	 * unit of raw software sampling
50c3c1ba171f3f Sean Wang  2017-06-30  162  	 */
d904eb0b351fe5 Sean Young 2020-11-29 @163  	val = DIV_ROUND_CLOSEST(clk_get_rate(ir->bus),
d904eb0b351fe5 Sean Young 2020-11-29  164  				USEC_PER_SEC * ir->data->div / MTK_IR_SAMPLE);
50c3c1ba171f3f Sean Wang  2017-06-30  165  
50c3c1ba171f3f Sean Wang  2017-06-30  166  	dev_dbg(ir->dev, "@pwm clk  = \t%lu\n",
50c3c1ba171f3f Sean Wang  2017-06-30  167  		clk_get_rate(ir->bus) / ir->data->div);
50c3c1ba171f3f Sean Wang  2017-06-30  168  	dev_dbg(ir->dev, "@chkperiod = %08x\n", val);
50c3c1ba171f3f Sean Wang  2017-06-30  169  
50c3c1ba171f3f Sean Wang  2017-06-30  170  	return val;
50c3c1ba171f3f Sean Wang  2017-06-30  171  }
50c3c1ba171f3f Sean Wang  2017-06-30  172  

:::::: The code at line 163 was first introduced by commit
:::::: d904eb0b351fe5545d9ba5b85844342f49025923 media: mtk-cir: fix calculation of chk period

:::::: TO: Sean Young <sean@mess.org>
:::::: CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

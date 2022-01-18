Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CC3492F52
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343787AbiARUYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:24:41 -0500
Received: from mga11.intel.com ([192.55.52.93]:36344 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349220AbiARUYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642537479; x=1674073479;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8no8Iu2KVTZIqPFo1pq1jGEX/qppR0YqktgtVEP5oUI=;
  b=FPIepHZ0ZD/dsyRw2leDRFmy/pcE9h9D1TkzdYsaw8jMlGrRHUpNnlBc
   0sHi91sT3KwO+OrjWR1FCSLvG4XncZ5oqpArCeweQSKTXK9nDGY3mHK++
   7SBdkpt2pK0RMJWy1zcO53Ws5KmbxnGZx1qEDsAyuEa0fBDqUM9Vif/fb
   emisQtzDOm4DmDoT/SHaHQL+oWc93PZYLyHsFXcOd/wYMY1LqiI/HbuY2
   0u3wBPvxazl5A+3+9pB1ketfa5rIF1vB3MwDz1sp/yLixk6TAguSGHmdi
   hRnVzzrIQnA40Hi4EhtlusQD+B5Clzpwzb2tr1KbpGuMxS6h2crP9Rc3d
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="242470948"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="242470948"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 12:24:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="517904279"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 18 Jan 2022 12:24:07 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9v1S-000CvR-G1; Tue, 18 Jan 2022 20:24:06 +0000
Date:   Wed, 19 Jan 2022 04:23:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik@protonmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/070-audio 3/10] drivers/clk/clk-apple-nco.c:95:16:
 error: implicit declaration of function 'FIELD_PREP'
Message-ID: <202201190413.nZlHy8tT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/070-audio
head:   63a99f1a44208593f5a423b5378824abc2246988
commit: 4fdd8dbf78d3dd153e610d43e69488468317b7ba [3/10] clk: clk-apple-nco: Add driver for Apple NCO
config: csky-allyesconfig (https://download.01.org/0day-ci/archive/20220119/202201190413.nZlHy8tT-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/4fdd8dbf78d3dd153e610d43e69488468317b7ba
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/070-audio
        git checkout 4fdd8dbf78d3dd153e610d43e69488468317b7ba
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clk/clk-apple-nco.c: In function 'nco_div_translate':
>> drivers/clk/clk-apple-nco.c:95:16: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
      95 |         return FIELD_PREP(DIV_COARSE, tbl->fwd[coarse - COARSE_DIV_OFFSET]) |
         |                ^~~~~~~~~~
   drivers/clk/clk-apple-nco.c: In function 'nco_div_translate_inv':
>> drivers/clk/clk-apple-nco.c:103:27: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
     103 |         coarse = tbl->inv[FIELD_GET(DIV_COARSE, regval)] + COARSE_DIV_OFFSET;
         |                           ^~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +95 drivers/clk/clk-apple-nco.c

    87	
    88	static u32 nco_div_translate(struct nco_tables *tbl, int div)
    89	{
    90		int coarse = div / 4;
    91	
    92		if (WARN_ON(!nco_div_check(div)))
    93			return 0;
    94	
  > 95		return FIELD_PREP(DIV_COARSE, tbl->fwd[coarse - COARSE_DIV_OFFSET]) |
    96				FIELD_PREP(DIV_FINE, div % 4);
    97	}
    98	
    99	static int nco_div_translate_inv(struct nco_tables *tbl, int regval)
   100	{
   101		int coarse, fine;
   102	
 > 103		coarse = tbl->inv[FIELD_GET(DIV_COARSE, regval)] + COARSE_DIV_OFFSET;
   104		fine = FIELD_GET(DIV_FINE, regval);
   105	
   106		return coarse * 4 + fine;
   107	}
   108	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

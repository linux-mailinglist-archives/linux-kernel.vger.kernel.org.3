Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4F6482174
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 03:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242111AbhLaCSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 21:18:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:41960 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhLaCSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 21:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640917125; x=1672453125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wtEJ0zWFCIg9b5L8s1KYkJATOZKPuIOSMQp1wVJxQgk=;
  b=BNXCkTO0ljN8zYQqphbPNng89CX+h6E1k9CgZEpZK+D4i6zlv3/dw+vW
   GKe4/sIAEnp12FjsipfL8LGqnXQ5SmKi4BA7H/wXSJ+SAKu4YjIJgZp4m
   uLV6EROgYM5Xv+i6gmFOH86XakS0ToVTi2RctGluuTdnLo88kyl9rqkMx
   M4l6Tk64CM3+Fodk5pzNKwbBxDw1MiRHPfjr4QpYUjnwdECfXHxpL1Eqv
   1BTtCuUNCOf+/xAcLtNjZJTwXTjNxwW3YDXrJfjiQNzu6wO1i58+xaORZ
   r6jh6isow2Yhxj/6qcG90KuxaNsPBF6F/kDPlIfyztmfAbO6mGSx4cgD/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="241969845"
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="241969845"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 18:18:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="687376744"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 30 Dec 2021 18:18:40 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n37V9-000ArO-75; Fri, 31 Dec 2021 02:18:39 +0000
Date:   Fri, 31 Dec 2021 10:17:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Taniya Das <tdas@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette =?iso-8859-1?Q?=A0?= 
        <mturquette@baylibre.com>
Cc:     kbuild-all@lists.01.org, Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 5/5] clk: qcom: lpass: Add support for LPASS clock
 controller for SC7280
Message-ID: <202112311037.baApS5Qa-lkp@intel.com>
References: <1640018638-19436-6-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1640018638-19436-6-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taniya,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on robh/for-next linus/master v5.16-rc7 next-20211224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Taniya-Das/Add-support-for-LPASS-Core-and-Audio-Clock-for-SC7280/20211221-004818
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20211231/202112311037.baApS5Qa-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/fec640fab5ec498e79475ecd4b15bc95035a76b1
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Taniya-Das/Add-support-for-LPASS-Core-and-Audio-Clock-for-SC7280/20211221-004818
        git checkout fec640fab5ec498e79475ecd4b15bc95035a76b1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/clk/qcom/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/of.h:14,
                    from include/linux/clk-provider.h:9,
                    from drivers/clk/qcom/lpassaudiocc-sc7280.c:6:
   drivers/clk/qcom/lpassaudiocc-sc7280.c: In function 'lpass_audio_cc_sc7280_probe':
>> include/linux/stddef.h:8:14: error: called object is not a function or function pointer
       8 | #define NULL ((void *)0)
         |              ^
   include/linux/pm_clock.h:82:25: note: in expansion of macro 'NULL'
      82 | #define pm_clk_suspend  NULL
         |                         ^~~~
   drivers/clk/qcom/lpassaudiocc-sc7280.c:740:9: note: in expansion of macro 'pm_clk_suspend'
     740 |         pm_clk_suspend(&pdev->dev);
         |         ^~~~~~~~~~~~~~
   drivers/clk/qcom/lpassaudiocc-sc7280.c: In function 'lpass_aon_cc_sc7280_probe':
>> include/linux/stddef.h:8:14: error: called object is not a function or function pointer
       8 | #define NULL ((void *)0)
         |              ^
   include/linux/pm_clock.h:82:25: note: in expansion of macro 'NULL'
      82 | #define pm_clk_suspend  NULL
         |                         ^~~~
   drivers/clk/qcom/lpassaudiocc-sc7280.c:798:9: note: in expansion of macro 'pm_clk_suspend'
     798 |         pm_clk_suspend(&pdev->dev);
         |         ^~~~~~~~~~~~~~


vim +8 include/linux/stddef.h

^1da177e4c3f41 Linus Torvalds   2005-04-16  6  
^1da177e4c3f41 Linus Torvalds   2005-04-16  7  #undef NULL
^1da177e4c3f41 Linus Torvalds   2005-04-16 @8  #define NULL ((void *)0)
6e218287432472 Richard Knutsson 2006-09-30  9  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

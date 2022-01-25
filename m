Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6893949AE33
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451384AbiAYIhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:37:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:16141 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1450276AbiAYIc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643099578; x=1674635578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PJYavozYdAkdPl4SALbJVcV0klynjxDcedKqP+BV1no=;
  b=OL3WshurAOgS+G3BIMyyWaVpKXioeLTaRMTOn/JnoZZYFZujZXAfTykT
   x2QqHZIu9epNkpMNGdY4eMhwOVV9Po37jPbeBXRkrPnc2KUsVrKeWObTy
   EqzYLVpntcHzcXF7ucMEdzPpiTxn+knxV/cTwUrqpPHY3yNRsbCxR5RQr
   FNoK5+3cSMISokQWPJ7AaxuYNvITjxozIb51+T3C/GlJYYBCwvg6+R/YA
   +MBRttXTT6UmadeM++DBzLKbgX/h/KStH69wkabMF5s9lODc+heDA9i2V
   wRSyQ6ENDVQgla74rOuftaMmQjAK9K3NFpt3gX+iMycddZHo987tBFPss
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="309570663"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="309570663"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 00:28:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="479409002"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Jan 2022 00:28:31 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCHBn-000JZc-7p; Tue, 25 Jan 2022 08:28:31 +0000
Date:   Tue, 25 Jan 2022 16:27:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, dan.carpenter@oracle.com,
        Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, paskripkin@gmail.com
Subject: Re: [PATCH 04/10] staging: r8188eu: remove all DBG_88E calls from
 hal dir
Message-ID: <202201251642.5tYQO4Fb-lkp@intel.com>
References: <20220124224415.831-5-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124224415.831-5-phil@philpotter.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

I love your patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]
[also build test WARNING on v5.17-rc1 next-20220124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Phillip-Potter/Cleanup-and-removal-of-DBG_88E-macro/20220125-125206
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git fa783154524a71ab74e293cd8251155e5971952b
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220125/202201251642.5tYQO4Fb-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/041fe115dad9245f83646e7674341f28094d62a5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Phillip-Potter/Cleanup-and-removal-of-DBG_88E-macro/20220125-125206
        git checkout 041fe115dad9245f83646e7674341f28094d62a5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/staging/r8188eu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/staging/r8188eu/hal/rtl8188e_cmd.c: In function 'rtl8188e_set_FwMediaStatus_cmd':
>> drivers/staging/r8188eu/hal/rtl8188e_cmd.c:195:20: warning: variable 'macid' set but not used [-Wunused-but-set-variable]
     195 |         u8 opmode, macid;
         |                    ^~~~~
>> drivers/staging/r8188eu/hal/rtl8188e_cmd.c:195:12: warning: variable 'opmode' set but not used [-Wunused-but-set-variable]
     195 |         u8 opmode, macid;
         |            ^~~~~~


vim +/macid +195 drivers/staging/r8188eu/hal/rtl8188e_cmd.c

8cd574e6af5463 Phillip Potter 2021-07-28  192  
8cd574e6af5463 Phillip Potter 2021-07-28  193  void rtl8188e_set_FwMediaStatus_cmd(struct adapter *adapt, __le16 mstatus_rpt)
8cd574e6af5463 Phillip Potter 2021-07-28  194  {
8cd574e6af5463 Phillip Potter 2021-07-28 @195  	u8 opmode, macid;
8cd574e6af5463 Phillip Potter 2021-07-28  196  	u16 mst_rpt = le16_to_cpu(mstatus_rpt);
8cd574e6af5463 Phillip Potter 2021-07-28  197  	opmode = (u8)mst_rpt;
8cd574e6af5463 Phillip Potter 2021-07-28  198  	macid = (u8)(mst_rpt >> 8);
8cd574e6af5463 Phillip Potter 2021-07-28  199  
8cd574e6af5463 Phillip Potter 2021-07-28  200  	FillH2CCmd_88E(adapt, H2C_COM_MEDIA_STATUS_RPT, sizeof(mst_rpt), (u8 *)&mst_rpt);
8cd574e6af5463 Phillip Potter 2021-07-28  201  }
8cd574e6af5463 Phillip Potter 2021-07-28  202  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

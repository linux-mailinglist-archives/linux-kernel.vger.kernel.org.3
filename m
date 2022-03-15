Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85DC4DA36F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351450AbiCOTpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349174AbiCOTpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:45:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7614632041
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647373445; x=1678909445;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kW4pMB6an9Z81Auvyet/HJVVCmoZvLOTWzns0zcpJ/g=;
  b=fTdiPlY8TkS8yXvKVOueob1j2uR9asfDFyKCsdPqBQmSwNtMdS3nDiJn
   f5nTQaUrvRr6tjgCPGv62Z2zj6KqQiyntFn5pR+s2q3JQ6gZ8s+pSlyDD
   f+Y09G95Qef80sbSKqUcZzFW24SpdNewrBQkkUrcXDqVYw4gGmgQIbafh
   9rncMS5Qz5To8QA8FXglAKngspStE0z/YlD3NO3fZpTEzlrbk+D/nCSZM
   3Sgfd7xqc+rFQkateSdxKVTVC1FJ+pWGzMDkmSmNga2feb8KGneoKJN/q
   5vXahbhrfhsAPzruHnSzVok/1epgE3RD3D9ZiAURRO8JyXPmSCyEMXOUf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256361753"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="256361753"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 12:44:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="646362637"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Mar 2022 12:44:01 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUD5M-000BQZ-Fe; Tue, 15 Mar 2022 19:44:00 +0000
Date:   Wed, 16 Mar 2022 03:43:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        will@kernel.org, axboe@kernel.dk
Cc:     kbuild-all@lists.01.org, mb@lightnvm.io,
        ckeepax@opensource.cirrus.com, manjunatha.venkatesh@nxp.com,
        mst@redhat.com, javier@javigon.com, mikelley@microsoft.com,
        jasowang@redhat.com, sunilmut@microsoft.com,
        bjorn.andersson@linaro.org, rvmanjumce@gmail.com
Subject: Re: [PATCH v2] uwb: nxp: sr1xx: UWB driver support for sr1xx series
 chip
Message-ID: <202203160341.mXSIGePW-lkp@intel.com>
References: <20220315111227.2388583-1-manjunatha.venkatesh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315111227.2388583-1-manjunatha.venkatesh@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manjunatha,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on linus/master v5.17-rc8]
[cannot apply to next-20220315]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Manjunatha-Venkatesh/uwb-nxp-sr1xx-UWB-driver-support-for-sr1xx-series-chip/20220315-191309
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2c271fe77d52a0555161926c232cd5bc07178b39
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220316/202203160341.mXSIGePW-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/26293c243a1119c3a848e08c588e371f21aceb53
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Manjunatha-Venkatesh/uwb-nxp-sr1xx-UWB-driver-support-for-sr1xx-series-chip/20220315-191309
        git checkout 26293c243a1119c3a848e08c588e371f21aceb53
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/uwb/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/uwb/sr1xx.c:196:6: warning: no previous prototype for 'sr1xx_wait_for_irq_gpio_low' [-Wmissing-prototypes]
     196 | void sr1xx_wait_for_irq_gpio_low(struct sr1xx_dev *sr1xx_dev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/uwb/sr1xx.c:793:5: warning: no previous prototype for 'sr1xx_dev_suspend' [-Wmissing-prototypes]
     793 | int sr1xx_dev_suspend(struct device *dev)
         |     ^~~~~~~~~~~~~~~~~
>> drivers/uwb/sr1xx.c:809:5: warning: no previous prototype for 'sr1xx_dev_resume' [-Wmissing-prototypes]
     809 | int sr1xx_dev_resume(struct device *dev)
         |     ^~~~~~~~~~~~~~~~


vim +/sr1xx_wait_for_irq_gpio_low +196 drivers/uwb/sr1xx.c

   189	
   190	/**
   191	 * sr1xx_wait_for_irq_gpio_low
   192	 *
   193	 * Function to wait till irq gpio goes low state
   194	 *
   195	 */
 > 196	void sr1xx_wait_for_irq_gpio_low(struct sr1xx_dev *sr1xx_dev)
   197	{
   198		int retry_count = 0;
   199	
   200		do {
   201			udelay(10);
   202			retry_count++;
   203			if (retry_count == MAX_RETRY_COUNT_FOR_HANDSHAKE) {
   204				dev_info(&sr1xx_dev->spi->dev,
   205					 "Slave not released the IRQ even after 10ms");
   206				break;
   207			}
   208		} while (gpio_get_value(sr1xx_dev->irq_gpio));
   209	}
   210	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

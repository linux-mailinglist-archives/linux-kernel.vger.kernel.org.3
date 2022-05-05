Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A1E51BCC4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbiEEKKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiEEKKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:10:40 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE496115F
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 03:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651745221; x=1683281221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SKQZZk5pvsgQPXaaeLMVmNMurd3L6Uu+aDpSNIeJhJk=;
  b=JswJ7qluE251jlkh/wdsddjBQrFjMfpFGEjrBeRN6AHtLI8+Y32Y34w/
   ITqArqa3LYAkpkV4xKEuL6KxFzRjmGSo7FWJTkSCm+m0fs7tvUL2O3NFt
   VBz3WFxLkGNpAtzpN4Yjkaa7LLTgkAmJbGQp+7NIrn/X0kuYgnDBuyHMx
   ajacYBmlExMrkkbY4sM9qpF2UbgeEjuuttjtt6kuKu6YQ3gvm1YqIIgMp
   85Vp+oueBs80Kf2P5E9hkt3SMwP6KNbVsqFtqMAw5HSJOxLUfUl8nS3ik
   HWnPo22IgiFRtu7qvlEehYGs8M87Nja00Mz/s8sxlfcW+NUeOjcr0XXnY
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="328603065"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="328603065"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 03:07:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="664901178"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 05 May 2022 03:06:57 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmYNs-000CHJ-R9;
        Thu, 05 May 2022 10:06:56 +0000
Date:   Thu, 5 May 2022 18:06:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        will@kernel.org, axboe@kernel.dk
Cc:     kbuild-all@lists.01.org, mb@lightnvm.io,
        ckeepax@opensource.cirrus.com, manjunatha.venkatesh@nxp.com,
        mst@redhat.com, javier@javigon.com, mikelley@microsoft.com,
        jasowang@redhat.com, sunilmut@microsoft.com,
        bjorn.andersson@linaro.org, rvmanjumce@gmail.com,
        ashish.deshpande@nxp.com
Subject: Re: [PATCH v3] [PATCH v3] uwb: nxp: sr1xx: UWB driver support for
 sr1xx series chip
Message-ID: <202205051830.f36qJQ6E-lkp@intel.com>
References: <20220504171337.3416983-1-manjunatha.venkatesh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504171337.3416983-1-manjunatha.venkatesh@nxp.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on linux/master linus/master v5.18-rc5 next-20220504]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Manjunatha-Venkatesh/uwb-nxp-sr1xx-UWB-driver-support-for-sr1xx-series-chip/20220505-020126
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 35a7609639c49f76f13f206402cbf692c4ae3e4e
config: sparc-buildonly-randconfig-r005-20220505 (https://download.01.org/0day-ci/archive/20220505/202205051830.f36qJQ6E-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/037b22462c3f4715f0a04e1be05cd12986880d21
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Manjunatha-Venkatesh/uwb-nxp-sr1xx-UWB-driver-support-for-sr1xx-series-chip/20220505-020126
        git checkout 037b22462c3f4715f0a04e1be05cd12986880d21
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/misc/sr1xx.c:125:6: warning: no previous prototype for 'sr1xx_wait_for_irq_gpio_low' [-Wmissing-prototypes]
     125 | void sr1xx_wait_for_irq_gpio_low(struct sr1xx_dev *sr1xx_dev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/sr1xx.c:720:5: warning: no previous prototype for 'sr1xx_dev_suspend' [-Wmissing-prototypes]
     720 | int sr1xx_dev_suspend(struct device *dev)
         |     ^~~~~~~~~~~~~~~~~
>> drivers/misc/sr1xx.c:736:5: warning: no previous prototype for 'sr1xx_dev_resume' [-Wmissing-prototypes]
     736 | int sr1xx_dev_resume(struct device *dev)
         |     ^~~~~~~~~~~~~~~~


vim +/sr1xx_wait_for_irq_gpio_low +125 drivers/misc/sr1xx.c

   118	
   119	/**
   120	 * sr1xx_wait_for_irq_gpio_low
   121	 *
   122	 * Function to wait till irq gpio goes low state
   123	 *
   124	 */
 > 125	void sr1xx_wait_for_irq_gpio_low(struct sr1xx_dev *sr1xx_dev)
   126	{
   127		int retry_count = 0;
   128	
   129		do {
   130			udelay(10);
   131			retry_count++;
   132			if (retry_count == MAX_RETRY_COUNT_FOR_HANDSHAKE) {
   133				dev_info(&sr1xx_dev->spi->dev,
   134					 "Slave not released the IRQ even after 10ms");
   135				break;
   136			}
   137		} while (gpio_get_value(sr1xx_dev->irq_gpio));
   138	}
   139	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

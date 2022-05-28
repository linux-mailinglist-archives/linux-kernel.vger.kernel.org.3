Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021345369AC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 03:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349472AbiE1BXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 21:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbiE1BXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 21:23:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56C2131F2F;
        Fri, 27 May 2022 18:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653701013; x=1685237013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c3Q9yIPMscWPVW88MxGTurNSEu+nk/oHdvXSshEhLIo=;
  b=H0264p59sSQnFNHsZGSFF+MSBlWTuyqR9PVlsH5ENFfiYqaSwfFybiHm
   5H2mXytg/xeKaOsJnFew24hd/v1UA7Pybpo73HfT2Trd+uFso4ZYN/rU/
   PcCGCjlTwbOgTqXnXpIWRIQVCHNl/JuJowKppxcBL4Xa3OV5uypUiHQxN
   fxTMz793aoce5cdENaS4bW3DgZXUpxCcV4jabzzOHt292VmTYSHlzgWqB
   YAreOzCsDg20kC8J/8AuBwqhi7IQwVMZ0OMntIDiGBa0hSUjfHXK1z/6/
   DkWiXyEZyW9vt2PD2APH6IgUVKWEeRK/uTpB/qVAOj2SJCMqPsibWutGY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="274708217"
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="274708217"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 18:23:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="747322698"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 May 2022 18:23:29 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nulAu-0005Kz-Bi;
        Sat, 28 May 2022 01:23:28 +0000
Date:   Sat, 28 May 2022 09:23:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        will@kernel.org, axboe@kernel.dk, robh+dt@kernel.org
Cc:     kbuild-all@lists.01.org, mb@lightnvm.io,
        ckeepax@opensource.cirrus.com, arnd@arndb.d,
        manjunatha.venkatesh@nxp.com, mst@redhat.com, javier@javigon.com,
        mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ashish.deshpande@nxp.com, rvmanjumce@gmail.com
Subject: Re: [PATCH v4 3/3] misc: uwb: nxp: sr1xx: UWB driver support for
 sr1xx series chip
Message-ID: <202205280934.M6HHdGSK-lkp@intel.com>
References: <20220527184351.3829543-4-manjunatha.venkatesh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527184351.3829543-4-manjunatha.venkatesh@nxp.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manjunatha,

I love your patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on robh/for-next linus/master v5.18 next-20220527]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Manjunatha-Venkatesh/dt-bindings-uwb-Device-tree-information-for-Nxp-SR1XX-SOCs/20220528-034415
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 90de6805267f8c79cd2b1a36805071e257c39b5c
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220528/202205280934.M6HHdGSK-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/948442a0588504d3fecae99073e785e5af6346bc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Manjunatha-Venkatesh/dt-bindings-uwb-Device-tree-information-for-Nxp-SR1XX-SOCs/20220528-034415
        git checkout 948442a0588504d3fecae99073e785e5af6346bc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/misc/nxp-sr1xx.c:175:6: warning: no previous prototype for 'sr1xx_wait_for_irq_gpio_low' [-Wmissing-prototypes]
     175 | void sr1xx_wait_for_irq_gpio_low(struct sr1xx_dev *sr1xx_dev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/nxp-sr1xx.c:770:5: warning: no previous prototype for 'sr1xx_dev_suspend' [-Wmissing-prototypes]
     770 | int sr1xx_dev_suspend(struct device *dev)
         |     ^~~~~~~~~~~~~~~~~
>> drivers/misc/nxp-sr1xx.c:786:5: warning: no previous prototype for 'sr1xx_dev_resume' [-Wmissing-prototypes]
     786 | int sr1xx_dev_resume(struct device *dev)
         |     ^~~~~~~~~~~~~~~~


vim +/sr1xx_wait_for_irq_gpio_low +175 drivers/misc/nxp-sr1xx.c

   168	
   169	/**
   170	 * sr1xx_wait_for_irq_gpio_low
   171	 *
   172	 * Function to wait till irq gpio goes low state
   173	 *
   174	 */
 > 175	void sr1xx_wait_for_irq_gpio_low(struct sr1xx_dev *sr1xx_dev)
   176	{
   177		int retry_count = 0;
   178	
   179		do {
   180			udelay(10);
   181			retry_count++;
   182			if (retry_count == MAX_RETRY_COUNT_FOR_HANDSHAKE) {
   183				dev_info(&sr1xx_dev->spi->dev,
   184					 "Slave not released the IRQ even after 10ms");
   185				break;
   186			}
   187		} while (gpio_get_value(sr1xx_dev->irq_gpio));
   188	}
   189	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

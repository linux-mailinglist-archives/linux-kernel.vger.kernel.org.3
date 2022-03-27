Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266C84E8A1B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 22:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbiC0UwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 16:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiC0UwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 16:52:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8458A192AD
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 13:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648414224; x=1679950224;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pDeVuR7jrBBzl1Smfwcy7VsMGMXmN22TJrrLvMT5vJQ=;
  b=jFS3CDIuUQq4KM2PYl5vEG18eTTefjdbQv+n14I5mJ0pIZLEP7FNDxqX
   VgRDfsh9RTki0pMLfxltIkqhxQA/FHsdK5uklf3up2g0aZcUT7ZkajC/P
   D2fF30O94SAqFbmroNp6tBUcneT95Crt6KfuhPiwwfseqrW1CdpH9sm5O
   X9jrQdOqQAAugzS+6Eh3noD1OKZyiqyxKhZxA5uq4pjiVHJ+tGw4eWKVB
   bDAMdvoC5WVo8zsT98zN0FGgMvtFhIhh6K2xC87x5tBkhy2+OF7E77V/9
   QmfaAi0jheaRFWxhUeqYd9It1FgnvIsjrjhKcG4XUzk0dwQWH9U82+0eZ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="238808578"
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="238808578"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 13:50:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="651104421"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 27 Mar 2022 13:50:22 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYZq9-0001Pu-AS; Sun, 27 Mar 2022 20:50:21 +0000
Date:   Mon, 28 Mar 2022 04:50:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Robert Richter <rrichter@amd.com>,
        Jean Delvare <jdelvare@suse.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [watchdog-next:v5.18-rc1 12/13] drivers/watchdog/sp5100_tco.c:345:6:
 warning: assignment to 'struct resource *' from 'int' makes pointer from
 integer without a cast
Message-ID: <202203280446.sZhhsZYx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://www.linux-watchdog.org/linux-watchdog-next.git v5.18-rc1
head:   826270373f17fd8ebd10753ca0a5fd2ceb1dc38e
commit: 0578fff4aae5bce3f09875f58e68e9ffbab8daf5 [12/13] Watchdog: sp5100_tco: Add initialization using EFCH MMIO
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220328/202203280446.sZhhsZYx-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce (this is a W=1 build):
        git remote add watchdog-next git://www.linux-watchdog.org/linux-watchdog-next.git
        git fetch --no-tags watchdog-next v5.18-rc1
        git checkout 0578fff4aae5bce3f09875f58e68e9ffbab8daf5
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/watchdog/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/watchdog/sp5100_tco.c: In function 'sp5100_tco_setupdevice_mmio':
   drivers/watchdog/sp5100_tco.c:345:8: error: implicit declaration of function 'request_mem_region_muxed'; did you mean 'request_mem_region'? [-Werror=implicit-function-declaration]
     345 |  res = request_mem_region_muxed(EFCH_PM_ACPI_MMIO_PM_ADDR,
         |        ^~~~~~~~~~~~~~~~~~~~~~~~
         |        request_mem_region
>> drivers/watchdog/sp5100_tco.c:345:6: warning: assignment to 'struct resource *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     345 |  res = request_mem_region_muxed(EFCH_PM_ACPI_MMIO_PM_ADDR,
         |      ^
   cc1: some warnings being treated as errors


vim +345 drivers/watchdog/sp5100_tco.c

   333	
   334	static int sp5100_tco_setupdevice_mmio(struct device *dev,
   335					       struct watchdog_device *wdd)
   336	{
   337		struct sp5100_tco *tco = watchdog_get_drvdata(wdd);
   338		const char *dev_name = SB800_DEVNAME;
   339		u32 mmio_addr = 0, alt_mmio_addr = 0;
   340		struct resource *res;
   341		void __iomem *addr;
   342		int ret;
   343		u32 val;
   344	
 > 345		res = request_mem_region_muxed(EFCH_PM_ACPI_MMIO_PM_ADDR,
   346					       EFCH_PM_ACPI_MMIO_PM_SIZE,
   347					       "sp5100_tco");
   348	
   349		if (!res) {
   350			dev_err(dev,
   351				"Memory region 0x%08x already in use\n",
   352				EFCH_PM_ACPI_MMIO_PM_ADDR);
   353			return -EBUSY;
   354		}
   355	
   356		addr = ioremap(EFCH_PM_ACPI_MMIO_PM_ADDR, EFCH_PM_ACPI_MMIO_PM_SIZE);
   357		if (!addr) {
   358			dev_err(dev, "Address mapping failed\n");
   359			ret = -ENOMEM;
   360			goto out;
   361		}
   362	
   363		/*
   364		 * EFCH_PM_DECODEEN_WDT_TMREN is dual purpose. This bitfield
   365		 * enables sp5100_tco register MMIO space decoding. The bitfield
   366		 * also starts the timer operation. Enable if not already enabled.
   367		 */
   368		val = efch_read_pm_reg8(addr, EFCH_PM_DECODEEN);
   369		if (!(val & EFCH_PM_DECODEEN_WDT_TMREN)) {
   370			efch_update_pm_reg8(addr, EFCH_PM_DECODEEN, 0xff,
   371					    EFCH_PM_DECODEEN_WDT_TMREN);
   372		}
   373	
   374		/* Error if the timer could not be enabled */
   375		val = efch_read_pm_reg8(addr, EFCH_PM_DECODEEN);
   376		if (!(val & EFCH_PM_DECODEEN_WDT_TMREN)) {
   377			dev_err(dev, "Failed to enable the timer\n");
   378			ret = -EFAULT;
   379			goto out;
   380		}
   381	
   382		mmio_addr = EFCH_PM_WDT_ADDR;
   383	
   384		/* Determine alternate MMIO base address */
   385		val = efch_read_pm_reg8(addr, EFCH_PM_ISACONTROL);
   386		if (val & EFCH_PM_ISACONTROL_MMIOEN)
   387			alt_mmio_addr = EFCH_PM_ACPI_MMIO_ADDR +
   388				EFCH_PM_ACPI_MMIO_WDT_OFFSET;
   389	
   390		ret = sp5100_tco_prepare_base(tco, mmio_addr, alt_mmio_addr, dev_name);
   391		if (!ret) {
   392			tco_timer_enable_mmio(addr);
   393			ret = sp5100_tco_timer_init(tco);
   394		}
   395	
   396	out:
   397		if (addr)
   398			iounmap(addr);
   399	
   400		release_resource(res);
   401	
   402		return ret;
   403	}
   404	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

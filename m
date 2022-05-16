Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E5E5294B7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 01:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350229AbiEPXJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 19:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348622AbiEPXJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 19:09:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E831B4476E;
        Mon, 16 May 2022 16:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652742538; x=1684278538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t9s//g5eW49okIknpm3TXfprezkECY9aRbZEJNV1PS0=;
  b=R3PQx5WyT6BXa947mXAS2riDVmAPRt2eWW0A741kBt6cb5j75dEiyyFN
   tHc+jgDg4/+sQUCawNDvxEXWI01hkx8obXWqhyB88VXudMKjt4qb4K5YH
   f3Ele9dihh8zNCmbj+p+tt3aV3ryjRidwz0qJdt47cqLjMvJbzYw+En8r
   82cnfvOZGFyf1/xCXRId80M8tVg9BKS4hUgCDMWLiw15bgos+sLfIleim
   npjBzNBKa6UoMpTOQPDFVHkh/oD/8iqAdu1DvATC7wddqAFOPITaWrQ8w
   OKS/A4G9BW2/oRRkWyYQwrGHz+3GbN88109peWA8F1p8uDNu23KDnmkdY
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="357401490"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="357401490"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 16:08:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="816621816"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 16 May 2022 16:08:53 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqjpc-0000PB-Ni;
        Mon, 16 May 2022 23:08:52 +0000
Date:   Tue, 17 May 2022 07:08:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Medad CChien <medadyoung@gmail.com>, benjaminfair@google.com,
        yuenn@google.com, venture@google.com, tali.perry1@gmail.com,
        tmaimon77@gmail.com, avifishman70@gmail.com, robh+dt@kernel.org,
        alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, ctcchien@nuvoton.com
Cc:     kbuild-all@lists.01.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v1 3/3] RTC: nuvoton: Add NCT3018Y real time clock driver
Message-ID: <202205170654.jQqRSbra-lkp@intel.com>
References: <20220516152751.27716-3-ctcchien@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516152751.27716-3-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Medad,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on abelloni/rtc-next]
[also build test WARNING on robh/for-next v5.18-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Medad-CChien/ARM-dts-nuvoton-Add-nuvoton-RTC3018Y-node/20220516-232940
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220517/202205170654.jQqRSbra-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/5c51862ee8030cfd9f2e955c10ee580f168663e3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Medad-CChien/ARM-dts-nuvoton-Add-nuvoton-RTC3018Y-node/20220516-232940
        git checkout 5c51862ee8030cfd9f2e955c10ee580f168663e3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/rtc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/rtc/rtc-nct3018y.c: In function 'nct3018y_rtc_read_time':
>> drivers/rtc/rtc-nct3018y.c:192:26: warning: unused variable 'nct3018y' [-Wunused-variable]
     192 |         struct nct3018y *nct3018y = i2c_get_clientdata(client);
         |                          ^~~~~~~~
   drivers/rtc/rtc-nct3018y.c: In function 'nct3018y_rtc_set_time':
   drivers/rtc/rtc-nct3018y.c:227:26: warning: unused variable 'nct3018y' [-Wunused-variable]
     227 |         struct nct3018y *nct3018y = i2c_get_clientdata(client);
         |                          ^~~~~~~~
   drivers/rtc/rtc-nct3018y.c: In function 'nct3018y_rtc_set_alarm':
   drivers/rtc/rtc-nct3018y.c:292:26: warning: unused variable 'nct3018y' [-Wunused-variable]
     292 |         struct nct3018y *nct3018y = i2c_get_clientdata(client);
         |                          ^~~~~~~~
   drivers/rtc/rtc-nct3018y.c: In function 'nct3018y_irq_enable':
   drivers/rtc/rtc-nct3018y.c:322:26: warning: unused variable 'nct3018y' [-Wunused-variable]
     322 |         struct nct3018y *nct3018y = i2c_get_clientdata(client);
         |                          ^~~~~~~~
   In file included from include/linux/printk.h:555,
                    from include/linux/kernel.h:29,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/mutex.h:14,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/clk-provider.h:9,
                    from drivers/rtc/rtc-nct3018y.c:5:
   drivers/rtc/rtc-nct3018y.c: In function 'nct3018y_probe':
   drivers/rtc/rtc-nct3018y.c:513:39: warning: format '%d' expects argument of type 'int', but argument 5 has type 'long unsigned int' [-Wformat=]
     513 |                 dev_dbg(&client->dev, "%s: NCT3018Y_BIT_TWO is :%d\n",
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/rtc/rtc-nct3018y.c:513:17: note: in expansion of macro 'dev_dbg'
     513 |                 dev_dbg(&client->dev, "%s: NCT3018Y_BIT_TWO is :%d\n",
         |                 ^~~~~~~
   drivers/rtc/rtc-nct3018y.c:513:66: note: format string is defined here
     513 |                 dev_dbg(&client->dev, "%s: NCT3018Y_BIT_TWO is :%d\n",
         |                                                                 ~^
         |                                                                  |
         |                                                                  int
         |                                                                 %ld
   drivers/rtc/rtc-nct3018y.c:535:22: error: 'struct rtc_device' has no member named 'uie_unsupported'
     535 |         nct3018y->rtc->uie_unsupported = 1;
         |                      ^~
   drivers/rtc/rtc-nct3018y.c:561:15: error: implicit declaration of function 'rtc_register_device'; did you mean 'i2c_unregister_device'? [-Werror=implicit-function-declaration]
     561 |         err = rtc_register_device(nct3018y->rtc);
         |               ^~~~~~~~~~~~~~~~~~~
         |               i2c_unregister_device
   cc1: some warnings being treated as errors


vim +/nct3018y +192 drivers/rtc/rtc-nct3018y.c

   184	
   185	/*
   186	 * In the routines that deal directly with the nct3018y hardware, we use
   187	 * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
   188	 */
   189	static int nct3018y_rtc_read_time(struct device *dev, struct rtc_time *tm)
   190	{
   191		struct i2c_client *client = to_i2c_client(dev);
 > 192		struct nct3018y *nct3018y = i2c_get_clientdata(client);
   193		unsigned char buf[10];
   194		int err;
   195	
   196		err = nct3018y_read_block_data(client, NCT3018Y_REG_ST, 1, buf);
   197		if (err)
   198			return err;
   199	
   200		if (!buf[0]) {
   201			dev_err(&client->dev, " voltage <=1.7, date/time is not reliable.\n");
   202			return -EINVAL;
   203		}
   204	
   205		err = nct3018y_read_block_data(client, NCT3018Y_REG_SC, 10, buf);
   206		if (err)
   207			return err;
   208	
   209		tm->tm_sec = bcd2bin(buf[0] & 0x7F);
   210		tm->tm_min = bcd2bin(buf[2] & 0x7F);
   211		tm->tm_hour = bcd2bin(buf[4] & 0x3F); /* rtc hr 0-24 */
   212		tm->tm_wday = buf[6] & 0x07;
   213		tm->tm_mday = bcd2bin(buf[7] & 0x3F);
   214		tm->tm_mon = bcd2bin(buf[8] & 0x1F) - 1 ; /* rtc mn 1-12 */
   215		tm->tm_year = bcd2bin(buf[9]) + 100;
   216	
   217		dev_dbg(&client->dev, "%s:s=%d, m=%d, hr=%d, md=%d, m=%d, yr=%d, wd=%d\n",
   218			__func__, tm->tm_sec, tm->tm_min, tm->tm_hour, tm->tm_mday, tm->tm_mon,
   219			tm->tm_year, tm->tm_wday);
   220	
   221		return 0;
   222	}
   223	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

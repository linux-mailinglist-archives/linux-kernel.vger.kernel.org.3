Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79B551DE95
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 20:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381951AbiEFSHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 14:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345265AbiEFSHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 14:07:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDE462BEB;
        Fri,  6 May 2022 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651860212; x=1683396212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8fFvGdzoG/rA8+1UZY/4PHel/cIyIvtKdIsOtXJKLw8=;
  b=II6nW9dbL6gLFUl5di4Q+aQcHl4FMSc1ZIo1g35/zSzZFTjTMmM1RRXn
   zJtLk6U25whU0Hm7oH4b3ASBPNNxUk0xKnytuDqVY3nJ7BAwwZOuB5oeE
   0x2s+ciTdD218iB7Ejda8JC/i/orkaVxjShwdWCPGRX90N72vTGp9bNIf
   Jk7a7NXn/ArBidNUi0EnzailEKBpWdzJha7O7i9K5YysATsL4dqV0qPdd
   bcq0tJ1XHYpLILjTngz/3R6QMiogc66Dna2fyHGiE1ZvMiHNqR7PwoHT0
   qMc2z4RuG0i3J7KFyQsaZSJPbc2eEqAZNAIaeA+ZbjQJGlemnzOTD4f3J
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="248443577"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="248443577"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 11:03:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="735870259"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 06 May 2022 11:03:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nn2IV-000DjU-Ps;
        Fri, 06 May 2022 18:03:23 +0000
Date:   Sat, 7 May 2022 02:02:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        usama.anjum@collabora.com,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        vbendeb@chromium.org, andy@infradead.org,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v9] platform/chrome: Add ChromeOS ACPI device driver
Message-ID: <202205070117.SW4TyTN4-lkp@intel.com>
References: <YnTw/iQ1Asjjmsb9@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnTw/iQ1Asjjmsb9@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muhammad,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on chrome-platform/for-next v5.18-rc5 next-20220506]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/platform-chrome-Add-ChromeOS-ACPI-device-driver/20220506-175951
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220507/202205070117.SW4TyTN4-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e004fb787698440a387750db7f8028e7cb14cfc)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4f6407962feddc57bc7c80e5b29d5d339a1dba6c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Muhammad-Usama-Anjum/platform-chrome-Add-ChromeOS-ACPI-device-driver/20220506-175951
        git checkout 4f6407962feddc57bc7c80e5b29d5d339a1dba6c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/platform/chrome/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/platform/chrome/chromeos_acpi.c:254:5: warning: format specifies type 'long' but the argument has type 'unsigned int' [-Wformat]
                            (ARRAY_SIZE(chromeos_acpi_all_groups) - 2), chromeos_acpi_gpio_groups);
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:146:70: note: expanded from macro 'dev_warn'
           dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                       ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   1 warning generated.


vim +254 drivers/platform/chrome/chromeos_acpi.c

   244	
   245	static int chromeos_acpi_device_probe(struct platform_device *pdev)
   246	{
   247		chromeos_acpi_gpio_groups = get_gpio_pkg_num(&pdev->dev);
   248	
   249		/* If platform has more GPIO attribute groups than the number of
   250		 * groups this driver supports, give out a warning message.
   251		 */
   252		if (chromeos_acpi_gpio_groups > (ARRAY_SIZE(chromeos_acpi_all_groups) - 2))
   253			dev_warn(&(pdev->dev), "Only %ld GPIO attr groups supported by the driver out of total %d.\n",
 > 254				 (ARRAY_SIZE(chromeos_acpi_all_groups) - 2), chromeos_acpi_gpio_groups);
   255		return 0;
   256	}
   257	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78B95ADA32
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 22:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiIEUbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 16:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbiIEUa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 16:30:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F954BB8;
        Mon,  5 Sep 2022 13:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662409855; x=1693945855;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rm1ex5gUDtu5627ACnqDS0Zd1JuwOajS+QeL6Xswg5A=;
  b=i5VfDOC/GrZw8aG7cF9R/8b5+STy86Khrydi+ZXq42sNLo0Rte0kkrE1
   C83gCKueHpalNI85K5IqKa0Y5PnzxVyj+QC/SwTHzS19CrfEJAmgB0zCq
   dj0xkNAitWdsiBz+OPO0CuibwBHRIwraRTlwR7p0r/RAqmdWI4qp+tIcO
   fG50b9UAjcy3Y8CL4zjOi6fzNtp7fIYF0zxwVTUUC+bQrzPwO4VGMHGai
   HW/ZdhpopOLLZqnW0cmkowZFjrEgbBDjuYMteOrrfmwLhBW+fIksxUcAl
   5witWQ9mHJmwUggkcHSyIDW3sfGvNwfKoD/RPCH4QIYvSv44WHLuCrXG6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="276845545"
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="276845545"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 13:30:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="682160454"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 05 Sep 2022 13:30:52 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVIk8-0004WD-03;
        Mon, 05 Sep 2022 20:30:52 +0000
Date:   Tue, 6 Sep 2022 04:30:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aleksa Savic <savicaleksa83@gmail.com>, linux-hwmon@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer High Flow Next
Message-ID: <202209060417.oElADHt3-lkp@intel.com>
References: <20220905142521.6674-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905142521.6674-1-savicaleksa83@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aleksa,

I love your patch! Yet something to improve:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on next-20220901]
[cannot apply to linus/master v6.0-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aleksa-Savic/hwmon-aquacomputer_d5next-Add-support-for-Aquacomputer-High-Flow-Next/20220905-222744
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
config: arc-randconfig-r043-20220905 (https://download.01.org/0day-ci/archive/20220906/202209060417.oElADHt3-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0a43ba8acd8bcd54afd03ea6149d54fc99fe284c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Aleksa-Savic/hwmon-aquacomputer_d5next-Add-support-for-Aquacomputer-High-Flow-Next/20220905-222744
        git checkout 0a43ba8acd8bcd54afd03ea6149d54fc99fe284c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/hwmon/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/hwmon/aquacomputer_d5next.c:38:10: error: 'highflownext' undeclared here (not in a function)
      38 |         [highflownext] = "highflownext"
         |          ^~~~~~~~~~~~
>> drivers/hwmon/aquacomputer_d5next.c:38:10: error: array index in initializer not of integer type
   drivers/hwmon/aquacomputer_d5next.c:38:10: note: (near initialization for 'aqc_device_names')
   drivers/hwmon/aquacomputer_d5next.c: In function 'aqc_probe':
>> drivers/hwmon/aquacomputer_d5next.c:924:14: error: 'USB_PRODUCT_ID_HIGHFLOWNEXT' undeclared (first use in this function); did you mean 'USB_PRODUCT_ID_D5NEXT'?
     924 |         case USB_PRODUCT_ID_HIGHFLOWNEXT:
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |              USB_PRODUCT_ID_D5NEXT
   drivers/hwmon/aquacomputer_d5next.c:924:14: note: each undeclared identifier is reported only once for each function it appears in
   In file included from drivers/hwmon/aquacomputer_d5next.c:15:
   drivers/hwmon/aquacomputer_d5next.c: At top level:
>> drivers/hwmon/aquacomputer_d5next.c:993:54: error: 'USB_PRODUCT_ID_HIGHFLOWNEXT' undeclared here (not in a function); did you mean 'USB_PRODUCT_ID_D5NEXT'?
     993 |         { HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_HIGHFLOWNEXT) },
         |                                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/hid.h:713:54: note: in definition of macro 'HID_USB_DEVICE'
     713 |         .bus = BUS_USB, .vendor = (ven), .product = (prod)
         |                                                      ^~~~


vim +/highflownext +38 drivers/hwmon/aquacomputer_d5next.c

    31	
    32	static const char *const aqc_device_names[] = {
    33		[d5next] = "d5next",
    34		[farbwerk] = "farbwerk",
    35		[farbwerk360] = "farbwerk360",
    36		[octo] = "octo",
    37		[quadro] = "quadro",
  > 38		[highflownext] = "highflownext"
    39	};
    40	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

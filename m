Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B5C5AE641
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 13:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbiIFLM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 07:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbiIFLMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 07:12:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303AB792EC;
        Tue,  6 Sep 2022 04:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662462742; x=1693998742;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bp/QZXCFTZwQSDShcDQGV6IwRcbjBetyV2jm9TRX0io=;
  b=VoehulZuL8OokP2qgK6MT6s+3qUcC1ODTaa+VvMjtODkGTb3A9WVmBr9
   1LJXEdGSvxmQutmE5HwnHpZwqK9L19ZqNaQQVeM1bay0tNkz14LQvjSx0
   Uu0o/8xlnoVxmosZxAmsALjFmO6qFT40ES/XGBAuTnrvQf+ZbdyhdLmic
   Z6lLiw3qgMEOE4/VkPAOfzYGel3qD2y/H7hyGXl+3iNt12KTz9Q2SUKsm
   cCqv2PNFMVAWVB92ZYaI0MhOTPxmdcR+YZ59sGKLag2eGV080SMDKLISr
   oBxVtZUhgHRoGLRZv85rCfsqj57f7xc+VewRHNd/hntKaFKy3blvQ3FlQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="382860796"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="382860796"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 04:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="756332691"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 06 Sep 2022 04:12:19 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVWV9-00052h-0S;
        Tue, 06 Sep 2022 11:12:19 +0000
Date:   Tue, 6 Sep 2022 19:11:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aleksa Savic <savicaleksa83@gmail.com>, linux-hwmon@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer High Flow Next
Message-ID: <202209061853.1eqL4nKA-lkp@intel.com>
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
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220906/202209061853.1eqL4nKA-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0a43ba8acd8bcd54afd03ea6149d54fc99fe284c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Aleksa-Savic/hwmon-aquacomputer_d5next-Add-support-for-Aquacomputer-High-Flow-Next/20220905-222744
        git checkout 0a43ba8acd8bcd54afd03ea6149d54fc99fe284c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kvm/ drivers/hwmon/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/hwmon/aquacomputer_d5next.c:38:3: error: use of undeclared identifier 'highflownext'
           [highflownext] = "highflownext"
            ^
   drivers/hwmon/aquacomputer_d5next.c:425:8: error: use of undeclared identifier 'highflownext'
                   case highflownext:
                        ^
   drivers/hwmon/aquacomputer_d5next.c:443:8: error: use of undeclared identifier 'highflownext'
                   case highflownext:
                        ^
   drivers/hwmon/aquacomputer_d5next.c:465:8: error: use of undeclared identifier 'highflownext'
                   case highflownext:
                        ^
   drivers/hwmon/aquacomputer_d5next.c:736:7: error: use of undeclared identifier 'highflownext'
           case highflownext:
                ^
>> drivers/hwmon/aquacomputer_d5next.c:924:7: error: use of undeclared identifier 'USB_PRODUCT_ID_HIGHFLOWNEXT'
           case USB_PRODUCT_ID_HIGHFLOWNEXT:
                ^
   drivers/hwmon/aquacomputer_d5next.c:925:16: error: use of undeclared identifier 'highflownext'
                   priv->kind = highflownext;
                                ^
   drivers/hwmon/aquacomputer_d5next.c:993:47: error: use of undeclared identifier 'USB_PRODUCT_ID_HIGHFLOWNEXT'
           { HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_HIGHFLOWNEXT) },
                                                        ^
>> drivers/hwmon/aquacomputer_d5next.c:997:1: error: definition of variable with array type needs an explicit size or an initializer
   MODULE_DEVICE_TABLE(hid, aqc_table);
   ^
   include/linux/module.h:244:21: note: expanded from macro 'MODULE_DEVICE_TABLE'
   extern typeof(name) __mod_##type##__##name##_device_table               \
                       ^
   <scratch space>:196:1: note: expanded from here
   __mod_hid__aqc_table_device_table
   ^
   9 errors generated.


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

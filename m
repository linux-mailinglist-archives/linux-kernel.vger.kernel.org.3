Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3897A4E2F36
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349728AbiCURlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245499AbiCURlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:41:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5730150E37;
        Mon, 21 Mar 2022 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647884380; x=1679420380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=93ScEXCpyveWIKDjm3CXxJUD3n+Kkxyy8pTNpHBuZjg=;
  b=RC2vxF5HXTAwOBq98TPibdqxiSsoaML0M1R93+v3fyt2jc3k2YJoXziB
   xo7u6ZlOkMj43N3mVrEaWFxNo3g9sAhtfiChnzCwWx5jZPL79hBl+tHqe
   NIWu8W2yoe5bRgV4QZCJGZRmyvbmcUkyKd/+erENui1IPM6C/wBbhZ0FH
   7gZfNa0OZW5A20JVIdX0aV7jkbnZcJH4Epp08+Q5cjgid4kklDb4o+OIw
   kX/CCameEIJr+jLCfQBd0kCvtsvBySzQYifJkcmP401NbxdT/Rq7RSNju
   iA7ILzVH/tJ9XBQf2TyXMPdU9bVgTc75RAuKP+xkBbcDyBC2iiVo7gZ/6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="257561102"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="257561102"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 10:39:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="515015749"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 21 Mar 2022 10:39:15 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWLzu-000I1T-Vq; Mon, 21 Mar 2022 17:39:15 +0000
Date:   Tue, 22 Mar 2022 01:38:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Quan Nguyen <quan@os.amperecomputing.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thu Nguyen <thu@os.amperecomputing.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Subject: Re: [PATCH v7 8/9] mfd: smpro-mfd: Adds Ampere's Altra SMpro MFD
 driver
Message-ID: <202203220139.67ewF74A-lkp@intel.com>
References: <20220321081355.6802-9-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321081355.6802-9-quan@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on groeck-staging/hwmon-next lee-mfd/for-mfd-next v5.17 next-20220321]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Quan-Nguyen/Add-Ampere-s-Altra-SMPro-MFD-and-its-child-drivers/20220321-161811
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 37fd83916da2e4cae03d350015c82a67b1b334c4
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20220322/202203220139.67ewF74A-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 85e9b2687a13d1908aa86d1b89c5ce398a06cd39)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/20d62dfe69d4a3a0cb64bf97df0062d050d6a4d4
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Quan-Nguyen/Add-Ampere-s-Altra-SMPro-MFD-and-its-child-drivers/20220321-161811
        git checkout 20d62dfe69d4a3a0cb64bf97df0062d050d6a4d4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/hwmon/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hwmon/smpro-hwmon.c:378:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
           default:
           ^
   drivers/hwmon/smpro-hwmon.c:378:2: note: insert 'break;' to avoid fall-through
           default:
           ^
           break; 
   1 warning generated.


vim +378 drivers/hwmon/smpro-hwmon.c

91d3fe230bebb1c Quan Nguyen 2022-03-21  359  
91d3fe230bebb1c Quan Nguyen 2022-03-21  360  static umode_t smpro_is_visible(const void *data, enum hwmon_sensor_types type,
91d3fe230bebb1c Quan Nguyen 2022-03-21  361  				u32 attr, int channel)
91d3fe230bebb1c Quan Nguyen 2022-03-21  362  {
91d3fe230bebb1c Quan Nguyen 2022-03-21  363  	const struct smpro_hwmon *hwmon = data;
91d3fe230bebb1c Quan Nguyen 2022-03-21  364  	unsigned int value;
91d3fe230bebb1c Quan Nguyen 2022-03-21  365  	int ret;
91d3fe230bebb1c Quan Nguyen 2022-03-21  366  
91d3fe230bebb1c Quan Nguyen 2022-03-21  367  	switch (type) {
91d3fe230bebb1c Quan Nguyen 2022-03-21  368  	case hwmon_temp:
91d3fe230bebb1c Quan Nguyen 2022-03-21  369  		switch (attr) {
91d3fe230bebb1c Quan Nguyen 2022-03-21  370  		case hwmon_temp_input:
91d3fe230bebb1c Quan Nguyen 2022-03-21  371  		case hwmon_temp_label:
91d3fe230bebb1c Quan Nguyen 2022-03-21  372  		case hwmon_temp_crit:
91d3fe230bebb1c Quan Nguyen 2022-03-21  373  			ret = regmap_read(hwmon->regmap, temperature[channel].reg, &value);
91d3fe230bebb1c Quan Nguyen 2022-03-21  374  			if (ret || value == 0xFFFF)
91d3fe230bebb1c Quan Nguyen 2022-03-21  375  				return 0;
91d3fe230bebb1c Quan Nguyen 2022-03-21  376  		break;
91d3fe230bebb1c Quan Nguyen 2022-03-21  377  		}
91d3fe230bebb1c Quan Nguyen 2022-03-21 @378  	default:
91d3fe230bebb1c Quan Nguyen 2022-03-21  379  		break;
91d3fe230bebb1c Quan Nguyen 2022-03-21  380  	}
91d3fe230bebb1c Quan Nguyen 2022-03-21  381  
91d3fe230bebb1c Quan Nguyen 2022-03-21  382  	return 0444;
91d3fe230bebb1c Quan Nguyen 2022-03-21  383  }
91d3fe230bebb1c Quan Nguyen 2022-03-21  384  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

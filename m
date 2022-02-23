Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3F94C0B55
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 06:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiBWFA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 00:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiBWFAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 00:00:55 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7C060CCD;
        Tue, 22 Feb 2022 21:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645592428; x=1677128428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6FLKm6fp0tyd6+4vW4Mst9f8YW1kXerksPWJZQnchhs=;
  b=mkTRIgGfVowajtjZcwokhZm+kAsW6+MX/JpI+IPNvyifD3UxqLqLipgZ
   79wlQ55GRGMnPdC7/eTEz3QOPTqrkSU70iwOhnLRshpNPnGoC9by/1l+a
   8k5ChUQz7myoLs0rNZQb4wszb25j4NdMQeGJrroK+MeFGg/xg2mHjtsKd
   9DyYPe4rM5eNheFBitL/YgkVeC86ySHgzhQk1NTbRA/LhwczW56KDfsnz
   6utJDtw7dFOoz0txYWNobIgkvEmw861Pc2Ysu4h+dF+VpVMvzULF8FV3Z
   pvHVbn2eD2hrdcE8gHMWDClEgXwebdRqmKVAgqCvCUdZzNaKKGqMW2aEz
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="338320951"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="338320951"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 21:00:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="639175040"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Feb 2022 21:00:16 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMjl9-0000zj-DA; Wed, 23 Feb 2022 05:00:15 +0000
Date:   Wed, 23 Feb 2022 12:59:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] Input: add Imagis touchscreen driver
Message-ID: <202202231213.Vj9yo4tW-lkp@intel.com>
References: <20220222203414.8656-3-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222203414.8656-3-markuss.broks@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markuss,

I love your patch! Perhaps something to improve:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on linux/master robh/for-next linus/master v5.17-rc5 next-20220222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Markuss-Broks/Add-support-for-Imagis-touchscreens/20220223-043645
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20220223/202202231213.Vj9yo4tW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/bc77ee5e0d7309edca7d65925c6afa05334b0b01
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Markuss-Broks/Add-support-for-Imagis-touchscreens/20220223-043645
        git checkout bc77ee5e0d7309edca7d65925c6afa05334b0b01
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/input/touchscreen/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/input/touchscreen/imagis.c:300:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (input_device_enabled(ts->input_dev))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/input/touchscreen/imagis.c:305:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/input/touchscreen/imagis.c:300:2: note: remove the 'if' if its condition is always true
           if (input_device_enabled(ts->input_dev))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/input/touchscreen/imagis.c:296:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   drivers/input/touchscreen/imagis.c:316:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (input_device_enabled(ts->input_dev))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/input/touchscreen/imagis.c:321:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/input/touchscreen/imagis.c:316:2: note: remove the 'if' if its condition is always true
           if (input_device_enabled(ts->input_dev))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/input/touchscreen/imagis.c:312:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   2 warnings generated.


vim +300 drivers/input/touchscreen/imagis.c

   291	
   292	static int __maybe_unused imagis_suspend(struct device *dev)
   293	{
   294		struct i2c_client *client = to_i2c_client(dev);
   295		struct imagis_ts *ts = i2c_get_clientdata(client);
   296		int ret;
   297	
   298		mutex_lock(&ts->input_dev->mutex);
   299	
 > 300		if (input_device_enabled(ts->input_dev))
   301			ret = imagis_stop(ts);
   302	
   303		mutex_unlock(&ts->input_dev->mutex);
   304	
   305		return ret;
   306	}
   307	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

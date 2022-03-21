Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51CB4E25E8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347088AbiCUMDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240270AbiCUMDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:03:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419765E74A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647864139; x=1679400139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nb4WpPSGpi5kBYNPvD9P+MCRBMm3tg3prZemHZxBBzA=;
  b=NU3kqtppC8Td41My7YHweGpdEq9cuvGl91vWc3I+URaFXq6t8MC9Gpfk
   O1KFdSz4Q8fvIYbcyPeD0xxboCX3IRaW+iSgGHIBfM7baAXaceXzCxGCW
   effMUitwhcrgCoNxrY0rHxxrbdFg0mTnNfngUNF7nzxb+66RTIubHkYw1
   LpXc4rSIKRxpH4LSSpePt7ih8E2lGeaLX2Uu6x/ojeuzdQ+/m7XIqmcR4
   UDKcx9OEogPPs9X4C90JNbS1Wf1NEowkRdKDxi8DRwcH/FyEB5SEHOFZK
   t5zjKK0YHlJYK8MNa+k6dMGgJEbFuqj4KsZdNsgMOXT+mz77QQMJgB85U
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="256351114"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="256351114"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 05:01:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="692149100"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2022 05:01:45 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWGjI-000HoK-Hc; Mon, 21 Mar 2022 12:01:44 +0000
Date:   Mon, 21 Mar 2022 20:01:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yusuf Khan <yusisamerican@gmail.com>, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, jasowang@redhat.com,
        mikelley@microsoft.com, mst@redhat.com, gregkh@linuxfoundation.org,
        javier@javigon.com, arnd@arndb.de, will@kernel.org,
        axboe@kernel.dk, Yusuf Khan <yusisamerican@gmail.com>,
        Christoph Grenz <christophg+lkml@grenz-bonn.de>
Subject: Re: [PATCH v8 1/2] drivers: ddcci: upstream DDCCI driver
Message-ID: <202203211954.b6DnJ7FO-lkp@intel.com>
References: <20220321031438.14762-1-yusisamerican@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321031438.14762-1-yusisamerican@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yusuf,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on linux/master linus/master lee-backlight/for-backlight-next v5.17 next-20220318]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Yusuf-Khan/drivers-ddcci-upstream-DDCCI-driver/20220321-111557
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 37fd83916da2e4cae03d350015c82a67b1b334c4
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20220321/202203211954.b6DnJ7FO-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 85e9b2687a13d1908aa86d1b89c5ce398a06cd39)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/42317fc284bbedc623892f2b20e404df80f8c393
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Yusuf-Khan/drivers-ddcci-upstream-DDCCI-driver/20220321-111557
        git checkout 42317fc284bbedc623892f2b20e404df80f8c393
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/char/ drivers/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/char/ddcci.c:1157:8: warning: result of comparison of constant -1 with expression of type 'const char' is always false [-Wtautological-constant-out-of-range-compare]
                    && (IS_ANY_ID(id->module) || (strcmp(device->module, id->module) == 0))) {
                        ^~~~~~~~~~~~~~~~~~~~~
   drivers/char/ddcci.c:1146:49: note: expanded from macro 'IS_ANY_ID'
   #define IS_ANY_ID(x) (((x)[0] == -1) && ((x)[7] == -1))
                                            ~~~~~~ ^  ~~
   drivers/char/ddcci.c:1157:8: warning: result of comparison of constant -1 with expression of type 'const char' is always false [-Wtautological-constant-out-of-range-compare]
                    && (IS_ANY_ID(id->module) || (strcmp(device->module, id->module) == 0))) {
                        ^~~~~~~~~~~~~~~~~~~~~
   drivers/char/ddcci.c:1146:31: note: expanded from macro 'IS_ANY_ID'
   #define IS_ANY_ID(x) (((x)[0] == -1) && ((x)[7] == -1))
                          ~~~~~~ ^  ~~
   drivers/char/ddcci.c:1156:8: warning: result of comparison of constant -1 with expression of type 'const char' is always false [-Wtautological-constant-out-of-range-compare]
                    && (IS_ANY_ID(id->vendor) || (strcmp(device->vendor, id->vendor) == 0))
                        ^~~~~~~~~~~~~~~~~~~~~
   drivers/char/ddcci.c:1146:49: note: expanded from macro 'IS_ANY_ID'
   #define IS_ANY_ID(x) (((x)[0] == -1) && ((x)[7] == -1))
                                            ~~~~~~ ^  ~~
   drivers/char/ddcci.c:1156:8: warning: result of comparison of constant -1 with expression of type 'const char' is always false [-Wtautological-constant-out-of-range-compare]
                    && (IS_ANY_ID(id->vendor) || (strcmp(device->vendor, id->vendor) == 0))
                        ^~~~~~~~~~~~~~~~~~~~~
   drivers/char/ddcci.c:1146:31: note: expanded from macro 'IS_ANY_ID'
   #define IS_ANY_ID(x) (((x)[0] == -1) && ((x)[7] == -1))
                          ~~~~~~ ^  ~~
   drivers/char/ddcci.c:1155:8: warning: result of comparison of constant -1 with expression of type 'const char' is always false [-Wtautological-constant-out-of-range-compare]
                    && (IS_ANY_ID(id->model) || (strcmp(device->model, id->model) == 0))
                        ^~~~~~~~~~~~~~~~~~~~
   drivers/char/ddcci.c:1146:49: note: expanded from macro 'IS_ANY_ID'
   #define IS_ANY_ID(x) (((x)[0] == -1) && ((x)[7] == -1))
                                            ~~~~~~ ^  ~~
   drivers/char/ddcci.c:1155:8: warning: result of comparison of constant -1 with expression of type 'const char' is always false [-Wtautological-constant-out-of-range-compare]
                    && (IS_ANY_ID(id->model) || (strcmp(device->model, id->model) == 0))
                        ^~~~~~~~~~~~~~~~~~~~
   drivers/char/ddcci.c:1146:31: note: expanded from macro 'IS_ANY_ID'
   #define IS_ANY_ID(x) (((x)[0] == -1) && ((x)[7] == -1))
                          ~~~~~~ ^  ~~
   drivers/char/ddcci.c:1154:8: warning: result of comparison of constant -1 with expression of type 'const char' is always false [-Wtautological-constant-out-of-range-compare]
                    && (IS_ANY_ID(id->type) || (strcmp(device->type, id->type) == 0))
                        ^~~~~~~~~~~~~~~~~~~
   drivers/char/ddcci.c:1146:49: note: expanded from macro 'IS_ANY_ID'
   #define IS_ANY_ID(x) (((x)[0] == -1) && ((x)[7] == -1))
                                            ~~~~~~ ^  ~~
   drivers/char/ddcci.c:1154:8: warning: result of comparison of constant -1 with expression of type 'const char' is always false [-Wtautological-constant-out-of-range-compare]
                    && (IS_ANY_ID(id->type) || (strcmp(device->type, id->type) == 0))
                        ^~~~~~~~~~~~~~~~~~~
   drivers/char/ddcci.c:1146:31: note: expanded from macro 'IS_ANY_ID'
   #define IS_ANY_ID(x) (((x)[0] == -1) && ((x)[7] == -1))
                          ~~~~~~ ^  ~~
   drivers/char/ddcci.c:1153:8: warning: result of comparison of constant -1 with expression of type 'const char' is always false [-Wtautological-constant-out-of-range-compare]
                   if ((IS_ANY_ID(id->prot) || (strcmp(device->prot, id->prot) == 0))
                        ^~~~~~~~~~~~~~~~~~~
   drivers/char/ddcci.c:1146:49: note: expanded from macro 'IS_ANY_ID'
   #define IS_ANY_ID(x) (((x)[0] == -1) && ((x)[7] == -1))
                                            ~~~~~~ ^  ~~
   drivers/char/ddcci.c:1153:8: warning: result of comparison of constant -1 with expression of type 'const char' is always false [-Wtautological-constant-out-of-range-compare]
                   if ((IS_ANY_ID(id->prot) || (strcmp(device->prot, id->prot) == 0))
                        ^~~~~~~~~~~~~~~~~~~
   drivers/char/ddcci.c:1146:31: note: expanded from macro 'IS_ANY_ID'
   #define IS_ANY_ID(x) (((x)[0] == -1) && ((x)[7] == -1))
                          ~~~~~~ ^  ~~
>> drivers/char/ddcci.c:1206:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
           int ret = 0;
               ^
   11 warnings generated.


vim +/ret +1206 drivers/char/ddcci.c

  1201	
  1202	static void ddcci_device_remove(struct device *dev)
  1203	{
  1204		struct ddcci_device	*device = ddcci_verify_device(dev);
  1205		struct ddcci_driver	*driver;
> 1206		int ret = 0;
  1207	
  1208		if (!device)
  1209			return;
  1210		driver = to_ddcci_driver(dev->driver);
  1211	
  1212		if (driver->remove)
  1213			ret = driver->remove(device);
  1214	}
  1215	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

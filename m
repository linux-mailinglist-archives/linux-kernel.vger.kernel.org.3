Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757685ABD9E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 09:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiICHQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 03:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiICHQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 03:16:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546FBAF0E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 00:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662189379; x=1693725379;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Op9p9NGVfJWmcZihtGsnQ/ZjYxQmCDAcbWQvwcBT6ms=;
  b=fxADKwNB3Ws1iB0xyQW1fPKP/LLXXdcVde5p8RiJ8pwL5ckcvfp2WYFu
   OeyABJhYKSSH2zVMTQAf6o/JlQ9x8M0PB7ffuDShU9ufWsU4vT2lECqQo
   Ioy6EA+j8mDjNblVGIzpsexEmy+7y/c04FVWFNBzF4sLVrNekAusuX3Af
   g6lVMuV61AK2dFYFIksM7QOSIcLbl+2i8S6qw4yvBCVGcZgcVbM6xqiJk
   jfmMBRkLTYifT9a6bqbNAdvA91f+VPEnSXOOFB6ddMHyhYXq4wj1hNnn2
   b9ENxykfTP7Rk8YJG5I70bJ2HtM72CmyGDdbwCIJ1WYEaSX/hKrGAsDg9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="276536303"
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="276536303"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 00:16:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="755496759"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 03 Sep 2022 00:16:00 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUNNl-0001Ee-1l;
        Sat, 03 Sep 2022 07:15:57 +0000
Date:   Sat, 3 Sep 2022 15:14:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: [steev:c630-6.0.0-rc3 59/94]
 drivers/power/supply/yoga-c630-ec.c:224:38: error: implicit declaration of
 function 'FIELD_GET'; did you mean 'FOLL_GET'?
Message-ID: <202209031538.opnNa64Y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/steev/linux c630-6.0.0-rc3
head:   012f3cdd2a60528b877305877b52135b0076e028
commit: d280858fe7f3386373027141f4b284fb61acc045 [59/94] power: supply: Add Lenovo Yoga C630 EC driver
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220903/202209031538.opnNa64Y-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/steev/linux/commit/d280858fe7f3386373027141f4b284fb61acc045
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev c630-6.0.0-rc3
        git checkout d280858fe7f3386373027141f4b284fb61acc045
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/power/supply/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/power/supply/yoga-c630-ec.c: In function 'yoga_c630_ec_update_adapter_status':
>> drivers/power/supply/yoga-c630-ec.c:224:38: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
     224 |                 ec->adapter_online = FIELD_GET(LENOVO_EC_ADPT_PRESENT, val);
         |                                      ^~~~~~~~~
         |                                      FOLL_GET
   cc1: some warnings being treated as errors


vim +224 drivers/power/supply/yoga-c630-ec.c

   215	
   216	static int yoga_c630_ec_update_adapter_status(struct yoga_c630_ec *ec)
   217	{
   218		int val;
   219	
   220		mutex_lock(&ec->lock);
   221	
   222		val = yoga_c630_ec_read8(ec, LENOVO_EC_ADPT_STATUS);
   223		if (val > 0)
 > 224			ec->adapter_online = FIELD_GET(LENOVO_EC_ADPT_PRESENT, val);
   225	
   226		mutex_unlock(&ec->lock);
   227	
   228		return val;
   229	}
   230	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

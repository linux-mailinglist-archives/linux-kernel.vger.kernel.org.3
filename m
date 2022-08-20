Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBDF59AAC1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 04:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241923AbiHTCv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 22:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiHTCvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 22:51:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1C1B5E4C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 19:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660963884; x=1692499884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lIWdGRlLgC6lsdpl02nzxXz9mnLvLDWzqkX7ahVNpIg=;
  b=gr5SEveI37USRaHsMA1ektehFFka9nIYmBvhzntPeaQVS80bGPGfAqUq
   2z7XYZwICTsH4wRn6CRcU8kitmvqZKuoBanFWSWJJvYYw1s9uB3I87GPC
   5O4HrMZvTP/aGHbfA8XmCIw3+OziJwlblKNAGn2QieF/+aQqQGgwEXqBP
   Y9jKmlF/dQ9DnikLNRozYg0kZCWq6N/DdJV1IzWzbrgnsn2jVIqOFDZ2N
   4sPYRqZU9Hk1zVp5hkb2iAnUH+/ITvTrLvuzIYuS89AuApU6Q/SAwmmiV
   iCfmUUCg0Pv0yRFFaqazXLign2ck4+3Ku8bnO82oZYWVItMWfKDNcdLtO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="293143866"
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="293143866"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 19:51:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="750716616"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 19 Aug 2022 19:51:21 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPEa1-00023D-0F;
        Sat, 20 Aug 2022 02:51:21 +0000
Date:   Sat, 20 Aug 2022 10:50:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nam Cao <namcaov@gmail.com>, gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, namcaov@gmail.com,
        hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: Re: [PATCH 3/3] staging: rtl8723bs: remove odm_NoiseMonitor.h and
 odm_NoiseMonitor.c
Message-ID: <202208201056.675rcXqe-lkp@intel.com>
References: <3d6124867c546368b961a30f85b56ee6c2600441.1660901124.git.namcaov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d6124867c546368b961a30f85b56ee6c2600441.1660901124.git.namcaov@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nam,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Nam-Cao/staging-rtl8723bs-remove-useless-files/20220819-173916
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 8379cf83fe6d57a12952de6dcaf7a7fbd7b364fc
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220820/202208201056.675rcXqe-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0fdeb2305c40b79975f2c6b683ee5225b3aedf08
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nam-Cao/staging-rtl8723bs-remove-useless-files/20220819-173916
        git checkout 0fdeb2305c40b79975f2c6b683ee5225b3aedf08
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/staging/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   make[4]: *** [scripts/Makefile.build:249: drivers/staging/rtl8723bs/core/rtw_ieee80211.o] Error 1
   make[4]: *** [scripts/Makefile.build:249: drivers/staging/rtl8723bs/core/rtw_pwrctrl.o] Error 1
   make[4]: *** [scripts/Makefile.build:249: drivers/staging/rtl8723bs/core/rtw_mlme_ext.o] Error 1
>> make[4]: *** No rule to make target 'drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.o', needed by 'drivers/staging/rtl8723bs/r8723bs.o'.
   make[4]: *** [scripts/Makefile.build:249: drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.o] Error 1
   make[4]: *** [scripts/Makefile.build:249: drivers/staging/rtl8723bs/os_dep/sdio_intf.o] Error 1
   make[4]: *** [scripts/Makefile.build:249: drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.o] Error 1
   make[4]: *** [scripts/Makefile.build:249: drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.o] Error 1
   make[4]: Target '__build' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

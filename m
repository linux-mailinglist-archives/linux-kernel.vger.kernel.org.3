Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C085D59A705
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 22:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350237AbiHSUTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348895AbiHSUTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:19:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A20BD1261
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660940353; x=1692476353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6+2161DsryQM8jOmpn2VWLpodX7I2xCD9ga5Tu4weio=;
  b=fr86+iasiV2buqf+kuk73ql/a10Dl6dBxxJVZz1qE+F/hup8s6UDprqf
   oZir0CF4SJdF5PJv+eWpPLiD6YiiBZGSWVQSw47Zk999ogJAm2qPmDs0C
   2HwxCNy6tLXViyRob2vv+4PhYREtUhe+WF9buteVBJn/4cmCdT/mDm5NO
   EEEvL1H81VE3o6rmGQGBQ9ssbwhRQneHrXnMj+U8+wD3/6JLQYXrXSY/f
   EdUd46poosQIrftkQjfyWHyhKSS21h55p+aMocGJBdHAm3y/k6/zSCMC6
   GhGyRkdTwdccAP6t8YpNB9Je3UVR+VB4REp0epPXbLvmdDHAXiGJ8/1Zp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="319123073"
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="319123073"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 13:19:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="676565820"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Aug 2022 13:19:10 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oP8SU-0001mF-0A;
        Fri, 19 Aug 2022 20:19:10 +0000
Date:   Sat, 20 Aug 2022 04:18:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nam Cao <namcaov@gmail.com>, gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, namcaov@gmail.com,
        hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: Re: [PATCH 3/3] staging: rtl8723bs: remove odm_NoiseMonitor.h and
 odm_NoiseMonitor.c
Message-ID: <202208200447.kdEhBy9a-lkp@intel.com>
References: <3d6124867c546368b961a30f85b56ee6c2600441.1660901124.git.namcaov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d6124867c546368b961a30f85b56ee6c2600441.1660901124.git.namcaov@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220820/202208200447.kdEhBy9a-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/0fdeb2305c40b79975f2c6b683ee5225b3aedf08
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nam-Cao/staging-rtl8723bs-remove-useless-files/20220819-173916
        git checkout 0fdeb2305c40b79975f2c6b683ee5225b3aedf08
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash M=drivers/staging

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> make[3]: *** No rule to make target 'drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.o', needed by 'drivers/staging/rtl8723bs/r8723bs.o'.
   make[3]: Target '__build' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

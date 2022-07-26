Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13D058123E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238914AbiGZLmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbiGZLmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:42:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90533286FE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658835729; x=1690371729;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1eAMO79FZmXRs+wzcth+Dhmn3RYc+zrDBkKBafUDChk=;
  b=dUiLr4bFiF9aN+vwl3bQ9kd6pQl5QcuNnTXtUsKsGN+eApHzyB+oPV1s
   SrLxo1qcwydMB3zqSdoyAd7EICLzZKczBiiGOkNnR0MYL5Qd5uQ2qKkrq
   FFUeCK1U9cjayoZzP1FL7R6LJhvCo9PxKRhQdhan/DwffnKTy+YFywi3T
   u/BjOIb1iOUR8piT88yDEc9n8Eq78nTD2z0Wu7AGxKO9CN7WnGfpDcARz
   1FGDaXAAoStH/ChFJufOrSdOVRbKW6DJjmbnKxp2DwSeD64Y72OSXWMtf
   JlRpTELkDAPdHkXUy2flixrU+RvL18MLM/VbG/o3ngJvqpeMXsV9HefUz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="286689095"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="286689095"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 04:42:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="627868091"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Jul 2022 04:42:05 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGIwv-0006km-0L;
        Tue, 26 Jul 2022 11:42:05 +0000
Date:   Tue, 26 Jul 2022 19:42:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manisha Chinthapally <manisha.chinthapally@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Faycal Benmlih <faycal.benmlih@intel.com>
Subject: drivers/platform/x86/socwatch/sw_trace_notifier_provider.c:1405:6:
 sparse: sparse: symbol 'sw_handle_wakelock_i' was not declared. Should it be
 static?
Message-ID: <202207261924.uOL8Ab8K-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manisha,

First bad commit (maybe != root cause):

tree:   https://github.com/mchinth/linux sep_socwatch_linux_5_10
head:   c55df4a2b60fc7c6c4d00fd9f9fb447087833513
commit: 4a8adda8065c4c6944ffedd3025605c845c262a5 SEP/SOCWATCH resolve build errors after rebasing to linux v5.6-rc3
date:   1 year, 10 months ago
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220726/202207261924.uOL8Ab8K-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/mchinth/linux/commit/4a8adda8065c4c6944ffedd3025605c845c262a5
        git remote add mchinth https://github.com/mchinth/linux
        git fetch --no-tags mchinth sep_socwatch_linux_5_10
        git checkout 4a8adda8065c4c6944ffedd3025605c845c262a5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/x86/socwatch/sw_trace_notifier_provider.c:1405:6: sparse: sparse: symbol 'sw_handle_wakelock_i' was not declared. Should it be static?
   drivers/platform/x86/socwatch/sw_trace_notifier_provider.c:1634:67: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t @@
   drivers/platform/x86/socwatch/sw_trace_notifier_provider.c:1634:67: sparse:     expected unsigned int flags
   drivers/platform/x86/socwatch/sw_trace_notifier_provider.c:1634:67: sparse:     got restricted gfp_t

vim +/sw_handle_wakelock_i +1405 drivers/platform/x86/socwatch/sw_trace_notifier_provider.c

d605aabab41663c Jon Moeller 2018-11-13 @1405  void sw_handle_wakelock_i(int cpu, struct sw_trace_notifier_data *node,

:::::: The code at line 1405 was first introduced by commit
:::::: d605aabab41663c9be9e8c549042933189adbf2f platform/x86: add sep and socwatch drivers without socperf.

:::::: TO: Jon Moeller <jon.moeller@intel.com>
:::::: CC: Faycal Benmlih <faycal.benmlih@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

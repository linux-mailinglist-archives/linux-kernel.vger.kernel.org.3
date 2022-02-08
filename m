Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2024AD7FA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355504AbiBHLz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbiBHLz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:55:27 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EC2C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644321326; x=1675857326;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Aua2rjiysQQtK4U9pOgSgAqjtr8NAm7ZS/tNhvRrFZk=;
  b=jOpiRQH7WCZ61JlqgWFIO88JRaoGRjWVaUaDkFQMPUed4DEymCwqJsxp
   j+gJCfgtOFeAoQhCkystyM26FxDnfYAZnMoYYyxKYYTO6TbQF3rteILeq
   Gi/Ta9gYV7/YYAL2FrTKr5K+HrExrADDkJyIP/miqIv1nCJkWP06+85MH
   qxyVP6f3kym/+5THgo4zfEuG1pyEkOEAX0fmMmvwIotdublHdjN9Ao9RH
   fnVjJV3WZGa0sorqkWZ3J+2gGLZRvkhfb0IQzVgeGxCAXBXh4kDA9EzLp
   eLNFUSPHhBaVSGn7vVDwFNEHc6OlULRpxZ3P4XCrfYduan5e+pT4FUfXf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="309676804"
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="309676804"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 03:55:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="540567147"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 08 Feb 2022 03:55:25 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHP5g-000085-Ch; Tue, 08 Feb 2022 11:55:24 +0000
Date:   Tue, 8 Feb 2022 19:55:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manisha Chinthapally <manisha.chinthapally@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mchinth:sep_socwatch_linux_5_10 1/2]
 drivers/platform/x86/sepdk/pax/pax.c:763:18: sparse: sparse: cast removes
 address space '__user' of expression
Message-ID: <202202081901.wpMee2f6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi Manisha,

First bad commit (maybe != root cause):

tree:   https://github.com/mchinth/linux sep_socwatch_linux_5_10
head:   c55df4a2b60fc7c6c4d00fd9f9fb447087833513
commit: 50ccb9f3611a1cff43d9df2e2b303f817ad00a4d [1/2] platform/x86: Update SEP driver for 5.10 pull
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220208/202202081901.wpMee2f6-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/mchinth/linux/commit/50ccb9f3611a1cff43d9df2e2b303f817ad00a4d
        git remote add mchinth https://github.com/mchinth/linux
        git fetch --no-tags mchinth sep_socwatch_linux_5_10
        git checkout 50ccb9f3611a1cff43d9df2e2b303f817ad00a4d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/x86/sepdk/pax/ drivers/platform/x86/sepdk/sep/ drivers/platform/x86/socperf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/platform/x86/sepdk/pax/pax.c:763:18: sparse: sparse: cast removes address space '__user' of expression
   drivers/platform/x86/sepdk/pax/pax.c:765:18: sparse: sparse: cast removes address space '__user' of expression

vim +/__user +763 drivers/platform/x86/sepdk/pax/pax.c

d605aabab41663 Jon Moeller 2018-11-13  741  
d605aabab41663 Jon Moeller 2018-11-13  742  #if defined(CONFIG_COMPAT) && defined(DRV_EM64T)
d605aabab41663 Jon Moeller 2018-11-13  743  static IOCTL_OP_TYPE pax_Device_Control_Compat(struct file *filp,
d605aabab41663 Jon Moeller 2018-11-13  744  					       unsigned int cmd,
d605aabab41663 Jon Moeller 2018-11-13  745  					       unsigned long arg)
d605aabab41663 Jon Moeller 2018-11-13  746  {
d605aabab41663 Jon Moeller 2018-11-13  747  	int status = OS_SUCCESS;
d605aabab41663 Jon Moeller 2018-11-13  748  	IOCTL_COMPAT_ARGS_NODE local_args_compat;
d605aabab41663 Jon Moeller 2018-11-13  749  	IOCTL_ARGS_NODE local_args;
d605aabab41663 Jon Moeller 2018-11-13  750  
d605aabab41663 Jon Moeller 2018-11-13  751  	memset(&local_args_compat, 0, sizeof(IOCTL_COMPAT_ARGS_NODE));
d605aabab41663 Jon Moeller 2018-11-13  752  	if (arg) {
d605aabab41663 Jon Moeller 2018-11-13  753  		status = copy_from_user(&local_args_compat,
d605aabab41663 Jon Moeller 2018-11-13  754  					(void __user *)arg,
d605aabab41663 Jon Moeller 2018-11-13  755  					sizeof(IOCTL_COMPAT_ARGS_NODE));
d605aabab41663 Jon Moeller 2018-11-13  756  		if (status != OS_SUCCESS)
d605aabab41663 Jon Moeller 2018-11-13  757  			return status;
d605aabab41663 Jon Moeller 2018-11-13  758  	}
d605aabab41663 Jon Moeller 2018-11-13  759  
d605aabab41663 Jon Moeller 2018-11-13  760  	local_args.len_drv_to_usr = local_args_compat.len_drv_to_usr;
d605aabab41663 Jon Moeller 2018-11-13  761  	local_args.len_usr_to_drv = local_args_compat.len_usr_to_drv;
d605aabab41663 Jon Moeller 2018-11-13  762  	local_args.buf_drv_to_usr =
d605aabab41663 Jon Moeller 2018-11-13 @763  		(char *)compat_ptr(local_args_compat.buf_drv_to_usr);
d605aabab41663 Jon Moeller 2018-11-13  764  	local_args.buf_usr_to_drv =
d605aabab41663 Jon Moeller 2018-11-13  765  		(char *)compat_ptr(local_args_compat.buf_usr_to_drv);
d605aabab41663 Jon Moeller 2018-11-13  766  
d605aabab41663 Jon Moeller 2018-11-13  767  	local_args.command = cmd;
d605aabab41663 Jon Moeller 2018-11-13  768  
d605aabab41663 Jon Moeller 2018-11-13  769  	status = pax_Service_IOCTL(filp, cmd, local_args);
d605aabab41663 Jon Moeller 2018-11-13  770  
d605aabab41663 Jon Moeller 2018-11-13  771  	return status;
d605aabab41663 Jon Moeller 2018-11-13  772  }
d605aabab41663 Jon Moeller 2018-11-13  773  #endif
d605aabab41663 Jon Moeller 2018-11-13  774  

:::::: The code at line 763 was first introduced by commit
:::::: d605aabab41663c9be9e8c549042933189adbf2f platform/x86: add sep and socwatch drivers without socperf.

:::::: TO: Jon Moeller <jon.moeller@intel.com>
:::::: CC: Faycal Benmlih <faycal.benmlih@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

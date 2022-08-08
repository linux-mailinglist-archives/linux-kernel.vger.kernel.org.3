Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940F658C452
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241712AbiHHHnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235975AbiHHHnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:43:22 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D83CA188
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 00:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659944601; x=1691480601;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4t6SeN7/XT2pFdBjQy0fi/TXZap4WFnfdIgGKE3qzmw=;
  b=K918MRwdgwUlxJre5FWrTHgIpabPj10U6uywgTj9tJQZjqjGCmHxwjWm
   shXND25Y6EAXtk5hzmuJLoi7YU/kvwnwUbMhk617tiRUegeLXfl9Am5WA
   556zq2Q5cQ0OngvOPF8mHUHEgMC8/q4zeOcBZrgD4CTeLSxj7X4EvZ9fb
   n4ModmOZaFtqRz1baC/D2L0VndB7N2AIOYrxOU/yjYbtzCKrEh7Ijt/Wa
   Q2jMrmAv6shTn0FelCgkbBb56Kk1Kiv/RcxGX0tgEqcHTQ3vosyydd4Xa
   JBEd3C3rd1WXTpps2TDUcFRAnOurqZJcnKEs0bCH2WKi7lRkk0cKfBEVm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="277459351"
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="277459351"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 00:43:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="580239387"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Aug 2022 00:43:17 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKxPw-000M59-2q;
        Mon, 08 Aug 2022 07:43:16 +0000
Date:   Mon, 8 Aug 2022 15:42:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manisha Chinthapally <manisha.chinthapally@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mchinth:sep_socwatch_linux_5_16 1/1]
 drivers/platform/x86/socperf/socperfdrv.c:1637:17: sparse: sparse: incorrect
 type in initializer (incompatible argument 2 (different address spaces))
Message-ID: <202208081533.vgDU1Isu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/mchinth/linux sep_socwatch_linux_5_16
head:   4cbfca15a262729ae8557758b49226fe4769f582
commit: 4cbfca15a262729ae8557758b49226fe4769f582 [1/1] Platform/x86 Updated SEP/SOCPERF drivers to latest version
config: i386-randconfig-s003 (https://download.01.org/0day-ci/archive/20220808/202208081533.vgDU1Isu-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/mchinth/linux/commit/4cbfca15a262729ae8557758b49226fe4769f582
        git remote add mchinth https://github.com/mchinth/linux
        git fetch --no-tags mchinth sep_socwatch_linux_5_16
        git checkout 4cbfca15a262729ae8557758b49226fe4769f582
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/platform/x86/socperf/socperfdrv.c:208:13: sparse: sparse: function 'SOCPERF_Read_Data3' with external linkage has definition
   drivers/platform/x86/socperf/socperfdrv.c:1175:13: sparse: sparse: function 'lwpmudrv_Stop_Mem' with external linkage has definition
   drivers/platform/x86/socperf/socperfdrv.c:1392:22: sparse: sparse: function 'socperf_Service_IOCTL' with external linkage has definition
   drivers/platform/x86/socperf/socperfdrv.c:1516:13: sparse: sparse: function 'socperf_Device_Control' with external linkage has definition
   drivers/platform/x86/socperf/socperfdrv.c:1602:12: sparse: sparse: function 'SOCPERF_Abnormal_Terminate' with external linkage has definition
   drivers/platform/x86/socperf/socperfdrv.c:104:22: sparse: sparse: symbol 'socperf_drv_version' was not declared. Should it be static?
   drivers/platform/x86/socperf/socperfdrv.c:105:5: sparse: sparse: symbol 'read_unc_ctr_info' was not declared. Should it be static?
   drivers/platform/x86/socperf/socperfdrv.c:106:10: sparse: sparse: symbol 'dispatch_uncore' was not declared. Should it be static?
   drivers/platform/x86/socperf/socperfdrv.c:108:14: sparse: sparse: symbol 'socperf_global_ec' was not declared. Should it be static?
   drivers/platform/x86/socperf/socperfdrv.c:109:14: sparse: sparse: symbol 'socperf_abnormal_terminate' was not declared. Should it be static?
   drivers/platform/x86/socperf/socperfdrv.c:110:11: sparse: sparse: symbol 'socperf_control' was not declared. Should it be static?
   drivers/platform/x86/socperf/socperfdrv.c:114:8: sparse: sparse: symbol 'socperf_pcb_size' was not declared. Should it be static?
   drivers/platform/x86/socperf/socperfdrv.c:246:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int [usertype] * @@
   drivers/platform/x86/socperf/socperfdrv.c:246:18: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/platform/x86/socperf/socperfdrv.c:246:18: sparse:     got unsigned int [usertype] *
   drivers/platform/x86/socperf/socperfdrv.c:246:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int [usertype] * @@
   drivers/platform/x86/socperf/socperfdrv.c:246:18: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/platform/x86/socperf/socperfdrv.c:246:18: sparse:     got unsigned int [usertype] *
   drivers/platform/x86/socperf/socperfdrv.c:328:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void *[usertype] buf_drv_to_usr @@
   drivers/platform/x86/socperf/socperfdrv.c:328:37: sparse:     expected void const [noderef] __user *from
   drivers/platform/x86/socperf/socperfdrv.c:328:37: sparse:     got void *[usertype] buf_drv_to_usr
   drivers/platform/x86/socperf/socperfdrv.c:407:62: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void *[usertype] buf_drv_to_usr @@
   drivers/platform/x86/socperf/socperfdrv.c:407:62: sparse:     expected void const [noderef] __user *from
   drivers/platform/x86/socperf/socperfdrv.c:407:62: sparse:     got void *[usertype] buf_drv_to_usr
   drivers/platform/x86/socperf/socperfdrv.c:559:63: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char *[usertype] buf_usr_to_drv @@
   drivers/platform/x86/socperf/socperfdrv.c:559:63: sparse:     expected void const [noderef] __user *from
   drivers/platform/x86/socperf/socperfdrv.c:559:63: sparse:     got char *[usertype] buf_usr_to_drv
   drivers/platform/x86/socperf/socperfdrv.c:641:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char *[usertype] buf_usr_to_drv @@
   drivers/platform/x86/socperf/socperfdrv.c:641:39: sparse:     expected void const [noderef] __user *from
   drivers/platform/x86/socperf/socperfdrv.c:641:39: sparse:     got char *[usertype] buf_usr_to_drv
   drivers/platform/x86/socperf/socperfdrv.c:742:64: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char *[usertype] buf_usr_to_drv @@
   drivers/platform/x86/socperf/socperfdrv.c:742:64: sparse:     expected void const [noderef] __user *from
   drivers/platform/x86/socperf/socperfdrv.c:742:64: sparse:     got char *[usertype] buf_usr_to_drv
   drivers/platform/x86/socperf/socperfdrv.c:1043:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned int [usertype] * @@
   drivers/platform/x86/socperf/socperfdrv.c:1043:43: sparse:     expected void const [noderef] __user *from
   drivers/platform/x86/socperf/socperfdrv.c:1043:43: sparse:     got unsigned int [usertype] *
   drivers/platform/x86/socperf/socperfdrv.c:1066:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got char *[usertype] buf_drv_to_usr @@
   drivers/platform/x86/socperf/socperfdrv.c:1066:29: sparse:     expected void [noderef] __user *to
   drivers/platform/x86/socperf/socperfdrv.c:1066:29: sparse:     got char *[usertype] buf_drv_to_usr
   drivers/platform/x86/socperf/socperfdrv.c:1089:28: sparse: sparse: Using plain integer as NULL pointer
   drivers/platform/x86/socperf/socperfdrv.c:1100:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got char *[usertype] buf_drv_to_usr @@
   drivers/platform/x86/socperf/socperfdrv.c:1100:29: sparse:     expected void [noderef] __user *to
   drivers/platform/x86/socperf/socperfdrv.c:1100:29: sparse:     got char *[usertype] buf_drv_to_usr
   drivers/platform/x86/socperf/socperfdrv.c:1135:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned long long [usertype] * @@
   drivers/platform/x86/socperf/socperfdrv.c:1135:45: sparse:     expected void const [noderef] __user *from
   drivers/platform/x86/socperf/socperfdrv.c:1135:45: sparse:     got unsigned long long [usertype] *
   drivers/platform/x86/socperf/socperfdrv.c:1154:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got char *[usertype] buf_drv_to_usr @@
   drivers/platform/x86/socperf/socperfdrv.c:1154:29: sparse:     expected void [noderef] __user *to
   drivers/platform/x86/socperf/socperfdrv.c:1154:29: sparse:     got char *[usertype] buf_drv_to_usr
   drivers/platform/x86/socperf/socperfdrv.c:1175:13: sparse: sparse: symbol 'lwpmudrv_Stop_Mem' was not declared. Should it be static?
   drivers/platform/x86/socperf/socperfdrv.c:1286:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char *[usertype] buf_usr_to_drv @@
   drivers/platform/x86/socperf/socperfdrv.c:1286:54: sparse:     expected void const [noderef] __user *from
   drivers/platform/x86/socperf/socperfdrv.c:1286:54: sparse:     got char *[usertype] buf_usr_to_drv
   drivers/platform/x86/socperf/socperfdrv.c:1310:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got char *[usertype] buf_drv_to_usr @@
   drivers/platform/x86/socperf/socperfdrv.c:1310:30: sparse:     expected void [noderef] __user *to
   drivers/platform/x86/socperf/socperfdrv.c:1310:30: sparse:     got char *[usertype] buf_drv_to_usr
   drivers/platform/x86/socperf/socperfdrv.c:1348:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got char *buf @@
   drivers/platform/x86/socperf/socperfdrv.c:1348:26: sparse:     expected void [noderef] __user *to
   drivers/platform/x86/socperf/socperfdrv.c:1348:26: sparse:     got char *buf
   drivers/platform/x86/socperf/socperfdrv.c:1368:76: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char const * @@
   drivers/platform/x86/socperf/socperfdrv.c:1368:76: sparse:     expected void const [noderef] __user *from
   drivers/platform/x86/socperf/socperfdrv.c:1368:76: sparse:     got char const *
   drivers/platform/x86/socperf/socperfdrv.c:1392:22: sparse: sparse: symbol 'socperf_Service_IOCTL' was not declared. Should it be static?
   drivers/platform/x86/socperf/socperfdrv.c:1537:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct IOCTL_ARGS_NODE_S [usertype] *[usertype] @@
   drivers/platform/x86/socperf/socperfdrv.c:1537:55: sparse:     expected void const [noderef] __user *from
   drivers/platform/x86/socperf/socperfdrv.c:1537:55: sparse:     got struct IOCTL_ARGS_NODE_S [usertype] *[usertype]
   drivers/platform/x86/socperf/socperfdrv.c:1516:13: sparse: sparse: symbol 'socperf_Device_Control' was not declared. Should it be static?
   drivers/platform/x86/socperf/socperfdrv.c:1602:12: sparse: sparse: symbol 'SOCPERF_Abnormal_Terminate' was not declared. Should it be static?
>> drivers/platform/x86/socperf/socperfdrv.c:1637:17: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected int ( *read )( ... ) @@     got int ( * )( ... ) @@
   drivers/platform/x86/socperf/socperfdrv.c:1637:17: sparse:     expected int ( *read )( ... )
   drivers/platform/x86/socperf/socperfdrv.c:1637:17: sparse:     got int ( * )( ... )
>> drivers/platform/x86/socperf/socperfdrv.c:1638:18: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected int ( *write )( ... ) @@     got int ( * )( ... ) @@
   drivers/platform/x86/socperf/socperfdrv.c:1638:18: sparse:     expected int ( *write )( ... )
   drivers/platform/x86/socperf/socperfdrv.c:1638:18: sparse:     got int ( * )( ... )

vim +1637 drivers/platform/x86/socperf/socperfdrv.c

f57492d07625ddd Manisha Chinthapally 2019-05-01  1619  
f57492d07625ddd Manisha Chinthapally 2019-05-01  1620  /*****************************************************************************************
f57492d07625ddd Manisha Chinthapally 2019-05-01  1621   *
f57492d07625ddd Manisha Chinthapally 2019-05-01  1622   *   Driver Entry / Exit functions that will be called on when the driver is loaded and
f57492d07625ddd Manisha Chinthapally 2019-05-01  1623   *   unloaded
f57492d07625ddd Manisha Chinthapally 2019-05-01  1624   *
f57492d07625ddd Manisha Chinthapally 2019-05-01  1625   ****************************************************************************************/
f57492d07625ddd Manisha Chinthapally 2019-05-01  1626  
f57492d07625ddd Manisha Chinthapally 2019-05-01  1627  /*
f57492d07625ddd Manisha Chinthapally 2019-05-01  1628   * Structure that declares the usual file access functions
f57492d07625ddd Manisha Chinthapally 2019-05-01  1629   * First one is for lwpmu_c, the control functions
f57492d07625ddd Manisha Chinthapally 2019-05-01  1630   */
f57492d07625ddd Manisha Chinthapally 2019-05-01  1631  static struct file_operations socperf_Fops = {
f57492d07625ddd Manisha Chinthapally 2019-05-01  1632  	.owner = THIS_MODULE,
f57492d07625ddd Manisha Chinthapally 2019-05-01  1633  	IOCTL_OP = socperf_Device_Control,
f57492d07625ddd Manisha Chinthapally 2019-05-01  1634  #if defined(CONFIG_COMPAT) && defined(DRV_EM64T)
f57492d07625ddd Manisha Chinthapally 2019-05-01  1635  	.compat_ioctl = socperf_Device_Control_Compat,
f57492d07625ddd Manisha Chinthapally 2019-05-01  1636  #endif
f57492d07625ddd Manisha Chinthapally 2019-05-01 @1637  	.read = socperf_Read,
f57492d07625ddd Manisha Chinthapally 2019-05-01 @1638  	.write = socperf_Write,
f57492d07625ddd Manisha Chinthapally 2019-05-01  1639  	.open = socperf_Open,
f57492d07625ddd Manisha Chinthapally 2019-05-01  1640  	.release = NULL,
f57492d07625ddd Manisha Chinthapally 2019-05-01  1641  	.llseek = NULL,
f57492d07625ddd Manisha Chinthapally 2019-05-01  1642  };
f57492d07625ddd Manisha Chinthapally 2019-05-01  1643  

:::::: The code at line 1637 was first introduced by commit
:::::: f57492d07625dddac7920eccdb5be08c55ee16fa platform/x86: SOCPERF3 support for sep & socwatch

:::::: TO: Manisha Chinthapally <manisha.chinthapally@intel.com>
:::::: CC: Faycal Benmlih <faycal.benmlih@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

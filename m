Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352EC5874BE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 02:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbiHBAOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 20:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiHBAN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 20:13:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F131474F1
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 17:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659399238; x=1690935238;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mH9QTsymrrUuRjEBtWASBE/TGJtDu1kPtUpfsETj/Y8=;
  b=mSWXZqd+q0dv1SCND9BteWzbd9/ZRKDyhq8uCEEKzKjQ40niOQ56g3iQ
   O03Gdg2S8RcyW6rGavXC6OsVW/H2/tWcTKRHzgJ1OY1rYM0cZPMM60VJq
   o3lXo66a/PnT0/rpbZPgED3uXqZTKk8LrQmj4T3U7cUps0rNni/uWr6W2
   FofRzAVLAXnh72epNyjAFps1Mac4a2Ho9W2D8MuNIPZuN3YZWQs4m+PfI
   D2KNcjg/iFFiKRXyrSwpJzhXSjGFQdydH+EjRbltZJjoHsUs4p8hvQuvi
   a+3I1yGPYjFCTCqgyUVt01balcQKkiNB9IdKeNj6cpzbVcD/rDJtItr+V
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="288037009"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="288037009"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 17:13:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="661385791"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Aug 2022 17:13:56 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIfXn-000FVL-32;
        Tue, 02 Aug 2022 00:13:55 +0000
Date:   Tue, 2 Aug 2022 08:13:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manisha Chinthapally <manisha.chinthapally@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mchinth:sep_socwatch_linux_5_16 1/1]
 drivers/platform/x86/socperf/socperfdrv.c:1551:13: sparse: sparse: function
 'socperf_Device_Control_Compat' with external linkage has definition
Message-ID: <202208020830.a08LyvcZ-lkp@intel.com>
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

tree:   https://github.com/mchinth/linux sep_socwatch_linux_5_16
head:   4cbfca15a262729ae8557758b49226fe4769f582
commit: 4cbfca15a262729ae8557758b49226fe4769f582 [1/1] Platform/x86 Updated SEP/SOCPERF drivers to latest version
config: x86_64-randconfig-s023 (https://download.01.org/0day-ci/archive/20220802/202208020830.a08LyvcZ-lkp@intel.com/config)
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
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/platform/x86/socperf/socperfdrv.c:208:13: sparse: sparse: function 'SOCPERF_Read_Data3' with external linkage has definition
   drivers/platform/x86/socperf/socperfdrv.c:1175:13: sparse: sparse: function 'lwpmudrv_Stop_Mem' with external linkage has definition
   drivers/platform/x86/socperf/socperfdrv.c:1392:22: sparse: sparse: function 'socperf_Service_IOCTL' with external linkage has definition
   drivers/platform/x86/socperf/socperfdrv.c:1516:13: sparse: sparse: function 'socperf_Device_Control' with external linkage has definition
>> drivers/platform/x86/socperf/socperfdrv.c:1551:13: sparse: sparse: function 'socperf_Device_Control_Compat' with external linkage has definition
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
>> drivers/platform/x86/socperf/socperfdrv.c:1570:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct IOCTL_COMPAT_ARGS_NODE_S [usertype] *[usertype] @@
   drivers/platform/x86/socperf/socperfdrv.c:1570:42: sparse:     expected void const [noderef] __user *from
   drivers/platform/x86/socperf/socperfdrv.c:1570:42: sparse:     got struct IOCTL_COMPAT_ARGS_NODE_S [usertype] *[usertype]
   drivers/platform/x86/socperf/socperfdrv.c:1576:18: sparse: sparse: cast removes address space '__user' of expression
   drivers/platform/x86/socperf/socperfdrv.c:1578:18: sparse: sparse: cast removes address space '__user' of expression
   drivers/platform/x86/socperf/socperfdrv.c:1551:13: sparse: sparse: symbol 'socperf_Device_Control_Compat' was not declared. Should it be static?
   drivers/platform/x86/socperf/socperfdrv.c:1602:12: sparse: sparse: symbol 'SOCPERF_Abnormal_Terminate' was not declared. Should it be static?
   drivers/platform/x86/socperf/socperfdrv.c:1637:17: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected long ( *read )( ... ) @@     got long ( * )( ... ) @@
   drivers/platform/x86/socperf/socperfdrv.c:1637:17: sparse:     expected long ( *read )( ... )
   drivers/platform/x86/socperf/socperfdrv.c:1637:17: sparse:     got long ( * )( ... )
   drivers/platform/x86/socperf/socperfdrv.c:1638:18: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected long ( *write )( ... ) @@     got long ( * )( ... ) @@
   drivers/platform/x86/socperf/socperfdrv.c:1638:18: sparse:     expected long ( *write )( ... )
   drivers/platform/x86/socperf/socperfdrv.c:1638:18: sparse:     got long ( * )( ... )

vim +/socperf_Device_Control_Compat +1551 drivers/platform/x86/socperf/socperfdrv.c

  1549	
  1550	#if defined(CONFIG_COMPAT) && defined(DRV_EM64T)
> 1551	extern long socperf_Device_Control_Compat(struct file *filp, unsigned int cmd,
  1552						  unsigned long arg)
  1553	{
  1554		int status = OS_SUCCESS;
  1555		IOCTL_COMPAT_ARGS_NODE local_args_compat;
  1556		IOCTL_ARGS_NODE local_args;
  1557	
  1558		memset(&local_args_compat, 0, sizeof(IOCTL_COMPAT_ARGS_NODE));
  1559		SOCPERF_PRINT_DEBUG("Compat: type: %d, subcommand: %d\n",
  1560				    _IOC_TYPE(cmd), _IOC_NR(cmd));
  1561	
  1562		if (_IOC_TYPE(cmd) != LWPMU_IOC_MAGIC) {
  1563			SOCPERF_PRINT_ERROR("Unknown IOCTL magic:%d\n", _IOC_TYPE(cmd));
  1564			return OS_ILLEGAL_IOCTL;
  1565		}
  1566	
  1567		MUTEX_LOCK(ioctl_lock);
  1568		if (arg) {
  1569			status = copy_from_user(&local_args_compat,
> 1570						(IOCTL_COMPAT_ARGS)arg,
  1571						sizeof(IOCTL_COMPAT_ARGS_NODE));
  1572		}
  1573		local_args.len_drv_to_usr = local_args_compat.len_drv_to_usr;
  1574		local_args.len_usr_to_drv = local_args_compat.len_usr_to_drv;
  1575		local_args.buf_drv_to_usr =
  1576			(char *)compat_ptr(local_args_compat.buf_drv_to_usr);
  1577		local_args.buf_usr_to_drv =
  1578			(char *)compat_ptr(local_args_compat.buf_usr_to_drv);
  1579	
  1580		status = socperf_Service_IOCTL(filp, _IOC_NR(cmd), local_args);
  1581		MUTEX_UNLOCK(ioctl_lock);
  1582	
  1583		return status;
  1584	}
  1585	#endif
  1586	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD945A2C32
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344702AbiHZQVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344358AbiHZQVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:21:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5923BDDA8A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661530891; x=1693066891;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zeUD94L6vzf03SEuEWtO5U0G4Ly82WDmTSzi6wgDTCs=;
  b=U6crNiXsWEQ08dWcwnaJMHlGRnYDVtjEmN7lv5A+L/HCU7GOT8VGgrOe
   HOxTn703HDd0iKom5ZFWPyB7079ogQRfTbpfFRFnRvcCL++Q0HH46gC8U
   3hmDXhoW22zpXg8BSTBr3xlXrh3Tm3pbMoARJt3mPAmFwwmo660cAtdwr
   JLM8MZjser6PlQhTozXfrj7RTI1unTixdV83ZBJpr0rPK0m5JD3yUZKzR
   y4cLesYIvdaDwHEinnticnCyCfZvTpefkUrV4HUDzQToPdkvbMH37C7oY
   /dW8Oi3BJJynqm2I414eUxIA9K5lsJnOoc+C8+oCGFCApZYpDZxEtDW2C
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="356256928"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="356256928"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 09:21:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="938805714"
Received: from lkp-server01.sh.intel.com (HELO 71b0d3b5b1bc) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Aug 2022 09:21:02 -0700
Received: from kbuild by 71b0d3b5b1bc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRc4s-00007Z-0p;
        Fri, 26 Aug 2022 16:21:02 +0000
Date:   Sat, 27 Aug 2022 00:20:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manisha Chinthapally <manisha.chinthapally@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mchinth:sep_socwatch_linux_5_16 1/1]
 drivers/platform/x86/socperf/soc_uncore.c:422:33: sparse: sparse: incorrect
 type in argument 2 (different address spaces)
Message-ID: <202208270006.ciJ67U2J-lkp@intel.com>
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

tree:   https://github.com/mchinth/linux sep_socwatch_linux_5_16
head:   4cbfca15a262729ae8557758b49226fe4769f582
commit: 4cbfca15a262729ae8557758b49226fe4769f582 [1/1] Platform/x86 Updated SEP/SOCPERF drivers to latest version
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220827/202208270006.ciJ67U2J-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/mchinth/linux/commit/4cbfca15a262729ae8557758b49226fe4769f582
        git remote add mchinth https://github.com/mchinth/linux
        git fetch --no-tags mchinth sep_socwatch_linux_5_16
        git checkout 4cbfca15a262729ae8557758b49226fe4769f582
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/platform/x86/socperf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/x86/socperf/soc_uncore.c:422:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/platform/x86/socperf/soc_uncore.c:422:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/platform/x86/socperf/soc_uncore.c:422:33: sparse:     got unsigned int [usertype] *
>> drivers/platform/x86/socperf/soc_uncore.c:593:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/platform/x86/socperf/soc_uncore.c:593:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/platform/x86/socperf/soc_uncore.c:593:26: sparse:     got void *
>> drivers/platform/x86/socperf/soc_uncore.c:890:79: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned long long [usertype] * @@
   drivers/platform/x86/socperf/soc_uncore.c:890:79: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/platform/x86/socperf/soc_uncore.c:890:79: sparse:     got unsigned long long [usertype] *
--
>> drivers/platform/x86/socperf/utility.c:75:13: sparse: sparse: function 'SOCPERF_UTILITY_Read_TSC' with external linkage has definition
>> drivers/platform/x86/socperf/utility.c:104:13: sparse: sparse: function 'SOCPERF_UTILITY_Read_Cpuid' with external linkage has definition
>> drivers/platform/x86/socperf/utility.c:136:17: sparse: sparse: function 'SOCPERF_UTILITY_Configure_CPU' with external linkage has definition
--
>> drivers/platform/x86/socperf/pci.c:76:12: sparse: sparse: function 'SOCPERF_PCI_Read_From_Memory_Address' with external linkage has definition
>> drivers/platform/x86/socperf/pci.c:122:12: sparse: sparse: function 'SOCPERF_PCI_Write_To_Memory_Address' with external linkage has definition
>> drivers/platform/x86/socperf/pci.c:163:12: sparse: sparse: function 'SOCPERF_PCI_Read_Ulong' with external linkage has definition
>> drivers/platform/x86/socperf/pci.c:185:13: sparse: sparse: function 'SOCPERF_PCI_Write_Ulong' with external linkage has definition
>> drivers/platform/x86/socperf/pci.c:94:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[usertype] base @@     got void [noderef] __iomem * @@
   drivers/platform/x86/socperf/pci.c:94:14: sparse:     expected void *[usertype] base
   drivers/platform/x86/socperf/pci.c:94:14: sparse:     got void [noderef] __iomem *
>> drivers/platform/x86/socperf/pci.c:99:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/platform/x86/socperf/pci.c:99:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/platform/x86/socperf/pci.c:99:28: sparse:     got void *
>> drivers/platform/x86/socperf/pci.c:105:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *[usertype] base @@
   drivers/platform/x86/socperf/pci.c:105:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/platform/x86/socperf/pci.c:105:17: sparse:     got void *[usertype] base
   drivers/platform/x86/socperf/pci.c:140:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[usertype] base @@     got void [noderef] __iomem * @@
   drivers/platform/x86/socperf/pci.c:140:14: sparse:     expected void *[usertype] base
   drivers/platform/x86/socperf/pci.c:140:14: sparse:     got void [noderef] __iomem *
>> drivers/platform/x86/socperf/pci.c:145:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/platform/x86/socperf/pci.c:145:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/platform/x86/socperf/pci.c:145:26: sparse:     got void *
   drivers/platform/x86/socperf/pci.c:147:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *[usertype] base @@
   drivers/platform/x86/socperf/pci.c:147:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/platform/x86/socperf/pci.c:147:17: sparse:     got void *[usertype] base
--
>> drivers/platform/x86/socperf/npk_uncore.c:92:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/platform/x86/socperf/npk_uncore.c:92:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/platform/x86/socperf/npk_uncore.c:92:36: sparse:     got unsigned int [usertype] *
>> drivers/platform/x86/socperf/npk_uncore.c:119:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/platform/x86/socperf/npk_uncore.c:119:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/platform/x86/socperf/npk_uncore.c:119:17: sparse:     got unsigned int [usertype] *
>> drivers/platform/x86/socperf/npk_uncore.c:340:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/platform/x86/socperf/npk_uncore.c:340:34: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/platform/x86/socperf/npk_uncore.c:340:34: sparse:     got void *
   drivers/platform/x86/socperf/npk_uncore.c:345:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/platform/x86/socperf/npk_uncore.c:345:34: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/platform/x86/socperf/npk_uncore.c:345:34: sparse:     got void *
--
>> drivers/platform/x86/socperf/pmu_list.c:246:17: sparse: sparse: function 'PMU_LIST_Check_MMIO' with external linkage has definition
>> drivers/platform/x86/socperf/pmu_list.c:303:18: sparse: sparse: function 'PMU_LIST_Initialize' with external linkage has definition
>> drivers/platform/x86/socperf/pmu_list.c:327:18: sparse: sparse: function 'PMU_LIST_Build_MMIO_List' with external linkage has definition
>> drivers/platform/x86/socperf/pmu_list.c:380:18: sparse: sparse: function 'PMU_LIST_Clean_Up' with external linkage has definition
--
>> drivers/platform/x86/socperf/control.c:99:13: sparse: sparse: function 'SOCPERF_Invoke_Cpu' with external linkage has definition
>> drivers/platform/x86/socperf/control.c:127:13: sparse: sparse: function 'SOCPERF_Invoke_Parallel_Service' with external linkage has definition
>> drivers/platform/x86/socperf/control.c:356:13: sparse: sparse: function 'SOCPERF_Memory_Tracker_Init' with external linkage has definition
>> drivers/platform/x86/socperf/control.c:382:13: sparse: sparse: function 'SOCPERF_Memory_Tracker_Free' with external linkage has definition
>> drivers/platform/x86/socperf/control.c:443:13: sparse: sparse: function 'SOCPERF_Memory_Tracker_Compaction' with external linkage has definition
>> drivers/platform/x86/socperf/control.c:582:14: sparse: sparse: function 'SOCPERF_Allocate_Memory' with external linkage has definition
>> drivers/platform/x86/socperf/control.c:646:14: sparse: sparse: function 'SOCPERF_Allocate_KMemory' with external linkage has definition
>> drivers/platform/x86/socperf/control.c:704:14: sparse: sparse: function 'SOCPERF_Free_Memory' with external linkage has definition
--
>> drivers/platform/x86/socperf/haswellunc_sa.c:127:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/platform/x86/socperf/haswellunc_sa.c:127:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/platform/x86/socperf/haswellunc_sa.c:127:33: sparse:     got unsigned int [usertype] *
   drivers/platform/x86/socperf/haswellunc_sa.c:160:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/platform/x86/socperf/haswellunc_sa.c:160:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/platform/x86/socperf/haswellunc_sa.c:160:33: sparse:     got unsigned int [usertype] *
>> drivers/platform/x86/socperf/haswellunc_sa.c:209:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/platform/x86/socperf/haswellunc_sa.c:209:42: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/platform/x86/socperf/haswellunc_sa.c:209:42: sparse:     got unsigned int [usertype] *
   drivers/platform/x86/socperf/haswellunc_sa.c:212:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/platform/x86/socperf/haswellunc_sa.c:212:42: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/platform/x86/socperf/haswellunc_sa.c:212:42: sparse:     got unsigned int [usertype] *
   drivers/platform/x86/socperf/haswellunc_sa.c:220:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/platform/x86/socperf/haswellunc_sa.c:220:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/platform/x86/socperf/haswellunc_sa.c:220:33: sparse:     got unsigned int [usertype] *
   drivers/platform/x86/socperf/haswellunc_sa.c:257:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/platform/x86/socperf/haswellunc_sa.c:257:41: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/platform/x86/socperf/haswellunc_sa.c:257:41: sparse:     got unsigned int [usertype] *
>> drivers/platform/x86/socperf/haswellunc_sa.c:271:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/platform/x86/socperf/haswellunc_sa.c:271:42: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/platform/x86/socperf/haswellunc_sa.c:271:42: sparse:     got void *
   drivers/platform/x86/socperf/haswellunc_sa.c:363:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/platform/x86/socperf/haswellunc_sa.c:363:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/platform/x86/socperf/haswellunc_sa.c:363:33: sparse:     got unsigned int [usertype] *
   drivers/platform/x86/socperf/haswellunc_sa.c:367:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/platform/x86/socperf/haswellunc_sa.c:367:33: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/platform/x86/socperf/haswellunc_sa.c:367:33: sparse:     got unsigned int [usertype] *
--
   drivers/platform/x86/socperf/socperfdrv.c:208:13: sparse: sparse: function 'SOCPERF_Read_Data3' with external linkage has definition
>> drivers/platform/x86/socperf/socperfdrv.c:1175:13: sparse: sparse: function 'lwpmudrv_Stop_Mem' with external linkage has definition
>> drivers/platform/x86/socperf/socperfdrv.c:1392:22: sparse: sparse: function 'socperf_Service_IOCTL' with external linkage has definition
>> drivers/platform/x86/socperf/socperfdrv.c:1516:13: sparse: sparse: function 'socperf_Device_Control' with external linkage has definition
>> drivers/platform/x86/socperf/socperfdrv.c:1602:12: sparse: sparse: function 'SOCPERF_Abnormal_Terminate' with external linkage has definition
   drivers/platform/x86/socperf/socperfdrv.c:104:22: sparse: sparse: symbol 'socperf_drv_version' was not declared. Should it be static?
   drivers/platform/x86/socperf/socperfdrv.c:105:5: sparse: sparse: symbol 'read_unc_ctr_info' was not declared. Should it be static?
   drivers/platform/x86/socperf/socperfdrv.c:106:10: sparse: sparse: symbol 'dispatch_uncore' was not declared. Should it be static?
   drivers/platform/x86/socperf/socperfdrv.c:108:14: sparse: sparse: symbol 'socperf_global_ec' was not declared. Should it be static?
   drivers/platform/x86/socperf/socperfdrv.c:109:14: sparse: sparse: symbol 'socperf_abnormal_terminate' was not declared. Should it be static?
   drivers/platform/x86/socperf/socperfdrv.c:110:11: sparse: sparse: symbol 'socperf_control' was not declared. Should it be static?
   drivers/platform/x86/socperf/socperfdrv.c:114:8: sparse: sparse: symbol 'socperf_pcb_size' was not declared. Should it be static?
>> drivers/platform/x86/socperf/socperfdrv.c:246:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int [usertype] * @@
   drivers/platform/x86/socperf/socperfdrv.c:246:18: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/platform/x86/socperf/socperfdrv.c:246:18: sparse:     got unsigned int [usertype] *
>> drivers/platform/x86/socperf/socperfdrv.c:246:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int [usertype] * @@
   drivers/platform/x86/socperf/socperfdrv.c:246:18: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/platform/x86/socperf/socperfdrv.c:246:18: sparse:     got unsigned int [usertype] *
>> drivers/platform/x86/socperf/socperfdrv.c:328:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void *[usertype] buf_drv_to_usr @@
   drivers/platform/x86/socperf/socperfdrv.c:328:37: sparse:     expected void const [noderef] __user *from
   drivers/platform/x86/socperf/socperfdrv.c:328:37: sparse:     got void *[usertype] buf_drv_to_usr
   drivers/platform/x86/socperf/socperfdrv.c:407:62: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void *[usertype] buf_drv_to_usr @@
   drivers/platform/x86/socperf/socperfdrv.c:407:62: sparse:     expected void const [noderef] __user *from
   drivers/platform/x86/socperf/socperfdrv.c:407:62: sparse:     got void *[usertype] buf_drv_to_usr
>> drivers/platform/x86/socperf/socperfdrv.c:559:63: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char *[usertype] buf_usr_to_drv @@
   drivers/platform/x86/socperf/socperfdrv.c:559:63: sparse:     expected void const [noderef] __user *from
   drivers/platform/x86/socperf/socperfdrv.c:559:63: sparse:     got char *[usertype] buf_usr_to_drv
   drivers/platform/x86/socperf/socperfdrv.c:641:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char *[usertype] buf_usr_to_drv @@
   drivers/platform/x86/socperf/socperfdrv.c:641:39: sparse:     expected void const [noderef] __user *from
   drivers/platform/x86/socperf/socperfdrv.c:641:39: sparse:     got char *[usertype] buf_usr_to_drv
   drivers/platform/x86/socperf/socperfdrv.c:742:64: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char *[usertype] buf_usr_to_drv @@
   drivers/platform/x86/socperf/socperfdrv.c:742:64: sparse:     expected void const [noderef] __user *from
   drivers/platform/x86/socperf/socperfdrv.c:742:64: sparse:     got char *[usertype] buf_usr_to_drv
>> drivers/platform/x86/socperf/socperfdrv.c:1043:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned int [usertype] * @@
   drivers/platform/x86/socperf/socperfdrv.c:1043:43: sparse:     expected void const [noderef] __user *from
   drivers/platform/x86/socperf/socperfdrv.c:1043:43: sparse:     got unsigned int [usertype] *
>> drivers/platform/x86/socperf/socperfdrv.c:1066:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got char *[usertype] buf_drv_to_usr @@
   drivers/platform/x86/socperf/socperfdrv.c:1066:29: sparse:     expected void [noderef] __user *to
   drivers/platform/x86/socperf/socperfdrv.c:1066:29: sparse:     got char *[usertype] buf_drv_to_usr
   drivers/platform/x86/socperf/socperfdrv.c:1089:28: sparse: sparse: Using plain integer as NULL pointer
   drivers/platform/x86/socperf/socperfdrv.c:1100:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got char *[usertype] buf_drv_to_usr @@
   drivers/platform/x86/socperf/socperfdrv.c:1100:29: sparse:     expected void [noderef] __user *to
   drivers/platform/x86/socperf/socperfdrv.c:1100:29: sparse:     got char *[usertype] buf_drv_to_usr
>> drivers/platform/x86/socperf/socperfdrv.c:1135:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned long long [usertype] * @@
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
>> drivers/platform/x86/socperf/socperfdrv.c:1348:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got char *buf @@
   drivers/platform/x86/socperf/socperfdrv.c:1348:26: sparse:     expected void [noderef] __user *to
   drivers/platform/x86/socperf/socperfdrv.c:1348:26: sparse:     got char *buf
>> drivers/platform/x86/socperf/socperfdrv.c:1368:76: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char const * @@
   drivers/platform/x86/socperf/socperfdrv.c:1368:76: sparse:     expected void const [noderef] __user *from
   drivers/platform/x86/socperf/socperfdrv.c:1368:76: sparse:     got char const *
   drivers/platform/x86/socperf/socperfdrv.c:1392:22: sparse: sparse: symbol 'socperf_Service_IOCTL' was not declared. Should it be static?
>> drivers/platform/x86/socperf/socperfdrv.c:1537:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct IOCTL_ARGS_NODE_S [usertype] *[usertype] @@
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

vim +422 drivers/platform/x86/socperf/soc_uncore.c

   298	
   299	/*!
   300	 * @fn          static VOID uncore_Write_PMU(VOID*)
   301	 *
   302	 * @brief       Initial write of PMU registers
   303	 *              Walk through the entries and write the value of the register accordingly.
   304	 *              When current_group = 0, then this is the first time this routine is called,
   305	 *
   306	 * @param       param - device index
   307	 *
   308	 * @return      None
   309	 *
   310	 * <I>Special Notes:</I>
   311	 */
   312	static VOID uncore_Write_PMU(VOID *param)
   313	{
   314		U32 dev_idx;
   315		ECB pecb;
   316		DRV_PCI_DEVICE_ENTRY dpden;
   317		U32 pci_address;
   318		U32 bar_lo;
   319		U64 bar_hi;
   320		U64 final_bar;
   321		U64 physical_address;
   322		U32 dev_index = 0;
   323		S32 bar_list[SOC_UNCORE_MAX_PCI_DEVICES];
   324		U32 bar_index = 0;
   325		U32 map_size = 0;
   326		U64 virtual_address = 0;
   327		U32 bar_name = 0;
   328		DRV_PCI_DEVICE_ENTRY curr_pci_entry = NULL;
   329		U32 next_bar_offset = 0;
   330		U64 mmio_offset = 0;
   331		U64 map_base = 0;
   332		U32 i = 0;
   333		U32 cur_grp;
   334	
   335		dev_idx = *((U32 *)param);
   336		if (device_uncore == NULL) {
   337			SOCPERF_PRINT_ERROR("ERROR: NULL device_uncore!\n");
   338			return;
   339		}
   340		cur_grp = LWPMU_DEVICE_cur_group(device_uncore);
   341	
   342		pecb = (ECB)LWPMU_DEVICE_PMU_register_data(device_uncore)[cur_grp];
   343		if (pecb == NULL) {
   344			SOCPERF_PRINT_ERROR("ERROR: null pecb!\n");
   345			return;
   346		}
   347	
   348		for (dev_index = 0; dev_index < SOC_UNCORE_MAX_PCI_DEVICES;
   349		     dev_index++) {
   350			bar_list[dev_index] = -1;
   351		}
   352	
   353		// initialize the per-counter overflow numbers
   354		for (i = 0; i < UNCORE_MAX_COUNTERS; i++) {
   355			counter_overflow[i] = 0;
   356			socperf_pcb[0].last_uncore_count[i] = 0;
   357		}
   358	
   359		ECB_pcidev_entry_list(pecb) = (DRV_PCI_DEVICE_ENTRY)(
   360			(S8 *)pecb + ECB_pcidev_list_offset(pecb));
   361		dpden = ECB_pcidev_entry_list(pecb);
   362	
   363		uncore_Reset_Counters(dev_idx);
   364	
   365		for (dev_index = 0; dev_index < ECB_num_pci_devices(pecb);
   366		     dev_index++) {
   367			curr_pci_entry = &dpden[dev_index];
   368			bar_name = DRV_PCI_DEVICE_ENTRY_bar_name(curr_pci_entry);
   369			mmio_offset = DRV_PCI_DEVICE_ENTRY_base_offset_for_mmio(
   370				curr_pci_entry);
   371	
   372			if (counter_port_id == 0 &&
   373			    DRV_PCI_DEVICE_ENTRY_prog_type(curr_pci_entry) ==
   374				    UNC_COUNTER) {
   375				counter_port_id =
   376					DRV_PCI_DEVICE_ENTRY_port_id(curr_pci_entry);
   377				uncore_Reset_Counters(dev_idx);
   378			}
   379			if (DRV_PCI_DEVICE_ENTRY_config_type(curr_pci_entry) ==
   380			    UNC_PCICFG) {
   381				if (bar_name == UNC_SOCPCI &&
   382				    (DRV_PCI_DEVICE_ENTRY_prog_type(curr_pci_entry) ==
   383					     UNC_MUX ||
   384				     DRV_PCI_DEVICE_ENTRY_prog_type(curr_pci_entry) ==
   385					     UNC_COUNTER) &&
   386				    DRV_PCI_DEVICE_ENTRY_operation(curr_pci_entry) ==
   387					    UNC_OP_WRITE) {
   388					SOCPERF_PRINT_DEBUG(
   389						"dev_index=%d OFFSET=%x VAL=%x\n",
   390						dev_index,
   391						DRV_PCI_DEVICE_ENTRY_base_offset_for_mmio(
   392							curr_pci_entry),
   393						DRV_PCI_DEVICE_ENTRY_value(
   394							curr_pci_entry));
   395					write_To_Register(
   396						DRV_PCI_DEVICE_ENTRY_bus_no(
   397							curr_pci_entry),
   398						DRV_PCI_DEVICE_ENTRY_dev_no(
   399							curr_pci_entry),
   400						DRV_PCI_DEVICE_ENTRY_func_no(
   401							curr_pci_entry),
   402						DRV_PCI_DEVICE_ENTRY_port_id(
   403							curr_pci_entry),
   404						DRV_PCI_DEVICE_ENTRY_op_code(
   405							curr_pci_entry),
   406						DRV_PCI_DEVICE_ENTRY_base_offset_for_mmio(
   407							curr_pci_entry),
   408						(ULONG)DRV_PCI_DEVICE_ENTRY_value(
   409							curr_pci_entry));
   410				}
   411				continue;
   412			}
   413			// UNC_MMIO programming
   414			if (bar_list[bar_name] != -1) {
   415				bar_index = bar_list[bar_name];
   416				virtual_address = DRV_PCI_DEVICE_ENTRY_virtual_address(
   417					&dpden[bar_index]);
   418				DRV_PCI_DEVICE_ENTRY_virtual_address(curr_pci_entry) =
   419					DRV_PCI_DEVICE_ENTRY_virtual_address(
   420						&dpden[bar_index]);
   421				writel(DRV_PCI_DEVICE_ENTRY_value(curr_pci_entry),
 > 422				       (U32 *)(((char *)(UIOP)virtual_address) +
   423					       mmio_offset));
   424				continue;
   425			}
   426			pci_address = FORM_PCI_ADDR(
   427				DRV_PCI_DEVICE_ENTRY_bus_no(curr_pci_entry),
   428				DRV_PCI_DEVICE_ENTRY_dev_no(curr_pci_entry),
   429				DRV_PCI_DEVICE_ENTRY_func_no(curr_pci_entry),
   430				DRV_PCI_DEVICE_ENTRY_bar_offset(curr_pci_entry));
   431			bar_lo = SOCPERF_PCI_Read_Ulong(pci_address);
   432			next_bar_offset =
   433				DRV_PCI_DEVICE_ENTRY_bar_offset(curr_pci_entry) +
   434				SOC_UNCORE_NEXT_ADDR_OFFSET;
   435			pci_address = FORM_PCI_ADDR(
   436				DRV_PCI_DEVICE_ENTRY_bus_no(curr_pci_entry),
   437				DRV_PCI_DEVICE_ENTRY_dev_no(curr_pci_entry),
   438				DRV_PCI_DEVICE_ENTRY_func_no(curr_pci_entry),
   439				next_bar_offset);
   440			bar_hi = SOCPERF_PCI_Read_Ulong(pci_address);
   441			final_bar = (bar_hi << SOC_UNCORE_BAR_ADDR_SHIFT) | bar_lo;
   442			final_bar &= SOC_UNCORE_BAR_ADDR_MASK;
   443			DRV_PCI_DEVICE_ENTRY_bar_address(curr_pci_entry) = final_bar;
   444			physical_address =
   445				DRV_PCI_DEVICE_ENTRY_bar_address(curr_pci_entry);
   446			if (physical_address) {
   447				map_size = SOC_UNCORE_OTHER_BAR_MMIO_PAGE_SIZE;
   448				map_base = (mmio_offset / map_size) * map_size;
   449				if (mmio_offset > map_size) {
   450					physical_address = physical_address + map_base;
   451				}
   452			}
   453		}
   454	
   455		return;
   456	}
   457	
   458	/*!
   459	 * @fn         static VOID uncore_Disable_PMU(PVOID)
   460	 *
   461	 * @brief      Unmap the virtual address when sampling/driver stops
   462	 *
   463	 * @param      param - device index
   464	 *
   465	 * @return     None
   466	 *
   467	 * <I>Special Notes:</I>
   468	 */
   469	static VOID uncore_Disable_PMU(PVOID param)
   470	{
   471		U32 dev_idx = *((U32 *)param);
   472	
   473		if (GLOBAL_STATE_current_phase(socperf_driver_state) ==
   474		    DRV_STATE_PREPARE_STOP) {
   475			uncore_Reset_Counters(dev_idx);
   476		}
   477	
   478		return;
   479	}
   480	
   481	/*!
   482	 * @fn         static VOID uncore_Stop_Mem(VOID)
   483	 *
   484	 * @brief      Stop trace
   485	 *
   486	 * @param      param - None
   487	 *
   488	 * @return     None
   489	 *
   490	 * <I>Special Notes:</I>
   491	 */
   492	static VOID uncore_Stop_Mem(VOID)
   493	{
   494		ECB pecb;
   495		DRV_PCI_DEVICE_ENTRY dpden;
   496		U32 bar_name = 0;
   497		DRV_PCI_DEVICE_ENTRY curr_pci_entry = NULL;
   498		U64 mmio_offset = 0;
   499		U32 dev_index = 0;
   500		U32 data_val = 0;
   501		U32 cur_grp;
   502	
   503		if (device_uncore == NULL) {
   504			SOCPERF_PRINT_ERROR("ERROR: NULL device_uncore!\n");
   505			return;
   506		}
   507		cur_grp = LWPMU_DEVICE_cur_group(device_uncore);
   508	
   509		pecb = (ECB)LWPMU_DEVICE_PMU_register_data(device_uncore)[cur_grp];
   510		if (pecb == NULL) {
   511			SOCPERF_PRINT_ERROR("ERROR: null pecb!\n");
   512			return;
   513		}
   514	
   515		ECB_pcidev_entry_list(pecb) = (DRV_PCI_DEVICE_ENTRY)(
   516			(S8 *)pecb + ECB_pcidev_list_offset(pecb));
   517		dpden = ECB_pcidev_entry_list(pecb);
   518	
   519		for (dev_index = 0; dev_index < ECB_num_pci_devices(pecb);
   520		     dev_index++) {
   521			curr_pci_entry = &dpden[dev_index];
   522			bar_name = DRV_PCI_DEVICE_ENTRY_bar_name(curr_pci_entry);
   523			mmio_offset = DRV_PCI_DEVICE_ENTRY_base_offset_for_mmio(
   524				curr_pci_entry);
   525	
   526			if (DRV_PCI_DEVICE_ENTRY_prog_type(curr_pci_entry) ==
   527				    UNC_STOP &&
   528			    DRV_PCI_DEVICE_ENTRY_config_type(curr_pci_entry) ==
   529				    UNC_PCICFG &&
   530			    bar_name == UNC_SOCPCI &&
   531			    DRV_PCI_DEVICE_ENTRY_operation(curr_pci_entry) ==
   532				    UNC_OP_READ) {
   533				SOCPERF_PRINT_DEBUG(
   534					"op=%d port=%d offset=%x val=%x\n",
   535					DRV_PCI_DEVICE_ENTRY_op_code(curr_pci_entry),
   536					DRV_PCI_DEVICE_ENTRY_port_id(curr_pci_entry),
   537					mmio_offset, data_val);
   538				read_From_Register(
   539					DRV_PCI_DEVICE_ENTRY_bus_no(curr_pci_entry),
   540					DRV_PCI_DEVICE_ENTRY_dev_no(curr_pci_entry),
   541					DRV_PCI_DEVICE_ENTRY_func_no(curr_pci_entry),
   542					DRV_PCI_DEVICE_ENTRY_port_id(curr_pci_entry),
   543					SOC_COUNTER_READ_OP_CODE, mmio_offset,
   544					&data_val);
   545				SOCPERF_PRINT_DEBUG(
   546					"op=%d port=%d offset=%x val=%x\n",
   547					DRV_PCI_DEVICE_ENTRY_op_code(curr_pci_entry),
   548					DRV_PCI_DEVICE_ENTRY_port_id(curr_pci_entry),
   549					mmio_offset, data_val);
   550				write_To_Register(
   551					DRV_PCI_DEVICE_ENTRY_bus_no(curr_pci_entry),
   552					DRV_PCI_DEVICE_ENTRY_dev_no(curr_pci_entry),
   553					DRV_PCI_DEVICE_ENTRY_func_no(curr_pci_entry),
   554					DRV_PCI_DEVICE_ENTRY_port_id(curr_pci_entry),
   555					SOC_COUNTER_WRITE_OP_CODE, mmio_offset,
   556					(ULONG)(data_val | 0x2000));
   557			}
   558		}
   559	
   560		return;
   561	}
   562	
   563	/*!
   564	 * @fn         static VOID uncore_Initialize(PVOID)
   565	 *
   566	 * @brief      Initialize any registers or addresses
   567	 *
   568	 * @param      param
   569	 *
   570	 * @return     None
   571	 *
   572	 * <I>Special Notes:</I>
   573	 */
   574	static VOID uncore_Initialize(VOID *param)
   575	{
   576		return;
   577	}
   578	
   579	/*!
   580	 * @fn         static VOID uncore_Clean_Up(PVOID)
   581	 *
   582	 * @brief      Reset any registers or addresses
   583	 *
   584	 * @param      param
   585	 *
   586	 * @return     None
   587	 *
   588	 * <I>Special Notes:</I>
   589	 */
   590	static VOID uncore_Clean_Up(VOID *param)
   591	{
   592		if (trace_virtual_address) {
 > 593			iounmap((void *)(UIOP)trace_virtual_address);
   594			trace_virtual_address = 0;
   595		}
   596		return;
   597	}
   598	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

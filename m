Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2119555B3A0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 20:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiFZSmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 14:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiFZSmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 14:42:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D49DEE8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 11:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656268953; x=1687804953;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8w95u2zf7HLlfHq2AmLV5saVszfuMS8dyt44VdwKFGU=;
  b=duXsOm9eLFz7pp5MqIXbXuDXpgIcCITrFQVKL8E83CfWz8rfN41dEuOT
   lp6o0fx0tXYCRBM20KFBDWXDBFcgMP9JOX8mmG0dDG1Ag4j6KyGhVmx+k
   KVpMayLrFailWisjfEbmhRGjRLf+G8vQG3wc0eqEVGDcKsuU5sIFcsAYo
   +507coHsUDMrVOHL37pdoOz13D8mw/ETw4ORsaraTlcW7wVvGsxdViFda
   i/wKLAJneafPnuWBs+/GnKovr+IPvg11BGfScWVBGB+WReLKYMBAL7dOa
   h05SdK/xM7T2PLuE3iJ+hA0I8/YCQWoyJ4MP39IDt9I0IkDKKtXtq/OfV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="261717295"
X-IronPort-AV: E=Sophos;i="5.92,224,1650956400"; 
   d="scan'208";a="261717295"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 11:42:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,224,1650956400"; 
   d="scan'208";a="835882725"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jun 2022 11:42:31 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5XDL-0007ih-2L;
        Sun, 26 Jun 2022 18:42:31 +0000
Date:   Mon, 27 Jun 2022 02:41:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manisha Chinthapally <manisha.chinthapally@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mchinth:sep_socwatch_linux_5_16 1/1]
 drivers/platform/x86/socperf/pci.c:76:12: sparse: sparse: function
 'SOCPERF_PCI_Read_From_Memory_Address' with external linkage has definition
Message-ID: <202206270250.gcGEukLV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
config: i386-randconfig-s001
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-31-g4880bd19-dirty
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
>> drivers/platform/x86/socperf/utility.c:75:13: sparse: sparse: function 'SOCPERF_UTILITY_Read_TSC' with external linkage has definition
>> drivers/platform/x86/socperf/utility.c:104:13: sparse: sparse: function 'SOCPERF_UTILITY_Read_Cpuid' with external linkage has definition
>> drivers/platform/x86/socperf/utility.c:136:17: sparse: sparse: function 'SOCPERF_UTILITY_Configure_CPU' with external linkage has definition
--
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
--
>> drivers/platform/x86/socperf/pmu_list.c:246:17: sparse: sparse: function 'PMU_LIST_Check_MMIO' with external linkage has definition
>> drivers/platform/x86/socperf/pmu_list.c:303:18: sparse: sparse: function 'PMU_LIST_Initialize' with external linkage has definition
>> drivers/platform/x86/socperf/pmu_list.c:327:18: sparse: sparse: function 'PMU_LIST_Build_MMIO_List' with external linkage has definition
>> drivers/platform/x86/socperf/pmu_list.c:380:18: sparse: sparse: function 'PMU_LIST_Clean_Up' with external linkage has definition

vim +/SOCPERF_PCI_Read_From_Memory_Address +76 drivers/platform/x86/socperf/pci.c

    63	
    64	/* ------------------------------------------------------------------------- */
    65	/*!
    66	 * @fn extern int SOCPERF_PCI_Read_From_Memory_Address(addr, val)
    67	 *
    68	 * @param    addr    - physical address in mmio
    69	 * @param   *value  - value at this address
    70	 *
    71	 * @return  status
    72	 *
    73	 * @brief   Read memory mapped i/o physical location
    74	 *
    75	 */
  > 76	extern int SOCPERF_PCI_Read_From_Memory_Address(U32 addr, U32 *val)
    77	{
    78		U32 aligned_addr, offset, value;
    79		PVOID base;
    80	
    81		if (addr <= 0) {
    82			return OS_INVALID;
    83		}
    84	
    85		SOCPERF_PRINT_DEBUG(
    86			"SOCPERF_PCI_Read_From_Memory_Address: reading physical address:%x\n",
    87			addr);
    88		offset = addr & ~PAGE_MASK;
    89		aligned_addr = addr & PAGE_MASK;
    90		SOCPERF_PRINT_DEBUG(
    91			"SOCPERF_PCI_Read_From_Memory_Address: aligned physical address:%x,offset:%x\n",
    92			aligned_addr, offset);
    93	
  > 94		base = ioremap(aligned_addr, PAGE_SIZE);
    95		if (base == NULL) {
    96			return OS_INVALID;
    97		}
    98	
  > 99		value = readl(base + offset);
   100		*val = value;
   101		SOCPERF_PRINT_DEBUG(
   102			"SOCPERF_PCI_Read_From_Memory_Address: value at this physical address:%x\n",
   103			value);
   104	
 > 105		iounmap(base);
   106	
   107		return OS_SUCCESS;
   108	}
   109	
   110	/* ------------------------------------------------------------------------- */
   111	/*!
   112	 * @fn extern int SOCPERF_PCI_Write_To_Memory_Address(addr, val)
   113	 *
   114	 * @param   addr   - physical address in mmio
   115	 * @param   value  - value to be written
   116	 *
   117	 * @return  status
   118	 *
   119	 * @brief   Write to memory mapped i/o physical location
   120	 *
   121	 */
 > 122	extern int SOCPERF_PCI_Write_To_Memory_Address(U32 addr, U32 val)
   123	{
   124		U32 aligned_addr, offset;
   125		PVOID base;
   126	
   127		if (addr <= 0) {
   128			return OS_INVALID;
   129		}
   130	
   131		SOCPERF_PRINT_DEBUG(
   132			"SOCPERF_PCI_Write_To_Memory_Address: writing physical address:%x with value:%x\n",
   133			addr, val);
   134		offset = addr & ~PAGE_MASK;
   135		aligned_addr = addr & PAGE_MASK;
   136		SOCPERF_PRINT_DEBUG(
   137			"SOCPERF_PCI_Write_To_Memory_Address: aligned physical address:%x,offset:%x\n",
   138			aligned_addr, offset);
   139	
   140		base = ioremap(aligned_addr, PAGE_SIZE);
   141		if (base == NULL) {
   142			return OS_INVALID;
   143		}
   144	
 > 145		writel(val, base + offset);
   146	
   147		iounmap(base);
   148	
   149		return OS_SUCCESS;
   150	}
   151	
   152	/* ------------------------------------------------------------------------- */
   153	/*!
   154	 * @fn extern int SOCPERF_PCI_Read_Ulong(pci_address)
   155	 *
   156	 * @param    pci_address - PCI configuration address
   157	 *
   158	 * @return  value at this location
   159	 *
   160	 * @brief   Reads a ULONG from PCI configuration space
   161	 *
   162	 */
 > 163	extern int SOCPERF_PCI_Read_Ulong(U32 pci_address)
   164	{
   165		U32 temp_ulong = 0;
   166	
   167		outl(pci_address, PCI_ADDR_IO);
   168		temp_ulong = inl(PCI_DATA_IO);
   169	
   170		return temp_ulong;
   171	}
   172	
   173	/* ------------------------------------------------------------------------- */
   174	/*!
   175	 * @fn extern int SOCPERF_PCI_Write_Ulong(addr, val)
   176	 *
   177	 * @param    pci_address - PCI configuration address
   178	 * @param    value - Value to be written
   179	 *
   180	 * @return  status
   181	 *
   182	 * @brief   Writes a ULONG to PCI configuration space
   183	 *
   184	 */
 > 185	extern void SOCPERF_PCI_Write_Ulong(U32 pci_address, U32 value)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

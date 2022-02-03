Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731AD4A7ED1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 06:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbiBCFCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 00:02:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:44169 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231496AbiBCFCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 00:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643864568; x=1675400568;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EB6Qi17gLu5INZqtvGHAXsNGDFjiuaadSKRyvKfjSKc=;
  b=RfHGbRpSrFgW8AYyGJgvA1yFj8Yy/Ldrl+mtVyoZT746XlPwA+o+x0PL
   lcOYDn58hETceUQH+1dGipMam7IxKOZaNOGv7feJy6D8ricm3lBayb2kY
   c3aRp4wYXESgq6kYqUYIyIGUrK+b/0svUmnzAdJX6qfkMYd3dYYcVnDUk
   CTk0tCyToLxDaWqR+ulgWYqb7MC38uIiV5IzhlFAIngYZJ8iP74u+T/Rf
   LFyjDNpvVoTpslqa7z2jGQ5jzbDd7VHNGOLoHL1aVeGgC3LVLMw1SERFN
   FmTzg45HEHFVm94rahN7ankfWuI14a0g6PX0Cs7yzSBaQKubqAahGyPNl
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="272566203"
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="272566203"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 21:02:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="583677457"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 Feb 2022 21:02:46 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFUGc-000Vbm-8R; Thu, 03 Feb 2022 05:02:46 +0000
Date:   Thu, 3 Feb 2022 13:02:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manisha Chinthapally <manisha.chinthapally@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mchinth:sep_socwatch_linux_5_16 1/1]
 drivers/platform/x86/sepdk/sep/pmi.c:81:5: warning: no previous prototype
 for function 'pmi_Get_CSD'
Message-ID: <202202031242.MnDxM5zu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/mchinth/linux sep_socwatch_linux_5_16
head:   4cbfca15a262729ae8557758b49226fe4769f582
commit: 4cbfca15a262729ae8557758b49226fe4769f582 [1/1] Platform/x86 Updated SEP/SOCPERF drivers to latest version
config: x86_64-randconfig-a015-20220131 (https://download.01.org/0day-ci/archive/20220203/202202031242.MnDxM5zu-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a73e4ce6a59b01f0e37037761c1e6889d539d233)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/mchinth/linux/commit/4cbfca15a262729ae8557758b49226fe4769f582
        git remote add mchinth https://github.com/mchinth/linux
        git fetch --no-tags mchinth sep_socwatch_linux_5_16
        git checkout 4cbfca15a262729ae8557758b49226fe4769f582
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/x86/sepdk/pax/ drivers/platform/x86/sepdk/sep/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/sepdk/pax/pax.c:171:5: warning: no previous prototype for function 'pax_Disable_NMIWatchdog' [-Wmissing-prototypes]
   S32 pax_Disable_NMIWatchdog(PVOID data)
       ^
   drivers/platform/x86/sepdk/pax/pax.c:171:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   S32 pax_Disable_NMIWatchdog(PVOID data)
   ^
   static 
>> drivers/platform/x86/sepdk/pax/pax.c:240:5: warning: no previous prototype for function 'pax_Check_NMIWatchdog' [-Wmissing-prototypes]
   S32 pax_Check_NMIWatchdog(PVOID data)
       ^
   drivers/platform/x86/sepdk/pax/pax.c:240:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   S32 pax_Check_NMIWatchdog(PVOID data)
   ^
   static 
>> drivers/platform/x86/sepdk/pax/pax.c:280:5: warning: no previous prototype for function 'pax_Enable_NMIWatchdog' [-Wmissing-prototypes]
   S32 pax_Enable_NMIWatchdog(PVOID data)
       ^
   drivers/platform/x86/sepdk/pax/pax.c:280:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   S32 pax_Enable_NMIWatchdog(PVOID data)
   ^
   static 
   drivers/platform/x86/sepdk/pax/pax.c:700:22: warning: no previous prototype for function 'pax_Service_IOCTL' [-Wmissing-prototypes]
   extern IOCTL_OP_TYPE pax_Service_IOCTL(IOCTL_USE_INODE struct file *filp,
                        ^
   drivers/platform/x86/sepdk/pax/pax.c:700:8: note: declare 'static' if the function is not intended to be used outside of this translation unit
   extern IOCTL_OP_TYPE pax_Service_IOCTL(IOCTL_USE_INODE struct file *filp,
          ^
   drivers/platform/x86/sepdk/inc/control.h:60:23: note: expanded from macro 'IOCTL_OP_TYPE'
   #define IOCTL_OP_TYPE long
                         ^
   drivers/platform/x86/sepdk/pax/pax.c:738:13: warning: no previous prototype for function 'pax_Device_Control' [-Wmissing-prototypes]
   extern long pax_Device_Control(IOCTL_USE_INODE struct file *filp,
               ^
   drivers/platform/x86/sepdk/pax/pax.c:738:8: note: declare 'static' if the function is not intended to be used outside of this translation unit
   extern long pax_Device_Control(IOCTL_USE_INODE struct file *filp,
          ^
   drivers/platform/x86/sepdk/pax/pax.c:744:6: warning: variable 'local_args' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (arg) {
               ^~~
   drivers/platform/x86/sepdk/pax/pax.c:749:56: note: uninitialized use occurs here
           status = pax_Service_IOCTL(IOCTL_USE_INODE filp, cmd, local_args);
                                                                 ^~~~~~~~~~
   drivers/platform/x86/sepdk/pax/pax.c:744:2: note: remove the 'if' if its condition is always true
           if (arg) {
           ^~~~~~~~~
   drivers/platform/x86/sepdk/pax/pax.c:742:2: note: variable 'local_args' is declared here
           IOCTL_ARGS_NODE local_args;
           ^
   drivers/platform/x86/sepdk/pax/pax.c:859:12: warning: no previous prototype for function 'pax_Load' [-Wmissing-prototypes]
   extern int pax_Load(VOID)
              ^
   drivers/platform/x86/sepdk/pax/pax.c:859:8: note: declare 'static' if the function is not intended to be used outside of this translation unit
   extern int pax_Load(VOID)
          ^
   drivers/platform/x86/sepdk/pax/pax.c:935:13: warning: no previous prototype for function 'pax_Unload' [-Wmissing-prototypes]
   extern VOID pax_Unload(VOID)
               ^
   drivers/platform/x86/sepdk/pax/pax.c:935:8: note: declare 'static' if the function is not intended to be used outside of this translation unit
   extern VOID pax_Unload(VOID)
          ^
   8 warnings generated.
--
>> drivers/platform/x86/sepdk/sep/pmi.c:81:5: warning: no previous prototype for function 'pmi_Get_CSD' [-Wmissing-prototypes]
   U32 pmi_Get_CSD(U32 seg, U32 *low, U32 *high)
       ^
   drivers/platform/x86/sepdk/sep/pmi.c:81:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   U32 pmi_Get_CSD(U32 seg, U32 *low, U32 *high)
   ^
   static 
   1 warning generated.


vim +/pmi_Get_CSD +81 drivers/platform/x86/sepdk/sep/pmi.c

d605aabab41663 Jon Moeller          2018-11-13   80  
d605aabab41663 Jon Moeller          2018-11-13  @81  U32 pmi_Get_CSD(U32 seg, U32 *low, U32 *high)
d605aabab41663 Jon Moeller          2018-11-13   82  {
d605aabab41663 Jon Moeller          2018-11-13   83  	PVOID gdt_max_addr;
d605aabab41663 Jon Moeller          2018-11-13   84  	struct desc_struct *gdt;
d605aabab41663 Jon Moeller          2018-11-13   85  	CodeDescriptor *csd;
d605aabab41663 Jon Moeller          2018-11-13   86  
d605aabab41663 Jon Moeller          2018-11-13   87  	SEP_DRV_LOG_TRACE_IN("Seg: %u, low: %p, high: %p.", seg, low, high);
d605aabab41663 Jon Moeller          2018-11-13   88  
d605aabab41663 Jon Moeller          2018-11-13   89  	gdt_max_addr =
d605aabab41663 Jon Moeller          2018-11-13   90  		(PVOID)(((U64)gdt_desc.idtgdt_base) + gdt_desc.idtgdt_limit);
d605aabab41663 Jon Moeller          2018-11-13   91  	gdt = gdt_desc.idtgdt_base;
d605aabab41663 Jon Moeller          2018-11-13   92  
d605aabab41663 Jon Moeller          2018-11-13   93  	if (seg & IS_LDT_BIT) {
d605aabab41663 Jon Moeller          2018-11-13   94  		*low = 0;
d605aabab41663 Jon Moeller          2018-11-13   95  		*high = 0;
d605aabab41663 Jon Moeller          2018-11-13   96  		SEP_DRV_LOG_TRACE_OUT("FALSE [%u, %u] (IS_LDT_BIT).", *low,
d605aabab41663 Jon Moeller          2018-11-13   97  				      *high);
4cbfca15a26272 Manisha Chinthapally 2022-02-02   98  		return (FALSE);
d605aabab41663 Jon Moeller          2018-11-13   99  	}
d605aabab41663 Jon Moeller          2018-11-13  100  
d605aabab41663 Jon Moeller          2018-11-13  101  	// segment offset is based on dropping the bottom 3 bits...
d605aabab41663 Jon Moeller          2018-11-13  102  	csd = (CodeDescriptor *)&(gdt[seg >> SEGMENT_SHIFT]);
d605aabab41663 Jon Moeller          2018-11-13  103  
d605aabab41663 Jon Moeller          2018-11-13  104  	if (((PVOID)csd) >= gdt_max_addr) {
d605aabab41663 Jon Moeller          2018-11-13  105  		SEP_DRV_LOG_WARNING_TRACE_OUT(
d605aabab41663 Jon Moeller          2018-11-13  106  			"FALSE (segment too big in get_CSD(0x%x)!).", seg);
d605aabab41663 Jon Moeller          2018-11-13  107  		return FALSE;
d605aabab41663 Jon Moeller          2018-11-13  108  	}
d605aabab41663 Jon Moeller          2018-11-13  109  
d605aabab41663 Jon Moeller          2018-11-13  110  	*low = csd->u1.lowWord;
d605aabab41663 Jon Moeller          2018-11-13  111  	*high = csd->u2.highWord;
d605aabab41663 Jon Moeller          2018-11-13  112  
d605aabab41663 Jon Moeller          2018-11-13  113  	SEP_DRV_LOG_TRACE("Seg 0x%x, low %08x, high %08x, reserved_0: %d.", seg,
d605aabab41663 Jon Moeller          2018-11-13  114  			  *low, *high, csd->u2.s2.reserved_0);
d605aabab41663 Jon Moeller          2018-11-13  115  	SEP_DRV_LOG_TRACE_OUT("TRUE [%u, %u].", *low, *high);
d605aabab41663 Jon Moeller          2018-11-13  116  
d605aabab41663 Jon Moeller          2018-11-13  117  	return TRUE;
d605aabab41663 Jon Moeller          2018-11-13  118  }
d605aabab41663 Jon Moeller          2018-11-13  119  #endif
d605aabab41663 Jon Moeller          2018-11-13  120  

:::::: The code at line 81 was first introduced by commit
:::::: d605aabab41663c9be9e8c549042933189adbf2f platform/x86: add sep and socwatch drivers without socperf.

:::::: TO: Jon Moeller <jon.moeller@intel.com>
:::::: CC: Faycal Benmlih <faycal.benmlih@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189064A7E03
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 03:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349061AbiBCCkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 21:40:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:41324 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233972AbiBCCkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 21:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643856040; x=1675392040;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R19Sr8Sjx+OtLUdQ7xAco/jqgt110mMokX2E0gw3Dzc=;
  b=dsILqkXNxlmid5uTmSsnfYC/6o06ZsQaqjBOJkL7Jx2lDxHoU433bcJ5
   GKupOZQwBwolH0CDR2wSUIYj1FhbqoOsuQASEJRkQWPsG0h3gdMRsfBMJ
   v7McbAwhOZqHItnc7xbBP1o7PwU6ML5rDVC45TkvWHVpWUESnYx+/u1j3
   wnH5MuQeRVmYHf9aRa4+k6uDOBb/R/yjcU/RuVcQhGx1fcw09gAzx/bXl
   fRUkggBGBJDqigOoTKLy0tBOYCvdADSdVcXgA1LRDZUjUt/mrakBWGEsf
   /n0H0WP8eluqFWnr0EaolabNq2ATNsqhpFU0q0QH1hiulQH16nbHHoCOT
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="248017067"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="248017067"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 18:40:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="771651829"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Feb 2022 18:40:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFS34-000VS1-CH; Thu, 03 Feb 2022 02:40:38 +0000
Date:   Thu, 3 Feb 2022 10:39:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manisha Chinthapally <manisha.chinthapally@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mchinth:sep_socwatch_linux_5_16 1/1]
 drivers/platform/x86/sepdk/sep/eventmux.c:371:13: warning: no previous
 prototype for 'EVENTMUX_Start'
Message-ID: <202202030918.94O8WKsL-lkp@intel.com>
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
config: x86_64-randconfig-a004-20220131 (https://download.01.org/0day-ci/archive/20220203/202202030918.94O8WKsL-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/mchinth/linux/commit/4cbfca15a262729ae8557758b49226fe4769f582
        git remote add mchinth https://github.com/mchinth/linux
        git fetch --no-tags mchinth sep_socwatch_linux_5_16
        git checkout 4cbfca15a262729ae8557758b49226fe4769f582
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/x86/sepdk/pax/ drivers/platform/x86/sepdk/sep/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/sepdk/pax/pax.c:171:5: warning: no previous prototype for 'pax_Disable_NMIWatchdog' [-Wmissing-prototypes]
     171 | S32 pax_Disable_NMIWatchdog(PVOID data)
         |     ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/platform/x86/sepdk/pax/pax.c:240:5: warning: no previous prototype for 'pax_Check_NMIWatchdog' [-Wmissing-prototypes]
     240 | S32 pax_Check_NMIWatchdog(PVOID data)
         |     ^~~~~~~~~~~~~~~~~~~~~
>> drivers/platform/x86/sepdk/pax/pax.c:280:5: warning: no previous prototype for 'pax_Enable_NMIWatchdog' [-Wmissing-prototypes]
     280 | S32 pax_Enable_NMIWatchdog(PVOID data)
         |     ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/platform/x86/sepdk/pax/pax.c:700:22: warning: no previous prototype for 'pax_Service_IOCTL' [-Wmissing-prototypes]
     700 | extern IOCTL_OP_TYPE pax_Service_IOCTL(IOCTL_USE_INODE struct file *filp,
         |                      ^~~~~~~~~~~~~~~~~
>> drivers/platform/x86/sepdk/pax/pax.c:738:13: warning: no previous prototype for 'pax_Device_Control' [-Wmissing-prototypes]
     738 | extern long pax_Device_Control(IOCTL_USE_INODE struct file *filp,
         |             ^~~~~~~~~~~~~~~~~~
>> drivers/platform/x86/sepdk/pax/pax.c:754:22: warning: no previous prototype for 'pax_Device_Control_Compat' [-Wmissing-prototypes]
     754 | extern IOCTL_OP_TYPE pax_Device_Control_Compat(struct file *filp,
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/platform/x86/sepdk/pax/pax.c:859:12: warning: no previous prototype for 'pax_Load' [-Wmissing-prototypes]
     859 | extern int pax_Load(VOID)
         |            ^~~~~~~~
>> drivers/platform/x86/sepdk/pax/pax.c:935:13: warning: no previous prototype for 'pax_Unload' [-Wmissing-prototypes]
     935 | extern VOID pax_Unload(VOID)
         |             ^~~~~~~~~~
--
   drivers/platform/x86/sepdk/sep/lwpmudrv.c: In function 'lwpmudrv_Trigger_Read_Op':
>> drivers/platform/x86/sepdk/sep/lwpmudrv.c:1990:12: warning: variable 'pcpu' set but not used [-Wunused-but-set-variable]
    1990 |  CPU_STATE pcpu;
         |            ^~~~
   drivers/platform/x86/sepdk/sep/lwpmudrv.c: At top level:
>> drivers/platform/x86/sepdk/sep/lwpmudrv.c:6693:22: warning: no previous prototype for 'lwpmu_Service_IOCTL' [-Wmissing-prototypes]
    6693 | extern IOCTL_OP_TYPE lwpmu_Service_IOCTL(IOCTL_USE_INODE struct file *filp,
         |                      ^~~~~~~~~~~~~~~~~~~
>> drivers/platform/x86/sepdk/sep/lwpmudrv.c:7031:13: warning: no previous prototype for 'lwpmu_Device_Control' [-Wmissing-prototypes]
    7031 | extern long lwpmu_Device_Control(IOCTL_USE_INODE struct file *filp,
         |             ^~~~~~~~~~~~~~~~~~~~
>> drivers/platform/x86/sepdk/sep/lwpmudrv.c:7066:13: warning: no previous prototype for 'lwpmu_Device_Control_Compat' [-Wmissing-prototypes]
    7066 | extern long lwpmu_Device_Control_Compat(struct file *filp, unsigned int cmd,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/platform/x86/sepdk/sep/lwpmudrv.c:7120:12: warning: no previous prototype for 'LWPMUDRV_Abnormal_Terminate' [-Wmissing-prototypes]
    7120 | extern int LWPMUDRV_Abnormal_Terminate(void)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/platform/x86/sepdk/sep/cpumon.c: In function 'CPUMON_is_Online_Allowed':
>> drivers/platform/x86/sepdk/sep/cpumon.c:133:17: warning: old-style function definition [-Wold-style-definition]
     133 | extern DRV_BOOL CPUMON_is_Online_Allowed()
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/sepdk/sep/cpumon.c: In function 'CPUMON_is_Offline_Allowed':
   drivers/platform/x86/sepdk/sep/cpumon.c:172:17: warning: old-style function definition [-Wold-style-definition]
     172 | extern DRV_BOOL CPUMON_is_Offline_Allowed()
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/platform/x86/sepdk/sep/eventmux.c:371:13: warning: no previous prototype for 'EVENTMUX_Start' [-Wmissing-prototypes]
     371 | extern VOID EVENTMUX_Start(VOID)
         |             ^~~~~~~~~~~~~~
>> drivers/platform/x86/sepdk/sep/eventmux.c:400:13: warning: no previous prototype for 'EVENTMUX_Initialize' [-Wmissing-prototypes]
     400 | extern VOID EVENTMUX_Initialize(VOID)
         |             ^~~~~~~~~~~~~~~~~~~
>> drivers/platform/x86/sepdk/sep/eventmux.c:455:13: warning: no previous prototype for 'EVENTMUX_Destroy' [-Wmissing-prototypes]
     455 | extern VOID EVENTMUX_Destroy(VOID)
         |             ^~~~~~~~~~~~~~~~
--
>> drivers/platform/x86/sepdk/sep/linuxos.c:710:5: warning: no previous prototype for 'linuxos_online_cpu' [-Wmissing-prototypes]
     710 | int linuxos_online_cpu(unsigned int cpu)
         |     ^~~~~~~~~~~~~~~~~~
>> drivers/platform/x86/sepdk/sep/linuxos.c:735:5: warning: no previous prototype for 'linuxos_offline_cpu' [-Wmissing-prototypes]
     735 | int linuxos_offline_cpu(unsigned int cpu)
         |     ^~~~~~~~~~~~~~~~~~~
--
>> drivers/platform/x86/sepdk/sep/pmi.c:81:5: warning: no previous prototype for 'pmi_Get_CSD' [-Wmissing-prototypes]
      81 | U32 pmi_Get_CSD(U32 seg, U32 *low, U32 *high)
         |     ^~~~~~~~~~~
--
   drivers/platform/x86/sepdk/sep/sys_info.c: In function 'sys_info_Fill_CPUID':
>> drivers/platform/x86/sepdk/sep/sys_info.c:325:6: warning: variable 'family' set but not used [-Wunused-but-set-variable]
     325 |  U32 family = 0;
         |      ^~~~~~
   drivers/platform/x86/sepdk/sep/sys_info.c: In function 'SYS_INFO_Build':
>> drivers/platform/x86/sepdk/sep/sys_info.c:935:6: warning: variable 'me' set but not used [-Wunused-but-set-variable]
     935 |  int me;
         |      ^~
--
   drivers/platform/x86/sepdk/sep/unc_power.c: In function 'unc_rdt_program_autormid':
>> drivers/platform/x86/sepdk/sep/unc_power.c:60:6: warning: variable 'cur_grp' set but not used [-Wunused-but-set-variable]
      60 |  U32 cur_grp;
         |      ^~~~~~~
   drivers/platform/x86/sepdk/sep/unc_power.c: In function 'unc_power_Trigger_Read':
   drivers/platform/x86/sepdk/sep/unc_power.c:350:6: warning: variable 'cur_grp' set but not used [-Wunused-but-set-variable]
     350 |  U32 cur_grp;
         |      ^~~~~~~
--
   drivers/platform/x86/sepdk/sep/core2.c: In function 'core2_Swap_Group':
>> drivers/platform/x86/sepdk/sep/core2.c:996:6: warning: variable 'cur_grp' set but not used [-Wunused-but-set-variable]
     996 |  U32 cur_grp;
         |      ^~~~~~~
   drivers/platform/x86/sepdk/sep/core2.c: In function 'corei7_Read_LBRs':
>> drivers/platform/x86/sepdk/sep/core2.c:1391:6: warning: variable 'pairs' set but not used [-Wunused-but-set-variable]
    1391 |  U32 pairs = 0;
         |      ^~~~~
--
   drivers/platform/x86/sepdk/sep/perfver4.c: In function 'perfver4_Read_LBRs':
>> drivers/platform/x86/sepdk/sep/perfver4.c:1054:6: warning: variable 'pairs' set but not used [-Wunused-but-set-variable]
    1054 |  U32 pairs = 0;
         |      ^~~~~
--
   drivers/platform/x86/sepdk/sep/silvermont.c: In function 'silvermont_Initialize':
>> drivers/platform/x86/sepdk/sep/silvermont.c:764:13: warning: variable 'pcfg' set but not used [-Wunused-but-set-variable]
     764 |  DEV_CONFIG pcfg;
         |             ^~~~
..


vim +/EVENTMUX_Start +371 drivers/platform/x86/sepdk/sep/eventmux.c

   354	
   355	/* ------------------------------------------------------------------------- */
   356	/*!
   357	 * @fn          VOID EVENTMUX_Start (
   358	 *                         VOID
   359	 *                         )
   360	 *
   361	 * @brief       Start the timers and enable all the threads
   362	 *
   363	 * @param       NONE
   364	 *
   365	 * @return      NONE
   366	 *
   367	 * <I>Special Notes:</I>
   368	 *              if event multiplexing has been enabled, set up the time slices and
   369	 *              start the timer threads for all the timers
   370	 */
 > 371	extern VOID EVENTMUX_Start(VOID)
   372	{
   373		SEP_DRV_LOG_TRACE_IN("");
   374	
   375		/*
   376	     * Start the timer for all cpus
   377	     */
   378		CONTROL_Invoke_Parallel(eventmux_Start_Timers, NULL);
   379	
   380		SEP_DRV_LOG_TRACE_OUT("");
   381	}
   382	
   383	/* ------------------------------------------------------------------------- */
   384	/*!
   385	 * @fn          VOID EVENTMUX_Initialize (
   386	 *                         VOID
   387	 *                         )
   388	 *
   389	 * @brief       Initialize the event multiplexing module
   390	 *
   391	 * @param       NONE
   392	 *
   393	 * @return      NONE
   394	 *
   395	 * <I>Special Notes:</I>
   396	 *              if event multiplexing has been enabled,
   397	 *              then allocate the memory needed to save and restore all the counter data
   398	 *              set up the timers needed, but do not start them
   399	 */
 > 400	extern VOID EVENTMUX_Initialize(VOID)
   401	{
   402		S32 size_of_vector;
   403		S32 cpu_num;
   404		CPU_STATE pcpu;
   405		U32 dev_idx;
   406		EVENT_CONFIG ec;
   407	
   408		SEP_DRV_LOG_TRACE_IN("");
   409	
   410		for (cpu_num = 0; cpu_num < GLOBAL_STATE_num_cpus(driver_state);
   411		     cpu_num++) {
   412			pcpu = &pcb[cpu_num];
   413			dev_idx = core_to_dev_map[cpu_num];
   414			ec = LWPMU_DEVICE_ec(&devices[dev_idx]);
   415			if (ec == NULL) {
   416				continue;
   417			}
   418			if (EVENT_CONFIG_mode(ec) == EM_DISABLED ||
   419			    EVENT_CONFIG_num_groups(ec) == 1) {
   420				continue;
   421			}
   422			size_of_vector = EVENT_CONFIG_num_groups(ec) *
   423					 EVENT_CONFIG_max_gp_events(ec) * sizeof(S64);
   424			CPU_STATE_em_table_offset(pcpu) = em_tables_size;
   425			em_tables_size += size_of_vector;
   426		}
   427	
   428		if (em_tables_size) {
   429			em_tables = CONTROL_Allocate_Memory(em_tables_size);
   430		}
   431		CONTROL_Invoke_Parallel(eventmux_Allocate_Groups, NULL);
   432	
   433		CONTROL_Invoke_Parallel(eventmux_Prepare_Timer_Threads,
   434					(VOID *)(size_t)0);
   435	
   436		SEP_DRV_LOG_TRACE_OUT("");
   437	}
   438	
   439	/* ------------------------------------------------------------------------- */
   440	/*!
   441	 * @fn          VOID EVENTMUX_Destroy (
   442	 *                         VOID
   443	 *                         )
   444	 *
   445	 * @brief       Clean up the event multiplexing threads
   446	 *
   447	 * @param       NONE
   448	 *
   449	 * @return      NONE
   450	 *
   451	 * <I>Special Notes:</I>
   452	 *              if event multiplexing has been enabled, then stop and cancel all the timers
   453	 *              free up all the memory that is associated with EM
   454	 */
 > 455	extern VOID EVENTMUX_Destroy(VOID)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

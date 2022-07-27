Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8F1581E92
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 06:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiG0EVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 00:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiG0EVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 00:21:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777C61EC50
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 21:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658895709; x=1690431709;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ga6jbB3bqzHysYo1ZI5QzBW/AWb3hkEy9Y6KWEXgnuQ=;
  b=jxtmFNtrkUKpF+vTEgoAKs3jUXvfM4A/BHvoriEJxY2j5GWKQBN7JKwF
   CvLnUtuY+NMCxAjaB1CCxnoqeetpTW3a/mqqDHfiQtiQcyqsZY9dHjec2
   f1jgdg7OxQ46b0wzXWEHNs2a64xPCsyemslRImBWP6qes6utO5nJiMbwV
   Sck3DqyGrqmr4IGwxgzyS5LjUEn0Ja9djAYeZMRfSeLl3SRMZWljH3LFC
   Rkn/351jbEyVnWJUhhFI/M7VmeIHuuwMtuqW+u2442xPezVfCtELjyxTx
   K1Qd6JIcfItr22lo9wNyU568fHgfXUDjNi7JIsxr3M257RcVsPXi4o9n8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="285687394"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="285687394"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 21:21:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="575805892"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Jul 2022 21:21:47 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGYYM-0008JU-29;
        Wed, 27 Jul 2022 04:21:46 +0000
Date:   Wed, 27 Jul 2022 12:21:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manisha Chinthapally <manisha.chinthapally@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/platform/x86/socperf/socperfdrv.c:203:13: sparse: sparse:
 function 'SOCPERF_Read_Data3' with external linkage has definition
Message-ID: <202207271245.tJtJrmMZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
commit: c859e634bf058e7963fccc4c1219c1365e925ad4 platform/x86: Update SEP driver for 5.9 pull
date:   1 year, 10 months ago
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220727/202207271245.tJtJrmMZ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/mchinth/linux/commit/c859e634bf058e7963fccc4c1219c1365e925ad4
        git remote add mchinth https://github.com/mchinth/linux
        git fetch --no-tags mchinth sep_socwatch_linux_5_10
        git checkout c859e634bf058e7963fccc4c1219c1365e925ad4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/x86/socperf/socperfdrv.c:203:13: sparse: sparse: function 'SOCPERF_Read_Data3' with external linkage has definition
   drivers/platform/x86/socperf/socperfdrv.c:885:1: sparse: sparse: function 'SOCPERF_Switch_Group3' with external linkage has definition
>> drivers/platform/x86/socperf/socperfdrv.c:101:22: sparse: sparse: symbol 'socperf_drv_version' was not declared. Should it be static?
>> drivers/platform/x86/socperf/socperfdrv.c:102:5: sparse: sparse: symbol 'read_unc_ctr_info' was not declared. Should it be static?
>> drivers/platform/x86/socperf/socperfdrv.c:103:10: sparse: sparse: symbol 'dispatch_uncore' was not declared. Should it be static?
   drivers/platform/x86/socperf/socperfdrv.c:104:12: sparse: sparse: symbol 'socperf_drv_cfg' was not declared. Should it be static?
>> drivers/platform/x86/socperf/socperfdrv.c:105:14: sparse: sparse: symbol 'socperf_global_ec' was not declared. Should it be static?
>> drivers/platform/x86/socperf/socperfdrv.c:106:14: sparse: sparse: symbol 'socperf_abnormal_terminate' was not declared. Should it be static?
>> drivers/platform/x86/socperf/socperfdrv.c:107:11: sparse: sparse: symbol 'socperf_control' was not declared. Should it be static?
>> drivers/platform/x86/socperf/socperfdrv.c:111:8: sparse: sparse: symbol 'socperf_pcb_size' was not declared. Should it be static?
>> drivers/platform/x86/socperf/socperfdrv.c:984:28: sparse: sparse: Using plain integer as NULL pointer
>> drivers/platform/x86/socperf/socperfdrv.c:1070:6: sparse: sparse: symbol 'lwpmudrv_Stop_Mem' was not declared. Should it be static?
>> drivers/platform/x86/socperf/socperfdrv.c:1155:15: sparse: sparse: symbol 'socperf_Service_IOCTL' was not declared. Should it be static?
>> drivers/platform/x86/socperf/socperfdrv.c:1274:6: sparse: sparse: symbol 'socperf_Device_Control' was not declared. Should it be static?
>> drivers/platform/x86/socperf/socperfdrv.c:1358:5: sparse: sparse: symbol 'SOCPERF_Abnormal_Terminate' was not declared. Should it be static?

vim +/SOCPERF_Read_Data3 +203 drivers/platform/x86/socperf/socperfdrv.c

f57492d07625dd Manisha Chinthapally 2019-05-01   99  
f57492d07625dd Manisha Chinthapally 2019-05-01  100  /* Global variables of the driver */
f57492d07625dd Manisha Chinthapally 2019-05-01 @101  SOCPERF_VERSION_NODE socperf_drv_version;
f57492d07625dd Manisha Chinthapally 2019-05-01 @102  U64 *read_unc_ctr_info;
f57492d07625dd Manisha Chinthapally 2019-05-01 @103  DISPATCH dispatch_uncore;
f57492d07625dd Manisha Chinthapally 2019-05-01  104  DRV_CONFIG socperf_drv_cfg;
f57492d07625dd Manisha Chinthapally 2019-05-01 @105  EVENT_CONFIG socperf_global_ec;
f57492d07625dd Manisha Chinthapally 2019-05-01 @106  volatile S32 socperf_abnormal_terminate;
f57492d07625dd Manisha Chinthapally 2019-05-01 @107  LWPMU_DEV socperf_control;
f57492d07625dd Manisha Chinthapally 2019-05-01  108  
f57492d07625dd Manisha Chinthapally 2019-05-01  109  LWPMU_DEVICE device_uncore;
f57492d07625dd Manisha Chinthapally 2019-05-01  110  CPU_STATE socperf_pcb;
f57492d07625dd Manisha Chinthapally 2019-05-01 @111  size_t socperf_pcb_size;
f57492d07625dd Manisha Chinthapally 2019-05-01  112  
f57492d07625dd Manisha Chinthapally 2019-05-01  113  #if defined(DRV_USE_UNLOCKED_IOCTL)
f57492d07625dd Manisha Chinthapally 2019-05-01  114  static struct mutex ioctl_lock;
f57492d07625dd Manisha Chinthapally 2019-05-01  115  #endif
f57492d07625dd Manisha Chinthapally 2019-05-01  116  
f57492d07625dd Manisha Chinthapally 2019-05-01  117  #define PMU_DEVICES 1 // pmu control
f57492d07625dd Manisha Chinthapally 2019-05-01  118  
f57492d07625dd Manisha Chinthapally 2019-05-01  119  static dev_t lwpmu_DevNum; /* the major and minor parts for SOCPERF base */
f57492d07625dd Manisha Chinthapally 2019-05-01  120  
f57492d07625dd Manisha Chinthapally 2019-05-01  121  static struct class *pmu_class;
f57492d07625dd Manisha Chinthapally 2019-05-01  122  
f57492d07625dd Manisha Chinthapally 2019-05-01  123  #define DRV_DEVICE_DELIMITER "!"
f57492d07625dd Manisha Chinthapally 2019-05-01  124  
f57492d07625dd Manisha Chinthapally 2019-05-01  125  #if !defined(DRV_USE_UNLOCKED_IOCTL)
f57492d07625dd Manisha Chinthapally 2019-05-01  126  #define MUTEX_INIT(lock)
f57492d07625dd Manisha Chinthapally 2019-05-01  127  #define MUTEX_LOCK(lock)
f57492d07625dd Manisha Chinthapally 2019-05-01  128  #define MUTEX_UNLOCK(lock)
f57492d07625dd Manisha Chinthapally 2019-05-01  129  #else
f57492d07625dd Manisha Chinthapally 2019-05-01  130  #define MUTEX_INIT(lock) mutex_init(&(lock))
f57492d07625dd Manisha Chinthapally 2019-05-01  131  #define MUTEX_LOCK(lock) mutex_lock(&(lock))
f57492d07625dd Manisha Chinthapally 2019-05-01  132  #define MUTEX_UNLOCK(lock) mutex_unlock(&(lock))
f57492d07625dd Manisha Chinthapally 2019-05-01  133  #endif
f57492d07625dd Manisha Chinthapally 2019-05-01  134  
f57492d07625dd Manisha Chinthapally 2019-05-01  135  /* ------------------------------------------------------------------------- */
f57492d07625dd Manisha Chinthapally 2019-05-01  136  /*!
f57492d07625dd Manisha Chinthapally 2019-05-01  137   * @fn  static OS_STATUS lwpmudrv_Initialize_State(void)
f57492d07625dd Manisha Chinthapally 2019-05-01  138   *
f57492d07625dd Manisha Chinthapally 2019-05-01  139   * @param none
f57492d07625dd Manisha Chinthapally 2019-05-01  140   *
f57492d07625dd Manisha Chinthapally 2019-05-01  141   * @return OS_STATUS
f57492d07625dd Manisha Chinthapally 2019-05-01  142   *
f57492d07625dd Manisha Chinthapally 2019-05-01  143   * @brief  Allocates the memory needed at load time.  Initializes all the
f57492d07625dd Manisha Chinthapally 2019-05-01  144   * @brief  necessary state variables with the default values.
f57492d07625dd Manisha Chinthapally 2019-05-01  145   *
f57492d07625dd Manisha Chinthapally 2019-05-01  146   * <I>Special Notes</I>
f57492d07625dd Manisha Chinthapally 2019-05-01  147   */
f57492d07625dd Manisha Chinthapally 2019-05-01  148  static OS_STATUS lwpmudrv_Initialize_State(VOID)
f57492d07625dd Manisha Chinthapally 2019-05-01  149  {
f57492d07625dd Manisha Chinthapally 2019-05-01  150  	S32 i, max_cpu_id = 0;
f57492d07625dd Manisha Chinthapally 2019-05-01  151  
f57492d07625dd Manisha Chinthapally 2019-05-01  152  	for_each_possible_cpu(i) {
f57492d07625dd Manisha Chinthapally 2019-05-01  153  		if (cpu_present(i)) {
f57492d07625dd Manisha Chinthapally 2019-05-01  154  			if (i > max_cpu_id) {
f57492d07625dd Manisha Chinthapally 2019-05-01  155  				max_cpu_id = i;
f57492d07625dd Manisha Chinthapally 2019-05-01  156  			}
f57492d07625dd Manisha Chinthapally 2019-05-01  157  		}
f57492d07625dd Manisha Chinthapally 2019-05-01  158  	}
f57492d07625dd Manisha Chinthapally 2019-05-01  159  	max_cpu_id++;
f57492d07625dd Manisha Chinthapally 2019-05-01  160  
f57492d07625dd Manisha Chinthapally 2019-05-01  161  	/*
f57492d07625dd Manisha Chinthapally 2019-05-01  162  	 *  Machine Initializations
f57492d07625dd Manisha Chinthapally 2019-05-01  163  	 *  Abstract this information away into a separate entry point
f57492d07625dd Manisha Chinthapally 2019-05-01  164  	 *
f57492d07625dd Manisha Chinthapally 2019-05-01  165  	 *  Question:  Should we allow for the use of Hot-cpu
f57492d07625dd Manisha Chinthapally 2019-05-01  166  	 *    add/subtract functionality while the driver is executing?
f57492d07625dd Manisha Chinthapally 2019-05-01  167  	 */
f57492d07625dd Manisha Chinthapally 2019-05-01  168  	if (max_cpu_id > num_present_cpus()) {
f57492d07625dd Manisha Chinthapally 2019-05-01  169  		GLOBAL_STATE_num_cpus(socperf_driver_state) = max_cpu_id;
f57492d07625dd Manisha Chinthapally 2019-05-01  170  	} else {
f57492d07625dd Manisha Chinthapally 2019-05-01  171  		GLOBAL_STATE_num_cpus(socperf_driver_state) =
f57492d07625dd Manisha Chinthapally 2019-05-01  172  			num_present_cpus();
f57492d07625dd Manisha Chinthapally 2019-05-01  173  	}
f57492d07625dd Manisha Chinthapally 2019-05-01  174  	GLOBAL_STATE_active_cpus(socperf_driver_state) = num_online_cpus();
f57492d07625dd Manisha Chinthapally 2019-05-01  175  	GLOBAL_STATE_cpu_count(socperf_driver_state) = 0;
f57492d07625dd Manisha Chinthapally 2019-05-01  176  	GLOBAL_STATE_dpc_count(socperf_driver_state) = 0;
f57492d07625dd Manisha Chinthapally 2019-05-01  177  	GLOBAL_STATE_num_em_groups(socperf_driver_state) = 0;
f57492d07625dd Manisha Chinthapally 2019-05-01  178  	GLOBAL_STATE_current_phase(socperf_driver_state) =
f57492d07625dd Manisha Chinthapally 2019-05-01  179  		DRV_STATE_UNINITIALIZED;
f57492d07625dd Manisha Chinthapally 2019-05-01  180  
f57492d07625dd Manisha Chinthapally 2019-05-01  181  	SOCPERF_PRINT_DEBUG(
f57492d07625dd Manisha Chinthapally 2019-05-01  182  		"%s: num_cpus=%d, active_cpus=%d\n",
f57492d07625dd Manisha Chinthapally 2019-05-01  183  		__func__,
f57492d07625dd Manisha Chinthapally 2019-05-01  184  		GLOBAL_STATE_num_cpus(socperf_driver_state),
f57492d07625dd Manisha Chinthapally 2019-05-01  185  		GLOBAL_STATE_active_cpus(socperf_driver_state));
f57492d07625dd Manisha Chinthapally 2019-05-01  186  
f57492d07625dd Manisha Chinthapally 2019-05-01  187  	return OS_SUCCESS;
f57492d07625dd Manisha Chinthapally 2019-05-01  188  }
f57492d07625dd Manisha Chinthapally 2019-05-01  189  
f57492d07625dd Manisha Chinthapally 2019-05-01  190  /* ------------------------------------------------------------------------- */
f57492d07625dd Manisha Chinthapally 2019-05-01  191  /*!
f57492d07625dd Manisha Chinthapally 2019-05-01  192   * @fn       VOID SOCPERF_Read_Data
f57492d07625dd Manisha Chinthapally 2019-05-01  193   *
f57492d07625dd Manisha Chinthapally 2019-05-01  194   * @brief    Reads counter data
f57492d07625dd Manisha Chinthapally 2019-05-01  195   *
f57492d07625dd Manisha Chinthapally 2019-05-01  196   * @param    param   data_buffer - buffer for reading counter data.
f57492d07625dd Manisha Chinthapally 2019-05-01  197   *
f57492d07625dd Manisha Chinthapally 2019-05-01  198   * @return  None
f57492d07625dd Manisha Chinthapally 2019-05-01  199   *
f57492d07625dd Manisha Chinthapally 2019-05-01  200   * <I>Special Notes:</I>
f57492d07625dd Manisha Chinthapally 2019-05-01  201   *              <NONE>
f57492d07625dd Manisha Chinthapally 2019-05-01  202   */
f57492d07625dd Manisha Chinthapally 2019-05-01 @203  extern VOID SOCPERF_Read_Data3(PVOID data_buffer)
f57492d07625dd Manisha Chinthapally 2019-05-01  204  {
f57492d07625dd Manisha Chinthapally 2019-05-01  205  	if (dispatch_uncore && dispatch_uncore->read_current_data) {
f57492d07625dd Manisha Chinthapally 2019-05-01  206  		dispatch_uncore->read_current_data(data_buffer);
f57492d07625dd Manisha Chinthapally 2019-05-01  207  	}
f57492d07625dd Manisha Chinthapally 2019-05-01  208  	SOCPERF_PRINT_DEBUG("%s called\n", __func__);
f57492d07625dd Manisha Chinthapally 2019-05-01  209  }
f57492d07625dd Manisha Chinthapally 2019-05-01  210  EXPORT_SYMBOL(SOCPERF_Read_Data3);
f57492d07625dd Manisha Chinthapally 2019-05-01  211  

:::::: The code at line 203 was first introduced by commit
:::::: f57492d07625dddac7920eccdb5be08c55ee16fa platform/x86: SOCPERF3 support for sep & socwatch

:::::: TO: Manisha Chinthapally <manisha.chinthapally@intel.com>
:::::: CC: Faycal Benmlih <faycal.benmlih@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

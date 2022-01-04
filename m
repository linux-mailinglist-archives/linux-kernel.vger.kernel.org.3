Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A940F483D9D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiADIDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:03:21 -0500
Received: from mga03.intel.com ([134.134.136.65]:36681 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233940AbiADIDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:03:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641283399; x=1672819399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fXwH3SxAg7pN0nTSPRYlxNHNuc3ldtTKbuPyVaIfvkM=;
  b=NyuZQAfmnN4yQH3/dDFz3z57uKsJGpqgWNLRgPHpLCOGtowb55tAf1SG
   d290Aa5TqP3TAsObNWkFDVnvdPn3WhTCBekNr9eHTmHl7GTxRXVgUhuu6
   HCQi1a02rf3BHjluYjnMii/tKovjSCIk+ldKfIAWOFiBiGQVtUMuLmsfe
   gOVrDyO6NFT/mUUpH787mNhbBAw24N2xjwgzA6TG+XDg0oCm8dfkb9Aqt
   EF/liCfHrGUwqay/gH9TgxlChqRkXmdKkSuaL59QaeQQ1qfcThpdVpGP9
   xOkP0zi0Q+hQIuK2oDdcJSbhl95e5m9Y15eAuNjF/6dhlqSicsvzrKOVo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="242133691"
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="242133691"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 00:02:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="556090074"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Jan 2022 00:02:39 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4emE-000F4U-Lg; Tue, 04 Jan 2022 08:02:38 +0000
Date:   Tue, 4 Jan 2022 16:01:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     kbuild-all@lists.01.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] ACPI: PCC: Implement OperationRegion handler for the
 PCC Type 3 subtype
Message-ID: <202201041539.feAV0l27-lkp@intel.com>
References: <20220103155838.616580-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103155838.616580-1-sudeep.holla@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

I love your patch! Yet something to improve:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on linux/master linus/master v5.16-rc8 next-20211224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sudeep-Holla/ACPI-PCC-Implement-OperationRegion-handler-for-the-PCC-Type-3-subtype/20220104-000003
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220104/202201041539.feAV0l27-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/1dbcdc47eadc8c55659410fc03d067f3438a386a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sudeep-Holla/ACPI-PCC-Implement-OperationRegion-handler-for-the-PCC-Type-3-subtype/20220104-000003
        git checkout 1dbcdc47eadc8c55659410fc03d067f3438a386a
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/acpi/acpi.h:29,
                    from include/linux/acpi.h:22,
                    from drivers/acpi/acpi_pcc.c:19:
   drivers/acpi/acpi_pcc.c: In function 'acpi_pcc_address_space_setup':
>> include/acpi/acoutput.h:398:19: error: implicit declaration of function 'acpi_ut_status_exit'; did you mean 'acpi_irq_stats_init'? [-Werror=implicit-function-declaration]
     398 |  ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
         |                   ^~~~~~~~~~~~~~~~~~~
   include/acpi/acoutput.h:281:44: note: in definition of macro 'ACPI_DO_WHILE0'
     281 | #define ACPI_DO_WHILE0(a)               do a while(0)
         |                                            ^
   include/acpi/acoutput.h:398:2: note: in expansion of macro 'ACPI_TRACE_EXIT'
     398 |  ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
         |  ^~~~~~~~~~~~~~~
   drivers/acpi/acpi_pcc.c:53:3: note: in expansion of macro 'return_ACPI_STATUS'
      53 |   return_ACPI_STATUS(AE_NO_MEMORY);
         |   ^~~~~~~~~~~~~~~~~~
>> include/acpi/acoutput.h:258:36: error: '_acpi_module_name' undeclared (first use in this function); did you mean 'acpi_dev_name'?
     258 |  __LINE__, ACPI_GET_FUNCTION_NAME, _acpi_module_name, _COMPONENT
         |                                    ^~~~~~~~~~~~~~~~~
   include/acpi/acoutput.h:281:44: note: in definition of macro 'ACPI_DO_WHILE0'
     281 | #define ACPI_DO_WHILE0(a)               do a while(0)
         |                                            ^
   include/acpi/acoutput.h:375:13: note: in expansion of macro 'ACPI_DEBUG_PARAMETERS'
     375 |   function (ACPI_DEBUG_PARAMETERS, _param); \
         |             ^~~~~~~~~~~~~~~~~~~~~
   include/acpi/acoutput.h:398:2: note: in expansion of macro 'ACPI_TRACE_EXIT'
     398 |  ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
         |  ^~~~~~~~~~~~~~~
   drivers/acpi/acpi_pcc.c:53:3: note: in expansion of macro 'return_ACPI_STATUS'
      53 |   return_ACPI_STATUS(AE_NO_MEMORY);
         |   ^~~~~~~~~~~~~~~~~~
   include/acpi/acoutput.h:258:36: note: each undeclared identifier is reported only once for each function it appears in
     258 |  __LINE__, ACPI_GET_FUNCTION_NAME, _acpi_module_name, _COMPONENT
         |                                    ^~~~~~~~~~~~~~~~~
   include/acpi/acoutput.h:281:44: note: in definition of macro 'ACPI_DO_WHILE0'
     281 | #define ACPI_DO_WHILE0(a)               do a while(0)
         |                                            ^
   include/acpi/acoutput.h:375:13: note: in expansion of macro 'ACPI_DEBUG_PARAMETERS'
     375 |   function (ACPI_DEBUG_PARAMETERS, _param); \
         |             ^~~~~~~~~~~~~~~~~~~~~
   include/acpi/acoutput.h:398:2: note: in expansion of macro 'ACPI_TRACE_EXIT'
     398 |  ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
         |  ^~~~~~~~~~~~~~~
   drivers/acpi/acpi_pcc.c:53:3: note: in expansion of macro 'return_ACPI_STATUS'
      53 |   return_ACPI_STATUS(AE_NO_MEMORY);
         |   ^~~~~~~~~~~~~~~~~~
>> include/acpi/acoutput.h:258:55: error: '_COMPONENT' undeclared (first use in this function)
     258 |  __LINE__, ACPI_GET_FUNCTION_NAME, _acpi_module_name, _COMPONENT
         |                                                       ^~~~~~~~~~
   include/acpi/acoutput.h:281:44: note: in definition of macro 'ACPI_DO_WHILE0'
     281 | #define ACPI_DO_WHILE0(a)               do a while(0)
         |                                            ^
   include/acpi/acoutput.h:375:13: note: in expansion of macro 'ACPI_DEBUG_PARAMETERS'
     375 |   function (ACPI_DEBUG_PARAMETERS, _param); \
         |             ^~~~~~~~~~~~~~~~~~~~~
   include/acpi/acoutput.h:398:2: note: in expansion of macro 'ACPI_TRACE_EXIT'
     398 |  ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
         |  ^~~~~~~~~~~~~~~
   drivers/acpi/acpi_pcc.c:53:3: note: in expansion of macro 'return_ACPI_STATUS'
      53 |   return_ACPI_STATUS(AE_NO_MEMORY);
         |   ^~~~~~~~~~~~~~~~~~
   drivers/acpi/acpi_pcc.c: In function 'acpi_pcc_address_space_handler':
>> include/acpi/acoutput.h:258:36: error: '_acpi_module_name' undeclared (first use in this function); did you mean 'acpi_dev_name'?
     258 |  __LINE__, ACPI_GET_FUNCTION_NAME, _acpi_module_name, _COMPONENT
         |                                    ^~~~~~~~~~~~~~~~~
   include/acpi/acoutput.h:281:44: note: in definition of macro 'ACPI_DO_WHILE0'
     281 | #define ACPI_DO_WHILE0(a)               do a while(0)
         |                                            ^
   include/acpi/acoutput.h:375:13: note: in expansion of macro 'ACPI_DEBUG_PARAMETERS'
     375 |   function (ACPI_DEBUG_PARAMETERS, _param); \
         |             ^~~~~~~~~~~~~~~~~~~~~
   include/acpi/acoutput.h:398:2: note: in expansion of macro 'ACPI_TRACE_EXIT'
     398 |  ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
         |  ^~~~~~~~~~~~~~~
   drivers/acpi/acpi_pcc.c:97:3: note: in expansion of macro 'return_ACPI_STATUS'
      97 |   return_ACPI_STATUS(AE_ERROR);
         |   ^~~~~~~~~~~~~~~~~~
>> include/acpi/acoutput.h:258:55: error: '_COMPONENT' undeclared (first use in this function)
     258 |  __LINE__, ACPI_GET_FUNCTION_NAME, _acpi_module_name, _COMPONENT
         |                                                       ^~~~~~~~~~
   include/acpi/acoutput.h:281:44: note: in definition of macro 'ACPI_DO_WHILE0'
     281 | #define ACPI_DO_WHILE0(a)               do a while(0)
         |                                            ^
   include/acpi/acoutput.h:375:13: note: in expansion of macro 'ACPI_DEBUG_PARAMETERS'
     375 |   function (ACPI_DEBUG_PARAMETERS, _param); \
         |             ^~~~~~~~~~~~~~~~~~~~~
   include/acpi/acoutput.h:398:2: note: in expansion of macro 'ACPI_TRACE_EXIT'
     398 |  ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
         |  ^~~~~~~~~~~~~~~
   drivers/acpi/acpi_pcc.c:97:3: note: in expansion of macro 'return_ACPI_STATUS'
      97 |   return_ACPI_STATUS(AE_ERROR);
         |   ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +398 include/acpi/acoutput.h

50df4d8b0f6e19 Bob Moore      2008-12-31  252  
50df4d8b0f6e19 Bob Moore      2008-12-31  253  /*
50df4d8b0f6e19 Bob Moore      2008-12-31  254   * Common parameters used for debug output functions:
50df4d8b0f6e19 Bob Moore      2008-12-31  255   * line number, function name, module(file) name, component ID
50df4d8b0f6e19 Bob Moore      2008-12-31  256   */
ad5a06f2969763 Bob Moore      2012-12-31  257  #define ACPI_DEBUG_PARAMETERS \
ad5a06f2969763 Bob Moore      2012-12-31 @258  	__LINE__, ACPI_GET_FUNCTION_NAME, _acpi_module_name, _COMPONENT
50df4d8b0f6e19 Bob Moore      2008-12-31  259  
e81a52b8b642aa Bob Moore      2012-12-31  260  /* Check if debug output is currently dynamically enabled */
e81a52b8b642aa Bob Moore      2012-12-31  261  
e81a52b8b642aa Bob Moore      2012-12-31  262  #define ACPI_IS_DEBUG_ENABLED(level, component) \
e81a52b8b642aa Bob Moore      2012-12-31  263  	((level & acpi_dbg_level) && (component & acpi_dbg_layer))
e81a52b8b642aa Bob Moore      2012-12-31  264  
50df4d8b0f6e19 Bob Moore      2008-12-31  265  /*
50df4d8b0f6e19 Bob Moore      2008-12-31  266   * Master debug print macros
50df4d8b0f6e19 Bob Moore      2008-12-31  267   * Print message if and only if:
50df4d8b0f6e19 Bob Moore      2008-12-31  268   *    1) Debug print for the current component is enabled
50df4d8b0f6e19 Bob Moore      2008-12-31  269   *    2) Debug error level or trace level for the print statement is enabled
ad5a06f2969763 Bob Moore      2012-12-31  270   *
ad5a06f2969763 Bob Moore      2012-12-31  271   * November 2012: Moved the runtime check for whether to actually emit the
ad5a06f2969763 Bob Moore      2012-12-31  272   * debug message outside of the print function itself. This improves overall
ad5a06f2969763 Bob Moore      2012-12-31  273   * performance at a relatively small code cost. Implementation involves the
ad5a06f2969763 Bob Moore      2012-12-31  274   * use of variadic macros supported by C99.
6e1888fdcaad17 Bob Moore      2013-01-08  275   *
6e1888fdcaad17 Bob Moore      2013-01-08  276   * Note: the ACPI_DO_WHILE0 macro is used to prevent some compilers from
6e1888fdcaad17 Bob Moore      2013-01-08  277   * complaining about these constructs. On other compilers the do...while
6e1888fdcaad17 Bob Moore      2013-01-08  278   * adds some extra code, so this feature is optional.
50df4d8b0f6e19 Bob Moore      2008-12-31  279   */
6e1888fdcaad17 Bob Moore      2013-01-08  280  #ifdef ACPI_USE_DO_WHILE_0
6e1888fdcaad17 Bob Moore      2013-01-08  281  #define ACPI_DO_WHILE0(a)               do a while(0)
6e1888fdcaad17 Bob Moore      2013-01-08  282  #else
6e1888fdcaad17 Bob Moore      2013-01-08  283  #define ACPI_DO_WHILE0(a)               a
6e1888fdcaad17 Bob Moore      2013-01-08  284  #endif
ad5a06f2969763 Bob Moore      2012-12-31  285  
ad5a06f2969763 Bob Moore      2012-12-31  286  /* DEBUG_PRINT functions */
ad5a06f2969763 Bob Moore      2012-12-31  287  
7b09d8fdede65e Lv Zheng       2015-07-01  288  #ifndef COMPILER_VA_MACRO
7b09d8fdede65e Lv Zheng       2015-07-01  289  
7b09d8fdede65e Lv Zheng       2015-07-01  290  #define ACPI_DEBUG_PRINT(plist)         acpi_debug_print plist
7b09d8fdede65e Lv Zheng       2015-07-01  291  #define ACPI_DEBUG_PRINT_RAW(plist)     acpi_debug_print_raw plist
7b09d8fdede65e Lv Zheng       2015-07-01  292  
7b09d8fdede65e Lv Zheng       2015-07-01  293  #else
ad5a06f2969763 Bob Moore      2012-12-31  294  
ad5a06f2969763 Bob Moore      2012-12-31  295  /* Helper macros for DEBUG_PRINT */
ad5a06f2969763 Bob Moore      2012-12-31  296  
6e1888fdcaad17 Bob Moore      2013-01-08  297  #define ACPI_DO_DEBUG_PRINT(function, level, line, filename, modulename, component, ...) \
6e1888fdcaad17 Bob Moore      2013-01-08  298  	ACPI_DO_WHILE0 ({ \
ad5a06f2969763 Bob Moore      2012-12-31  299  		if (ACPI_IS_DEBUG_ENABLED (level, component)) \
ad5a06f2969763 Bob Moore      2012-12-31  300  		{ \
ad5a06f2969763 Bob Moore      2012-12-31  301  			function (level, line, filename, modulename, component, __VA_ARGS__); \
6e1888fdcaad17 Bob Moore      2013-01-08  302  		} \
6e1888fdcaad17 Bob Moore      2013-01-08  303  	})
ad5a06f2969763 Bob Moore      2012-12-31  304  
ad5a06f2969763 Bob Moore      2012-12-31  305  #define ACPI_ACTUAL_DEBUG(level, line, filename, modulename, component, ...) \
6e1888fdcaad17 Bob Moore      2013-01-08  306  	ACPI_DO_DEBUG_PRINT (acpi_debug_print, level, line, \
6e1888fdcaad17 Bob Moore      2013-01-08  307  		filename, modulename, component, __VA_ARGS__)
ad5a06f2969763 Bob Moore      2012-12-31  308  
ad5a06f2969763 Bob Moore      2012-12-31  309  #define ACPI_ACTUAL_DEBUG_RAW(level, line, filename, modulename, component, ...) \
6e1888fdcaad17 Bob Moore      2013-01-08  310  	ACPI_DO_DEBUG_PRINT (acpi_debug_print_raw, level, line, \
6e1888fdcaad17 Bob Moore      2013-01-08  311  		filename, modulename, component, __VA_ARGS__)
50df4d8b0f6e19 Bob Moore      2008-12-31  312  
7b09d8fdede65e Lv Zheng       2015-07-01  313  #define ACPI_DEBUG_PRINT(plist)         ACPI_ACTUAL_DEBUG plist
7b09d8fdede65e Lv Zheng       2015-07-01  314  #define ACPI_DEBUG_PRINT_RAW(plist)     ACPI_ACTUAL_DEBUG_RAW plist
7b09d8fdede65e Lv Zheng       2015-07-01  315  
7b09d8fdede65e Lv Zheng       2015-07-01  316  #endif
7b09d8fdede65e Lv Zheng       2015-07-01  317  
0377b5acba2f25 Bob Moore      2012-12-31  318  /*
0377b5acba2f25 Bob Moore      2012-12-31  319   * Function entry tracing
0377b5acba2f25 Bob Moore      2012-12-31  320   *
0377b5acba2f25 Bob Moore      2012-12-31  321   * The name of the function is emitted as a local variable that is
0377b5acba2f25 Bob Moore      2012-12-31  322   * intended to be used by both the entry trace and the exit trace.
0377b5acba2f25 Bob Moore      2012-12-31  323   */
0377b5acba2f25 Bob Moore      2012-12-31  324  
0377b5acba2f25 Bob Moore      2012-12-31  325  /* Helper macro */
0377b5acba2f25 Bob Moore      2012-12-31  326  
fd1af7126fb626 Bob Moore      2013-03-08  327  #define ACPI_TRACE_ENTRY(name, function, type, param) \
0377b5acba2f25 Bob Moore      2012-12-31  328  	ACPI_FUNCTION_NAME (name) \
fd1af7126fb626 Bob Moore      2013-03-08  329  	function (ACPI_DEBUG_PARAMETERS, (type) (param))
0377b5acba2f25 Bob Moore      2012-12-31  330  
0377b5acba2f25 Bob Moore      2012-12-31  331  /* The actual entry trace macros */
0377b5acba2f25 Bob Moore      2012-12-31  332  
0377b5acba2f25 Bob Moore      2012-12-31  333  #define ACPI_FUNCTION_TRACE(name) \
0377b5acba2f25 Bob Moore      2012-12-31  334  	ACPI_FUNCTION_NAME(name) \
0377b5acba2f25 Bob Moore      2012-12-31  335  	acpi_ut_trace (ACPI_DEBUG_PARAMETERS)
0377b5acba2f25 Bob Moore      2012-12-31  336  
0377b5acba2f25 Bob Moore      2012-12-31  337  #define ACPI_FUNCTION_TRACE_PTR(name, pointer) \
fd1af7126fb626 Bob Moore      2013-03-08  338  	ACPI_TRACE_ENTRY (name, acpi_ut_trace_ptr, void *, pointer)
0377b5acba2f25 Bob Moore      2012-12-31  339  
0377b5acba2f25 Bob Moore      2012-12-31  340  #define ACPI_FUNCTION_TRACE_U32(name, value) \
fd1af7126fb626 Bob Moore      2013-03-08  341  	ACPI_TRACE_ENTRY (name, acpi_ut_trace_u32, u32, value)
0377b5acba2f25 Bob Moore      2012-12-31  342  
0377b5acba2f25 Bob Moore      2012-12-31  343  #define ACPI_FUNCTION_TRACE_STR(name, string) \
4857a94de17a3c Jung-uk Kim    2016-08-04  344  	ACPI_TRACE_ENTRY (name, acpi_ut_trace_str, const char *, string)
0377b5acba2f25 Bob Moore      2012-12-31  345  
0377b5acba2f25 Bob Moore      2012-12-31  346  #define ACPI_FUNCTION_ENTRY() \
0377b5acba2f25 Bob Moore      2012-12-31  347  	acpi_ut_track_stack_ptr()
0377b5acba2f25 Bob Moore      2012-12-31  348  
0377b5acba2f25 Bob Moore      2012-12-31  349  /*
0377b5acba2f25 Bob Moore      2012-12-31  350   * Function exit tracing
0377b5acba2f25 Bob Moore      2012-12-31  351   *
0377b5acba2f25 Bob Moore      2012-12-31  352   * These macros include a return statement. This is usually considered
0377b5acba2f25 Bob Moore      2012-12-31  353   * bad form, but having a separate exit macro before the actual return
0377b5acba2f25 Bob Moore      2012-12-31  354   * is very ugly and difficult to maintain.
0377b5acba2f25 Bob Moore      2012-12-31  355   *
0377b5acba2f25 Bob Moore      2012-12-31  356   * One of the FUNCTION_TRACE macros above must be used in conjunction
0377b5acba2f25 Bob Moore      2012-12-31  357   * with these macros so that "_AcpiFunctionName" is defined.
fd1af7126fb626 Bob Moore      2013-03-08  358   *
fd1af7126fb626 Bob Moore      2013-03-08  359   * There are two versions of most of the return macros. The default version is
fd1af7126fb626 Bob Moore      2013-03-08  360   * safer, since it avoids side-effects by guaranteeing that the argument will
fd1af7126fb626 Bob Moore      2013-03-08  361   * not be evaluated twice.
fd1af7126fb626 Bob Moore      2013-03-08  362   *
fd1af7126fb626 Bob Moore      2013-03-08  363   * A less-safe version of the macros is provided for optional use if the
fd1af7126fb626 Bob Moore      2013-03-08  364   * compiler uses excessive CPU stack (for example, this may happen in the
e527db8f39d4c7 Colin Ian King 2021-04-06  365   * debug case if code optimization is disabled.)
0377b5acba2f25 Bob Moore      2012-12-31  366   */
0377b5acba2f25 Bob Moore      2012-12-31  367  
0377b5acba2f25 Bob Moore      2012-12-31  368  /* Exit trace helper macro */
0377b5acba2f25 Bob Moore      2012-12-31  369  
fd1af7126fb626 Bob Moore      2013-03-08  370  #ifndef ACPI_SIMPLE_RETURN_MACROS
fd1af7126fb626 Bob Moore      2013-03-08  371  
fd1af7126fb626 Bob Moore      2013-03-08  372  #define ACPI_TRACE_EXIT(function, type, param) \
fd1af7126fb626 Bob Moore      2013-03-08  373  	ACPI_DO_WHILE0 ({ \
fd1af7126fb626 Bob Moore      2013-03-08  374  		register type _param = (type) (param); \
fd1af7126fb626 Bob Moore      2013-03-08  375  		function (ACPI_DEBUG_PARAMETERS, _param); \
fd1af7126fb626 Bob Moore      2013-03-08  376  		return (_param); \
fd1af7126fb626 Bob Moore      2013-03-08  377  	})
fd1af7126fb626 Bob Moore      2013-03-08  378  
fd1af7126fb626 Bob Moore      2013-03-08  379  #else				/* Use original less-safe macros */
fd1af7126fb626 Bob Moore      2013-03-08  380  
fd1af7126fb626 Bob Moore      2013-03-08  381  #define ACPI_TRACE_EXIT(function, type, param) \
0377b5acba2f25 Bob Moore      2012-12-31  382  	ACPI_DO_WHILE0 ({ \
fd1af7126fb626 Bob Moore      2013-03-08  383  		function (ACPI_DEBUG_PARAMETERS, (type) (param)); \
fd1af7126fb626 Bob Moore      2013-03-08  384  		return (param); \
0377b5acba2f25 Bob Moore      2012-12-31  385  	})
0377b5acba2f25 Bob Moore      2012-12-31  386  
fd1af7126fb626 Bob Moore      2013-03-08  387  #endif				/* ACPI_SIMPLE_RETURN_MACROS */
fd1af7126fb626 Bob Moore      2013-03-08  388  
0377b5acba2f25 Bob Moore      2012-12-31  389  /* The actual exit macros */
0377b5acba2f25 Bob Moore      2012-12-31  390  
0377b5acba2f25 Bob Moore      2012-12-31  391  #define return_VOID \
0377b5acba2f25 Bob Moore      2012-12-31  392  	ACPI_DO_WHILE0 ({ \
0377b5acba2f25 Bob Moore      2012-12-31  393  		acpi_ut_exit (ACPI_DEBUG_PARAMETERS); \
0377b5acba2f25 Bob Moore      2012-12-31  394  		return; \
0377b5acba2f25 Bob Moore      2012-12-31  395  	})
0377b5acba2f25 Bob Moore      2012-12-31  396  
0377b5acba2f25 Bob Moore      2012-12-31  397  #define return_ACPI_STATUS(status) \
fd1af7126fb626 Bob Moore      2013-03-08 @398  	ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
0377b5acba2f25 Bob Moore      2012-12-31  399  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

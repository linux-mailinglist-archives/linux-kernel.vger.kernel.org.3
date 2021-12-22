Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F9947D902
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 22:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240964AbhLVVyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 16:54:06 -0500
Received: from mga03.intel.com ([134.134.136.65]:48819 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240496AbhLVVyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 16:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640210045; x=1671746045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Co7Xz/6eH1doJ6nwIWNwi00vuVQJJYA+gaSC7xA4+5c=;
  b=ZCFxcCnAcCrU9AZYLogLRJyW+o3oZq+gDXUYQQXZELX/jp4nbNqrUyvv
   18s3DyS/2MVw8I9wrTsG0CJEb7coaxCBGp5EEuBDQGBV8vkALF8BT3Ojx
   VyOBGAilQ3rnDcyYLtVTEEhv5sZZJCesshmpSWkHAuSoF2EUrlGc3E/Fm
   F2hN059JCDVpPr+rSgFeMSBa+Sx8IF5PGQi1hr49QHvL+sCnlW0E38GUw
   IqTlkbLjE5fwDziSul+Tz3jm5CdeBhzP5aiXdEt8fTxNjLRIItGyG83O2
   C4tmmmRZ3RvodrgPEWbFDWh6zqVf89TnVpyW23o0W+LVGZ8ilko2zjSZl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="240666551"
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="240666551"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 13:54:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="508632089"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 22 Dec 2021 13:54:02 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n09Yg-0000zY-AF; Wed, 22 Dec 2021 21:54:02 +0000
Date:   Thu, 23 Dec 2021 05:53:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     kbuild-all@lists.01.org, Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI: PCC: Implement OperationRegion handler for the PCC
 Type 3 subtype
Message-ID: <202112230517.xGNBVseT-lkp@intel.com>
References: <20211222190919.137550-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222190919.137550-1-sudeep.holla@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

I love your patch! Yet something to improve:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on linux/master linus/master v5.16-rc6 next-20211222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sudeep-Holla/ACPI-PCC-Implement-OperationRegion-handler-for-the-PCC-Type-3-subtype/20211223-030953
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: arm64-randconfig-r034-20211222 (https://download.01.org/0day-ci/archive/20211223/202112230517.xGNBVseT-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d47183476e4a00211d39cd175b92fe5c11fbb65a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sudeep-Holla/ACPI-PCC-Implement-OperationRegion-handler-for-the-PCC-Type-3-subtype/20211223-030953
        git checkout d47183476e4a00211d39cd175b92fe5c11fbb65a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/acpi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/acpi/pcc_opregion.c:22:30: error: field 'ctx' has incomplete type
      22 |         struct acpi_pcc_info ctx;
         |                              ^~~
   In file included from include/acpi/acpi.h:29,
                    from include/linux/acpi.h:22,
                    from drivers/acpi/pcc_opregion.c:10:
   drivers/acpi/pcc_opregion.c: In function 'acpi_pcc_opregion_setup':
>> include/acpi/acoutput.h:398:26: error: implicit declaration of function 'acpi_ut_status_exit'; did you mean 'acpi_irq_stats_init'? [-Werror=implicit-function-declaration]
     398 |         ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
         |                          ^~~~~~~~~~~~~~~~~~~
   include/acpi/acoutput.h:281:44: note: in definition of macro 'ACPI_DO_WHILE0'
     281 | #define ACPI_DO_WHILE0(a)               do a while(0)
         |                                            ^
   include/acpi/acoutput.h:398:9: note: in expansion of macro 'ACPI_TRACE_EXIT'
     398 |         ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
         |         ^~~~~~~~~~~~~~~
   drivers/acpi/pcc_opregion.c:44:17: note: in expansion of macro 'return_ACPI_STATUS'
      44 |                 return_ACPI_STATUS(AE_NO_MEMORY);
         |                 ^~~~~~~~~~~~~~~~~~
>> include/acpi/acoutput.h:258:43: error: '_acpi_module_name' undeclared (first use in this function); did you mean 'quota_module_name'?
     258 |         __LINE__, ACPI_GET_FUNCTION_NAME, _acpi_module_name, _COMPONENT
         |                                           ^~~~~~~~~~~~~~~~~
   include/acpi/acoutput.h:281:44: note: in definition of macro 'ACPI_DO_WHILE0'
     281 | #define ACPI_DO_WHILE0(a)               do a while(0)
         |                                            ^
   include/acpi/acoutput.h:375:27: note: in expansion of macro 'ACPI_DEBUG_PARAMETERS'
     375 |                 function (ACPI_DEBUG_PARAMETERS, _param); \
         |                           ^~~~~~~~~~~~~~~~~~~~~
   include/acpi/acoutput.h:398:9: note: in expansion of macro 'ACPI_TRACE_EXIT'
     398 |         ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
         |         ^~~~~~~~~~~~~~~
   drivers/acpi/pcc_opregion.c:44:17: note: in expansion of macro 'return_ACPI_STATUS'
      44 |                 return_ACPI_STATUS(AE_NO_MEMORY);
         |                 ^~~~~~~~~~~~~~~~~~
   include/acpi/acoutput.h:258:43: note: each undeclared identifier is reported only once for each function it appears in
     258 |         __LINE__, ACPI_GET_FUNCTION_NAME, _acpi_module_name, _COMPONENT
         |                                           ^~~~~~~~~~~~~~~~~
   include/acpi/acoutput.h:281:44: note: in definition of macro 'ACPI_DO_WHILE0'
     281 | #define ACPI_DO_WHILE0(a)               do a while(0)
         |                                            ^
   include/acpi/acoutput.h:375:27: note: in expansion of macro 'ACPI_DEBUG_PARAMETERS'
     375 |                 function (ACPI_DEBUG_PARAMETERS, _param); \
         |                           ^~~~~~~~~~~~~~~~~~~~~
   include/acpi/acoutput.h:398:9: note: in expansion of macro 'ACPI_TRACE_EXIT'
     398 |         ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
         |         ^~~~~~~~~~~~~~~
   drivers/acpi/pcc_opregion.c:44:17: note: in expansion of macro 'return_ACPI_STATUS'
      44 |                 return_ACPI_STATUS(AE_NO_MEMORY);
         |                 ^~~~~~~~~~~~~~~~~~
>> include/acpi/acoutput.h:258:62: error: '_COMPONENT' undeclared (first use in this function)
     258 |         __LINE__, ACPI_GET_FUNCTION_NAME, _acpi_module_name, _COMPONENT
         |                                                              ^~~~~~~~~~
   include/acpi/acoutput.h:281:44: note: in definition of macro 'ACPI_DO_WHILE0'
     281 | #define ACPI_DO_WHILE0(a)               do a while(0)
         |                                            ^
   include/acpi/acoutput.h:375:27: note: in expansion of macro 'ACPI_DEBUG_PARAMETERS'
     375 |                 function (ACPI_DEBUG_PARAMETERS, _param); \
         |                           ^~~~~~~~~~~~~~~~~~~~~
   include/acpi/acoutput.h:398:9: note: in expansion of macro 'ACPI_TRACE_EXIT'
     398 |         ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
         |         ^~~~~~~~~~~~~~~
   drivers/acpi/pcc_opregion.c:44:17: note: in expansion of macro 'return_ACPI_STATUS'
      44 |                 return_ACPI_STATUS(AE_NO_MEMORY);
         |                 ^~~~~~~~~~~~~~~~~~
>> drivers/acpi/pcc_opregion.c:48:31: error: invalid use of undefined type 'struct acpi_pcc_info'
      48 |         data->ctx.length = ctx->length;
         |                               ^~
   drivers/acpi/pcc_opregion.c:49:36: error: invalid use of undefined type 'struct acpi_pcc_info'
      49 |         data->ctx.subspace_id = ctx->subspace_id;
         |                                    ^~
   drivers/acpi/pcc_opregion.c:50:40: error: invalid use of undefined type 'struct acpi_pcc_info'
      50 |         data->ctx.internal_buffer = ctx->internal_buffer;
         |                                        ^~
   drivers/acpi/pcc_opregion.c:53:65: error: invalid use of undefined type 'struct acpi_pcc_info'
      53 |         data->pcc_chan = pcc_mbox_request_channel(&data->cl, ctx->subspace_id);
         |                                                                 ^~
   In file included from include/linux/kernel.h:20,
                    from drivers/acpi/pcc_opregion.c:9:
   drivers/acpi/pcc_opregion.c:56:27: error: invalid use of undefined type 'struct acpi_pcc_info'
      56 |                        ctx->subspace_id);
         |                           ^~
   include/linux/printk.h:422:33: note: in definition of macro 'printk_index_wrap'
     422 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:493:9: note: in expansion of macro 'printk'
     493 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   drivers/acpi/pcc_opregion.c:55:17: note: in expansion of macro 'pr_err'
      55 |                 pr_err("Failed to find PCC channel for subspace %d\n",
         |                 ^~~~~~
   drivers/acpi/pcc_opregion.c:65:27: error: invalid use of undefined type 'struct acpi_pcc_info'
      65 |                        ctx->subspace_id);
         |                           ^~
   include/linux/printk.h:422:33: note: in definition of macro 'printk_index_wrap'
     422 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:493:9: note: in expansion of macro 'printk'
     493 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   drivers/acpi/pcc_opregion.c:64:17: note: in expansion of macro 'pr_err'
      64 |                 pr_err("Failed to ioremap PCC comm region mem for %d\n",
         |                 ^~~~~~
   In file included from include/acpi/acpi.h:29,
                    from include/linux/acpi.h:22,
                    from drivers/acpi/pcc_opregion.c:10:
   drivers/acpi/pcc_opregion.c: In function 'acpi_pcc_opregion_space_handler':
>> include/acpi/acoutput.h:258:43: error: '_acpi_module_name' undeclared (first use in this function); did you mean 'quota_module_name'?
     258 |         __LINE__, ACPI_GET_FUNCTION_NAME, _acpi_module_name, _COMPONENT
         |                                           ^~~~~~~~~~~~~~~~~
   include/acpi/acoutput.h:281:44: note: in definition of macro 'ACPI_DO_WHILE0'
     281 | #define ACPI_DO_WHILE0(a)               do a while(0)
         |                                            ^
   include/acpi/acoutput.h:375:27: note: in expansion of macro 'ACPI_DEBUG_PARAMETERS'
     375 |                 function (ACPI_DEBUG_PARAMETERS, _param); \
         |                           ^~~~~~~~~~~~~~~~~~~~~
   include/acpi/acoutput.h:398:9: note: in expansion of macro 'ACPI_TRACE_EXIT'
     398 |         ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
         |         ^~~~~~~~~~~~~~~
   drivers/acpi/pcc_opregion.c:88:17: note: in expansion of macro 'return_ACPI_STATUS'
      88 |                 return_ACPI_STATUS(AE_ERROR);
         |                 ^~~~~~~~~~~~~~~~~~
>> include/acpi/acoutput.h:258:62: error: '_COMPONENT' undeclared (first use in this function)
     258 |         __LINE__, ACPI_GET_FUNCTION_NAME, _acpi_module_name, _COMPONENT
         |                                                              ^~~~~~~~~~
   include/acpi/acoutput.h:281:44: note: in definition of macro 'ACPI_DO_WHILE0'
     281 | #define ACPI_DO_WHILE0(a)               do a while(0)
         |                                            ^
   include/acpi/acoutput.h:375:27: note: in expansion of macro 'ACPI_DEBUG_PARAMETERS'
     375 |                 function (ACPI_DEBUG_PARAMETERS, _param); \
         |                           ^~~~~~~~~~~~~~~~~~~~~
   include/acpi/acoutput.h:398:9: note: in expansion of macro 'ACPI_TRACE_EXIT'
     398 |         ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
         |         ^~~~~~~~~~~~~~~
   drivers/acpi/pcc_opregion.c:88:17: note: in expansion of macro 'return_ACPI_STATUS'
      88 |                 return_ACPI_STATUS(AE_ERROR);
         |                 ^~~~~~~~~~~~~~~~~~
   drivers/acpi/pcc_opregion.c: At top level:
>> drivers/acpi/pcc_opregion.c:25:22: error: storage size of 'pcc_ctx' isn't known
      25 | struct acpi_pcc_info pcc_ctx;
         |                      ^~~~~~~
   cc1: some warnings being treated as errors


vim +/ctx +22 drivers/acpi/pcc_opregion.c

    16	
    17	struct pcc_data {
    18		struct pcc_mbox_chan *pcc_chan;
    19		void __iomem *pcc_comm_addr;
    20		struct completion done;
    21	        struct mbox_client cl;
  > 22		struct acpi_pcc_info ctx;
    23	};
    24	
  > 25	struct acpi_pcc_info pcc_ctx;
    26	
    27	static void pcc_rx_callback(struct mbox_client *cl, void *m)
    28	{
    29	        struct pcc_data *data = container_of(cl, struct pcc_data, cl);
    30	
    31		complete(&data->done);
    32	}
    33	
    34	static acpi_status
    35	acpi_pcc_opregion_setup(acpi_handle region_handle, u32 function,
    36				void *handler_context,  void **region_context)
    37	{
    38		struct pcc_data *data;
    39		struct acpi_pcc_info *ctx = handler_context;
    40		struct pcc_mbox_chan *pcc_chan;
    41	
    42		data = kzalloc(sizeof(*data), GFP_KERNEL);
    43		if (!data)
    44			return_ACPI_STATUS(AE_NO_MEMORY);
    45	
    46		data->cl.rx_callback = pcc_rx_callback;
    47		data->cl.knows_txdone = true;
  > 48		data->ctx.length = ctx->length;
    49		data->ctx.subspace_id = ctx->subspace_id;
    50		data->ctx.internal_buffer = ctx->internal_buffer;
    51	
    52		init_completion(&data->done);
    53		data->pcc_chan = pcc_mbox_request_channel(&data->cl, ctx->subspace_id);
    54		if (IS_ERR(data->pcc_chan)) {
    55			pr_err("Failed to find PCC channel for subspace %d\n",
    56			       ctx->subspace_id);
    57			return_ACPI_STATUS(AE_NOT_FOUND);
    58		}
    59	
    60		pcc_chan = data->pcc_chan;
    61		data->pcc_comm_addr = acpi_os_ioremap(pcc_chan->shmem_base_addr,
    62						      pcc_chan->shmem_size);
    63		if (!data->pcc_comm_addr) {
    64			pr_err("Failed to ioremap PCC comm region mem for %d\n",
    65			       ctx->subspace_id);
    66			return_ACPI_STATUS(AE_NO_MEMORY);
    67		}
    68	
    69		*region_context = data;
    70		return_ACPI_STATUS(AE_OK);
    71	}
    72	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

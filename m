Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60EA485AF0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244568AbiAEVrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:47:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:33563 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235053AbiAEVq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641419217; x=1672955217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fnqT6abPp7rgwKt8obY3+ASiykQkENaY+AkEtrPPEmw=;
  b=bKYWxg8YQJzRLbOjXd/AlXuTfYBk2OhShimoSuTfUrsd75qx3UXZtVPG
   J4nNWDLTQ5DPo9yuvFV9tpJVBdkKBRRKb+JamUFadR1MOjTQMsooyKSMC
   3DUn3SqV/R6Kznw/xYdMEzT4GImdG6buEphwmuNvc6iAFxcEUAAJBrMtG
   TfKqqSyuHvbgopR068c5nbxWmcr2yBah13FddmD9+0x2xCQfe7jyI3WIx
   8/r7qz0EV+Z9Btb+5qozPKWOUn1AancZYX4G7pcmsaaxHKX0N3nTC+cJD
   cq22YnTcYLWd3G6ToG1aB/HoaJz+ixQ0ZeC5MQIyn8mLYetWbLzFBTRfT
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="240086192"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="240086192"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 13:46:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="556689773"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 05 Jan 2022 13:46:55 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5E7S-000H46-Di; Wed, 05 Jan 2022 21:46:54 +0000
Date:   Thu, 6 Jan 2022 05:46:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] ACPI: PCC: Implement OperationRegion handler for the
 PCC Type 3 subtype
Message-ID: <202201060524.QF2PbOn8-lkp@intel.com>
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
[also build test ERROR on linux/master linus/master v5.16-rc8 next-20220105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sudeep-Holla/ACPI-PCC-Implement-OperationRegion-handler-for-the-PCC-Type-3-subtype/20220104-000003
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: x86_64-randconfig-a012-20220105 (https://download.01.org/0day-ci/archive/20220106/202201060524.QF2PbOn8-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d5b6e30ed3acad794dd0aec400e617daffc6cc3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/1dbcdc47eadc8c55659410fc03d067f3438a386a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sudeep-Holla/ACPI-PCC-Implement-OperationRegion-handler-for-the-PCC-Type-3-subtype/20220104-000003
        git checkout 1dbcdc47eadc8c55659410fc03d067f3438a386a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/acpi/acpi_pcc.c:53:3: error: implicit declaration of function 'acpi_ut_status_exit' [-Werror,-Wimplicit-function-declaration]
                   return_ACPI_STATUS(AE_NO_MEMORY);
                   ^
   include/acpi/acoutput.h:398:19: note: expanded from macro 'return_ACPI_STATUS'
           ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
                            ^
   drivers/acpi/acpi_pcc.c:53:3: note: did you mean 'acpi_irq_stats_init'?
   include/acpi/acoutput.h:398:19: note: expanded from macro 'return_ACPI_STATUS'
           ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
                            ^
   include/linux/acpi.h:320:6: note: 'acpi_irq_stats_init' declared here
   void acpi_irq_stats_init(void);
        ^
>> drivers/acpi/acpi_pcc.c:53:3: error: use of undeclared identifier '_acpi_module_name'
                   return_ACPI_STATUS(AE_NO_MEMORY);
                   ^
   include/acpi/acoutput.h:398:2: note: expanded from macro 'return_ACPI_STATUS'
           ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
           ^
   include/acpi/acoutput.h:375:13: note: expanded from macro 'ACPI_TRACE_EXIT'
                   function (ACPI_DEBUG_PARAMETERS, _param); \
                             ^
   include/acpi/acoutput.h:258:36: note: expanded from macro 'ACPI_DEBUG_PARAMETERS'
           __LINE__, ACPI_GET_FUNCTION_NAME, _acpi_module_name, _COMPONENT
                                             ^
>> drivers/acpi/acpi_pcc.c:53:3: error: use of undeclared identifier '_COMPONENT'
   include/acpi/acoutput.h:398:2: note: expanded from macro 'return_ACPI_STATUS'
           ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
           ^
   include/acpi/acoutput.h:375:13: note: expanded from macro 'ACPI_TRACE_EXIT'
                   function (ACPI_DEBUG_PARAMETERS, _param); \
                             ^
   include/acpi/acoutput.h:258:55: note: expanded from macro 'ACPI_DEBUG_PARAMETERS'
           __LINE__, ACPI_GET_FUNCTION_NAME, _acpi_module_name, _COMPONENT
                                                                ^
   drivers/acpi/acpi_pcc.c:66:3: error: implicit declaration of function 'acpi_ut_status_exit' [-Werror,-Wimplicit-function-declaration]
                   return_ACPI_STATUS(AE_NOT_FOUND);
                   ^
   include/acpi/acoutput.h:398:19: note: expanded from macro 'return_ACPI_STATUS'
           ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
                            ^
   drivers/acpi/acpi_pcc.c:66:3: error: use of undeclared identifier '_acpi_module_name'
   include/acpi/acoutput.h:398:2: note: expanded from macro 'return_ACPI_STATUS'
           ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
           ^
   include/acpi/acoutput.h:375:13: note: expanded from macro 'ACPI_TRACE_EXIT'
                   function (ACPI_DEBUG_PARAMETERS, _param); \
                             ^
   include/acpi/acoutput.h:258:36: note: expanded from macro 'ACPI_DEBUG_PARAMETERS'
           __LINE__, ACPI_GET_FUNCTION_NAME, _acpi_module_name, _COMPONENT
                                             ^
   drivers/acpi/acpi_pcc.c:66:3: error: use of undeclared identifier '_COMPONENT'
   include/acpi/acoutput.h:398:2: note: expanded from macro 'return_ACPI_STATUS'
           ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
           ^
   include/acpi/acoutput.h:375:13: note: expanded from macro 'ACPI_TRACE_EXIT'
                   function (ACPI_DEBUG_PARAMETERS, _param); \
                             ^
   include/acpi/acoutput.h:258:55: note: expanded from macro 'ACPI_DEBUG_PARAMETERS'
           __LINE__, ACPI_GET_FUNCTION_NAME, _acpi_module_name, _COMPONENT
                                                                ^
   drivers/acpi/acpi_pcc.c:75:3: error: implicit declaration of function 'acpi_ut_status_exit' [-Werror,-Wimplicit-function-declaration]
                   return_ACPI_STATUS(AE_NO_MEMORY);
                   ^
   include/acpi/acoutput.h:398:19: note: expanded from macro 'return_ACPI_STATUS'
           ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
                            ^
   drivers/acpi/acpi_pcc.c:75:3: error: use of undeclared identifier '_acpi_module_name'
   include/acpi/acoutput.h:398:2: note: expanded from macro 'return_ACPI_STATUS'
           ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
           ^
   include/acpi/acoutput.h:375:13: note: expanded from macro 'ACPI_TRACE_EXIT'
                   function (ACPI_DEBUG_PARAMETERS, _param); \
                             ^
   include/acpi/acoutput.h:258:36: note: expanded from macro 'ACPI_DEBUG_PARAMETERS'
           __LINE__, ACPI_GET_FUNCTION_NAME, _acpi_module_name, _COMPONENT
                                             ^
   drivers/acpi/acpi_pcc.c:75:3: error: use of undeclared identifier '_COMPONENT'
   include/acpi/acoutput.h:398:2: note: expanded from macro 'return_ACPI_STATUS'
           ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
           ^
   include/acpi/acoutput.h:375:13: note: expanded from macro 'ACPI_TRACE_EXIT'
                   function (ACPI_DEBUG_PARAMETERS, _param); \
                             ^
   include/acpi/acoutput.h:258:55: note: expanded from macro 'ACPI_DEBUG_PARAMETERS'
           __LINE__, ACPI_GET_FUNCTION_NAME, _acpi_module_name, _COMPONENT
                                                                ^
   drivers/acpi/acpi_pcc.c:79:2: error: implicit declaration of function 'acpi_ut_status_exit' [-Werror,-Wimplicit-function-declaration]
           return_ACPI_STATUS(AE_OK);
           ^
   include/acpi/acoutput.h:398:19: note: expanded from macro 'return_ACPI_STATUS'
           ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
                            ^
   drivers/acpi/acpi_pcc.c:79:2: error: use of undeclared identifier '_acpi_module_name'
   include/acpi/acoutput.h:398:2: note: expanded from macro 'return_ACPI_STATUS'
           ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
           ^
   include/acpi/acoutput.h:375:13: note: expanded from macro 'ACPI_TRACE_EXIT'
                   function (ACPI_DEBUG_PARAMETERS, _param); \
                             ^
   include/acpi/acoutput.h:258:36: note: expanded from macro 'ACPI_DEBUG_PARAMETERS'
           __LINE__, ACPI_GET_FUNCTION_NAME, _acpi_module_name, _COMPONENT
                                             ^
   drivers/acpi/acpi_pcc.c:79:2: error: use of undeclared identifier '_COMPONENT'
   include/acpi/acoutput.h:398:2: note: expanded from macro 'return_ACPI_STATUS'
           ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
           ^
   include/acpi/acoutput.h:375:13: note: expanded from macro 'ACPI_TRACE_EXIT'
                   function (ACPI_DEBUG_PARAMETERS, _param); \
                             ^
   include/acpi/acoutput.h:258:55: note: expanded from macro 'ACPI_DEBUG_PARAMETERS'
           __LINE__, ACPI_GET_FUNCTION_NAME, _acpi_module_name, _COMPONENT
                                                                ^
   drivers/acpi/acpi_pcc.c:97:3: error: implicit declaration of function 'acpi_ut_status_exit' [-Werror,-Wimplicit-function-declaration]
                   return_ACPI_STATUS(AE_ERROR);
                   ^
   include/acpi/acoutput.h:398:19: note: expanded from macro 'return_ACPI_STATUS'
           ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
                            ^
   drivers/acpi/acpi_pcc.c:97:3: error: use of undeclared identifier '_acpi_module_name'
   include/acpi/acoutput.h:398:2: note: expanded from macro 'return_ACPI_STATUS'
           ACPI_TRACE_EXIT (acpi_ut_status_exit, acpi_status, status)
           ^
   include/acpi/acoutput.h:375:13: note: expanded from macro 'ACPI_TRACE_EXIT'
                   function (ACPI_DEBUG_PARAMETERS, _param); \
                             ^


vim +/acpi_ut_status_exit +53 drivers/acpi/acpi_pcc.c

    42	
    43	static acpi_status
    44	acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
    45				     void *handler_context,  void **region_context)
    46	{
    47		struct pcc_data *data;
    48		struct acpi_pcc_info *ctx = handler_context;
    49		struct pcc_mbox_chan *pcc_chan;
    50	
    51		data = kzalloc(sizeof(*data), GFP_KERNEL);
    52		if (!data)
  > 53			return_ACPI_STATUS(AE_NO_MEMORY);
    54	
    55		data->cl.rx_callback = pcc_rx_callback;
    56		data->cl.knows_txdone = true;
    57		data->ctx.length = ctx->length;
    58		data->ctx.subspace_id = ctx->subspace_id;
    59		data->ctx.internal_buffer = ctx->internal_buffer;
    60	
    61		init_completion(&data->done);
    62		data->pcc_chan = pcc_mbox_request_channel(&data->cl, ctx->subspace_id);
    63		if (IS_ERR(data->pcc_chan)) {
    64			pr_err("Failed to find PCC channel for subspace %d\n",
    65			       ctx->subspace_id);
    66			return_ACPI_STATUS(AE_NOT_FOUND);
    67		}
    68	
    69		pcc_chan = data->pcc_chan;
    70		data->pcc_comm_addr = acpi_os_ioremap(pcc_chan->shmem_base_addr,
    71						      pcc_chan->shmem_size);
    72		if (!data->pcc_comm_addr) {
    73			pr_err("Failed to ioremap PCC comm region mem for %d\n",
    74			       ctx->subspace_id);
    75			return_ACPI_STATUS(AE_NO_MEMORY);
    76		}
    77	
    78		*region_context = data;
    79		return_ACPI_STATUS(AE_OK);
    80	}
    81	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

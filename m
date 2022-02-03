Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F1D4A7ED2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 06:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiBCFCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 00:02:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:9339 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230182AbiBCFCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 00:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643864568; x=1675400568;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GQzsSLSYfFEem78L0rEnjN7EfrEKbdPPRY+ncM591mg=;
  b=SCqVXlaXRjiculqoXd+nkf1jw/G6HVtIbtDm6lJ9h0AzBWDFn7GHZB14
   Uoy4DGjxG9YE8HJsAU8VpbBcbox4w+KFzL8tFKtT7IHXHP/IP4VIosJzb
   AFaZ/c/7QmNU9D/KhSZYwduSjPElZFY8d9ohUOH4s4w3fmy71xY3hw2tS
   TtWyoJjkPayxfww6u92c8wLcAlQiV7bwHjFsVbVi3zodIOdUK7Muve9Bu
   DfJtuZ8LsM7Tp4aZXsVRS17wNaRvh9zm6JsTThw/88Ota4AvkrwTpXmXP
   aAA4+/hmNuT/V9zjGI/jt3x1u6yyv1Htn0NrtbrqsT1BRcBUoMEhFOHML
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="228729926"
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="228729926"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 21:02:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="676668186"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 Feb 2022 21:02:46 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFUGc-000Vbo-9p; Thu, 03 Feb 2022 05:02:46 +0000
Date:   Thu, 3 Feb 2022 13:02:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manisha Chinthapally <manisha.chinthapally@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mchinth:sep_socwatch_linux_5_16 1/1]
 drivers/platform/x86/sepdk/sep/ipt.c:325:5: warning: cast from pointer to
 integer of different size
Message-ID: <202202031233.Btxr10ZR-lkp@intel.com>
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
config: i386-randconfig-a003-20220131 (https://download.01.org/0day-ci/archive/20220203/202202031233.Btxr10ZR-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/mchinth/linux/commit/4cbfca15a262729ae8557758b49226fe4769f582
        git remote add mchinth https://github.com/mchinth/linux
        git fetch --no-tags mchinth sep_socwatch_linux_5_16
        git checkout 4cbfca15a262729ae8557758b49226fe4769f582
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/platform/x86/sepdk/sep/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/platform/x86/sepdk/inc/master.h:43,
                    from drivers/platform/x86/sepdk/sep/ipt.c:25:
   drivers/platform/x86/sepdk/sep/ipt.c: In function 'ipt_Allocate_Buffers':
>> drivers/platform/x86/sepdk/sep/ipt.c:325:5: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     325 |     (U64)(ipt_node_on_cpu(i).outbuf_virt_address) +
         |     ^
   drivers/platform/x86/sepdk/inc/linuxos.h:66:50: note: in definition of macro 'VIRT_TO_PHYS_ADDR'
      66 | #define VIRT_TO_PHYS_ADDR(va) ((U64)virt_to_phys(va))
         |                                                  ^~
>> drivers/platform/x86/sepdk/sep/ipt.c:323:49: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     323 |     .outbuf_phys_address[j] = VIRT_TO_PHYS_ADDR((
         |                                                 ^
   drivers/platform/x86/sepdk/inc/linuxos.h:66:50: note: in definition of macro 'VIRT_TO_PHYS_ADDR'
      66 | #define VIRT_TO_PHYS_ADDR(va) ((U64)virt_to_phys(va))
         |                                                  ^~
   drivers/platform/x86/sepdk/sep/ipt.c: In function 'IPT_TOPA_Flush':
   drivers/platform/x86/sepdk/sep/ipt.c:465:6: warning: variable 'data_size' set but not used [-Wunused-but-set-variable]
     465 |  U64 data_size = 0;
         |      ^~~~~~~~~


vim +325 drivers/platform/x86/sepdk/sep/ipt.c

   270	
   271	/*
   272	 * Initialize the IPT micro dispatch tables
   273	 */
   274	IPT_DISPATCH_NODE gen2_ipt = { .init = ipt_Initialize,
   275				       .fini = ipt_Finalize,
   276				       .enable = ipt_Enable,
   277				       .disable = ipt_Disable,
   278				       .flush = ipt_Flush };
   279	
   280	/* ------------------------------------------------------------------------- */
   281	/*!
   282	 * @fn          OS_STATUS ipt_Allocate_Buffers (VOID)
   283	 *
   284	 * @brief       Allocate memory and set up MSRs in preparation for IPT
   285	 *
   286	 * @param       NONE
   287	 *
   288	 * @return      OS_STATUS status
   289	 *
   290	 */
   291	static OS_STATUS ipt_Allocate_Buffers(VOID)
   292	{
   293		S32 i;
   294		U32 j;
   295	
   296		SEP_DRV_LOG_TRACE_IN("");
   297	
   298		for (i = 0; i < GLOBAL_STATE_num_cpus(driver_state); i++) {
   299			ipt_node_on_cpu(i).topa_virt_address =
   300				CONTROL_Allocate_Memory_Aligned((size_t)IPT_BUF_SIZE,
   301								TRUE);
   302			if (!(ipt_node_on_cpu(i).topa_virt_address)) {
   303				SEP_DRV_LOG_ERROR_TRACE_OUT(
   304					"IPT buffer allocation failed!");
   305				return OS_NO_MEM;
   306			}
   307			ipt_node_on_cpu(i).topa_phys_address =
   308				VIRT_TO_PHYS_ADDR(ipt_node_on_cpu(i).topa_virt_address);
   309			ipt_node_on_cpu(i).outbuf_virt_address =
   310				CONTROL_Allocate_Memory_Aligned(
   311					(size_t)IPT_BUF_SIZE * ipt_buffer_num, TRUE);
   312			if (!(ipt_node_on_cpu(i).outbuf_virt_address)) {
   313				SEP_DRV_LOG_ERROR_TRACE_OUT(
   314					"IPT buffer allocation failed!");
   315				return OS_NO_MEM;
   316			}
   317			SEP_DRV_LOG_TRACE("cpu%d topa_va=%llx, topa_pa=%llx", i,
   318					  ipt_node_on_cpu(i).topa_virt_address,
   319					  ipt_node_on_cpu(i).topa_phys_address);
   320	
   321			for (j = 0; j < ipt_buffer_num; j++) {
   322				ipt_node_on_cpu(i)
 > 323					.outbuf_phys_address[j] = VIRT_TO_PHYS_ADDR((
   324					PVOID)(
 > 325					(U64)(ipt_node_on_cpu(i).outbuf_virt_address) +
   326					j * IPT_BUF_SIZE));
   327				((U64 *)ipt_node_on_cpu(i).topa_virt_address)[j] =
   328					ipt_node_on_cpu(i).outbuf_phys_address[j];
   329				SEP_DRV_LOG_TRACE(
   330					"cpu%d buffer%d outbuf_pa=%llx", i, j,
   331					ipt_node_on_cpu(i).outbuf_phys_address[j]);
   332			}
   333		}
   334	
   335		SEP_DRV_LOG_TRACE_OUT("");
   336		return OS_SUCCESS;
   337	}
   338	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

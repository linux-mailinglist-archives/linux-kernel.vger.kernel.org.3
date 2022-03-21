Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEC04E2253
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345347AbiCUIk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345232AbiCUIkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:40:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723002D1DC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647851964; x=1679387964;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zBkNcIaE7vRKqifh5x4wdiIAiDTn35u2wVhdHiRTcVk=;
  b=AbK5hV6Za1CpCwVrQxmtjih7I9V1ZJAxrpgB+yL9K9h2O5Egi53PHYh6
   wk8JGkTzIz3n4oNYG9Of6OK5UBiWFXxKYhzGX1Vu6sKdK8u4kxCwKw8lx
   BJd9L6Ddqhl4IHyhfBUupOB+s6ddqhF8umhtHGNDfrdyXkn/vfGkLoIa9
   27b+UPWe4E26Yy+StI21yduQ02VxdmKUoNZtbHobcL3y1xSRnKUkQ0bP9
   Hn0e5vcYDg8qDQgOlY7nIKTw+rnmNv+GWa653ZbILnbJMLksM6q1QrnNo
   BQpsV1bVlwHYe6tfhPodrAfgCBv+vE+5BwRCGck91Z/GjnBa67KJN4t6F
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="237443986"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="237443986"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 01:39:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="559773185"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 21 Mar 2022 01:39:22 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWDZR-000Hem-PU; Mon, 21 Mar 2022 08:39:21 +0000
Date:   Mon, 21 Mar 2022 16:39:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:efi-psci 2/2] drivers/firmware/psci/psci.c:158:9: error:
 implicit declaration of function 'efi_set_pgd'
Message-ID: <202203211626.cYFXbogy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git efi-psci
head:   4b8d4b95fbd43459a4b0ae3f9020a912f7621884
commit: 4b8d4b95fbd43459a4b0ae3f9020a912f7621884 [2/2] efi: arm: implement PSCI method backed by EFI runtime code
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220321/202203211626.cYFXbogy-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=4b8d4b95fbd43459a4b0ae3f9020a912f7621884
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb efi-psci
        git checkout 4b8d4b95fbd43459a4b0ae3f9020a912f7621884
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/firmware/psci/psci.c: In function '__invoke_psci_fn_efi':
>> drivers/firmware/psci/psci.c:158:9: error: implicit declaration of function 'efi_set_pgd' [-Werror=implicit-function-declaration]
     158 |         efi_set_pgd(&efi_mm);
         |         ^~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/efi_set_pgd +158 drivers/firmware/psci/psci.c

   131	
   132	static unsigned long __invoke_psci_fn_efi(unsigned long function_id,
   133				unsigned long arg0, unsigned long arg1,
   134				unsigned long arg2)
   135	{
   136		unsigned long flags, ret;
   137	
   138		switch (function_id) {
   139		case PSCI_0_2_FN_PSCI_VERSION:
   140			return PSCI_VERSION(0, 2);
   141		case PSCI_0_2_FN_MIGRATE_INFO_TYPE:
   142			return PSCI_0_2_TOS_MP;
   143		case PSCI_0_2_FN_CPU_SUSPEND:
   144		case PSCI_0_2_FN_CPU_OFF:
   145		case PSCI_0_2_FN_CPU_ON:
   146		case PSCI_0_2_FN_AFFINITY_INFO:
   147		case PSCI_0_2_FN64_CPU_SUSPEND:
   148		case PSCI_0_2_FN64_CPU_ON:
   149		case PSCI_0_2_FN64_AFFINITY_INFO:
   150			if (WARN_ON_ONCE(!efi_psci.psci_handler ||
   151					 !efi_enabled(EFI_RUNTIME_SERVICES)))
   152		default:
   153				return PSCI_RET_NOT_SUPPORTED;
   154			break;
   155		}
   156	
   157		raw_local_irq_save(flags);
 > 158		efi_set_pgd(&efi_mm);
   159	
   160		ret = efi_psci.psci_handler(function_id, arg0, arg1, arg2);
   161	
   162		efi_set_pgd(current->active_mm);
   163		raw_local_irq_restore(flags);
   164	
   165		return ret;
   166	}
   167	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

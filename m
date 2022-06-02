Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C45C53C02A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbiFBVC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbiFBVCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:02:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2221CB21
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 14:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654203772; x=1685739772;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0UzVWwaOi/8bfFUzsc83WA6PHSfLMI2rHT/Y5hwvIF0=;
  b=KxlxS9dCH/LwjUU1dOffJ7zRMJB+vYzqakzMigkVKG9vuZwLTBN8n2YL
   6aicfqKsREnycyvekJcbkQ2aoTIK33I32OWn2azZAv3x3uBYQs6Bi4Vgm
   pGJwzf5LI9PnVVFzMsCkn0q9gUx8IVMPyjsuMe6SY9488vW0fsvbR6Uv+
   RZhVLP5BG0SnYRCnlvMN5IR4F/Exszu0U/MM0miHPwgetZpn+sw0+I+gR
   ZlXZP3OrWjnk2qZXHjUK+jHEqoKhTUAfM/jcGa4XGUOBQK9g/ZDFQYcbM
   tRwdLqzVIVea7yN/bSPCZJMbtMbVEIqRpHiXb9lXoCN4umRx6OlISYzOr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="275814813"
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="275814813"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 14:02:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="612991715"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 02 Jun 2022 14:02:50 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwrxx-0005RP-SR;
        Thu, 02 Jun 2022 21:02:49 +0000
Date:   Fri, 3 Jun 2022 05:02:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_lc_dev 4/5] ld.lld: error: undefined
 symbol: auxiliary_device_init
Message-ID: <202206030535.Sbiik5tQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_lc_dev
head:   ef34c1c33c0ae43a9ad3c0ed3708eb1880972de0
commit: 2d0852c5fa89a48c6fa1f860600b5e24e2faab4b [4/5] mlxsw: core_linecards: Introduce per line card auxiliary device
config: x86_64-randconfig-a016 (https://download.01.org/0day-ci/archive/20220603/202206030535.Sbiik5tQ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b364c76683f8ef241025a9556300778c07b590c2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/2d0852c5fa89a48c6fa1f860600b5e24e2faab4b
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_lc_dev
        git checkout 2d0852c5fa89a48c6fa1f860600b5e24e2faab4b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   vmlinux.o: warning: objtool: fixup_bad_iret+0x1e: call to memset() leaves .noinstr.text section
   vmlinux.o: warning: objtool: in_entry_stack+0x9: call to __this_cpu_preempt_check() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_nmi+0x8: call to sev_es_nmi_complete() leaves .noinstr.text section
   vmlinux.o: warning: objtool: default_do_nmi+0x10: call to __this_cpu_preempt_check() leaves .noinstr.text section
   vmlinux.o: warning: objtool: kvm_read_and_reset_apf_flags+0x1: call to __this_cpu_preempt_check() leaves .noinstr.text section
   vmlinux.o: warning: objtool: lockdep_hardirqs_on+0xa6: call to __this_cpu_preempt_check() leaves .noinstr.text section
   vmlinux.o: warning: objtool: lockdep_hardirqs_off+0xa3: call to __this_cpu_preempt_check() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_enter+0x63: call to __this_cpu_preempt_check() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_exit+0x32: call to __this_cpu_preempt_check() leaves .noinstr.text section
>> ld.lld: error: undefined symbol: auxiliary_device_init
   >>> referenced by core_linecard_dev.c
   >>> net/ethernet/mellanox/mlxsw/core_linecard_dev.o:(mlxsw_linecard_dev_add) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: __auxiliary_device_add
   >>> referenced by core_linecard_dev.c
   >>> net/ethernet/mellanox/mlxsw/core_linecard_dev.o:(mlxsw_linecard_dev_add) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: __auxiliary_driver_register
   >>> referenced by core_linecard_dev.c
   >>> net/ethernet/mellanox/mlxsw/core_linecard_dev.o:(mlxsw_linecard_driver_register) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: auxiliary_driver_unregister
   >>> referenced by core_linecard_dev.c
   >>> net/ethernet/mellanox/mlxsw/core_linecard_dev.o:(mlxsw_linecard_driver_unregister) in archive drivers/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

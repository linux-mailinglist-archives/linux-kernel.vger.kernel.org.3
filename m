Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D754DD0E8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiCQWwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiCQWwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:52:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D791B2C4C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647557484; x=1679093484;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o6EcUI/nffbKAi/tVN1u/XWuc/zFkhXJLQjXqtiJbJc=;
  b=MIzpDxxQ2kduY+noKGPZAHCdGDP6FgIvI6v5zSm8fPxrWqyjIf0gx+d4
   QjIws8VSjZYCJL6x8uooMjCHoNLSgQlHV+X0bIruNBPehlk546+dveHra
   i1DXiEBaH2HJznj+smXrIrCeIQIt3b0tMx2UsI7T6VJykgei4H3D2dblO
   Fo3bRQMsjy/WkaPap9vWi72t7KYyix8YGwfwNP3fB+/uFsdqdweBFpFZG
   7b+S74VHYGwrfKrSm5JQdq60Qzw45NmDgCvY5Cc3z5z3xQPdoY5NrXtOj
   ozhWuam5dhA2GFNu8BTsgguR00haYGndUq06bJcvLBNQfMWYp4x/11FVo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257187731"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="257187731"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 15:51:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="647226771"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 17 Mar 2022 15:51:22 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUyxl-000EBL-Ct; Thu, 17 Mar 2022 22:51:21 +0000
Date:   Fri, 18 Mar 2022 06:51:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>
Subject: [luxis1999-iommufd:iommufd-v5.17-rc6 38/40] ld.lld: error: undefined
 symbol: interval_tree_iter_first
Message-ID: <202203180632.Yo8yADOY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc6
head:   5ab19f95878da0c393e4b8c3f5b0bb51efb9f99a
commit: a7d1827d76767fe3e5366ef50efd50ebea0ed089 [38/40] vfio: Add iommufd VFIO compat support to group_fd
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220318/202203180632.Yo8yADOY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/a7d1827d76767fe3e5366ef50efd50ebea0ed089
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc6
        git checkout a7d1827d76767fe3e5366ef50efd50ebea0ed089
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   vmlinux.o: warning: objtool: do_syscall_64()+0x18: call to static_key_count() leaves .noinstr.text section
   vmlinux.o: warning: objtool: do_int80_syscall_32()+0x25: call to static_key_count() leaves .noinstr.text section
   vmlinux.o: warning: objtool: __do_fast_syscall_32()+0x29: call to static_key_count() leaves .noinstr.text section
   vmlinux.o: warning: objtool: fixup_bad_iret()+0x21: call to memset() leaves .noinstr.text section
   vmlinux.o: warning: objtool: in_task_stack()+0xc: call to task_stack_page() leaves .noinstr.text section
   vmlinux.o: warning: objtool: in_entry_stack()+0x9: call to cpu_entry_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode()+0x2e: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode()+0x36: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare()+0x2e: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exit_to_user_mode()+0x26: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_exit_to_user_mode()+0xde: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode()+0x2e: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_exit_to_user_mode()+0x2d: call to __kcsan_check_access() leaves .noinstr.text section
>> ld.lld: error: undefined symbol: interval_tree_iter_first
   >>> referenced by io_pagetable.c:161 (drivers/iommu/iommufd/io_pagetable.c:161)
   >>> iommu/iommufd/io_pagetable.o:(iopt_map_pages) in archive drivers/built-in.a
   >>> referenced by io_pagetable.h:91 (drivers/iommu/iommufd/io_pagetable.h:91)
   >>> iommu/iommufd/io_pagetable.o:(iopt_map_pages) in archive drivers/built-in.a
   >>> referenced by io_pagetable.h:91 (drivers/iommu/iommufd/io_pagetable.h:91)
   >>> iommu/iommufd/io_pagetable.o:(iopt_find_exact_area) in archive drivers/built-in.a
   >>> referenced 14 more times
--
>> ld.lld: error: undefined symbol: interval_tree_span_iter_first
   >>> referenced by io_pagetable.c:89 (drivers/iommu/iommufd/io_pagetable.c:89)
   >>> iommu/iommufd/io_pagetable.o:(iopt_map_pages) in archive drivers/built-in.a
   >>> referenced by io_pagetable.c:97 (drivers/iommu/iommufd/io_pagetable.c:97)
   >>> iommu/iommufd/io_pagetable.o:(iopt_map_pages) in archive drivers/built-in.a
   >>> referenced by ioas.c:93 (drivers/iommu/iommufd/ioas.c:93)
   >>> iommu/iommufd/ioas.o:(iommufd_ioas_iova_ranges) in archive drivers/built-in.a
   >>> referenced 8 more times
--
>> ld.lld: error: undefined symbol: interval_tree_span_iter_next
   >>> referenced by io_pagetable.c:101 (drivers/iommu/iommufd/io_pagetable.c:101)
   >>> iommu/iommufd/io_pagetable.o:(iopt_map_pages) in archive drivers/built-in.a
   >>> referenced by io_pagetable.c:92 (drivers/iommu/iommufd/io_pagetable.c:92)
   >>> iommu/iommufd/io_pagetable.o:(iopt_map_pages) in archive drivers/built-in.a
   >>> referenced by ioas.c:96 (drivers/iommu/iommufd/ioas.c:96)
   >>> iommu/iommufd/ioas.o:(iommufd_ioas_iova_ranges) in archive drivers/built-in.a
   >>> referenced 8 more times
--
>> ld.lld: error: undefined symbol: interval_tree_insert
   >>> referenced by io_pagetable.c:179 (drivers/iommu/iommufd/io_pagetable.c:179)
   >>> iommu/iommufd/io_pagetable.o:(iopt_map_pages) in archive drivers/built-in.a
   >>> referenced by io_pagetable.c:528 (drivers/iommu/iommufd/io_pagetable.c:528)
   >>> iommu/iommufd/io_pagetable.o:(iopt_reserve_iova) in archive drivers/built-in.a
   >>> referenced by io_pagetable.c:678 (drivers/iommu/iommufd/io_pagetable.c:678)
   >>> iommu/iommufd/io_pagetable.o:(iopt_table_add_domain) in archive drivers/built-in.a
   >>> referenced 2 more times
--
>> ld.lld: error: undefined symbol: interval_tree_remove
   >>> referenced by io_pagetable.c:192 (drivers/iommu/iommufd/io_pagetable.c:192)
   >>> iommu/iommufd/io_pagetable.o:(iopt_abort_area) in archive drivers/built-in.a
   >>> referenced by io_pagetable.c:546 (drivers/iommu/iommufd/io_pagetable.c:546)
   >>> iommu/iommufd/io_pagetable.o:(iopt_remove_reserved_iova) in archive drivers/built-in.a
   >>> referenced by io_pagetable.c:697 (drivers/iommu/iommufd/io_pagetable.c:697)
   >>> iommu/iommufd/io_pagetable.o:(iopt_table_add_domain) in archive drivers/built-in.a
   >>> referenced 3 more times
--
>> ld.lld: error: undefined symbol: interval_tree_iter_next
   >>> referenced by io_pagetable.h:103 (drivers/iommu/iommufd/io_pagetable.h:103)
   >>> iommu/iommufd/io_pagetable.o:(iopt_access_pages) in archive drivers/built-in.a
   >>> referenced by io_pagetable.h:103 (drivers/iommu/iommufd/io_pagetable.h:103)
   >>> iommu/iommufd/io_pagetable.o:(iopt_unaccess_pages) in archive drivers/built-in.a
   >>> referenced by io_pagetable.c:543 (drivers/iommu/iommufd/io_pagetable.c:543)
   >>> iommu/iommufd/io_pagetable.o:(iopt_remove_reserved_iova) in archive drivers/built-in.a
   >>> referenced 6 more times

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMUFD
   Depends on IOMMU_SUPPORT
   Selected by
   - VFIO && MMU && (X86 || S390 || ARM || ARM64)

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

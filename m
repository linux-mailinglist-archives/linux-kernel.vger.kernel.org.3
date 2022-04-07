Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416F74F7616
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241131AbiDGGdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239287AbiDGGde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:33:34 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEC2972DB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 23:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649313094; x=1680849094;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YF/qhkPruKLjlOv9A4/gotWe1O62iB8RRrGaPFCBqQo=;
  b=X/M1X7KDIhEWF6CBXMKMp9q915BkVglO0zqvNZr44nd4TLvGXmBUDsSC
   SF/Ex2IyL512+53TOkpb4fQmrx+R3ItryYKFjZwg/cDJbfLFUNnxsjYdD
   f3OZseu5c+jNqNk7R3afTsrzJ6ASyrANui28IVF2M6fta1shHQC9/3LcD
   RfyyC6hIf2vXBUbPylsi49RnK36O7YMQ4u+vomklU1Z2qZ4KRh8jttlVT
   PZu0KD8YIaLYyQKtiDS2WI6f3hbeRh2vRYzS3yKZCAuq73Rc+Gcj/BY6Y
   D4XVyTdPh0nwm4k2NrVNE+qCsgf6V/qa+l7XsdHbignoFhQIeEdM7eZIU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="241173141"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="241173141"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 23:31:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="524797342"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 06 Apr 2022 23:31:31 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncLg2-00059L-No;
        Thu, 07 Apr 2022 06:31:30 +0000
Date:   Thu, 7 Apr 2022 14:31:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 9/10] arch/x86/kernel/process.c:1035:37: error:
 'mm_context_t' has no member named 'lam'
Message-ID: <202204071441.Xq1KTIgi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   73447e771c55e18598a6fbf6adee1002aee18ea0
commit: d4e785c333c5cfacdc663cb05ea375238393027e [9/10] x86/mm: Add userspace API to enable Linear Address Masking
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220407/202204071441.Xq1KTIgi-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?id=d4e785c333c5cfacdc663cb05ea375238393027e
        git remote add kas https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git
        git fetch --no-tags kas lam
        git checkout d4e785c333c5cfacdc663cb05ea375238393027e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kernel/process.c:896:13: warning: no previous prototype for 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
     896 | void __init arch_post_acpi_subsys_init(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/process.c: In function 'enable_lam':
>> arch/x86/kernel/process.c:1035:37: error: 'mm_context_t' has no member named 'lam'
    1035 |                 current->mm->context.lam = LAM_U48;
         |                                     ^
   arch/x86/kernel/process.c:1036:38: error: 'mm_context_t' has no member named 'lam'
    1036 |         else if (current->mm->context.lam == LAM_NONE)
         |                                      ^
   arch/x86/kernel/process.c:1037:37: error: 'mm_context_t' has no member named 'lam'
    1037 |                 current->mm->context.lam = LAM_U57;
         |                                     ^


vim +1035 arch/x86/kernel/process.c

  1003	
  1004	static long enable_lam(struct task_struct *task, unsigned long features)
  1005	{
  1006		features |= task->thread.features;
  1007	
  1008		/* LAM_U48 and LAM_U57 are mutually exclusive */
  1009		if ((features & X86_THREAD_LAM_U48) && (features & X86_THREAD_LAM_U57))
  1010			return -EINVAL;
  1011	
  1012		if (in_32bit_syscall())
  1013			return -EINVAL;
  1014	
  1015		if (!cpu_feature_enabled(X86_FEATURE_LAM))
  1016			return -ENXIO;
  1017	
  1018		if (mmap_write_lock_killable(task->mm))
  1019			return -EINTR;
  1020	
  1021		if ((features & X86_THREAD_LAM_U48) && !lam_u48_allowed()) {
  1022			mmap_write_unlock(task->mm);
  1023			return -EINVAL;
  1024		}
  1025	
  1026		/*
  1027		 * Record the most permissive (allowing the widest tags) LAM
  1028		 * mode to the mm context. It determinates if a mappings above
  1029		 * 47 bit is allowed for the process.
  1030		 *
  1031		 * The mode is also used by a kernel thread when it does work
  1032		 * on behalf of the process (like async I/O, io_uring, etc.)
  1033		 */
  1034		if (features & X86_THREAD_LAM_U48)
> 1035			current->mm->context.lam = LAM_U48;
  1036		else if (current->mm->context.lam == LAM_NONE)
  1037			current->mm->context.lam = LAM_U57;
  1038	
  1039		mmap_write_unlock(task->mm);
  1040		return 0;
  1041	}
  1042	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

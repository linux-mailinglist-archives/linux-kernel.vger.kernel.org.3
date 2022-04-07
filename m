Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984C24F7B8C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243745AbiDGJ1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243787AbiDGJ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:27:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD23DEAF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649323540; x=1680859540;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a0mAkM6G2uGimt8JpEAMQShE/fpLe+vQSXGLX4GQr2M=;
  b=T7upbxwfjpAiQ2lzSLwGeG5Ikn0daYTK0aLe+gqtreZPJampbEpAfkmV
   tXFLRBVv0aDplciZh3L6y5LYYYgPN285FfCXawewUU8WJU+TfZ2NsRx/j
   uBvxfi5EqjIMTWq2R5lanCgqFwYVHpPMqO1JBqM813LiOFOn0PJxcHTIm
   5KaB9jZs4RAaHKDBcxQlIitZlNtPfZCPpCa7m+eLjtWzci0QK842pJhYt
   FIirtHMGjlnEmxpte49YgeuZzHpNx3A6QUBEzX4WzKRaoP7xdS5kW0s2b
   58SorIe0NyDnTG/YG3OND+JWuOk6sHDFAmA8+T/8aQTFHAMWX9HCAH379
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="241205198"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="241205198"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 02:25:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="722889091"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 07 Apr 2022 02:25:38 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncOOX-0005HD-Dt;
        Thu, 07 Apr 2022 09:25:37 +0000
Date:   Thu, 7 Apr 2022 17:25:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [kas:lam 10/10] arch/x86/kernel/proc.c:35:17: error: use of
 undeclared identifier 'X86_THREAD_LAM_U48'
Message-ID: <202204071702.1AlCbCIC-lkp@intel.com>
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
commit: 73447e771c55e18598a6fbf6adee1002aee18ea0 [10/10] x86: Expose thread features status in /proc/$PID/arch_status
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220407/202204071702.1AlCbCIC-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b306233f78876a1d197ed6e1f05785505de7c63)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?id=73447e771c55e18598a6fbf6adee1002aee18ea0
        git remote add kas https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git
        git fetch --no-tags kas lam
        git checkout 73447e771c55e18598a6fbf6adee1002aee18ea0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/kernel/proc.c:35:17: error: use of undeclared identifier 'X86_THREAD_LAM_U48'
           if (features & X86_THREAD_LAM_U48)
                          ^
>> arch/x86/kernel/proc.c:37:17: error: use of undeclared identifier 'X86_THREAD_LAM_U57'
           if (features & X86_THREAD_LAM_U57)
                          ^
   2 errors generated.


vim +/X86_THREAD_LAM_U48 +35 arch/x86/kernel/proc.c

    32	
    33	static void dump_features(struct seq_file *m, unsigned long features)
    34	{
  > 35		if (features & X86_THREAD_LAM_U48)
    36			seq_puts(m, "lam_u48 ");
  > 37		if (features & X86_THREAD_LAM_U57)
    38			seq_puts(m, "lam_u57 ");
    39	}
    40	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9634F7A94
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbiDGI5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbiDGI5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:57:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C82167F86
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 01:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649321744; x=1680857744;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8oNth3LWFsKCpX8HwZT36uUknbe79ilbHXkiY4G2yCQ=;
  b=lwF04ZFoXyjKU/sUS97CkAp5RpVvJhqd1JXD3pmeuQpK9CLdHW82T+ye
   YLr7WO4eiULE9Uuuivx6sagVL+Fg3SzXU45/1eocnrLDQ7T+ieQV3VkLk
   ebWeNCxBRuPjPp1O2IfHkc7QqbgrHKe54/ZPgVa6SPu2G05i+VQ5p3DmU
   w7hSklHLwWvfF2tpw+WVJkNAsSQtxoZtmNo5SkKO3OchRT0UrtUIr5Bf+
   fNJxL+P+4bjRjNAP+S5Etryr6tctQJAa3DL6Fv4eNh0WXMF07DQVzBGDl
   lcq/NGuW+hqZiM5rgdH78JHmDKd6Zp3rpe3kgaaOwvGMGoKL5iMYWQ39U
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="261446219"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="261446219"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 01:55:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="549928167"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 07 Apr 2022 01:55:37 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncNvU-0005GN-N8;
        Thu, 07 Apr 2022 08:55:36 +0000
Date:   Thu, 7 Apr 2022 16:54:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 10/10] arch/x86/kernel/proc.c:35:24: error:
 'X86_THREAD_LAM_U48' undeclared; did you mean 'X86_CR3_LAM_U48'?
Message-ID: <202204071610.T6fPhCnP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   73447e771c55e18598a6fbf6adee1002aee18ea0
commit: 73447e771c55e18598a6fbf6adee1002aee18ea0 [10/10] x86: Expose thread features status in /proc/$PID/arch_status
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220407/202204071610.T6fPhCnP-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?id=73447e771c55e18598a6fbf6adee1002aee18ea0
        git remote add kas https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git
        git fetch --no-tags kas lam
        git checkout 73447e771c55e18598a6fbf6adee1002aee18ea0
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kernel/proc.c: In function 'dump_features':
>> arch/x86/kernel/proc.c:35:24: error: 'X86_THREAD_LAM_U48' undeclared (first use in this function); did you mean 'X86_CR3_LAM_U48'?
      35 |         if (features & X86_THREAD_LAM_U48)
         |                        ^~~~~~~~~~~~~~~~~~
         |                        X86_CR3_LAM_U48
   arch/x86/kernel/proc.c:35:24: note: each undeclared identifier is reported only once for each function it appears in
>> arch/x86/kernel/proc.c:37:24: error: 'X86_THREAD_LAM_U57' undeclared (first use in this function); did you mean 'X86_CR3_LAM_U57'?
      37 |         if (features & X86_THREAD_LAM_U57)
         |                        ^~~~~~~~~~~~~~~~~~
         |                        X86_CR3_LAM_U57


vim +35 arch/x86/kernel/proc.c

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

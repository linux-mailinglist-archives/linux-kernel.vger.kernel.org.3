Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75056475308
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 07:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbhLOGjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 01:39:53 -0500
Received: from mga12.intel.com ([192.55.52.136]:28883 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233763AbhLOGjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 01:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639550392; x=1671086392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LXaG3RNyDTFgVc8HPZRc/tEwHLLs1D0tpqJvvdD9cpc=;
  b=mNwPggS7m4ADrj8/XjscyFAu5XhMWuJ2batawrju2/CTvWIb0OY5pA6+
   u53KWrFLueLAvqMvAf9kPHWsh2TR9OkiOfDXpGdjNCr6dtzl+9u2g3fsn
   4pVZ1Euye/mrpagOAr7/Rmrj3jnW1xbNBe4na0BCllIz5xqmIkJIoILsj
   QO4jPsnQJV1f9uLYq47n0TmKuiuhtoSo61q+2XXNakgf3dyqT0zKBxRLi
   9eSqUpvsvXOnQQoCyRcnyk1mYLudaQDCzy33XtZ1a6W0KrGWJbrxy/IHg
   eNIXgbstYHZnaPMM6gmrMOhYZe/iuSA2A6QtxjRwF0uJjm/rUmJOCQHxv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="219176483"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="219176483"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 22:39:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="545476032"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 14 Dec 2021 22:39:48 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxNx5-0001OA-RK; Wed, 15 Dec 2021 06:39:47 +0000
Date:   Wed, 15 Dec 2021 14:39:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        hdegoede@redhat.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH V3 4/6] platform/x86: Add Intel Software Defined Silicon
 driver
Message-ID: <202112151420.ZVi8YXOl-lkp@intel.com>
References: <20211213175921.1897860-5-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213175921.1897860-5-david.e.box@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "David,

I love your patch! Yet something to improve:

[auto build test ERROR on lee-mfd/for-mfd-next]
[also build test ERROR on helgaas-pci/next shuah-kselftest/next linus/master v5.16-rc5 next-20211214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/David-E-Box/Auxiliary-bus-driver-support-for-Intel-PCIe-VSEC-DVSEC/20211214-020016
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: x86_64-randconfig-r013-20211214 (https://download.01.org/0day-ci/archive/20211215/202112151420.ZVi8YXOl-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/405984bb2427331f6e97ffef42244a5d2d090da3
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review David-E-Box/Auxiliary-bus-driver-support-for-Intel-PCIe-VSEC-DVSEC/20211214-020016
        git checkout 405984bb2427331f6e97ffef42244a5d2d090da3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/platform/x86/intel/sdsi.c:566:2: error: expected ';' after top level declarator
   }
    ^
    ;
   1 error generated.


vim +566 drivers/platform/x86/intel/sdsi.c

   558	
   559	static struct auxiliary_driver sdsi_aux_driver = {
   560		.driver = {
   561			.dev_groups = sdsi_groups,
   562		},
   563		.id_table	= sdsi_aux_id_table,
   564		.probe		= sdsi_probe,
   565		/* No remove. All resources are handled under devm */
 > 566	}
   567	module_auxiliary_driver(sdsi_aux_driver);
   568	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05DB47718C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbhLPMXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:23:01 -0500
Received: from mga05.intel.com ([192.55.52.43]:30906 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230214AbhLPMXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:23:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639657380; x=1671193380;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DjLKCj5m+HM6AjP5ToVDgj+3YarUk3+o0Hd2+u3krQE=;
  b=ccrRag6EyY3Zbu+nLm1WbNt4Dqejc/VSBtGYwtBYUS/fRuoIF2xXtiy7
   aCzYOfs20V5j36ut98yapI0/2UARbMcrfnlg9jt3SrD/Ydio4UxTAkYCX
   ncvxwaiWXzGWlTl+mPcpMOBMJZZ+ehKdSgLUGdX2+XkKzSmVTIXLLfXLU
   +//txuLDp2vaeW2DxGDSokBoSFj97jMY/QhOCwkHP7AURDO/qna44wAQF
   cQBZcU9NZnh977lJ+zu4hG9/jADn30lIhCi1q3IqOPSiphAKZBBvkCklQ
   /mLbSbjcFv0Uqcrr/hUFFeSyug0nBgNXjkPSf02GX7a/4MnPJCz9U6Wwu
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="325755121"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="325755121"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 04:23:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="615130975"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 Dec 2021 04:22:59 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxpmk-000374-82; Thu, 16 Dec 2021 12:22:58 +0000
Date:   Thu, 16 Dec 2021 20:22:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream 73/152] arch/x86/kvm/vmx/main.c:25:14:
 error: lvalue required as left operand of assignment
Message-ID: <202112162007.5fUQkqjb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream
head:   bdfe06c17daab60c196ff80c1d98467a1d3734fa
commit: 3545bcde2d72e4b5b5f16571788aac0ddb5f49a5 [73/152] KVM: TDX: Add KVM TDX system-wide initialization and teardown
config: i386-randconfig-m021-20211216 (https://download.01.org/0day-ci/archive/20211216/202112162007.5fUQkqjb-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/3545bcde2d72e4b5b5f16571788aac0ddb5f49a5
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream
        git checkout 3545bcde2d72e4b5b5f16571788aac0ddb5f49a5
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kvm/vmx/main.c: In function 'vt_hardware_setup':
>> arch/x86/kvm/vmx/main.c:25:14: error: lvalue required as left operand of assignment
      25 |   enable_tdx = false;
         |              ^
--
   arch/x86/kvm/vmx/tdx_stubs.c:4:13: error: no previous prototype for 'tdx_pre_kvm_init' [-Werror=missing-prototypes]
       4 | void __init tdx_pre_kvm_init(unsigned int *vcpu_size,
         |             ^~~~~~~~~~~~~~~~
>> arch/x86/kvm/vmx/tdx_stubs.c:6:12: error: no previous prototype for 'tdx_hardware_setup' [-Werror=missing-prototypes]
       6 | int __init tdx_hardware_setup(struct kvm_x86_ops *x86_ops) { return -EOPNOTSUPP; }
         |            ^~~~~~~~~~~~~~~~~~
>> arch/x86/kvm/vmx/tdx_stubs.c:7:6: error: no previous prototype for 'tdx_hardware_enable' [-Werror=missing-prototypes]
       7 | void tdx_hardware_enable(void) {}
         |      ^~~~~~~~~~~~~~~~~~~
>> arch/x86/kvm/vmx/tdx_stubs.c:8:6: error: no previous prototype for 'tdx_hardware_disable' [-Werror=missing-prototypes]
       8 | void tdx_hardware_disable(void) {}
         |      ^~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +25 arch/x86/kvm/vmx/main.c

    15	
    16	static __init int vt_hardware_setup(void)
    17	{
    18		int ret;
    19	
    20		ret = vmx_hardware_setup();
    21		if (ret)
    22			return ret;
    23	
    24		if (enable_tdx && tdx_hardware_setup(&vt_x86_ops))
  > 25			enable_tdx = false;
    26		return 0;
    27	}
    28	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F186477516
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbhLPO5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:57:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:21848 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235010AbhLPO5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:57:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639666630; x=1671202630;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s42kfBRilTCxpdjntHYacwLfvf0+A7dAoeI1JfpZDok=;
  b=oDejW4tkAUpyxZ2lZ81j4fJYS5oK5fLpymtJrYU9eJpXgJkQ7XOtjfW1
   Y7vmfqImN81PRfk7BKAgtMXq+ibghyubwrH8CI51zDPF3BYUwUdcB/HUc
   zlFIgXfuL5HPhann50VIABMcOvBPXzCSE0OUVdeVIUhs0UD3lenjlOCjr
   Z6cjscVDlaYrvAkYlihkrz91Rmk0SRLyMnveiP8stHrfvpvh7rQJjjJ8m
   xM7rclL3yhuF1vdxTck3RKUQDidtwsd7Uqs7yCwJlAVJ6GGPnonxvQEZR
   nbTeiZSdA2aj/UB86SgCdozgKdWfBKd8c5yB23sFJ45+XbEehSAauPmQC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="219523976"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="219523976"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 06:57:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="615179031"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 Dec 2021 06:57:08 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxsBv-0003MY-JO; Thu, 16 Dec 2021 14:57:07 +0000
Date:   Thu, 16 Dec 2021 22:56:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream 73/152] arch/x86/kvm/vmx/tdx_stubs.c:6:12:
 warning: no previous prototype for function 'tdx_hardware_setup'
Message-ID: <202112162216.Lu7x1lPh-lkp@intel.com>
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
config: x86_64-randconfig-a013-20211216 (https://download.01.org/0day-ci/archive/20211216/202112162216.Lu7x1lPh-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dd245bab9fbb364faa1581e4f92ba3119a872fba)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/3545bcde2d72e4b5b5f16571788aac0ddb5f49a5
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream
        git checkout 3545bcde2d72e4b5b5f16571788aac0ddb5f49a5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/kvm/vmx/tdx_stubs.c:4:13: warning: no previous prototype for function 'tdx_pre_kvm_init' [-Wmissing-prototypes]
   void __init tdx_pre_kvm_init(unsigned int *vcpu_size,
               ^
   arch/x86/kvm/vmx/tdx_stubs.c:4:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init tdx_pre_kvm_init(unsigned int *vcpu_size,
   ^
   static 
>> arch/x86/kvm/vmx/tdx_stubs.c:6:12: warning: no previous prototype for function 'tdx_hardware_setup' [-Wmissing-prototypes]
   int __init tdx_hardware_setup(struct kvm_x86_ops *x86_ops) { return -EOPNOTSUPP; }
              ^
   arch/x86/kvm/vmx/tdx_stubs.c:6:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __init tdx_hardware_setup(struct kvm_x86_ops *x86_ops) { return -EOPNOTSUPP; }
   ^
   static 
>> arch/x86/kvm/vmx/tdx_stubs.c:7:6: warning: no previous prototype for function 'tdx_hardware_enable' [-Wmissing-prototypes]
   void tdx_hardware_enable(void) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:7:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_hardware_enable(void) {}
   ^
   static 
>> arch/x86/kvm/vmx/tdx_stubs.c:8:6: warning: no previous prototype for function 'tdx_hardware_disable' [-Wmissing-prototypes]
   void tdx_hardware_disable(void) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:8:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_hardware_disable(void) {}
   ^
   static 
   4 warnings generated.


vim +/tdx_hardware_setup +6 arch/x86/kvm/vmx/tdx_stubs.c

     3	
     4	void __init tdx_pre_kvm_init(unsigned int *vcpu_size,
     5				unsigned int *vcpu_align, unsigned int *vm_size) {}
   > 6	int __init tdx_hardware_setup(struct kvm_x86_ops *x86_ops) { return -EOPNOTSUPP; }
   > 7	void tdx_hardware_enable(void) {}
   > 8	void tdx_hardware_disable(void) {}

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

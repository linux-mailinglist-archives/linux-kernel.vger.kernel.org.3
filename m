Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADAE477470
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbhLPO0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:26:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:13948 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232396AbhLPO0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639664778; x=1671200778;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ChWMF++dZen0hyvnLNPvkRp5hx0z9bVGRWanAXWKHgM=;
  b=Jgv6wsAlggfTyMQQUNQvHxjxpGAm8pxl67y9d5ghXDvx41PSYmlVeybe
   Fc5DWvUrjXe6Iwu2+2sye71T/dEX5lIXakvETCPmqweWYGO8UCWZT5s62
   DKEIlAE7YLowOvZRtNvw3pe3471pBFQ+vMSm3YW+GUA9CClmc5wUqN828
   UXot3G6S7gPz4/JN2Og3sSXEuTbXfi9rLmlXQ+Z3hPSkm7QJDpBI9S3jj
   8/3eYO4ca1S+VMLAM7oZ8lapUItNSNlJaEpye42NqcN2M5EUnZC9X09AQ
   SJuYy2BYEvMoMEFlyvOZEVF2PHlikL6LE2fC6/bv72HsHi7LZGRUTudJG
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="239724617"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="239724617"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 06:26:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="615169224"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 Dec 2021 06:26:07 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxrhv-0003KD-39; Thu, 16 Dec 2021 14:26:07 +0000
Date:   Thu, 16 Dec 2021 22:26:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream 79/152] arch/x86/kvm/vmx/tdx_stubs.c:11:5:
 error: no previous prototype for 'tdx_vm_ioctl'
Message-ID: <202112162217.0r56Rm99-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream
head:   bdfe06c17daab60c196ff80c1d98467a1d3734fa
commit: aa43996cce77132edb090ca84f3f6a72e359b55c [79/152] KVM: TDX: initialize VM with TDX specific parameters
config: i386-randconfig-m021-20211216 (https://download.01.org/0day-ci/archive/20211216/202112162217.0r56Rm99-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/aa43996cce77132edb090ca84f3f6a72e359b55c
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream
        git checkout aa43996cce77132edb090ca84f3f6a72e359b55c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kvm/vmx/tdx_stubs.c:4:13: error: no previous prototype for 'tdx_pre_kvm_init' [-Werror=missing-prototypes]
       4 | void __init tdx_pre_kvm_init(unsigned int *vcpu_size,
         |             ^~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:6:12: error: no previous prototype for 'tdx_hardware_setup' [-Werror=missing-prototypes]
       6 | int __init tdx_hardware_setup(struct kvm_x86_ops *x86_ops) { return -EOPNOTSUPP; }
         |            ^~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:7:6: error: no previous prototype for 'tdx_hardware_enable' [-Werror=missing-prototypes]
       7 | void tdx_hardware_enable(void) {}
         |      ^~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:8:6: error: no previous prototype for 'tdx_hardware_disable' [-Werror=missing-prototypes]
       8 | void tdx_hardware_disable(void) {}
         |      ^~~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:10:5: error: no previous prototype for 'tdx_dev_ioctl' [-Werror=missing-prototypes]
      10 | int tdx_dev_ioctl(void __user *argp) { return -EOPNOTSUPP; }
         |     ^~~~~~~~~~~~~
>> arch/x86/kvm/vmx/tdx_stubs.c:11:5: error: no previous prototype for 'tdx_vm_ioctl' [-Werror=missing-prototypes]
      11 | int tdx_vm_ioctl(struct kvm *kvm, void __user *argp) { return -EOPNOTSUPP; }
         |     ^~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/tdx_vm_ioctl +11 arch/x86/kvm/vmx/tdx_stubs.c

     3	
     4	void __init tdx_pre_kvm_init(unsigned int *vcpu_size,
     5				unsigned int *vcpu_align, unsigned int *vm_size) {}
     6	int __init tdx_hardware_setup(struct kvm_x86_ops *x86_ops) { return -EOPNOTSUPP; }
   > 7	void tdx_hardware_enable(void) {}
     8	void tdx_hardware_disable(void) {}
     9	
    10	int tdx_dev_ioctl(void __user *argp) { return -EOPNOTSUPP; }
  > 11	int tdx_vm_ioctl(struct kvm *kvm, void __user *argp) { return -EOPNOTSUPP; }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

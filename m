Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B384775E2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbhLPP2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:28:11 -0500
Received: from mga12.intel.com ([192.55.52.136]:24827 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhLPP2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639668490; x=1671204490;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Mlc1tvWUn8N2JZncy/tcTNtvBYQmnIND+ttf4+3eQ/k=;
  b=S3Bm9hdrNdnN+85M4a8cd77Ni6jSq7/hkirhZHtZtVAeSlReCBy6Gh3H
   0gP+sj0shNEcp8HsAYlLBBkIcIKG3r/soUvoLoV9UGs5+evNMtpEWXGuQ
   tQmadWZXfuErGt5lrWzCDSIuVoBZbX3UaSI/hZ6Qbbo6AWHgz/tabdpZG
   yWQssHuPaJ/616kz8rM8QMRn0lf+vykKT3BKjykv7pIRFQ5gqwTZYdwSg
   O6f7VfjdW04wWcK50GMYwNIYo7pGR19+dmBueS6XBKp61iOcj6lsqVtJ+
   /PV1GI6zAUF5BvTWmevPs4T3QUwFqoy5MauN54+KqXRv0C6On7RQR+D3H
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="219533152"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="219533152"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 07:28:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="615190586"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 Dec 2021 07:28:08 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxsfw-0003O3-12; Thu, 16 Dec 2021 15:28:08 +0000
Date:   Thu, 16 Dec 2021 23:27:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream 80/152] arch/x86/kvm/vmx/tdx_stubs.c:10:5:
 error: no previous prototype for 'tdx_vcpu_create'
Message-ID: <202112162335.xw8SJ3xA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream
head:   bdfe06c17daab60c196ff80c1d98467a1d3734fa
commit: bd5ba6a8b26525834dfa3bc5ade2dc2726b73468 [80/152] KVM: TDX: allocate/free TDX vcpu structure
config: i386-randconfig-m021-20211216 (https://download.01.org/0day-ci/archive/20211216/202112162335.xw8SJ3xA-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/bd5ba6a8b26525834dfa3bc5ade2dc2726b73468
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream
        git checkout bd5ba6a8b26525834dfa3bc5ade2dc2726b73468
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
>> arch/x86/kvm/vmx/tdx_stubs.c:10:5: error: no previous prototype for 'tdx_vcpu_create' [-Werror=missing-prototypes]
      10 | int tdx_vcpu_create(struct kvm_vcpu *vcpu) { return -EOPNOTSUPP; }
         |     ^~~~~~~~~~~~~~~
>> arch/x86/kvm/vmx/tdx_stubs.c:11:6: error: no previous prototype for 'tdx_vcpu_free' [-Werror=missing-prototypes]
      11 | void tdx_vcpu_free(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~~
>> arch/x86/kvm/vmx/tdx_stubs.c:12:6: error: no previous prototype for 'tdx_vcpu_reset' [-Werror=missing-prototypes]
      12 | void tdx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event) {}
         |      ^~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:14:5: error: no previous prototype for 'tdx_dev_ioctl' [-Werror=missing-prototypes]
      14 | int tdx_dev_ioctl(void __user *argp) { return -EOPNOTSUPP; }
         |     ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:15:5: error: no previous prototype for 'tdx_vm_ioctl' [-Werror=missing-prototypes]
      15 | int tdx_vm_ioctl(struct kvm *kvm, void __user *argp) { return -EOPNOTSUPP; }
         |     ^~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/tdx_vcpu_create +10 arch/x86/kvm/vmx/tdx_stubs.c

     9	
  > 10	int tdx_vcpu_create(struct kvm_vcpu *vcpu) { return -EOPNOTSUPP; }
  > 11	void tdx_vcpu_free(struct kvm_vcpu *vcpu) {}
  > 12	void tdx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event) {}
    13	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

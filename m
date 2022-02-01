Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FB44A5414
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 01:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiBAAdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 19:33:06 -0500
Received: from mga05.intel.com ([192.55.52.43]:25904 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229598AbiBAAdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 19:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643675585; x=1675211585;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3gXTiCamqHVXaLC8ysYKx/Z9ei0LS6DfwZIZuPqX7sc=;
  b=eAgC8FcgvDZ/mJsYhQHJwjzPJmmSOdxbL1iTGRvK6suY/XtWCLXBKfOJ
   a+cO2RULVlnAae2W4e9GIWFNvngLuBVSAjqgJSpmvfpTvVzNE0+I6BBnJ
   eQlDJQspI2qIrKlFAn7bT7uwsKJpSVfCYo7m3z314qQx4Zo4X8yybnZuG
   wDj8prdu+PjdkfSN8FhKYD22oUUuVfCid7lVbeOApDeyFNjrBf5AWSUlN
   jznX7wDz12F7nfyMNaLNwEQnsId0uW6Vx6tl47WrthrpULtOG8XKd2dOS
   YqDp0Nt5DBXYPn7kX1IZvgc7xPumtblsI8OAbA3tfBXgmdhXNeCEGfny0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="333946544"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="333946544"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 16:33:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="497150674"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 31 Jan 2022 16:33:03 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEh6U-000SWM-W7; Tue, 01 Feb 2022 00:33:02 +0000
Date:   Tue, 1 Feb 2022 08:32:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: arch/x86/kvm/x86.c:4342:31: sparse: sparse: incorrect type in return
 expression (different address spaces)
Message-ID: <202202010807.z1MJQYQ1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   26291c54e111ff6ba87a164d85d4a4e134b7315c
commit: 56f289a8d23addfa4408a08f07f42fcfe2a7bd69 KVM: x86: Add a helper to retrieve userspace address from kvm_device_attr
date:   4 days ago
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220201/202202010807.z1MJQYQ1-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=56f289a8d23addfa4408a08f07f42fcfe2a7bd69
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 56f289a8d23addfa4408a08f07f42fcfe2a7bd69
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/x86/kvm/x86.c:235:47: sparse: sparse: array of flexible structures
   arch/x86/kvm/x86.c: note: in included file:
   include/linux/kvm_host.h:1761:54: sparse: sparse: array of flexible structures
   arch/x86/kvm/x86.c:261:49: sparse: sparse: array of flexible structures
   include/linux/kvm_host.h:1763:56: sparse: sparse: array of flexible structures
   arch/x86/kvm/x86.c:2833:9: sparse: sparse: context imbalance in '__kvm_start_pvclock_update' - wrong count at exit
   arch/x86/kvm/x86.c:2844:13: sparse: sparse: context imbalance in 'kvm_end_pvclock_update' - unexpected unlock
>> arch/x86/kvm/x86.c:4342:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __user * @@     got void * @@
   arch/x86/kvm/x86.c:4342:31: sparse:     expected void [noderef] __user *
   arch/x86/kvm/x86.c:4342:31: sparse:     got void *
>> arch/x86/kvm/x86.c:4342:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __user * @@     got void * @@
   arch/x86/kvm/x86.c:4342:31: sparse:     expected void [noderef] __user *
   arch/x86/kvm/x86.c:4342:31: sparse:     got void *
   arch/x86/kvm/x86.c: note: in included file (through include/linux/notifier.h, arch/x86/include/asm/uprobes.h, include/linux/uprobes.h, ...):
   include/linux/srcu.h:188:9: sparse: sparse: context imbalance in 'vcpu_enter_guest' - unexpected unlock

vim +4342 arch/x86/kvm/x86.c

  4336	
  4337	static inline void __user *kvm_get_attr_addr(struct kvm_device_attr *attr)
  4338	{
  4339		void __user *uaddr = (void __user*)(unsigned long)attr->addr;
  4340	
  4341		if ((u64)(unsigned long)uaddr != attr->addr)
> 4342			return ERR_PTR(-EFAULT);
  4343		return uaddr;
  4344	}
  4345	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

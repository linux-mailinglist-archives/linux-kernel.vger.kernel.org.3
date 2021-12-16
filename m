Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0387F47704D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbhLPLcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:32:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:19059 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhLPLb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639654319; x=1671190319;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7qLv7WF8HjsyzV+bbaOyBlx5nFIA5ZeP6uelaSEh+eg=;
  b=LJM0jfuvY62r+Igof6FmsF1IbAceQrNpSSaZmWFCveGEzZNGdy7fYPb9
   4nkwQ485WjYgR1TQ0zUjlsM6qIHIXlLLqFor6YJO/cySdsRFMxM920a8r
   yPAvQYHa0MsLaE0e+ak9jJ+vxfqYKPj5mNH/fQrS+XAm5yQbFRPnfbo63
   CfWe+0rrhQ4+4Y3LZD5dJUT6v9hmQAVLl+G88QolD+MNedEXWQMoCGgv3
   okvlvOJs3dnjAg+F85G1BiNoE9lh7lPeQ3xsF43eGZbBc6BHEcn48KCq2
   dA8STEUZHm+ARokZE5BAa7lkH/fU1wWEcR5qq2oK3SPcGjghvKESJQ+KY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="238205935"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="238205935"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 03:31:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="519211908"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Dec 2021 03:31:58 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxozN-00034Y-Du; Thu, 16 Dec 2021 11:31:57 +0000
Date:   Thu, 16 Dec 2021 19:31:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream 72/152] arch/x86/kvm/vmx/tdx_stubs.c:4:13:
 error: no previous prototype for 'tdx_pre_kvm_init'
Message-ID: <202112161952.Ly2O53qj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream
head:   bdfe06c17daab60c196ff80c1d98467a1d3734fa
commit: bf8636a6b18c9a4a17d11dd306dcc7809db9cc9c [72/152] KVM: TDX: Stub in tdx.h with structs, accessors, and VMCS helpers
config: i386-randconfig-m021-20211216 (https://download.01.org/0day-ci/archive/20211216/202112161952.Ly2O53qj-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/bf8636a6b18c9a4a17d11dd306dcc7809db9cc9c
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream
        git checkout bf8636a6b18c9a4a17d11dd306dcc7809db9cc9c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/kvm/vmx/tdx_stubs.c:4:13: error: no previous prototype for 'tdx_pre_kvm_init' [-Werror=missing-prototypes]
       4 | void __init tdx_pre_kvm_init(unsigned int *vcpu_size,
         |             ^~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/tdx_pre_kvm_init +4 arch/x86/kvm/vmx/tdx_stubs.c

     3	
   > 4	void __init tdx_pre_kvm_init(unsigned int *vcpu_size,

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

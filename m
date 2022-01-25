Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1003A49A8AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242672AbiAYDKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:10:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:39812 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1312860AbiAYCq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643078816; x=1674614816;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x/wFiXom4DbD3ERe/v38vavrcnfKJnSak0l7vDBkZOw=;
  b=XNHjXggygs03vZNPmrZLigzZxzstuNzIF2jSMQVAbauUUqMPIuQ6+H3b
   vTqMjhCY2kUL31MZrVTLpyYIIFv8UTgzG5xc4WYdf0uPyO5FN6Sgine4R
   ugSepo0UMWvm5gmqRFHrb2WrWLv7EYTh86fi4DiB9vffTkIU2qfk3xzrB
   FQP3f6SzJTVt0Nd8GiMA/owXXMpJOestQvmPO7zzTshj8BTssn7LbL3b8
   gGOqCiNM6qH7sx/4uVYmt5J+BZi4Ty0r+YYbayuuKsG7bX76/qn3zVjgu
   OjoodY9AUNritI/Y5EF7yBV/U95UtfyjRl9oRu6UuFKFeIBzoQc6YzOEw
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246419321"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="246419321"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 18:35:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="479319843"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 24 Jan 2022 18:35:19 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCBfz-000JEP-2u; Tue, 25 Jan 2022 02:35:19 +0000
Date:   Tue, 25 Jan 2022 10:34:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 133/162] arch/x86/kvm/vmx/tdx.c:
 linux/mmu_context.h is included more than once.
Message-ID: <202201250902.FA1Zx2zw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   9ba9d8e36b0fa25f5f20109a0ae61619a421f550
commit: 8429f3db2373c9bdca7a5a0cb479f6a7ee1bc71a [133/162] KVM: TDX: Add methods to ignore accesses to CPU state
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> arch/x86/kvm/vmx/tdx.c: linux/mmu_context.h is included more than once.
>> /kbuild/src/consumer/arch/x86/kvm/vmx/tdx.c: asm/fpu/xcr.h is included more than once.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B974781F3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 02:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhLQBKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 20:10:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:10761 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231666AbhLQBKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 20:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639703434; x=1671239434;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aXh+RNelsekk6vNy62kUu27QUbmBPekwVqBDAThUTdA=;
  b=WyqLZ2aAw9JG+gIPceCQoKM6JT+SzLpi4QpaTXPi/hXIj6hrfiOCqlpY
   pXlmH3f/plmn0vootSdivTcwfMuPqMZFyjlPm+FigdCTjDZimCCm8zyeT
   ysgOv9hYBONGMsUCd+UXOqCtNsab6XbqlwSQfMLvdUsLH9Rtl+XqvX639
   XOay/DmrGI8zTEwmQG+5aNv4plemr3NTFxjV8n9fmTgjbYp3LPpMLpeGc
   Rc3EjPLpMmzwRTGCuAWrNzf22IRVsjmkjPw1Czi2Wk2FQU6fl37GlCCGr
   Dm/z5kh5mWMEfZYka2+jrdSc/coXnv24jRQwh4NMHnm8Yc9QPe+O0xA1k
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="239873214"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="239873214"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 17:10:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="466304778"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2021 17:10:32 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1my1lY-00042e-0v; Fri, 17 Dec 2021 01:10:32 +0000
Date:   Fri, 17 Dec 2021 09:09:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream 130/152] arch/x86/kvm/vmx/tdx.c:
 asm/fpu/xcr.h is included more than once.
Message-ID: <202112170923.IIuZF8xV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream
head:   bdfe06c17daab60c196ff80c1d98467a1d3734fa
commit: 1e0deafa174c1fe4fc88f708c20e1e0b592bc77d [130/152] KVM: TDX: Add methods to ignore accesses to CPU state
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> arch/x86/kvm/vmx/tdx.c: asm/fpu/xcr.h is included more than once.
>> /kbuild/src/consumer/arch/x86/kvm/vmx/tdx.c: linux/mmu_context.h is included more than once.

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

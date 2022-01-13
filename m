Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161AD48DF37
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 21:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiAMUwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 15:52:05 -0500
Received: from mga03.intel.com ([134.134.136.65]:46063 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232824AbiAMUwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 15:52:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642107124; x=1673643124;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TyGG8SSO0WgBdeeKAnSyaHcAZKgECByDY2HpggnR1Hs=;
  b=b7Q/MaK/IBKu6oJR+DbHCX4SFdPGpnoD2tAHnEAgbyBQJ5tIDKIyEbcr
   I/ddmJOdNiobGGLYxrz7CxQgiaXaUCPfYm3SrPl31qQ6qPWhlptTswGRP
   f8PouZ671RwlYfEzH8eEZ7kUFkrcou19t+SAg5EfZNCVgRct783Kz2Lk9
   V9Ex011/Xuum/IUMzv02jteN67/yzGLIw9QCeDz9mbD2KpxoiGGctjjoy
   MsqVXIzv58m2TIlWx0o4vd+Kb4K9wWeLV7s8qX+cTJDch0VD7lvkMtDei
   hKKsITmkeCXnhFNUUPoQbNvU4m0T24T7uXm6yzvkDLgPd49cVoVjqfz2m
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="244065131"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="244065131"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 12:52:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="475489557"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 13 Jan 2022 12:52:02 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n874j-0007cx-VO; Thu, 13 Jan 2022 20:52:01 +0000
Date:   Fri, 14 Jan 2022 04:51:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [intel-tdx:tdx/guest-rebased 108/133] arch/x86/kernel/tdx.c:692:15:
 warning: no previous prototype for 'tdx_mmio_readq'
Message-ID: <202201140431.dg81It8G-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git tdx/guest-rebased
head:   e3995864d37c56f431c93fc3dc454d9c65f5e9ea
commit: 756e9ea1c2ce5a460d5e3edc980255eea5f0fecf [108/133] x86/tdx: Enable direct iomap MMIO optimizations
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220114/202201140431.dg81It8G-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/756e9ea1c2ce5a460d5e3edc980255eea5f0fecf
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx tdx/guest-rebased
        git checkout 756e9ea1c2ce5a460d5e3edc980255eea5f0fecf
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/kernel/tdx.c:268:5: warning: no previous prototype for 'tdx_hcall_set_notify_intr' [-Wmissing-prototypes]
     268 | int tdx_hcall_set_notify_intr(u8 vector)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/tdx.c:509:14: warning: no previous prototype for 'tdx_write_msr' [-Wmissing-prototypes]
     509 | void notrace tdx_write_msr(unsigned int msr, u32 low, u32 high)
         |              ^~~~~~~~~~~~~
>> arch/x86/kernel/tdx.c:692:15: warning: no previous prototype for 'tdx_mmio_readq' [-Wmissing-prototypes]
     692 | unsigned long tdx_mmio_readq(void __iomem *addr)
         |               ^~~~~~~~~~~~~~


vim +/tdx_mmio_readq +692 arch/x86/kernel/tdx.c

   691	
 > 692	unsigned long tdx_mmio_readq(void __iomem *addr)
   693	{
   694		unsigned long val;
   695	
   696		if (tdx_virt_mmio(8, false, (unsigned long)addr, &val))
   697			return 0xffffffffffffffff;
   698		return val;
   699	}
   700	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

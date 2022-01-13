Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD7048DE28
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 20:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbiAMThF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 14:37:05 -0500
Received: from mga14.intel.com ([192.55.52.115]:41018 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230046AbiAMThD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 14:37:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642102623; x=1673638623;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HsZYQATemj49Q5za/ZOosy4lGjEVU+3lPW8S4Vntzc4=;
  b=Zvb5qOEQ0hbrHPoJjQHpF58zDadUEp+CO8w9cHFrn/TStGe/5L3MygUQ
   y7VQC1ZktCMFmzdVhHVY55Gw1X90VY4VOLBegfESa0OW7FAJfIiaExNAs
   e+QFZ1WtDUiI6hSzFS9zyz7PdPratdxOeiUeglKZZ6Ag5FyL3/U+GIKMa
   ZKbBqoOGLuct1lRShdMRru7Ar5vAXBX4wyCT4LmgjNlYprM2jWTfl6Cey
   Nlu+exdi7PlVT2POTrTrbcM+XGEliMu1Smuci8lIVHHD5MmfBt8bKjgeY
   BtQI3tASQJpsQcp12DO26cgw2sUy4b8hrDtof7PZOwLIEEUqZxQaicrjj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="244301641"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="244301641"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 11:37:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="691922636"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Jan 2022 11:37:01 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n85u8-0007a9-O2; Thu, 13 Jan 2022 19:37:00 +0000
Date:   Fri, 14 Jan 2022 03:36:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [intel-tdx:tdx/guest-rebased 104/133] arch/x86/kernel/tdx.c:508:14:
 warning: no previous prototype for 'tdx_write_msr'
Message-ID: <202201140330.80EFnRRg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git tdx/guest-rebased
head:   e3995864d37c56f431c93fc3dc454d9c65f5e9ea
commit: 95bf288c8d7a4e30ca710931bfb0deb2a6f020e7 [104/133] x86/tdx: Use direct paravirt call for wrmsrl
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220114/202201140330.80EFnRRg-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/95bf288c8d7a4e30ca710931bfb0deb2a6f020e7
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx tdx/guest-rebased
        git checkout 95bf288c8d7a4e30ca710931bfb0deb2a6f020e7
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/kernel/tdx.c:267:5: warning: no previous prototype for 'tdx_hcall_set_notify_intr' [-Wmissing-prototypes]
     267 | int tdx_hcall_set_notify_intr(u8 vector)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/kernel/tdx.c:508:14: warning: no previous prototype for 'tdx_write_msr' [-Wmissing-prototypes]
     508 | void notrace tdx_write_msr(unsigned int msr, u32 low, u32 high)
         |              ^~~~~~~~~~~~~


vim +/tdx_write_msr +508 arch/x86/kernel/tdx.c

   507	
 > 508	void notrace tdx_write_msr(unsigned int msr, u32 low, u32 high)
   509	{
   510		if (tdx_fast_tdcall_path_msr(msr))
   511			__tdx_write_msr(msr, low, high);
   512		else
   513			native_write_msr(msr, low, high);
   514	}
   515	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

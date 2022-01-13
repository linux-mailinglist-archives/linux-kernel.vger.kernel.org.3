Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4BC48DD6C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbiAMSFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:05:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:15231 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231138AbiAMSFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642097101; x=1673633101;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HqJcif4A+/iNXNXnoMtIA43mVWjUXStqiv78DzDwYdA=;
  b=UbD6bx9OXudUEhHKIi7xBLHCrGwpQJdWCwGpA/t0Eq5cWbjVDpqwQnvc
   0FxPcPDrYsP2orw467r/BxTjdA3bD/OMCnnGRHxtD1oOaA2xaIu+Kbp0Y
   XUVhz0Vch/wl6n3/N+Is/XRecfRpgwdQnZ/dEr01vLeYBc9htBne3QyrW
   IjPSSyOlcRiKfnYLga2Bzj0WA8haej/1dl4UYzwkKnWNKP2oBQcOoHSnp
   ApK3XNZ9XqGZ35iSTGuQq+3bv8NsUAfLjs0C402nq+ebm+VRncYGc8SBq
   2JZFeYwnhfUOtouZQDNd/baNI2HuaI78L0o7KuOCA2bmw+DMebxVy15Ff
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="330426652"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="330426652"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 10:05:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="475429932"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 13 Jan 2022 10:04:59 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n84T4-0007WR-Qb; Thu, 13 Jan 2022 18:04:58 +0000
Date:   Fri, 14 Jan 2022 02:04:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [intel-tdx:tdx/guest-rebased 55/133] arch/x86/kernel/tdx.c:224:5:
 warning: no previous prototype for 'tdx_hcall_set_notify_intr'
Message-ID: <202201140147.8KQUVLdd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git tdx/guest-rebased
head:   e3995864d37c56f431c93fc3dc454d9c65f5e9ea
commit: eff3229d99a6ea4b75fa0656fca38ac6db67ca7d [55/133] x86/tdx: Add SetupEventNotifyInterrupt TDX hypercall support
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220114/202201140147.8KQUVLdd-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/eff3229d99a6ea4b75fa0656fca38ac6db67ca7d
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx tdx/guest-rebased
        git checkout eff3229d99a6ea4b75fa0656fca38ac6db67ca7d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/tdx.c:224:5: warning: no previous prototype for 'tdx_hcall_set_notify_intr' [-Wmissing-prototypes]
     224 | int tdx_hcall_set_notify_intr(u8 vector)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/tdx_hcall_set_notify_intr +224 arch/x86/kernel/tdx.c

   216	
   217	/*
   218	 * tdx_hcall_set_notify_intr() - Setup Event Notify Interrupt Vector.
   219	 *
   220	 * @vector        : Vector address to be used for notification.
   221	 *
   222	 * return 0 on success or failure error number.
   223	 */
 > 224	int tdx_hcall_set_notify_intr(u8 vector)
   225	{
   226		u64 ret;
   227	
   228		/* Minimum vector value allowed is 32 */
   229		if (vector < 32)
   230			return -EINVAL;
   231	
   232		/*
   233		 * Register callback vector address with VMM. More details
   234		 * about the ABI can be found in TDX Guest-Host-Communication
   235		 * Interface (GHCI), sec 3.5.
   236		 */
   237		ret = _trace_tdx_hypercall(TDVMCALL_SETUP_NOTIFY_INTR, vector, 0, 0, 0,
   238					   NULL);
   239	
   240		if (ret == TDVMCALL_SUCCESS)
   241			return 0;
   242		else if (ret == TDCALL_INVALID_OPERAND)
   243			return -EINVAL;
   244	
   245		return -EIO;
   246	}
   247	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

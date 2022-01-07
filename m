Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16E1487957
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239341AbiAGO4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:56:08 -0500
Received: from mga04.intel.com ([192.55.52.120]:18581 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347944AbiAGO4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641567364; x=1673103364;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KjBVeJgxwOL1A1x3WDgZrDeI1Qd6leE5mZpHKq61sko=;
  b=VBW1FpUi2LOM1CYP8fTQE3L/KZzpUoOJzcr9Gjyp0xdpRRt9Y8cxqOCw
   OnUAOAvvGPUZ09ZDO05Dz1Jqe/SbEeyeU0CktuzlrUgykKGGtIyoB87B5
   yw5xXRoU9mAw0fCVaPOpVtNkUM1jmoY9odej3lblKXRr+f7fv5wTDuO1j
   y06zhKUeZIzQRoM+18RBhG1cnO6wjrUA1tD5tIpb6JmMHuF6q0Cu7IQP5
   Hj1mzyhW67f8IHyzzcrnJT2+19TRc13sjCZsNoCkc9t/eE2QMVZFTXKEq
   gM0CQ2VmyeIdO3Na0lcpV4vhOTg4fU8c4rufKlIWFnGXTBBVhAn+Hoh19
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="241691750"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="241691750"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 06:56:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="513818701"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 07 Jan 2022 06:56:00 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5qet-000In0-SW; Fri, 07 Jan 2022 14:55:59 +0000
Date:   Fri, 7 Jan 2022 22:55:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [intel-tdx:guest-upstream 23/33]
 arch/x86/kernel/cc_platform.c:82:10: warning: no previous prototype for
 'pgprot_encrypted'
Message-ID: <202201072256.yQG6agRZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-upstream
head:   a19e5eff857e7bb62ae28f50bf8416a71fee443d
commit: f4b36432cc6c6a9388da5f75da8bffa78d6a74a9 [23/33] x86/tdx: Make pages shared in ioremap()
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220107/202201072256.yQG6agRZ-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/f4b36432cc6c6a9388da5f75da8bffa78d6a74a9
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-upstream
        git checkout f4b36432cc6c6a9388da5f75da8bffa78d6a74a9
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cc_platform.c:82:10: warning: no previous prototype for 'pgprot_encrypted' [-Wmissing-prototypes]
      82 | pgprot_t pgprot_encrypted(pgprot_t prot)
         |          ^~~~~~~~~~~~~~~~
>> arch/x86/kernel/cc_platform.c:93:10: warning: no previous prototype for 'pgprot_decrypted' [-Wmissing-prototypes]
      93 | pgprot_t pgprot_decrypted(pgprot_t prot)
         |          ^~~~~~~~~~~~~~~~


vim +/pgprot_encrypted +82 arch/x86/kernel/cc_platform.c

    81	
  > 82	pgprot_t pgprot_encrypted(pgprot_t prot)
    83	{
    84	        if (sme_me_mask)
    85	                return __pgprot(__sme_set(pgprot_val(prot)));
    86	        else if (is_tdx_guest())
    87			return __pgprot(pgprot_val(prot) & ~tdx_shared_mask());
    88	
    89	        return prot;
    90	}
    91	EXPORT_SYMBOL_GPL(pgprot_encrypted);
    92	
  > 93	pgprot_t pgprot_decrypted(pgprot_t prot)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

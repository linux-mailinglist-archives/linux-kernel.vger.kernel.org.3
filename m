Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9B948C12B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352145AbiALJkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:40:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:5176 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349438AbiALJkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641980451; x=1673516451;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NDObU3+Yl16UQmYX4QqpeATBk95upk8QyG1bPd1Td0k=;
  b=DcQ7MQcefJsY0smfryA8wNLbpAZuAzqhdfKm1XUuFNKpDbI2yZ8DdXIj
   RB6H5MNi/MZxF5jj8TaNNaVdPXy7pehXHimLWqEFRhuV8gH1GJdn0gd14
   Rq9yZm1zEuwEOOeGoLVHwZ0b8/YaWRJsSTGI/LnyKNsTORmHGXNIVpt0/
   9e9cSYk1SodgneDixDykzb7Me+VD5PMFr2fYhHg+D/rRI7EWQw5aA9mLJ
   aReuQQp/LIeAMhWXN3sn1Q43m7qz8dako7OSvZwgUdwoeY2N5+Atzui10
   t3YT3F7uLCrHO4DOZEHCRlg9YKVG1c+nNXlSpNNBF2N0snX9A81dA8h6u
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="243496114"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="243496114"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 01:40:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="623381455"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 12 Jan 2022 01:40:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7a7S-0005f1-My; Wed, 12 Jan 2022 09:40:38 +0000
Date:   Wed, 12 Jan 2022 17:40:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [intel-tdx:tdx/guest-rebased 82/133] arch/x86/kernel/kvmclock.c:
 linux/cc_platform.h is included more than once.
Message-ID: <202201121451.3oUHcvjs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git tdx/guest-rebased
head:   e3995864d37c56f431c93fc3dc454d9c65f5e9ea
commit: 4a3880b5341dcd044ac45b1483342f005d1ec083 [82/133] x86/tdx: Disable kvmclock in TDX
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> arch/x86/kernel/kvmclock.c: linux/cc_platform.h is included more than once.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

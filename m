Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25E348F25B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 23:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiANWVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 17:21:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:23289 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230381AbiANWVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 17:21:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642198891; x=1673734891;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NDObU3+Yl16UQmYX4QqpeATBk95upk8QyG1bPd1Td0k=;
  b=aOUFPzpwr9DIoJPcWTXij7Af7e9xasLSPkbhiGMqjEDawnMB1wl3oHdk
   vsIUBFbH1jiU2I6yK0TO0wb/SwlOYvJvT7tYh2poeLKFLbXIzIGCBE0Ia
   8hSN9eRCH32id7vwjvvT19IhwGePIkPAI0ovmho4us1oJLQBkZuXdkGye
   gfgpUoPuBqKKYMjD2jA9mo57hs7LWjan0OUpiEgNYWnkFJzFxjuAlNeMr
   zlYT6woHKAjnr7SYZMUGzRbPvyZMOue0Ke0YDtyecs3nxFvz2j1uCI7hC
   OLWVSXQx6p8Ew/Ykq4OwtUW+Dj7NPYpdgDfigLA6cm4MI+kP7OELODjh1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="244540960"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="244540960"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 14:21:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="516557132"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 14 Jan 2022 14:21:29 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8Uwq-000945-S0; Fri, 14 Jan 2022 22:21:28 +0000
Date:   Sat, 15 Jan 2022 06:20:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [intel-tdx:tdx/guest-rebased 82/133] arch/x86/kernel/kvmclock.c:
 linux/cc_platform.h is included more than once.
Message-ID: <202201150608.2hRxJ21f-lkp@intel.com>
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

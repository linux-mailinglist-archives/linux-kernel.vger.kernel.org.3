Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977B248DD3C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbiAMRyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:54:06 -0500
Received: from mga02.intel.com ([134.134.136.20]:46414 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237294AbiAMRyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642096444; x=1673632444;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SZYdsBY8LvhsvMT4mK2hwTSy/LDidLatquLw1gwauPk=;
  b=PPDTaBfMw/C2mAmd65TJrKN/0YVPpJjBUGPtlQe9g3hxNxAyXTp19eT0
   GbB6EH5TkWR+qNC95na8o4I7XdkVk61ce/HpLWiDuqYzH2kSTkGSiOU+Y
   qXQyicYsgHUDiuBqDSw2Mw65SnIqDj3ecmd0Aa6TwLtsD+Fjn8ReqQcWz
   caw7jGBPC7AtWFt5jKuDNXiiJmT6faM8WuPZaoJDHT/BOZfyGuhC+zk9e
   PPVYWBxaqG9m1tqB6cqE3ziwU14vER3UX+sNab4yEigHcyb5Y3JQPCXzF
   MROk7k5XQzACsOQn3rbCmkjURSMqNjgmHJWCQk6kx6ln1emhmzVOAieye
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="231422024"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="231422024"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 09:54:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="577019313"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jan 2022 09:53:59 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n84IQ-0007Vo-MN; Thu, 13 Jan 2022 17:53:58 +0000
Date:   Fri, 14 Jan 2022 01:53:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [intel-tdx:tdx/guest-rebased 56/133] arch/x86/kernel/tdx.c:
 asm/idtentry.h is included more than once.
Message-ID: <202201140159.L4zFCiTb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git tdx/guest-rebased
head:   e3995864d37c56f431c93fc3dc454d9c65f5e9ea
commit: e43f059dae4f3a415126d04a8b1879e6b65bf5c5 [56/133] x86/tdx: Add TDX Guest event notify interrupt vector support
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> arch/x86/kernel/tdx.c: asm/idtentry.h is included more than once.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

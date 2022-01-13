Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A395A48D023
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 02:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiAMB3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 20:29:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:20758 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231308AbiAMB32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 20:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642037368; x=1673573368;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SZYdsBY8LvhsvMT4mK2hwTSy/LDidLatquLw1gwauPk=;
  b=n1Vr0eIdO6yAgeUs6ZS4R2uKXTRwngJqQwXan62Bb1oYZfDUiCLZXQhc
   O4+FFmrLoNr+0s6/rMmeeA4Fj308OKCGPztt1rG/tQKgWZkAGl4bhrW7c
   yEAmhdI0tBDMjtzGa/DfVQfvkn2n3DjDrLPFe7tbnldFzgytlNvaEsO+P
   lnROYlI239403bON/mILbxA+5CQG81SPO7mafS3P8ez1dg2UULfd7Kp9Y
   P4UwbR6OZZ6trnt5hl5yIV9/PGEctpywycPD5SXWmdmAgalDqmao1a66Z
   /IbibmfRpHNADhP/Qb/ByXJYHUg2OCwEeIqbbaA+22RYNCI85lADs0S1a
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="243857062"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="243857062"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 17:29:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="576772518"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jan 2022 17:29:26 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7ovd-0006fj-JO; Thu, 13 Jan 2022 01:29:25 +0000
Date:   Thu, 13 Jan 2022 09:28:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [intel-tdx:tdx/guest-rebased 56/133] arch/x86/kernel/tdx.c:
 asm/idtentry.h is included more than once.
Message-ID: <202201130841.Mu4ROGXG-lkp@intel.com>
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

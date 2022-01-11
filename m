Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C0D48BB64
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 00:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346800AbiAKXZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 18:25:31 -0500
Received: from mga09.intel.com ([134.134.136.24]:9337 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346782AbiAKXZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 18:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641943530; x=1673479530;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SZYdsBY8LvhsvMT4mK2hwTSy/LDidLatquLw1gwauPk=;
  b=O/aAdZGz0YrdqGq1PiTrfXi+RK1C0hvopCEo6SK/XJ65wJ3ppzFUZVbh
   zDraw5NEbRJfIllHmYhE9vhsU5nBCrzntddN+pKanrkGr8vIuR5oUq8hC
   FMfCNpfWd3BGvoBQXOSX7SPZvy2h7swEs5lCblTBhxBDRgfU07hD8Ixud
   Cf2MoJpUrG9nD7rOeYIPnqBMIQaqcidqq6tHI4oRkeVuPI+qiWJcPEIrF
   YfX+g6nnveAzKm3s4mDX8xS/0MQttw65AwzrJyIq5o+mfYmMmttfwgMgA
   NvsTy+CQkHwptCftzusor590T5GAxGQpK1k8NP5h3DP1IJ48zyqij8wpB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="243410634"
X-IronPort-AV: E=Sophos;i="5.88,281,1635231600"; 
   d="scan'208";a="243410634"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 15:24:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,281,1635231600"; 
   d="scan'208";a="490545071"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 11 Jan 2022 15:24:52 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7QVX-0005KY-S9; Tue, 11 Jan 2022 23:24:51 +0000
Date:   Wed, 12 Jan 2022 07:24:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [intel-tdx:tdx/guest-rebased 56/133] arch/x86/kernel/tdx.c:
 asm/idtentry.h is included more than once.
Message-ID: <202201120332.62laIFu0-lkp@intel.com>
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

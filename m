Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCF348E677
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239997AbiANI2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:28:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:33017 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240705AbiANI04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642148816; x=1673684816;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RZuFfgnNrTLSM579LxhI3jYodEOF6qNjDrhHiRDoTL4=;
  b=kf/nxjrRJxbIwn4GVmnNa7T+XRhT8Qnh7Cje7azhZqqeGAl84aqVp5DL
   TqGhs/c554D2EHDQJeExG3sVhRm9Cqg3IVlgEx3rx3jo0T3AhcHTU6eB1
   PjWw6cXbygTqZ+E7stjnVcOGrPLOvnLEUZH+jmQ+8rhgmMW6U2PBGidn6
   EuM4QkESOFl2vgXWbDPExykeyZChbweHrHLou9THyGmK0P+7iMC7pUGEM
   mr2OeKZgr0Y/g6mP0Uq69QWw33qfxIIvEcdq0YSvtjo3lWDIWWNiVeuCS
   DYdv/VLsDkHuygVcna2xKFKGaP2iYzK8MwEk3BPhyU3FbS/IVnG60PV28
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="244407851"
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="244407851"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 00:22:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="614266907"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jan 2022 00:22:31 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8Hqw-0008Hp-HL; Fri, 14 Jan 2022 08:22:30 +0000
Date:   Fri, 14 Jan 2022 16:22:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [intel-tdx:tdx/guest-rebased 58/133]
 tools/tdx/attest/tdx-attest-test.c: unistd.h is included more than once.
Message-ID: <202201141606.Grxph5GP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git tdx/guest-rebased
head:   e3995864d37c56f431c93fc3dc454d9c65f5e9ea
commit: 10cf59c2590afd8c342994cd885e4b0c40f1666e [58/133] tools/tdx: Add a sample attestation user app
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> tools/tdx/attest/tdx-attest-test.c: unistd.h is included more than once.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

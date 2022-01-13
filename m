Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CDD48DFF8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbiAMVxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:53:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:17147 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231158AbiAMVxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:53:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642110786; x=1673646786;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0fGFoFWKMES/l7JcNKt/2InvA6ZJ2EexIpo9cyiZTjk=;
  b=AF1UxvHXQuylcTfbDCsaBKoaAHx1y+Q/loBFGUyyMxXDjXNenZK8V+bz
   YkeEnfGFi6VpTC12U/ayOthGGhxqGznpynQt0tdGZiU4eFlertp66v/tZ
   B9ZnPouTvXKin1GKTCu5xOOlHwqSmDEexWxPfA8LNrP/OhrHA2NHF6B3+
   KaEBZNnJmcqbks6FtUwQHG+2IlFQR3ESwKouJlrCyxy27C3qdNNHAdikK
   1RsfKEIzck+qDXzwHN6/9B3IfRVqBFv20+hB90rh8OTIJ7lIj2uW8mSY1
   yuB+wqZnLLunT0HccMp6KgtsZ1yTqyevxITQCV5MkUuIZvq2Al2d+7it7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="307465379"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="307465379"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 13:53:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="577083882"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jan 2022 13:53:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n881o-0007gF-7N; Thu, 13 Jan 2022 21:53:04 +0000
Date:   Fri, 14 Jan 2022 05:53:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [intel-tdx:tdx/guest-rebased 126/133]
 arch/x86/kernel/tdx-tests.c:66:12: warning: no previous prototype for
 'kvm_unit_test_debug_init'
Message-ID: <202201140556.6bywMkqW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git tdx/guest-rebased
head:   e3995864d37c56f431c93fc3dc454d9c65f5e9ea
commit: a7d35a3976c3ad98bc3c6522a92f5eb4e3c68fc9 [126/133] x86/tdx-tests: Add a port of a kvm unit test
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220114/202201140556.6bywMkqW-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/a7d35a3976c3ad98bc3c6522a92f5eb4e3c68fc9
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx tdx/guest-rebased
        git checkout a7d35a3976c3ad98bc3c6522a92f5eb4e3c68fc9
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/tdx-tests.c:66:12: warning: no previous prototype for 'kvm_unit_test_debug_init' [-Wmissing-prototypes]
      66 | int __init kvm_unit_test_debug_init(void)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/kvm_unit_test_debug_init +66 arch/x86/kernel/tdx-tests.c

    65	
  > 66	int __init kvm_unit_test_debug_init(void)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

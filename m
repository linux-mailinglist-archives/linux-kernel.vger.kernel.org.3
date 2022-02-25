Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98E24C3B11
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbiBYBiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbiBYBiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:38:12 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744871AF8E5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645753061; x=1677289061;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TEwt2N0yp5BWOj2O+ixEeeqzj4EilJHw6lNfIrTuF7k=;
  b=AbmH87NJnL4B1Spxdro6ltF56uaxmdVTYgQn21LUAVbILTb5/Sw8oqEU
   KVcO5nbz2Bl3sMZDsTLrmEhYLoFz/HPgz6eEnD2KADsDwBLbUZZp6ilza
   azosZGrqZJFXvezEzkCx8/07oMRJCY++feTSd31fkdAfOcQtSsQGwnSzW
   thY/6EEts8U6iqdmfn895W4SEIeextTYebqimBlRdcVMp8RrDjcIGYxUB
   ggLH8oy4LhIfuD6H9n8FkDdQRfGU0X/1rGfQa0NVgPJtJYzacfcl8FGLK
   VHaxYS3FoUW4l4QyzJDfFsnvI6uGNPhCyTtquvp+AQN/TP72mxcotj3VK
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="233018512"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="233018512"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 17:37:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="639950428"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Feb 2022 17:37:39 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNPYB-0003fg-5I; Fri, 25 Feb 2022 01:37:39 +0000
Date:   Fri, 25 Feb 2022 09:37:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [intel-tdx:guest 2/4] arch/x86/kernel/tdx-tests.c:66:12: warning: no
 previous prototype for 'kvm_unit_test_debug_init'
Message-ID: <202202250905.0cOkUXj4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest
head:   f3d7a7e86bf2f0d5ce629f2fb7be11dca88ac06d
commit: 4cd6be90a565d847e1d7ccfe28264a1610a02a34 [2/4] x86/tdx-tests: Add a port of a kvm unit test
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220225/202202250905.0cOkUXj4-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/4cd6be90a565d847e1d7ccfe28264a1610a02a34
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest
        git checkout 4cd6be90a565d847e1d7ccfe28264a1610a02a34
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

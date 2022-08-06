Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E023D58B5B5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 15:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiHFN2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 09:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiHFN2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 09:28:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B2FDFE0
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 06:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659792479; x=1691328479;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XZFg9SgNLIEeJtHUemx0Vj5PmvuEoAfa1rJE4yEnd3Y=;
  b=Vs11zzvlMs6DoP4+yEB69Bd+lfedJtE4IyooOkpw9hoB/HRQOEeXfovP
   ID6lQTZDBhmg5qU69UMBXxb2J79aOsrGcAnXHjUDSi2R1mMBR8xAPz7+O
   G21SDBaekNyhyqgcOcoFom9+9POl+xKtliLidOqMdJ0TTHei3f7XUyDDS
   7Ar1jXi5RKrivN8E2R+u2SRBf3+/hTsAzkJmOa96jUgF4WpQzz/Urw6Xp
   kIUeERMSE17+BnSh3F80+0uLYF+4G5htNk0m7FwrzbxuITnT5hIrFYO9r
   9dVzYG3oEVCImph9pxc24R0UFyGrBGaIXh29vvY4yDKsYQNNSfQ1SNGav
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="277292701"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="277292701"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 06:27:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="554414900"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Aug 2022 06:27:57 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKJqO-000KOv-2n;
        Sat, 06 Aug 2022 13:27:56 +0000
Date:   Sat, 6 Aug 2022 21:27:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 19/23]
 arch/x86/coco/tdx/tdx-tests.c:66:12: warning: no previous prototype for
 'kvm_unit_test_debug_init'
Message-ID: <202208062117.s3LIMOH6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-hardening-rebased
head:   c170462888e1dab8e3e80c1c6e3708dd473ad1ed
commit: bb5af2b7a84ef8343b56bd2c1c90461635b32bd2 [19/23] x86/tdx-tests: Add a port of a kvm unit test
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220806/202208062117.s3LIMOH6-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/bb5af2b7a84ef8343b56bd2c1c90461635b32bd2
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout bb5af2b7a84ef8343b56bd2c1c90461635b32bd2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/coco/tdx/tdx-tests.c:66:12: warning: no previous prototype for 'kvm_unit_test_debug_init' [-Wmissing-prototypes]
      66 | int __init kvm_unit_test_debug_init(void)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/kvm_unit_test_debug_init +66 arch/x86/coco/tdx/tdx-tests.c

    65	
  > 66	int __init kvm_unit_test_debug_init(void)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

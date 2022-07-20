Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A09A57B132
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 08:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiGTGqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 02:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiGTGqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 02:46:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F17F474CC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 23:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658299575; x=1689835575;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eVrm6H+aOOB40iO3p23GmHegIyeHrd4VfgRNMDktSqM=;
  b=hDREmqgVZeGekVqOT5V7OmR3wbEoFrIIHQPrzXlSdUbUoax6ta3J202E
   F/fSQ5aPeFIM+WRQ4yc9PzS4T7H6orxB4hcgpcxCpvt52LmCOFnoSAtuP
   XLjdvmfAN+l08xLIJwrcm+yk5ipZsmn798FbqfjMw7WCtILy2H+fapASu
   hQz5eIvPI+76JOGcM0rwoAfmJJVUJrHsGlGSWG8iISn9pSKWN7XN0Nm1q
   Km+RWmnaADtm7PQBedg1YVfPnO/CIYmo2ShFJ+D7uHVWnCTRkkPbi/Rwx
   DBSNc87CfM2GqNRQeRkwLvZ4GrCY2dVVg7spt4aUUW+Qmn6pVengnMP95
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="286704052"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="286704052"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 23:46:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="925106437"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jul 2022 23:46:14 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oE3TJ-000091-Dr;
        Wed, 20 Jul 2022 06:46:13 +0000
Date:   Wed, 20 Jul 2022 14:45:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 19/23]
 arch/x86/coco/tdx/tdx-tests.c:66:12: warning: no previous prototype for
 function 'kvm_unit_test_debug_init'
Message-ID: <202207201438.I3jn9Bvh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-hardening-rebased
head:   c170462888e1dab8e3e80c1c6e3708dd473ad1ed
commit: bb5af2b7a84ef8343b56bd2c1c90461635b32bd2 [19/23] x86/tdx-tests: Add a port of a kvm unit test
config: x86_64-buildonly-randconfig-r002-20220718 (https://download.01.org/0day-ci/archive/20220720/202207201438.I3jn9Bvh-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project dd5635541cd7bbd62cd59b6694dfb759b6e9a0d8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/bb5af2b7a84ef8343b56bd2c1c90461635b32bd2
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout bb5af2b7a84ef8343b56bd2c1c90461635b32bd2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/coco/tdx/tdx-tests.c:66:12: warning: no previous prototype for function 'kvm_unit_test_debug_init' [-Wmissing-prototypes]
   int __init kvm_unit_test_debug_init(void)
              ^
   arch/x86/coco/tdx/tdx-tests.c:66:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __init kvm_unit_test_debug_init(void)
   ^
   static 
   1 warning generated.


vim +/kvm_unit_test_debug_init +66 arch/x86/coco/tdx/tdx-tests.c

    65	
  > 66	int __init kvm_unit_test_debug_init(void)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

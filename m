Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3834756B0C5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 04:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbiGHC52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 22:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbiGHC5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 22:57:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC1D74366
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 19:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657249043; x=1688785043;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3WPEf+lbZp7cQlZwvjhwIgF5yKZC6eX7E5gzta3IFsI=;
  b=RmVOmuuXEFifTaDWKqR4WvwrTMGOs83YECNtnJwJ8alu+Q7+5WODllR6
   Ca8BIJPpCOdBpahsbxKj9J8uCN85cqQh0ktjc4eQDfiUBrRWyAEKpimCc
   UaMkztiLazlGYR1046H4hlUpj6sq3aTcBST65Bb+3uL74M7X0S6RbpOMi
   kxDUpuuJPtVg56ruLDX4PRLuD7uLAzhsYAwb1zUs9+5eswr0HszinDlQ4
   jTnef0dL8rJ6POcdEchT/Ux+ZVdXLbQTGaAp6+syvzHoRqWmM1omg7hnL
   idKLPIBzR9EwiTc1J0YrI8Eyfps20MA1D6Qrw9O/RYmS2rJQPTgsuQBq4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="370487889"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="370487889"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 19:57:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="920835443"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jul 2022 19:57:21 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9eBF-000Mqa-Am;
        Fri, 08 Jul 2022 02:57:21 +0000
Date:   Fri, 8 Jul 2022 10:56:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 19/23]
 arch/x86/coco/tdx/tdx-tests.c:66:12: warning: no previous prototype for
 'kvm_unit_test_debug_init'
Message-ID: <202207081020.wIFbKA64-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-hardening-rebased
head:   64a4c4e66ca9cce1ca55de6d801f32284fbf7c8e
commit: c3504283446ec4b6c6f3afba2a235357c6773c98 [19/23] x86/tdx-tests: Add a port of a kvm unit test
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220708/202207081020.wIFbKA64-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/c3504283446ec4b6c6f3afba2a235357c6773c98
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout c3504283446ec4b6c6f3afba2a235357c6773c98
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

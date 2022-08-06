Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1158258B542
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 13:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiHFLo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 07:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiHFLo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 07:44:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CEC13E14
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 04:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659786296; x=1691322296;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uEj/h0R6IiIlAM1BTd6/UibngxFPKnawYsG+NfnMzgQ=;
  b=ULsFUYSSZsKUsHEU2uEk+GBfRnRfh2pzXPbjOodGGpiQxjspM5yYiuR2
   Gu2JE4fkhvFcXYDClHvl8sDGkiokXi03Tvo6Z2orho3iGkQL+Mdwq5rr+
   +SdKYMG6DUOUw5Oob7fpUtmLDdKoI0rXOuNT5jFbhQybXK5GodqKjXJuZ
   4GyTrKBStGTFAKQ1Bbyt1PJaQnP8FwTYpAPJKrDgPEk2C27vsVakcdVUm
   YM8/44Lf9Z36ZbreFiVMp4ifKNkhx1ctIgg8RrKbCnFY57M2Yz8Ecdwx7
   0ij3jdJpunB6SxoyDrFERvpaBDiTlOcaf3MkoLkteO7TkEQfKbl5YaGY/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="277286749"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="277286749"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 04:44:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="931524689"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 06 Aug 2022 04:44:54 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKIEg-000KJs-0I;
        Sat, 06 Aug 2022 11:44:54 +0000
Date:   Sat, 6 Aug 2022 19:43:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 19/23]
 arch/x86/coco/tdx/tdx-tests.c:66:12: sparse: sparse: symbol
 'kvm_unit_test_debug_init' was not declared. Should it be static?
Message-ID: <202208061952.z7f1PgpF-lkp@intel.com>
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
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220806/202208061952.z7f1PgpF-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel/tdx/commit/bb5af2b7a84ef8343b56bd2c1c90461635b32bd2
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout bb5af2b7a84ef8343b56bd2c1c90461635b32bd2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> arch/x86/coco/tdx/tdx-tests.c:66:12: sparse: sparse: symbol 'kvm_unit_test_debug_init' was not declared. Should it be static?

vim +/kvm_unit_test_debug_init +66 arch/x86/coco/tdx/tdx-tests.c

    65	
  > 66	int __init kvm_unit_test_debug_init(void)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

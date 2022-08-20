Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95F759AA4A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 02:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243659AbiHTAzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 20:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbiHTAzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:55:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6279C107ADA
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 17:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660956920; x=1692492920;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ip43NlnItFb9tN3qkW7h+1wOC/V3hBtAT/G2mnv9ZTI=;
  b=EY4NsOkyyKpFqwFY4b3u+ac8occd1J/i8vKOAlRQ2vqLpoXCs0DG8gzb
   XhTUVuVk1+wELeDKAqGDInDNp3b4o8YtgSQsm2K0aqj5WS08fHsa//2Ud
   1gYxF360crqaQvN+JFvvdhiYiPwUfo4Z9xuO359Q+WuNhcBaMDzYCHjnM
   1W+yzoPvpenD7o5DBCkiweEAD9MWoXwUKqQyyYwJ4Nswdpjvnvqq+7Qkd
   HR2fN8mSRtq2zMjTCw5bNETZ0GvBp0kDZF+hjRgPL0ELM6e/qAkmxk5BR
   US44IpbRuLwwySs1fHQlItdE1bvTG6sxoTcF9R4DKDRxa3KHx8cM3qx7l
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="293920869"
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="293920869"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 17:55:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="676626195"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Aug 2022 17:55:18 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPCli-0001yB-0Q;
        Sat, 20 Aug 2022 00:55:18 +0000
Date:   Sat, 20 Aug 2022 08:54:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 16/36]
 arch/x86/coco/tdx/tdx-tests.c:66:12: warning: no previous prototype for
 'kvm_unit_test_debug_init'
Message-ID: <202208200809.O038j7ih-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/coco/tdx/Makefile
arch/x86/coco/tdx/tdx-tests.c
tree:   https://github.com/intel/tdx.git guest-hardening-rebased
head:   d941f409a509c084250b50a3b5fc1c3c84a596a0
commit: 5091d7c6068bf030df54dc48b303a1d25a7ef0a0 [16/36] x86/tdx-tests: Add a port of a kvm unit test
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220820/202208200809.O038j7ih-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/5091d7c6068bf030df54dc48b303a1d25a7ef0a0
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout 5091d7c6068bf030df54dc48b303a1d25a7ef0a0
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

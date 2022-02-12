Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D209F4B343F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 11:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiBLKjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 05:39:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiBLKjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 05:39:46 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE16B26544
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 02:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644662382; x=1676198382;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XSsL6qV2n9k64Apfa4F4nZ+5Kxc4c6SoDQeun4MQ2Fs=;
  b=h39bTFRU+eyY9SU3NtT7Gf7XJddfyLFo8OrgvBX8s+cZ2oKAWripG8dg
   Nca0tXly2wxqnXOsc71feIllzX320qWHzBQ/mYY0nCpFwcTzvLHyX0Ue+
   si40zxGj/uVJlmUPhCW2JWjwAqcFKUNeAH0f7/X4gQJgZN0EzOpa7SVNC
   gt0/+8UuCxbzKDac/p4lfsnNeCN2kYnqUfM8bg1o4JGBn27vh7t3943E8
   yGZ2RfKZEHz9pPvr+hrqD30Ls9VRKY8nzBJ69hKsJDUHs0F8oxvYoyML8
   rystOfA2X0vxepPYpxJIxdvb5K34vhj1EKWBJJhYMbtgBT84Tf0GtmVxe
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="247465973"
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="247465973"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 02:39:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="774490224"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 12 Feb 2022 02:39:41 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIpob-00061R-29; Sat, 12 Feb 2022 10:39:41 +0000
Date:   Sat, 12 Feb 2022 18:38:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 3/145]
 arch/x86/include/asm/seam.h: asm/processor.h is included more than once.
Message-ID: <202202121422.eKTeORPV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   f40698d38196025a38e79a2bdf22058de944b38a
commit: 6b0213db6862a89cb6db2d20311af4b1e278dd73 [3/145] x86/cpu: Implement the SEAMCALL base function
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> arch/x86/include/asm/seam.h: asm/processor.h is included more than once.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

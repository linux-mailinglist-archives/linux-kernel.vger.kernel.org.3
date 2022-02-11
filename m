Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CAC4B1D3C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 04:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbiBKD6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 22:58:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbiBKD6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 22:58:45 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958DC5F70
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 19:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644551925; x=1676087925;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1tn3kbGsMoDDLlGVMfqWZyn3kg5bqv8q9WkCHoPWxws=;
  b=YLLzGDsbPW+FQn041ucq1tCYCm0B/sH0PfYRqASYufyjUtRCkH9W+/dM
   HzgB2dKxS+cbeWUOWrnuHdbRu4iFkNyJV3MKa48IWAa+WwqvIClDfksth
   3Z9ezBylION1LhLqTbSLqs07ZyFa56oDtADKv7GkUm1dBZOUuyQf0ZjV8
   RW85jy1l+aTQw+UK/AZmn1CvUjDnFYL/csLps3BbqL884JBo4vuiLj5U7
   fTja5pXcg/nwVrXULmltecak4XfFzUvICgiqfKR8AcLwkiIo6ql3r4Wzh
   0FzeNAcyjIYk7l3/2S6LwDj8r+6PGIsg55x7/xD31T6xP/SrGqtf6nrZi
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="312938514"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="312938514"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 19:58:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="602260468"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 10 Feb 2022 19:58:28 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIN4l-00046A-Gg; Fri, 11 Feb 2022 03:58:27 +0000
Date:   Fri, 11 Feb 2022 11:57:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 3/141]
 arch/x86/include/asm/seam.h: asm/processor.h is included more than once.
Message-ID: <202202110908.ul6dQYuA-lkp@intel.com>
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

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   58f28b2fcc73d05d6a5a9f70a8fdacefa99acb85
commit: 6b0213db6862a89cb6db2d20311af4b1e278dd73 [3/141] x86/cpu: Implement the SEAMCALL base function
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> arch/x86/include/asm/seam.h: asm/processor.h is included more than once.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

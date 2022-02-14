Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDEA4B585B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356991AbiBNRUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:20:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240902AbiBNRUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:20:06 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D4D652D0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644859198; x=1676395198;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XSsL6qV2n9k64Apfa4F4nZ+5Kxc4c6SoDQeun4MQ2Fs=;
  b=O5buJ6dhqQU24qDot3bOPXAvegv9a7OmxBBQisuQE/2lndSHsOp2MhS1
   /+axhPftoiY7wWynvqqRBcVpGLfU9YjV/PrA4Rtd4DYD2rZhDlbytAqlJ
   vqbzgaWhHuBNaArOPjFV4EY5u5X1zQPn44QIoNDyUYw7BrFur4QuydW4Q
   /uVMMV/D10IAp+16FjxnFssRc1JXWSwMS7+zIF0weHxkOVwJD9+fcR10y
   6CjlODrsc+WSR6klO/RfrVL412vfmnKDTArqUu3gBZ9YwMZl3BpEUGODW
   TgnaoDIpjSJUBPkFrX4wWcJN3Zj9SSDcdHeauL7cU2eXChnW/x8V2Tw+P
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="247732698"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="247732698"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 09:19:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="635315846"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 14 Feb 2022 09:19:14 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJf0L-0008mj-UF; Mon, 14 Feb 2022 17:19:13 +0000
Date:   Tue, 15 Feb 2022 01:19:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 3/145]
 arch/x86/include/asm/seam.h: asm/processor.h is included more than once.
Message-ID: <202202142207.IfsH9Fn5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E9857CA78
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 14:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbiGUMNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 08:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbiGUMNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 08:13:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0938689F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 05:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658405611; x=1689941611;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WVw/GgSsVUJfsjlWtcltTLtLJGGerJroVsUb2oi/Ur0=;
  b=HM61WMXnqrQYHciwa7pWM3vwTNrKBqM81R4CiuhwJ8oEYecQBHMJZTyO
   sJ9bpi06uYswUWjITHNJbr5YZfmYbNFTGCTWCB0RsJ2kTb+DJbbQh6tKE
   npZcED8OwjyvQ9BZDWHIzGmTPQWLAQnLVhq1Ny15eLWo2wMj6qm9hNNpA
   GwSDEYXB7w6fXK1OB7cm+t0UlsQfMW9F1cRW3U97EGZ3G0sUp1G0ZHLva
   eWx3F2xvcfCplKLIuDaGOnlSChMfii764admX9f0qW3ICxaBsY7Xp/9p9
   GZYvnMUOBHFEtUv71lAQMIVJvubciTf59SpgR7qVXfYlcQJbIT9le5VSQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="273874964"
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="273874964"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 05:13:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="666265537"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jul 2022 05:13:28 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEV3Y-000074-0V;
        Thu, 21 Jul 2022 12:13:28 +0000
Date:   Thu, 21 Jul 2022 20:12:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:tglx/devel/depthtracking 44/45]
 arch/x86/lib/putuser.S:81: Error: symbol `__put_user_nocheck_2' is already
 defined
Message-ID: <202207212007.ELVbSv77-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tglx/devel/depthtracking
head:   714d29e3e7e3faac27142424ae2533163ddd3a46
commit: 825ec2afef752357059c356cf19e8cd6230af560 [44/45] x86/putuser: Provide room for padding
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220721/202207212007.ELVbSv77-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/825ec2afef752357059c356cf19e8cd6230af560
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tglx/devel/depthtracking
        git checkout 825ec2afef752357059c356cf19e8cd6230af560
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/lib/putuser.S: Assembler messages:
>> arch/x86/lib/putuser.S:81: Error: symbol `__put_user_nocheck_2' is already defined


vim +81 arch/x86/lib/putuser.S

    79	
    80	SYM_FUNC_START(__put_user_nocheck_2)
  > 81	SYM_INNER_LABEL(__put_user_nocheck_2, SYM_L_GLOBAL)
    82		ENDBR
    83		ASM_STAC
    84	2:	movw %ax,(%_ASM_CX)
    85		xor %ecx,%ecx
    86		ASM_CLAC
    87		RET
    88	SYM_FUNC_END(__put_user_nocheck_2)
    89	EXPORT_SYMBOL(__put_user_nocheck_2)
    90	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

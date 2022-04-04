Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EEC4F13C2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359322AbiDDLXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbiDDLXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:23:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB0B26554
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 04:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649071273; x=1680607273;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cpfj922rxXkaYqzq03NQ9Tf7OY901fo5PcBzePrIbYs=;
  b=BPNUTlF2hXS6BNMNZI/nGES8grwaluR/mY7wkpDIFOG+C7kjviN88Bpy
   1QhNl8VJFL8cvXXY/2eCYF0o9T7eGDVIG1/iwXrvluu/EjUcikWdlxsiC
   Ya+CiPTWgtL/bRn7RdcTXsSLSuRQncXZ+2qxxJm4dhrBdo9UzPm+IAQ3A
   JmQ1qQcIiC/81rOI+1FV7TRdAJ6dIWa5Xl0Ov1qBnjkcBuRZgp/3Iy0na
   Nd013s6LDaebT6SF1rV0o46BDqvyRkBEz0OJJifW3/oyGQccaEACiOYem
   ncCFaxel+0J0itkO7ZyBlK9MrS8+ab+9eCNpJksPuGh9ut1kHUssYwGYM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="260189239"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="260189239"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 04:21:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="548615791"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 04 Apr 2022 04:21:12 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbKlj-0001zx-Kd;
        Mon, 04 Apr 2022 11:21:11 +0000
Date:   Mon, 4 Apr 2022 19:20:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: arch/x86/crypto/crc32c-pcl-intel-asm_64.o: warning: objtool:
 crc_pcl()+0x78: missing int3 after indirect jump
Message-ID: <202204041920.nfD4X9X5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3123109284176b1532874591f7c81f3837bbdc17
commit: e463a09af2f0677b9485a7e8e4e70b396b2ffb6f x86: Add straight-line-speculation mitigation
date:   4 months ago
config: x86_64-randconfig-c023-20220404 (https://download.01.org/0day-ci/archive/20220404/202204041920.nfD4X9X5-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e463a09af2f0677b9485a7e8e4e70b396b2ffb6f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e463a09af2f0677b9485a7e8e4e70b396b2ffb6f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/crypto/crc32c-pcl-intel-asm_64.o: warning: objtool: crc_pcl()+0x78: missing int3 after indirect jump

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

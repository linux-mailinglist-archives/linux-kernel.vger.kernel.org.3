Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9248A4F0B3F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359417AbiDCQdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238951AbiDCQdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:33:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8716725E88
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649003497; x=1680539497;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wyYxf3wsK4Z8h8k3gsnEfHp8xS0baWcV68/1yd+8EW8=;
  b=Ih1NijjVSpExHLPumeJkTRBURPKjRjzRvyutoPBaumLpZ5lZ0eUiu78/
   K5pyhPFL0WdJiQh6j6y4fNZeblp3V2gQwcQr1enhCqU549W6fso+nIp7/
   8T96MSrltqtcc+/+Z+vcoEjLf9lUzNJuQb2zCd8Mujunm0vxzVjSjGdzc
   GZ2EdAZbH9rCsYgqFb+HpqMgMldfQh386Lj7gqbhWYdNRmJ6i9HnOkmKb
   fLSKw/dbeRXTmu/FNyC9J7fHZz9Z1ByGz/5HTdO9lWF2w6RcuyEtSlSZF
   mEZ1I97dO9JYveUUxVMUOcLFyqgydxorf2yYKjnhKhr6ckLaMzCh4tyB6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="260383464"
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="260383464"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 09:31:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="504668352"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Apr 2022 09:31:35 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nb38Y-00016O-KZ;
        Sun, 03 Apr 2022 16:31:34 +0000
Date:   Mon, 4 Apr 2022 00:30:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [ammarfaizi2-block:bp/bp/test 23/23]
 arch/x86/kernel/cpu/mce/amd.c:726:1: warning: 'inline' is not at beginning
 of declaration
Message-ID: <202204040044.xPo5Hahu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block bp/bp/test
head:   aff0e90f2a981e0350187c8a931071d7f35df6e5
commit: aff0e90f2a981e0350187c8a931071d7f35df6e5 [23/23] x86/mce: Define a function to extract ErrorAddr from MCA_ADDR
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220404/202204040044.xPo5Hahu-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/aff0e90f2a981e0350187c8a931071d7f35df6e5
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block bp/bp/test
        git checkout aff0e90f2a981e0350187c8a931071d7f35df6e5
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/cpu/mce/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/mce/amd.c:726:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
     726 | void __always_inline smca_extract_err_addr(struct mce *m)
         | ^~~~


vim +/inline +726 arch/x86/kernel/cpu/mce/amd.c

   724	
   725	/* Extract [55:<lsb>] where lsb is the LS-*valid* bit of the address bits. */
 > 726	void __always_inline smca_extract_err_addr(struct mce *m)
   727	{
   728		u8 lsb;
   729	
   730		if (!mce_flags.smca)
   731			return;
   732	
   733		lsb = (m->addr >> 56) & 0x3f;
   734	
   735		m->addr &= GENMASK_ULL(55, lsb);
   736	}
   737	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

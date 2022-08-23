Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81EE59EFCF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 01:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiHWXnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 19:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHWXnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 19:43:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B58895E3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 16:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661298193; x=1692834193;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fIkj5MGlEYJCht9uw7IfFKxyX9durIK+OSnr7JNcoBE=;
  b=B2eFRtL42VN2Qbv1G19UY0DD9oLZXSXYFnlRze+Dmua1i2dt3V8X8Kqa
   GmiOmOAQCJv25Lc46eMmtCBo4/CxnwgpxYbLiM1wquhiEmZGdftFuGTqP
   rjCEHlzYVDKjc1iPuQkPL9bWFPtgrcNwfUDxTNPY3EPLXzKEXpVcesKF/
   9PxED6UnLQZ5/3/9S2B3GudUCDhaVMqw61s3OYKLLLW9kvVjDK+BbgnsB
   ZY/0jv6oSFgIdmZFPreA6UoahH/+QRltojh/azyennXeSAZAccQRAOEt1
   m2rx9ZD8VFu1sHheqL7VSvdOy+cY2V5CSv2pFCZHJXgeba03izt+qqocZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="355550313"
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="355550313"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 16:43:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="712805659"
Received: from lkp-server02.sh.intel.com (HELO 9bbcefcddf9f) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 23 Aug 2022 16:43:11 -0700
Received: from kbuild by 9bbcefcddf9f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQdY6-0000if-1g;
        Tue, 23 Aug 2022 23:43:10 +0000
Date:   Wed, 24 Aug 2022 07:42:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:arm64/alternatives/rework 15/18]
 arch/arm64/kernel/alternative.c:269:14: warning: no previous prototype for
 'alt_cb_patch_nops'
Message-ID: <202208240724.xuA9twFW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/alternatives/rework
head:   fad62c713602c963008575fd972d316569a32d12
commit: e5a9b245aeab3e0d83fbc7f9861351e8bb0e4823 [15/18] arm64: alternatives: add shared NOP callback
config: arm64-buildonly-randconfig-r005-20220823 (https://download.01.org/0day-ci/archive/20220824/202208240724.xuA9twFW-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=e5a9b245aeab3e0d83fbc7f9861351e8bb0e4823
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/alternatives/rework
        git checkout e5a9b245aeab3e0d83fbc7f9861351e8bb0e4823
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/alternative.c:269:14: warning: no previous prototype for 'alt_cb_patch_nops' [-Wmissing-prototypes]
     269 | noinstr void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,
         |              ^~~~~~~~~~~~~~~~~


vim +/alt_cb_patch_nops +269 arch/arm64/kernel/alternative.c

   268	
 > 269	noinstr void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71718596786
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 04:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238366AbiHQCuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 22:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbiHQCuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 22:50:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C30F8E9B6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 19:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660704611; x=1692240611;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=imY/mzr9ioQrXsr1sB25wvAl1kpV5ATxx69XCs57YUU=;
  b=jE+8JFFFacAfX6YRqUQKlZFkoX2I5lAg+UusdGAYjrgsscr4AuI3xe58
   H2WwGqHNKClF83jmbspu9pQ1dCSHQ7yCdBkS0oVfrY6lmRe2V6wkQBuF+
   BQEGkC4BCDQQ6dwBRzavNOILvA0znCj/RsQnhdUpbgrUaasIQ8eVLVf1e
   in57AV0uFXN59aFaRSOCYGzqdF+Nt8P7HuVk9pxgb7IgXlFw9X1yxKzd9
   skGpEP+gGMmn2xxYMMG602b18lyZdQ7/vC4b/ygKDPbeBt4vYeIyJIRhk
   udULx+SyPo5ZliTphNzV40A9VuvSzW9ss2LHms+xXaSghRUxBHh/hCw2v
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="318388395"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="318388395"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 19:50:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="583574712"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Aug 2022 19:50:09 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO98C-0000Uh-1C;
        Wed, 17 Aug 2022 02:50:08 +0000
Date:   Wed, 17 Aug 2022 10:49:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [intel-tdx:guest-filter 10/28] arch/x86/coco/core.c:35:23: error: a
 function declaration without a prototype is deprecated in all versions of C
Message-ID: <202208171051.GtZFxUcq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-filter
head:   c8ae661a124d107ccb71713b70010f1bf237b7a2
commit: c664f263080aef1f09d2021e00428e648bc1c73f [10/28] x86/tdx: Add command line option to disable TDX guest filter support
config: x86_64-randconfig-r012-20220815 (https://download.01.org/0day-ci/archive/20220817/202208171051.GtZFxUcq-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/c664f263080aef1f09d2021e00428e648bc1c73f
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-filter
        git checkout c664f263080aef1f09d2021e00428e648bc1c73f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/coco/core.c:35:23: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
   bool cc_filter_enabled()
                         ^
                          void
   1 error generated.


vim +35 arch/x86/coco/core.c

    34	
  > 35	bool cc_filter_enabled()
    36	{
    37		return cc_filter_status;
    38	}
    39	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

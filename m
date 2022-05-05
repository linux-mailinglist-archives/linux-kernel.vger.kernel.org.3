Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0AF51B965
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345873AbiEEHs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345862AbiEEHsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:48:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B39A48E7B
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 00:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651736686; x=1683272686;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5QZH20R4CRpJrDQqN3b7LZQ9qf0vHi0fRJF3GqUhTtc=;
  b=BxyEnwxruS1W5OHXPNOisvnSyIM/YvAs2jYXlgUy/o0sCOvnnlR3LHN3
   35rcOjdeR416FjVzizkOA9tRpIzQfd6v6LCMkdYJ85dE/gv4teWf4Eqol
   RdmSj2xvRwidm495XYqN/ck+Z0O+dozckeISUcLmJ3AjTN9NM61RYFjWF
   lrCaJuIUaR1prJwVCMaSEozOhX/CHbP7dODxsHyaBfoEs2hTQsQ8zVz//
   hEstX+V9b6JU/YA/XXjL99rnQwIbJHurBgESml00fRE5egxw48yu58wjN
   uP+YTW+BUCyXxocB8PKHtQozZUHRwqJSjBE76dnv/KTos7VvtOx8fsqV7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="267628614"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="267628614"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 00:44:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="694551362"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2022 00:44:45 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmWAG-000CC3-Hk;
        Thu, 05 May 2022 07:44:44 +0000
Date:   Thu, 5 May 2022 15:44:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: sh4-linux-gcc: error: unrecognized command-line option
 '-Wout-of-line-declaration'; did you mean '-Wold-style-declaration'?
Message-ID: <202205051555.tsDPbiZY-lkp@intel.com>
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

Hi Konstantin,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a7391ad3572431a354c927cf8896e86e50d7d0bf
commit: 6e5be40d32fb1907285277c02e74493ed43d77fe fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile
date:   9 months ago
config: sh-randconfig-r024-20220505 (https://download.01.org/0day-ci/archive/20220505/202205051555.tsDPbiZY-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e5be40d32fb1907285277c02e74493ed43d77fe
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6e5be40d32fb1907285277c02e74493ed43d77fe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> sh4-linux-gcc: error: unrecognized command-line option '-Wout-of-line-declaration'; did you mean '-Wold-style-declaration'?

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

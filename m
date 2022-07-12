Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6135C57222A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 20:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbiGLSGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 14:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiGLSGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:06:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29C4A9E7B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657649192; x=1689185192;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3OY3Eq99+maed0wT5vsCAhmiHbzhccXIeGcTBur8GH8=;
  b=ASdGeuH915iJN6vTZqNr/UN7oEp29foiXaq/Q03d7zmNkDnF4dvb+b6t
   nUll/ZQZsie1ybIXFPuVkLfK7ino/skUKLM/B2ehKaOaA4FOEh4Imrg0P
   1ggPt0x8Or07ox3BS3708AMWWpb92OINlD7LSf6nQPNSsYpllKcZtuEHn
   7+qGXxHdGAfW/ZTBqo+yB6fA85YrZ9/X/EOWDJQnaaqoESmuVcnoAGB32
   Peye9ZxXqhKeuBoHoMtWYHH6KX6pcIzwSQwlMgypmWEogUk9wVe4ywZoF
   uGswcEQ/KOn97WwSUCIWEauFoOlWobe5WKnFbA1hZ9bCrDr9Evwy+Swb8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="286136223"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="286136223"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 11:06:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="622609782"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 12 Jul 2022 11:06:29 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBKHE-0002YZ-E2;
        Tue, 12 Jul 2022 18:06:28 +0000
Date:   Wed, 13 Jul 2022 02:05:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [martinetd:9p-next 11/11] net/9p/trans_fd.c:275:12: warning: unused
 variable 'failme'
Message-ID: <202207130211.3Gyzsvmp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/martinetd/linux.git 9p-next
head:   c249fb4f91931b9f010849134e95d33e388c375b
commit: c249fb4f91931b9f010849134e95d33e388c375b [11/11] 9p: roll p9_tag_remove into p9_req_put
config: x86_64-randconfig-a016 (https://download.01.org/0day-ci/archive/20220713/202207130211.3Gyzsvmp-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project badda4ac3c489a8c8cccdad1f74b9308c350a9e0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/martinetd/linux/commit/c249fb4f91931b9f010849134e95d33e388c375b
        git remote add martinetd https://github.com/martinetd/linux.git
        git fetch --no-tags martinetd 9p-next
        git checkout c249fb4f91931b9f010849134e95d33e388c375b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/9p/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/9p/trans_fd.c:275:12: warning: unused variable 'failme' [-Wunused-variable]
   static int failme;
              ^
   1 warning generated.


vim +/failme +275 net/9p/trans_fd.c

   268	
   269	/**
   270	 * p9_read_work - called when there is some data to be read from a transport
   271	 * @work: container of work to be done
   272	 *
   273	 */
   274	
 > 275	static int failme;
   276	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

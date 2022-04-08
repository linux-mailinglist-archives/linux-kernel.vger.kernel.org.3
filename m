Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A804F8FB3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiDHHli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiDHHlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:41:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180881A8FEA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649403572; x=1680939572;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3zrp1LCinPGbxnXslarJ2cePZid18+wENiG18pbmG/4=;
  b=Ph/TOTqE/8W9QoI7zLYU4Cgv4P6IIhsLoiikNuwEAdjlNQZwZ3Vqf0Pt
   YzCE9MYXsf1lck31a+noOwrt2ZO7VdUIHi4KcGajb5aLIxBZGkfxwRK4V
   1Y5Nzftawu3/CMv16qqRYbM1gRYu+xPGTYRKjxEkalZvXFqQJbDMYqgYP
   EU5HMzOyitPoPVOE9bkMDk+5zkqYnDhX3nZ8+SM4OkwsjtWNE1KZ7byyV
   glOmiywJqUzaGqgEkYQPDaAtvRrcZmyfCDoDUVd9ew4afPoQ7LJ/GA7vr
   LD0JFe2p9wpMbBhv738t9QDPJDEuyY6BXZ9OuXry2yP6a1UeLUGzx4uBU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261529498"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="261529498"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 00:39:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="794490563"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 08 Apr 2022 00:39:28 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncjDM-0006Az-0o;
        Fri, 08 Apr 2022 07:39:28 +0000
Date:   Fri, 8 Apr 2022 15:38:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhanglianjie <zhanglianjie@uniontech.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [mcgrof:sysctl-testing 12/18] mm/page-writeback.c:93:28: warning:
 unused variable 'dirty_bytes_min'
Message-ID: <202204081510.D41wQr6m-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git sysctl-testing
head:   7cde53da38a3ea00d75ef6a6ab06fa85b80bcf87
commit: 87125d15aa3c4046e902758a39062f213b3664ad [12/18] mm: move page-writeback sysctls to their own file
config: s390-randconfig-r034-20220406 (https://download.01.org/0day-ci/archive/20220408/202204081510.D41wQr6m-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b306233f78876a1d197ed6e1f05785505de7c63)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?id=87125d15aa3c4046e902758a39062f213b3664ad
        git remote add mcgrof https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
        git fetch --no-tags mcgrof sysctl-testing
        git checkout 87125d15aa3c4046e902758a39062f213b3664ad
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/page-writeback.c:93:28: warning: unused variable 'dirty_bytes_min' [-Wunused-const-variable]
   static const unsigned long dirty_bytes_min = 2 * PAGE_SIZE;
                              ^
   1 warning generated.


vim +/dirty_bytes_min +93 mm/page-writeback.c

    91	
    92	/* this is needed for the proc_doulongvec_minmax of vm_dirty_bytes */
  > 93	static const unsigned long dirty_bytes_min = 2 * PAGE_SIZE;
    94	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

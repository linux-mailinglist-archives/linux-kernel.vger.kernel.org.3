Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F9954A7FF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 06:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiFNEZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 00:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiFNEZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 00:25:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6F52A415
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 21:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655180715; x=1686716715;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p9sj/QiIVWiU9GsI+4aNT6Sg88ts13hszXjq4P/QBYo=;
  b=BH+yTctCaIG4aDuLpARCXPZ1INylaSFFqTBsSIOtKTDUXrhr4374Dkxi
   vdoJUWa0D6IF7DdEcI4QGKr9SFbLkVjwKFo8ki5+aOYzqa2VE+huNpf4r
   5H/7/XFyKQ4k5W1G45j3B5vNYaJL7T3wBkJa7RMpQ/H+HayuGkwmg4BtL
   HRf28ZAmOAha2W/C3Vzj5gDfkwtdOZ4Suxt637HXZa+0oQb57kkc6in79
   oiiJoFFKz01fXtZbTFgdAQ4aamPNm9o740cc8QFBpNAi9FzeDH+QC+7Ha
   PdwkC8FA1SKBlfVRThFcMuThHHR/ZwSUZq9axUAy7RCh+61qJYsfqzkzX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="364830971"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="364830971"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 21:25:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="673653671"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jun 2022 21:25:13 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0y77-000LTI-2c;
        Tue, 14 Jun 2022 04:25:13 +0000
Date:   Tue, 14 Jun 2022 12:24:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [intel-tdx:guest-unaccepted-memory 6/17] mm/page_alloc.c:1015:40:
 error: use of undeclared identifier 'NR_UNACCEPTED'
Message-ID: <202206141219.Jr2jdIB3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-unaccepted-memory
head:   7a902d05477ac272558ba731d903c6b0c9d72903
commit: e4fbeb9c5cb4aa02fcd17388eef920f389fc83ea [6/17] mm: Report unaccepted memory in meminfo
config: hexagon-randconfig-r041-20220613 (https://download.01.org/0day-ci/archive/20220614/202206141219.Jr2jdIB3-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c97436f8b6e2718286e8496faf53a2c800e281cf)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/e4fbeb9c5cb4aa02fcd17388eef920f389fc83ea
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-unaccepted-memory
        git checkout e4fbeb9c5cb4aa02fcd17388eef920f389fc83ea
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/page_alloc.c:1015:40: error: use of undeclared identifier 'NR_UNACCEPTED'
           mod_node_page_state(page_pgdat(page), NR_UNACCEPTED, -(1 << order));
                                                 ^
   mm/page_alloc.c:1152:43: error: use of undeclared identifier 'NR_UNACCEPTED'
                   __mod_node_page_state(page_pgdat(page), NR_UNACCEPTED,
                                                           ^
   2 errors generated.


vim +/NR_UNACCEPTED +1015 mm/page_alloc.c

  1001	
  1002	/*
  1003	 * Page acceptance can be very slow. Do not call under critical locks.
  1004	 */
  1005	static void accept_page(struct page *page, unsigned int order)
  1006	{
  1007		phys_addr_t start = page_to_phys(page);
  1008		int i;
  1009	
  1010		if (!PageUnaccepted(page))
  1011			return;
  1012	
  1013		accept_memory(start, start + (PAGE_SIZE << order));
  1014		__ClearPageUnaccepted(page);
> 1015		mod_node_page_state(page_pgdat(page), NR_UNACCEPTED, -(1 << order));
  1016	
  1017		/* Assert that there is no PageUnaccepted() on tail pages */
  1018		if (IS_ENABLED(CONFIG_DEBUG_VM)) {
  1019			for (i = 1; i < (1 << order); i++)
  1020				VM_BUG_ON_PAGE(PageUnaccepted(page + i), page + i);
  1021		}
  1022	}
  1023	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C07C4DDA63
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbiCRNXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbiCRNXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:23:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B0217C415
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 06:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647609702; x=1679145702;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eqV1QWw9TmNHxfIL5myyHjYQz1fBHsC6X3GwbFchzV8=;
  b=F0WwRedXe1MJooh6Q//nPOHTS6XHiOBvPKH6kNaVkhQXziYGL9N0WPIO
   l8H7KUspiK25ouQ1UiFbMgLbKBnbNpzC7764u3wvcXBqrsi6tF57uX3ky
   K7YsIHJpRheaXVokyeiaQiRSfRLYbRvjD3CjU6oCMwIQLiWhv/BLSbjn5
   ZSOEf0GAgo4KsI37xCjlMRHZ4xgb7jOHN0TBaZEmg/vrDb8tNYNiOyxN7
   nHzzk1L9T0vxsENqEqbhGIXhTXvn6Fmuompv/MOswLMCKMQDCUa+MHAEg
   3YytwcLzomT3dM81k4xAFSpCg3ACMAGxhBnmwS6la9xQjsKQGRucbLbJY
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="343567981"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="343567981"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 06:21:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="541838601"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 18 Mar 2022 06:21:40 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVCXz-000EmR-S0; Fri, 18 Mar 2022 13:21:39 +0000
Date:   Fri, 18 Mar 2022 21:21:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Charan Teja Reddy <quic_charante@quicinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.15
 5191/5193] mm/compaction.c:761:15: error: redefinition of
 'isolate_and_split_free_page'
Message-ID: <202203182124.wIWFJftW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.15
head:   f82f0ceba5827c9d5a3c9326c95f591ebf254003
commit: f47b852faa4afaae0e534b616f2864bb587286e4 [5191/5193] ANDROID: implement wrapper for reverse migration
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220318/202203182124.wIWFJftW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6e70e4056dff962ec634c5bd4f2f4105a0bef71)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/f47b852faa4afaae0e534b616f2864bb587286e4
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.15
        git checkout f47b852faa4afaae0e534b616f2864bb587286e4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/compaction.c:761:15: error: redefinition of 'isolate_and_split_free_page'
   unsigned long isolate_and_split_free_page(struct page *page,
                 ^
   include/linux/compaction.h:230:22: note: previous definition is here
   static unsigned long isolate_and_split_free_page(struct page *page,
                        ^
   1 error generated.


vim +/isolate_and_split_free_page +761 mm/compaction.c

   760	
 > 761	unsigned long isolate_and_split_free_page(struct page *page,
   762							struct list_head *list)
   763	{
   764		unsigned long isolated;
   765		unsigned int order;
   766	
   767		if (!PageBuddy(page))
   768			return 0;
   769	
   770		order = buddy_order(page);
   771		isolated = __isolate_free_page(page, order);
   772		if (!isolated)
   773			return 0;
   774	
   775		set_page_private(page, order);
   776		list_add(&page->lru, list);
   777	
   778		split_map_pages(list);
   779	
   780		return isolated;
   781	}
   782	EXPORT_SYMBOL_GPL(isolate_and_split_free_page);
   783	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BEB4DD513
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 08:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiCRHLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 03:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiCRHLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:11:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3342B8806
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 00:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647587415; x=1679123415;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b6Q5FoXy6/I3c+e38K8Pe/KO2KlNrJOn28YTVF8+7iY=;
  b=SahtUqNB3LPidLzDSyYfqv/zlBtHkIhXSbr8bEFXI7xnf/1AiKCNiZxh
   iW0hAFTFvSwRAKkgKSa7sDsQy0HfzCvMdtFeKA3Qc2Oh/+KEsw8bepDOG
   eKjFuiuJmATQl6soId6GiNNB/Pky8Xtn/OJ9Zcx+7BxEE+sfnV+k6K9pp
   0ZkdZJzTu8mqI68zS373+zOW+VIazGM3KwM+QpvPRKUIaCPQwV+oVj+g2
   1YxjRJB/342pWHnV7q+dn+2PxuCe0VqgbT5x6h9ihmabGiVlsGM3PVxMB
   pi+OudAoF0T76I/WOQVVJudIEgCPB+XPF3t7UeQjw0uVCf1N/WXQgUCsl
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="255903979"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="255903979"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 00:10:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="550645352"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 18 Mar 2022 00:10:08 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nV6kR-000EVG-Tz; Fri, 18 Mar 2022 07:10:07 +0000
Date:   Fri, 18 Mar 2022 15:09:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Charan Teja Reddy <quic_charante@quicinc.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.15
 5191/5193] mm/compaction.c:761:15: error: redefinition of
 'isolate_and_split_free_page'
Message-ID: <202203181524.vEJlM4Ub-lkp@intel.com>
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
config: arm64-buildonly-randconfig-r005-20220318 (https://download.01.org/0day-ci/archive/20220318/202203181524.vEJlM4Ub-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/f47b852faa4afaae0e534b616f2864bb587286e4
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.15
        git checkout f47b852faa4afaae0e534b616f2864bb587286e4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/compaction.c:761:15: error: redefinition of 'isolate_and_split_free_page'
     761 | unsigned long isolate_and_split_free_page(struct page *page,
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from mm/compaction.c:14:
   include/linux/compaction.h:230:22: note: previous definition of 'isolate_and_split_free_page' with type 'long unsigned int(struct page *, struct list_head *)'
     230 | static unsigned long isolate_and_split_free_page(struct page *page,
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/compaction.c:56:27: warning: 'HPAGE_FRAG_CHECK_INTERVAL_MSEC' defined but not used [-Wunused-const-variable=]
      56 | static const unsigned int HPAGE_FRAG_CHECK_INTERVAL_MSEC = 500;
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from mm/compaction.c:14:
   include/linux/compaction.h:230:22: warning: 'isolate_and_split_free_page' defined but not used [-Wunused-function]
     230 | static unsigned long isolate_and_split_free_page(struct page *page,
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~


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

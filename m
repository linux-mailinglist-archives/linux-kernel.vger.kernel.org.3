Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DCA4D6254
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 14:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348886AbiCKNYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 08:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237824AbiCKNYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 08:24:11 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C6E77AA6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 05:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647004987; x=1678540987;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PHFcrPHTxnieTAmXY+JRlqOYJYZhnDDA5Te/E0LDw6U=;
  b=VFHOrAkOgZqgxnWMSlOwBI0khvQyVkBMrNA710cQmrHljlNbx2tamTlv
   YOli57OKTcyvUYCD+mcAJM/vDfbemPUTBOztzIYzRau0Eytb9ki9grcXB
   XHR2InQld6HXc6MEYebH8WjNvn1UBq6KNnje9ZGfmbBLms6Z/vd1SC2lS
   1lbzG874UCF0Du3y0bQUOUY+VLfs376yqqguIGHsgo08/v3cg1Wij0s1R
   ft55zcU6kKqWmsJvGx9V85sWqICXzA1Zut/r2rbeUrfqdkpIZ3xsgr23v
   kJlouqtlXbJaJhX/4k1IWvlV9BV7nKe5TBlQD6irUQduTay33CDKWD7dN
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="236173420"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="236173420"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 05:23:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="633412414"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Mar 2022 05:23:05 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSfEX-0006Sf-0c; Fri, 11 Mar 2022 13:23:05 +0000
Date:   Fri, 11 Mar 2022 21:22:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: kernel/power/snapshot.c:627:17: warning: variable 'zone_start' set
 but not used
Message-ID: <202203112142.9ym6Tz83-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220311-151720/Xiaomeng-Tong/list_for_each_entry-make-iterator-invisiable-outside-the-loop/20220301-160113
head:   54ae283053c127aac4b946dffa0f31f9885dbb77
commit: 9f7f0c85eacda7f80f068b2a2b4bcf31b91f6939 kernel: remove iterator use outside the loop
date:   6 hours ago
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220311/202203112142.9ym6Tz83-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/9f7f0c85eacda7f80f068b2a2b4bcf31b91f6939
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20220311-151720/Xiaomeng-Tong/list_for_each_entry-make-iterator-invisiable-outside-the-loop/20220301-160113
        git checkout 9f7f0c85eacda7f80f068b2a2b4bcf31b91f6939
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash kernel/power/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/power/snapshot.c: In function 'create_mem_extents':
   kernel/power/snapshot.c:633:3: error: implicit declaration of function 'list_for_each_entry_inside'; did you mean 'list_for_each_entry_safe'? [-Werror=implicit-function-declaration]
     633 |   list_for_each_entry_inside(ext, struct mem_extent, list, hook)
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |   list_for_each_entry_safe
   kernel/power/snapshot.c:633:30: error: 'ext' undeclared (first use in this function); did you mean '_text'?
     633 |   list_for_each_entry_inside(ext, struct mem_extent, list, hook)
         |                              ^~~
         |                              _text
   kernel/power/snapshot.c:633:30: note: each undeclared identifier is reported only once for each function it appears in
   kernel/power/snapshot.c:633:35: error: expected expression before 'struct'
     633 |   list_for_each_entry_inside(ext, struct mem_extent, list, hook)
         |                                   ^~~~~~
   kernel/power/snapshot.c:633:65: error: expected ';' before 'if'
     633 |   list_for_each_entry_inside(ext, struct mem_extent, list, hook)
         |                                                                 ^
         |                                                                 ;
     634 |    if (zone_start <= ext->end) {
         |    ~~                                                            
   kernel/power/snapshot.c:664:3: error: implicit declaration of function 'list_for_each_entry_safe_continue_inside'; did you mean 'list_for_each_entry_safe_continue'? [-Werror=implicit-function-declaration]
     664 |   list_for_each_entry_safe_continue_inside(cur, aux, me, list, hook) {
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |   list_for_each_entry_safe_continue
   kernel/power/snapshot.c:664:44: error: 'cur' undeclared (first use in this function)
     664 |   list_for_each_entry_safe_continue_inside(cur, aux, me, list, hook) {
         |                                            ^~~
   kernel/power/snapshot.c:664:49: error: 'aux' undeclared (first use in this function)
     664 |   list_for_each_entry_safe_continue_inside(cur, aux, me, list, hook) {
         |                                                 ^~~
   kernel/power/snapshot.c:664:64: error: 'hook' undeclared (first use in this function)
     664 |   list_for_each_entry_safe_continue_inside(cur, aux, me, list, hook) {
         |                                                                ^~~~
   kernel/power/snapshot.c:664:69: error: expected ';' before '{' token
     664 |   list_for_each_entry_safe_continue_inside(cur, aux, me, list, hook) {
         |                                                                     ^~
         |                                                                     ;
>> kernel/power/snapshot.c:627:17: warning: variable 'zone_start' set but not used [-Wunused-but-set-variable]
     627 |   unsigned long zone_start, zone_end;
         |                 ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/zone_start +627 kernel/power/snapshot.c

b788db79896ef2 Rafael J. Wysocki 2006-09-25  612  
846705deb059c3 Rafael J. Wysocki 2008-11-26  613  /**
ef96f639ea6634 Rafael J. Wysocki 2016-07-06  614   * create_mem_extents - Create a list of memory extents.
ef96f639ea6634 Rafael J. Wysocki 2016-07-06  615   * @list: List to put the extents into.
ef96f639ea6634 Rafael J. Wysocki 2016-07-06  616   * @gfp_mask: Mask to use for memory allocations.
ef96f639ea6634 Rafael J. Wysocki 2016-07-06  617   *
ef96f639ea6634 Rafael J. Wysocki 2016-07-06  618   * The extents represent contiguous ranges of PFNs.
846705deb059c3 Rafael J. Wysocki 2008-11-26  619   */
846705deb059c3 Rafael J. Wysocki 2008-11-26  620  static int create_mem_extents(struct list_head *list, gfp_t gfp_mask)
b788db79896ef2 Rafael J. Wysocki 2006-09-25  621  {
846705deb059c3 Rafael J. Wysocki 2008-11-26  622  	struct zone *zone;
b788db79896ef2 Rafael J. Wysocki 2006-09-25  623  
846705deb059c3 Rafael J. Wysocki 2008-11-26  624  	INIT_LIST_HEAD(list);
b788db79896ef2 Rafael J. Wysocki 2006-09-25  625  
ee99c71c59f897 KOSAKI Motohiro   2009-03-31  626  	for_each_populated_zone(zone) {
846705deb059c3 Rafael J. Wysocki 2008-11-26 @627  		unsigned long zone_start, zone_end;
9f7f0c85eacda7 Xiaomeng Tong     2022-03-01  628  		struct mem_extent *me = NULL;
b788db79896ef2 Rafael J. Wysocki 2006-09-25  629  
846705deb059c3 Rafael J. Wysocki 2008-11-26  630  		zone_start = zone->zone_start_pfn;
c33bc315fd921b Xishi Qiu         2013-09-11  631  		zone_end = zone_end_pfn(zone);
846705deb059c3 Rafael J. Wysocki 2008-11-26  632  
9f7f0c85eacda7 Xiaomeng Tong     2022-03-01  633  		list_for_each_entry_inside(ext, struct mem_extent, list, hook)
9f7f0c85eacda7 Xiaomeng Tong     2022-03-01  634  			if (zone_start <= ext->end) {
9f7f0c85eacda7 Xiaomeng Tong     2022-03-01  635  				me = ext;
846705deb059c3 Rafael J. Wysocki 2008-11-26  636  				break;
9f7f0c85eacda7 Xiaomeng Tong     2022-03-01  637  			}
846705deb059c3 Rafael J. Wysocki 2008-11-26  638  
9f7f0c85eacda7 Xiaomeng Tong     2022-03-01  639  		if (!me || zone_end < me->start) {
846705deb059c3 Rafael J. Wysocki 2008-11-26  640  			/* New extent is necessary */
846705deb059c3 Rafael J. Wysocki 2008-11-26  641  			struct mem_extent *new_ext;
846705deb059c3 Rafael J. Wysocki 2008-11-26  642  
846705deb059c3 Rafael J. Wysocki 2008-11-26  643  			new_ext = kzalloc(sizeof(struct mem_extent), gfp_mask);
846705deb059c3 Rafael J. Wysocki 2008-11-26  644  			if (!new_ext) {
846705deb059c3 Rafael J. Wysocki 2008-11-26  645  				free_mem_extents(list);
846705deb059c3 Rafael J. Wysocki 2008-11-26  646  				return -ENOMEM;
b788db79896ef2 Rafael J. Wysocki 2006-09-25  647  			}
846705deb059c3 Rafael J. Wysocki 2008-11-26  648  			new_ext->start = zone_start;
846705deb059c3 Rafael J. Wysocki 2008-11-26  649  			new_ext->end = zone_end;
9f7f0c85eacda7 Xiaomeng Tong     2022-03-01  650  			if (!me)
9f7f0c85eacda7 Xiaomeng Tong     2022-03-01  651  				list_add_tail(&new_ext->hook, list);
9f7f0c85eacda7 Xiaomeng Tong     2022-03-01  652  			else
9f7f0c85eacda7 Xiaomeng Tong     2022-03-01  653  				list_add_tail(&new_ext->hook, &me->hook);
846705deb059c3 Rafael J. Wysocki 2008-11-26  654  			continue;
846705deb059c3 Rafael J. Wysocki 2008-11-26  655  		}
846705deb059c3 Rafael J. Wysocki 2008-11-26  656  
846705deb059c3 Rafael J. Wysocki 2008-11-26  657  		/* Merge this zone's range of PFNs with the existing one */
9f7f0c85eacda7 Xiaomeng Tong     2022-03-01  658  		if (zone_start < me->start)
9f7f0c85eacda7 Xiaomeng Tong     2022-03-01  659  			me->start = zone_start;
9f7f0c85eacda7 Xiaomeng Tong     2022-03-01  660  		if (zone_end > me->end)
9f7f0c85eacda7 Xiaomeng Tong     2022-03-01  661  			me->end = zone_end;
846705deb059c3 Rafael J. Wysocki 2008-11-26  662  
846705deb059c3 Rafael J. Wysocki 2008-11-26  663  		/* More merging may be possible */
9f7f0c85eacda7 Xiaomeng Tong     2022-03-01  664  		list_for_each_entry_safe_continue_inside(cur, aux, me, list, hook) {
846705deb059c3 Rafael J. Wysocki 2008-11-26  665  			if (zone_end < cur->start)
846705deb059c3 Rafael J. Wysocki 2008-11-26  666  				break;
846705deb059c3 Rafael J. Wysocki 2008-11-26  667  			if (zone_end < cur->end)
9f7f0c85eacda7 Xiaomeng Tong     2022-03-01  668  				me->end = cur->end;
846705deb059c3 Rafael J. Wysocki 2008-11-26  669  			list_del(&cur->hook);
846705deb059c3 Rafael J. Wysocki 2008-11-26  670  			kfree(cur);
846705deb059c3 Rafael J. Wysocki 2008-11-26  671  		}
846705deb059c3 Rafael J. Wysocki 2008-11-26  672  	}
846705deb059c3 Rafael J. Wysocki 2008-11-26  673  
846705deb059c3 Rafael J. Wysocki 2008-11-26  674  	return 0;
b788db79896ef2 Rafael J. Wysocki 2006-09-25  675  }
b788db79896ef2 Rafael J. Wysocki 2006-09-25  676  

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

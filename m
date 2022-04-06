Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889734F6CCD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiDFVej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbiDFVeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:34:03 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6BA15837
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649278005; x=1680814005;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fvqODK3ztO62zOAA8u1/PyrlpBqIrBsKoDcGqSej0RU=;
  b=WFJw+Ekc2kM5ev7HRIJqJxwOqSRcPiLLUbQib/+lJ36VTwcgltu1ELmy
   dHXbR2chl7fRBEIabrOfPyTOoUB9cDf7/8gn+2O0t5EyhX6K9tt2N5YCl
   oVvfbFTW/g0xbBGpi+p5ibFPfCt2G2zMy7Tc0vyyJMmgXrUICJs98J0qB
   nddD9Y2sh3y3GCFe+8HxiUa7QqfpoJ44NCObT2DWJ3cgGR10QOg4jGePa
   cs44D0ymFcxVQA9jNESzZyS44pAffVTISD8KYSUcxB9hX8MkE5F1YEl3w
   1xx6K7bX1dc7Upr+y1n8Pp9DNGp7ut9o2QRF8DQE5SFEOdC5mJFmDMnFE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="321844975"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="321844975"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 13:46:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="658683636"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 06 Apr 2022 13:46:43 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncCY7-0004jp-7C;
        Wed, 06 Apr 2022 20:46:43 +0000
Date:   Thu, 7 Apr 2022 04:46:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/fscache-ceph 22/22]
 fs/ceph/addr.c:1047:9: error: use of undeclared identifier 'skips'
Message-ID: <202204070429.h8hMgEQm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/fscache-ceph
head:   3eaf3110a87879d1fdaf472fd14885c99aa919a0
commit: 3eaf3110a87879d1fdaf472fd14885c99aa919a0 [22/22] ceph: Pass an iter down from writepages
config: hexagon-randconfig-r014-20220406 (https://download.01.org/0day-ci/archive/20220407/202204070429.h8hMgEQm-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/3eaf3110a87879d1fdaf472fd14885c99aa919a0
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/fscache-ceph
        git checkout 3eaf3110a87879d1fdaf472fd14885c99aa919a0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/ceph/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/ceph/addr.c:1047:9: error: use of undeclared identifier 'skips'
                                   if (skips >= 5 || need_resched())
                                       ^
   fs/ceph/addr.c:1049:5: error: use of undeclared identifier 'skips'
                                   skips++;
                                   ^
   2 errors generated.


vim +/skips +1047 fs/ceph/addr.c

   982	
   983	/*
   984	 * write a region of pages back to the server
   985	 */
   986	static int ceph_writepages_region(struct address_space *mapping,
   987					  struct writeback_control *wbc,
   988					  struct ceph_snap_context *snapc,
   989					  struct ceph_writeback_ctl *ceph_wbc,
   990					  loff_t start, loff_t end, loff_t *_next)
   991	{
   992		struct folio *folio;
   993		ssize_t ret;
   994	
   995		printk("%s(%llx,%llx)", __func__, start, end);
   996	
   997		do {
   998			pgoff_t index = start / PAGE_SIZE;
   999			pgoff_t end = end / PAGE_SIZE;
  1000	
  1001			folio = ceph_scan_for_writeable_page(mapping, snapc, index, end);
  1002			if (!folio)
  1003				break;
  1004	
  1005			start = folio_pos(folio); /* May regress with THPs */
  1006	
  1007			printk("wback %lx\n", folio_index(folio));
  1008	
  1009			/* At this point we hold neither the i_pages lock nor the
  1010			 * page lock: the page may be truncated or invalidated
  1011			 * (changing page->mapping to NULL), or even swizzled
  1012			 * back from swapper_space to tmpfs file mapping
  1013			 */
  1014			if (wbc->sync_mode != WB_SYNC_NONE) {
  1015				ret = folio_lock_killable(folio);
  1016				if (ret < 0) {
  1017					folio_put(folio);
  1018					return ret;
  1019				}
  1020			} else {
  1021				if (!folio_trylock(folio)) {
  1022					folio_put(folio);
  1023					return 0;
  1024				}
  1025			}
  1026	
  1027			if (folio_mapping(folio) != mapping ||
  1028			    folio_get_private(folio) != snapc ||
  1029			    !folio_test_dirty(folio)) {
  1030				start += folio_size(folio);
  1031				folio_unlock(folio);
  1032				folio_put(folio);
  1033				continue;
  1034			}
  1035	
  1036			if (folio_test_writeback(folio) ||
  1037			    folio_test_fscache(folio)) {
  1038				folio_unlock(folio);
  1039				if (wbc->sync_mode != WB_SYNC_NONE) {
  1040					folio_wait_writeback(folio);
  1041					folio_wait_fscache(folio);
  1042				} else {
  1043					start += folio_size(folio);
  1044				}
  1045				folio_put(folio);
  1046				if (wbc->sync_mode == WB_SYNC_NONE) {
> 1047					if (skips >= 5 || need_resched())
  1048						break;
  1049					skips++;
  1050				}
  1051				continue;
  1052			}
  1053	
  1054			if (!folio_clear_dirty_for_io(folio))
  1055				BUG();
  1056			ret = ceph_write_back_from_locked_folio(mapping, wbc, snapc, ceph_wbc,
  1057								folio, start, end);
  1058			folio_put(folio);
  1059			if (ret < 0)
  1060				return ret;
  1061	
  1062			start += ret;
  1063	
  1064			cond_resched();
  1065		} while (wbc->nr_to_write > 0);
  1066	
  1067		*_next = start;
  1068		printk("%s() = 0 [%llx]\n", __func__, *_next);
  1069		return 0;
  1070	}
  1071	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

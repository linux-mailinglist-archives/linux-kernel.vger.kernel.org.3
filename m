Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A7150C5E6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 03:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiDWBIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 21:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiDWBIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 21:08:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5BD1CF712
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 18:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650675934; x=1682211934;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+AKjTIy/D5/5a2Kn+Wb/Y7zUrIrc7ourKnOb1bcZPlQ=;
  b=fTae+zWacL120WB6GB8T6Y070YjKW3SEoPgIuRdClF2ETaAuoxnqREn6
   OTmgjs6ShkoCXzFWCiuReBFVD/1hwmApsQxWpK7Lw8mnNhBWj2fSUqxvQ
   zLPM6/J8tsJeIthpaIq4iBN87Tu8o5x7IoykfOsBGG6Ra/sGWPAUaNmrl
   PyIBMex69EIrsHmuFRSDEDsi5GMa77ETX1b2rNikdn9YckM73BP1H94WY
   7KOJWDFA2C/6/uttRc9D2wFuXBEx0Tn7o/MQNo+pD268uuCHqNoTcLH3y
   NoSH3ktorUkLzod301NCQ7A77BT+F7fDCnwx8zyBy3SZIQlCPy69Ws4oc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264314992"
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="264314992"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 18:05:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="806228214"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 22 Apr 2022 18:05:31 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni4DL-000Akb-6V;
        Sat, 23 Apr 2022 01:05:31 +0000
Date:   Sat, 23 Apr 2022 09:04:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 19/44]
 lib/maple_tree.c:76:28: warning: unused variable 'mt_max'
Message-ID: <202204230954.HDq6NK6c-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   931e50676c6598d0eda1954ead465519ff91874d
commit: 6c45be03ed6456efda93c06956d586eecae0e51a [19/44] Maple Tree: add new data structure
config: hexagon-randconfig-r012-20220422 (https://download.01.org/0day-ci/archive/20220423/202204230954.HDq6NK6c-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/6c45be03ed6456efda93c06956d586eecae0e51a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 6c45be03ed6456efda93c06956d586eecae0e51a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/maple_tree.c:76:28: warning: unused variable 'mt_max' [-Wunused-const-variable]
   static const unsigned long mt_max[] = {
                              ^
   lib/maple_tree.c:322:20: warning: unused function 'mte_set_full' [-Wunused-function]
   static inline void mte_set_full(const struct maple_enode *node)
                      ^
   lib/maple_tree.c:327:20: warning: unused function 'mte_clear_full' [-Wunused-function]
   static inline void mte_clear_full(const struct maple_enode *node)
                      ^
>> lib/maple_tree.c:4199:20: warning: stack frame size (1096) exceeds limit (1024) in 'mas_wr_modify' [-Wframe-larger-than]
   static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
                      ^
   4 warnings generated.


vim +/mt_max +76 lib/maple_tree.c

    75	
  > 76	static const unsigned long mt_max[] = {
    77		[maple_dense]		= MAPLE_NODE_SLOTS,
    78		[maple_leaf_64]		= ULONG_MAX,
    79		[maple_range_64]	= ULONG_MAX,
    80		[maple_arange_64]	= ULONG_MAX,
    81	};
    82	#define mt_node_max(x) mt_max[mte_node_type(x)]
    83	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653B84C1C56
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244461AbiBWThY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240725AbiBWThR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:37:17 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE8D344DF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645645008; x=1677181008;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=28eVFkMm3SOoNUQ1iwI8a71le4xUQriqCX4Mto4jfSA=;
  b=YKWTUcOVCCALbTn679pfgGaQvL30iWhuNFwOWn/wUoj0d8ih8v6j++GK
   JiIDEi/oIR6KYj+eRhFWdDRpaYxg0d21x7nL6De0mfAyfGydLo3GyODpL
   MQW44qun8CJzb2MluLrsAC2lvA7g8bJf1hiX92WXGbxwBuRBKf65WyfZx
   YGGTCNZg2h2gODBnltmF7FkXtFsfUCCPUXnWTI2m3rX53zwQxU6YR275b
   ZqeDNxvEwHQ3EvePBlvUhXnieEXLHLmqmp+4PI1qyuEQWhjVY83nIF96/
   WmVcQtIgZ0W2fe2pRtLAAMUTohdsKLbTG+cD98q4+jJzNYudQMbBaElcg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="338502804"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="338502804"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 11:36:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="491331805"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Feb 2022 11:36:45 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMxRM-0001kH-Ph; Wed, 23 Feb 2022 19:36:44 +0000
Date:   Thu, 24 Feb 2022 03:36:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2233/2340] net/ceph/messenger_v1.c:1066:3:
 error: implicit declaration of function 'memcpy_to_page'
Message-ID: <202202240347.8dLJwUNW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   97c5eeb4de3ad324ed2a4656b46465299cfd010a
commit: 7134c56595f0f35bb1f17fcbf4dcca28c52b8ae8 [2233/2340] headers/deps: mm: Introduce <linux/highmem_extra.h> for rarely used APIs
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220224/202202240347.8dLJwUNW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=7134c56595f0f35bb1f17fcbf4dcca28c52b8ae8
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 7134c56595f0f35bb1f17fcbf4dcca28c52b8ae8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the mingo-tip/sched/headers HEAD 97c5eeb4de3ad324ed2a4656b46465299cfd010a builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> net/ceph/messenger_v1.c:1066:3: error: implicit declaration of function 'memcpy_to_page' [-Werror,-Wimplicit-function-declaration]
                   memcpy_to_page(page, off, page_address(con->bounce_page), ret);
                   ^
   net/ceph/messenger_v1.c:1066:3: note: did you mean 'memcpy_to_msg'?
   include/linux/skbuff_api.h:2215:19: note: 'memcpy_to_msg' declared here
   static inline int memcpy_to_msg(struct msghdr *msg, void *data, int len)
                     ^
   1 error generated.
--
>> net/ceph/messenger_v2.c:1805:3: error: implicit declaration of function 'memcpy_to_page' [-Werror,-Wimplicit-function-declaration]
                   memcpy_to_page(bv.bv_page, bv.bv_offset,
                   ^
   net/ceph/messenger_v2.c:1805:3: note: did you mean 'memcpy_to_msg'?
   include/linux/skbuff_api.h:2215:19: note: 'memcpy_to_msg' declared here
   static inline int memcpy_to_msg(struct msghdr *msg, void *data, int len)
                     ^
   1 error generated.


vim +/memcpy_to_page +1066 net/ceph/messenger_v1.c

2f713615ddd9d8 Ilya Dryomov 2020-11-12  1034  
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1035  static int read_partial_msg_data_bounce(struct ceph_connection *con)
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1036  {
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1037  	struct ceph_msg_data_cursor *cursor = &con->in_msg->cursor;
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1038  	struct page *page;
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1039  	size_t off, len;
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1040  	u32 crc;
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1041  	int ret;
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1042  
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1043  	if (unlikely(!con->bounce_page)) {
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1044  		con->bounce_page = alloc_page(GFP_NOIO);
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1045  		if (!con->bounce_page) {
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1046  			pr_err("failed to allocate bounce page\n");
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1047  			return -ENOMEM;
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1048  		}
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1049  	}
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1050  
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1051  	crc = con->in_data_crc;
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1052  	while (cursor->total_resid) {
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1053  		if (!cursor->resid) {
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1054  			ceph_msg_data_advance(cursor, 0);
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1055  			continue;
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1056  		}
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1057  
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1058  		page = ceph_msg_data_next(cursor, &off, &len, NULL);
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1059  		ret = ceph_tcp_recvpage(con->sock, con->bounce_page, 0, len);
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1060  		if (ret <= 0) {
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1061  			con->in_data_crc = crc;
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1062  			return ret;
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1063  		}
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1064  
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1065  		crc = crc32c(crc, page_address(con->bounce_page), ret);
038b8d1d1ab1cc Ilya Dryomov 2021-12-30 @1066  		memcpy_to_page(page, off, page_address(con->bounce_page), ret);
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1067  
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1068  		ceph_msg_data_advance(cursor, ret);
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1069  	}
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1070  	con->in_data_crc = crc;
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1071  
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1072  	return 1;	/* must return > 0 to indicate success */
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1073  }
038b8d1d1ab1cc Ilya Dryomov 2021-12-30  1074  

:::::: The code at line 1066 was first introduced by commit
:::::: 038b8d1d1ab1cce11a158d30bf080ff41a2cfd15 libceph: optionally use bounce buffer on recv path in crc mode

:::::: TO: Ilya Dryomov <idryomov@gmail.com>
:::::: CC: Ilya Dryomov <idryomov@gmail.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

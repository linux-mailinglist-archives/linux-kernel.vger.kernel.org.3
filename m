Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D864B1F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347720AbiBKHjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:39:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238209AbiBKHjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:39:36 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48A7B5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644565175; x=1676101175;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KJcBPHutFtdAp5TQJ5p4A8haLafQWC+Mu0rEEAa+Y0M=;
  b=Ksjy7yT6GPstmY2F1ioQskATYEbJlY9l8NFJn2DWVsrxoO2xlo+c1Mwu
   KAfRHmDiHZz34qGf2fXLgUDH+PyVTi8/DWM4c0pURQMgwBXyAvTcsfMxy
   XEwrWU4vs1SdgNU72Et908BV1LCZ8azQbmlld/CTGbo/Xb1mtJEr3UEOp
   +Rdq2RsL1gSmWOl0pdJe+m/ggREBHbQ/T25oS05hZXvAChBgc4stBH5I+
   RXOZNTOoNHoRwI+ux0eBgUbd5PCXu7uAzXa6bczbTFXYQ55GM7qydzl6F
   aIUF1y5QPglY1kjTScKHqD/vC9Oy0oP7q3oPqiZ/YxWbvEB2wbW8yKldw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="237084857"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="237084857"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 23:39:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="483196792"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 10 Feb 2022 23:39:34 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIQWj-0004Iu-SR; Fri, 11 Feb 2022 07:39:33 +0000
Date:   Fri, 11 Feb 2022 15:38:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jlayton:ceph-fscrypt 55/57] net/ceph/messenger.c:1126:30: sparse:
 sparse: incompatible types in comparison expression (different type sizes):
Message-ID: <202202111549.YqdShhY1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git ceph-fscrypt
head:   adf69efebc954db1aa7af7b93febbc2a1b51dc6c
commit: 8647843c1c4c4ebffb864d049176b4d847ef3a4b [55/57] libceph: allow ceph_msg_data_advance to advance more than a page
config: xtensa-randconfig-s032-20220210 (https://download.01.org/0day-ci/archive/20220211/202202111549.YqdShhY1-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=8647843c1c4c4ebffb864d049176b4d847ef3a4b
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton ceph-fscrypt
        git checkout 8647843c1c4c4ebffb864d049176b4d847ef3a4b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=xtensa SHELL=/bin/bash net/ceph/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   net/ceph/messenger.c: note: in included file (through arch/xtensa/include/asm/bitops.h, include/linux/bitops.h, include/linux/log2.h, ...):
   arch/xtensa/include/asm/processor.h:107:2: sparse: sparse: Unsupported xtensa ABI
   arch/xtensa/include/asm/processor.h:137:2: sparse: sparse: Unsupported Xtensa ABI
>> net/ceph/messenger.c:1126:30: sparse: sparse: incompatible types in comparison expression (different type sizes):
>> net/ceph/messenger.c:1126:30: sparse:    unsigned int *
>> net/ceph/messenger.c:1126:30: sparse:    unsigned long *

vim +1126 net/ceph/messenger.c

  1122	
  1123	void ceph_msg_data_advance(struct ceph_msg_data_cursor *cursor, size_t bytes)
  1124	{
  1125		while (bytes) {
> 1126			size_t cur = min(bytes, PAGE_SIZE);
  1127	
  1128			__ceph_msg_data_advance(cursor, cur);
  1129			bytes -= cur;
  1130		}
  1131	}
  1132	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6129359ECAF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbiHWTpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiHWToc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:44:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0911CB942D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661280422; x=1692816422;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ldZgYNfdYBSGbD0K/M+Boh0I8FVavFlXHoINWQ0ulGc=;
  b=VEVaIHNgDdhy35RhU/ueQaonptAnUgTFBA8Vo0SYV5Qh1nn81wCmIa4u
   6rW465mMUXeemrSBxTZ8AJLV36zKyDBYbQ4sB7P/WgHQlXJWBwykTw85U
   P2M9ojj61Imld4nl3RBlkrYsApWsGdJ3/82Sf17fiFQ44uVnY7e9zinJd
   BNYYkOoNHIFBkPlMMGbls48qsmCsBsUpG+lJnLh3/xYusjFoLZwPvOBvp
   XyrQUq8Fcb7hp/i5FFUFxaewwvJDCZwNczGD0nQlFkqa4gj9CBepJX+rR
   c6wmS4crlkGPluL9c/MwOBoB4wtDiRKIVtR+d8V4IrNrG0Cm5hFPL9NOe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="355499716"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="355499716"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 11:47:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="586109432"
Received: from lkp-server02.sh.intel.com (HELO 9bbcefcddf9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 23 Aug 2022 11:47:00 -0700
Received: from kbuild by 9bbcefcddf9f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQYvT-0000RD-1e;
        Tue, 23 Aug 2022 18:46:59 +0000
Date:   Wed, 24 Aug 2022 02:46:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leon@kernel.org>
Subject: [leon-rdma:rdma-next 15/40]
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c:5805:5: warning: no previous
 prototype for 'hns_roce_v2_query_mpt'
Message-ID: <202208240240.7nXzYHkq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git rdma-next
head:   07c7704e6a8741b28f249e1f53c6c1f66b718687
commit: 436aa2aa24f6efe8f918709daa71f47d2d0713ae [15/40] RDMA/hns: Support MR's restrack raw ops for hns driver
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20220824/202208240240.7nXzYHkq-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/commit/?id=436aa2aa24f6efe8f918709daa71f47d2d0713ae
        git remote add leon-rdma https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git
        git fetch --no-tags leon-rdma rdma-next
        git checkout 436aa2aa24f6efe8f918709daa71f47d2d0713ae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/infiniband/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:5805:5: warning: no previous prototype for 'hns_roce_v2_query_mpt' [-Wmissing-prototypes]
    5805 | int hns_roce_v2_query_mpt(struct hns_roce_dev *hr_dev, u32 key, void *buffer)
         |     ^~~~~~~~~~~~~~~~~~~~~


vim +/hns_roce_v2_query_mpt +5805 drivers/infiniband/hw/hns/hns_roce_hw_v2.c

  5804	
> 5805	int hns_roce_v2_query_mpt(struct hns_roce_dev *hr_dev, u32 key, void *buffer)
  5806	{
  5807		struct hns_roce_v2_mpt_entry *context;
  5808		struct hns_roce_cmd_mailbox *mailbox;
  5809		int ret;
  5810	
  5811		mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
  5812		if (IS_ERR(mailbox))
  5813			return PTR_ERR(mailbox);
  5814	
  5815		context = mailbox->buf;
  5816		ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, HNS_ROCE_CMD_QUERY_MPT,
  5817					key_to_hw_index(key));
  5818		if (ret) {
  5819			ibdev_err(&hr_dev->ib_dev,
  5820				  "failed to process cmd when querying MPT, ret = %d.\n",
  5821				  ret);
  5822			goto err_mailbox;
  5823		}
  5824	
  5825		memcpy(buffer, context, sizeof(*context));
  5826	
  5827	err_mailbox:
  5828		hns_roce_free_cmd_mailbox(hr_dev, mailbox);
  5829	
  5830		return ret;
  5831	}
  5832	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

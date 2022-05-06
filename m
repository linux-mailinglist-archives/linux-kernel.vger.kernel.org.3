Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819AD51D097
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 07:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389091AbiEFF1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 01:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241151AbiEFF1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 01:27:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C0A5DA60
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 22:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651814629; x=1683350629;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CskUf1vOKBv/THAKA3+Z3M68gUYpgNttgvdFNDATh10=;
  b=TScIaWKilKE2/TvgDPtSEeSleoyWmiUKzFYwJS4rrfNz6FRE8lNNo6IH
   kzHHZy5SrJ2OsJUPUq2M4S3ziUY0rpsI8eV1wXHl9DVYV3JSVuA9BZlWL
   nbXqrRpI2A98yXAfkw/4jLQey+5Skb4QFtlDYfKy7XLmbuTGA4KRMznpx
   mYvM3jlNlxY9qypnYfCez3QD0jcBqxNedu2RWRf3cfVne1xL1SzBkzuUn
   dOwQmtt6xZ8TXpCyamZixAHcrk+mFuEhSFzbLY4eyG4e1ZCsXZev8WuCU
   CzOdhTqRkapYH0D0VNr3vfGQLgIVGtrcAovYNKItKiWLfU6UZkLn54Pkf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="268253203"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="268253203"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 22:23:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="549696711"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 05 May 2022 22:23:47 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmqRO-000DA0-95;
        Fri, 06 May 2022 05:23:46 +0000
Date:   Fri, 6 May 2022 13:23:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Anuj Gupta <anuj20.g@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [ammarfaizi2-block:axboe/linux-block/for-5.19/io_uring-passthrough
 19/20] drivers/nvme/host/ioctl.c:690:6: warning: variable 'ret' is used
 uninitialized whenever 'if' condition is false
Message-ID: <202205061324.Uf7nd6hz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/for-5.19/io_uring-passthrough
head:   6f7c47f1c2768790e557c301ddf75498f36f12b2
commit: 86116c2f6fee81a0be72a71cc2f1f7c087df8efa [19/20] nvme: wire-up uring-cmd support for io-passthru on char-device.
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20220506/202205061324.Uf7nd6hz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e004fb787698440a387750db7f8028e7cb14cfc)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/86116c2f6fee81a0be72a71cc2f1f7c087df8efa
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/for-5.19/io_uring-passthrough
        git checkout 86116c2f6fee81a0be72a71cc2f1f7c087df8efa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/nvme/host/ioctl.c:690:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (ns)
               ^~
   drivers/nvme/host/ioctl.c:693:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/nvme/host/ioctl.c:690:2: note: remove the 'if' if its condition is always true
           if (ns)
           ^~~~~~~
   drivers/nvme/host/ioctl.c:688:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +690 drivers/nvme/host/ioctl.c

   680	
   681	int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
   682			unsigned int issue_flags)
   683	{
   684		struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
   685		struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
   686		int srcu_idx = srcu_read_lock(&head->srcu);
   687		struct nvme_ns *ns = nvme_find_path(head);
   688		int ret;
   689	
 > 690		if (ns)
   691			ret = nvme_ns_uring_cmd(ns, ioucmd, issue_flags);
   692		srcu_read_unlock(&head->srcu, srcu_idx);
   693		return ret;
   694	}
   695	#endif /* CONFIG_NVME_MULTIPATH */
   696	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

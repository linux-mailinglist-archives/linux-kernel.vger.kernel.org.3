Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8452D4D6AD4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiCKXOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 18:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiCKXOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:14:06 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F016D199
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 15:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647040382; x=1678576382;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JGaHSx3huI9NcVx9BFM/d5oU7KU8dTn8atKVk+lwT4w=;
  b=TaaEU3UDIg0Lu+L3XXZJfApc19MzzdGsZ+07Ro1EJb0ez57VmgvteMYQ
   muU8qEy/G+gaiEZiwh6xwWuIvn8nvzYfMZNA3mdsG+0AF26uy/89CyxBU
   8HcP0p52x+5yPElpwYU6S811PmnA0c8QZzXxVPHqEQoNq2jxx4N9c1oWi
   AlEKshXlP+bfENlwlp/iXWHo2Mw0F912HmbYRXRSapHhjQRuURst+rPKZ
   j02K1EuGKMXMiQiypB5Q7ueTixzV44jBScPydbmDuOnR/B+QRLiJ+5GGq
   5CtgEDDMkIroU4EncuMY8zAQhwGLwftwZL4J42rWqo6Fru91A0bZFK66y
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="318880028"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="318880028"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 13:25:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="539141775"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 11 Mar 2022 13:25:08 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSml1-00077U-NK; Fri, 11 Mar 2022 21:25:07 +0000
Date:   Sat, 12 Mar 2022 05:24:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Anuj Gupta <anuj20.g@samsung.com>
Subject: [mcgrof-next:20220311-io-uring-cmd 16/17] fs/io_uring.c:4215:31:
 warning: cast to pointer from integer of different size
Message-ID: <202203120559.66PKUxNh-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20220311-io-uring-cmd
head:   abe791464a630c1cc3821258e002a0a623dc9b5a
commit: d7b1a5fd9fdbe454f93795f46e040951a4510d2e [16/17] io_uring: add support for non-inline uring-cmd
config: arm-buildonly-randconfig-r006-20220310 (https://download.01.org/0day-ci/archive/20220312/202203120559.66PKUxNh-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=d7b1a5fd9fdbe454f93795f46e040951a4510d2e
        git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
        git fetch --no-tags mcgrof-next 20220311-io-uring-cmd
        git checkout d7b1a5fd9fdbe454f93795f46e040951a4510d2e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/io_uring.c: In function '__io_submit_flush_completions':
   fs/io_uring.c:2562:40: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
    2562 |         struct io_wq_work_node *node, *prev;
         |                                        ^~~~
   fs/io_uring.c: In function 'io_uring_cmd_prep':
>> fs/io_uring.c:4215:31: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    4215 |                 ioucmd->cmd = (void *) sqe->cmd;
         |                               ^


vim +4215 fs/io_uring.c

  4186	
  4187	static int io_uring_cmd_prep(struct io_kiocb *req,
  4188				     const struct io_uring_sqe *sqe)
  4189	{
  4190		struct io_ring_ctx *ctx = req->ctx;
  4191		struct io_uring_cmd *ioucmd = &req->uring_cmd;
  4192		u32 ucmd_flags = READ_ONCE(sqe->uring_cmd_flags);
  4193	
  4194		if (!req->file->f_op->async_cmd)
  4195			return -EOPNOTSUPP;
  4196		if (!(req->ctx->flags & IORING_SETUP_SQE128) &&
  4197				!(ucmd_flags & IORING_URING_CMD_INDIRECT))
  4198			return -EOPNOTSUPP;
  4199		if (req->ctx->flags & IORING_SETUP_IOPOLL) {
  4200			ioucmd->flags = IO_URING_F_UCMD_POLLED;
  4201			ioucmd->bio = NULL;
  4202			req->iopoll_completed = 0;
  4203		} else {
  4204			ioucmd->flags = 0;
  4205		}
  4206		if (req->opcode == IORING_OP_URING_CMD_FIXED) {
  4207			req->imu = NULL;
  4208			io_req_set_rsrc_node(req, ctx);
  4209			req->buf_index = READ_ONCE(sqe->buf_index);
  4210			ioucmd->flags |= IO_URING_F_UCMD_FIXEDBUFS;
  4211		}
  4212	
  4213		if (ucmd_flags & IORING_URING_CMD_INDIRECT) {
  4214			ioucmd->flags |= IO_URING_F_UCMD_INDIRECT;
> 4215			ioucmd->cmd = (void *) sqe->cmd;
  4216		} else {
  4217			ioucmd->cmd = (void *) &sqe->cmd;
  4218		}
  4219		ioucmd->cmd_op = READ_ONCE(sqe->cmd_op);
  4220		ioucmd->cmd_len = READ_ONCE(sqe->cmd_len);
  4221		return 0;
  4222	}
  4223	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

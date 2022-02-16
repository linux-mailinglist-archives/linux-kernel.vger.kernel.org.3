Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9454F4B8697
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiBPLYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:24:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiBPLYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:24:49 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209462DF6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645010677; x=1676546677;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SrVy68AUkmK2IOLXR54aG87xRVa7oOsYKgUT5PUQKDk=;
  b=bKXulL0pe/w9fd2nhIneBRUFkGl81jLqrHVTzcclh0APiio8ScyKxKuC
   Jh2Cy0UPSJ8ME5lW9ZrwAwTsRnehBWnnP5VUG7tR8ZeIeTi1mfI8nOLFy
   +q4alOXe3M5rw4KmDNBzbQSrp+FgAge80WiJQQblFYZ5IqyNaD0taV+Zr
   XcB7o6kp3TLJHJ9VSSK6+EKIupiUtBEe3OmrGH4v1imVOAMv+WUzBlwaW
   Bs2JW4N0e9dwm64WE8PHV1gEkDxRwcgP5i4Hc6GVtIrCj+6aic+ohnFLK
   ZzuAh7F/h3ApXINUA8VoVyKL7YN35CDNfh1oLWf58+0Y8LKpABt6Gtm5k
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="311322493"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="311322493"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 03:24:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="704267191"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Feb 2022 03:24:35 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKIQE-000Aki-Tg; Wed, 16 Feb 2022 11:24:34 +0000
Date:   Wed, 16 Feb 2022 19:24:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: fs/io_uring.c:5999:2: warning: Redundant assignment of 'req' to
 itself. [selfAssignment]
Message-ID: <202202161925.Sd1RTERz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5d9ae265b105d9a67575fb67bd4650a6fc08e25
commit: a3dbdf54da80326fd12bc11ad75ecd699a82374f io_uring: refactor io_get_sequence()
date:   8 months ago
compiler: powerpc64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
>> kernel/irq/proc.c:357:2: warning: %d in format string (no. 1) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
    sprintf(name, "%d", irq);
    ^
>> fs/io_uring.c:5999:2: warning: Redundant assignment of 'req' to itself. [selfAssignment]
    io_for_each_link(req, req)
    ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> kernel/irq/proc.c:357:2: warning: %d in format string (no. 1) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
    sprintf(name, "%d", irq);
    ^
>> fs/io_uring.c:5305:19: warning: Uninitialized variable: req [uninitvar]
     if (sqe_addr != req->user_data)
                     ^
   fs/io_uring.c:5309:10: warning: Uninitialized variable: req [uninitvar]
     return req;
            ^
   fs/io_uring.c:9491:46: warning: Uninitialized variable: req [uninitvar]
      seq_printf(m, "  op=%d, task_works=%dn", req->opcode,
                                                ^
   fs/io_uring.c:9492:6: warning: Uninitialized variable: req [uninitvar]
        req->task->task_works != NULL);
        ^

vim +/req +5999 fs/io_uring.c

  5993	
  5994	static u32 io_get_sequence(struct io_kiocb *req)
  5995	{
  5996		u32 seq = req->ctx->cached_sq_head;
  5997	
  5998		/* need original cached_sq_head, but it was increased for each req */
> 5999		io_for_each_link(req, req)
  6000			seq--;
  6001		return seq;
  6002	}
  6003	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

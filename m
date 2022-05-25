Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECDD53369A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 07:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244008AbiEYF7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 01:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiEYF7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 01:59:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31BF71A01
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653458386; x=1684994386;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hydelQXy3MiOgGbxpRz3C3wiYSmiZ9+Ky/CXtTr6U6U=;
  b=WK0pSVWz8OXsBx0nXhBVZnUBQhxXq8ubsqgwrIa7tpIssdbGZXegKcPk
   gGrRj0qq+LFuOZagyYDzKudkdTCDtDzV0HiOgbDFSxZSbOP0MyCwmNmiI
   HRl45M5dPrhiwLuGTlgolkjRW3T6xz4qIFaP4nmczkfFbKbobUTyT341C
   fW4bS+leO8oLPcxYKtPdl2CUuhJ4WOoH2dIf3qepJ4h9x15WJsGXAni9g
   zU+odVkKnoIev66N61bIMS2KN6PV31JRfGvvSvb93FEvG8OLMElJLQ22+
   a7m7E4yDko/868zkN0zH3JO3+6kRe8us/jAi66fvgMfsYy8hU5DfVbeoM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273835948"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273835948"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 22:59:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="608982028"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 May 2022 22:59:45 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntk3c-0002mw-9r;
        Wed, 25 May 2022 05:59:44 +0000
Date:   Wed, 25 May 2022 13:59:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/for-5.20/io_uring 36/40]
 io_uring/splice.c:42:5: warning: no previous prototype for 'io_tee_prep'
Message-ID: <202205251321.vRCtW7An-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/for-5.20/io_uring
head:   9da4fba4e0165c5e40d689eb5d34b73d780bf067
commit: 22eadf221928100134978b69655f0cf37466e30a [36/40] io_uring: split out splice related operations
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20220525/202205251321.vRCtW7An-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/22eadf221928100134978b69655f0cf37466e30a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/for-5.20/io_uring
        git checkout 22eadf221928100134978b69655f0cf37466e30a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> io_uring/splice.c:42:5: warning: no previous prototype for 'io_tee_prep' [-Wmissing-prototypes]
      42 | int io_tee_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
         |     ^~~~~~~~~~~
>> io_uring/splice.c:49:5: warning: no previous prototype for 'io_tee' [-Wmissing-prototypes]
      49 | int io_tee(struct io_kiocb *req, unsigned int issue_flags)
         |     ^~~~~~
>> io_uring/splice.c:81:5: warning: no previous prototype for 'io_splice_prep' [-Wmissing-prototypes]
      81 | int io_splice_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
         |     ^~~~~~~~~~~~~~
>> io_uring/splice.c:90:5: warning: no previous prototype for 'io_splice' [-Wmissing-prototypes]
      90 | int io_splice(struct io_kiocb *req, unsigned int issue_flags)
         |     ^~~~~~~~~


vim +/io_tee_prep +42 io_uring/splice.c

    41	
  > 42	int io_tee_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
    43	{
    44		if (READ_ONCE(sqe->splice_off_in) || READ_ONCE(sqe->off))
    45			return -EINVAL;
    46		return __io_splice_prep(req, sqe);
    47	}
    48	
  > 49	int io_tee(struct io_kiocb *req, unsigned int issue_flags)
    50	{
    51		struct io_splice *sp = io_kiocb_to_cmd(req);
    52		struct file *out = sp->file_out;
    53		unsigned int flags = sp->flags & ~SPLICE_F_FD_IN_FIXED;
    54		struct file *in;
    55		long ret = 0;
    56	
    57		if (issue_flags & IO_URING_F_NONBLOCK)
    58			return -EAGAIN;
    59	
    60		if (sp->flags & SPLICE_F_FD_IN_FIXED)
    61			in = io_file_get_fixed(req, sp->splice_fd_in, issue_flags);
    62		else
    63			in = io_file_get_normal(req, sp->splice_fd_in);
    64		if (!in) {
    65			ret = -EBADF;
    66			goto done;
    67		}
    68	
    69		if (sp->len)
    70			ret = do_tee(in, out, sp->len, flags);
    71	
    72		if (!(sp->flags & SPLICE_F_FD_IN_FIXED))
    73			io_put_file(in);
    74	done:
    75		if (ret != sp->len)
    76			req_set_fail(req);
    77		io_req_set_res(req, ret, 0);
    78		return IOU_OK;
    79	}
    80	
  > 81	int io_splice_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
    82	{
    83		struct io_splice *sp = io_kiocb_to_cmd(req);
    84	
    85		sp->off_in = READ_ONCE(sqe->splice_off_in);
    86		sp->off_out = READ_ONCE(sqe->off);
    87		return __io_splice_prep(req, sqe);
    88	}
    89	
  > 90	int io_splice(struct io_kiocb *req, unsigned int issue_flags)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

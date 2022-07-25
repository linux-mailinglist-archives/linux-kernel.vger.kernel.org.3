Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F00457FEDE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbiGYMVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiGYMV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:21:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20F412A97
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658751688; x=1690287688;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sOgNb6vHYNnkVvj2NQGptn1wiqf4hfH5zjG+ujGf3gA=;
  b=Z9ZXdAJAjG9opZtOYwagVQmAAgFFv9zRxUyEFr1Cq2oRx7e9xPeT2eXD
   K4xfaezNCmrQo4ZN+xPi6AHtGBgAY4vwpCMn6iQfjkDPWP+293Y54cvQu
   rKOXjbtrrpEHaJT7hFoFZu76qN7hNpwh7BbHlTW7ystbJqtbqim+VWl0h
   6MiGA+Xs9dtCwXPx5fwd32rP6d7q9cAQg/jIVE7WjAjWZHaNf+PUg1kE6
   sJKA3cMIlbpt8n95CDIr/cqk26pLWLJPIB2k4zpJGPrTrbFhdWhLaV//A
   yjOwObNAkw81QOLw5WlEuaC5rNs6CvHhA3B9F/Wo1nW4OIx7Cy4cHGsCm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="270718583"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="270718583"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 05:21:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="741819685"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jul 2022 05:21:27 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFx5S-00057e-1H;
        Mon, 25 Jul 2022 12:21:26 +0000
Date:   Mon, 25 Jul 2022 20:21:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [isilence:zc_perf_tests 10/10] io_uring/net.c:1094:18: warning:
 variable 'min_ret' set but not used
Message-ID: <202207252009.1dAju6CG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/isilence/linux zc_perf_tests
head:   0909a53e1c81ca9432cbb58d15b87e500595bcbd
commit: 0909a53e1c81ca9432cbb58d15b87e500595bcbd [10/10] io_uring: simple zc
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220725/202207252009.1dAju6CG-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/isilence/linux/commit/0909a53e1c81ca9432cbb58d15b87e500595bcbd
        git remote add isilence https://github.com/isilence/linux
        git fetch --no-tags isilence zc_perf_tests
        git checkout 0909a53e1c81ca9432cbb58d15b87e500595bcbd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   io_uring/net.c: In function 'io_sendzc1':
>> io_uring/net.c:1094:18: warning: variable 'min_ret' set but not used [-Wunused-but-set-variable]
    1094 |         int ret, min_ret = 0;
         |                  ^~~~~~~


vim +/min_ret +1094 io_uring/net.c

  1086	
  1087	int io_sendzc1(struct io_kiocb *req, unsigned int issue_flags)
  1088	{
  1089		struct io_sendzc1 *zc = io_kiocb_to_cmd(req);
  1090		struct msghdr msg;
  1091		struct iovec iov;
  1092		struct socket *sock;
  1093		unsigned msg_flags;
> 1094		int ret, min_ret = 0;
  1095	
  1096		sock = sock_from_file(req->file);
  1097		if (unlikely(!sock))
  1098			return -ENOTSOCK;
  1099	
  1100		msg.msg_name = NULL;
  1101		msg.msg_control = NULL;
  1102		msg.msg_controllen = 0;
  1103		msg.msg_namelen = 0;
  1104	
  1105		if (req->imu) {
  1106			ret = io_import_fixed(WRITE, &msg.msg_iter, req->imu,
  1107					      (u64)(uintptr_t)zc->buf, zc->len);
  1108			if (unlikely(ret))
  1109				return ret;
  1110		} else {
  1111			return -EFAULT;
  1112	
  1113			ret = import_single_range(WRITE, zc->buf, zc->len, &iov,
  1114						  &msg.msg_iter);
  1115			if (unlikely(ret))
  1116				return ret;
  1117			/* TODO: add pinning accounting */
  1118		}
  1119	
  1120		msg_flags = zc->msg_flags | MSG_ZEROCOPY;
  1121		if (issue_flags & IO_URING_F_NONBLOCK)
  1122			msg_flags |= MSG_DONTWAIT;
  1123		if (msg_flags & MSG_WAITALL)
  1124			min_ret = iov_iter_count(&msg.msg_iter);
  1125	
  1126		msg.msg_flags = msg_flags;
  1127		msg.msg_ubuf = &zc->ubuf;
  1128		msg.sg_from_iter = io_sg_from_iter;
  1129		ret = sock_sendmsg(sock, &msg);
  1130	
  1131		req->cqe.res = ret;
  1132		if (refcount_dec_and_test(&zc->ubuf.refcnt)) {
  1133			io_req_set_res(req, req->cqe.res, 0);
  1134			return IOU_OK;
  1135		}
  1136		return IOU_ISSUE_SKIP_COMPLETE;
  1137	}
  1138	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

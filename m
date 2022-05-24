Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C131533286
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 22:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241577AbiEXUl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 16:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiEXUlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:41:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A652E48305
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653424882; x=1684960882;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0/lOWEuchQd/63mT8vuT8FTuqEWKOUN6nPxIsnP3A90=;
  b=eHEr/eQsXCq9OdbtkLhh0ODAGQXv0yUHuTNbZWMWbvC0D7IYfEEBOu0+
   w2pziiA8mS8WHRGWr2cRHc5R3MPK6w79eGbzr0JCmgiFhRK3eAzRdlnUv
   Ha9TDmbMflg3JPtC150Wnx0Vs0DKg/MRuEDeXSNOUyXOvJUDvpuvCYZMp
   qklRCksm3zaDTeFyG25/BvkhxSmXd7sh/GJ+XJXyxZ5A6ZhKFALoEIx/8
   U0EuTD72lQUHXIxWtMvjir1EbVdhCSDgcgoPhMSvG2y2CPFjxIMD4ELmt
   dB7kosqgV4auBkE8Ad7nfZm9MVB9hEumr2KWpikXLshFAVc5zJZQDaclN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="334290591"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="334290591"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 13:41:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="608833469"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 May 2022 13:41:10 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntbL3-0002QG-F7;
        Tue, 24 May 2022 20:41:09 +0000
Date:   Wed, 25 May 2022 04:40:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [axboe-block:io_uring-5.19 6/6] fs/io_uring.c:8094:10: error: call
 to undeclared function 'io_shutdown_prep'; ISO C99 and later do not support
 implicit function declarations
Message-ID: <202205250418.aPKjt5h3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git io_uring-5.19
head:   7bab837b2b5435e37dfef64a1bff983855f24567
commit: 7bab837b2b5435e37dfef64a1bff983855f24567 [6/6] io_uring: move shutdown under the general net section
config: hexagon-randconfig-r045-20220524 (https://download.01.org/0day-ci/archive/20220525/202205250418.aPKjt5h3-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 10c9ecce9f6096e18222a331c5e7d085bd813f75)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=7bab837b2b5435e37dfef64a1bff983855f24567
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch --no-tags axboe-block io_uring-5.19
        git checkout 7bab837b2b5435e37dfef64a1bff983855f24567
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/io_uring.c:8094:10: error: call to undeclared function 'io_shutdown_prep'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   return io_shutdown_prep(req, sqe);
                          ^
   fs/io_uring.c:8094:10: note: did you mean 'io_shutdown'?
   fs/io_uring.c:6774:1: note: 'io_shutdown' declared here
   IO_NETOP_FN(shutdown);
   ^
   fs/io_uring.c:6748:12: note: expanded from macro 'IO_NETOP_FN'
   static int io_##op(struct io_kiocb *req, unsigned int issue_flags)      \
              ^
   <scratch space>:201:1: note: expanded from here
   io_shutdown
   ^
   1 error generated.


vim +/io_shutdown_prep +8094 fs/io_uring.c

5262f567987d3c3 Jens Axboe      2019-09-17  8028  
bfe76559833d5d7 Pavel Begunkov  2020-09-30  8029  static int io_req_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
f67676d160c6ee2 Jens Axboe      2019-12-02  8030  {
d625c6ee4975000 Jens Axboe      2019-12-17  8031  	switch (req->opcode) {
e781573e2fb1b75 Jens Axboe      2019-12-17  8032  	case IORING_OP_NOP:
2bb04df7c2af9da Stefan Roesch   2022-04-26  8033  		return io_nop_prep(req, sqe);
f67676d160c6ee2 Jens Axboe      2019-12-02  8034  	case IORING_OP_READV:
f67676d160c6ee2 Jens Axboe      2019-12-02  8035  	case IORING_OP_READ_FIXED:
3a6820f2bb8a079 Jens Axboe      2019-12-22  8036  	case IORING_OP_READ:
f67676d160c6ee2 Jens Axboe      2019-12-02  8037  	case IORING_OP_WRITEV:
f67676d160c6ee2 Jens Axboe      2019-12-02  8038  	case IORING_OP_WRITE_FIXED:
3a6820f2bb8a079 Jens Axboe      2019-12-22  8039  	case IORING_OP_WRITE:
584b0180f0f4d67 Jens Axboe      2022-03-29  8040  		return io_prep_rw(req, sqe);
0969e783e3a8913 Jens Axboe      2019-12-17  8041  	case IORING_OP_POLL_ADD:
bfe76559833d5d7 Pavel Begunkov  2020-09-30  8042  		return io_poll_add_prep(req, sqe);
0969e783e3a8913 Jens Axboe      2019-12-17  8043  	case IORING_OP_POLL_REMOVE:
c62b646db817106 Jens Axboe      2022-05-23  8044  		return io_poll_remove_prep(req, sqe);
8ed8d3c3bc32bf5 Jens Axboe      2019-12-16  8045  	case IORING_OP_FSYNC:
1155c76a248364d Pavel Begunkov  2021-02-18  8046  		return io_fsync_prep(req, sqe);
8ed8d3c3bc32bf5 Jens Axboe      2019-12-16  8047  	case IORING_OP_SYNC_FILE_RANGE:
1155c76a248364d Pavel Begunkov  2021-02-18  8048  		return io_sfr_prep(req, sqe);
03b1230ca12a12e Jens Axboe      2019-12-02  8049  	case IORING_OP_SENDMSG:
fddafacee287b31 Jens Axboe      2020-01-04  8050  	case IORING_OP_SEND:
bfe76559833d5d7 Pavel Begunkov  2020-09-30  8051  		return io_sendmsg_prep(req, sqe);
03b1230ca12a12e Jens Axboe      2019-12-02  8052  	case IORING_OP_RECVMSG:
fddafacee287b31 Jens Axboe      2020-01-04  8053  	case IORING_OP_RECV:
bfe76559833d5d7 Pavel Begunkov  2020-09-30  8054  		return io_recvmsg_prep(req, sqe);
f499a021ea8c9f7 Jens Axboe      2019-12-02  8055  	case IORING_OP_CONNECT:
bfe76559833d5d7 Pavel Begunkov  2020-09-30  8056  		return io_connect_prep(req, sqe);
2d28390aff87923 Jens Axboe      2019-12-04  8057  	case IORING_OP_TIMEOUT:
a0dd627730ba9c1 Jens Axboe      2022-05-23  8058  		return io_timeout_prep(req, sqe);
b29472ee7b53784 Jens Axboe      2019-12-17  8059  	case IORING_OP_TIMEOUT_REMOVE:
bfe76559833d5d7 Pavel Begunkov  2020-09-30  8060  		return io_timeout_remove_prep(req, sqe);
fbf23849b1724d3 Jens Axboe      2019-12-17  8061  	case IORING_OP_ASYNC_CANCEL:
bfe76559833d5d7 Pavel Begunkov  2020-09-30  8062  		return io_async_cancel_prep(req, sqe);
2d28390aff87923 Jens Axboe      2019-12-04  8063  	case IORING_OP_LINK_TIMEOUT:
a0dd627730ba9c1 Jens Axboe      2022-05-23  8064  		return io_link_timeout_prep(req, sqe);
8ed8d3c3bc32bf5 Jens Axboe      2019-12-16  8065  	case IORING_OP_ACCEPT:
bfe76559833d5d7 Pavel Begunkov  2020-09-30  8066  		return io_accept_prep(req, sqe);
d63d1b5edb7b832 Jens Axboe      2019-12-10  8067  	case IORING_OP_FALLOCATE:
bfe76559833d5d7 Pavel Begunkov  2020-09-30  8068  		return io_fallocate_prep(req, sqe);
15b71abe7b52df2 Jens Axboe      2019-12-11  8069  	case IORING_OP_OPENAT:
bfe76559833d5d7 Pavel Begunkov  2020-09-30  8070  		return io_openat_prep(req, sqe);
b5dba59e0cf7e2c Jens Axboe      2019-12-11  8071  	case IORING_OP_CLOSE:
bfe76559833d5d7 Pavel Begunkov  2020-09-30  8072  		return io_close_prep(req, sqe);
05f3fb3c5397524 Jens Axboe      2019-12-09  8073  	case IORING_OP_FILES_UPDATE:
c62b646db817106 Jens Axboe      2022-05-23  8074  		return io_files_update_prep(req, sqe);
eddc7ef52a6b37b Jens Axboe      2019-12-13  8075  	case IORING_OP_STATX:
bfe76559833d5d7 Pavel Begunkov  2020-09-30  8076  		return io_statx_prep(req, sqe);
4840e418c2fc533 Jens Axboe      2019-12-25  8077  	case IORING_OP_FADVISE:
bfe76559833d5d7 Pavel Begunkov  2020-09-30  8078  		return io_fadvise_prep(req, sqe);
c1ca757bd6f4632 Jens Axboe      2019-12-25  8079  	case IORING_OP_MADVISE:
bfe76559833d5d7 Pavel Begunkov  2020-09-30  8080  		return io_madvise_prep(req, sqe);
cebdb98617ae3e8 Jens Axboe      2020-01-08  8081  	case IORING_OP_OPENAT2:
bfe76559833d5d7 Pavel Begunkov  2020-09-30  8082  		return io_openat2_prep(req, sqe);
3e4827b05d2ac2d Jens Axboe      2020-01-08  8083  	case IORING_OP_EPOLL_CTL:
bfe76559833d5d7 Pavel Begunkov  2020-09-30  8084  		return io_epoll_ctl_prep(req, sqe);
7d67af2c0134025 Pavel Begunkov  2020-02-24  8085  	case IORING_OP_SPLICE:
bfe76559833d5d7 Pavel Begunkov  2020-09-30  8086  		return io_splice_prep(req, sqe);
ddf0322db79c598 Jens Axboe      2020-02-23  8087  	case IORING_OP_PROVIDE_BUFFERS:
bfe76559833d5d7 Pavel Begunkov  2020-09-30  8088  		return io_provide_buffers_prep(req, sqe);
067524e914cb23e Jens Axboe      2020-03-02  8089  	case IORING_OP_REMOVE_BUFFERS:
bfe76559833d5d7 Pavel Begunkov  2020-09-30  8090  		return io_remove_buffers_prep(req, sqe);
f2a8d5c7a218b9c Pavel Begunkov  2020-05-17  8091  	case IORING_OP_TEE:
bfe76559833d5d7 Pavel Begunkov  2020-09-30  8092  		return io_tee_prep(req, sqe);
36f4fa6886a8126 Jens Axboe      2020-09-05  8093  	case IORING_OP_SHUTDOWN:
36f4fa6886a8126 Jens Axboe      2020-09-05 @8094  		return io_shutdown_prep(req, sqe);
80a261fd0032789 Jens Axboe      2020-09-28  8095  	case IORING_OP_RENAMEAT:
80a261fd0032789 Jens Axboe      2020-09-28  8096  		return io_renameat_prep(req, sqe);
14a1143b68ee2e4 Jens Axboe      2020-09-28  8097  	case IORING_OP_UNLINKAT:
14a1143b68ee2e4 Jens Axboe      2020-09-28  8098  		return io_unlinkat_prep(req, sqe);
e34a02dc40c95d1 Dmitry Kadashev 2021-07-08  8099  	case IORING_OP_MKDIRAT:
e34a02dc40c95d1 Dmitry Kadashev 2021-07-08  8100  		return io_mkdirat_prep(req, sqe);
7a8721f84fcb3b2 Dmitry Kadashev 2021-07-08  8101  	case IORING_OP_SYMLINKAT:
7a8721f84fcb3b2 Dmitry Kadashev 2021-07-08  8102  		return io_symlinkat_prep(req, sqe);
cf30da90bc3a269 Dmitry Kadashev 2021-07-08  8103  	case IORING_OP_LINKAT:
cf30da90bc3a269 Dmitry Kadashev 2021-07-08  8104  		return io_linkat_prep(req, sqe);
4f57f06ce2186c3 Jens Axboe      2022-03-10  8105  	case IORING_OP_MSG_RING:
4f57f06ce2186c3 Jens Axboe      2022-03-10  8106  		return io_msg_ring_prep(req, sqe);
e9621e2bec80fe6 Stefan Roesch   2022-03-23  8107  	case IORING_OP_FSETXATTR:
e9621e2bec80fe6 Stefan Roesch   2022-03-23  8108  		return io_fsetxattr_prep(req, sqe);
e9621e2bec80fe6 Stefan Roesch   2022-03-23  8109  	case IORING_OP_SETXATTR:
e9621e2bec80fe6 Stefan Roesch   2022-03-23  8110  		return io_setxattr_prep(req, sqe);
a56834e0fafe0ad Stefan Roesch   2022-03-23  8111  	case IORING_OP_FGETXATTR:
a56834e0fafe0ad Stefan Roesch   2022-03-23  8112  		return io_fgetxattr_prep(req, sqe);
a56834e0fafe0ad Stefan Roesch   2022-03-23  8113  	case IORING_OP_GETXATTR:
a56834e0fafe0ad Stefan Roesch   2022-03-23  8114  		return io_getxattr_prep(req, sqe);
1374e08e2d44863 Jens Axboe      2022-04-12  8115  	case IORING_OP_SOCKET:
1374e08e2d44863 Jens Axboe      2022-04-12  8116  		return io_socket_prep(req, sqe);
ee692a21e9bf835 Jens Axboe      2022-05-11  8117  	case IORING_OP_URING_CMD:
ee692a21e9bf835 Jens Axboe      2022-05-11  8118  		return io_uring_cmd_prep(req, sqe);
bfe76559833d5d7 Pavel Begunkov  2020-09-30  8119  	}
bfe76559833d5d7 Pavel Begunkov  2020-09-30  8120  
e781573e2fb1b75 Jens Axboe      2019-12-17  8121  	printk_once(KERN_WARNING "io_uring: unhandled opcode %d\n",
e781573e2fb1b75 Jens Axboe      2019-12-17  8122  			req->opcode);
bfe76559833d5d7 Pavel Begunkov  2020-09-30  8123  	return -EINVAL;
f67676d160c6ee2 Jens Axboe      2019-12-02  8124  }
f67676d160c6ee2 Jens Axboe      2019-12-02  8125  

:::::: The code at line 8094 was first introduced by commit
:::::: 36f4fa6886a81266d7c82b1c90a65205e73a7c85 io_uring: add support for shutdown(2)

:::::: TO: Jens Axboe <axboe@kernel.dk>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

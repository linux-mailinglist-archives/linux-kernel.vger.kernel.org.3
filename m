Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A6D53435D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343854AbiEYSv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239788AbiEYSvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:51:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D14DAF1D6
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653504668; x=1685040668;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Pvb36TZyOqIvImWTJ3SLE+Be1j3L6EIeI9MkIEEc0Iw=;
  b=VkmycA/qVjMN3MwkgXOASaCyx3wJwFGNDBISm8d3gCAuQk5NKUsddYEM
   4tjKIeWUIuv3/qie8WKfnz8EcnmMCAgY+tfwDTjRH5XUcVemKb75W5cS6
   c3XBg4fXXmWVERy6FXZl7Rs8w6MShES3b7V6rmSLsi/fs/+WpO8X4V1xV
   +mnqf0lghpPowatAvwMJkyZ2XusZoLGLGxWy6uqLbj4WpsiMzpTe/bQ5V
   JQ/4K9VPBNXdZgxzugBXvPGvO0Htjk67JJcZDXy6lcsDOk3gjnm+tnhVx
   ciwEWZ3l3eBzKw60fLTKwVCHQU38rHlOIjbCkrO2sKZfp4cmPrU7N4QLs
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="299243137"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="299243137"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 11:51:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="901611808"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 25 May 2022 11:51:05 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntw65-0003F8-0E;
        Wed, 25 May 2022 18:51:05 +0000
Date:   Thu, 26 May 2022 02:50:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/for-5.20/io_uring 28/53]
 io_uring/io_uring.c:12888:43: error: 'io_sendmsg_recvmsg_cleanup' undeclared
 here (not in a function)
Message-ID: <202205260248.7TmgUebo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/for-5.20/io_uring
head:   84f1dd6310da01fcc5bdc6b1f31d4bcfeea958d2
commit: 2f5dbd1b2ea6935f2a36342a26cda8e427ee9f4d [28/53] io_uring: define a request type cleanup handler
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20220526/202205260248.7TmgUebo-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/2f5dbd1b2ea6935f2a36342a26cda8e427ee9f4d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/for-5.20/io_uring
        git checkout 2f5dbd1b2ea6935f2a36342a26cda8e427ee9f4d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: the ammarfaizi2-block/axboe/linux-block/for-5.20/io_uring HEAD 84f1dd6310da01fcc5bdc6b1f31d4bcfeea958d2 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   io_uring/io_uring.c: In function '__io_submit_flush_completions':
   io_uring/io_uring.c:2923:40: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
    2923 |         struct io_wq_work_node *node, *prev;
         |                                        ^~~~
   io_uring/io_uring.c: At top level:
>> io_uring/io_uring.c:12888:43: error: 'io_sendmsg_recvmsg_cleanup' undeclared here (not in a function)
   12888 |                 .cleanup                = io_sendmsg_recvmsg_cleanup,
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/io_sendmsg_recvmsg_cleanup +12888 io_uring/io_uring.c

 12792	
 12793	static const struct io_op_def io_op_defs[] = {
 12794		[IORING_OP_NOP] = {
 12795			.audit_skip		= 1,
 12796			.iopoll			= 1,
 12797			.buffer_select		= 1,
 12798			.prep			= io_nop_prep,
 12799			.issue			= io_nop,
 12800		},
 12801		[IORING_OP_READV] = {
 12802			.needs_file		= 1,
 12803			.unbound_nonreg_file	= 1,
 12804			.pollin			= 1,
 12805			.buffer_select		= 1,
 12806			.plug			= 1,
 12807			.audit_skip		= 1,
 12808			.ioprio			= 1,
 12809			.iopoll			= 1,
 12810			.async_size		= sizeof(struct io_async_rw),
 12811			.prep			= io_prep_rw,
 12812			.issue			= io_read,
 12813			.prep_async		= io_readv_prep_async,
 12814			.cleanup		= io_readv_writev_cleanup,
 12815		},
 12816		[IORING_OP_WRITEV] = {
 12817			.needs_file		= 1,
 12818			.hash_reg_file		= 1,
 12819			.unbound_nonreg_file	= 1,
 12820			.pollout		= 1,
 12821			.plug			= 1,
 12822			.audit_skip		= 1,
 12823			.ioprio			= 1,
 12824			.iopoll			= 1,
 12825			.async_size		= sizeof(struct io_async_rw),
 12826			.prep			= io_prep_rw,
 12827			.issue			= io_write,
 12828			.prep_async		= io_writev_prep_async,
 12829			.cleanup		= io_readv_writev_cleanup,
 12830		},
 12831		[IORING_OP_FSYNC] = {
 12832			.needs_file		= 1,
 12833			.audit_skip		= 1,
 12834			.prep			= io_fsync_prep,
 12835			.issue			= io_fsync,
 12836		},
 12837		[IORING_OP_READ_FIXED] = {
 12838			.needs_file		= 1,
 12839			.unbound_nonreg_file	= 1,
 12840			.pollin			= 1,
 12841			.plug			= 1,
 12842			.audit_skip		= 1,
 12843			.ioprio			= 1,
 12844			.iopoll			= 1,
 12845			.async_size		= sizeof(struct io_async_rw),
 12846			.prep			= io_prep_rw,
 12847			.issue			= io_read,
 12848		},
 12849		[IORING_OP_WRITE_FIXED] = {
 12850			.needs_file		= 1,
 12851			.hash_reg_file		= 1,
 12852			.unbound_nonreg_file	= 1,
 12853			.pollout		= 1,
 12854			.plug			= 1,
 12855			.audit_skip		= 1,
 12856			.ioprio			= 1,
 12857			.iopoll			= 1,
 12858			.async_size		= sizeof(struct io_async_rw),
 12859			.prep			= io_prep_rw,
 12860			.issue			= io_write,
 12861		},
 12862		[IORING_OP_POLL_ADD] = {
 12863			.needs_file		= 1,
 12864			.unbound_nonreg_file	= 1,
 12865			.audit_skip		= 1,
 12866			.prep			= io_poll_add_prep,
 12867			.issue			= io_poll_add,
 12868		},
 12869		[IORING_OP_POLL_REMOVE] = {
 12870			.audit_skip		= 1,
 12871			.prep			= io_poll_remove_prep,
 12872			.issue			= io_poll_remove,
 12873		},
 12874		[IORING_OP_SYNC_FILE_RANGE] = {
 12875			.needs_file		= 1,
 12876			.audit_skip		= 1,
 12877			.prep			= io_sfr_prep,
 12878			.issue			= io_sync_file_range,
 12879		},
 12880		[IORING_OP_SENDMSG] = {
 12881			.needs_file		= 1,
 12882			.unbound_nonreg_file	= 1,
 12883			.pollout		= 1,
 12884			.async_size		= sizeof(struct io_async_msghdr),
 12885			.prep			= io_sendmsg_prep,
 12886			.issue			= io_sendmsg,
 12887			.prep_async		= io_sendmsg_prep_async,
 12888			.cleanup		= io_sendmsg_recvmsg_cleanup,
 12889		},
 12890		[IORING_OP_RECVMSG] = {
 12891			.needs_file		= 1,
 12892			.unbound_nonreg_file	= 1,
 12893			.pollin			= 1,
 12894			.buffer_select		= 1,
 12895			.async_size		= sizeof(struct io_async_msghdr),
 12896			.prep			= io_recvmsg_prep,
 12897			.issue			= io_recvmsg,
 12898			.prep_async		= io_recvmsg_prep_async,
 12899			.cleanup		= io_sendmsg_recvmsg_cleanup,
 12900		},
 12901		[IORING_OP_TIMEOUT] = {
 12902			.audit_skip		= 1,
 12903			.async_size		= sizeof(struct io_timeout_data),
 12904			.prep			= io_timeout_prep,
 12905			.issue			= io_timeout,
 12906		},
 12907		[IORING_OP_TIMEOUT_REMOVE] = {
 12908			/* used by timeout updates' prep() */
 12909			.audit_skip		= 1,
 12910			.prep			= io_timeout_remove_prep,
 12911			.issue			= io_timeout_remove,
 12912		},
 12913		[IORING_OP_ACCEPT] = {
 12914			.needs_file		= 1,
 12915			.unbound_nonreg_file	= 1,
 12916			.pollin			= 1,
 12917			.poll_exclusive		= 1,
 12918			.ioprio			= 1,	/* used for flags */
 12919			.prep			= io_accept_prep,
 12920			.issue			= io_accept,
 12921		},
 12922		[IORING_OP_ASYNC_CANCEL] = {
 12923			.audit_skip		= 1,
 12924			.prep			= io_async_cancel_prep,
 12925			.issue			= io_async_cancel,
 12926		},
 12927		[IORING_OP_LINK_TIMEOUT] = {
 12928			.audit_skip		= 1,
 12929			.async_size		= sizeof(struct io_timeout_data),
 12930			.prep			= io_link_timeout_prep,
 12931			.issue			= io_no_issue,
 12932		},
 12933		[IORING_OP_CONNECT] = {
 12934			.needs_file		= 1,
 12935			.unbound_nonreg_file	= 1,
 12936			.pollout		= 1,
 12937			.async_size		= sizeof(struct io_async_connect),
 12938			.prep			= io_connect_prep,
 12939			.issue			= io_connect,
 12940			.prep_async		= io_connect_prep_async,
 12941		},
 12942		[IORING_OP_FALLOCATE] = {
 12943			.needs_file		= 1,
 12944			.prep			= io_fallocate_prep,
 12945			.issue			= io_fallocate,
 12946		},
 12947		[IORING_OP_OPENAT] = {
 12948			.prep			= io_openat_prep,
 12949			.issue			= io_openat,
 12950			.cleanup		= io_open_cleanup,
 12951		},
 12952		[IORING_OP_CLOSE] = {
 12953			.prep			= io_close_prep,
 12954			.issue			= io_close,
 12955		},
 12956		[IORING_OP_FILES_UPDATE] = {
 12957			.audit_skip		= 1,
 12958			.iopoll			= 1,
 12959			.prep			= io_files_update_prep,
 12960			.issue			= io_files_update,
 12961		},
 12962		[IORING_OP_STATX] = {
 12963			.audit_skip		= 1,
 12964			.prep			= io_statx_prep,
 12965			.issue			= io_statx,
 12966			.cleanup		= io_statx_cleanup,
 12967		},
 12968		[IORING_OP_READ] = {
 12969			.needs_file		= 1,
 12970			.unbound_nonreg_file	= 1,
 12971			.pollin			= 1,
 12972			.buffer_select		= 1,
 12973			.plug			= 1,
 12974			.audit_skip		= 1,
 12975			.ioprio			= 1,
 12976			.iopoll			= 1,
 12977			.async_size		= sizeof(struct io_async_rw),
 12978			.prep			= io_prep_rw,
 12979			.issue			= io_read,
 12980		},
 12981		[IORING_OP_WRITE] = {
 12982			.needs_file		= 1,
 12983			.hash_reg_file		= 1,
 12984			.unbound_nonreg_file	= 1,
 12985			.pollout		= 1,
 12986			.plug			= 1,
 12987			.audit_skip		= 1,
 12988			.ioprio			= 1,
 12989			.iopoll			= 1,
 12990			.async_size		= sizeof(struct io_async_rw),
 12991			.prep			= io_prep_rw,
 12992			.issue			= io_write,
 12993		},
 12994		[IORING_OP_FADVISE] = {
 12995			.needs_file		= 1,
 12996			.audit_skip		= 1,
 12997			.prep			= io_fadvise_prep,
 12998			.issue			= io_fadvise,
 12999		},
 13000		[IORING_OP_MADVISE] = {
 13001			.prep			= io_madvise_prep,
 13002			.issue			= io_madvise,
 13003		},
 13004		[IORING_OP_SEND] = {
 13005			.needs_file		= 1,
 13006			.unbound_nonreg_file	= 1,
 13007			.pollout		= 1,
 13008			.audit_skip		= 1,
 13009			.prep			= io_sendmsg_prep,
 13010			.issue			= io_send,
 13011		},
 13012		[IORING_OP_RECV] = {
 13013			.needs_file		= 1,
 13014			.unbound_nonreg_file	= 1,
 13015			.pollin			= 1,
 13016			.buffer_select		= 1,
 13017			.audit_skip		= 1,
 13018			.prep			= io_recvmsg_prep,
 13019			.issue			= io_recv,
 13020		},
 13021		[IORING_OP_OPENAT2] = {
 13022			.prep			= io_openat2_prep,
 13023			.issue			= io_openat2,
 13024			.cleanup		= io_open_cleanup,
 13025		},
 13026		[IORING_OP_EPOLL_CTL] = {
 13027			.unbound_nonreg_file	= 1,
 13028			.audit_skip		= 1,
 13029			.prep			= io_epoll_ctl_prep,
 13030			.issue			= io_epoll_ctl,
 13031		},
 13032		[IORING_OP_SPLICE] = {
 13033			.needs_file		= 1,
 13034			.hash_reg_file		= 1,
 13035			.unbound_nonreg_file	= 1,
 13036			.audit_skip		= 1,
 13037			.prep			= io_splice_prep,
 13038			.issue			= io_splice,
 13039		},
 13040		[IORING_OP_PROVIDE_BUFFERS] = {
 13041			.audit_skip		= 1,
 13042			.iopoll			= 1,
 13043			.prep			= io_provide_buffers_prep,
 13044			.issue			= io_provide_buffers,
 13045		},
 13046		[IORING_OP_REMOVE_BUFFERS] = {
 13047			.audit_skip		= 1,
 13048			.iopoll			= 1,
 13049			.prep			= io_remove_buffers_prep,
 13050			.issue			= io_remove_buffers,
 13051		},
 13052		[IORING_OP_TEE] = {
 13053			.needs_file		= 1,
 13054			.hash_reg_file		= 1,
 13055			.unbound_nonreg_file	= 1,
 13056			.audit_skip		= 1,
 13057			.prep			= io_tee_prep,
 13058			.issue			= io_tee,
 13059		},
 13060		[IORING_OP_SHUTDOWN] = {
 13061			.needs_file		= 1,
 13062			.prep			= io_shutdown_prep,
 13063			.issue			= io_shutdown,
 13064		},
 13065		[IORING_OP_RENAMEAT] = {
 13066			.prep			= io_renameat_prep,
 13067			.issue			= io_renameat,
 13068			.cleanup		= io_renameat_cleanup,
 13069		},
 13070		[IORING_OP_UNLINKAT] = {
 13071			.prep			= io_unlinkat_prep,
 13072			.issue			= io_unlinkat,
 13073			.cleanup		= io_unlinkat_cleanup,
 13074		},
 13075		[IORING_OP_MKDIRAT] = {
 13076			.prep			= io_mkdirat_prep,
 13077			.issue			= io_mkdirat,
 13078			.cleanup		= io_mkdirat_cleanup,
 13079		},
 13080		[IORING_OP_SYMLINKAT] = {
 13081			.prep			= io_symlinkat_prep,
 13082			.issue			= io_symlinkat,
 13083			.cleanup		= io_link_cleanup,
 13084		},
 13085		[IORING_OP_LINKAT] = {
 13086			.prep			= io_linkat_prep,
 13087			.issue			= io_linkat,
 13088			.cleanup		= io_link_cleanup,
 13089		},
 13090		[IORING_OP_MSG_RING] = {
 13091			.needs_file		= 1,
 13092			.iopoll			= 1,
 13093			.prep			= io_msg_ring_prep,
 13094			.issue			= io_msg_ring,
 13095		},
 13096		[IORING_OP_FSETXATTR] = {
 13097			.needs_file = 1,
 13098			.prep			= io_fsetxattr_prep,
 13099			.issue			= io_fsetxattr,
 13100			.cleanup		= io_xattr_cleanup,
 13101		},
 13102		[IORING_OP_SETXATTR] = {
 13103			.prep			= io_setxattr_prep,
 13104			.issue			= io_setxattr,
 13105			.cleanup		= io_xattr_cleanup,
 13106		},
 13107		[IORING_OP_FGETXATTR] = {
 13108			.needs_file = 1,
 13109			.prep			= io_fgetxattr_prep,
 13110			.issue			= io_fgetxattr,
 13111			.cleanup		= io_xattr_cleanup,
 13112		},
 13113		[IORING_OP_GETXATTR] = {
 13114			.prep			= io_getxattr_prep,
 13115			.issue			= io_getxattr,
 13116			.cleanup		= io_xattr_cleanup,
 13117		},
 13118		[IORING_OP_SOCKET] = {
 13119			.audit_skip		= 1,
 13120			.prep			= io_socket_prep,
 13121			.issue			= io_socket,
 13122		},
 13123		[IORING_OP_URING_CMD] = {
 13124			.needs_file		= 1,
 13125			.plug			= 1,
 13126			.async_size		= uring_cmd_pdu_size(1),
 13127			.prep			= io_uring_cmd_prep,
 13128			.issue			= io_uring_cmd,
 13129			.prep_async		= io_uring_cmd_prep_async,
 13130		},
 13131	};
 13132	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

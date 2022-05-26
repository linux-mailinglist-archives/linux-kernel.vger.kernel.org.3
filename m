Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED5353551B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348853AbiEZUxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345301AbiEZUxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:53:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE16B67D29
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653598388; x=1685134388;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZJ4467pFlEy4QvN5TJxgyQcZxKk0D2ZcG32Zm3FOqDU=;
  b=WOcu4JIrImsbqHiup/9N39otrx3PIkd5S5FjDss69Mlu3p6x9MdbyFWU
   4+We3OSB0u2AcMFLUWeakebWXmtqeImEvUP6ZJIOhxZR1rOqOxM/dG8zH
   t8LK2yq69oRGvcKuhkbJY8jecwMQzjrQn/o5iKi/+wMt6zIfeU/oDj13X
   RUh0+sJsfuFvS54x08/bKA3qiwvHRrlKK+/ruYB2s0n4UE4JYwyFSaMcd
   x1znncqkoBC/Z4ajM48Go903Si6eH4wpRiDybOUV7fBFYd0iAdbBH6W/8
   2Zut25F02C0PYi1PnFquMTZbCDTZ6VU5f+NSVtCMgGWWM74R0GjZia86s
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="273100623"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="273100623"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 13:53:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="527611282"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 May 2022 13:53:06 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuKTi-0004BC-1c;
        Thu, 26 May 2022 20:53:06 +0000
Date:   Fri, 27 May 2022 04:52:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/for-5.20/io_uring 60/60]
 io_uring/io_uring.c:410:43: error: 'io_eopnotsupp_prep' undeclared here (not
 in a function)
Message-ID: <202205270453.2fWO7X1t-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/for-5.20/io_uring
head:   69d8d55bf2af24767a9ee24afdf88f349c4eec2d
commit: 69d8d55bf2af24767a9ee24afdf88f349c4eec2d [60/60] io_uring: move io_op_defs[] back to the top of the file
config: nios2-defconfig (https://download.01.org/0day-ci/archive/20220527/202205270453.2fWO7X1t-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/69d8d55bf2af24767a9ee24afdf88f349c4eec2d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/for-5.20/io_uring
        git checkout 69d8d55bf2af24767a9ee24afdf88f349c4eec2d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> io_uring/io_uring.c:410:43: error: 'io_eopnotsupp_prep' undeclared here (not in a function)
     410 |                 .prep                   = io_eopnotsupp_prep,
         |                                           ^~~~~~~~~~~~~~~~~~
   io_uring/io_uring.c: In function '__io_submit_flush_completions':
   io_uring/io_uring.c:1718:40: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
    1718 |         struct io_wq_work_node *node, *prev;
         |                                        ^~~~


vim +/io_eopnotsupp_prep +410 io_uring/io_uring.c

   115	
   116	const struct io_op_def io_op_defs[] = {
   117		[IORING_OP_NOP] = {
   118			.audit_skip		= 1,
   119			.iopoll			= 1,
   120			.buffer_select		= 1,
   121			.name			= "NOP",
   122			.prep			= io_nop_prep,
   123			.issue			= io_nop,
   124		},
   125		[IORING_OP_READV] = {
   126			.needs_file		= 1,
   127			.unbound_nonreg_file	= 1,
   128			.pollin			= 1,
   129			.buffer_select		= 1,
   130			.plug			= 1,
   131			.audit_skip		= 1,
   132			.ioprio			= 1,
   133			.iopoll			= 1,
   134			.async_size		= sizeof(struct io_async_rw),
   135			.name			= "READV",
   136			.prep			= io_prep_rw,
   137			.issue			= io_read,
   138			.prep_async		= io_readv_prep_async,
   139			.cleanup		= io_readv_writev_cleanup,
   140		},
   141		[IORING_OP_WRITEV] = {
   142			.needs_file		= 1,
   143			.hash_reg_file		= 1,
   144			.unbound_nonreg_file	= 1,
   145			.pollout		= 1,
   146			.plug			= 1,
   147			.audit_skip		= 1,
   148			.ioprio			= 1,
   149			.iopoll			= 1,
   150			.async_size		= sizeof(struct io_async_rw),
   151			.name			= "WRITEV",
   152			.prep			= io_prep_rw,
   153			.issue			= io_write,
   154			.prep_async		= io_writev_prep_async,
   155			.cleanup		= io_readv_writev_cleanup,
   156		},
   157		[IORING_OP_FSYNC] = {
   158			.needs_file		= 1,
   159			.audit_skip		= 1,
   160			.name			= "FSYNC",
   161			.prep			= io_fsync_prep,
   162			.issue			= io_fsync,
   163		},
   164		[IORING_OP_READ_FIXED] = {
   165			.needs_file		= 1,
   166			.unbound_nonreg_file	= 1,
   167			.pollin			= 1,
   168			.plug			= 1,
   169			.audit_skip		= 1,
   170			.ioprio			= 1,
   171			.iopoll			= 1,
   172			.async_size		= sizeof(struct io_async_rw),
   173			.name			= "READ_FIXED",
   174			.prep			= io_prep_rw,
   175			.issue			= io_read,
   176		},
   177		[IORING_OP_WRITE_FIXED] = {
   178			.needs_file		= 1,
   179			.hash_reg_file		= 1,
   180			.unbound_nonreg_file	= 1,
   181			.pollout		= 1,
   182			.plug			= 1,
   183			.audit_skip		= 1,
   184			.ioprio			= 1,
   185			.iopoll			= 1,
   186			.async_size		= sizeof(struct io_async_rw),
   187			.name			= "WRITE_FIXED",
   188			.prep			= io_prep_rw,
   189			.issue			= io_write,
   190		},
   191		[IORING_OP_POLL_ADD] = {
   192			.needs_file		= 1,
   193			.unbound_nonreg_file	= 1,
   194			.audit_skip		= 1,
   195			.name			= "POLL_ADD",
   196			.prep			= io_poll_add_prep,
   197			.issue			= io_poll_add,
   198		},
   199		[IORING_OP_POLL_REMOVE] = {
   200			.audit_skip		= 1,
   201			.name			= "POLL_REMOVE",
   202			.prep			= io_poll_remove_prep,
   203			.issue			= io_poll_remove,
   204		},
   205		[IORING_OP_SYNC_FILE_RANGE] = {
   206			.needs_file		= 1,
   207			.audit_skip		= 1,
   208			.name			= "SYNC_FILE_RANGE",
   209			.prep			= io_sfr_prep,
   210			.issue			= io_sync_file_range,
   211		},
   212		[IORING_OP_SENDMSG] = {
   213			.needs_file		= 1,
   214			.unbound_nonreg_file	= 1,
   215			.pollout		= 1,
   216			.name			= "SENDMSG",
   217	#if defined(CONFIG_NET)
   218			.async_size		= sizeof(struct io_async_msghdr),
   219			.prep			= io_sendmsg_prep,
   220			.issue			= io_sendmsg,
   221			.prep_async		= io_sendmsg_prep_async,
   222			.cleanup		= io_sendmsg_recvmsg_cleanup,
   223	#else
   224			.prep			= io_eopnotsupp_prep,
   225	#endif
   226		},
   227		[IORING_OP_RECVMSG] = {
   228			.needs_file		= 1,
   229			.unbound_nonreg_file	= 1,
   230			.pollin			= 1,
   231			.buffer_select		= 1,
   232			.name			= "RECVMSG",
   233	#if defined(CONFIG_NET)
   234			.async_size		= sizeof(struct io_async_msghdr),
   235			.prep			= io_recvmsg_prep,
   236			.issue			= io_recvmsg,
   237			.prep_async		= io_recvmsg_prep_async,
   238			.cleanup		= io_sendmsg_recvmsg_cleanup,
   239	#else
   240			.prep			= io_eopnotsupp_prep,
   241	#endif
   242		},
   243		[IORING_OP_TIMEOUT] = {
   244			.audit_skip		= 1,
   245			.async_size		= sizeof(struct io_timeout_data),
   246			.name			= "TIMEOUT",
   247			.prep			= io_timeout_prep,
   248			.issue			= io_timeout,
   249		},
   250		[IORING_OP_TIMEOUT_REMOVE] = {
   251			/* used by timeout updates' prep() */
   252			.audit_skip		= 1,
   253			.name			= "TIMEOUT_REMOVE",
   254			.prep			= io_timeout_remove_prep,
   255			.issue			= io_timeout_remove,
   256		},
   257		[IORING_OP_ACCEPT] = {
   258			.needs_file		= 1,
   259			.unbound_nonreg_file	= 1,
   260			.pollin			= 1,
   261			.poll_exclusive		= 1,
   262			.ioprio			= 1,	/* used for flags */
   263			.name			= "ACCEPT",
   264	#if defined(CONFIG_NET)
   265			.prep			= io_accept_prep,
   266			.issue			= io_accept,
   267	#else
   268			.prep			= io_eopnotsupp_prep,
   269	#endif
   270		},
   271		[IORING_OP_ASYNC_CANCEL] = {
   272			.audit_skip		= 1,
   273			.name			= "ASYNC_CANCEL",
   274			.prep			= io_async_cancel_prep,
   275			.issue			= io_async_cancel,
   276		},
   277		[IORING_OP_LINK_TIMEOUT] = {
   278			.audit_skip		= 1,
   279			.async_size		= sizeof(struct io_timeout_data),
   280			.name			= "LINK_TIMEOUT",
   281			.prep			= io_link_timeout_prep,
   282			.issue			= io_no_issue,
   283		},
   284		[IORING_OP_CONNECT] = {
   285			.needs_file		= 1,
   286			.unbound_nonreg_file	= 1,
   287			.pollout		= 1,
   288			.name			= "CONNECT",
   289	#if defined(CONFIG_NET)
   290			.async_size		= sizeof(struct io_async_connect),
   291			.prep			= io_connect_prep,
   292			.issue			= io_connect,
   293			.prep_async		= io_connect_prep_async,
   294	#else
   295			.prep			= io_eopnotsupp_prep,
   296	#endif
   297		},
   298		[IORING_OP_FALLOCATE] = {
   299			.needs_file		= 1,
   300			.name			= "FALLOCATE",
   301			.prep			= io_fallocate_prep,
   302			.issue			= io_fallocate,
   303		},
   304		[IORING_OP_OPENAT] = {
   305			.name			= "OPENAT",
   306			.prep			= io_openat_prep,
   307			.issue			= io_openat,
   308			.cleanup		= io_open_cleanup,
   309		},
   310		[IORING_OP_CLOSE] = {
   311			.name			= "CLOSE",
   312			.prep			= io_close_prep,
   313			.issue			= io_close,
   314		},
   315		[IORING_OP_FILES_UPDATE] = {
   316			.audit_skip		= 1,
   317			.iopoll			= 1,
   318			.name			= "FILES_UPDATE",
   319			.prep			= io_files_update_prep,
   320			.issue			= io_files_update,
   321		},
   322		[IORING_OP_STATX] = {
   323			.audit_skip		= 1,
   324			.name			= "STATX",
   325			.prep			= io_statx_prep,
   326			.issue			= io_statx,
   327			.cleanup		= io_statx_cleanup,
   328		},
   329		[IORING_OP_READ] = {
   330			.needs_file		= 1,
   331			.unbound_nonreg_file	= 1,
   332			.pollin			= 1,
   333			.buffer_select		= 1,
   334			.plug			= 1,
   335			.audit_skip		= 1,
   336			.ioprio			= 1,
   337			.iopoll			= 1,
   338			.async_size		= sizeof(struct io_async_rw),
   339			.name			= "READ",
   340			.prep			= io_prep_rw,
   341			.issue			= io_read,
   342		},
   343		[IORING_OP_WRITE] = {
   344			.needs_file		= 1,
   345			.hash_reg_file		= 1,
   346			.unbound_nonreg_file	= 1,
   347			.pollout		= 1,
   348			.plug			= 1,
   349			.audit_skip		= 1,
   350			.ioprio			= 1,
   351			.iopoll			= 1,
   352			.async_size		= sizeof(struct io_async_rw),
   353			.name			= "WRITE",
   354			.prep			= io_prep_rw,
   355			.issue			= io_write,
   356		},
   357		[IORING_OP_FADVISE] = {
   358			.needs_file		= 1,
   359			.audit_skip		= 1,
   360			.name			= "FADVISE",
   361			.prep			= io_fadvise_prep,
   362			.issue			= io_fadvise,
   363		},
   364		[IORING_OP_MADVISE] = {
   365			.name			= "MADVISE",
   366			.prep			= io_madvise_prep,
   367			.issue			= io_madvise,
   368		},
   369		[IORING_OP_SEND] = {
   370			.needs_file		= 1,
   371			.unbound_nonreg_file	= 1,
   372			.pollout		= 1,
   373			.audit_skip		= 1,
   374			.name			= "SEND",
   375	#if defined(CONFIG_NET)
   376			.prep			= io_sendmsg_prep,
   377			.issue			= io_send,
   378	#else
   379			.prep			= io_eopnotsupp_prep,
   380	#endif
   381		},
   382		[IORING_OP_RECV] = {
   383			.needs_file		= 1,
   384			.unbound_nonreg_file	= 1,
   385			.pollin			= 1,
   386			.buffer_select		= 1,
   387			.audit_skip		= 1,
   388			.name			= "RECV",
   389	#if defined(CONFIG_NET)
   390			.prep			= io_recvmsg_prep,
   391			.issue			= io_recv,
   392	#else
   393			.prep			= io_eopnotsupp_prep,
   394	#endif
   395		},
   396		[IORING_OP_OPENAT2] = {
   397			.name			= "OPENAT2",
   398			.prep			= io_openat2_prep,
   399			.issue			= io_openat2,
   400			.cleanup		= io_open_cleanup,
   401		},
   402		[IORING_OP_EPOLL_CTL] = {
   403			.unbound_nonreg_file	= 1,
   404			.audit_skip		= 1,
   405			.name			= "EPOLL",
   406	#if defined(CONFIG_EPOLL)
   407			.prep			= io_epoll_ctl_prep,
   408			.issue			= io_epoll_ctl,
   409	#else
 > 410			.prep			= io_eopnotsupp_prep,
   411	#endif
   412		},
   413		[IORING_OP_SPLICE] = {
   414			.needs_file		= 1,
   415			.hash_reg_file		= 1,
   416			.unbound_nonreg_file	= 1,
   417			.audit_skip		= 1,
   418			.name			= "SPLICE",
   419			.prep			= io_splice_prep,
   420			.issue			= io_splice,
   421		},
   422		[IORING_OP_PROVIDE_BUFFERS] = {
   423			.audit_skip		= 1,
   424			.iopoll			= 1,
   425			.name			= "PROVIDE_BUFFERS",
   426			.prep			= io_provide_buffers_prep,
   427			.issue			= io_provide_buffers,
   428		},
   429		[IORING_OP_REMOVE_BUFFERS] = {
   430			.audit_skip		= 1,
   431			.iopoll			= 1,
   432			.name			= "REMOVE_BUFFERS",
   433			.prep			= io_remove_buffers_prep,
   434			.issue			= io_remove_buffers,
   435		},
   436		[IORING_OP_TEE] = {
   437			.needs_file		= 1,
   438			.hash_reg_file		= 1,
   439			.unbound_nonreg_file	= 1,
   440			.audit_skip		= 1,
   441			.name			= "TEE",
   442			.prep			= io_tee_prep,
   443			.issue			= io_tee,
   444		},
   445		[IORING_OP_SHUTDOWN] = {
   446			.needs_file		= 1,
   447			.name			= "SHUTDOWN",
   448	#if defined(CONFIG_NET)
   449			.prep			= io_shutdown_prep,
   450			.issue			= io_shutdown,
   451	#else
   452			.prep			= io_eopnotsupp_prep,
   453	#endif
   454		},
   455		[IORING_OP_RENAMEAT] = {
   456			.name			= "RENAMEAT",
   457			.prep			= io_renameat_prep,
   458			.issue			= io_renameat,
   459			.cleanup		= io_renameat_cleanup,
   460		},
   461		[IORING_OP_UNLINKAT] = {
   462			.name			= "UNLINKAT",
   463			.prep			= io_unlinkat_prep,
   464			.issue			= io_unlinkat,
   465			.cleanup		= io_unlinkat_cleanup,
   466		},
   467		[IORING_OP_MKDIRAT] = {
   468			.name			= "MKDIRAT",
   469			.prep			= io_mkdirat_prep,
   470			.issue			= io_mkdirat,
   471			.cleanup		= io_mkdirat_cleanup,
   472		},
   473		[IORING_OP_SYMLINKAT] = {
   474			.name			= "SYMLINKAT",
   475			.prep			= io_symlinkat_prep,
   476			.issue			= io_symlinkat,
   477			.cleanup		= io_link_cleanup,
   478		},
   479		[IORING_OP_LINKAT] = {
   480			.name			= "LINKAT",
   481			.prep			= io_linkat_prep,
   482			.issue			= io_linkat,
   483			.cleanup		= io_link_cleanup,
   484		},
   485		[IORING_OP_MSG_RING] = {
   486			.needs_file		= 1,
   487			.iopoll			= 1,
   488			.name			= "MSG_RING",
   489			.prep			= io_msg_ring_prep,
   490			.issue			= io_msg_ring,
   491		},
   492		[IORING_OP_FSETXATTR] = {
   493			.needs_file = 1,
   494			.name			= "FSETXATTR",
   495			.prep			= io_fsetxattr_prep,
   496			.issue			= io_fsetxattr,
   497			.cleanup		= io_xattr_cleanup,
   498		},
   499		[IORING_OP_SETXATTR] = {
   500			.name			= "SETXATTR",
   501			.prep			= io_setxattr_prep,
   502			.issue			= io_setxattr,
   503			.cleanup		= io_xattr_cleanup,
   504		},
   505		[IORING_OP_FGETXATTR] = {
   506			.needs_file = 1,
   507			.name			= "FGETXATTR",
   508			.prep			= io_fgetxattr_prep,
   509			.issue			= io_fgetxattr,
   510			.cleanup		= io_xattr_cleanup,
   511		},
   512		[IORING_OP_GETXATTR] = {
   513			.name			= "GETXATTR",
   514			.prep			= io_getxattr_prep,
   515			.issue			= io_getxattr,
   516			.cleanup		= io_xattr_cleanup,
   517		},
   518		[IORING_OP_SOCKET] = {
   519			.audit_skip		= 1,
   520			.name			= "SOCKET",
   521	#if defined(CONFIG_NET)
   522			.prep			= io_socket_prep,
   523			.issue			= io_socket,
   524	#else
   525			.prep			= io_eopnotsupp_prep,
   526	#endif
   527		},
   528		[IORING_OP_URING_CMD] = {
   529			.needs_file		= 1,
   530			.plug			= 1,
   531			.name			= "URING_CMD",
   532			.async_size		= uring_cmd_pdu_size(1),
   533			.prep			= io_uring_cmd_prep,
   534			.issue			= io_uring_cmd,
   535			.prep_async		= io_uring_cmd_prep_async,
   536		},
   537	};
   538	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
